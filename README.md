# MobPay - A Flutter library for integrating card and mobile payments through Interswitch

Focus on running your business and spend less time reconciling payments. Quickteller Business unifies payments from different channels (Card, Mobile Money and through pesalink) all in one payments platform that grows with you. With Quickteller Business, you’ll never worry about payments again.

## Supported Features

#### Pay with Mobile money

- Mpesa
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
Merchant merchant = Merchant("ISWKEN0001", "ISWKE");
```

### Payment Details

Create an instance of the Payment class with the following items:

- #### Amount
  The amount would be sent to us in the double currency format. i.e you will have to multiply the amount by 100. An example is if the value of an apple fruit is 99.90 (Ninety nine Shillings and ninety cents) you will have to send it to us as 9990
- #### Order Id
  Merchant's orderId for the payment item, similar to receipt number, duplicates allowed.
- #### Transaction Reference
  A unique identifier of the transaction on the merchant's side – maximum 15 characters, duplicates will be rejected.
- #### Payment Item
- #### Currency Code
  The ISO currency code e.g. KES
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
  The customer's id from the merchant's point of view e.g. email, phone, or database/registration id.
- #### First Name
  Customer's first name
- #### Second Name
  Customer's second name
- #### Email
  Customer's email
- #### Mobile
  Customer's mobile
- #### City
  Customer's city
- #### Country
  Customer's country
- #### Postal Code
  Customer's postal code
- #### Street
  Customer's street
- #### State
  Customer's state

```dart
Customer customer =  Customer(
"1",
"John",
"Doe",
"someone@yopmail.com",
"0700000000",
"NBI",
"KE",
"00100",
'KIBIKO',
"KAJIADO");
```

### Extra Configuration

In order to change a few elements in the UI we have an object for that (Config)
The items that we allow extra configuration for are:

- Logo on the top left

In order to change the logo on the top left

- Create a instance of the config class
- Pass the logo url (HTTPS) as the parameter

Below is an example

```dart
Config config =  Config(

iconUrl:

"https://images.pexels.com/photos/104372/pexels-photo-104372.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",


// the primary accent color should be a hex value
primaryAccentColor: '#D433FF');


```

### Mobpay Instance

Create a mobpay instance and pass the merchant details and also whether you are on live or not

```dart
Mobpay mobpay =  new  Mobpay(merchant, false);
```

### Transaction Success And Failure Callbacks

For both success and failure you will have to pass the functions and example is as below:

Transaction Success Example:

```dart
void  transactionSuccessCallback(payload) {
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

Transaction Failure Example:

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

transactionSuccessfulCallback:

transactionSuccessCallback,

transactionFailureCallback:

transactionFailureCallback,

config: config,

context: context);
```

## Source code

Visit [the Github repository](https://github.com/interswitch-kenya-limited/mobpay-flutter) to get the source code and releases of this project if you want to try a manual integration process that does not make use of gradle.

## Frequently Asked Questions

On  android 7 and above please add the following to your AndroidManifest.xml

```xml
<queries>
        <intent>
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.BROWSABLE" />
            <data android:scheme="https" />
        </intent>
    </queries>
```
