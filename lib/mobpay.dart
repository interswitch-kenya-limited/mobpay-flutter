library mobpay;

import 'package:dio/dio.dart';
import 'package:mobpay/di/RestClient.dart';
import 'package:mobpay/models/Config.dart';
import 'package:mobpay/utils.dart';

import 'api/TransactionPayload.dart';
import 'models/Customer.dart';
import 'models/Merchant.dart';
import 'models/Payment.dart';

class Mobpay {
  Merchant merchant;
  bool live;
  Mobpay(this.merchant, this.live);
  Future<void> pay(
      {required Payment payment,
      required Customer customer,
      required Function(Map<String, dynamic>) transactionSuccessfullCallback,
      required Function(Map<String, dynamic>) transactionFailureCallback,
      Config? config}) async {
    try {
      Utils utils = Utils();
      //pass both transaction sucess and failure here
      utils.mqtt(this.merchant, payment, transactionSuccessfullCallback,
          transactionFailureCallback);
      TransactionPayload transactionPayload =
          TransactionPayload.compact(this.merchant, payment, customer, config);
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
