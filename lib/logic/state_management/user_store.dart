import 'dart:convert';
import 'dart:ffi';
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
        Uri.parse(
            "https://innovative-minds.mustansirg.in/api/auth/token/refresh/"),
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
    required double lat,
    required double lon,
    String? domainPreference,
    String? experience,
    String? keySkills,
    String? address,
    String? preferredDepartment,
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
      request.files.add(await http.MultipartFile.fromPath(
          'profile_photo', profilePhoto.path));
    }
    if (resume != null) {
      request.files
          .add(await http.MultipartFile.fromPath('resume', resume.path));
    }
    request.fields.addAll({
      'email': email,
      'password1': password1,
      'password2': password2,
      'username': username,
      'lat': lat.toString(),
      'lon': lon.toString(),

    });

    if (domainPreference!= null) {
      request.fields.addAll({'domainpreference': domainPreference});
    }
    if (experience!= null) {
      request.fields.addAll({'experience': experience});
    }
    if (address!= null) {
      request.fields.addAll({'address': address});
    }
    if (keySkills != null) {
      request.fields.addAll({'keyskills': keySkills});
    }
    if (preferredDepartment != null) {
      request.fields.addAll({'preferredDepartment': preferredDepartment});
    }

    var response = await request.send();

    await http.Response.fromStream(response).then((value) async {
      var body = jsonDecode(value.body);
      if (response.statusCode == 201) {
        print(body);
        await prefs.setString('access', body['access_token']);
        await prefs.setString('refresh', body['refresh_token']);
        Access = body['access'];
        Refresh = body['refresh'];
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

  Future createCompany({
    required String name,
    required File? logo,
    required File? headquarters,
    required String establishedYear,
    required String size,
    required int revenue,
    required String missionStatement,
    required String domain,
    required String whatWeDo,
    required String website,
    required String instagram,
    required String facebook,
    required String twitter,
    required String address,
    required String linkedin,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest('POST',
        Uri.parse('https://innovative-minds.mustansirg.in/api/companies/'));
    request.headers
        .addAll({'Authorization': 'Bearer ${prefs.getString('access')}'});
    request.files.add(
        await http.MultipartFile.fromPath('headquarters', headquarters!.path));
    request.files.add(await http.MultipartFile.fromPath('logo', logo!.path));
    request.fields.addAll({
      'name': name,
      'established_year': establishedYear,
      'size': size,
      'revenue': revenue.toString(),
      'mission_statement': missionStatement,
      'what_we_do': whatWeDo,
      'website': website,
      'instagram': instagram,
      'address': address,
      'facebook': facebook,
      'domain': domain,
      'twitter': twitter,
      'linkedin': linkedin,
    });

    var response = await request.send();

    await http.Response.fromStream(response).then((value) async {
      var body = jsonDecode(value.body);
      if (response.statusCode == 201) {
        print(body);
        return true;
      } else {
        print("Failed to create company");
        print(body);
        return false;
      }
    });
  }

  Future getAllCompany() async {
    final prefs = await SharedPreferences.getInstance();
    var response = await http.delete(
        Uri.parse('https://innovative-minds.mustansirg.in/api/companies/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${prefs.getString('access')}",
        });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      print("Failed to get all companies");
      print(response.body);
      return false;
    }
  }

  Future editCompany({
    required int id,
    required String name,
    required File? logo,
    required File? headquarters,
    required String establishedYear,
    required String address,
    required String size,
    required int revenue,
    required String missionStatement,
    required String domain,
    required String whatWeDo,
    required String website,
    required String instagram,
    required String facebook,
    required String twitter,
    required String linkedin,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest('PUT',
        Uri.parse('https://innovative-minds.mustansirg.in/api/companies/${id}'));
    request.headers
        .addAll({'Authorization': 'Bearer ${prefs.getString('access')}'});
    request.files.add(
        await http.MultipartFile.fromPath('headquarters', headquarters!.path));
    request.files.add(await http.MultipartFile.fromPath('logo', logo!.path));
    request.fields.addAll({
      'name': name,
      'established_year': establishedYear,
      'size': size,
      'revenue': revenue.toString(),
      'mission_statement': missionStatement,
      'what_we_do': whatWeDo,
      'website': website,
      'instagram': instagram,
      'domain': domain,
      'facebook': facebook,
      'twitter': twitter,
      'address': address,
      'linkedin': linkedin,
    });

    var response = await request.send();

    await http.Response.fromStream(response).then((value) async {
      var body = jsonDecode(value.body);
      if (response.statusCode == 201) {
        print(body);
        return true;
      } else {
        print("Failed to Register");
        print(body);
        return false;
      }
    });
  }

  Future getCompanyById({
    required int id,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    var response = await http.delete(
        Uri.parse('https://innovative-minds.mustansirg.in/api/companies/${id}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${prefs.getString('access')}",
        });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      print("Failed to company by id");
      print(response.body);
      return false;
    }
  }

  Future deleteCompany({
    required int id,
  }) async {
    print('Inside Delete Company');
    final prefs = await SharedPreferences.getInstance();
    // Register
    var response = await http.post(
      Uri.parse("https://innovative-minds.mustansirg.in/api/companies/${id}"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString('access')}",
      },
    );

    if (response.statusCode == 204) {
      print('Deleted');
      return true;
    } else {
      print("Failed to Delete");
      print(response.body);
      return false;
    }
  }

  Future createJob({
    required int companyId,
    required String title,
    required String description,
    required double lat,
    required double lon,
    required String payscale,
    required String duration,
    required String timings,
    required String experience,
    required String workCulture,
    required String sponsored,
    required String emotionality,
  }) async {
    
  }
}