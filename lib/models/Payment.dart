class Payment {
  int amount;
  String transactionReference;
  String orderId;
  String paymentItem;
  String currencyCode;
  bool preauth = false;
  String narration;

  String? terminalType;
  String? terminalId;

  Payment(this.amount, this.transactionReference, this.orderId,
      this.paymentItem, this.currencyCode, this.narration);

  int getPreauth() {
    if (this.preauth) {
      return 1;
    } else {
      return 0;
    }
  }
}
