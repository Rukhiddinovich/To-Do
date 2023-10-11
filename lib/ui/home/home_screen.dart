import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_task/bloc/todo/todo_bloc.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/ui/app_routes.dart';
import 'package:todo_task/ui/home/widgets/calendar.dart';
import 'package:todo_task/ui/home/widgets/global_container.dart';
import 'package:todo_task/utils/colors/colors.dart';
import 'package:todo_task/utils/constants/constants.dart';
import 'package:todo_task/utils/icons/icons.dart';
import 'package:todo_task/utils/size/size_extension.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String day = DateTime.now().weekday == 0
      ? "Sunday"
      : DateTime.now().weekday == 1
      ? "Monday"
      : DateTime.now().weekday == 2
      ? "Tuesday"
      : DateTime.now().weekday == 3
      ? "Wednesday"
      : DateTime.now().weekday == 4
      ? "Thursday"
      : DateTime.now().weekday == 5
      ? "Friday"
      : "Saturday";

  bool isVisible = true;
  List<ToDoModel> todoList = [];

  @override
  void initState() {
    BlocProvider.of<ToDoBloc>(context).add(GeToDo());
    todoList = BlocProvider.of<ToDoBloc>(context).newEvents;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Column(
          children: [
            Text(
              day,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.C_292929,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.C_292929,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  4.pw,
                  GestureDetector(
                    onTap: () {
                      isVisible = !isVisible;
                      setState(() {});
                    },
                    child: isVisible
                        ? const Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                  )
                ],
              ),
            )
          ],
        ),
        actions: [SvgPicture.asset(AppIcons.notification), 28.pw],
        centerTitle: true,
      ),
      body: BlocConsumer<ToDoBloc, ToDoState>(
        builder: (context, state) {
          return Column(
            children: [
              CustomCalendarDate(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2950),
                  onDateChanged: (v) {
                    setState(() {
                      switch (v.weekday) {
                        case 0:
                          {
                            day = "Monday";
                          }
                          break;

                        case 1:
                          {
                            day = "Tuesday";
                          }
                          break;
                        case 2:
                          {
                            day = "Wednesday";
                          }
                          break;

                        case 3:
                          {
                            day = "Thursday";
                          }
                          break;
                        case 4:
                          {
                            day = "Friday";
                          }
                          break;
                        case 5:
                          {
                            day = "Saturday";
                          }
                          break;
                        case 6:
                          {
                            day = "Sunday";
                          }
                          break;

                        default:
                          {
                            //statements;
                          }
                          break;
                      }
                    });
                  }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Schedule",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          fontFamily: "Poppins",
                          color: AppColors.C_292929),
                    ),
                    ZoomTapAnimation(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.addScreen);
                      },
                      child: Container(
                        width: 102.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.C_009FEE),
                        child: Center(
                          child: Text(
                            "+ Add Event",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                fontFamily: "Poppins",
                                color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              18.ph,
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  itemBuilder: (BuildContext context, int index) {
                    ToDoModel toDo = state.events[index];
                    return ZoomTapAnimation(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.detailScreen,
                            arguments: toDo);
                      },
                      child: GlobalContainer(
                        clock: AppIcons.clock,
                        clockTitle: toDo.eventTime,
                        location: AppIcons.location,
                        locationTitle: toDo.eventLocation,
                        firstContainerColor:
                            getColorFromString(toDo.eventColor).withOpacity(1),
                        secondContainerColor:
                            getColorFromString(toDo.eventColor),
                        title: toDo.eventName,
                        subtitle: toDo.eventDescription,
                        svgColor:
                            getColorFromString(toDo.eventColor).withOpacity(1),
                        textColor:
                            getColorFromString(toDo.eventColor).withOpacity(1),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return 14.ph;
                  },
                  itemCount: state.events.length,
                  physics: const BouncingScrollPhysics(),
                ),
              ),
            ],
          );
        },
        listener: (context, state) {
          if(state.statusText ==StatusTextConstants.todoDelete){
            setState(() {
              BlocProvider.of<ToDoBloc>(context).add(GeToDo());
              todoList = BlocProvider.of<ToDoBloc>(context).newEvents;
            });
          }
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
