class RecommendationResponse {
  int? statusCode;
  RecommendationBody? data;
  String? message;
  bool? success;

  RecommendationResponse({
    this.statusCode,
    this.data,
    this.message,
    this.success,
  });

  factory RecommendationResponse.fromJson(Map<String, dynamic> json) {
    return RecommendationResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      success: json['success'],
      data: json['data'] != null
          ? RecommendationBody.fromJson(json['data'])
          : null,
    );
  }
}

class RecommendationBody {
  List<RecommendationData>? recommendations;
  Pagination? pagination;

  RecommendationBody({
    this.recommendations,
    this.pagination,
  });

  factory RecommendationBody.fromJson(Map<String, dynamic> json) {
    return RecommendationBody(
      recommendations: json['recommendations'] != null
          ? List<RecommendationData>.from(
        json['recommendations'].map(
              (x) => RecommendationData.fromJson(x),
        ),
      )
          : [],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalItems;
  int? limit;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.limit,
    this.hasNextPage,
    this.hasPrevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalItems: json['totalItems'],
      limit: json['limit'],
      hasNextPage: json['hasNextPage'],
      hasPrevPage: json['hasPrevPage'],
    );
  }
}

class RecommendationData {
  String? id;
  String? profileId;
  Results? results;
  String? topCountry;
  int? topScore;
  String? modelUsed;
  String? aiResponseHash;
  String? createdAt;
  String? updatedAt;

  RecommendationData({
    this.id,
    this.profileId,
    this.results,
    this.topCountry,
    this.topScore,
    this.modelUsed,
    this.aiResponseHash,
    this.createdAt,
    this.updatedAt,
  });

  factory RecommendationData.fromJson(Map<String, dynamic> json) {
    return RecommendationData(
      id: json['_id'],
      profileId: json['profileId'],
      results: json['results'] != null ? Results.fromJson(json['results']) : null,
      topCountry: json['topCountry'],
      topScore: json['topScore'],
      modelUsed: json['modelUsed'],
      aiResponseHash: json['aiResponseHash'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Results {
  List<CountryRecommendation>? countries;

  Results({this.countries});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      countries: json['countries'] != null
          ? List<CountryRecommendation>.from(
        json['countries'].map((x) => CountryRecommendation.fromJson(x)),
      )
          : [],
    );
  }
}

class CountryRecommendation {
  String? id;
  String? country;
  double? likelihood;
  String? confidence;
  List<dynamic>? visaTypes;
  bool? englishSpeaking;
  bool? fastTrack;
  int? score;
  String? label;
  String? imageUrl;


  CountryRecommendation({
    this.id,
    this.country,
    this.likelihood,
    this.confidence,
    this.visaTypes,
    this.englishSpeaking,
    this.fastTrack,
    this.score,
    this.label,
    this.imageUrl,
  });

  factory CountryRecommendation.fromJson(Map<String, dynamic> json) {
    return CountryRecommendation(
      id: json['_id'],
      country: json['country'],
      likelihood: (json['likelihood'] ?? 0).toDouble(),
      confidence: json['confidence'],
      englishSpeaking: json['englishSpeaking'],
      fastTrack: json['fastTrack'],
      score: json['score'],
      label: json['label'],
      imageUrl: json['imageUrl'],
      visaTypes: json['visaTypes'] != null ? List<String>.from(json['visaTypes']) : [],
    );
  }
}