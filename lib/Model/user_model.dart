class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: (json['id'] ?? '').toString(),
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    photoUrl: json['photoUrl'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    if (photoUrl != null) 'photoUrl': photoUrl,
  };
}
