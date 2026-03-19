class AppointmentResponse {
  int? statusCode;
  AppointmentData? data;
  String? message;
  bool? success;

  AppointmentResponse({
    this.statusCode,
    this.data,
    this.message,
    this.success,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      success: json['success'],
      data: json['data'] != null ? AppointmentData.fromJson(json['data']) : null,
    );
  }
}

class AppointmentData {
  List<Appointment>? bookings;
  AppointmentPagination? pagination;

  AppointmentData({
    this.bookings,
    this.pagination,
  });

  factory AppointmentData.fromJson(Map<String, dynamic> json) {
    return AppointmentData(
      bookings: json['bookings'] != null
          ? List<Appointment>.from(
          json['bookings'].map((x) => Appointment.fromJson(x)))
          : [],
      pagination: json['pagination'] != null
          ? AppointmentPagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class Appointment {
  String? id;
  AppointmentUser? userId;
  AppointmentConsultant? consultantId;
  double? originalAmount;
  double? discountRate;
  double? discountAmount;
  double? amount;
  String? currency;
  String? paymentStatus;
  String? bookingStatus;
  String? consultationDate;
  String? consultationTime;
  String? consultationType;
  String? createdAt;
  String? updatedAt;
  int? v;

  Appointment({
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

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'],
      userId: json['userId'] != null ? AppointmentUser.fromJson(json['userId']) : null,
      consultantId: json['consultantId'] != null
          ? AppointmentConsultant.fromJson(json['consultantId'])
          : null,
      originalAmount: (json['originalAmount'] ?? 0).toDouble(),
      discountRate: (json['discountRate'] ?? 0).toDouble(),
      discountAmount: (json['discountAmount'] ?? 0).toDouble(),
      amount: (json['amount'] ?? 0).toDouble(),
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

class AppointmentConsultant {
  String? id;
  AppointmentUser? userId;
  AppointmentAvailability? availability;
  String? businessName;
  String? jobTitle;
  String? profileDescription;
  AppointmentConsultationFees? consultationFees;
  String? currency;
  int? discountRates;
  List<String>? consultationFormats;
  String? additionalNotes;

  AppointmentConsultant({
    this.id,
    this.userId,
    this.availability,
    this.businessName,
    this.jobTitle,
    this.profileDescription,
    this.consultationFees,
    this.currency,
    this.discountRates,
    this.consultationFormats,
    this.additionalNotes,
  });

  factory AppointmentConsultant.fromJson(Map<String, dynamic> json) {
    return AppointmentConsultant(
      id: json['_id'],
      userId: json['userId'] != null ? AppointmentUser.fromJson(json['userId']) : null,
      availability: json['availability'] != null
          ? AppointmentAvailability.fromJson(json['availability'])
          : null,
      businessName: json['businessName'],
      jobTitle: json['jobTitle'],
      profileDescription: json['profileDescription'],
      consultationFees: json['consultationFees'] != null
          ? AppointmentConsultationFees.fromJson(json['consultationFees'])
          : null,
      currency: json['currency'],
      discountRates: json['discountRates'],
      consultationFormats: json['consultationFormats'] != null
          ? List<String>.from(json['consultationFormats'])
          : [],
      additionalNotes: json['additionalNotes'],
    );
  }
}

class AppointmentConsultationFees {
  int? videoCall;
  int? phoneCall;
  int? inPerson;

  AppointmentConsultationFees({
    this.videoCall,
    this.phoneCall,
    this.inPerson,
  });

  factory AppointmentConsultationFees.fromJson(Map<String, dynamic> json) {
    return AppointmentConsultationFees(
      videoCall: json['videoCall'],
      phoneCall: json['phoneCall'],
      inPerson: json['inPerson'],
    );
  }
}

class AppointmentUser {
  String? id;
  String? email;
  String? fullname;
  String? mobile;
  String? avatar;

  AppointmentUser({
    this.id,
    this.email,
    this.fullname,
    this.mobile,
    this.avatar,
  });

  factory AppointmentUser.fromJson(Map<String, dynamic> json) {
    return AppointmentUser(
      id: json['_id'],
      email: json['email'],
      fullname: json['fullname'],
      mobile: json['mobile'],
      avatar: json['avatar'],
    );
  }
}

class AppointmentAvailability {
  String? timeZone;
  List<String>? recurringDays;
  List<String>? preferredTimeSlots;

  AppointmentAvailability({
    this.timeZone,
    this.recurringDays,
    this.preferredTimeSlots,
  });

  factory AppointmentAvailability.fromJson(Map<String, dynamic> json) {
    return AppointmentAvailability(
      timeZone: json['timeZone'],
      recurringDays: json['recurringDays'] != null
          ? List<String>.from(json['recurringDays'])
          : [],
      preferredTimeSlots: json['preferredTimeSlots'] != null
          ? List<String>.from(json['preferredTimeSlots'])
          : [],
    );
  }
}

class AppointmentPagination {
  int? total;
  int? page;
  int? limit;
  int? pages;

  AppointmentPagination({
    this.total,
    this.page,
    this.limit,
    this.pages,
  });

  factory AppointmentPagination.fromJson(Map<String, dynamic> json) {
    return AppointmentPagination(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      pages: json['pages'],
    );
  }
}