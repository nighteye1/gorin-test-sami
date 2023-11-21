enum Status { success, error, loading, noInternet, regionNotAllowed }

class ApiResponse<T> {
  ApiResponse({this.status, this.data, this.message});

  Status? status;
  T? data;
  String? message;
}
