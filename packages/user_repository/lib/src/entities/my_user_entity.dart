import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? photo;

  const MyUserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.photo,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photo': photo,
    };
  }

  @override
  List<Object?> get props => [id, email, name, photo];

  @override
  String toString() {
    return '''UserEntity:{
    id:$id
    email:$email
    name:$name
    photo:$photo}
''';
  }
}
