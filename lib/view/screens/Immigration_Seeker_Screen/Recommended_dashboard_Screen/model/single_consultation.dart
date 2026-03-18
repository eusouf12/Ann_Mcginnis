class ConsultantDetailsResponse {
  int? statusCode;
  ConsultantDetails? data;
  String? message;
  bool? success;

  ConsultantDetailsResponse({
    this.statusCode,
    this.data,
    this.message,
    this.success,
  });

  factory ConsultantDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ConsultantDetailsResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      success: json['success'],
      data: json['data'] != null
          ? ConsultantDetails.fromJson(json['data'])
          : null,
    );
  }
}

class ConsultantDetails {
  String? id;
  ConsultantAvailability? availability;
  SingleConsultantUser? userId;

  String? businessName;
  String? jobTitle;
  String? profileDescription;

  String? professionalLicenseDoc;
  String? certificationsFile;
  ConsultationFees? consultationFees;
  String? currency;
  int? discountRates;
  bool? stripeConnected;
  List<String>? consultationFormats;
  String? additionalNotes;
  String? stripeAccountId;
  int? experienceYears;
  List<String>? additionalDocuments;
  String? createdAt;
  String? updatedAt;

  ConsultantDetails({
    this.id,
    this.availability,
    this.userId,
    this.businessName,
    this.jobTitle,
    this.profileDescription,
    this.professionalLicenseDoc,
    this.certificationsFile,
    this.consultationFees,
    this.currency,
    this.discountRates,
    this.stripeConnected,
    this.consultationFormats,
    this.additionalNotes,
    this.stripeAccountId,
    this.experienceYears,
    this.additionalDocuments,
    this.createdAt,
    this.updatedAt,
  });

  factory ConsultantDetails.fromJson(Map<String, dynamic> json) {
    return ConsultantDetails(
      id: json['_id'],
      availability: json['availability'] != null ? ConsultantAvailability.fromJson(json['availability']) : null,
      userId: json['userId'] != null ? SingleConsultantUser.fromJson(json['userId']) : null,
      businessName: json['businessName'],
      jobTitle: json['jobTitle'],
      profileDescription: json['profileDescription'],
      professionalLicenseDoc: json['professionalLicenseDoc'],
      certificationsFile: json['certificationsFile'],
      consultationFees: json['consultationFees'] != null ? ConsultationFees.fromJson(json['consultationFees']) : null,
      currency: json['currency'],
      discountRates: json['discountRates'],
      stripeConnected: json['stripeConnected'],
      consultationFormats: json['consultationFormats'] != null ? List<String>.from(json['consultationFormats']) : [],
      additionalNotes: json['additionalNotes'],
      stripeAccountId: json['stripeAccountId'],
      experienceYears: json['experienceYears'],
      additionalDocuments: json['additionalDocuments'] != null ? List<String>.from(json['additionalDocuments']) : [],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class ConsultantAvailability {
  String? timeZone;
  List<String>? recurringDays;
  List<String>? preferredTimeSlots;

  ConsultantAvailability({
    this.timeZone,
    this.recurringDays,
    this.preferredTimeSlots,
  });

  factory ConsultantAvailability.fromJson(Map<String, dynamic> json) {
    return ConsultantAvailability(
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

class SingleConsultantUser {
  String? email;
  String? fullname;
  String? mobile;
  String? avatar;
  String? role;

  SingleConsultantUser({
    this.email,
    this.fullname,
    this.mobile,
    this.avatar,
    this.role,
  });

  factory SingleConsultantUser.fromJson(Map<String, dynamic> json) {
    return SingleConsultantUser(
      email: json['email'],
      fullname: json['fullname'],
      mobile: json['mobile'],
      avatar: json['avatar'],
      role: json['role'],
    );
  }
}

class ConsultationFees {
  int? videoCall;
  int? phoneCall;
  int? inPerson;

  ConsultationFees({
    this.videoCall,
    this.phoneCall,
    this.inPerson,
  });

  factory ConsultationFees.fromJson(Map<String, dynamic> json) {
    return ConsultationFees(
      videoCall: json['videoCall'],
      phoneCall: json['phoneCall'],
      inPerson: json['inPerson'],
    );
  }
}