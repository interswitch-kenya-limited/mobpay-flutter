class Urls {
  String ipgBaseUrl;
  String mqttBaseUrl;
  int mqttPort;

  Urls({
    required this.ipgBaseUrl,
    required this.mqttBaseUrl,
    this.mqttPort = 8084,
  });
}