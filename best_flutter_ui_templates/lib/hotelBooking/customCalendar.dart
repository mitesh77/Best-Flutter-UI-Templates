import 'package:best_flutter_ui_templates/hotelBooking/hotelAppTheme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalendarView extends StatefulWidget {
  final DateTime minimumDate;
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final Function(DateTime, DateTime) startEndDateChange;

  const CustomCalendarView({Key key, this.initialStartDate, this.initialEndDate, this.startEndDateChange, this.minimumDate}) : super(key: key);

  @override
  _CustomCalendarViewState createState() => _CustomCalendarViewState();
}

class _CustomCalendarViewState extends State<CustomCalendarView> {
  List<DateTime> dateList = List<DateTime>();
  var currentMonthDate = DateTime.now();
  DateTime startDate;
  DateTime endDate;

  @override
  void initState() {
    setListOfDate(currentMonthDate);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setListOfDate(DateTime monthDate) {
    dateList.clear();
    var newDate = DateTime(monthDate.year, monthDate.month, 0);
    int privusMothDay = 0;
    if (newDate.weekday < 7) {
      privusMothDay = newDate.weekday;
      for (var i = 1; i <= privusMothDay; i++) {
        dateList.add(newDate.subtract(Duration(days: privusMothDay - i)));
      }
    }
    for (var i = 0; i < (42 - privusMothDay); i++) {
      dateList.add(newDate.add(Duration(days: i + 1)));
    }
    // if (dateList[dateList.length - 7].month != monthDate.month) {
    //   dateList.removeRange(dateList.length - 7, dateList.length);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      border: new Border.all(
                        color: HotelAppTheme.buildLightTheme().dividerColor,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {
                          setState(() {
                            currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month, 0);
                            setListOfDate(currentMonthDate);
                          });
                        },
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      DateFormat("MMMM, yyyy").format(currentMonthDate),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      border: new Border.all(
                        color: HotelAppTheme.buildLightTheme().dividerColor,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {
                          setState(() {
                            currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month + 2, 0);
                            setListOfDate(currentMonthDate);
                          });
                        },
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
            child: Row(
              children: getDaysNameUI(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: Column(
              children: getDaysNoUI(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getDaysNameUI() {
    List<Widget> listUI = List<Widget>();
    for (var i = 0; i < 7; i++) {
      listUI.add(
        Expanded(
          child: Center(
            child: Text(
              DateFormat("EEE").format(dateList[i]),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: HotelAppTheme.buildLightTheme().primaryColor),
            ),
          ),
        ),
      );
    }
    return listUI;
  }

  List<Widget> getDaysNoUI() {
    List<Widget> noList = List<Widget>();
    var cout = 0;
    for (var i = 0; i < dateList.length / 7; i++) {
      List<Widget> listUI = List<Widget>();
      for (var i = 0; i < 7; i++) {
        final date = dateList[cout];
        listUI.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 3),
                      child: Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.only(top: 2, bottom: 2, left: isStartDateRadius(date) ? 4 : 0, right: isEndDateRadius(date) ? 4 : 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: startDate != null && endDate != null
                                  ? getIsItStartAndEndDate(date) || getIsInRange(date)
                                      ? HotelAppTheme.buildLightTheme().primaryColor.withOpacity(0.4)
                                      : Colors.transparent
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                bottomLeft: isStartDateRadius(date) ? Radius.circular(24.0) : Radius.circular(0.0),
                                topLeft: isStartDateRadius(date) ? Radius.circular(24.0) : Radius.circular(0.0),
                                topRight: isEndDateRadius(date) ? Radius.circular(24.0) : Radius.circular(0.0),
                                bottomRight: isEndDateRadius(date) ? Radius.circular(24.0) : Radius.circular(0.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        onTap: () {
                          if (currentMonthDate.month == date.month) {
                            if (widget.minimumDate != null) {
                              var newminimumDate = DateTime(widget.minimumDate.year, widget.minimumDate.month, widget.minimumDate.day - 1);
                              if (date.isAfter(newminimumDate)) {
                                onDateClick(date);
                              }
                            } else {
                              onDateClick(date);
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                              color: getIsItStartAndEndDate(date) ? HotelAppTheme.buildLightTheme().primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                              border: Border.all(
                                color: getIsItStartAndEndDate(date) ? Colors.white : Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: getIsItStartAndEndDate(date)
                                  ? <BoxShadow>[
                                      BoxShadow(color: Colors.grey.withOpacity(0.6), blurRadius: 4, offset: Offset(0, 0)),
                                    ]
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                "${date.day}",
                                style: TextStyle(
                                    color: getIsItStartAndEndDate(date)
                                        ? Colors.white
                                        : currentMonthDate.month == date.month ? Colors.black : Colors.grey.withOpacity(0.6),
                                    fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                                    fontWeight: getIsItStartAndEndDate(date) ? FontWeight.bold : FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 9,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                            color: DateTime.now().day == date.day && DateTime.now().month == date.month  && DateTime.now().year == date.year
                                ? getIsInRange(date) ? Colors.white : HotelAppTheme.buildLightTheme().primaryColor
                                : Colors.transparent,
                            shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        cout += 1;
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  bool getIsInRange(DateTime date) {
    if (startDate != null && endDate != null) {
      if (date.isAfter(startDate) && date.isBefore(endDate)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool getIsItStartAndEndDate(DateTime date) {
    if (startDate != null && startDate.day == date.day && startDate.month == date.month && startDate.year == date.year) {
      return true;
    } else if (endDate != null && endDate.day == date.day && endDate.month == date.month && endDate.year == date.year) {
      return true;
    } else {
      return false;
    }
  }

  bool isStartDateRadius(DateTime date) {
    if (startDate != null && startDate.day == date.day && startDate.month == date.month) {
      return true;
    } else if (date.weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isEndDateRadius(DateTime date) {
    if (endDate != null && endDate.day == date.day && endDate.month == date.month) {
      return true;
    } else if (date.weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  void onDateClick(DateTime date) {
    if (startDate == null) {
      startDate = date;
    } else if (startDate != date && endDate == null) {
      endDate = date;
    } else if (startDate.day == date.day && startDate.month == date.month) {
      startDate = null;
    } else if (endDate.day == date.day && endDate.month == date.month) {
      endDate = null;
    }
    if (startDate == null && endDate != null) {
      startDate = endDate;
      endDate = null;
    }
    if (startDate != null && endDate != null) {
      if (!endDate.isAfter(startDate)) {
        var d = startDate;
        startDate = endDate;
        endDate = d;
      }
      if (date.isBefore(startDate)) {
        startDate = date;
      }
      if (date.isAfter(endDate)) {
        endDate = date;
      }
    }
    setState(() {
      try {
        widget.startEndDateChange(startDate, endDate);
      } catch (e) {}
    });
  }
}
