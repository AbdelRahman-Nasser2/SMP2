import 'package:flutter/material.dart';
import 'package:smp/modules/createcustomer/createcustomer.dart';
import 'package:smp/shared/components/componentts.dart';
import 'package:smp/shared/components/no_transaction_message.dart';
import 'package:smp/theme.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NoTranscationMessage(
                messageTitle: "No Completed Order, yet.",
                messageDesc:
                    "Please Complete your order. . . \nif you don't have one, Let's explore sport venue near you.",
              ),
              TextButton(
                  onPressed: () {
                    navigateTo(context, const CreateCustomer());
                  },
                  child: const Text('نسجيل عميل'))
            ],
          ),
        ),
      ),
    );
  }
}
