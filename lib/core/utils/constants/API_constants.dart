class APIConstants {
  // PAYSTACK TRANSACTION API ENDPOINTS
  static const initializeTransaction =
      "https://api.paystack.co/transaction/initialize";
  static String verifyTransaction(String reference) =>
      "https://api.paystack.co/transaction/verify/$reference";
  static const listTransactions = "https://api.paystack.co/transaction";

  // PAYSTACK CUSTOMERS API ENDPOINTS
  static const createCustomers = "https://api.paystack.co/customer";
  static const listCustomers = "https://api.paystack.co/customer";
  static String retrieveCustomer(String emailOrCode) =>
      "https://api.paystack.co/customer/$emailOrCode";
  static String updateCustomer(String code) =>
      "https://api.paystack.co/customer/$code";

  // default value
  static const String currentCustomer = "createCustomer";
  static const String transaction = "transaction";
}
