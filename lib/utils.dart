import 'dart:convert';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/Merchant.dart';
import 'models/Payment.dart';

class Utils {
  void mqtt(
      Merchant merchant,
      Payment payment,
      Function(Map<String, dynamic>) transactionSuccessfullCallback,
      Function(Map<String, dynamic>) transactionFailureCallback) async {
    final client = MqttServerClient('testmerchant.interswitch-ke.com', '');
    client.logging(on: false);
    client.onDisconnected = _onDisconnected;
    client.onSubscribed = _onSubscribed;
    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueIdQ1')
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('MQTT::Mosquitto client connecting....');
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
      print('MQTT::Mosquitto client connected');
    } else {
      print(
          'MQTT::ERROR Mosquitto client connection failed - disconnecting, state is ${client.connectionStatus!.state}');
      //throw error failed to connect to mqtt
      client.disconnect();
    }

    client.published!.listen((MqttPublishMessage message) {
      print("MQTT: MESSAGE RECEIVED");
      print(MqttPublishPayload.bytesToStringAsString(message.payload.message!));
      Map<String, dynamic> mqttPayload = json.decode(
          MqttPublishPayload.bytesToStringAsString(message.payload.message!));
      client.disconnect();
      closeWebView();
      if (mqttPayload.containsKey('error')) {
        transactionFailureCallback(mqttPayload);
      } else {
        transactionSuccessfullCallback(mqttPayload);
      }
    });
    var transactionTopic = "merchant_portal/" +
        merchant.merchantId +
        "/" +
        payment.transactionReference;
    client.subscribe(transactionTopic, MqttQos.atMostOnce);
  }

  /// The subscribed callback
  ///
  /// make this private
  void _onSubscribed(String topic) {
    print('MQTT::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  ///
  /// make this private
  void _onDisconnected() {
    //read about dart error handling
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
