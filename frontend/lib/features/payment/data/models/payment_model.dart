class PaymentModel {
  final String bookingId;
  final double amount;
  final String paymentMethod;
  final String status;

  PaymentModel({
    required this.bookingId,
    required this.amount,
    required this.paymentMethod,
    required this.status,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      bookingId: json["booking"],
      amount: (json["amount"] as num).toDouble(),
      paymentMethod: json["paymentMethod"],
      status: json["status"],
    );
  }
}