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
  AvailableFilters? availableFilters;

  RecommendationBody({
    this.recommendations,
    this.pagination,
    this.availableFilters,
  });

  factory RecommendationBody.fromJson(Map<String, dynamic> json) {
    return RecommendationBody(
      recommendations: json['recommendations'] != null ? List<RecommendationData>.from(json['recommendations'].map((x) => RecommendationData.fromJson(x),),) : [],
      pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
      availableFilters: json['availableFilters'] != null ? AvailableFilters.fromJson(json['availableFilters']) : null,
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
  String? flagUrl;


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
    this.flagUrl,
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
      imageUrl: json['imageUrl'] ?? "",
      flagUrl: json['flagUrl'] ?? "",
      visaTypes: json['visaTypes'] != null ? List<String>.from(json['visaTypes']) : [],
    );
  }
}

class AvailableFilters {
  List<VisaTypeFilter>? visaTypes;
  AdditionalOptions? additionalOptions;
  int? countryCount;

  AvailableFilters({
    this.visaTypes,
    this.additionalOptions,
    this.countryCount,
  });

  factory AvailableFilters.fromJson(Map<String, dynamic> json) {
    return AvailableFilters(
      visaTypes: json['visaTypes'] != null
          ? List<VisaTypeFilter>.from(
        json['visaTypes'].map((x) => VisaTypeFilter.fromJson(x)),
      )
          : [],
      additionalOptions: json['additionalOptions'] != null
          ? AdditionalOptions.fromJson(json['additionalOptions'])
          : null,
      countryCount: json['countryCount'],
    );
  }
}

class VisaTypeFilter {
  String? label;
  String? value;
  int? count;

  VisaTypeFilter({
    this.label,
    this.value,
    this.count,
  });

  factory VisaTypeFilter.fromJson(Map<String, dynamic> json) {
    return VisaTypeFilter(
      label: json['label'],
      value: json['value'],
      count: json['count'],
    );
  }
}

class AdditionalOptions {
  bool? englishOnly;
  bool? fastTrackOnly;

  AdditionalOptions({
    this.englishOnly,
    this.fastTrackOnly,
  });

  factory AdditionalOptions.fromJson(Map<String, dynamic> json) {
    return AdditionalOptions(
      englishOnly: json['englishOnly'],
      fastTrackOnly: json['fastTrackOnly'],
    );
  }
}