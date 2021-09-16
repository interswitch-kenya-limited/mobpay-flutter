import 'dart:convert';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/Merchant.dart';
import 'models/Payment.dart';
import 'models/Urls.dart';

class Utils {
  void mqtt(
      Merchant merchant,
      Payment payment,
      Urls urls,
      Function(Map<String, dynamic>) transactionSuccessfullCallback,
      Function(Map<String, dynamic>) transactionFailureCallback) async {
    final client = MqttServerClient(urls.mqttBaseUrl, '');
    client.keepAlivePeriod = 10;
    client.logging(on: true);
    client.onDisconnected = _onDisconnected;
    client.onSubscribed = _onSubscribed;
    final connMess = MqttConnectMessage()
        .withClientIdentifier(
            new DateTime.now().millisecondsSinceEpoch.toString())
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMess;
    try {
      await client.connect();
    } on Exception catch (e) {
      print('MQTT::client exception - $e');
      client.disconnect();
      throw e;
    }

    /// Check we are connected
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
    } else {
      print(
          'MQTT::ERROR Mosquitto client connection failed - disconnecting, state is ${client.connectionStatus!.state}');
      //throw error failed to connect to mqtt
      client.disconnect();
      throw 'Could not connect to mqtt client';
    }

    client.published!.listen((MqttPublishMessage message) {
      print("MQTT: MESSAGE RECEIVED");
      Map<String, dynamic> mqttPayload = json.decode(
          MqttPublishPayload.bytesToStringAsString(message.payload.message));
      client.disconnect();
      if (mqttPayload['responseCode'] == "00" ||
          mqttPayload['responseCode'] == "0") {
        transactionSuccessfullCallback(mqttPayload);
      } else {
        transactionFailureCallback(mqttPayload);
      }
    });
    var transactionTopic = "merchant_portal/" +
        merchant.merchantId +
        "/" +
        payment.transactionReference;
    client.subscribe(transactionTopic, MqttQos.atMostOnce);
  }

  void _onSubscribed(String topic) {
    print('MQTT::Subscription confirmed for topic $topic');
  }

  void _onDisconnected() {
    closeWebView();
    print('MQTT::OnDisconnected client callback - Client disconnection');
  }

  ///URL LAUNCHER UTIL
  ///
  /// start using chrome tabs if possible
  ///
  Future<void> launchWebView(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
