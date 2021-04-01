library mobpay;

import 'package:dio/dio.dart';
import 'package:mobpay/di/RestClient.dart';
import 'package:mobpay/utils.dart';

import 'api/TransactionPayload.dart';
import 'models/Customer.dart';
import 'models/Merchant.dart';
import 'models/Payment.dart';

class Mobpay {
  // Merchant? merchant;
  bool live = false;
  //create factory with merchant details
  Future<void> pay(
      Merchant merchant,
      Payment payment,
      Customer customer,
      Function(int) transactionSuccessfullCallback,
      Function(int) transactionFailureCallback) async {
    try {
      Utils utils = Utils();
      //pass both transaction sucess and failure here
      utils.mqtt(merchant, payment);
      TransactionPayload transactionPayload =
          TransactionPayload.meh(merchant, payment, customer, null);
      final formDataClient = RestClient(Dio(BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 400;
        },
      )));
      var checkout = await formDataClient.postCheckout(transactionPayload);

      utils.launchWebView(
          checkout.response.headers.value('location').toString());
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
