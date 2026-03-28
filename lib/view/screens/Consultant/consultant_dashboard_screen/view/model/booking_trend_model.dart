class BookingTrendResponse {
  int? statusCode;
  BookingTrendData? data;
  String? message;
  bool? success;

  BookingTrendResponse({
    this.statusCode,
    this.data,
    this.message,
    this.success,
  });

  factory BookingTrendResponse.fromJson(Map<String, dynamic> json) {
    return BookingTrendResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      success: json['success'],
      data: json['data'] != null ? BookingTrendData.fromJson(json['data']) : null,
    );
  }
}

class BookingTrendData {
  int? year;
  List<BookingTrendItem>? bookingTrend;

  BookingTrendData({
    this.year,
    this.bookingTrend,
  });

  factory BookingTrendData.fromJson(Map<String, dynamic> json) {
    return BookingTrendData(
      year: json['year'],
      bookingTrend: json['bookingTrend'] != null ? List<BookingTrendItem>.from(json['bookingTrend'].map((x) => BookingTrendItem.fromJson(x))) : [],
    );
  }
}

class BookingTrendItem {
  String? month;
  int? count;

  BookingTrendItem({
    this.month,
    this.count,
  });

  factory BookingTrendItem.fromJson(Map<String, dynamic> json) {
    return BookingTrendItem(
      month: json['month'],
      count: json['count'] ?? 0,
    );
  }
}