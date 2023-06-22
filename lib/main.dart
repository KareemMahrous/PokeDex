import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/constants/color_manager.dart';
import 'package:pokemon/constants/fonts.dart';
import 'package:pokemon/constants/navigation_service.dart';
import 'package:pokemon/constants/observer.dart';
import 'package:pokemon/view/components/custom_text.dart';
import 'package:pokemon/view/sceens/auth/ForgotPass.dart';
import 'package:pokemon/view/sceens/home/HomeScreen.dart';
import 'package:pokemon/viewmodel/cubit/Login/login_cubit.dart';
import 'package:pokemon/viewmodel/database/local/cache_helper.dart';
import 'package:pokemon/viewmodel/database/network/dio_helper.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'package:path_provider/path_provider.dart' as path;

import 'view/sceens/auth/LoginScreen.dart';
import 'view/sceens/auth/SignUpScreen.dart';
import 'view/sceens/home/BottomNavBar.dart';
import 'viewmodel/cubit/BottomNavBar/bottomnavbar_cubit.dart';
import 'viewmodel/cubit/Home/home_cubit.dart';
import 'viewmodel/cubit/SignUp/signup_cubit.dart';
import 'viewmodel/database/local/keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();
  final appDocumentDir = await path.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.initFlutter();
  await Hive.openBox("fav");
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCU-cV9YJTDdiMJmtwRT76PAhjVrafblME",
          appId: "1:258444701143:android:e5d53976fb1c58bfee6f92",
          messagingSenderId: "258444701143",
          projectId: "pokemon-c4210"));
  Bloc.observer = MyBlocObserver();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => LoginCubit()),
    BlocProvider(create: (context) => SignupCubit()),
    BlocProvider(create: (context) => HomeCubit()..getallData()),
    BlocProvider(create: (context) => BottomNavBarCubit()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 811),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Pokemon',
            navigatorKey: NavigationService.instance.navigationKey,
            routes: {
              "LoginScreen": (BuildContext context) => LoginScreen(),
              "SignUpScreen": (BuildContext context) => SignUpScreen(),
              "HomeScreen": (BuildContext context) => HomeScreen(),
              "BottomNavBar": (BuildContext context) => const BottomNavBar(),
              "ForgetPasswordScreen": (BuildContext context) =>
                  ForgetPasswordScreen(),
            },
            home: AnimatedSplashScreen(
                duration: 3000,
                splash: const Center(child: CustomText(text: "Welcome to PokeDex",fontSize: textFont42,color: borderColor,)),
                nextScreen: CacheHelper.get(key: Keys.userToken) != null
                    ? const BottomNavBar()
                    : LoginScreen(),
                splashTransition: SplashTransition.fadeTransition,
                pageTransitionType: PageTransitionType.bottomToTop,
                backgroundColor: background)));
  }
}
