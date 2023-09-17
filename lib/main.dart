import 'package:chat2_app/screens/chat_cubit/chat_cubit.dart';
import 'package:chat2_app/screens/chat_page.dart';
import 'package:chat2_app/screens/login_cubit/login_cubit.dart';
import 'package:chat2_app/screens/login_page.dart';
import 'package:chat2_app/screens/register_cubit/register_cubit.dart';
import 'package:chat2_app/screens/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) => RegisterCubit(),),
        BlocProvider(create: (context) => ChatCubit(),),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            LoginPage.id: (context) => LoginPage(),
            RegisterPage.id: (context) => RegisterPage(),
            ChatPage.id: (context) => ChatPage(),
          },
          initialRoute: LoginPage.id,

      ),
    );
  }
}
