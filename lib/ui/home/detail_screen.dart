import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_task/bloc/todo/todo_bloc.dart';
import 'package:todo_task/data/model/form_status.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/utils/colors/colors.dart';
import 'package:todo_task/utils/icons/icons.dart';
import 'package:todo_task/utils/size/size_extension.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.toDoModel});

  final ToDoModel toDoModel;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:
                getColorFromString(widget.toDoModel.eventColor).withOpacity(1)),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: BlocConsumer<ToDoBloc, ToDoState>(
        listener: (context, state) {
          if (state.status == FormStatus.pure) {
            context.read<ToDoBloc>().add(GeToDo());
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 28.h),
                width: double.infinity,
                height: 248.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r)),
                  color: getColorFromString(widget.toDoModel.eventColor)
                      .withOpacity(1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    18.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ZoomTapAnimation(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                color: AppColors.white),
                            child: const Center(
                              child: Icon(
                                CupertinoIcons.back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.edit,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.white, BlendMode.srcIn),
                            ),
                            Text(
                              "Edit",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                    20.ph,
                    Text(
                      widget.toDoModel.eventName,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 26.sp,
                          color: Colors.white,
                          fontFamily: "Poppins"),
                    ),
                    Text(
                      widget.toDoModel.eventDescription,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 8.sp,
                          color: Colors.white,
                          fontFamily: "Poppins"),
                    ),
                    10.ph,
                    Row(
                      children: [
                        SvgPicture.asset(AppIcons.clock),
                        5.pw,
                        Text(
                          widget.toDoModel.eventTime,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                              color: Colors.white,
                              fontFamily: "Poppins"),
                        ),
                      ],
                    ),
                    10.ph,
                    Row(
                      children: [
                        SvgPicture.asset(AppIcons.location),
                        5.pw,
                        Text(
                          widget.toDoModel.eventLocation,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                              color: Colors.white,
                              fontFamily: "Poppins"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              28.ph,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reminder",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontFamily: "Poppins"),
                    ),
                    10.ph,
                    Text(
                      "15 minutes befor",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: AppColors.C_7C7B7B,
                          fontFamily: "Poppins"),
                    ),
                    22.ph,
                    Text(
                      "Description",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontFamily: "Poppins"),
                    ),
                    10.ph,
                    Text(
                      widget.toDoModel.eventDescription,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                          color: AppColors.C_7C7B7B,
                          fontFamily: "Poppins"),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ZoomTapAnimation(
                onTap: () {
                  showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog.adaptive(
                          title: const Text("Warning",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                                height: 24 / 16,
                              ),
                              textAlign: TextAlign.left),
                          content: const Text(
                            "Do you really delete it?",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff7c7b7b),
                              height: 24 / 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                context.read<ToDoBloc>().add(DeleteTodo(
                                    toDoId: widget.toDoModel.id ?? 0));
                                const snackBar = SnackBar(
                                  content: Text(
                                    "Event deleted successfully",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text(
                                "YES",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "NO",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  width: double.infinity,
                  height: 54.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.C_FEE8E9),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppIcons.delete),
                        Text(
                          "Delete Event",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              color: AppColors.C_292929),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Color getColorFromString(String colorString) {
  String valueString = colorString.split('(0x')[1].split(')')[0];
  int value = int.parse(valueString, radix: 16);
  return Color(value);
}
