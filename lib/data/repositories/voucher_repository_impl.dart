import '../../domain/entities/voucher.dart';
import '../../domain/repositories/voucher_repository.dart';
import '../datasources/voucher_local_datasource.dart';

/// Implementation of VoucherRepository
/// Bridges domain layer with data layer
class VoucherRepositoryImpl implements VoucherRepository {
  final VoucherLocalDataSource localDataSource;

  VoucherRepositoryImpl({required this.localDataSource});

  @override
  Future<Voucher> getVoucher() async {
    return await localDataSource.getVoucher('default');
  }
}
