class UserModel {
  final int? id;
  final String nama;
  final String username;
  final String password;
  final String role;

  UserModel({
    this.id,
    required this.nama,
    required this.username,
    required this.password,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      nama: json['nama']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
      role: json['role']?.toString().toLowerCase() ?? 'user',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'nama': nama,
      'username': username,
      'password': password,
      'role': role,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }

  UserModel copyWith({
    int? id,
    String? nama,
    String? username,
    String? password,
    String? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }
}

