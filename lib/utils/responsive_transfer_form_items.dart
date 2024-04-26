import 'package:transfercrypto/constants/app_colors.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../data/enums.dart';
import '../widgets/custom_text_filed.dart';

Widget formItem({
  required String fieldTitle,
  required String field2Title,
  TextEditingController? fieldController,
  TextEditingController? field2Controller,
  TextFieldType? textFieldType,
  TextFieldType? text2FieldType,
  bool? autoFocusField,
  IconData? fieldIcon,
  IconData? field2Icon,
  required SizingInformation sizingInformation,
  Widget? child1,
  Widget? child2,
  TextInputType? fieldKeyboardType,
  TextInputType? field2KeyboardType,
  bool? disableConfirmTextField,
  Function(String)? onChangedfield,
  Function(String)? onChangedfield2,
  Function(String)? onSubmitfield,
  Function(String)? onSubmitfield2,
  String? Function(String?)? validatorfield,
  String? Function(String?)? validatorfield2,
  AutovalidateMode? autoValidateField,
  AutovalidateMode? autoValidateField2,
  bool addText = false,
  String? startAddText,
  String? middleAddText,
  String? endAddText,
  bool addText2 = false,
  String? startAddText2,
  String? middleAddText2,
  String? endAddText2,
  bool isAmount = false,
}) {
  return formItemResponsive(
    sizingInformation: sizingInformation,
    children: [
      formItemResponsive2(
        sizingInformation: sizingInformation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fieldTitle,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[500],
              ),
            ),
            25.height,
            child1 ??
                CustomTextField(
                  textFieldType: textFieldType!,
                  prefixIcon: fieldIcon,
                  autoFocus: autoFocusField,
                  controller: fieldController,
                  onChanged: onChangedfield,
                  keyboardType: fieldKeyboardType,
                  onFieldSubmitted: onSubmitfield,
                  validator: validatorfield,
                  autovalidateMode: autoValidateField,
                ),
            addText
                ? Column(
                    children: [
                      5.height,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: startAddText,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[500],
                              ),
                            ),
                            TextSpan(
                              text: middleAddText,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            TextSpan(
                              text: endAddText,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
      sizingInformation.deviceScreenType == DeviceScreenType.mobile
          ? 50.height
          : 50.width,
      formItemResponsive2(
        sizingInformation: sizingInformation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              field2Title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[500],
              ),
            ),
            25.height,
            child2 != null?child2:
            isAmount?
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomTextField(
                    textFieldType: text2FieldType!,
                    prefixIcon: field2Icon ?? fieldIcon,
                    controller: field2Controller,
                    readOnly: disableConfirmTextField,
                    onChanged: onChangedfield2,
                    keyboardType: field2KeyboardType,
                    onFieldSubmitted: onSubmitfield2,
                    autovalidateMode: autoValidateField2,
                    validator: validatorfield2,
                    // textStyle: TextStyle(locale:isAmount ?  Locale('en'): null) ,
                  
                  ),
                ):
                CustomTextField(
                  textFieldType: text2FieldType!,
                  prefixIcon: field2Icon ?? fieldIcon,
                  controller: field2Controller,
                  readOnly: disableConfirmTextField,
                  onChanged: onChangedfield2,
                  keyboardType: field2KeyboardType,
                  onFieldSubmitted: onSubmitfield2,
                  autovalidateMode: autoValidateField2,
                  validator: validatorfield2,
                  // textStyle: TextStyle(locale:isAmount ?  Locale('en'): null) ,
                
                ),
            addText2
                ? Column(
                    children: [
                      5.height,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: startAddText2,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[500],
                              ),
                            ),
                            TextSpan(
                              text: middleAddText2,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            TextSpan(
                              text: endAddText2,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    ],
  );
}

Widget formItemResponsive(
    {required List<Widget> children,
    required SizingInformation sizingInformation}) {
  return sizingInformation.deviceScreenType == DeviceScreenType.mobile
      ? Column(children: children)
      : Row(children: children);
}

Widget formItemResponsive2(
    {required Widget child, required SizingInformation sizingInformation}) {
  return sizingInformation.deviceScreenType == DeviceScreenType.mobile
      ? SizedBox(child: child)
      : Expanded(flex: 1, child: child);
}
