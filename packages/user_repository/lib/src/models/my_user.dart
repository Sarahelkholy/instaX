import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/entities.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;
  String? photo;

  MyUser({
    required this.id,
    required this.email,
    required this.name,
    this.photo,
  });

  static final empty = MyUser(id: '', email: '', name: '', photo: '');

  MyUser copyWith({
    String? id,
    String? email,
    String? name,
    String? photo,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photo: photo ?? this.photo,
    );
  }

  bool get isEmpty => this == MyUser.empty;
  bool get isNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      email: email,
      name: name,
      photo: photo,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        id: entity.id,
        email: entity.email,
        name: entity.name,
        photo: entity.photo);
  }

  @override
  List<Object?> get props => [id, email, name, photo];
}
