class ServerException implements Exception{
  final String msg;
  const ServerException(this.msg);
}

class NetworkException implements Exception{
  final String msg;
  const NetworkException(this.msg);
}


class DatabaseException implements Exception{
  final String msg;
  const DatabaseException(this.msg);
}