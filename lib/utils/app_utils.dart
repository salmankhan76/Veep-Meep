import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static TimeOfDay getTimeFromString(String time) {
    return TimeOfDay(
        hour: int.parse(time.split(':')[0]),
        minute: int.parse(time.split(':')[1].split(' ')[0]));
  }

  static String convertTimeOfDayToAPIFormat(TimeOfDay value) {
    return '${value.hour}:${value.minute}:00';
  }

  static String convertTimeToAPIFormat(String value) {
    final time = getTimeFromString(value);
    return convertTimeOfDayToAPIFormat(time);
  }

  static String convertToCurrency(double amount,
      {bool shouldAddSymbol = true}) {
    return '${shouldAddSymbol ? 'Rs ' : ''}${NumberFormat.currency(symbol: '')
        .format(amount)}';
  }

  static String getOnlineStatus(DateTime lastActive) {
    final difference = DateTime.now().difference(lastActive);
    if (difference.inDays > 365) {
      int years = (difference.inDays / 365).toInt();
      if (years == 1) {
        return "$years year ago";
      } else {
        return "$years years ago";
      }
    } else if (difference.inDays > 30) {
      int months = (difference.inDays / 30).toInt();
      if (months == 1) {
        return "$months month ago";
      } else {
        return "$months months ago";
      }
    } else if (difference.inDays >= 1) {
      if (difference.inDays == 1) {
        return "1 day ago";
      } else {
        return "${difference.inDays} days ago";
      }
    } else if (difference.inHours >= 1) {
      if (difference.inHours == 1) {
        return "1 hour ago";
      } else {
        return "${difference.inHours} hours ago";
      }
    } else {
      if (difference.inMinutes >= 2) {
        return "${difference.inMinutes} minutes ago";
      } else {
        return "Recently Active";
      }
    }
  }

  static String getLeftTime(DateTime timeExpire) {
    final difference = DateTime.now().difference(timeExpire);
    if (difference.inDays > 365) {
      int years = (difference.inDays / 365).toInt();
      if (years == 1) {
        return "$years year left";
      } else {
        return "$years years left";
      }
    } else if (difference.inDays > 30) {
      int months = (difference.inDays / 30).toInt();
      if (months == 1) {
        return "$months month left";
      } else {
        return "$months months left";
      }
    } else if (difference.inDays >= 1) {
      if (difference.inDays == 1) {
        return "1 day left";
      } else {
        return "${difference.inDays} days left";
      }
    } else if (difference.inHours >= 1) {
      if (difference.inHours == 1) {
        return "1 hour left";
      } else {
        return "${difference.inHours} hours left";
      }
    } else {
      if (difference.inMinutes >= 2) {
        return "${difference.inMinutes} minutes left";
      } else {
        return "Time Expired";
      }
    }
  }
}
