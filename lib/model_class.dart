class UserData {
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String countryCode;
  final String phoneNumber;
  final bool isUser;
  final bool isSeller;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.countryCode,
    required this.phoneNumber,
    required this.isUser,
    required this.isSeller,
  });

  // Copy constructor
  UserData copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? gender,
    String? countryCode,
    String? phoneNumber,
    bool? isUser,
    bool? isSeller,
  }) {
    return UserData(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      countryCode: countryCode ?? this.countryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isUser: isUser ?? this.isUser,
      isSeller: isSeller ?? this.isSeller,
    );
  }

  // Convert a UserData object into a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'country_code': countryCode,
      'phone_number': phoneNumber,
      'is_user': isUser ? 1 : 0,
      'is_seller': isSeller ? 1 : 0,
    };
  }

  // Create a UserData object from a map
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      gender: map['gender'],
      countryCode: map['country_code'],
      phoneNumber: map['phone_number'],
      isUser: map['is_user'] == 1,
      isSeller: map['is_seller'] == 1,
    );
  }
}
