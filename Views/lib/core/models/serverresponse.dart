import 'dart:convert';

class ServerResponse {
  final bool success;
  final String message;
  final String? exception;
  final dynamic data;
  final int? records;
  final String? id;
  final String serviceIdentifier;
  ServerResponse({
    required this.success,
    required this.message,
    this.exception,
    this.data,
    this.records,
    this.id,
    required this.serviceIdentifier,
  });

  ServerResponse copyWith({
    bool? success,
    String? message,
    String? exception,
    dynamic data,
    int? records,
    String? id,
    String? serviceIdentifier,
  }) {
    return ServerResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      exception: exception ?? this.exception,
      data: data ?? this.data,
      records: records ?? this.records,
      id: id ?? this.id,
      serviceIdentifier: serviceIdentifier ?? this.serviceIdentifier,
    );
  }

  static ServerResponse errorResponse = ServerResponse(success: false, message: 'Ops! Um erro ocorreu ao realizarmos essa ação', serviceIdentifier: '');

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
      'exception': exception,
      'data': data,
      'records': records,
      'id': id,
      'serviceIdentifier': serviceIdentifier,
    };
  }

  ServerResponse.custom({this.success = true, this.message = '', this.serviceIdentifier = '', required this.data, this.id, this.exception, this.records});

  factory ServerResponse.fromMap(Map<String, dynamic> map) {
    return ServerResponse(
      success: map['success'],
      message: map['message'],
      exception: map['exception'],
      data: map['data'],
      records: map['records'],
      id: map['id'],
      serviceIdentifier: map['serviceIdentifier'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ServerResponse.fromJson(String source) => ServerResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ServerResponse(success: $success, message: $message, exception: $exception, data: $data, records: $records, id: $id, serviceIdentifier: $serviceIdentifier)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServerResponse &&
        other.success == success &&
        other.message == message &&
        other.exception == exception &&
        other.data == data &&
        other.records == records &&
        other.id == id &&
        other.serviceIdentifier == serviceIdentifier;
  }

  @override
  int get hashCode {
    return success.hashCode ^ message.hashCode ^ exception.hashCode ^ data.hashCode ^ records.hashCode ^ id.hashCode ^ serviceIdentifier.hashCode;
  }
}
