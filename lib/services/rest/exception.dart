import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DioExceptions implements Exception {
  String message = "";
  DioExceptions.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = "requestCanceled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "connectionTimeout";
        break;
      case DioExceptionType.receiveTimeout:
        message = "receiveTimeout";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(dioException.response!.statusCode!.toInt(),
            dioException.response!.data);
        break;
      case DioExceptionType.sendTimeout:
        message = "sendTimeout";
        break;
      case DioExceptionType.unknown:
        message = "connectionPend";
        break;
      default:
        message = "somethingWrong";
        break;
    }
  }

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error['error'] ?? error["message"] ?? "badRequest";
      case 404:
        return error['error'] ?? error["message"] ?? "urlIncorrect";
      case 500:
        return error['error'] ??
            error["message"] ??
            "internalServerError";
      default:
        return error['error'] ?? error["message"] ?? "somethingWrong";
    }
  }

  @override
  String toString() => message;
}