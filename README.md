## Cache

A globally shared cache for storing and reusing logical data or objects by type and key.

## Example

```dart
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
```