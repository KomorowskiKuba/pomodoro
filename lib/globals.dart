library pomodoro.globals;

import 'package:intl/intl.dart';

enum AppState {session, shortBreak, longBreak}

const String longBreakDurationName = 'LONGBREAKDURATION';
const String shortBreakDurationName = 'SHORTBREAKDURATION';
const String sessionDurationName = 'SESSIONDURATION';

const String amountOfSessionsName = 'AMOUNTOFSESSIONS';
const String autoStartBreaksEnabledName = 'AUTOSTARTBREAKSENABLED';
const String autoStartSessionsEnabledName = 'AUTOSTARTSESSIONSENABLED';

const String notificationsEnabledName = 'NOTIFICATIONSENABLEDNAME';
const String vibrationsEnabledName = 'VIBRATIONSENABLEDNAME';
const String keepPhoneAwakeEnabledName = 'KEEPPHONEAWAKEENABLEDNAME';

final DateFormat dateFormat = DateFormat('mm:ss');