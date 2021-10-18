class ShortlyModel {
  bool ok;
  ShortlyResult result;

  ShortlyModel({required this.ok, required this.result});

  factory ShortlyModel.fromJson(Map<String, dynamic> json) {
    return ShortlyModel(
      ok: json["ok"],
      result: ShortlyResult.fromJson(json["result"]),
    );
  }
}

class ShortlyResult {
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

  ShortlyResult(
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

  factory ShortlyResult.fromJson(Map<String, dynamic> json) {
    return ShortlyResult(
      code: json["code"],
      shortLink: json["short_link"],
      fullShortLink: json["full_short_link"],
      shortLink2: json["short_link2"],
      fullShortLink2: json["full_short_link2"],
      shortLink3: json["short_link3"],
      fullShortLink3: json["full_short_link3"],
      shareLink: json["share_link"],
      fullShareLink: json["full_share_link"],
      originalLink: json["original_link"],
    );
  }
}
