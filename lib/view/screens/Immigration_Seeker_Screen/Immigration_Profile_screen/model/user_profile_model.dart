class UserProfileModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  UserProfileModel({this.statusCode, this.data, this.message, this.success});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      statusCode: json['statusCode'],
      message: json['message'],
      success: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  User? user;

  Data({this.user});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  String? id;
  String? email;
  String? fullname;
  String? mobile;
  String? dateOfBirth;
  String? country;
  String? avatar;
  bool? isPremiumMember;
  String? role;
  bool? isBlocked;
  bool? isEmailVerified;
  dynamic emailVerificationExpiresAt;
  String? createdAt;
  String? updatedAt;
  int? version;

  User({
    this.id,
    this.email,
    this.fullname,
    this.mobile,
    this.dateOfBirth,
    this.country,
    this.avatar,
    this.isPremiumMember,
    this.role,
    this.isBlocked,
    this.isEmailVerified,
    this.emailVerificationExpiresAt,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'],
      email: json['email'] ?? "",
      fullname: json['fullname'] ?? "",
      mobile: json['mobile'] ?? "",
      dateOfBirth: json['dateOfBirth'] ?? "",
      country: json['country'] ?? "",
      avatar: json['avatar'] ?? "",
      isPremiumMember: json['isPremiumMember'] ?? false,
      role: json['role'] ?? "",
      isBlocked: json['isBlocked'] ?? false,
      isEmailVerified: json['isEmailVerified'] ?? false,
      emailVerificationExpiresAt: json['emailVerificationExpiresAt'],
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      version: json['__v'],
    );
  }
}
