class User{
  late int key;
  late String email;
  late String password;

  User(this.email, this.password);
  User.fromMap(Map map){
    email = map['email'];
    password = map['password'];
  }
}