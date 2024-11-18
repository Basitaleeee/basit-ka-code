import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Reusable/Button.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/app_colors.dart';
import 'Search Filter.dart';

class EventSearchScreen extends StatelessWidget {
  EventSearchScreen({super.key});
  final EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 150.0.w,
                  child: const Divider(
                    thickness: 3,
                    color: AppColors.black,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: 220.w, // Use double.infinity for responsive width
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(6.0.r),
                    border: Border.all(
                      color: AppColors.divider2,
                      width: 3.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          eventController.isEventSelected.value = true;
                        },
                        child: Obx(() => Container(
                          width: 91.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: eventController.isEventSelected.value
                                ? AppColors.white
                                : AppColors.divider,
                            borderRadius: BorderRadius.circular(8.0.r),
                          ),
                          child: Center(
                            child: Text(
                              'Events',
                              style: oStyleBlack16600.copyWith(
                                color: eventController.isEventSelected.value
                                    ? AppColors.secondary
                                    : AppColors.text6,
                              ),
                            ),
                          ),
                        )),
                      ),
                      GestureDetector(
                        onTap: () {
                          eventController.isEventSelected.value = false;
                        },
                        child: Obx(() => Container(
                          width: 91.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: !eventController.isEventSelected.value
                                ? AppColors.white
                                : AppColors.divider,
                            borderRadius: BorderRadius.circular(8.0.r),
                          ),
                          child: Center(
                            child: Text(
                              'Date',
                              style: oStyleBlack16600.copyWith(
                                color: !eventController.isEventSelected.value
                                    ? AppColors.secondary
                                    : AppColors.text6,
                              ),
                            ),
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Obx(() {
                return Column(
                  children: [
                    eventController.isEventSelected.value
                        ? _buildEventSearch(context)
                        : _buildCalendar(context),
                  ],
                );
              }),
              SizedBox(
                height: 58.h,
                child: RoundedButton(
                  text: 'FIND RESULT',
                  onPressed: () {
                    Navigator.push
                      (
                        context,
                        MaterialPageRoute(builder: (context) =>  SearchFilter())
                      );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventSearch(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.h,
          width: double.infinity, // Use double.infinity for responsive width
          child: TextField(
            controller: eventController.searchController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15.h),
              filled: true,
              fillColor: const Color(0xFFF8F9FE),
              prefixIcon: Icon(
                Icons.search,
                color: const Color(0xFF2F3036),
                size: 24.sp,
              ),
              hintText: 'Search',
              hintStyle: TextStyle(
                color: const Color(0xFF8F9098),
                fontSize: 17.sp,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity, // Use double.infinity for responsive width
          height: 300.h,
          decoration: BoxDecoration(
            color: Color(0xFFD9D9D9).withOpacity(0.24),
            borderRadius: BorderRadius.circular(6.0.r),
            border: Border.all(
              color: AppColors.divider2,
              width: 1.0,
            ),
          ),
          child: Obx(() {
            return eventController.filteredEvents.isNotEmpty
                ? ListView.builder(
              itemCount: eventController.filteredEvents.length,
              itemBuilder: (context, index) {
                final event = eventController.filteredEvents[index];
                return ListTile(
                  title: Text(
                    event.toUpperCase(),
                    style: oStyleBlack14300.copyWith(
                        color: AppColors.primaryColor),
                  ),
                  onTap: () {
                    eventController.selectEvent(event);
                  },
                );
              },
            )
                : Center(
              child: Text(
                'No events found',
                style:
                oStyleBlack16600.copyWith(color: AppColors.secondary),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCalendar(BuildContext context) {
    return Column(
      children: [
        Obx(() => Text(
          "Selected Event: ${eventController.selectedEvent.value}",
          style: oStyleBlack16600.copyWith(color: AppColors.secondary),
        )),
        Container(
          width: double.infinity, // Use double.infinity for responsive width
          decoration: BoxDecoration(
            color: Color(0xFFD9D9D9).withOpacity(0.24),
            borderRadius: BorderRadius.circular(6.0.r),
            border: Border.all(
              color: AppColors.divider2,
              width: 1.0,
            ),
          ),
          child: Obx(() {
            return TableCalendar(
              firstDay: DateTime.utc(2020, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: eventController.focusedDay.value,
              selectedDayPredicate: (day) {
                return isSameDay(eventController.selectedDate.value, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                eventController.selectDate(selectedDay);
                eventController.focusedDay.value = focusedDay;
              },
              calendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: const TextStyle(
                  color: Colors.black,
                ),
                defaultTextStyle: iStyleBlack13700,
                weekendTextStyle: iStyleBlack13700,
                outsideDaysVisible: false,
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon:
                const Icon(Icons.chevron_left, color: Colors.grey),
                rightChevronIcon:
                const Icon(Icons.chevron_right, color: Colors.grey),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class EventController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<String> selectedEvent = ''.obs;
  TextEditingController searchController = TextEditingController();
  RxList<String> filteredEvents = <String>[].obs; // Add filteredEvents observable
  List<String> events = [
    'event1',
    'event2',
    'event3',
    'event4',
    'event5',
  ];

  RxBool isEventSelected = true.obs; // Add isEventSelected observable

  void selectEvent(String event) {
    selectedEvent.value = event; // Update selectedEvent value
  }

  void selectDate(DateTime selectedDay) {
    selectedDate.value = selectedDay; // Update selectedDate value
  }
}
