import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/utils/size/size_extension.dart';

class GlobalContainer extends StatelessWidget {
  const GlobalContainer(
      {super.key,
      this.clock,
      this.clockTitle = "",
      this.locationTitle = "",
      this.location,
      required this.firstContainerColor,
      required this.secondContainerColor,
      required this.title,
      required this.subtitle,
      required this.svgColor,
      required this.textColor});

  final Color firstContainerColor;
  final Color secondContainerColor;
  final String clockTitle;
  final String locationTitle;
  final String title;
  final String subtitle;
  final String? clock;
  final String? location;
  final Color svgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 10.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                topLeft: Radius.circular(10.r),
              ),
              color: firstContainerColor),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: secondContainerColor.withOpacity(0.3),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.r),
              bottomLeft: Radius.circular(10.r),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            fontFamily: "Poppins",
                            color: textColor),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 8.sp,
                            fontFamily: "Poppins",
                            color: textColor),
                      ),
                    ],
                  ),
                ],
              ),
              12.ph,
              Row(
                children: [
                  clock != null
                      ? SvgPicture.asset(
                          clock!,
                          width: 18.w,
                          height: 18.h,
                          colorFilter:
                              ColorFilter.mode(svgColor, BlendMode.srcIn),
                        )
                      : const SizedBox(),
                  4.pw,
                  Text(
                    clockTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        fontFamily: "Poppins",
                        color: textColor),
                  ),
                  10.pw,
                  location != null
                      ? SvgPicture.asset(
                          location!,
                          colorFilter:
                              ColorFilter.mode(svgColor, BlendMode.srcIn),
                        )
                      : const SizedBox(),
                  4.pw,
                  Text(
                    locationTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        fontFamily: "Poppins",
                        color: textColor),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
