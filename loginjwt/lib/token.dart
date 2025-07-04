import 'package:flutter/material.dart';

class Token extends ChangeNotifier{
  String? _accessToken=null;
  String? _refreshToken=null;

  String get accessToken => _accessToken!;

  String get refreshToken => _refreshToken!;

  set refreshToken(String value) {
    _refreshToken = value;
  }

  set accessToken(String value) {
    _accessToken = value;
  }
}