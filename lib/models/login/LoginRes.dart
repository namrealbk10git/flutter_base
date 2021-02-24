

class LoginRes {

  String token;
  String name;
  String url;


  LoginRes.fromJson(Map<String, dynamic> map):
    token = map["token"],
    name = map["name"],
    url = map["url"];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = token;
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}