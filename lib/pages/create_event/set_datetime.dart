import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app_storage.dart';
import '../../utils/constants/colors.dart';
import 'controller.dart';
import 'event_demonstration.dart';

class SetDatetimeScreen extends StatefulWidget {
  SetDatetimeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SetDatetimeScreenState createState() => _SetDatetimeScreenState();
}

class _SetDatetimeScreenState extends State<SetDatetimeScreen> with TickerProviderStateMixin {
  final _backgroundGradient = AppColors.getShuffledGradient();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateEventController>(
      init: CreateEventController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(gradient: _backgroundGradient),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FadeInDownBig(
                        child: LottieBuilder.asset('assets/animations/calendar.json'),
                      ),
                      SizedBox(height: 12),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 21.0,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Set the ',
                              style: TextStyle(
                                color: AppColors.WHITE.withOpacity(.8),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'event start',
                              style: TextStyle(
                                color: AppColors.WHITE,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: ' date & time',
                              style: TextStyle(
                                color: AppColors.WHITE.withOpacity(.8),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeInUpBig(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(36),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 36),
                                width: double.infinity,
                                // decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
                                child: DateTimePicker(
                                  style: TextStyle(
                                    color: AppColors.PRIMARY,
                                  ),
                                  cursorRadius: Radius.circular(36),
                                  controller: controller.dateTimeController,
                                  type: DateTimePickerType.dateTimeSeparate,
                                  dateMask: 'd MMM, yyyy',
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2040),
                                  dateLabelText: 'Date',
                                  timeLabelText: 'Time',
                                  selectableDayPredicate: (date) {
                                    return true;
                                  },
                                  onChanged: (val) => print(val),
                                  validator: (val) {
                                    print(val);
                                    return null;
                                  },
                                  onSaved: (val) => print(val),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 48,
                  child: FadeInLeft(
                    child: IconButton(
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        color: AppColors.PRIMARY!.withOpacity(.6),
                        size: 48,
                      ),
                      onPressed: () => {Get.back()},
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FadeInUpBig(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: TextButton(
                onPressed: () async => {
                  Get.to(
                    () => EventDemonstrationScreen(
                      creatorName: AppStorage.getCurrentUserData().name,
                      creatorDescription: AppStorage.getCurrentUserData().description ?? '',
                      eventName: controller.nameController.text,
                      aboutEvent: controller.aboutEventController.text,
                      aboutYou: controller.aboutYouController.text,
                      aboutLocation: controller.aboutLocationController.text,
                    ),
                  ),
                },
                child: Text(
                  'Check result',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.PRIMARY,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
