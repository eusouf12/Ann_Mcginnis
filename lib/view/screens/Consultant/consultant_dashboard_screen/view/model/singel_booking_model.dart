class SingleBookingResponse {
  int? statusCode;
  bool? success;
  String? message;
  SingleBookingData? data;

  SingleBookingResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory SingleBookingResponse.fromJson(Map<String, dynamic> json) {
    return SingleBookingResponse(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? SingleBookingData.fromJson(json['data'])
          : null,
    );
  }
}

class SingleBookingData {
  String? id;
  SingleBookingUser? userId;
  SingleBookingConsultant? consultantId;

  num? originalAmount;
  num? discountRate;
  num? discountAmount;
  num? amount;

  String? currency;
  String? paymentStatus;
  String? bookingStatus;

  String? consultationDate;
  String? consultationTime;
  String? consultationType;

  String? createdAt;
  String? updatedAt;
  int? v;

  SingleBookingData({
    this.id,
    this.userId,
    this.consultantId,
    this.originalAmount,
    this.discountRate,
    this.discountAmount,
    this.amount,
    this.currency,
    this.paymentStatus,
    this.bookingStatus,
    this.consultationDate,
    this.consultationTime,
    this.consultationType,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SingleBookingData.fromJson(Map<String, dynamic> json) {
    return SingleBookingData(
      id: json['_id'],
      userId: json['userId'] != null
          ? SingleBookingUser.fromJson(json['userId'])
          : null,
      consultantId: json['consultantId'] != null
          ? SingleBookingConsultant.fromJson(json['consultantId'])
          : null,
      originalAmount: json['originalAmount'] ?? 0,
      discountRate: json['discountRate'] ?? 0,
      discountAmount: json['discountAmount'] ?? 0,
      amount: json['amount'] ?? 0,
      currency: json['currency'],
      paymentStatus: json['paymentStatus'],
      bookingStatus: json['bookingStatus'],
      consultationDate: json['consultationDate'],
      consultationTime: json['consultationTime'],
      consultationType: json['consultationType'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class SingleBookingUser {
  String? id;
  String? email;
  String? fullname;
  String? mobile;
  String? avatar;

  SingleBookingUser({
    this.id,
    this.email,
    this.fullname,
    this.mobile,
    this.avatar,
  });

  factory SingleBookingUser.fromJson(Map<String, dynamic> json) {
    return SingleBookingUser(
      id: json['_id'],
      email: json['email'],
      fullname: json['fullname'],
      mobile: json['mobile'],
      avatar: json['avatar'],
    );
  }
}

class SingleBookingConsultant {
  String? id;
  SingleBookingUser? userId;

  String? businessName;
  String? jobTitle;
  String? profileDescription;

  SingleBookingFees? consultationFees;
  String? currency;

  SingleBookingConsultant({
    this.id,
    this.userId,
    this.businessName,
    this.jobTitle,
    this.profileDescription,
    this.consultationFees,
    this.currency,
  });

  factory SingleBookingConsultant.fromJson(Map<String, dynamic> json) {
    return SingleBookingConsultant(
      id: json['_id'],
      userId: json['userId'] != null
          ? SingleBookingUser.fromJson(json['userId'])
          : null,
      businessName: json['businessName'],
      jobTitle: json['jobTitle'],
      profileDescription: json['profileDescription'],
      consultationFees: json['consultationFees'] != null
          ? SingleBookingFees.fromJson(json['consultationFees'])
          : null,
      currency: json['currency'],
    );
  }
}

class SingleBookingFees {
  int? videoCall;
  int? phoneCall;
  int? inPerson;

  SingleBookingFees({
    this.videoCall,
    this.phoneCall,
    this.inPerson,
  });

  factory SingleBookingFees.fromJson(Map<String, dynamic> json) {
    return SingleBookingFees(
      videoCall: json['videoCall'],
      phoneCall: json['phoneCall'],
      inPerson: json['inPerson'],
    );
  }
}