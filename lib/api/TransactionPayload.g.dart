// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TransactionPayload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionPayload _$TransactionPayloadFromJson(Map<String, dynamic> json) {
  return TransactionPayload(
    merchantCode: json['merchantCode'] as String?,
    domain: json['domain'] as String?,
    transactionReference: json['transactionReference'] as String?,
    orderId: json['orderId'] as String?,
    expiryTime: json['expiryTime'] as String?,
    currencyCode: json['currencyCode'] as String?,
    amount: json['amount'] as int?,
    narration: json['narration'] as String?,
    redirectUrl: json['redirectUrl'] as String?,
    iconUrl: json['iconUrl'] as String?,
    primaryAccentColor: json['primaryAccentColor'] as String?,
    merchantName: json['merchantName'] as String?,
    providerIconUrl: json['providerIconUrl'] as String?,
    cardTokensJson: json['cardTokensJson'] as String?,
    reqId: json['reqId'] as String?,
    field1: json['field1'] as String?,
    preauth: json['preauth'] as int?,
    customerId: json['customerId'] as String?,
    customerFirstName: json['customerFirstName'] as String?,
    customerSecondName: json['customerSecondName'] as String?,
    customerEmail: json['customerEmail'] as String?,
    customerMobile: json['customerMobile'] as String?,
    customerCity: json['customerCity'] as String?,
    customerCountry: json['customerCountry'] as String?,
    customerPostalCode: json['customerPostalCode'] as String?,
    customerStreet: json['customerStreet'] as String?,
    customerState: json['customerState'] as String?,
  )
    ..dateOfPayment = json['dateOfPayment'] as String
    ..terminalId = json['terminalId'] as String?
    ..terminalType = json['terminalType'] as String?
    ..channel = json['channel'] as String?
    ..redirectMerchantName = json['redirectMerchantName'] as String?
    ..fee = json['fee'] as int?;
}

Map<String, dynamic> _$TransactionPayloadToJson(TransactionPayload instance) =>
    <String, dynamic>{
      'merchantCode': instance.merchantCode,
      'domain': instance.domain,
      'transactionReference': instance.transactionReference,
      'orderId': instance.orderId,
      'expiryTime': instance.expiryTime,
      'currencyCode': instance.currencyCode,
      'amount': instance.amount,
      'narration': instance.narration,
      'redirectUrl': instance.redirectUrl,
      'iconUrl': instance.iconUrl,
      'primaryAccentColor': instance.primaryAccentColor,
      'merchantName': instance.merchantName,
      'providerIconUrl': instance.providerIconUrl,
      'cardTokensJson': instance.cardTokensJson,
      'reqId': instance.reqId,
      'field1': instance.field1,
      'dateOfPayment': instance.dateOfPayment,
      'terminalId': instance.terminalId,
      'terminalType': instance.terminalType,
      'channel': instance.channel,
      'redirectMerchantName': instance.redirectMerchantName,
      'fee': instance.fee,
      'preauth': instance.preauth,
      'customerId': instance.customerId,
      'customerFirstName': instance.customerFirstName,
      'customerSecondName': instance.customerSecondName,
      'customerEmail': instance.customerEmail,
      'customerMobile': instance.customerMobile,
      'customerCity': instance.customerCity,
      'customerCountry': instance.customerCountry,
      'customerPostalCode': instance.customerPostalCode,
      'customerStreet': instance.customerStreet,
      'customerState': instance.customerState,
    };
