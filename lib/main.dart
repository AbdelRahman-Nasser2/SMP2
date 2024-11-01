import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/firebase_options.dart';
import 'package:smp/modules/login_screen/login_screen.dart';
import 'package:smp/modules/onboarding_view.dart';
import 'package:smp/modules/root/homelayoutscreen.dart';
import 'package:smp/shared/components/constant.dart';
import 'package:smp/shared/cubit/appcubit/appcubit.dart';
import 'package:smp/shared/cubit/appcubit/appstates.dart';
import 'package:smp/shared/cubit/authcubit/authcubit.dart';
import 'package:smp/shared/network/local/sharedpreference/sharedpreference.dart';
import 'package:smp/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  // token = CacheHelper.get(key: "token");
//sxdas
  skipOnBoarding = CacheHelper.get(key: "skipOnBoarding") ?? false;
  uID = CacheHelper.get(key: 'uID');
  // uID = 'Icz5q9ViKtdR5Dudkn8r2LzE54d2';
  if (kDebugMode) {
    print(skipOnBoarding);
  }
  print(uID);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Widget widget;
  if (uID != null) {
    widget = const HomeLayoutScreen();
  } else {
    if (skipOnBoarding != true) {
      widget = const OnboardingView();
    } else {
      widget = const LoginScreen();
    }
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  // final bool skipOnBoarding;
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => AppCubit()..getUserData(),
          ),
          BlocProvider(
            create: (BuildContext context) => AuthCubit(),
          )
        ],
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (BuildContext context, AppStates state) {},
            builder: (BuildContext context, AppStates state) {
              AppCubit cubit = AppCubit.get(context);
              return MaterialApp(
                title: 'Spod',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primaryColor: primaryColor500,
                  useMaterial3: false,
                ),
                // home: const CreateCustomer(),
                // home: LoginScreen(),
                home: startWidget,

                // (uID   = null!)
                //     ? HomeLayoutScreen(
                //         currentScreen: 1,
                //       )
                //     : (skipOnBoarding = false)
                //         ? OnboardingView()
                //         : LoginScreen(),
              );
            }));
  }
}
