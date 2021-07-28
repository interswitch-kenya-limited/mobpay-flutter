import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobpay/mobpay.dart';
import 'package:mobpay/models/Config.dart';
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
  final _keyForm = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _password = TextEditingController();
  final _email = TextEditingController();
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
                        ExpansionPanelList(
                          expansionCallback: (int index, bool isExpanded) {},
                          children: [
                            ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text('Merchant Details'),
                                );
                              },
                              body: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ListTile(
                                    title: Text('Merchant Id '),
                                    subtitle: TextFormField(
                                      controller: _name,
                                      decoration: InputDecoration(
                                          hintText: 'Merchant Id'),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text('Domain Id'),
                                    subtitle: TextFormField(
                                      controller: _name,
                                      decoration: InputDecoration(
                                          hintText: 'Insert your name.'),
                                    ),
                                  )
                                ],
                              ),
                              isExpanded: false,
                            ),
                            ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text('Payment Details'),
                                );
                              },
                              body: ListTile(
                                title: Text('Item 2 child'),
                                subtitle: Text('Details goes here'),
                              ),
                              isExpanded: false,
                            ),
                            ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text('Customer Details'),
                                );
                              },
                              body: ListTile(
                                title: Text('Item 2 child'),
                                subtitle: Text('Details goes here'),
                              ),
                              isExpanded: false,
                            ),
                            ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text('Config Details'),
                                );
                              },
                              body: ListTile(
                                title: Text('Item 2 child'),
                                subtitle: Text('Details goes here'),
                              ),
                              isExpanded: false,
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Merchant merchant =
                                  Merchant("ISWKEN0001", "ISKWE");
                              Payment payment = Payment(
                                  100,
                                  Random().nextInt(1000).toString(),
                                  Random().nextInt(1000000).toString(),
                                  "food",
                                  "KES",
                                  "Buying tings");
                              Customer customer = Customer(
                                  "1",
                                  "Allan",
                                  "Mageto",
                                  "allan.mageto@yopmail.com",
                                  "0700000000",
                                  "NBI",
                                  "KEN",
                                  "00100",
                                  'KIBIKO',
                                  "KAJIADO");
                              Config config = Config(
                                  iconUrl:
                                      "https://images.pexels.com/photos/104372/pexels-photo-104372.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                                  primaryAccentColor: '#D433FF');
                              Mobpay mobpay =
                                  new Mobpay(merchant: merchant, live: false);
                              mobpay.pay(
                                  payment: payment,
                                  customer: customer,
                                  transactionSuccessfullCallback:
                                      transactionSuccessfullCallback,
                                  transactionFailureCallback:
                                      transactionFailureCallback,
                                  config: config);
                            },
                            child: Text("Pay")),
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
    final snackBar = SnackBar(
      content: Text("transaction success" + payload.toString()),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
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

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
