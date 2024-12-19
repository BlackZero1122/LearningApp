import 'package:simple_connection_checker/simple_connection_checker.dart';

class NetworkService implements INetworkService {
  NetworkService();

  @override
  Future<bool> get isConnected async {
    return await SimpleConnectionChecker.isConnectedToInternet();
  }

  @override
  SimpleConnectionChecker get simpleConnectionChecker =>
      SimpleConnectionChecker();
}

abstract class INetworkService {
  Future<bool> get isConnected;

  SimpleConnectionChecker get simpleConnectionChecker;
}