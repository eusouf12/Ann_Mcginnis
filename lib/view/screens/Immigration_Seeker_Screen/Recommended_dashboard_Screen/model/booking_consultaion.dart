class BookingResponse {
  int? statusCode;
  BookingData? data;
  String? message;
  bool? success;

  BookingResponse({
    this.statusCode,
    this.data,
    this.message,
    this.success,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      success: json['success'],
      data: json['data'] != null ? BookingData.fromJson(json['data']) : null,
    );
  }
}

class BookingData {
  List<Booking>? bookings;
  Pagination? pagination;

  BookingData({
    this.bookings,
    this.pagination,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      bookings: json['bookings'] != null
          ? List<Booking>.from(
          json['bookings'].map((x) => Booking.fromJson(x)))
          : [],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class Booking {
  String? id;
  User? userId;
  Consultant? consultantId;

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

  Booking({
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
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'],
      userId: json['userId'] != null ? User.fromJson(json['userId']) : null,
      consultantId: json['consultantId'] != null
          ? Consultant.fromJson(json['consultantId'])
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
    );
  }
}

class Consultant {
  String? id;
  User? userId;
  Availability? availability;

  String? businessName;
  String? jobTitle;
  String? profileDescription;

  int? consultationFees;
  String? currency;
  int? discountRates;

  List<String>? consultationFormats;
  String? additionalNotes;

  Consultant({
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

  factory Consultant.fromJson(Map<String, dynamic> json) {
    return Consultant(
      id: json['_id'],
      userId: json['userId'] != null ? User.fromJson(json['userId']) : null,
      availability: json['availability'] != null
          ? Availability.fromJson(json['availability'])
          : null,
      businessName: json['businessName'],
      jobTitle: json['jobTitle'],
      profileDescription: json['profileDescription'],
      consultationFees: json['consultationFees'],
      currency: json['currency'],
      discountRates: json['discountRates'],
      consultationFormats: json['consultationFormats'] != null
          ? List<String>.from(json['consultationFormats'])
          : [],
      additionalNotes: json['additionalNotes'],
    );
  }
}

class User {
  String? id;
  String? email;
  String? fullname;
  String? mobile;
  String? avatar;

  User({
    this.id,
    this.email,
    this.fullname,
    this.mobile,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      fullname: json['fullname'],
      mobile: json['mobile'],
      avatar: json['avatar'],
    );
  }
}

class Availability {
  String? timeZone;
  List<String>? recurringDays;
  List<String>? preferredTimeSlots;

  Availability({
    this.timeZone,
    this.recurringDays,
    this.preferredTimeSlots,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
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

class Pagination {
  int? total;
  int? page;
  int? limit;
  int? pages;

  Pagination({
    this.total,
    this.page,
    this.limit,
    this.pages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      pages: json['pages'],
    );
  }
}