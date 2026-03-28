class EarningsTrendResponse {
  int? statusCode;
  EarningsTrendData? data;
  String? message;
  bool? success;

  EarningsTrendResponse({
    this.statusCode,
    this.data,
    this.message,
    this.success,
  });

  factory EarningsTrendResponse.fromJson(Map<String, dynamic> json) {
    return EarningsTrendResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      success: json['success'],
      data: json['data'] != null
          ? EarningsTrendData.fromJson(json['data'])
          : null,
    );
  }
}

class EarningsTrendData {
  int? year;
  String? currency;
  List<EarningItem>? earningsTrend;

  EarningsTrendData({
    this.year,
    this.currency,
    this.earningsTrend,
  });

  factory EarningsTrendData.fromJson(Map<String, dynamic> json) {
    return EarningsTrendData(
      year: json['year'],
      currency: json['currency'],
      earningsTrend: json['earningsTrend'] != null ? List<EarningItem>.from(json['earningsTrend'].map((x) => EarningItem.fromJson(x))) : [],
    );
  }
}

class EarningItem {
  String? month;
  num? amount;

  EarningItem({
    this.month,
    this.amount,
  });

  factory EarningItem.fromJson(Map<String, dynamic> json) {
    return EarningItem(
      month: json['month'],
      amount: json['amount'] ?? 0,
    );
  }
}