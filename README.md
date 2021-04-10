# MobPay - A Flutter library for integrating card and mobile payments through Interswitch

Focus on running your business and spend less time reconciling payments. Quickteller Business unifies payments from different channels (Card, Mobile Money and through pesalink) all in one payments platform that grows with you. With Quickteller Business, you’ll never worry about payments again.

## Supported Features
#### Pay with Mobile money
-  Mpesa
- T-Kash
#### Pay with Card
- Verve
- Mastercard
- Visa

#### Pay with Bank
#### Pay with Pesalink


## Usage
### Merchant Details

You will have to create an instance of the Merchant class with the following details: 
- Merchant Id 
- Domain Id
```dart
Merchant merchant = Merchant("ISWKEN0001", "ISKWE");
```

### Payment Details

Create an instance of the Payment class with the follwing items: 
- #### Amount
The amount would be sent to us in the double currency format. i.e you will have to multiply the amount by 100. An example is if the value of an apple fruit is 99.90 (Ninenty nine Shillings and ninety cents) you will have to send it to us as 9990
- #### Order Id
- #### Transaction Reference
- #### Payment Item
- #### Currency Code
- #### Narration
```dart
Payment payment = Payment( 100,
Random().nextInt(1000).toString(),
Random().nextInt(1000).toString(),
"food",
"KES",
"Buying food Items");
```

### Customer Details
- #### id
- #### First Name
- #### Second Name
- #### Email
- #### Mobile
- #### City
- #### Country
- #### Postal Code
- #### Street
- #### State


```dart
Customer customer =  Customer(
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
```
### Extra Configuration
In order to change a few elements in the UI we have an object for that  (Config)
The items that we allow extra configuration for are: 
- Logo on the top left 

In order to change the logo on the top left 
- Create a instance of the config class 
-  Pass the logo url (HTTPS) as the parameter 

Below is an example

```dart
Config config =  Config(

iconUrl:

"https://images.pexels.com/photos/104372/pexels-photo-104372.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260");
```

### Mobpay Instance
Create a mobpay instance and pass the merchant details and also whether you are on live or not

```dart
Mobpay mobpay =  new  Mobpay(merchant, false);
```

### Transaction Success And Failure Callbacks
For both success and failure you will have to pass the functions and example is as below: 

Transaction Success or Failure Example: 
```dart
void  transactionFailureCallback(payload) {
	{
		final snackBar =  SnackBar(
		content:  Text(payload.toString()),
		action:  SnackBarAction(
		label:  'Undo',
		onPressed: () {
		// Some code to undo the change.
		},),);
		// Find the ScaffoldMessenger in the widget tree
		// and use it to show a SnackBar.
		ScaffoldMessenger.of(context).showSnackBar(snackBar);
		}
	}
``` 
### Pay
To pay call the pay function as follows: 
```dart
mobpay.pay(

payment: payment,

customer: customer,

transactionSuccessfullCallback:

transactionFailureCallback,

transactionFailureCallback:

transactionFailureCallback,

config: config);
```
## Source code

Visit  [the Github repository](https://github.com/interswitch-kenya-limited/mobpay-flutter)  to get the source code and releases of this project if you want to try a manual integration process that does not make use of gradle.