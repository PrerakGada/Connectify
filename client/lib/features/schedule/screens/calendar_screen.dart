import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:connectify/features/jobs/models/interview.dart';
import 'package:connectify/features/jobs/models/job.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

@RoutePage()
class CalendarScreen extends StatefulWidget {
  final bool isEmployee;
  final String? jobId;
  final String? applicantId;

  const CalendarScreen({
    super.key,
    required this.isEmployee,
    this.jobId,
    this.applicantId,
  });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late CalendarController _calendarController;
  bool get canSchedule => widget.jobId != null && widget.applicantId != null;
  DateTime? _selectedStartTime;
  DateTime? _selectedEndTime;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  List<Appointment> _getAppointments() {
    List<Appointment> appointments = [];
    for (var slot in sampleInterviewSlots) {
      // Assign different colors based on status or type
      Color appointmentColor = Colors.blue;
      if (slot.status == 'booked') {
        appointmentColor = Colors.green;
      } else if (slot.status == 'pending') {
        appointmentColor = Colors.orange;
      } else if (slot.status == 'cancelled') {
        appointmentColor = Colors.red;
      }

      appointments.add(
        Appointment(
          startTime: slot.dateTime,
          endTime: slot.dateTime.add(const Duration(hours: 1)),
          subject: slot.applicantId ?? 'Interview',
          color: appointmentColor,
          notes: slot.status, // Store status in notes for reference
        ),
      );
    }
    return appointments;
  }

  Future<void> _showScheduleDialog() async {
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
      _scheduleInterview(result['startTime'], result['endTime']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
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
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Joining call...'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
              onSelectionChanged: (CalendarSelectionDetails details) {
                if (details.date != null) {
                  setState(() {
                    _selectedStartTime = details.date;
                    _selectedEndTime =
                        details.date!.add(const Duration(hours: 1));
                  });
                }
              },
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
              dataSource: _AppointmentDataSource(_getAppointments()),
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
          if (_selectedStartTime != null && _selectedEndTime != null)
            Container(
              margin: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: canSchedule ? _showScheduleDialog : null,
                child: const Text('Schedule'),
              ),
            ),
        ],
      ),
    );
  }

  void _scheduleInterview(DateTime startTime, DateTime endTime) {
    if (!canSchedule) return;

    // Find the job and application
    final job = sampleJobs.firstWhere((j) => j.id == widget.jobId);
    final application =
        job.applications.firstWhere((a) => a.id == widget.applicantId);

    // Create new interview slot
    final newSlot = InterviewSlot(
      id: DateTime.now().toString(),
      dateTime: startTime,
      interviewerId: 'employer1', // TODO: Get from auth
      applicantId: application.id,
      jobId: job.id,
      status: 'booked',
    );

    // TODO: Add to list/database

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
