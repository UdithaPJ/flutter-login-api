import 'dart:convert';

Users usersFromMap(String str) => Users.fromMap(json.decode(str));

String usersToMap(Users data) => json.encode(data.toMap());

class Users {
  final String userCode;
  final String userDisplayName;
  final String email;
  final String userEmployeeCode;
  final String companyCode;
  final List<dynamic> userLocations;
  final List<dynamic> userPermissions;

  Users({
    required this.userCode,
    required this.userDisplayName,
    required this.email,
    required this.userEmployeeCode,
    required this.companyCode,
    required this.userLocations,
    required this.userPermissions,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        userCode: json["User_Code"],
        userDisplayName: json["User_Display_Name"],
        email: json["Email"],
        userEmployeeCode: json["User_Employee_Code"],
        companyCode: json["Company_Code"],
        // If the element in the list of the json response is a String, then add it to the list in the user model
        userLocations: (json["User_Locations"] as List<dynamic>?)
                ?.map((x) {
                  if (x is String) {
                    return x;
                  }
                })
        // Else return an empty list as the default value
                .whereType<String>()
                .toList() ??
            [],
        userPermissions: (json["User_Permissions"] as List<dynamic>?)
                ?.map((x) {
                  if (x is String) {
                    return x;
                  }
                })
                .whereType<String>()
                .toList() ??
            [],
      );

  Map<String, dynamic> toMap() => {
        "User_Code": userCode,
        "User_Display_Name": userDisplayName,
        "Email": email,
        "User_Employee_Code": userEmployeeCode,
        "Company_Code": companyCode,
        "User_Locations": List<dynamic>.from(userLocations.map((x) => x)),
        "User_Permissions": List<dynamic>.from(userPermissions.map((x) => x)),
      };
}
