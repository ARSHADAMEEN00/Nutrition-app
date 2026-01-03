import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers.dart';
import '../../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthService(apiClient);
});

// For now, let's keep it simple. We will build the AuthStateNotifier when we build the UI.
