import 'package:connectify/features/auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:connectify/features/schedule/models/interview_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectify/features/schedule/cubits/interview_cubit/interview_cubit.dart';
import 'package:connectify/features/video_call/screens/video_call_screen.dart';
import 'package:connectify/features/video_call/cubits/video_call_cubit/video_call_cubit.dart';
import 'dart:async';

class CalendarScreen extends StatefulWidget {
  final bool isEmployee;
  final String? jobId;
  final String? applicantId;

  const CalendarScreen({
    required this.isEmployee,
    super.key,
    this.jobId,
    this.applicantId,
  });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController? _calendarController;
  bool get canSchedule =>
      widget.jobId != null && widget.applicantId != null && !widget.isEmployee;
  DateTime? _selectedStartTime;
  DateTime? _selectedEndTime;
  List<InterviewModel> _interviews = [];
  StreamSubscription? _videoCallSubscription;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _loadInterviews();
  }

  Future<void> _loadInterviews() async {
    await context.read<InterviewCubit>().getAllInterviews();
  }

  @override
  void dispose() {
    if (_calendarController != null) {
      _calendarController!.dispose();
    }
    _videoCallSubscription?.cancel();
    super.dispose();
  }

  List<Appointment> _getAppointments(List<InterviewModel> interviews) {
    List<Appointment> appointments = [];
    for (var interview in interviews) {
      appointments.add(
        Appointment(
          startTime: interview.startTime,
          endTime: interview.endTime,
          subject: interview.otherPartyName,
          color: Colors.blue,
          notes: 'Interview',
        ),
      );
    }
    return appointments;
  }

  Future<void> _showScheduleDialog(String currentUserId) async {
    if (_selectedStartTime == null) return;

    DateTime startDate = _selectedStartTime!;
    DateTime endDate = _selectedEndTime!;
    TimeOfDay startTime =
        TimeOfDay(hour: startDate.hour, minute: startDate.minute);
    TimeOfDay endTime = TimeOfDay(hour: endDate.hour, minute: endDate.minute);

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Schedule Interview'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Start Time'),
              subtitle: Text(
                  '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}'),
              trailing: IconButton(
                icon: const Icon(Icons.access_time),
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: startTime,
                  );
                  if (time != null) {
                    startTime = time;
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('End Time'),
              subtitle: Text(
                  '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}'),
              trailing: IconButton(
                icon: const Icon(Icons.access_time),
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: endTime,
                  );
                  if (time != null) {
                    endTime = time;
                  }
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final startDateTime = DateTime(
                startDate.year,
                startDate.month,
                startDate.day,
                startTime.hour,
                startTime.minute,
              );
              final endDateTime = DateTime(
                endDate.year,
                endDate.month,
                endDate.day,
                endTime.hour,
                endTime.minute,
              );
              Navigator.pop(context, {
                'startTime': startDateTime,
                'endTime': endDateTime,
              });
            },
            child: const Text('Schedule'),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() {
        _selectedStartTime = result['startTime'];
        _selectedEndTime = result['endTime'];
      });
      _scheduleInterview(currentUserId, result['startTime'], result['endTime']);
    }
  }

  void _handleVideoCall(InterviewModel interview) async {
    final authCubit = context.read<AuthCubit>();
    final authState = authCubit.state;
    if (authState is! AuthAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to join the call'),
        ),
      );
      return;
    }

    final videoCallCubit = context.read<VideoCallCubit>();
    await videoCallCubit.generateToken(
      channelName: interview.id,
      uid: authState.user.id,
      token: authState.user.token,
    );

    if (!mounted) return;

    _videoCallSubscription = videoCallCubit.stream.listen((state) {
      if (state is VideoCallTokenGenerated) {
        if (!mounted) return;
        debugPrint('Navigating to video call screen');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoCallScreen(
              channelName: interview.id,
              token: state.token.token,
              appId: state.token.appId,
              isHost: widget.isEmployee,
            ),
          ),
        ).then((_) {
          _videoCallSubscription?.cancel();
          _videoCallSubscription = null;
        });
      } else if (state is VideoCallError) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: BlocBuilder<InterviewCubit, InterviewState>(
        builder: (context, state) {
          if (state is InterviewLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InterviewError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is InterviewLoaded) {
            _interviews = state.interviews;
          }

          return Column(
            children: [
              Expanded(
                child: SfCalendar(
                  controller: _calendarController,
                  view: CalendarView.day,
                  showDatePickerButton: true,
                  headerHeight: 50,
                  viewHeaderHeight: 60,
                  allowViewNavigation: true,
                  allowAppointmentResize: false,
                  allowDragAndDrop: false,
                  initialDisplayDate: DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  appointmentBuilder: (context, details) {
                    return Container(
                      decoration: BoxDecoration(
                        color: details.appointments.first.color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                details.appointments.first.subject,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.video_call,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () async {
                              final interview = _interviews.firstWhere(
                                (i) =>
                                    i.startTime ==
                                    details.appointments.first.startTime,
                              );
                              _handleVideoCall(interview);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  // onSelectionChanged: (CalendarSelectionDetails details) {
                  //   if (details.date != null) {
                  //     setState(() {
                  //       _selectedStartTime = details.date;
                  //       _selectedEndTime =
                  //           details.date!.add(const Duration(hours: 1));
                  //     });
                  //   }
                  // },
                  timeSlotViewSettings: const TimeSlotViewSettings(
                    timeInterval: Duration(minutes: 60),
                    timeFormat: 'h:mm a',
                    startHour: 8,
                    endHour: 20,
                    timeIntervalHeight: 60,
                    timeTextStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                  dataSource:
                      _AppointmentDataSource(_getAppointments(_interviews)),
                  onTap: (CalendarTapDetails details) {
                    if (details.targetElement == CalendarElement.calendarCell) {
                      if (details.date != null) {
                        setState(() {
                          _selectedStartTime = details.date;
                          _selectedEndTime =
                              details.date!.add(const Duration(hours: 1));
                        });
                      }
                    }
                  },
                ),
              ),
              if (canSchedule &&
                  _selectedStartTime != null &&
                  _selectedEndTime != null)
                Container(
                  margin: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: canSchedule
                        ? () {
                            final authCubit = context.read<AuthCubit>();
                            final currentUserId =
                                (authCubit.state as AuthAuthenticated).user.id;
                            _showScheduleDialog(currentUserId);
                          }
                        : null,
                    child: const Text('Schedule'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _scheduleInterview(
      String currentUserId, DateTime startTime, DateTime endTime) {
    if (!canSchedule) return;

    final istStartTime =
        startTime.toUtc().add(const Duration(hours: 5, minutes: 30));
    final istEndTime =
        endTime.toUtc().add(const Duration(hours: 5, minutes: 30));

    context.read<InterviewCubit>().scheduleInterview(
          employeeId: widget.applicantId!,
          employerId: currentUserId,
          startTime: istStartTime,
          endTime: istEndTime,
        );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Interview scheduled successfully!'),
      ),
    );

    setState(() {
      _selectedStartTime = null;
      _selectedEndTime = null;
    });
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
