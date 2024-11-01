import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/model/adminmodel.dart';
import 'package:smp/modules/root/homelayoutscreen.dart';
import 'package:smp/shared/components/componentts.dart';
import 'package:smp/shared/components/constant.dart';
import 'package:smp/shared/cubit/authcubit/authstates.dart';
import 'package:smp/shared/network/local/sharedpreference/sharedpreference.dart';
import 'package:smp/shared/style/styles.dart';
import 'package:smp/theme.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(LoginInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  //Vars

  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();

  IconData prefix = Icons.visibility_off_outlined;
  bool obscureText = true;
  void changeEye() {
    obscureText = !obscureText;
    prefix = !obscureText
        ? prefix = Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangeEyePassword());
  }

  // id = json['id'];
  // name = json['name'];
  // email = json['email'];
  // image = json['image'];
  // admin = json['admin'];

  ////Create Admin
  bool toggle = false;

  void switchToggle(bool value) {
    toggle = value;
    emit(SwitchToggleState());
  }

  var createAdminEmailController = TextEditingController();
  var createAdminNameController = TextEditingController();
  var createAdminPasswordController = TextEditingController();

  void userCreate({
    required String email,
    required String image,
    required String name,
    required bool admin,
    required String id,
  }) {
    emit(UserCreateLoadingState());
    UserData model = UserData(
      id: id,
      email: email,
      image: image,
      name: name,
      admin: admin,
    );

    FirebaseFirestore.instance
        .collection((toggle == true) ? 'admins' : 'users')
        .doc(id)
        .set(model.toMap())
        .then((value) {
      showToast(state: ToastStates.SUCCESS, text: 'تم تسجيل العميل بنجاح');

      if (kDebugMode) {
        print('creatsucc');
      }
      emit(UserCreateSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(UserCreateErrorState());
    });
  }

  void userLogin(
    context, {
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (builder) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [shadow()],
                        borderRadius: BorderRadius.circular(borderRadiusSize),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Your email isn't verified",
                                style: greetingTextStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  vertical: 10, horizontal: 80),
                              child: InkWell(
                                onTap: () async {
                                  FirebaseAuth.instance.currentUser
                                      ?.sendEmailVerification()
                                      .then((value) {
                                    showToast(
                                        state: ToastStates.SUCCESS,
                                        text: 'check your mail');
                                  }).catchError((error) {});
                                },
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: darkBlue300,
                                      borderRadius: BorderRadius.circular(28)),
                                  child: Center(
                                    child: Text(
                                      'verified',
                                      style: titleTextStyle.apply(
                                        color: colorWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              );
            });
      } else {
        print(value.user?.uid.toString());
        CacheHelper.saveData(key: 'uID', value: value.user?.uid).then((sa) {
          uID = CacheHelper.get(key: 'uID');
          emit(LoginSuccessState());
          showToast(state: ToastStates.SUCCESS, text: 'succ');
          navigateAndFinish(context, const HomeLayoutScreen());
        });
      }
    }).catchError((error) {
      showToast(state: ToastStates.ERROR, text: error.toString());

      if (kDebugMode) {
        print(error.toString());
      }
      emit(LoginErrorState(error.toString()));
    });
  }

  void userRegister({
    required String name,
    required String password,
    required String email,
    required String image,
    required bool admin,
  }) async {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.setLanguageCode('ar');
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('succc');

      userCreate(
          email: email,
          image: image,
          name: name,
          admin: admin,
          id: value.user!.uid);
      emit(RegisterSuccessState());
    }).catchError((error) {
      (error.toString() ==
              '[firebase_auth/email-already-in-use] The email address is already in use by another account.')
          ? showToast(
              state: ToastStates.ERROR, text: 'هذا الايميل ممرتبط بحساب اخر')
          : showToast(state: ToastStates.ERROR, text: error.toString());

      emit(RegisterErrorState(error));
    });
  }
}
