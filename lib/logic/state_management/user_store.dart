import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'state_keeper.dart';

class UserStore extends StateKeeper {
  double lat = 19.0760;

  double long = 72.8777;

  UserStore._();

  static final UserStore _instance = UserStore._();

  factory UserStore() => _instance;

  var tokenData;
  var Access;
  var Refresh;

  // var lat;
  // var long;

  Future refreshTheToken() async {
    print(
        '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Refresh Ke Andar @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('access') != null) {
      print(prefs.getString('refresh'));
      var response = await http.post(
        Uri.parse("https://innovative-minds.mustansirg.in/api/auth/token/refresh/"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "refresh": prefs.getString('refresh'),
        }),
      );
      var data = jsonDecode(response.body);
      print("Refresh Response: $data");
      await prefs.setString('access', data['access']);
      Access = data['access'];
      Refresh = data['refresh'];

      print(data);
      tokenData = JwtDecoder.decode(data['access']);
      print("Decoded After Refresh: $tokenData");
      print("------------------------------" + tokenData['profile_photo']);
      notifyListeners();
    }
  }

  Future login({
    required String email,
    required String password,
  }) async {
    print('Inside Login');
    final prefs = await SharedPreferences.getInstance();
    // Register
    var response = await http.post(
      Uri.parse("https://innovative-minds.mustansirg.in/api/auth/login/"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      await prefs.setString('access', data['access']);
      await prefs.setString('refresh', data['refresh']);
      Access = data['access'];
      Refresh = data['refresh'];

      print('It is saved');

      // final APIToken = prefs.getString('APIToken');
      tokenData = JwtDecoder.decode(Access.toString());
      print(tokenData);
      notifyListeners();
      return true;
    } else {
      print("Failed to Login");
      print(response.body);
      return false;
    }
  }

  Future register({
    required String username,
    required String email,
    required String password1,
    required String password2,
    File? profilePhoto,
    File? resume,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    // Register

    var request = http.MultipartRequest(
    'POST',
    Uri.parse(
        'https://innovative-minds.mustansirg.in/api/auth/registration/'));
    if (profilePhoto != null) {
      request.files.add(
          await http.MultipartFile.fromPath(
              'profile_photo', profilePhoto.path));
    }
    if (resume != null) {
      request.files.add(
          await http.MultipartFile.fromPath(
              'resume', resume.path));
    }
    request.fields.addAll(
    {
      'email': email,
      'password1': password1,
      'password2': password2,
      'username': username,
    });

    var response = await request.send();
    
    await http.Response.fromStream(response).then((value) async {
      var body = jsonDecode(value.body);
      if (response.statusCode == 201) {
        var data = jsonDecode(body);
        print(data);
        await prefs.setString('access', data['access_token']);
        await prefs.setString('refresh', data['refresh_token']);
        Access = data['access'];
        Refresh = data['refresh'];
        refreshTheToken();
        return true;
      } else {
        print("Failed to Register");
        print(body);
        return false;
      }
    });

  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    tokenData = null;
    notifyListeners();
  }
}
