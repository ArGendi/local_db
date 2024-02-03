class Contact{
  String? name; // abdo
  String? phone; // 0100365264

  Contact({this.name, this.phone});
  Contact.fromMap(Map map){
    name = map['name'];
    phone = map['phone'];
  }

  Map<String, dynamic> toMap(){
    return {
      "name": name,
      "phone": phone,
    };
  }
}
