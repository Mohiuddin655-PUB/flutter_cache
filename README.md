## Cache

A globally shared cache for storing and reusing logical data or objects by type and key.

## Example

```dart
import 'package:cache_manager/cache.dart';

void main() async {
  CacheManager.put("user", () {
    return {"name": "Json"};
  });
  print(CacheManager.get("user"));
  await CacheManager.putAsync("user2", () async {
    return {"name": "Future Json"};
  });
  print(CacheManager.get("user2"));
}
```