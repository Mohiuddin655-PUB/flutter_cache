import 'package:in_app_cache/in_app_cache.dart';

void main() async {
  Cache.put("user", () {
    return {"name": "Json"};
  });
  print(Cache.get("user"));
  await Cache.putAsync("user2", () async {
    return {"name": "Future Json"};
  });
  print(Cache.get("user2"));
}
