enum UserType {
  Unknown,
}
Map<String, UserType> mapUserType = {
  "Unknown": UserType.Unknown,
};

Map<UserType, String> userTypeMap = {
  UserType.Unknown: "Unknown",
};

class User {
  final String uid;
  final UserType role;
  final String name;
  final String photoUrl;
  final String email;
  final String phoneNumber;
  final bool registrationComplete;

  User({
    this.uid,
    this.role = UserType.Unknown,
    this.name,
    this.email,
    this.phoneNumber,
    this.registrationComplete = false,
    this.photoUrl,
  });

  bool get hasRole => this.role != UserType.Unknown;

  static fromJSON(Map<String, dynamic> json, String id) {
    var role = json['role'] as String;
    var properties = json['properties'];
    List<String> propertyRefs = List();
    if (properties != null) {
      for (String string in properties) {
        propertyRefs.add(string);
      }
    }
    return User(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: mapUserType[role],
      phoneNumber: json['phoneNumber'] as String,
      registrationComplete: json['registrationComplete'] as bool,
      photoUrl: json['photoUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'role': userTypeMap[role],
        'phoneNumber': phoneNumber,
        'registrationComplete': registrationComplete,
        'photoUrl': photoUrl,
      };
}
