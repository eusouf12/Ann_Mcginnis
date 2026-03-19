class BookingSummary {
  final int? totalBookings;
  final int? totalPaidBookings;
  final num? totalEarnings;
  final String? currency;

  BookingSummary({
    this.totalBookings,
    this.totalPaidBookings,
    this.totalEarnings,
    this.currency,
  });

  factory BookingSummary.fromJson(Map<String, dynamic> json) {
    return BookingSummary(
      totalBookings: json['totalBookings'] ??0,
      totalPaidBookings: json['totalPaidBookings'] ?? 0,
      totalEarnings: json['totalEarnings'] ?? 0,
      currency: json['currency'] ?? "",
    );
  }
}