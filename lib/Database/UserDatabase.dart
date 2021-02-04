import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class UserDatabase{
  
  var users = FirebaseFirestore.instance.collection('Users');
  
  Future<void> createUserDocument(String uid,String name) async {
    await users.doc(uid).set({
      'Name': name,
      'Timezone': null,
    });
    await users.doc(uid).collection('Schedule').doc('BaseDocument').set({
      'Base' : true,
      'Day': null,
      'Type': null,
      'StartTime': null,
      'EndTime': null,
      'Note': null
    });
  }
}