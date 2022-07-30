import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;

  Future<T> handleConnection<T>(
      {required Future<T> Function() onConnected,
      required Future<T> Function() onNotConnected});
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Future<T> handleConnection<T>(
      {required Future<T> Function() onConnected,
      required Future<T> Function() onNotConnected}) async {
    if (await isConnected) {
      return onConnected();
    } else {
      return onNotConnected();
    }
  }
}
