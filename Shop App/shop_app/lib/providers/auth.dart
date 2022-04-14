import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Auth with ChangeNotifier {
  //this token will expire after sometime that is for security purpose
  var _token;
  //when or what time the token will expire
  DateTime? _expiryDate;
  //id of the login user
  var _userId;
  Timer? _authTimer;
  //var storeSharedData;

  String? get token {
    //if _expiryDate == null then we cant have a valid token
    //_expiryDate!.isAfter(DateTime.now()) == token hasnt exipired yet means it is valid
    //_token == null means we are not authenticate
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  //if we have token and token didnt expire then we are authenticate
  bool get isAuth {
    //if token is equal to null then we are not authenticated
    if (token != null) {
      return true;
    }
    return false;
  }

  get userId {
    return _userId;
  }

  /*//(i)
    Future<void> signup(String? email, String? password) async {
    //with this Url we will need to send to a request to
    //and this url comes from https://firebase.google.com/docs/reference/rest/auth this link
    //where inside of Endpoint
    //and [API_KEY] = comes from from firbase inside of project setting of shop app namde Web
    // API Key
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=AIzaSyBX2yXti8vHufM9LtzX15-7P_2RV5klRsY");

    //Request Body Payload check here with this link https://firebase.google.com/docs/reference/rest/auth
    final response = await http.post(
      url,
      body: json.encode(
        {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      ),
    );
    print(json.decode(response.body));
  }*/

  //   bool getUserAutoLoginId(var storeSharedData) {
  //   print(
  //       "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS + getUserAutoLoginId + storeSharedData : ${storeSharedData}");
  //   if (storeSharedData != null) {
  //     return true;
  //   }
  //   return false;
  // }

  Future<void> _authenticate(
      String? email, String? password, String? urlSegment) async {
    //(i) == check the explanation
    // here urlSegment is for indicating signup or signin
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBX2yXti8vHufM9LtzX15-7P_2RV5klRsY");
    //https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY](for signup)
    //https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY](for login)

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      //do some wrong and print the error then you will see how the error look like.it actaully look
      //like a map.
      //and this exception will receive on HttpException in auth_screen.dart
      if (responseData["error"] != null) {
        throw HttpException(responseData['error']['message']);
      }

      //from this link idToken.. has taken https://firebase.google.com/docs/reference/rest/auth#section-create-email-password
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      //from here _autoLogout is called(main set up)
      _autoLogout();
      notifyListeners();

      //for auto login.
      //SharedPreferences store key value pair on the device
      final _shredPreference = await SharedPreferences.getInstance();
      //assigning data into userData variable
      //josn alaws string.so when you have map then it necessary to convet into string
      //so here data is stored of user and token
      final userData = json.encode({
        'expiryDate': _expiryDate!.toIso8601String(),
        'token': _token,
        'userId': _userId,
      });
      //write(store) data with set method. here is stored string data inside of shredPreference
      _shredPreference.setString('userData', userData);

      var storeSharedData = _shredPreference.getString('userData');
      // getUserAutoLoginId(storeSharedData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String? email, String? password) async {
    //if we dont give return then signup will return immediatly. it will not wait for completing
    //_authenticate function
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String? email, String? password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final shredPreference = await SharedPreferences.getInstance();
    //  final extractedUserData = json
    //     .decode(shredPreference.getString('userData')!) as Map<String, dynamic>;

    //if userData has no value
    if (!shredPreference.containsKey('userData')) {
      return false;
    }
    //retrieve the data from SharedPreferences which was setted before inside of _athenticate function
    //shredPreference.getString('userData') == string, for this is converted into map with json.decode
     final extractedUserData = json
         .decode(shredPreference.getString('userData')!) as Map<String?, dynamic>;
    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'].toString());

    
    //if it is after then token is valide
    //if is before then token is invalid
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    //to clean shredPreference data when it logouts
    final shredPreference = await SharedPreferences.getInstance();
    //prefs.remove('userData');
    shredPreference.clear();
  }

  void _autoLogout() {
    //still we have existing time
    if (_authTimer != null) {
      //we will cancel before setting the new one
      _authTimer!.cancel();
    }
    //it difference between current time and expire time
    final _timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: _timeToExpiry), logout);
  }
}
