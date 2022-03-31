import 'package:cloud_firestore/cloud_firestore.dart';
import '/config/paths.dart';
import '/models/appuser.dart';
import '/models/contact_us.dart';
import '/models/failure.dart';

class FirebaseServices {
  final CollectionReference _contact =
      FirebaseFirestore.instance.collection('contacts');

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendContactUsInformation(ContactUs contactUs) async {
    try {
      await _contact.add(contactUs.toMap());
    } catch (error) {
      print('Error sending contact us information ${error.toString()}');
      throw const Failure(message: 'Something went wrong');
    }
  }

  Future<List<AppUser?>> getUsers() async {
    try {
      final userSnaps = await _firestore.collection(Paths.users).get();
      return userSnaps.docs.map((doc) => AppUser.fromDocument(doc)).toList();
    } catch (error) {
      print('Error in gettings users ${error.toString()}');
      throw const Failure(message: 'Error in getting users');
    }
  }
}
