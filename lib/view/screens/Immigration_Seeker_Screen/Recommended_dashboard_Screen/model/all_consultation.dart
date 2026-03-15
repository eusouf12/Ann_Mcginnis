class ConsultantResponse {
  int? statusCode;
  ConsultantData? data;
  String? message;
  bool? success;

  ConsultantResponse({
    this.statusCode,
    this.data,
    this.message,
    this.success,
  });

  factory ConsultantResponse.fromJson(Map<String, dynamic> json) {
    return ConsultantResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      success: json['success'],
      data: json['data'] != null
          ? ConsultantData.fromJson(json['data'])
          : null,
    );
  }
}

class ConsultantData {
  List<Consultant>? consultants;
  Pagination? pagination;

  ConsultantData({
    this.consultants,
    this.pagination,
  });

  factory ConsultantData.fromJson(Map<String, dynamic> json) {
    return ConsultantData(
      consultants: json['consultants'] != null
          ? List<Consultant>.from(
          json['consultants'].map((x) => Consultant.fromJson(x)))
          : [],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class Consultant {
  String? id;
  Availability? availability;
  UserId? userId;
  String? businessName;
  String? jobTitle;
  String? profileDescription;
  int? consultationFees;
  String? currency;
  int? discountRates;
  bool? stripeConnected;
  List<String>? consultationFormats;
  String? additionalNotes;
  String? stripeAccountId;
  String? createdAt;
  String? updatedAt;

  Consultant({
    this.id,
    this.availability,
    this.userId,
    this.businessName,
    this.jobTitle,
    this.profileDescription,
    this.consultationFees,
    this.currency,
    this.discountRates,
    this.stripeConnected,
    this.consultationFormats,
    this.additionalNotes,
    this.stripeAccountId,
    this.createdAt,
    this.updatedAt,
  });

  factory Consultant.fromJson(Map<String, dynamic> json) {
    return Consultant(
      id: json['_id'],
      availability: json['availability'] != null
          ? Availability.fromJson(json['availability'])
          : null,
      userId:
      json['userId'] != null ? UserId.fromJson(json['userId']) : null,
      businessName: json['businessName'],
      jobTitle: json['jobTitle'],
      profileDescription: json['profileDescription'],
      consultationFees: json['consultationFees'],
      currency: json['currency'],
      discountRates: json['discountRates'],
      stripeConnected: json['stripeConnected'],
      consultationFormats: json['consultationFormats'] != null
          ? List<String>.from(json['consultationFormats'])
          : [],
      additionalNotes: json['additionalNotes'],
      stripeAccountId: json['stripeAccountId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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

class UserId {
  String? email;
  String? fullname;
  String? mobile;
  String? avatar;
  String? role;

  UserId({
    this.email,
    this.fullname,
    this.mobile,
    this.avatar,
    this.role,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      email: json['email'],
      fullname: json['fullname'],
      mobile: json['mobile'],
      avatar: json['avatar'],
      role: json['role'],
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