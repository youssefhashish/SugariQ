class User {
  String image;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String aboutMeDescription;

  User({
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.aboutMeDescription,
  });

  User copy({
    String? imagePath,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? about,
  }) =>
      User(
        image: imagePath ?? this.image,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        aboutMeDescription: about ?? this.aboutMeDescription,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        image: json['imagePath'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        aboutMeDescription: json['about'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': image,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'about': aboutMeDescription,
      };
}
