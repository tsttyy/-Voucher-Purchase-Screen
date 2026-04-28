import '../entities/voucher.dart';

/// Abstract repository interface following clean architecture
/// Defines the contract for voucher data operations
abstract class VoucherRepository {
  /// Fetches voucher details
  /// Throws exception if operation fails
  Future<Voucher> getVoucher();
}
