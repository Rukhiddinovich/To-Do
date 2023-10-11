import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:todo_task/bloc/todo/todo_bloc.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/ui/home/widgets/global_button.dart';
import 'package:todo_task/ui/home/widgets/global_text_field.dart';
import 'package:todo_task/utils/colors/colors.dart';
import 'package:todo_task/utils/size/size_extension.dart';
import 'package:todo_task/utils/ui_utils/error_message_dialog.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  List<Color> colors = [
    AppColors.C_EE2B00.withOpacity(0.3),
    AppColors.C_009FEE.withOpacity(0.3),
    AppColors.C_EE8F00.withOpacity(0.3),
  ];

  Color selectedColor = AppColors.C_EE2B00.withOpacity(0.3);

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  TextEditingController eventTimeController = TextEditingController();
  TextEditingController eventDayController = TextEditingController();

  var timeFormatter = MaskTextInputFormatter(
      mask: '*#:&# - *#:&#',
      filter: {
        "#": RegExp(r'[0-9]'),
        "*": RegExp(r'[0-2]'),
        "&": RegExp(r'[0-5]')
      },
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.r),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  32.ph,
                  GlobalTextField(
                      suffixIcon: false,
                      controller: eventNameController,
                      eventText: "Event name",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next),
                  GlobalTextField(
                      suffixIcon: false,
                      maxHeight: 5,
                      controller: eventDescriptionController,
                      eventText: "Event description",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next),
                  GlobalTextField(
                      controller: eventLocationController,
                      suffixIcon: true,
                      eventText: "Event location",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next),
                  Container(
                    width: 75.w,
                    height: 40.h,
                    margin: EdgeInsets.only(right: 280.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.C_F3F4F6),
                    child: Center(
                      child: DropdownButton<Color>(
                        value: selectedColor,
                        icon: Icon(Icons.keyboard_arrow_down,
                            color: AppColors.C_009FEE, size: 30.r),
                        iconSize: 24,
                        elevation: 16,
                        underline: const SizedBox(),
                        style: TextStyle(color: Colors.black, fontSize: 18.sp),
                        onChanged: (Color? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedColor = newValue;
                            });
                          }
                        },
                        items:
                            colors.map<DropdownMenuItem<Color>>((Color value) {
                          return DropdownMenuItem<Color>(
                            value: value,
                            child: Container(
                              width: 23.w,
                              height: 23.h,
                              decoration: BoxDecoration(color: value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  16.ph,
                  GlobalTextField(
                      maskFormatter: timeFormatter,
                      suffixIcon: false,
                      controller: eventTimeController,
                      eventText: "Event time",
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done),
                ],
              ),
            ),
            ZoomTapAnimation(
              onTap: () {
                if (eventTimeController.text.isNotEmpty &&
                    eventNameController.text.isNotEmpty) {
                  BlocProvider.of<ToDoBloc>(context).add(AddToDo(
                      newEvents: ToDoModel(
                          day: eventDayController.text,
                          eventColor: selectedColor.toString(),
                          eventDescription: eventDescriptionController.text,
                          eventLocation: eventLocationController.text,
                          eventName: eventNameController.text,
                          eventTime: eventTimeController.text)));
                  Navigator.pop(context);
                } else {
                  showErrorMessage(
                      message: "The data is incomplete!", context: context);
                }
              },
              child: const GlobalButton(
                  buttonText: "Add", buttonColor: AppColors.C_009FEE),
            ),
          ],
        ),
      ),
    );
  }
}
