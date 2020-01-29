class UserModel {

  // Field
  
  String id, name, user, password, avatar;


  // Method
  UserModel(this.id, this.name, this.user, this.password, this.avatar);

  UserModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    name = map['Name'];
    user = map['User'];
    password = map['Password'];
    avatar = map['Avatar'];

  }



  
}