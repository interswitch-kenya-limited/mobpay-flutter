import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobpay/mobpay.dart';
import 'package:mobpay/models/Customer.dart';
import 'package:mobpay/models/Merchant.dart';
import 'package:mobpay/models/Payment.dart';

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
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () async {
                    Mobpay mobpay = new Mobpay();
                    Merchant merchant = Merchant("BMATKE0001", "ISKWE");
                    Payment payment = Payment(
                        100,
                        Random().nextInt(1000).toString(),
                        Random().nextInt(1000).toString(),
                        "food",
                        "KES",
                        "Buying tings");
                    Customer customer = Customer(
                        "1",
                        "Allan",
                        "Mageto",
                        "allan.mageto@yopmail.com",
                        "0713805241",
                        "NBI",
                        "KEN",
                        "00100",
                        'KIBIKO',
                        "KAJIADO");
                    mobpay.pay(
                        merchant,
                        payment,
                        customer,
                        transactionSuccessfullCallback,
                        transactionFailureCallback);
                    print("hello");
                  },
                  child: Text("Pay"))
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void transactionSuccessfullCallback(int) {
    print(int);
  }

  void transactionFailureCallback(int) {
    print(int);
  }
}
