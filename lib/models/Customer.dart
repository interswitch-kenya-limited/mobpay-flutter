library com.interswitchgroup.mobpaylib.model;

class Customer {
  String id;
  String firstName;
  String secondName;
  String email;
  String mobile;
  String city;
  String country;
  String postalCode;
  String street;
  String state;
  Customer(this.id, this.firstName, this.secondName, this.email, this.mobile,
      this.city, this.country, this.postalCode, this.street, this.state) {
    this.id = id;
    this.firstName = firstName;
    this.secondName = secondName;
    this.email = email;
    this.mobile = mobile;
    this.city = city;
    this.country = country;
    this.postalCode = postalCode;
    this.street = street;
    this.state = state;
  }
}
