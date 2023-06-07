class TokenEntity {
  String name;
  String avatarUrl;
  String sub;
  int iat;
  int exp;

  TokenEntity(
      {required this.name,
      required this.avatarUrl,
      required this.sub,
      required this.iat,
      required this.exp});

  factory TokenEntity.fromMap(Map<String, dynamic> json) {
    return TokenEntity(
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      sub: json['sub'],
      iat: json['iat'],
      exp: json['exp'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['avatarUrl'] = avatarUrl;
    data['sub'] = sub;
    data['iat'] = iat;
    data['exp'] = exp;
    return data;
  }
}
