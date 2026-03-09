class PrivacyPolicyResponse {
  int? statusCode;
  bool? success;
  String? message;
  PrivacyPolicyData? data;

  PrivacyPolicyResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory PrivacyPolicyResponse.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyResponse(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? PrivacyPolicyData.fromJson(json['data'])
          : null,
    );
  }
}

class PrivacyPolicyData {
  String? id;
  String? type;
  String? content;
  String? createdAt;
  String? updatedAt;

  PrivacyPolicyData({
    this.id,
    this.type,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  factory PrivacyPolicyData.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyData(
      id: json['_id'] ?? json['id'],
      type: json['type'],
      content: json['content'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}