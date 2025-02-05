import 'package:freezed_annotation/freezed_annotation.dart';

// Generated model files
part 'auth.g.dart'; // Needed for toJson, fromJson
part 'auth.freezed.dart';

@freezed
class SignInDTO with _$SignInDTO {
  factory SignInDTO({
    required String email,
    required String password,
  }) = _SignInDTO;

  factory SignInDTO.fromJson(Map<String, dynamic> json) =>
      _$SignInDTOFromJson(json);
}

@freezed
class RefresherUser with _$RefresherUser {
  factory RefresherUser({
    required String ulid,
    required String name,
    required String email,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _RefresherUser;

  factory RefresherUser.fromJson(Map<String, dynamic> json) =>
      _$RefresherUserFromJson(json);
}
