import 'package:online_61/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase{
  Future<Database> initDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'abdo.db'),
      version: 1,
      onUpgrade: (db, oldVersion, newVersion) {},
      onCreate: (db, version) {
        db.execute("CREATE TABLE contacts(name TEXT, phone TEXT)");
      },
    );
  }

  void insert(Contact contact) async{
    Database db = await initDB();
    // db.insert('contacts', {
    //   'name': contact.name,
    //   "phone": contact.phone,
    // });
    db.insert('contacts', contact.toMap());

    //db.rawInsert(""); insert by sql
  }

  void delete(String phone) async{
    Database db = await initDB();
    db.delete('contacts', where: "phone = ?" , whereArgs: [phone]);
    //db.rawDelete(sql) delete by sql
  }

  void update(Contact oldContact, Contact newContact) async{
    Database db = await initDB();
    //db.update("contacts", {"name": newContact.name, "phone": newContact.phone}, where: "phone = ?", whereArgs: [oldContact.phone]);
    db.update("contacts", newContact.toMap(), where: "phone = ?", whereArgs: [oldContact.phone]);
  }

  Future<List<Contact>> getContacts() async{
    Database db = await initDB();
    List<Map<String, dynamic>> data = await db.query("contacts");
    List<Contact> contacts = [];
    for(var map in data){
      Contact newContact = Contact.fromMap(map);
      contacts.add(newContact);
    }
    return contacts;
  }
}