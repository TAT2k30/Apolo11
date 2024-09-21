class ApiUrls {
  static const String API_BASE_URL = 'http://192.168.1.96:8080/api/v1';
}


class ResultResponse<T> {
  final String timeStamp;
  final T body;
  final String message;
  final String status;
  final int statusCode;

  ResultResponse({
    required this.timeStamp,
    required this.body,
    required this.message,
    required this.status,
    required this.statusCode,
  });

  factory ResultResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) parseBody) {
    return ResultResponse<T>(
      timeStamp: json['timeStamp'] as String,
      body: parseBody(json['body']),
      message: json['message'] as String,
      status: json['status'] as String,
      statusCode: json['statusCode'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timeStamp': timeStamp,
      'body': body,
      'message': message,
      'status': status,
      'statusCode': statusCode,
    };
  }
}
