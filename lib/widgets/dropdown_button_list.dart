import 'dart:math';

import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';

import '../constants/api_constants.dart';
import '../constants/app_colors.dart';
import '../models/method_model.dart';

class CustomDropDownButtonList extends StatelessWidget {
  CustomDropDownButtonList(
      {super.key,
      required this.list,
      required this.onChanged,
      required this.value,
      required this.isReceive});
  final List<dynamic> list;
  final void Function(MethodModel?)? onChanged;
  final MethodModel? value;
  final bool isReceive;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<MethodModel>(
        isExpanded: true,
        hint: Row(
          children: [
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'selectWallet'.tr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: list
            .map((item) => DropdownMenuItem<MethodModel>(
                  value: item,
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${(item.wallet_name as String).contains('cash') ? 'cash'.tr : (item.wallet_name as String).tr}',
                            style: const TextStyle(fontFamily: 'Outfit-Medium'),
                            overflow: TextOverflow.ellipsis,
                          ),
                          5.width,
                          ImageNetwork(
                            height: 30,
                            width: 30,
                            fitAndroidIos: BoxFit.cover,
                            fitWeb: BoxFitWeb.cover,
                            image: ApiConstants.imageUrl + item.wallet_icon,
                            key: ValueKey(new Random().nextInt(100)),
                          )
                        ],
                      )),

                  // Text(
                  //   item.walletName,
                  //   style: const TextStyle(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.white,
                  //   ),
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                ))
            .toList(),
        value: value,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 300,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.white,
          ),
          elevation: 2,
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
          ),
          iconSize: 14,
          iconEnabledColor: AppColors.primaryColor,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
