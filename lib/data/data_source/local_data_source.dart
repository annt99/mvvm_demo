import 'package:mvvm_demo/data/network/error_handler.dart';
import 'package:mvvm_demo/data/response/responses.dart';

const CACHE_HOME_KEY = 'CACHE_HOME_KEY';
const CACHE_HOME_INTERVAL = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHome();
  Future<void> saveHomeToCache(HomeResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  //run time cache
  Map<String, CacheItem> cacheMap = Map();
  @override
  Future<HomeResponse> getHome() async {
    CacheItem? cacheItem = cacheMap[CACHE_HOME_KEY];
    if (cacheItem != null && cacheItem.isValid(CACHE_HOME_INTERVAL)) {
      return cacheItem.data;
    } else {
      throw ErrorHandler.handler(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CacheItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CacheItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CacheItem(this.data);
}

extension CachedItemExtension on CacheItem {
  bool isValid(int expirationTime) {
    int currenTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isCachedValid = currenTimeInMillis - expirationTime > cacheTime;
    return isCachedValid;
  }
}
