import 'dart:convert';

class UploadResponse {
  Data data;

  UploadResponse({
    required this.data,
  });

  UploadResponse copyWith({
    Data? data,
  }) =>
      UploadResponse(
        data: data ?? this.data,
      );

  factory UploadResponse.fromRawJson(String str) => UploadResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UploadResponse.fromJson(Map<String, dynamic> json) => UploadResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  String type;
  String id;
  Links links;

  Data({
    required this.type,
    required this.id,
    required this.links,
  });

  Data copyWith({
    String? type,
    String? id,
    Links? links,
  }) =>
      Data(
        type: type ?? this.type,
        id: id ?? this.id,
        links: links ?? this.links,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        id: json["id"],
        links: Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "links": links.toJson(),
      };
}

class Links {
  String self;

  Links({
    required this.self,
  });

  Links copyWith({
    String? self,
  }) =>
      Links(
        self: self ?? this.self,
      );

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
      };
}
