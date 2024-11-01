import 'package:flutter/material.dart';
import 'package:smp/model/field_order.dart';
import 'package:smp/shared/components/no_transaction_message.dart';
import 'package:smp/theme.dart';
import 'package:smp/utils/dummy_data.dart';

class OrderView extends StatelessWidget {
  List<FieldOrder> fieldOrderList = dummyUserOrderList;

  OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: fieldOrderList.isEmpty
            ? Center(
                child: SingleChildScrollView(
                    child: NoTranscationMessage(
                messageTitle: "No Transactions, yet.",
                messageDesc:
                    "You have never placed an order. Let's explore the sport venue near you.",
              )))
            : ListView.builder(
                itemCount: fieldOrderList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    splashColor: primaryColor100,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(fieldOrderList[index]
                                        .field
                                        .imageAsset))),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fieldOrderList[index].field.name,
                                style: normalTextStyle,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(fieldOrderList[index].selectedDate,
                                  style: normalTextStyle),
                            ],
                          ),
                          const Spacer(),
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.red)),
                              child: Text(
                                "Unpaid",
                                style: normalTextStyle.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red),
                              ))
                        ],
                      ),
                    ),
                  );
                }));
  }
}
