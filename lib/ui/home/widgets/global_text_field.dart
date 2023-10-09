import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:todo_task/utils/colors/colors.dart';
import 'package:todo_task/utils/icons/icons.dart';
import 'package:todo_task/utils/size/size_extension.dart';

class GlobalTextField extends StatelessWidget {
  const GlobalTextField(
      {super.key,
      required this.eventText,
      required this.keyboardType,
      required this.textInputAction,
      this.suffixIcon = false,
      required this.controller,
      this.maxHeight = 1,
      this.maskFormatter});

  final String eventText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool suffixIcon;
  final TextEditingController controller;
  final int maxHeight;
  final TextInputFormatter? maskFormatter;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventText,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  fontFamily: "Roboto",
                  color: AppColors.C_17191C),
            ),
          ],
        ),
        4.ph,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.C_F3F4F6),
          child: TextField(
            inputFormatters: maskFormatter != null ? [maskFormatter!] : [],
            maxLines: maxHeight,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            controller: controller,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                suffixIcon: suffixIcon
                    ? SvgPicture.asset(
                        AppIcons.location,
                        width: 17.w,
                        height: 17.h,
                        fit: BoxFit.scaleDown,
                        colorFilter: const ColorFilter.mode(
                            AppColors.C_009FEE, BlendMode.srcIn),
                      )
                    : SizedBox(),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide:
                        BorderSide(width: 1.w, color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide:
                        BorderSide(width: 1.w, color: Colors.transparent)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(width: 1.w, color: Colors.red)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide:
                        BorderSide(width: 1.w, color: Colors.transparent)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide:
                        BorderSide(width: 1.w, color: Colors.transparent))),
          ),
        ),
        16.ph,
      ],
    );
  }
}
