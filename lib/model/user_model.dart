class User {
  late String firstName;
  late String lastName;
  late String email;
  late String phone;
  late String dateOfBirth;
  late String passportCode;
  late String nationality;
  late String state;
  late String city;
  late String time;

  User(
      {firstName,
      lastName,
      email,
      phone,
      dateOfBirth,
      passportCode,
      nationality,
      state,
      city,
      time});
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'dateOfBirth': dateOfBirth,
        'passportCode': passportCode,
        'nationality': nationality,
        'state': state,
        'city': city,
        'time': time,
      };
}
