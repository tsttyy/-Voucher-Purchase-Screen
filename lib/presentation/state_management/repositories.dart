import '../../core/constants/app_constants.dart';
import '../../data/datasources/voucher_local_datasource.dart';
import '../../data/repositories/voucher_repository_impl.dart';
import '../../domain/repositories/voucher_repository.dart';

/// Simple repository factory
class RepositoryFactory {
  static VoucherRepository? _repository;

  static VoucherRepository getRepository() {
    _repository ??= VoucherRepositoryImpl(
      localDataSource: VoucherLocalDataSourceImpl(
        mockData: AppConstants.mockVoucherJson,
      ),
    );
    return _repository!;
  }

  static void reset() {
    _repository = null;
  }
}

/// Convenience getter for repository
VoucherRepository get voucherRepository => RepositoryFactory.getRepository();
