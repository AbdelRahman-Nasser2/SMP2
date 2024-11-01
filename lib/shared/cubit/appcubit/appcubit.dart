import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/model/adminmodel.dart';
import 'package:smp/modules/home/home_view.dart';
import 'package:smp/modules/setting/settings_view.dart';
import 'package:smp/modules/transaction/transaction_history_view.dart';
import 'package:smp/shared/components/constant.dart';
import 'package:smp/shared/cubit/appcubit/appstates.dart';
import 'package:smp/shared/network/local/sharedpreference/sharedpreference.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  //HomeLayoutScreen
  var currentIndex = 0;

  final screens = [
    HomeScreen(),
    const TransactionHistoryView(),
    const SettingsView(),
  ];

  void changeScreen(value) {
    currentIndex = value;
    emit(ChangeScreen());
  }

  UserData? userDataModel;
  void getUserData() async {
    emit(GetUserDataLoading());
    var future = FirebaseFirestore.instance.collection('users').doc(uID).get()
      ..then((value) {
        if (value.data() != null) {
          print('succ1');
          userDataModel = UserData.fromJson(value.data()!);
          // print(userDataModel!.id);
          CacheHelper.saveData(key: 'admin', value: userDataModel!.admin);
          admin = CacheHelper.get(key: 'admin');
          print(admin);

          // print(value.data());
          emit(GetUserDataSuccess());
        } else {
          print('succ2');
          FirebaseFirestore.instance
              .collection('admins')
              .doc(uID)
              .get()
              .then((value) {
            userDataModel = UserData.fromJson(value.data()!);
            CacheHelper.saveData(key: 'admin', value: userDataModel!.admin);
            // print(value.data());
            admin = CacheHelper.get(key: 'admin');
            emit(GetUserDataSuccess());
          });
          // print(value.data());
        }
      }).catchError((error) {
        emit(GetUserDataError());
      });
  }
}
