import 'dart:convert';

class Rate {
  String driverId;
  String feedback;
  String rate;
  Rate({
    this.driverId,
    this.feedback,
    this.rate,
  });

  Map<String, dynamic> toMap() {
    return {
      'driverId': driverId,
      'comment': feedback,
      'rate': rate,
    };
  }

  static Rate fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Rate(
      driverId: map['driverId'],
      feedback: map['comment'],
      rate: map['rate'],
    );
  }

  String toJson() => json.encode(toMap());

  static Rate fromJson(String source) => fromMap(json.decode(source));
}
