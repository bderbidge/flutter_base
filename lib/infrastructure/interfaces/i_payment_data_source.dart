abstract class IPaymentDataSource {
  Future<String> createVerifiedCustomer(
      Map<String, dynamic> data, String authToken);
  Future<String> createUnverifiedCustomer(
      Map<String, dynamic> data, String authToken);
  Future<String> verifyMicroDeposit(
      Map<String, dynamic> data, String authToken);
  Future<Map<String, dynamic>> addFundingSource(
      Map<String, dynamic> data, String authToken);
  Future<String> payRentTransaction(
      Map<String, dynamic> data, String authToken);
}
