import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String username;
  final String? designation;
  final String? pictureUrl;

  const UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.designation,
    required this.pictureUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        designation,
        pictureUrl,
      ];
}
