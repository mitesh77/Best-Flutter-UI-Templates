import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'hotel_app_theme.dart';

class CustomCalendarView extends StatefulWidget {
  const CustomCalendarView(
      {required this.initialStartDate,
      required this.initialEndDate,
      required this.startEndDateChange,
      this.minimumDate,
      this.maximumDate,
      Key? key})
      : super(key: key);

  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final DateTime initialStartDate;
  final DateTime initialEndDate;

  final Function(DateTime, DateTime) startEndDateChange;

  @override
  _CustomCalendarViewState createState() => _CustomCalendarViewState();
}

class _CustomCalendarViewState extends State<CustomCalendarView> {
  List<DateTime> dateList = <DateTime>[];
  DateTime currentMonthDate = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    setListOfDate(currentMonthDate);
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setListOfDate(DateTime monthDate) {
    dateList.clear();
    final DateTime newDate = DateTime(monthDate.year, monthDate.month, 0);
    int previousMothDay = 0;
    if (newDate.weekday < 7) {
      previousMothDay = newDate.weekday;
      for (int i = 1; i <= previousMothDay; i++) {
        dateList.add(newDate.subtract(Duration(days: previousMothDay - i)));
      }
    }
    for (int i = 0; i < (42 - previousMothDay); i++) {
      dateList.add(newDate.add(Duration(days: i + 1)));
    }
    // if (dateList[dateList.length - 7].month != monthDate.month) {
    //   dateList.removeRange(dateList.length - 7, dateList.length);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
                      borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                      border: Border.all(
                        color: HotelAppTheme.buildLightTheme().dividerColor,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                      onTap: () {
                        if (mounted) {
                          setState(() {
                            currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month, 0);
                            setListOfDate(currentMonthDate);
                          });
                        }
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      DateFormat('MMMM, yyyy').format(currentMonthDate),
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                      border: Border.all(
                        color: HotelAppTheme.buildLightTheme().dividerColor,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                      onTap: () {
                        if (mounted) {
                          setState(() {
                            currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month + 2, 0);
                            setListOfDate(currentMonthDate);
                          });
                        }
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
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
    final List<Widget> listUI = <Widget>[];
    for (int i = 0; i < 7; i++) {
      listUI.add(
        Expanded(
          child: Center(
            child: Text(
              DateFormat('EEE').format(dateList[i]),
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: HotelAppTheme.buildLightTheme().primaryColor),
            ),
          ),
        ),
      );
    }
    return listUI;
  }

  List<Widget> getDaysNoUI() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    for (int i = 0; i < dateList.length / 7; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < 7; i++) {
        final DateTime date = dateList[count];
        listUI.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                          left: isStartDateRadius(date) ? 4 : 0,
                          right: isEndDateRadius(date) ? 4 : 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: startDate != null && endDate != null
                              ? getIsItStartAndEndDate(date) || getIsInRange(date)
                                  ? HotelAppTheme.buildLightTheme().primaryColor.withOpacity(0.4)
                                  : Colors.transparent
                              : Colors.transparent,
                          borderRadius: BorderRadius.only(
                            bottomLeft:
                                isStartDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                            topLeft:
                                isStartDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                            topRight:
                                isEndDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                            bottomRight:
                                isEndDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                    onTap: () {
                      if (currentMonthDate.month == date.month) {
                        final DateTime? minimumDate = widget.minimumDate;
                        final DateTime? maximumDate = widget.maximumDate;
                        if (minimumDate != null && maximumDate != null) {
                          final DateTime newminimumDate =
                              DateTime(minimumDate.year, minimumDate.month, minimumDate.day - 1);
                          final DateTime newmaximumDate =
                              DateTime(maximumDate.year, maximumDate.month, maximumDate.day + 1);
                          if (date.isAfter(newminimumDate) && date.isBefore(newmaximumDate)) {
                            onDateClick(date);
                          }
                        } else if (minimumDate != null) {
                          final DateTime newminimumDate =
                              DateTime(minimumDate.year, minimumDate.month, minimumDate.day - 1);
                          if (date.isAfter(newminimumDate)) {
                            onDateClick(date);
                          }
                        } else if (maximumDate != null) {
                          final DateTime newmaximumDate =
                              DateTime(maximumDate.year, maximumDate.month, maximumDate.day + 1);
                          if (date.isBefore(newmaximumDate)) {
                            onDateClick(date);
                          }
                        } else {
                          onDateClick(date);
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: getIsItStartAndEndDate(date)
                              ? HotelAppTheme.buildLightTheme().primaryColor
                              : Colors.transparent,
                          borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                          border: Border.all(
                            color: getIsItStartAndEndDate(date) ? Colors.white : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: getIsItStartAndEndDate(date)
                              ? <BoxShadow>[
                                  BoxShadow(color: Colors.grey.withOpacity(0.6), blurRadius: 4),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: TextStyle(
                                color: getIsItStartAndEndDate(date)
                                    ? Colors.white
                                    : currentMonthDate.month == date.month
                                        ? Colors.black
                                        : Colors.grey.withOpacity(0.6),
                                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                                fontWeight: getIsItStartAndEndDate(date) ? FontWeight.bold : FontWeight.normal),
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
                          color: DateTime.now().day == date.day &&
                                  DateTime.now().month == date.month &&
                                  DateTime.now().year == date.year
                              ? getIsInRange(date)
                                  ? Colors.white
                                  : HotelAppTheme.buildLightTheme().primaryColor
                              : Colors.transparent,
                          shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        count += 1;
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  bool getIsInRange(DateTime date) {
    final DateTime? _startDate = startDate;
    final DateTime? _endDate = endDate;
    if (_startDate != null && _endDate != null) {
      if (date.isAfter(_startDate) && date.isBefore(_endDate)) {
        return true;
      }
    }
    return false;
  }

  bool getIsItStartAndEndDate(DateTime date) {
    final DateTime? _startDate = startDate;
    final DateTime? _endDate = endDate;
    if ((_startDate != null &&
            _startDate.day == date.day &&
            _startDate.month == date.month &&
            _startDate.year == date.year) ||
        (_endDate != null &&
            _endDate.day == date.day &&
            _endDate.month == date.month &&
            _endDate.year == date.year)) return true;
    return false;
  }

  bool isStartDateRadius(DateTime date) {
    final DateTime? _startDate = startDate;
    if (_startDate != null && _startDate.day == date.day && _startDate.month == date.month) {
      return true;
    } else if (date.weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isEndDateRadius(DateTime date) {
    final DateTime? _endDate = endDate;
    if (_endDate != null && _endDate.day == date.day && _endDate.month == date.month) {
      return true;
    } else if (date.weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  void onDateClick(DateTime date) {
    final DateTime? _startDate = startDate;
    final DateTime? _endDate = endDate;
    if (_startDate == null) {
      startDate = date;
    } else if (startDate != date && endDate == null) {
      endDate = date;
    } else if (_startDate.day == date.day && _startDate.month == date.month) {
      startDate = null;
    } else if (_endDate != null && _endDate.day == date.day && _endDate.month == date.month) {
      endDate = null;
    }
    if (startDate == null && endDate != null) {
      startDate = endDate;
      endDate = null;
    }
    if (_startDate != null && _endDate != null) {
      if (!_endDate.isAfter(_startDate)) {
        final DateTime d = _startDate;
        startDate = endDate;
        endDate = d;
      }
      if (date.isBefore(_startDate)) {
        startDate = date;
      } else if (date.isAfter(_endDate)) {
        endDate = date;
      } else {
        final int daysToStartDate = _startDate.difference(date).inDays.abs();
        final int daysToEndDate = _endDate.difference(date).inDays.abs();
        daysToStartDate > daysToEndDate ? endDate = date : startDate = date;
      }
    }
    if (mounted) {
      setState(
        () {
          if (_startDate != null && _endDate != null) {
            try {
              widget.startEndDateChange(_startDate, _endDate);
            } catch (_) {}
          }
        },
      );
    }
  }
}
