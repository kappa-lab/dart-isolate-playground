import 'dart:io';
import 'dart:isolate';

/** ---------------------------
{name: Taro}:117765460
  rename {name: Jiro}: 117765460
{name: Jiro}:117765460
  rename {name: Sabro}: 54522872
{name: Jiro}:117765460 ,Do not change Sabro! (hashCode Not equals)
User(Taro): 34171567
  rename User(Shiro): 34171567
User(Shiro): 34171567
  User(Shiro): 893950694, Apply Shiro, but it is different object.
  rename User(Goro): 893950694
User(Goro): 893950694 ,Return Goro from isolate
User(Shiro): 34171567 ,Do not change Goro! (hashCode Not equals)
------------------------------- */

Map<String, String> m = Map()..["name"] = "Taro";

class User {
  String name = "Taro";

  @override
  String toString() {
    return "User($name): $hashCode";
  }
}

void main() async {
  //Map
  print("$m:${m.hashCode}"); //{name: Taro}:

  toJiro(m);
  print("$m:${m.hashCode}");
  ; //{name: Jiro}

  Isolate.spawn(toSabro, m);
  sleep(Duration(milliseconds: 100));
  print(
      "$m:${m.hashCode} ,Do not change Sabro! (hashCode Not equals)"); //{name: Jiro}. Do not change Sabro! (hashCode Not equals)

  // User Class
  var u = User();
  print(u); //User(Taro)

  toShiro(u);
  print(u); //User(Shiro)

  final p = ReceivePort();
  Isolate.spawn(toGoro, [u, p.sendPort]);
  User res = await p.first as User;
  print("$res ,Return Goro from isolate"); // Return Goro from isolate

  print(
      "$u ,Do not change Goro! (hashCode Not equals)"); //User(Shiro). Do not change Goro! (hashCode Not equals)
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

void toGoro(List<dynamic> args) {
  print("  ${args[0]}, Apply Shiro, but it is different object.");
  (args[0] as User).name = "Goro";
  print("  rename ${args[0]}");
  Isolate.exit(args[1], args[0]);
}
