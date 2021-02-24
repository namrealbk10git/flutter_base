

class LoginReq {

  String user;
  String pass;


  LoginReq.fromJson(Map<String, dynamic> map):
        user = map["user"],
        pass = map["pass"];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = user;
    data['pass'] = pass;
    return data;
  }
}