import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_fb_june_ndz/src/cubit/authentication/authentication_repository.dart';
import 'package:task_fb_june_ndz/src/helpers/storage_helper.dart';
import 'package:task_fb_june_ndz/src/helpers/storage_keys.dart';
import 'package:task_fb_june_ndz/src/models/user_model.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {

  AuthenticationRepository _repository = AuthenticationRepository();

  AuthenticationCubit() : super(AuthenticationInitial());

  Future<void> createUser(UserModel userModel) async {
    emit(AuthenticationLoading());
    try{
      UserCredential user = await _repository.createUser(userModel.email, userModel.password??"");
      String? token = await user.user?.getIdToken();
      String? uid =  user.user?.uid; // UserId from firebase
      StorageHelper.writeData(StorageKeys.token.name, token??"");
      StorageHelper.writeData(StorageKeys.uid.name, uid??"");
      userModel.id = uid;
      await _repository.storeUserData(userModel);
      emit(AuthenticationSuccess());
    }catch(ex){
      emit(AuthenticationFailure());
    }
  }

  loginUser(String email,String password) async{
    emit(AuthenticationLoading());
    try{
      UserCredential user = await _repository.loginUser(email,password);
      String? token = await user.user?.getIdToken();
      String? uid =  user.user?.uid; // UserId from firebase
      StorageHelper.writeData(StorageKeys.token.name, token??"");
      StorageHelper.writeData(StorageKeys.uid.name, uid??"");
      // Store in the local storage
      emit(AuthenticationSuccess());
    }catch(ex){
      emit(AuthenticationFailure());
    }

  }

}
