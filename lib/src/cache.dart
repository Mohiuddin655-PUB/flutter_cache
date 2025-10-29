import 'package:flutter/foundation.dart';

/// A globally shared cache for storing and reusing logical data or objects
/// by type and key.
///
/// Each (Type, key) pair is guaranteed to have only one instance.
///
/// Example:
/// ```dart
/// final item = Cache.put(
///   'user/42',
///   () => UserModel(),
/// );
/// ```
class Cache {
  static final Map<String, Object> _cache = {};

  /// Retrieves an existing instance if available, or creates and stores
  /// a new one using the provided [create] function.
  static T put<T extends Object?>(String key, T Function() create) {
    final cache = _cache[key];
    if (cache is T) return cache;
    final x = create();
    if (x != null) _cache[key] = x;
    return x;
  }

  /// Retrieves an existing instance if available, or creates and stores
  /// a new one using the provided [create] function.
  static Future<T> putAsync<T extends Object?>(
    String key,
    Future<T> Function() create,
  ) async {
    final cache = _cache[key];
    if (cache is T) return cache;
    final x = await create();
    if (x != null) _cache[key] = x;
    return x;
  }

  /// Returns an existing instance for the given type and key, or null.
  static T? get<T extends Object>(String key) {
    final cache = _cache[key];
    if (cache is T) return cache;
    return null;
  }

  /// Removes a single instance from the cache and disposes it if possible.
  static Future<void> remove<T extends Object>(String key) async {
    final instance = _cache.remove(key);
    await _tryDispose(instance);
  }

  /// Clears all cached instances of all types.
  static Future<void> clear() async {
    for (final instance in _cache.values) {
      await _tryDispose(instance);
    }
    _cache.clear();
  }

  /// Attempts to gracefully dispose supported objects.
  /// Supports both `dispose()` and `close()` methods automatically.
  static Future<void> _tryDispose(Object? instance) async {
    if (instance == null) return;
    try {
      if (instance is ChangeNotifier) {
        instance.dispose();
      }
    } catch (e) {
      debugPrint('Cache dispose error: $e');
    }
  }
}
