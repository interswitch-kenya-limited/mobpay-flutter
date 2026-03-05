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
import 'package:flutter/material.dart';

class Mobpay {
  Merchant merchant;
  bool live;

  Urls urls = Urls(
      ipgBaseUrl: "https://gatewaybackend-uat.quickteller.co.ke",
      mqttBaseUrl: 'testmerchant.interswitch-ke.com/mqtt',
      mqttPort: 8084); // ✅ test

  Mobpay({required this.merchant, required this.live}) {
    this.live = live;
    this.merchant = merchant;
    if (live) {
      urls = Urls(
          ipgBaseUrl: "https://gatewaybackend.quickteller.co.ke",
          mqttBaseUrl: 'merchant.interswitch-ke.com/mqtt',
          mqttPort: 8083); // ✅ production
    }
  }

  Future<void> pay({
    required Payment payment,
    required Customer customer,
    required Function(Map<String, dynamic>) transactionSuccessfullCallback,
    required Function(Map<String, dynamic>) transactionFailureCallback,
    required BuildContext context,
    Config? config,
  }) async {
    try {
      Utils utils = Utils(
          context: context,
          transactionFailureCallback: transactionFailureCallback,
          transactionSuccessfullCallback: transactionSuccessfullCallback);

      TransactionPayload transactionPayload =
      TransactionPayload.compact(this.merchant, payment, customer, config);

      final formDataClient = RestClient(
          Dio(BaseOptions(
            followRedirects: false,
            validateStatus: (status) => status! < 400,
          )),
          baseUrl: urls.ipgBaseUrl);

      var checkout = await formDataClient.postCheckout(transactionPayload);
      final checkoutUrl =
      checkout.response.headers.value('location').toString();

      await utils.mqttThenLaunch(this.merchant, payment, urls, checkoutUrl);
    } catch (e) {
      throw e;
    }
  }
}