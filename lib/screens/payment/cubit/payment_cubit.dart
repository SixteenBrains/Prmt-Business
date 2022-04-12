import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:prmt_business/models/payment_details.dart';
import '/enums/card_brand.dart';
import '/models/save_card.dart';
import '/repositories/payment/payment_repository.dart';
import '/enums/enums.dart';
import '/models/ad_model.dart';
import '/utils/media_util.dart';
import '/blocs/auth/auth_bloc.dart';
import '/models/failure.dart';
import '/repositories/ad/ad_repository.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final AdRepository _adRepository;
  final AuthBloc _authBloc;
  //final AdModel? _ad;
  final PaymentRepository _paymentRepository;

  PaymentCubit({
    required AdRepository adRepository,
    required AuthBloc authBloc,
    required AdModel? ad,
    required PaymentRepository paymentRepository,
  })  : _adRepository = adRepository,
        _authBloc = authBloc,

        ///  _ad = ad,
        _paymentRepository = paymentRepository,
        super(PaymentState.initial());

  void publishAd({required AdModel? ad}) async {
    try {
      emit(state.copyWith(status: PaymentStatus.loading));

      String? mediaUrl;
      if (_authBloc.state.user?.uid != null && ad?.mediaFile != null) {
        mediaUrl = await MediaUtil.uploadAdMedia(
          childName: ad?.adType == MediaType.image ? 'images' : 'videos',
          file: ad!.mediaFile!,
          uid: _authBloc.state.user!.uid!,
        );
      }

      final adId = await _adRepository.publishAd(
          ad: ad?.copyWith(mediaUrl: mediaUrl),
          userId: _authBloc.state.user?.uid);

      final paymentDetails = PaymentDetails(
        adId: adId,
        createdAt: DateTime.now(),
        amount: ad?.budget != null ? int.tryParse(ad!.budget!) : null,
      );

      // TODO: monitor this
      await _paymentRepository.addPaymentDetails(
          userId: _authBloc.state.user?.uid, details: paymentDetails);

      emit(state.copyWith(status: PaymentStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(status: PaymentStatus.error, failure: failure));
    }
  }

  void cardNoChanged(String? value) async {
    emit(state.copyWith(cardNo: value, status: PaymentStatus.initial));
  }

  void expMonthChanged(String? value) async {
    emit(state.copyWith(expMonth: value, status: PaymentStatus.initial));
  }

  void expYearChanged(String? value) async {
    emit(state.copyWith(expYear: value, status: PaymentStatus.initial));
  }

  void cvvChanged(String? value) {
    emit(state.copyWith(cvv: value, status: PaymentStatus.initial));
  }

  void cardBrandChanged(String? value) {
    //emit(state.copyWith(cvv: value));
  }

  void isCardValidChanged(bool? value) {
    //emit(state.copyWith(cvv: value));
    emit(state.copyWith(isCardValid: value, status: PaymentStatus.initial));
  }

  void updatePayment({required PaymentStatus status}) async {
    emit(state.copyWith(status: status));
  }

  void throwPaymentError(String? errorMsg) {
    emit(state.copyWith(
        status: PaymentStatus.error, failure: Failure(message: errorMsg)));
  }

  void cardPayment({
    required double price,
    required PaymentMethod paymentMethod,
  }) async {
    try {
      emit(state.copyWith(status: PaymentStatus.loading));

      final result = await _paymentRepository.cardPayment(
            price: price,
            paymentMethod: paymentMethod,
          ) ??
          false;
      print('Payment result $result');
      if (result) {
        emit(state.copyWith(status: PaymentStatus.paymentSuccuss));
      } else {
        // emit(state.copyWith(
        //     status: PaymentStatus.error,
        //     failure: const Failure(message: 'Something went wrong')));
      }
    } on Failure catch (failure) {
      print('fatilre -- $failure');
      emit(state.copyWith(status: PaymentStatus.error, failure: failure));
    }
  }

  void saveCard() async {
    try {
      emit(state.copyWith(status: PaymentStatus.loading));
      await _paymentRepository.saveCard(
        userId: _authBloc.state.user?.uid,
        card: SaveCard(
          cardBrand: state.cardBrand,
          cardNo: state.cardNo,
          cvv: state.cvv,
          expMon: state.expMonth,
          expYear: state.expYear,
        ),
      );
      emit(state.copyWith(status: PaymentStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(status: PaymentStatus.error, failure: failure));
    }
  }

  void buyWithGooglePay(paymentResult) async {
    try {
      await _paymentRepository.buyWithGooglePay(paymentResult);
    } catch (error) {
      print('Google pay cubit catch error ${error.toString()}');
    }
  }
}
