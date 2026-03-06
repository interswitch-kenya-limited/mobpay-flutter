import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobpay/mobpay.dart';
import 'package:mobpay/models/Config.dart';
import 'package:mobpay/models/Customer.dart';
import 'package:mobpay/models/Merchant.dart';
import 'package:mobpay/models/Payment.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interswitch IPG Example Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Interswitch IPG Example Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _keyForm = GlobalKey<FormState>();

  final _formKey = GlobalKey<FormState>();
  final _merchantId = TextEditingController(text: "ISWKEN0001");
  final _domainId = TextEditingController(text: "ISWKE");
  final _clientId = TextEditingController(text: "IKIA7C2981C715915A2D9DF952D8422F956BAB4ABB8A");
  final _clientSecret = TextEditingController(text: "2NZ4AlYFzabz6+eTMp9pYJvcgWTLjfYBvsFQFRkfuUc=");
  final _terminalId = TextEditingController(text: "3CRZ0001");
  final _terminalType = TextEditingController(text: "MOBILE");
  final _preAuth = TextEditingController(text: "1");



  final _amount = TextEditingController(text: "100");
  final _transactionRef =
      TextEditingController(text: Random().nextInt(1000).toString());
  final _orderId =
      TextEditingController(text: Random().nextInt(1000).toString());
  final _paymentItem = TextEditingController(text: "CRD");
  final _currencyCode = TextEditingController(text: "USD");
  final _narration = TextEditingController(text: "Buying tings");
  final _pan = TextEditingController(text: "4111111111111111");
  final _cvv = TextEditingController(text: "234");
  final _expiryYear = TextEditingController(text: "23");
  final _expMonth = TextEditingController(text: "02");


  final _customerId = TextEditingController(text: "test@example.com");
  final _firstName = TextEditingController(text: "Jane");
  final _secondName = TextEditingController(text: "Doe");
  final _email = TextEditingController(text: "john.doe@yopmail.com");
  final _mobile = TextEditingController(text: "0700000000");
  final _city = TextEditingController(text: "NBI");
  final _country = TextEditingController(text: "KE");
  final _postalCode = TextEditingController(text: "00200");
  final _street = TextEditingController(text: "Westlands");
  final _state = TextEditingController(text: "NBI");
  late bool _tokenize = true;

  final _iconUrl = TextEditingController(
      text:
          "https://images.pexels.com/photos/104372/pexels-photo-104372.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260");
  final _primaryAccentColor = TextEditingController(text: '#D433FF');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height, // fixed height
                child: Form(
                  key: _keyForm,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      children: [
                        TextFormField(
                          controller: _merchantId,
                          decoration: InputDecoration(
                              hintText: 'Merchant Id',
                              labelText: 'Merchant Id'),
                        ),
                        TextFormField(
                          controller: _domainId,
                          decoration: InputDecoration(
                              hintText: 'Domain Id', labelText: 'Domain Id'),
                        ),
                        //payment details
                        TextFormField(
                          controller: _amount,
                          decoration: InputDecoration(
                              hintText: 'Amount', labelText: 'Amount'),
                        ),
                        TextFormField(
                          controller: _transactionRef,
                          decoration: InputDecoration(
                              hintText: 'Transaction Reference',
                              labelText: 'Transaction Reference'),
                        ),
                        TextFormField(
                          controller: _orderId,
                          decoration: InputDecoration(
                              hintText: 'Order Id', labelText: 'Order Id'),
                        ),

                        TextFormField(
                          controller: _clientId,
                          decoration: InputDecoration(
                              hintText: 'Client Id', labelText: 'Client Id'),
                        ),

                        TextFormField(
                          controller: _clientSecret,
                          decoration: InputDecoration(
                              hintText: 'Client Secret', labelText: 'Client Secret'),
                        ),

                        TextFormField(
                          controller: _pan,
                          decoration: InputDecoration(
                              hintText: 'Pan', labelText: 'Pan'),
                        ),

                        TextFormField(
                          controller: _cvv,
                          decoration: InputDecoration(
                              hintText: 'CVV', labelText: 'CVV'),
                        ),

                        TextFormField(
                          controller: _terminalId,
                          decoration: InputDecoration(
                              hintText: 'Terminal ID', labelText: 'Terminal ID'),
                        ),

                        TextFormField(
                          controller: _terminalType,
                          decoration: InputDecoration(
                              hintText: 'Terminal Type', labelText: 'Terminal Type'),
                        ),

                        TextFormField(
                          controller: _expMonth,
                          decoration: InputDecoration(
                              hintText: 'Exp Month', labelText: 'Exp Month'),
                        ),

                        TextFormField(
                          controller: _expiryYear,
                          decoration: InputDecoration(
                              hintText: 'Expiry Year', labelText: 'Expiry Year'),
                        ),

                        TextFormField(
                          controller: _paymentItem,
                          decoration: InputDecoration(
                              hintText: 'Payment Item',
                              labelText: 'Payment Item'),
                        ),
                        TextFormField(
                          controller: _currencyCode,
                          decoration: InputDecoration(
                              hintText: 'Currency Code',
                              labelText: 'Currency Code'),
                        ),
                        TextFormField(
                          controller: _narration,
                          decoration: InputDecoration(
                              hintText: 'Narration', labelText: 'Narration'),
                        ),
                        // customer details
                        TextFormField(
                          controller: _customerId,
                          decoration: InputDecoration(
                              hintText: 'Customer Id',
                              labelText: 'Customer Id'),
                        ),
                        TextFormField(
                          controller: _firstName,
                          decoration: InputDecoration(
                              hintText: 'First Name', labelText: 'First Name'),
                        ),
                        TextFormField(
                          controller: _secondName,
                          decoration: InputDecoration(
                              hintText: 'Second Name',
                              labelText: 'Second Name'),
                        ),
                        TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                              hintText: 'Email', labelText: 'Email'),
                        ),
                        TextFormField(
                          controller: _mobile,
                          decoration: InputDecoration(
                              hintText: 'Mobile', labelText: 'Mobile'),
                        ),
                        TextFormField(
                          controller: _city,
                          decoration: InputDecoration(
                              hintText: 'City', labelText: 'City'),
                        ),
                        TextFormField(
                          controller: _country,
                          decoration: InputDecoration(
                              hintText: 'Country Code',
                              labelText: 'Country Code'),
                        ),
                        TextFormField(
                          controller: _postalCode,
                          decoration: InputDecoration(
                              hintText: 'Postal Code',
                              labelText: 'Postal Code'),
                        ),
                        TextFormField(
                          controller: _street,
                          decoration: InputDecoration(
                              hintText: 'Street', labelText: 'Street'),
                        ),
                        TextFormField(
                          controller: _state,
                          decoration: InputDecoration(
                              hintText: 'State', labelText: 'State'),
                        ),
                        //config
                        TextFormField(
                          controller: _iconUrl,
                          decoration: InputDecoration(
                              hintText: 'Icon Url', labelText: 'Icon Url'),
                        ),
                        TextFormField(
                          controller: _primaryAccentColor,
                          decoration: InputDecoration(
                              hintText: 'primaryAccentColor',
                              labelText: 'primaryAccentColor'),
                        ),
                        SwitchListTile(
                          title: Text('Tokenize'),
                          value: _tokenize,
                          onChanged: (bool value) {
                            setState(() {
                              _tokenize = value;
                            });
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 50, top: 50),
                          child: ElevatedButton(
                              onPressed: () {
                                Merchant merchant = Merchant(
                                    _merchantId.value.text,
                                    _domainId.value.text);
                                Payment payment = Payment(
                                    int.parse(_amount.value.text),
                                    _transactionRef.value.text,
                                    _orderId.value.text,
                                    _paymentItem.value.text,
                                    _currencyCode.value.text,
                                    _narration.value.text,
                                    _terminalId.value.text,
                                    _terminalType.value.text,
                                    _preAuth.value.text == "1");
                                Customer customer = Customer(
                                    _customerId.value.text,
                                    _firstName.value.text,
                                    _secondName.value.text,
                                    _email.value.text,
                                    _mobile.value.text,
                                    _city.value.text,
                                    _country.value.text,
                                    _postalCode.value.text,
                                    _street.value.text,
                                    _state.value.text);
                                Config config = Config(
                                    iconUrl: _iconUrl.value.text,
                                    primaryAccentColor:
                                        _primaryAccentColor.value.text);
                                Mobpay mobpay =
                                    new Mobpay(merchant: merchant, live: true);
                                mobpay.pay(
                                    payment: payment,
                                    customer: customer,
                                    transactionSuccessfullCallback:
                                        transactionSuccessfullCallback,
                                    transactionFailureCallback:
                                        transactionFailureCallback,
                                    config: config,
                                    context: context);
                              },
                              child: Text("Pay")),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(""),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void transactionSuccessfullCallback(payload) {
    Clipboard.setData(ClipboardData(text: payload.toString()));
    final snackBar = SnackBar(
      content: Text("transaction success" + payload.toString()),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void transactionFailureCallback(payload) {
    {
      final snackBar = SnackBar(
        content: Text("transaction failure" + payload.toString()),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
