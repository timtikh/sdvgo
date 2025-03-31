import 'package:bloc/bloc.dart';

import 'user_info.dart';

class UserInfoCubit extends Cubit<UserInfo> {
  UserInfoCubit({
    required String uid,
    required String email,
  }) : super(UserInfo(
          uid: uid,
          email: email,
        ));

  // AuthRepository authRepository = AuthRepositoryImpl();

  void setUid(String newUid) => emit(state.copyWith(uid: newUid));

  void setEmail(String newEmail) => emit(state.copyWith(email: newEmail));
}
