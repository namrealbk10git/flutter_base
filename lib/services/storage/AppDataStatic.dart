
class AppDataStatic{

  static AppDataStatic _instance;
  AppDataStatic._internal();
  factory AppDataStatic(){
    _instance = _instance ?? new AppDataStatic._internal();
    return _instance;
  }

  String _token;
  String get token => _token??"";

}