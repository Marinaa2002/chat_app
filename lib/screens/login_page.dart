import 'package:chat2_app/screens/login_cubit/login_cubit.dart';
import 'package:chat2_app/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../Constants.dart';
import '../widgets/custom.dart';
import '../widgets/customButton.dart';
import 'chat_cubit/chat_cubit.dart';
import 'chat_page.dart';

class LoginPage extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();

  static String id = 'LoginPage';
  String? email;

  String? password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          //BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        } else if(state is LoginFailure){
          showSnackbar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Form(
            key: formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 75,
                    ),
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scholar Chat',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 75,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is required';
                          } else if (!value.contains('@')) {
                            return 'Formatted Email is required';
                          }
                        },
                        onChanged: (value) {
                          email = value;
                        },
                        hint: 'Email'),
                    CustomTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      hint: 'Password',
                      obsecure: true,
                    ),
                    CustomButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context)
                                .loginUser(email: email!, password: password!);
                          } else {

                          }
                        },
                        buttonName: 'Sign In'),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account? Sign Up',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 75,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
