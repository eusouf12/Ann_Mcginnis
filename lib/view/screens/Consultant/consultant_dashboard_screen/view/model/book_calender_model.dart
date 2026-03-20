class BookedDatesResponse {
  int? statusCode;
  BookedDatesData? data;
  String? message;
  bool? success;

  BookedDatesResponse({
    this.statusCode,
    this.data,
    this.message,
    this.success,
  });

  factory BookedDatesResponse.fromJson(Map<String, dynamic> json) {
    return BookedDatesResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      success: json['success'],
      data: json['data'] != null
          ? BookedDatesData.fromJson(json['data'])
          : null,
    );
  }
}

class BookedDatesData {
  int? year;
  int? month;
  String? monthName;
  List<BookedDate>? bookedDates;

  BookedDatesData({
    this.year,
    this.month,
    this.monthName,
    this.bookedDates,
  });

  factory BookedDatesData.fromJson(Map<String, dynamic> json) {
    return BookedDatesData(
      year: json['year'],
      month: json['month'],
      monthName: json['monthName'],
      bookedDates: json['bookedDates'] != null ? List<BookedDate>.from(json['bookedDates'].map((x) => BookedDate.fromJson(x))) : [],
    );
  }
}

class BookedDate {
  String? date;
  int? day;
  int? totalBookings;

  BookedDate({
    this.date,
    this.day,
    this.totalBookings,
  });

  factory BookedDate.fromJson(Map<String, dynamic> json) {
    return BookedDate(
      date: json['date'],
      day: json['day'],
      totalBookings: json['totalBookings'],
    );
  }
}