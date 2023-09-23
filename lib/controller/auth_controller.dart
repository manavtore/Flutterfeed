import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfeed/features/auth/auth_repository.dart';

final AuthControllerProvider = Provider(
    (ref) => AuthController(authRepository: ref.read(authRepositoryProvider)));

class AuthController {
  final Authrepository _authRepository;

  AuthController({required Authrepository authRepository})
      : _authRepository = authRepository;

  void signinWithGoogle() {
    _authRepository.signinwithgoogle();
  }
}
