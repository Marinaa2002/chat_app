import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser({required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    emit(RegisterLoading());
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure('The account already exists for that email.'));
      }
    } on Exception catch (e) {
      emit(RegisterFailure('Something went wrong ....'));
    }
  }

}
