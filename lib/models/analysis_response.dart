import 'dart:convert';

class AnalysisResponse {
  Meta meta;
  Data data;

  AnalysisResponse({
    required this.meta,
    required this.data,
  });

  AnalysisResponse copyWith({
    Meta? meta,
    Data? data,
  }) =>
      AnalysisResponse(
        meta: meta ?? this.meta,
        data: data ?? this.data,
      );

  factory AnalysisResponse.fromRawJson(String str) => AnalysisResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnalysisResponse.fromJson(Map<String, dynamic> json) => AnalysisResponse(
        meta: Meta.fromJson(json["meta"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  Attributes attributes;
  String type;
  String id;
  Links links;

  Data({
    required this.attributes,
    required this.type,
    required this.id,
    required this.links,
  });

  Data copyWith({
    Attributes? attributes,
    String? type,
    String? id,
    Links? links,
  }) =>
      Data(
        attributes: attributes ?? this.attributes,
        type: type ?? this.type,
        id: id ?? this.id,
        links: links ?? this.links,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        attributes: Attributes.fromJson(json["attributes"]),
        type: json["type"],
        id: json["id"],
        links: Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "attributes": attributes.toJson(),
        "type": type,
        "id": id,
        "links": links.toJson(),
      };
}

class Attributes {
  int date;
  String status;
  Stats stats;
  Map<String, Result> results;

  Attributes({
    required this.date,
    required this.status,
    required this.stats,
    required this.results,
  });

  Attributes copyWith({
    int? date,
    String? status,
    Stats? stats,
    Map<String, Result>? results,
  }) =>
      Attributes(
        date: date ?? this.date,
        status: status ?? this.status,
        stats: stats ?? this.stats,
        results: results ?? this.results,
      );

  factory Attributes.fromRawJson(String str) => Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        date: json["date"],
        status: json["status"],
        stats: Stats.fromJson(json["stats"]),
        results: Map.from(json["results"]).map((k, v) => MapEntry<String, Result>(k, Result.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "status": status,
        "stats": stats.toJson(),
        "results": Map.from(results).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Result {
  Category category;
  String engineName;
  String? engineVersion;
  dynamic result;
  Method method;
  String? engineUpdate;

  Result({
    required this.category,
    required this.engineName,
    required this.engineVersion,
    required this.result,
    required this.method,
    required this.engineUpdate,
  });

  Result copyWith({
    Category? category,
    String? engineName,
    String? engineVersion,
    dynamic result,
    Method? method,
    String? engineUpdate,
  }) =>
      Result(
        category: category ?? this.category,
        engineName: engineName ?? this.engineName,
        engineVersion: engineVersion ?? this.engineVersion,
        result: result ?? this.result,
        method: method ?? this.method,
        engineUpdate: engineUpdate ?? this.engineUpdate,
      );

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        category: categoryValues.map[json["category"]]!,
        engineName: json["engine_name"],
        engineVersion: json["engine_version"],
        result: json["result"],
        method: methodValues.map[json["method"]]!,
        engineUpdate: json["engine_update"],
      );

  Map<String, dynamic> toJson() => {
        "category": categoryValues.reverse[category],
        "engine_name": engineName,
        "engine_version": engineVersion,
        "result": result,
        "method": methodValues.reverse[method],
        "engine_update": engineUpdate,
      };
}

enum Category { FAILURE, TIMEOUT, TYPE_UNSUPPORTED, UNDETECTED }

final categoryValues = EnumValues(
    {"failure": Category.FAILURE, "timeout": Category.TIMEOUT, "type-unsupported": Category.TYPE_UNSUPPORTED, "undetected": Category.UNDETECTED});

enum Method { BLACKLIST }

final methodValues = EnumValues({"blacklist": Method.BLACKLIST});

class Stats {
  int harmless;
  int typeUnsupported;
  int suspicious;
  int confirmedTimeout;
  int timeout;
  int failure;
  int malicious;
  int undetected;

  Stats({
    required this.harmless,
    required this.typeUnsupported,
    required this.suspicious,
    required this.confirmedTimeout,
    required this.timeout,
    required this.failure,
    required this.malicious,
    required this.undetected,
  });

  Stats copyWith({
    int? harmless,
    int? typeUnsupported,
    int? suspicious,
    int? confirmedTimeout,
    int? timeout,
    int? failure,
    int? malicious,
    int? undetected,
  }) =>
      Stats(
        harmless: harmless ?? this.harmless,
        typeUnsupported: typeUnsupported ?? this.typeUnsupported,
        suspicious: suspicious ?? this.suspicious,
        confirmedTimeout: confirmedTimeout ?? this.confirmedTimeout,
        timeout: timeout ?? this.timeout,
        failure: failure ?? this.failure,
        malicious: malicious ?? this.malicious,
        undetected: undetected ?? this.undetected,
      );

  factory Stats.fromRawJson(String str) => Stats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        harmless: json["harmless"],
        typeUnsupported: json["type-unsupported"],
        suspicious: json["suspicious"],
        confirmedTimeout: json["confirmed-timeout"],
        timeout: json["timeout"],
        failure: json["failure"],
        malicious: json["malicious"],
        undetected: json["undetected"],
      );

  Map<String, dynamic> toJson() => {
        "harmless": harmless,
        "type-unsupported": typeUnsupported,
        "suspicious": suspicious,
        "confirmed-timeout": confirmedTimeout,
        "timeout": timeout,
        "failure": failure,
        "malicious": malicious,
        "undetected": undetected,
      };
}

class Links {
  String item;
  String self;

  Links({
    required this.item,
    required this.self,
  });

  Links copyWith({
    String? item,
    String? self,
  }) =>
      Links(
        item: item ?? this.item,
        self: self ?? this.self,
      );

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        item: json["item"],
        self: json["self"],
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "self": self,
      };
}

class Meta {
  FileInfo fileInfo;

  Meta({
    required this.fileInfo,
  });

  Meta copyWith({
    FileInfo? fileInfo,
  }) =>
      Meta(
        fileInfo: fileInfo ?? this.fileInfo,
      );

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        fileInfo: FileInfo.fromJson(json["file_info"]),
      );

  Map<String, dynamic> toJson() => {
        "file_info": fileInfo.toJson(),
      };
}

class FileInfo {
  String sha256;
  String sha1;
  String md5;
  int size;

  FileInfo({
    required this.sha256,
    required this.sha1,
    required this.md5,
    required this.size,
  });

  FileInfo copyWith({
    String? sha256,
    String? sha1,
    String? md5,
    int? size,
  }) =>
      FileInfo(
        sha256: sha256 ?? this.sha256,
        sha1: sha1 ?? this.sha1,
        md5: md5 ?? this.md5,
        size: size ?? this.size,
      );

  factory FileInfo.fromRawJson(String str) => FileInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FileInfo.fromJson(Map<String, dynamic> json) => FileInfo(
        sha256: json["sha256"],
        sha1: json["sha1"],
        md5: json["md5"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "sha256": sha256,
        "sha1": sha1,
        "md5": md5,
        "size": size,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
