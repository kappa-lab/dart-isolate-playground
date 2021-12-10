import 'dart:io';
import 'dart:isolate';

Map<String, String> m = Map()..["name"] = "Taro";

class User {
  String name = "Taro";

  @override
  String toString() {
    return "User($name): $hashCode";
  }
}

void main() {
  //Map
  print("$m:${m.hashCode}"); //{name: Taro}:

  toJiro(m);
  print(m); //{name: Jiro}

  Isolate.spawn(toSabro, m);
  sleep(Duration(milliseconds: 100));
  print(m); //{name: Jiro}. Do not change Sabro! (hashCode Not equals)

  // User Class
  var u = User();
  print(u); //User(Taro)

  toShiro(u);
  print(u); //User(Shiro)

  Isolate.spawn(toGoro, u);
  sleep(Duration(milliseconds: 100));
  print(u); //User(Shiro). Do not change Goro! (hashCode Not equals)
}

void toJiro(Map<String, String> m) {
  m["name"] = "Jiro";
  print("  rename $m: ${m.hashCode}");
}

void toSabro(Map<String, String> m) {
  m["name"] = "Sabro";
  print("  rename $m: ${m.hashCode}");
}

void toShiro(User u) {
  u.name = "Shiro";
  print("  rename $u");
}

void toGoro(User u) {
  u.name = "Goro";
  print("  rename $u");
}
