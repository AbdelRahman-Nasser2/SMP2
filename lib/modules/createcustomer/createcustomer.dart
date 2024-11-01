import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/modules/root/homelayoutscreen.dart';
import 'package:smp/shared/cubit/authcubit/authcubit.dart';

import '../../shared/components/componentts.dart';
import '../../shared/cubit/authcubit/authstates.dart';
import '../../theme.dart';

class CreateCustomer extends StatelessWidget {
  const CreateCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (BuildContext context, AuthStates states) {},
            builder: (BuildContext context, AuthStates states) {
              var authCubit = AuthCubit.get(context);

              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  toolbarHeight: 0,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: backgroundColor,
                      statusBarIconBrightness: Brightness.dark),
                ),
                backgroundColor: backgroundColor,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/logo1.png",
                          height: 300,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(bottom: 8),
                          child: Text(
                            'تسجيل عميل جديد',
                            style: greetingTextStyle.apply(
                                fontWeightDelta: DateTime.february,
                                color: darkBlue700),
                          ),
                        ),
                        loginField(
                            controller: authCubit.createAdminNameController,
                            textInput: TextInputType.name,
                            validator: (String? value) {
                              return null;
                            },
                            suffixIcon: Icons.email_outlined,
                            hintText: 'enter your name'),
                        const SizedBox(
                          height: 24,
                        ),
                        loginField(
                            controller: authCubit.createAdminEmailController,
                            textInput: TextInputType.emailAddress,
                            validator: (String? value) {
                              return null;
                            },
                            suffixIcon: Icons.person,
                            hintText: 'enter your email'),
                        const SizedBox(
                          height: 24,
                        ),
                        loginField(
                            controller: authCubit.createAdminPasswordController,
                            textInput: TextInputType.visiblePassword,
                            validator: (String? value) {
                              return null;
                            },
                            suffixIcon: Icons.remove_red_eye_outlined,
                            hintText: 'enter your password'),
                        Row(
                          children: [
                            Switch(
                                value: authCubit.toggle,
                                onChanged: (value) {
                                  authCubit.switchToggle(value);
                                }),
                            const Spacer(),
                            Text(
                              'منح العميل مالك؟',
                              style: subTitleTextStyle.apply(
                                color: darkBlue500,
                                fontWeightDelta: 20,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'هل نسيت كلمة السر ؟',
                                  style: subTitleTextStyle.apply(
                                      color: darkBlue500, fontWeightDelta: 20),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        InkWell(
                          onTap: () async {
                            authCubit.userRegister(
                                name: authCubit.createAdminNameController.text,
                                password: authCubit
                                    .createAdminPasswordController.text,
                                email:
                                    authCubit.createAdminEmailController.text,
                                image: 'image',
                                admin: authCubit.toggle);
                          },
                          child: Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 50),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: darkBlue300,
                                  borderRadius: BorderRadius.circular(28)),
                              child: Center(
                                child: Text(
                                  'تسجيل دخول',
                                  style: greetingTextStyle.apply(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              navigateAndFinish(
                                  context, const HomeLayoutScreen());
                            },
                            child: Text(
                              'حجز ملعب ',
                              style: greetingTextStyle.apply(
                                color: darkBlue500,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  Widget loginField({
    required TextEditingController controller,
    required TextInputType? textInput,
    required String? Function(String?)? validator,
    required IconData? suffixIcon,
    required String? hintText,
  }) =>
      TextFormField(
        textAlign: TextAlign.left,
        controller: controller,
        validator: validator,
        textDirection: TextDirection.ltr,
        style: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        keyboardAppearance: Brightness.light,
        keyboardType: textInput,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          suffixIcon: Icon(suffixIcon),
// suffixIcon: suffixx,
          hintTextDirection: TextDirection.rtl,

          // isDense: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          fillColor: Colors.transparent,
          // label: Text(
          //   label!,
          //   textDirection: TextDirection.rtl,
          // ),
          // prefix: Padding(
          //   padding: EdgeInsets.only(right: 10.0),
          //   child: InkWell(onTap: (){}, child: prefix),
          // ),
          // prefix: prefix != null
          //     ? InkWell(onTap: prefixPressed, child: prefix)
          //     : null,
          // labelText: label,
          // labelStyle: const TextStyle(
          //   color: Color.fromRGBO(99, 99, 99, 100),
          //   // fontWeight: FontWeight.w600,
          //   fontSize: 14,
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(
              color: darkBlue700,
              width: 1,
            ),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(
              width: 1,
              color: darkBlue300,
            ),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
            28,
          )),
          filled: true,
          // suffixIcon: suffix != null
          //     ? IconButton(
          //         icon: Icon(suffix),
          //         onPressed: suffixpressed,
          //       )
          //     : null,
          // contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 2),
        ),
      );
}
