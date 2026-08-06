class PaymentService {

  Future<bool> makePayment() async {

    await Future.delayed(
      const Duration(seconds: 2),
    );

    return true;
  }

}