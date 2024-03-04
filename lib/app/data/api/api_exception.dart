import 'dart:convert';

class APIException implements Exception {
  final _message;
  final _prefix;
  final int? statusCode;

  APIException([this._message, this._prefix, this.statusCode]);

  String toString() {
    return "$_prefix$_message";
  }

  Map<String, dynamic>? errorMessages() {
    try {
      Map<String, dynamic> errorMessages = json.decode(_message);
      if (errorMessages == null || !errorMessages.containsKey("errors")) return null;

      return errorMessages["errors"];
    } catch (error) {
      return null;
    }
  }

  String errorMessage() {
    try {
      Map<String, dynamic> errorMessages = json.decode(_message);
      if (errorMessages == null || !errorMessages.containsKey("msg")) return _message;

      if (errorMessages == null || !errorMessages.containsKey("errors"))
        return errorMessages["msg"];

      if (errorMessages != null || errorMessages.containsKey("msg")) return errorMessages["msg"];

      return errorMessages["msg"] + errorMessages["errors"].keys.toString();
    } catch (error) {
      return _message;
    }
  }
}

class FetchDataException extends APIException {
  FetchDataException([String? message, statusCode])
      : super(message, "Error During Communication: ", statusCode);
}

class BadRequestException extends APIException {
  BadRequestException([message, statusCode]) : super(message, "Invalid Request: ", statusCode);
}

class NotFoundException extends APIException {
  NotFoundException([message, statusCode]) : super(message, "Invalid Request: ", statusCode);
}

class UnauthorisedException extends APIException {
  UnauthorisedException([message, statusCode]) : super(message, "Unauthorised: ", statusCode);
}

class InvalidInputException extends APIException {
  InvalidInputException([String? message, statusCode])
      : super(message, "Invalid Input: ", statusCode);
}
