import 'dart:convert';

import 'package:refresher/models/auth.dart';
import 'package:refresher/utils/network.dart';

abstract class AuthService {
  Future<String> signIn({required SignInDTO signInDTO});
  Future<RefresherUser> getUser();
}

class AuthServiceImpl implements AuthService {
  final _networkUtil = NetworkUtil();

  @override
  Future<String> signIn({required SignInDTO signInDTO}) async {
    try {
      final response = await _networkUtil.postReq(
        '/auth/login',
        body: json.encode(signInDTO.toJson()),
      );

      return response['token'] as String;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RefresherUser> getUser() async {
    try {
      final response = await _networkUtil.getReq(
        '/auth/me',
        queryParameters: <String, dynamic>{
          'include': 'roles.permissions,member.groupMembers.group,student,'
              'member.memberships.spiritualYear',
        },
      );

      return RefresherUser.fromJson(response['data'] as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
