class ServerResponse {
  final bool success;
  final String? message;
  final dynamic data;
  final int? records;
  final Uri? path;
  final String? token;

  ServerResponse({
    this.data,
    this.success = true,
    this.message,
    this.records,
    this.path,
    this.token,
  });

  ServerResponse.error({
    this.success = false,
    this.message = 'Ops! Um erro ocorreu ao executar esta ação :(',
    this.records = 0,
    this.path,
    this.data,
    this.token
  });
}
