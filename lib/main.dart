import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/modules/login/login.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cachehelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget? widget;

  uId = CacheHelper.getData('uId');

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = LoginScreen();
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.startWidget});

  final Widget? startWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()..getUserData(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                  size: 25),
                titleTextStyle: TextStyle(color: Colors.black),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                elevation: 20,
                backgroundColor: Colors.white
              ),
              primarySwatch: Colors.blue,
            ),
            home: startWidget,
          );
        },
      ),
    );
  }
}
