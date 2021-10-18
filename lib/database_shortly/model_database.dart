class ShortlyModelDB {
  int? id ;
  String? shortlyLink;
  String? originalLink;

  ShortlyModelDB({this.id,this.shortlyLink, this.originalLink, });

  factory ShortlyModelDB.fromJson(Map<String, dynamic> json) {
    return ShortlyModelDB(
      id: json["id"],
      shortlyLink: json["shortlyLink"],
      originalLink: json["originalLink"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "shortlyLink": this.shortlyLink,
      "originalLink": this.originalLink,
    };
  }
}
