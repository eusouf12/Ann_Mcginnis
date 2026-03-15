class SavedCountriesResponse {
  int? statusCode;
  SavedCountriesData? data;
  String? message;
  bool? success;

  SavedCountriesResponse({
    this.statusCode,
    this.data,
    this.message,
    this.success,
  });

  factory SavedCountriesResponse.fromJson(Map<String, dynamic> json) {
    return SavedCountriesResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      success: json['success'],
      data: json['data'] != null
          ? SavedCountriesData.fromJson(json['data'])
          : null,
    );
  }
}

class SavedCountriesData {
  List<SavedCountry>? savedCountries;
  SavedCountriesPagination? pagination;

  SavedCountriesData({
    this.savedCountries,
    this.pagination,
  });

  factory SavedCountriesData.fromJson(Map<String, dynamic> json) {
    return SavedCountriesData(
      savedCountries: json['savedCountries'] != null
          ? List<SavedCountry>.from(
          json['savedCountries'].map((x) => SavedCountry.fromJson(x)))
          : [],
      pagination: json['pagination'] != null
          ? SavedCountriesPagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class SavedCountry {
  String? id;
  String? userId;
  RecommendationInfo? recommendationId;

  String? country;
  int? score;
  String? label;
  String? confidence;

  List<String>? visaTypes;

  bool? englishSpeaking;
  bool? fastTrack;

  String? imageUrl;
  String? flagUrl;

  String? createdAt;
  String? updatedAt;

  SavedCountry({
    this.id,
    this.userId,
    this.recommendationId,
    this.country,
    this.score,
    this.label,
    this.confidence,
    this.visaTypes,
    this.englishSpeaking,
    this.fastTrack,
    this.imageUrl,
    this.flagUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory SavedCountry.fromJson(Map<String, dynamic> json) {
    return SavedCountry(
      id: json['_id'],
      userId: json['userId'],
      recommendationId: json['recommendationId'] != null
          ? RecommendationInfo.fromJson(json['recommendationId'])
          : null,
      country: json['country'],
      score: json['score'],
      label: json['label'],
      confidence: json['confidence'],
      visaTypes: json['visaTypes'] != null
          ? List<String>.from(json['visaTypes'])
          : [],
      englishSpeaking: json['englishSpeaking'],
      fastTrack: json['fastTrack'],
      imageUrl: json['imageUrl'],
      flagUrl: json['flagUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class RecommendationInfo {
  String? id;
  String? modelUsed;
  String? createdAt;

  RecommendationInfo({
    this.id,
    this.modelUsed,
    this.createdAt,
  });

  factory RecommendationInfo.fromJson(Map<String, dynamic> json) {
    return RecommendationInfo(
      id: json['_id'],
      modelUsed: json['modelUsed'],
      createdAt: json['createdAt'],
    );
  }
}

class SavedCountriesPagination {
  int? currentPage;
  int? totalPages;
  int? totalSaved;
  int? limit;
  bool? hasNextPage;
  bool? hasPrevPage;

  SavedCountriesPagination({
    this.currentPage,
    this.totalPages,
    this.totalSaved,
    this.limit,
    this.hasNextPage,
    this.hasPrevPage,
  });

  factory SavedCountriesPagination.fromJson(Map<String, dynamic> json) {
    return SavedCountriesPagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalSaved: json['totalSaved'],
      limit: json['limit'],
      hasNextPage: json['hasNextPage'],
      hasPrevPage: json['hasPrevPage'],
    );
  }
}