import '../../data/datasources/voucher_local_datasource.dart';
import '../../data/repositories/voucher_repository_impl.dart';
import '../../domain/repositories/voucher_repository.dart';
import 'voucher_service.dart';

/// Simple dependency injection container
class DependencyInjection {
  static VoucherService? _voucherService;
  
  static VoucherService get voucherService {
    _voucherService ??= VoucherService(_createRepository());
    return _voucherService!;
  }
  
  static VoucherRepository _createRepository() {
    final dataSource = VoucherLocalDataSourceImpl(
      mockData: VoucherLocalDataSourceImpl.defaultMockData,
    );
    return VoucherRepositoryImpl(localDataSource: dataSource);
  }
  
  static void reset() {
    _voucherService = null;
  }
}
