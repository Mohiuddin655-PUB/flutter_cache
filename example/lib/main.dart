import 'package:cache/cache.dart';

void main() {
  final cache = Cache.put("user", () {
    return {"name": "Json"};
  });
  print(cache);
}
