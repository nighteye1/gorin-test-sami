class AppUser {
  String uid;
  String name;
  String email;
  String? imageUrl;

  AppUser({
    required this.email,
    required this.name,
    this.imageUrl,
    required this.uid,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      email: json['email'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'uid': uid,
    };
  }
}
