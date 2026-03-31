class EligibleVisasModel {
  int? statusCode;
  CountryData? data;
  String? message;
  bool? success;

  EligibleVisasModel({
    this.statusCode,
    this.data,
    this.message,
    this.success,
  });

  factory EligibleVisasModel.fromJson(Map<String, dynamic> json) {
    return EligibleVisasModel(
      statusCode: json['statusCode'],
      data: json['data'] != null ? CountryData.fromJson(json['data']) : null,
      message: json['message'],
      success: json['success'],
    );
  }
}

class CountryData {
  String? id;
  String? name;
  String? slug;
  String? imageUrl;
  String? flagUrl;
  List<VisaType>? visaTypes;
  RecommendationMetadata? recommendationMetadata;

  CountryData({
    this.id,
    this.name,
    this.slug,
    this.imageUrl,
    this.flagUrl,
    this.visaTypes,
    this.recommendationMetadata,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) {
    return CountryData(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      imageUrl: json['imageUrl'],
      flagUrl: json['flagUrl'],
      visaTypes: (json['visaTypes'] as List?)
          ?.map((e) => VisaType.fromJson(e))
          .toList(),
      recommendationMetadata: json['recommendationMetadata'] != null
          ? RecommendationMetadata.fromJson(json['recommendationMetadata'])
          : null,
    );
  }
}

class VisaType {
  String? id;
  String? name;
  String? type;
  String? tag;
  String? description;
  String? duration;
  String? icon;
  List<Requirement>? requirements;
  String? processingTime;
  String? processingInfo;
  List<DelayFactor>? delayFactors;
  List<Timeline>? timeline;

  VisaType({
    this.id,
    this.name,
    this.type,
    this.tag,
    this.description,
    this.duration,
    this.icon,
    this.requirements,
    this.processingTime,
    this.processingInfo,
    this.delayFactors,
    this.timeline,
  });

  factory VisaType.fromJson(Map<String, dynamic> json) {
    return VisaType(
      id: json['_id'],
      name: json['name'],
      type: json['type'],
      tag: json['tag'],
      description: json['description'],
      duration: json['duration'],
      icon: json['icon'],
      requirements: (json['requirements'] as List?)
          ?.map((e) => Requirement.fromJson(e))
          .toList(),
      processingTime: json['processingTime'],
      processingInfo: json['processingInfo'],
      delayFactors: (json['delayFactors'] as List?)
          ?.map((e) => DelayFactor.fromJson(e))
          .toList(),
      timeline: (json['timeline'] as List?)
          ?.map((e) => Timeline.fromJson(e))
          .toList(),
    );
  }
}

class Requirement {
  String? id;
  String? name;
  String? description;
  bool? isMandatory;
  String? icon;

  Requirement({
    this.id,
    this.name,
    this.description,
    this.isMandatory,
    this.icon,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) {
    return Requirement(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      isMandatory: json['isMandatory'],
      icon: json['icon'],
    );
  }
}

class DelayFactor {
  String? id;
  String? title;
  String? description;

  DelayFactor({
    this.id,
    this.title,
    this.description,
  });

  factory DelayFactor.fromJson(Map<String, dynamic> json) {
    return DelayFactor(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
    );
  }
}

class Timeline {
  String? id;
  String? stage;
  String? duration;

  Timeline({
    this.id,
    this.stage,
    this.duration,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) {
    return Timeline(
      id: json['_id'],
      stage: json['stage'],
      duration: json['duration'],
    );
  }
}

class RecommendationMetadata {
  int? score;
  double? likelihood;
  String? confidence;
  bool? englishSpeaking;
  bool? fastTrack;
  String? label;

  RecommendationMetadata({
    this.score,
    this.likelihood,
    this.confidence,
    this.englishSpeaking,
    this.fastTrack,
    this.label,
  });

  factory RecommendationMetadata.fromJson(Map<String, dynamic> json) {
    return RecommendationMetadata(
      score: json['score'],
      likelihood: (json['likelihood'] as num?)?.toDouble(),
      confidence: json['confidence'],
      englishSpeaking: json['englishSpeaking'],
      fastTrack: json['fastTrack'],
      label: json['label'],
    );
  }
}