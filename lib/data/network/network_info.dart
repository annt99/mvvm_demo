// ignore: import_of_legacy_library_into_null_safe
import 'package:simple_connection_checker/simple_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();
  @override
  Future<bool> get isConnected =>
      SimpleConnectionChecker.isConnectedToInternet();
}
