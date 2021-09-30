import 'package:json_annotation/json_annotation.dart';
import 'package:mobpay/models/Config.dart';
import 'package:mobpay/models/Customer.dart';
import 'package:mobpay/models/Merchant.dart';
import 'package:mobpay/models/Payment.dart';

part 'TransactionPayload.g.dart';

@JsonSerializable()
class TransactionPayload {
  String? merchantCode;
  String? domain;
  String? transactionReference;
  String? orderId;
  String? expiryTime;
  String? currencyCode;
  int? amount;
  String? narration;
  String? redirectUrl = "https://uat.quickteller.co.ke/";
  String? iconUrl;
  String? primaryAccentColor;
  String? merchantName;
  String? providerIconUrl;
  String? cardTokensJson; //TODO
  String? reqId;
  String? field1;
  String dateOfPayment = DateTime.now().toString();
  String? terminalId = "3TLP0001";
  String? terminalType = "Flutter";
  String? channel = "MOBILE";
  String? redirectMerchantName = "application";
  int? fee = 0;
  int? preauth;
  String? customerId;
  String? customerFirstName;
  String? customerSecondName;
  String? customerEmail;
  String? customerMobile;
  String? customerCity;
  String? customerCountry;
  String? customerPostalCode;
  String? customerStreet;
  String? customerState;

  TransactionPayload(
      {this.merchantCode,
      this.domain,
      this.transactionReference,
      this.orderId,
      this.expiryTime,
      this.currencyCode,
      this.amount,
      this.narration,
      this.redirectUrl,
      this.iconUrl,
      this.primaryAccentColor,
      this.merchantName,
      this.providerIconUrl,
      this.cardTokensJson,
      this.reqId,
      this.field1,
      this.preauth,
      this.customerId,
      this.customerFirstName,
      this.customerSecondName,
      this.customerEmail,
      this.customerMobile,
      this.customerCity,
      this.customerCountry,
      this.customerPostalCode,
      this.customerStreet,
      this.customerState});

  TransactionPayload.compact(
      Merchant merchant, Payment payment, Customer customer, Config? config) {
    this.merchantCode = merchant.merchantId;
    this.domain = merchant.domain;
    this.transactionReference = payment.transactionReference;
    this.orderId = payment.orderId;
    this.currencyCode = payment.currencyCode;
    this.amount = payment.amount;
    this.narration = payment.narration;
    this.preauth = payment.getPreauth();
    // CONFIG DETAILS
    if (config != null) {
      this.providerIconUrl = config.providerIconUrl ??= null;
      this.iconUrl = config.iconUrl ??= null;
      this.primaryAccentColor = config.primaryAccentColor ??= null;
    }
    //CUSTOMER DETAILS
    this.customerId = customer.id;
    this.customerFirstName = customer.firstName;
    this.customerSecondName = customer.secondName;
    this.customerEmail = customer.email;
    this.customerMobile = customer.mobile;
    this.customerCity = customer.city;
    this.customerCountry = customer.country;
    this.customerPostalCode = customer.postalCode;
    this.customerStreet = customer.street;
    this.customerState = customer.state;
  }

  factory TransactionPayload.fromJson(Map<String, dynamic> json) =>
      _$TransactionPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionPayloadToJson(this);
}
