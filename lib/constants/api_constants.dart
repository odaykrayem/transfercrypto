class ApiConstants {
  static const baseUrl = "https://cryptoadmin.transfercrypto.online/api/";
  static const imageUrl = "https://cryptoadmin.transfercrypto.online/storage/";

  // static const baseUrl = "http://192.168.1.110:8000/api/";
  // static const imageUrl = "http://192.168.1.110:8000/storage/";

  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String updatePass = "auth/update_pass";
  static const String requestOTP = "auth/request_otp";
  static const String verifyOTP = "auth/verify_otp";

  static const String adminValues = "auth/admin_values";
  static const String getTransferMethodsValuesList =
      "auth/transfer_methods_values";

  static const String USER_INFO_URI = "v1/user_info";

  static const String transactionsList = "v1/transactions_list";
  static const String addTransaction = "v1/add_transaction";

  static const String walletToCashList = "v1/wallet_to_cash_list";
  static const String addWalletToCash = "v1/add_wallet_to_cash";

  static const String cashToWalletList = "v1/cash_to_wallet_list";
  static const String addCashToWallet = "v1/add_cash_to_wallet";

  static const String walletToWalletList = "v1/wallet_to_wallet_list";
  static const String addWalletToWallet = "v1/add_wallet_to_wallet";
}
