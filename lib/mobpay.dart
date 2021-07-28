library mobpay;

import 'package:dio/dio.dart';
import 'package:mobpay/di/RestClient.dart';
import 'package:mobpay/models/Config.dart';
import 'package:mobpay/models/Urls.dart';
import 'package:mobpay/utils.dart';

import 'api/TransactionPayload.dart';
import 'models/Customer.dart';
import 'models/Merchant.dart';
import 'models/Payment.dart';

class Mobpay {
  Merchant merchant;
  bool live;
  Urls urls = Urls(
      ipgBaseUrl: "https://gatewaybackend-uat.quickteller.co.ke",
      mqttBaseUrl: 'testmerchant.interswitch-ke.com');
  Mobpay({required this.merchant, required this.live}) {
    this.live = live;
    this.merchant = merchant;
    if (live) {
      Urls urls = Urls(
          ipgBaseUrl: "https://gatewaybackend.quickteller.co.ke",
          mqttBaseUrl: 'merchant.interswitch-ke.com');
      this.urls = urls;
    }
  }
  Future<void> pay(
      {required Payment payment,
      required Customer customer,
      required Function(Map<String, dynamic>) transactionSuccessfullCallback,
      required Function(Map<String, dynamic>) transactionFailureCallback,
      Config? config}) async {
    try {
      Utils utils = Utils();
      //pass both transaction sucess and failure here
      utils.mqtt(this.merchant, payment, urls, transactionSuccessfullCallback,
          transactionFailureCallback);
      TransactionPayload transactionPayload =
          TransactionPayload.compact(this.merchant, payment, customer, config);
      final formDataClient = RestClient(
          Dio(BaseOptions(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 400;
            },
          )),
          baseUrl: urls.ipgBaseUrl);
      var checkout = await formDataClient.postCheckout(transactionPayload);
      utils.launchWebView(
          checkout.response.headers.value('location').toString());
    } catch (e) {
      throw e;
    }
  }
}
