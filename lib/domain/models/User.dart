class User {
  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.password,
    required this.birthDate,
    required this.degree,
    required this.school,
    this.level,
  });

  User.defaultUser()
      : id = null,
        firstName = '',
        lastName = '',
        email = '',
        password = null,
        birthDate = '',
        degree = '',
        school = '',
        level = null;

  int? id;
  String firstName;
  String lastName;
  String email;
  String? password;
  String birthDate;
  String degree;
  String school;
  int? level;

  // String get name => '$firstName $lastName';

  // String get emailAddress => email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"] ?? "somefirstName",
        lastName: json["lastName"] ?? "someLastName",
        email: json["email"] ?? "someemail",
        password: json["password"],
        birthDate: json["birthDate"],
        degree: json["degree"],
        school: json["school"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "birthDate": birthDate,
        "degree": degree,
        "school": school,
        "level": level,
      };
}
