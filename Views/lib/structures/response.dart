import 'package:comies/structures/structures.dart';
class Response<T> {
  String message;
  bool success;
  String access;
  T data;
  Notification notification;

  Response(
      {this.message, this.success, this.access, this.data, this.notification});
}
