import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String ip = '189.49.232.245';

class AuthenticateRequest {
  static Future<bool> login(String email, String password) async {
    var url = Uri.http('$ip:3333', '/authenticate',);
    Map data = {
      'email': email,
      'password': password
    };
    var body = json.encode(data);
    try{
      var response = await http.post(url, headers: {"Content-Type": "application/json"} ,body: body);
      if(response.statusCode == 200){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var res = json.decode(response.body);
        prefs.setString('id', res['userAlreadyExists']['id']);
        prefs.setString('email', res['userAlreadyExists']['email']);
        prefs.setString('name', res['userAlreadyExists']['name']);
        prefs.setString('nickname', res['userAlreadyExists']['nickname']);
        prefs.setString('telefone', res['userAlreadyExists']['telefone'].toString());
        prefs.setString('token', res['token']);
        prefs.setString('refreshtoken', res['refreshToken']['id']);
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }
  }

  static Future<bool> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('refreshtoken') == null){
      //fazer login dnv
      return false;
    }
    var url = Uri.http('$ip:3333', '/authenticate/refreshToken/${prefs.getString('refreshtoken')}',);
    var response = await http.get(url);
    if(response.statusCode == 200){
      prefs.setString('refreshtoken', json.decode(response.body)['refreshToken']['id']);
      return true;
    }else{
      return false;
    }
  }

  static Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.http('$ip:3333', '/authenticate/logout/${prefs.getString('refreshtoken')}',);
    var response = await http.get(url);
    if(response.statusCode == 200){
      prefs.remove('token');
      prefs.remove('refreshtoken');
      return true;
    }else{
      return false;
    }
  }

  static Future<int> register(String name, String nickname, String email, String password, String telefone) async {
    var url = Uri.http('$ip:3333', '/authenticate/register',);
    Map data = {
      'name':name,
      'nickname': nickname,
      'email': email,
      'password': password,
      'telefone': telefone
    };
    var body = json.encode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"} ,body: body);
    if(response.statusCode == 200){
      return 1;
    }else if(response.statusCode == 409){
      return 409;
      //clonfito
    }else{
      //erro de conexão
      return 0;
    }
  }


}