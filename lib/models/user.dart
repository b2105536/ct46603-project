class User {
  final String id;
  final String name;
  final String mobile;
  final String peradd;
  final String? temadd;
  final String avatar;
  final bool gender;
  final DateTime? dob;
  final bool role;

  User({
    required this.id,
    this.name = '',
    required this.mobile,
    this.peradd = '',
    this.temadd,
    this.avatar = '',
    this.gender = false,
    this.dob,
    this.role = false,
  });

  User copyWith({
    String? id,
    String? name,
    String? mobile,
    String? peradd,
    String? temadd,
    String? avatar,
    bool? gender,
    DateTime? dob,
    bool? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      peradd: peradd ?? this.peradd,
      temadd: temadd ?? this.temadd,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'name': name,
      'dob': dob,
      'temadd': temadd,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? '',
      mobile: json['mobile'],
      peradd: json['peradd'] ?? '',
      temadd: json['temadd'],
      avatar: json['avatar'] ?? '',
      gender: json['gender'] ?? false,
      dob: json['dob'] != null ? DateTime.tryParse(json['dob']) : null,
      role: json['role'] ?? false,
    );
  }
}
