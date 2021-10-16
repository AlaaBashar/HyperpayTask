class ShortlyModel {
  bool ok;
  Result result;

  ShortlyModel({required this.ok, required this.result});

  factory ShortlyModel.fromJson(Map<String, dynamic> json) {
    return ShortlyModel(
      ok: json["ok"],
      result: Result.fromJson(json["result"]),
    );
  }
}

class Result {
  String code;
  String shortLink;
  String fullShortLink;
  String shortLink2;
  String fullShortLink2;
  String shortLink3;
  String fullShortLink3;
  String shareLink;
  String fullShareLink;
  String originalLink;

  Result(
      {required this.code,
      required this.shortLink,
      required this.fullShortLink,
      required this.shortLink2,
      required this.fullShortLink2,
      required this.shortLink3,
      required this.fullShortLink3,
      required this.shareLink,
      required this.fullShareLink,
      required this.originalLink});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      code: json["code"],
      shortLink: json["shortLink"],
      fullShortLink: json["fullShortLink"],
      shortLink2: json["shortLink2"],
      fullShortLink2: json["fullShortLink2"],
      shortLink3: json["shortLink3"],
      fullShortLink3: json["fullShortLink3"],
      shareLink: json["shareLink"],
      fullShareLink: json["fullShareLink"],
      originalLink: json["originalLink"],
    );
  }
}
