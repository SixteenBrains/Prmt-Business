import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prmt_admin/models/payment_details.dart';
import '/config/paths.dart';
import '/models/bussiness_user.dart';
import '/models/failure.dart';
import '/repositories/transaction/base_transaction_repo.dart';

class TransactionRepository extends BaseTransactionRepo {
  final FirebaseFirestore _firestore;

  TransactionRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<BussinessUser?>> getBussinessTransactions() async {
    try {
      List<BussinessUser?> users = [];
      final userSnaps = await _firestore.collection(Paths.users).get();

      for (var element in userSnaps.docs) {
        final userDoc = _firestore.collection(Paths.users).doc(element.id);
        final userSnap = await userDoc.get();
        users.add(BussinessUser.fromDocument(userSnap));
      }
      return users;
    } catch (error) {
      print('Error in getting bussiness transactions ${error.toString()}');
      throw const Failure(message: 'Error in getting bussiness users ');
    }
  }

  Future<List<PaymentDetails?>> getUserPaymentsHistory({
    required String? bussinessUserId,
  }) async {
    try {
      final transactionsSnaps = await _firestore
          .collection(Paths.payments)
          .doc(bussinessUserId)
          .collection(Paths.userPayments)
          .get();

      return transactionsSnaps.docs
          .map((doc) => PaymentDetails.fromMap(doc.data()))
          .toList();
    } catch (error) {
      print('Error in getting payment list ${error.toString()}');
      throw const Failure(message: 'Error in getting payment list');
    }
  }
}
