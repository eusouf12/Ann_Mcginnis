class CountryDetailsResponse {
  int? statusCode;
  CountryDetails? data;
  String? message;
  bool? success;

  CountryDetailsResponse({
    this.statusCode,
    this.data,
    this.message,
    this.success,
  });

  factory CountryDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CountryDetailsResponse(
      statusCode: json['statusCode'],
      data: json['data'] != null ? CountryDetails.fromJson(json['data']) : null,
      message: json['message'],
      success: json['success'],
    );
  }
}

class CountryDetails {
  String? id;
  String? name;
  String? slug;
  String? imageUrl;
  String? description;
  String? population;

  List<String>? officialLanguages;
  List<String>? whyChoose;

  List<VisaType>? visaTypes;
  List<Requirement>? requirements;
  List<DelayFactor>? delayFactors;
  List<Timeline>? timeline;

  String? processingTime;
  String? processingInfo;

  String? createdAt;
  String? updatedAt;

  CountryDetails({
    this.id,
    this.name,
    this.slug,
    this.imageUrl,
    this.description,
    this.population,
    this.officialLanguages,
    this.whyChoose,
    this.visaTypes,
    this.requirements,
    this.delayFactors,
    this.timeline,
    this.processingTime,
    this.processingInfo,
    this.createdAt,
    this.updatedAt,
  });

  factory CountryDetails.fromJson(Map<String, dynamic> json) {
    return CountryDetails(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      population: json['population'],
      officialLanguages: json['officialLanguages'] != null
          ? List<String>.from(json['officialLanguages'])
          : [],
      whyChoose: json['whyChoose'] != null
          ? List<String>.from(json['whyChoose'])
          : [],
      visaTypes: json['visaTypes'] != null
          ? List<VisaType>.from(
          json['visaTypes'].map((x) => VisaType.fromJson(x)))
          : [],
      requirements: json['requirements'] != null
          ? List<Requirement>.from(
          json['requirements'].map((x) => Requirement.fromJson(x)))
          : [],
      delayFactors: json['delayFactors'] != null
          ? List<DelayFactor>.from(
          json['delayFactors'].map((x) => DelayFactor.fromJson(x)))
          : [],
      timeline: json['timeline'] != null
          ? List<Timeline>.from(
          json['timeline'].map((x) => Timeline.fromJson(x)))
          : [],
      processingTime: json['processingTime'],
      processingInfo: json['processingInfo'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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

  VisaType({
    this.id,
    this.name,
    this.type,
    this.tag,
    this.description,
    this.duration,
    this.icon,
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