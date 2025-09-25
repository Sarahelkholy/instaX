import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/my_user.dart';
import 'entities/entities.dart';
import 'user_repo.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  /// Stream of [MyUser] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [MyUser.empty] if the user is not authenticated.
  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser;
      return user;
    });
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      // Try the normal flow first
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );

      final createdUid = userCredential.user!.uid;
      myUser = myUser.copyWith(id: createdUid);

      // Write Firestore user doc and await it
      await usersCollection
          .doc(createdUid)
          .set(myUser.toEntity().toDocument(), SetOptions(merge: true));

      return myUser;
    } catch (e, st) {
      log('signUp error: $e\n$st');

      try {
        final current = _firebaseAuth.currentUser;
        if (current != null) {
          final recoveredUid = current.uid;
          myUser = myUser.copyWith(id: recoveredUid);

          await usersCollection
              .doc(recoveredUid)
              .set(myUser.toEntity().toDocument(), SetOptions(merge: true));

          log('signUp: recovered after decode error and created Firestore doc for uid=$recoveredUid');
          return myUser;
        }
      } catch (recoveryError, recoverySt) {
        log('signUp recovery error: $recoveryError\n$recoverySt');
      }

      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser user) async {
    try {
      await usersCollection.doc(user.id).set(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> getUserData(String myUserId) async {
    try {
      return usersCollection.doc(myUserId).get().then((value) =>
          MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!)));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
