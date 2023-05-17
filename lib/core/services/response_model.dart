class ResponseModel {

  String? message;
  bool? isError;

  ResponseModel({
    this.message,
    this.isError
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
        message: json["message"] ?? "",
        isError: json["isError"] ?? false,
      );
  }

Map<String, dynamic> toJson() {
  return {
    "message" : message,
    "isError" : isError,
  };
}

}