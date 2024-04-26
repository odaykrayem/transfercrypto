import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transfercrypto/extensions/string_extension.dart';
import 'package:get/get.dart';
import '../data/enums.dart';

/// Default Text Form Field
class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextFieldType textFieldType;
  final InputDecoration? decoration;
  final FocusNode? focus;
  final FormFieldValidator<String>? validator;
  final bool? isPassword;
  final bool? isValidationRequired;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final FocusNode? nextFocus;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final bool? autoFocus;
  final bool? readOnly;
  final bool? enableSuggestions;
  final int? maxLength;
  final Color? cursorColor;
  final Widget? suffix;
  final Color? suffixIconColor;
  final TextInputType? keyboardType;
  final Iterable<String>? autoFillHints;
  final EdgeInsets? scrollPadding;
  final double? cursorWidth;
  final double? cursorHeight;
  final Function()? onTap;
  final InputCounterWidgetBuilder? buildCounter;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlignVertical? textAlignVertical;
  final bool? expands;
  final bool? showCursor;
  final TextSelectionControls? selectionControls;
  final StrutStyle? strutStyle;
  final String? obscuringCharacter;
  final String? initialValue;
  final String? hintText;
  final Brightness? keyboardAppearance;

  final String? errorThisFieldRequired;
  final String? errorInvalidEmail;
  final String? errorMinimumPasswordLength;
  final String? errorInvalidURL;
  final String? errorInvalidUsername;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final double? borderRadius;
  final AutovalidateMode? autovalidateMode;

  const CustomTextField({
    super.key,
    this.controller,
    required this.textFieldType,
    this.decoration,
    this.focus,
    this.validator,
    this.isPassword,
    this.buildCounter,
    this.isValidationRequired,
    this.textCapitalization,
    this.textInputAction,
    this.onFieldSubmitted,
    this.nextFocus,
    this.textStyle,
    this.textAlign,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.onChanged,
    this.cursorColor,
    this.suffix,
    this.suffixIconColor,
    this.enableSuggestions,
    this.autoFocus,
    this.readOnly,
    this.maxLength,
    this.keyboardType,
    this.autoFillHints,
    this.scrollPadding,
    this.onTap,
    this.cursorWidth,
    this.cursorHeight,
    this.inputFormatters,
    this.errorThisFieldRequired,
    this.errorInvalidEmail,
    this.errorMinimumPasswordLength,
    this.errorInvalidURL,
    this.errorInvalidUsername,
    this.textAlignVertical,
    this.expands,
    this.showCursor,
    this.selectionControls,
    this.strutStyle,
    this.obscuringCharacter,
    this.initialValue,
    this.keyboardAppearance,
    this.hintText,
    this.prefixIcon,
    this.prefixIconColor,
    this.borderRadius,
    this.autovalidateMode,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;
  String thisFieldIsRequired = 'thisFieldIsRequired'.tr;

  FormFieldValidator<String>? applyValidation() {
    if (widget.isValidationRequired ?? true) {
      if (widget.validator != null) {
        return widget.validator;
      } else if (widget.textFieldType == TextFieldType.EMAIL) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired.validate(
                value: widget.errorThisFieldRequired ?? thisFieldIsRequired);
          }
          if (!s.trim().validateEmail()) {
            return widget.errorInvalidEmail.validate(value: 'Email is invalid');
          }
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.PASSWORD) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired.validate(
                value: widget.errorThisFieldRequired ?? thisFieldIsRequired);
          }
          if (s.trim().length < 6) {
            return widget.errorMinimumPasswordLength
                .validate(value: 'Minimum password length should be 6');
          }
          return null;
        };
      } else if (widget.textFieldType == TextFieldType.NAME ||
          widget.textFieldType == TextFieldType.PHONE) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired.validate(
                value: widget.errorThisFieldRequired ?? thisFieldIsRequired);
          }
          return null;
        };
      }
      // else if (widget.textFieldType == TextFieldType.URL) {
      //   return (s) {
      //     if (s!.trim().isEmpty) return widget.errorThisFieldRequired.validate(value: widget.errorThisFieldRequired??thisFieldIsRequired);
      //     if (!s.validateURL()) {
      //       return widget.errorInvalidURL.validate(value: 'Invalid URL');
      //     }
      //     return null;
      //   };
      // }
      else if (widget.textFieldType == TextFieldType.USERNAME) {
        return (s) {
          if (s!.trim().isEmpty) {
            return widget.errorThisFieldRequired.validate(
                value: widget.errorThisFieldRequired ?? thisFieldIsRequired);
          }
          if (s.contains(' ')) {
            return widget.errorInvalidUsername
                .validate(value: 'Username should not contain space');
          }
          return null;
        };
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  TextCapitalization applyTextCapitalization() {
    if (widget.textCapitalization != null) {
      return widget.textCapitalization!;
    } else if (widget.textFieldType == TextFieldType.NAME) {
      return TextCapitalization.words;
    } else if (widget.textFieldType == TextFieldType.ADDRESS) {
      return TextCapitalization.sentences;
    } else {
      return TextCapitalization.none;
    }
  }

  TextInputAction? applyTextInputAction() {
    if (widget.textInputAction != null) {
      return widget.textInputAction;
    } else if (widget.textFieldType == TextFieldType.ADDRESS) {
      return TextInputAction.newline;
    } else if (widget.nextFocus != null) {
      return TextInputAction.next;
    } else {
      return TextInputAction.done;
    }
  }

  TextInputType? applyTextInputType() {
    if (widget.keyboardType != null) {
      return widget.keyboardType;
    } else if (widget.textFieldType == TextFieldType.EMAIL) {
      return TextInputType.emailAddress;
    } else if (widget.textFieldType == TextFieldType.ADDRESS) {
      return TextInputType.multiline;
    } else if (widget.textFieldType == TextFieldType.PASSWORD) {
      return TextInputType.visiblePassword;
    } else if (widget.textFieldType == TextFieldType.PHONE) {
      return TextInputType.number;
    }
    // else if (widget.textFieldType == TextFieldType.URL) {
    //   return TextInputType.url;
    // }
    else {
      return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 15),
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(1, 1),
              color: Colors.grey.withOpacity(0.2)),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.textFieldType == TextFieldType.PASSWORD &&
            !isPasswordVisible,
        validator: applyValidation(),
        autovalidateMode: widget.autovalidateMode,
        textCapitalization: applyTextCapitalization(),
        textInputAction: applyTextInputAction(),
        onFieldSubmitted: (s) {
          if (widget.nextFocus != null) {
            FocusScope.of(context).requestFocus(widget.nextFocus);
          }

          if (widget.onFieldSubmitted != null) widget.onFieldSubmitted!.call(s);
        },
        keyboardType: applyTextInputType(),
        decoration: widget.decoration != null
            ? (widget.decoration!.copyWith(
                suffixIcon: widget.textFieldType == TextFieldType.PASSWORD
                    ? widget.suffix ??
                        GestureDetector(
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: widget.suffixIconColor ??
                                Theme.of(context).iconTheme.color,
                          ),
                          onTap: () {
                            isPasswordVisible = !isPasswordVisible;

                            setState(() {});
                          },
                        )
                    : widget.suffix,
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        color: widget.prefixIconColor,
                      )
                    : null,
              ))
            : InputDecoration(
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        color: widget.prefixIconColor,
                      )
                    : null,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 15,
                  ),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 15,
                  ),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 15,
                  ),
                ),
              ),
        focusNode: widget.focus,
        style: widget.textStyle ??
            const TextStyle(
              fontSize: 16.00,
              color: Color(0xFF2E3033),
              fontWeight: FontWeight.normal,
            ),
        textAlign: widget.textAlign ?? TextAlign.start,
        maxLines: widget.textFieldType == TextFieldType.ADDRESS
            ? null
            : widget.maxLines ?? 1,
        minLines: widget.minLines ?? 1,
        autofocus: widget.autoFocus ?? false,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        cursorColor: widget.cursorColor ??
            Theme.of(context).textSelectionTheme.cursorColor,
        readOnly: widget.readOnly ?? false,
        maxLength: widget.maxLength,
        enableSuggestions: widget.enableSuggestions ?? true,
        autofillHints: widget.autoFillHints,
        scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20),
        cursorWidth: widget.cursorWidth ?? 2.0,
        cursorHeight: widget.cursorHeight,
        cursorRadius: const Radius.circular(4),
        onTap: widget.onTap,
        buildCounter: widget.buildCounter,
        scrollPhysics: const BouncingScrollPhysics(),
        enableInteractiveSelection: true,
        inputFormatters: widget.inputFormatters,
        textAlignVertical: widget.textAlignVertical,
        expands: widget.expands ?? false,
        showCursor: widget.showCursor,
        selectionControls: widget.selectionControls,
        strutStyle: widget.strutStyle,
        obscuringCharacter: widget.obscuringCharacter.validate(value: '•'),
        initialValue: widget.initialValue,
        keyboardAppearance: widget.keyboardAppearance,
      ),
    );
  }
}
