import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobpay/Ipg.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/Merchant.dart';
import 'models/Payment.dart';
import 'models/Urls.dart';

class Utils {
  BuildContext context;
  Function(Map<String, dynamic>) transactionSuccessfullCallback;
  Function(Map<String, dynamic>) transactionFailureCallback;

  Utils({
    required this.context,
    required this.transactionSuccessfullCallback,
    required this.transactionFailureCallback,
  });

  late MqttServerClient _mqttClient;

  Future<void> mqttThenLaunch(
      Merchant merchant, Payment payment, Urls urls, String checkoutUrl) async {

    // ✅ WSS only — no TCP
    final wsUrl = 'wss://${urls.mqttBaseUrl}';
    final client = MqttServerClient.withPort(wsUrl, '', urls.mqttPort);
    client.useWebSocket = true;
    client.websocketProtocols = MqttClientConstants.protocolsSingleDefault;
    client.secure = false;
    client.onBadCertificate = (dynamic certificate) => true;

    _mqttClient = client;

    client.keepAlivePeriod = 10;
    client.logging(on: true);
    client.onDisconnected = _onDisconnected;
    client.onSubscribed = _onSubscribed;

    final connMess = MqttConnectMessage()
        .withClientIdentifier(
        DateTime.now().millisecondsSinceEpoch.toString())
        .startClean()
        .withWillTopic('willTopic')
        .withWillMessage('client disconnected')
        .withWillQos(MqttQos.exactlyOnce);
    client.connectionMessage = connMess;

    try {
      await client.connect();
      print('MQTT::CONNECTED');
    } on Exception catch (e) {
      print('MQTT::client exception - $e');
      client.disconnect();
      throw e;
    }

    if (client.connectionStatus!.state != MqttConnectionState.connected) {
      print('MQTT::ERROR connection failed, state is ${client.connectionStatus!.state}');
      client.disconnect();
      throw 'Could not connect to mqtt client';
    }

    final transactionTopic =
        'merchant_portal/${merchant.merchantId}/${payment.transactionReference}';
    client.subscribe(transactionTopic, MqttQos.atMostOnce);

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> msgs) {
      print('MQTT: MESSAGE RECEIVED');
      final MqttPublishMessage receivedMsg =
      msgs[0].payload as MqttPublishMessage;
      final String payload =
      MqttPublishPayload.bytesToStringAsString(receivedMsg.payload.message);

      print('MQTT PAYLOAD:: $payload');

      Map<String, dynamic> mqttPayload = json.decode(payload);

      Future.microtask(() => client.disconnect());

      if (mqttPayload['responseCode'] == '00' ||
          mqttPayload['responseCode'] == '0') {
        transactionSuccessfullCallback(mqttPayload);
      } else {
        transactionFailureCallback(mqttPayload);
      }
    });

    await launchWebView(checkoutUrl, context);
  }

  void _onSubscribed(String topic) {
    print('MQTT::Subscription confirmed for topic $topic');
  }

  void _onDisconnected() {
    Navigator.maybePop(context);
    print('MQTT::OnDisconnected client callback - Client disconnection');
  }

  Future<void> launchWebView(String url, BuildContext context) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewExample(
            url: url,
            transactionSuccessfullCallback: transactionSuccessfullCallback,
            transactionFailureCallback: transactionFailureCallback,
          ),
        ),
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}