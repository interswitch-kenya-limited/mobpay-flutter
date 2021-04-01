// import 'package:dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mobpay/api/TransactionPayload.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'RestClient.g.dart';

@RestApi(baseUrl: "https://gatewaybackend-uat.quickteller.co.ke")
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST("/ipg-backend/api/checkout")
  @FormUrlEncoded()
  Future<HttpResponse> postCheckout(
      @Body() TransactionPayload transactionPayload);
}
