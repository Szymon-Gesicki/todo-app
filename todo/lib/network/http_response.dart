enum HTTPResponse {
  unauthorized,
  notFound,
  unprocessableEntity,
  invalidRequest,
  internalServerError,
  conflict,
  unknown,
  success,
}

extension HTTPResponseExtension on HTTPResponse {
  static HTTPResponse from(int? value) {
    if(value == null) {
      return HTTPResponse.unknown;
    }

    if (value == 401)
      return HTTPResponse.unauthorized;
    else if (value == 404)
      return HTTPResponse.notFound;
    else if (value == 422)
      return HTTPResponse.unprocessableEntity;
    else if (value == 409)
      return HTTPResponse.conflict;
    else if (value >= 400 && value <= 499)
      return HTTPResponse.invalidRequest;
    else if (value >= 500 && value <= 599)
      return HTTPResponse.internalServerError;
    else
      return HTTPResponse.success;
  }
}
