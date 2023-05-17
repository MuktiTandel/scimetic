class CreateUserModel {

   String firstName;
   String lastName;
   String email;
   String password;

   CreateUserModel({
     required this.firstName,
     required this.lastName,
     required this.email,
     required this.password,
  });

   factory CreateUserModel.fromJson(Map<String, dynamic> json) {
     return CreateUserModel(
         firstName: json["firstName"] ?? "",
         lastName: json["lastName"] ?? "",
         email: json["email"] ?? "",
         password: json["password"] ?? "",
     );
   }

   Map<String, dynamic> toJson() {
     return {
       "firstName" : firstName,
       "lastName" : lastName,
       "email" : email,
       "password" : password,
     };
   }
}