import 'dart:ui';

import 'package:best_flutter_ui_templates/hotelBooking/hotelAppTheme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'customCalendar.dart';

class CalendarPopupView extends StatefulWidget {
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final Function(DateTime, DateTime) onApplyClick;
  final Function onCancelClick;

  const CalendarPopupView({Key key, this.initialStartDate, this.initialEndDate, this.onApplyClick, this.onCancelClick}) : super(key: key);
  @override
  _CalendarPopupViewState createState() => _CalendarPopupViewState();
}

class _CalendarPopupViewState extends State<CalendarPopupView> with TickerProviderStateMixin {
  AnimationController animationController;
  DateTime startDate;
  DateTime endDate;

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 100),
          opacity: animationController.value,
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              animationController.reverse().then((f) {
                widget.onCancelClick();
              });
            },
            child: Container(
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: HotelAppTheme.buildLightTheme().backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.grey.withOpacity(0.2), offset: Offset(4, 4), blurRadius: 8.0),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "From",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16, color: Colors.grey.withOpacity(0.8)),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    startDate != null ? DateFormat("EEE, dd MMM").format(startDate) : "--/-- ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 74,
                              width: 1,
                              color: HotelAppTheme.buildLightTheme().dividerColor,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "To",
                                    style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16, color: Colors.grey.withOpacity(0.8)),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    endDate != null ? DateFormat("EEE, dd MMM").format(endDate) : "--/-- ",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(
                          height: 1,
                        ),
                        CustomCalendarView(
                          minimumDate: DateTime.now(),
                          initialEndDate: widget.initialEndDate,
                          initialStartDate: widget.initialStartDate,
                          startEndDateChange: (DateTime startDateData, DateTime endDateData) {
                            setState(() {
                              startDate = startDateData;
                              endDate = endDateData;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: HotelAppTheme.buildLightTheme().primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(24.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  blurRadius: 8,
                                  offset: Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  try {
                                    animationController.reverse().then((f) {
                                      widget.onApplyClick(startDate, endDate);
                                    });
                                  } catch (e) {}
                                },
                                child: Center(
                                  child: Text(
                                    "Apply",
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
