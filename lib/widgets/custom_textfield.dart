import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/utils/responsive.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isPassword, readOnly;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? type;
  final void Function(String)? onChanged;
  final onTap;
  final Widget? icon; // <-- made optional
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.label,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.type,
    this.inputFormatters,
    this.readOnly = false,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    this.icon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    bool isDate = widget.label == "Date" ||
        widget.label == "From" ||
        widget.label == "To" ||
        widget.hintText == "DD/MM/YYYY";
    return TextField(
      controller: widget.controller,
      style: AppTextStyles.getLato(
        13,
        4.weight,
      ),
      maxLines: widget.maxLines,
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      keyboardType: widget.type,
      readOnly: widget.readOnly,
      obscureText: widget.isPassword ? _obscure : false,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.label.isEmpty ? '' : "${widget.label}*",
        alignLabelWithHint: false,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // label: Text(
        //   widget.label,
        //   style: AppTextStyles.getLato(16, 6.weight),
        // ),
        hintStyle: AppTextStyles.getLato(13, 4.weight, AppColors.hintColor),
        labelStyle: AppTextStyles.getLato(16, 6.weight),
        // floatingLabelStyle: TextStyle(
        //   color: AppColors.primaryColor, // when focused
        //   fontSize: 16,
        //   fontWeight: FontWeight.w600,
        // ),
        suffixIcon: isDate
            ? IconButton(
                icon: Image.asset(
                  Assets.pngIconsCalander,
                  height: 24,
                ),
                onPressed: widget.onTap,
              )
            : widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: Color(0xffD4D4D4),
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : null,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5)),
        focusColor: AppColors.primaryColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.backgroundColor,
    required this.fieldLabel,
    required this.focusNode,
    this.autofocus = false,
    this.showEditIcon = false,
    this.onEditTap,
    this.onTap,
    this.textStyle,
    this.labelStyle,
    this.maxLength,
    this.obscureText = false,
    this.labelFieldSpace = 8,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.borderColor,
    this.filled = true,
    this.inputFormatters,
    this.validator,
    this.isViewMode = false,
    this.onChanged,
  });

  final Alignment? alignment;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode focusNode;
  final void Function()? onEditTap;
  final double labelFieldSpace;

  final bool? autofocus;
  final void Function()? onTap;
  final TextStyle? textStyle;

  final bool? obscureText;
  final bool showEditIcon;
  final String fieldLabel;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;
  final int? maxLength;
  final Color? borderColor;

  final String? hintText;

  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;
  final Color? backgroundColor;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final bool isViewMode;
  List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (fieldLabel.isNotEmpty)
            Row(
              children: [
                Text(
                  fieldLabel,
                  style: AppTextStyles.getLato(
                    Responsive.isMobile(Get.context!) ? 12 : 16,
                    4.weight,
                  ),
                )
              ],
            ),
          labelFieldSpace.ph,
          TextFormField(
            readOnly: isViewMode,
            autovalidateMode: AutovalidateMode.disabled,
            controller: controller,
            focusNode: focusNode,
            maxLength: maxLength,
            onTap: onTap,
            style: textStyle ??
                AppTextStyles.getLato(
                  Responsive.isMobile(Get.context!) ? 12 : 16,
                  4.weight,
                ),
            obscureText: obscureText!,
            obscuringCharacter: '*',
            inputFormatters: inputFormatters,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            maxLines: maxLines ?? 1,
            cursorColor: AppColors.primaryColor,
            decoration: decoration,
            onChanged: onChanged,
            validator: validator,
          ),
        ],
      );

  InputDecoration get decoration => InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        hintText: hintText ?? "",

        hintStyle: hintStyle ??
            AppTextStyles.getLato(Responsive.isMobile(Get.context!) ? 12 : 16,
                4.weight, AppColors.blackColor.withOpacity(0.6)),
        prefixIcon: prefix,

        prefixIconConstraints: prefixConstraints,

        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        errorStyle: AppTextStyles.getLato(
            Responsive.isMobile(Get.context!) ? 12 : 16,
            4.weight,
            AppColors.redColor),

        contentPadding: contentPadding ??
            EdgeInsets.only(
              top: 12,
              right: 15,
              bottom: 15,
              left: 12,
            ),
        filled: true,
        fillColor: fillColor ?? AppColors.whiteColor,
        // filled: filled,
        // border: InputBorder.none,
        border: borderDecoration ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.textBlackColor.withOpacity(0.3), width: 1.0),
              borderRadius: BorderRadius.circular(6),
            ),
        enabledBorder: borderDecoration ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.textBlackColor.withOpacity(0.3),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
        focusedBorder: borderDecoration ??
            UnderlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                  color: borderColor ?? AppColors.primaryColor, width: 1.0),
            ),
      );
}
