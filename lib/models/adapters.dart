import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:refresher/models/auth.dart';

class RefresherUserAdapter extends TypeAdapter<RefresherUser> {
  @override
  final typeId = 0;

  @override
  RefresherUser read(BinaryReader reader) {
    return RefresherUser.fromJson(
      Map<String, dynamic>.of(
        json.decode(reader.read() as String) as Map<String, dynamic>,
      ),
    );
  }

  @override
  void write(BinaryWriter writer, RefresherUser obj) {
    writer.write(json.encode(obj.toJson()));
  }
}

// Here for adapter registration demo completeness
class SignInDTOAdapter extends TypeAdapter<SignInDTO> {
  @override
  final typeId = 1;

  @override
  SignInDTO read(BinaryReader reader) {
    return SignInDTO.fromJson(
      Map<String, dynamic>.of(
        json.decode(reader.read() as String) as Map<String, dynamic>,
      ),
    );
  }

  @override
  void write(BinaryWriter writer, SignInDTO obj) {
    writer.write(json.encode(obj.toJson()));
  }
}
