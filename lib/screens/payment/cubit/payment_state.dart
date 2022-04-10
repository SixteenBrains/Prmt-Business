part of 'payment_cubit.dart';

enum PaymentStatus { initial, loading, succuss, error, paymentSuccuss }

class PaymentState extends Equatable {
  final PaymentStatus status;
  final Failure failure;
  final String cardNo;
  final String cvv;
  final String? expMonth;
  final String? expYear;
  final CardBrand? cardBrand;
  final bool isCardValid;

  const PaymentState({
    required this.status,
    required this.failure,
    this.expMonth,
    this.cardNo = '',
    this.cvv = '',
    this.expYear,
    this.cardBrand,
    this.isCardValid = false,
  });

  // bool isCardEmpty() =>
  //     cardNo.isEmpty && cardNo.isEmpty && expMonth != null && expYear != null;

  @override
  List<Object?> get props =>
      [status, failure, expMonth, cardNo, cvv, expYear, cardBrand, isCardValid];

  factory PaymentState.initial() =>
      const PaymentState(status: PaymentStatus.initial, failure: Failure());

  PaymentState copyWith({
    PaymentStatus? status,
    Failure? failure,
    String? cardNo,
    String? cvv,
    String? expMonth,
    String? expYear,
    CardBrand? cardBrand,
    bool? isCardValid,
  }) {
    return PaymentState(
        status: status ?? this.status,
        failure: failure ?? this.failure,
        cardNo: cardNo ?? this.cardNo,
        cvv: cvv ?? this.cvv,
        expMonth: expMonth ?? this.expMonth,
        expYear: expYear ?? this.expYear,
        cardBrand: cardBrand ?? this.cardBrand,
        isCardValid: isCardValid ?? this.isCardValid);
  }

  @override
  String toString() =>
      'PaymentState(status: $status, failure: $failure, cardNo: $cardNo, cvv: $cvv, expMonth: $expMonth, expYear: $expYear, cardBrand $cardBrand, isCardValid $isCardValid)';
}
