import 'dart:convert';

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
        Uri.parse("https://tourmate.mustansirg.in/api/auth/token/refresh/"),
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
      Uri.parse("https://tourmate.mustansirg.in/api/auth/login/"),
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
  }) async {
    final prefs = await SharedPreferences.getInstance();
    // Register
    var response = await http.post(
      Uri.parse("https://tourmate.mustansirg.in/api/auth/registration/"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "username": username,
        "password1": password1,
        "password2": password2,
      }),
    );
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print(data);
      await prefs.setString('access', data['access_token']);
      await prefs.setString('refresh', data['refresh_token']);
      Access = data['access'];
      Refresh = data['refresh'];
      refreshTheToken();
      return true;
    } else {
      print("Failed to Register");
      print(response.body);
      return false;
    }
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    tokenData = null;
    notifyListeners();
  }

  List<dynamic> locationPoints = [
    {
      "id": 5,
      "name": "Taj Mahal",
      "description":
          "A structure of absolute beauty in Agra constructed in the name of love",
      "country": "India",
      "state": "Delhi",
      "address": "Agra, Delhi",
      "location": {
        "type": "Point",
        "coordinates": [78.0421, 27.1751],
      },
      "image":
          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.dharmadispatch.in%2Fhistory%2Fyes-the-taj-mahal-is-a-despots-monument-to-a-woman-it-also-stands-for-hindu-cultural-amnesia&psig=AOvVaw1wBH3_CG7OokC0P3hRj0Fb&ust=1678006263329000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCPDCqMzywf0CFQAAAAAdAAAAABAE",
      "added_by": "Prerak",
      "phone": "9876543210",
      "website": "www.google.com",
      "created_at": "2023-03-04T09:13:16.115146Z",
      "updated_at": "2023-03-04T09:13:16.115171Z"
    },
  ];

  // var locationPoints;

  var locationsByRadius = [];

  Future getLocationsByRadius() async {
    print('Fetching Location by radius');
    final prefs = await SharedPreferences.getInstance();
    // Register
    var response = await http.get(
      Uri.parse(
          "https://tourmate.mustansirg.in/api/locations/get/nearby/?lon=72.8777&lat=19.0760"),
      headers: {
        "Content-Type": "application/json",
        // "Authorization": "Bearer " + APIToken,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 203) {
      print('Response received');
      locationsByRadius = jsonDecode(response.body);
      locationPoints.addAll(locationsByRadius);
      print(locationsByRadius.length);
      print(locationPoints.length);
      notifyListeners();
      return true;
    } else {
      print("Failed to Fetch");
      print(response.body);
      return false;
    }
  }

  var availableSearches = [];

  Future getAvailableSearches() async {
    print('Fetching All');
    var response = await http.get(
      Uri.parse("https://tourmate.mustansirg.in/api/locations/get/all/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + Access,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 203) {
      print('Response received');
      availableSearches = jsonDecode(response.body);
      print(availableSearches.length);
      notifyListeners();
      return true;
    } else {
      print("Failed to Fetch");
      print(response.body);
      return false;
    }
  }

  var createTourData = {};

  Future findJourney({required double lat, required double long}) async {
    print('Inside Find Journey');
    var response = await http.get(
      Uri.parse(
          "https://tourmate.mustansirg.in/api/locations/get/latlong/?lat=$lat&lon=$long"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + Access,
      },
    );
    if (response.statusCode == 200) {
      print('object');
      var data = jsonDecode(response.body);
      createTourData = data;
      print(data.toString());
      notifyListeners();
    } else {
      print("Failed to Find Journey");
    }
  }

  var nearbyJourneys = [];

  Future fetchNearbyJourneys() async {
    print('Inside Nearby Journeys');
    var response = await http.get(
      Uri.parse("https://tourmate.mustansirg.in/api/journey/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + Access,
      },
    );
    if (response.statusCode == 200) {
      print('Found! Nearby Journeys');
      var data = jsonDecode(response.body);
      nearbyJourneys = data;
      print(data.toString());
      notifyListeners();
    } else {
      print("Failed to Fetch Nearby Journeys");
    }
  }

  var nearbyUsers = [];

  Future fetchNearbyUsers() async {
    print('Inside Fetch Users');
    var response = await http.get(
      Uri.parse("https://tourmate.mustansirg.in/api/journey/users/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + Access,
      },
    );
    if (response.statusCode == 200) {
      print('Found! Nearby Users');
      var data = jsonDecode(response.body);
      nearbyUsers = data;
      print(data.toString());
      notifyListeners();
    } else {
      print("Failed to Fetch Users");
    }
  }



  Future crateNewTour({
    required String username,
    required String email,
    required String password1,
    required String password2,
  }) async {
    final prefs = await SharedPreferences.getInstance();
// Register
    var response = await http.post(
      Uri.parse("https://tourmate.mustansirg.in/api/auth/registration/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + Access,
      },
      body: jsonEncode({
        "name": "Hellooo's Birthday Trek",
        "description": "It's my birthday trek duh....",
        "start_date": "2023-07-03",
        "end_date": "2023-10-03",
        "budget": "250000",
        "destination": 3
      }),
    );
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print(data);
      await prefs.setString('access', data['access_token']);
      await prefs.setString('refresh', data['refresh_token']);
      Access = data['access'];
      Refresh = data['refresh'];
      refreshTheToken();
      return true;
    } else {
      print("Failed to Register");
      print(response.body);
      return false;
    }
  }

  Future sendSOS({required double lat, required double long}) async {
    print('Inside Send SOS');
    final prefs = await SharedPreferences.getInstance();
// Register
    var response = await http.get(
      Uri.parse("https://tourmate.mustansirg.in/api/sos/?lat=$lat&lon=$long"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + Access,
      },
    );
    if (response.statusCode == 200) {
      print('SOS Sent');
      var data = jsonDecode(response.body);
      print(data.toString());
    } else {
      print("Failed to Send SOS");
    }
  }
}
