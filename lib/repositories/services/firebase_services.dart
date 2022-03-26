import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/contact_us.dart';
import '/models/failure.dart';

class FirebaseServices {
  final CollectionReference _contact =
      FirebaseFirestore.instance.collection('contacts');

  Future<void> sendContactUsInformation(ContactUs contactUs) async {
    try {
      await _contact.add(contactUs.toMap());
    } catch (error) {
      print('Error sending contact us information ${error.toString()}');
      throw const Failure(message: 'Something went wrong');
    }
  }
}
