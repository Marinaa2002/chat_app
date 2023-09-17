import 'package:chat2_app/screens/chat_page.dart';
import 'package:chat2_app/screens/register_cubit/register_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Constants.dart';
import '../widgets/custom.dart';
import '../widgets/customButton.dart';

class RegisterPage extends StatelessWidget {
  static String id = 'RegisterPage';
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        } else if (state is RegisterFailure) {
          showSnackbar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                              'Sign Up',
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
                          onChanged: (data) {
                            email = data;
                          },
                          hint: 'Email'),
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is required';
                          } else if (value.characters.length < 8) {
                            return 'Password more than 8 is required';
                          }
                        },
                        onChanged: (data) {
                          password = data;
                        },
                        hint: 'Password',
                        obsecure: true,
                      ),
                      CustomButton(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<RegisterCubit>(context)
                                  .registerUser(
                                      email: email!, password: password!);
                            } else {

                            }
                          },
                          buttonName: 'Sign Up'),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account? Sign In',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
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
        );
      },
    );
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

}
