import 'job.dart';

class InterviewSlot {
  final String id;
  final DateTime dateTime;
  final String interviewerId;
  final String? applicantId;
  final String? jobId;
  final String status; // 'available', 'booked', 'completed', 'cancelled'

  InterviewSlot({
    required this.id,
    required this.dateTime,
    required this.interviewerId,
    this.applicantId,
    this.jobId,
    this.status = 'available',
  });
}

// Sample data for testing
final List<InterviewSlot> sampleInterviewSlots = [
  // Today's interviews
  InterviewSlot(
    id: '1',
    dateTime: DateTime.now().copyWith(hour: 10),
    interviewerId: 'employer1',
    applicantId: 'John Doe',
    jobId: '1',
    status: 'booked',
  ),
  InterviewSlot(
    id: '2',
    dateTime: DateTime.now().copyWith(hour: 14),
    interviewerId: 'employer1',
    applicantId: 'Jane Smith',
    jobId: '1',
    status: 'booked',
  ),
  InterviewSlot(
    id: '3',
    dateTime: DateTime.now().copyWith(hour: 15),
    interviewerId: 'employer1',
    applicantId: 'Mike Johnson',
    jobId: '2',
    status: 'booked',
  ),

  // Tomorrow's interviews
  InterviewSlot(
    id: '4',
    dateTime: DateTime.now().add(const Duration(days: 1)).copyWith(hour: 11),
    interviewerId: 'employer1',
    applicantId: 'Sarah Wilson',
    jobId: '1',
    status: 'booked',
  ),
  InterviewSlot(
    id: '5',
    dateTime: DateTime.now().add(const Duration(days: 1)).copyWith(hour: 11),
    interviewerId: 'employer1',
    applicantId: 'David Brown',
    jobId: '2',
    status: 'booked',
  ),
  InterviewSlot(
    id: '6',
    dateTime: DateTime.now().add(const Duration(days: 1)).copyWith(hour: 16),
    interviewerId: 'employer1',
    applicantId: 'Emily Davis',
    jobId: '1',
    status: 'booked',
  ),

  // Day after tomorrow's interviews
  InterviewSlot(
    id: '7',
    dateTime: DateTime.now().add(const Duration(days: 2)).copyWith(hour: 9),
    interviewerId: 'employer1',
    applicantId: 'Robert Taylor',
    jobId: '2',
    status: 'booked',
  ),
  InterviewSlot(
    id: '8',
    dateTime: DateTime.now().add(const Duration(days: 2)).copyWith(hour: 13),
    interviewerId: 'employer1',
    applicantId: 'Lisa Anderson',
    jobId: '1',
    status: 'booked',
  ),
  InterviewSlot(
    id: '9',
    dateTime: DateTime.now().add(const Duration(days: 2)).copyWith(hour: 13),
    interviewerId: 'employer1',
    applicantId: 'Tom Wilson',
    jobId: '2',
    status: 'booked',
  ),
  InterviewSlot(
    id: '10',
    dateTime: DateTime.now().add(const Duration(days: 2)).copyWith(hour: 13),
    interviewerId: 'employer1',
    applicantId: 'Mary Johnson',
    jobId: '1',
    status: 'booked',
  ),

  // Next week's interviews
  InterviewSlot(
    id: '11',
    dateTime: DateTime.now().add(const Duration(days: 7)).copyWith(hour: 10),
    interviewerId: 'employer1',
    applicantId: 'James Miller',
    jobId: '1',
    status: 'booked',
  ),
  InterviewSlot(
    id: '12',
    dateTime: DateTime.now().add(const Duration(days: 7)).copyWith(hour: 14),
    interviewerId: 'employer1',
    applicantId: 'Patricia White',
    jobId: '2',
    status: 'booked',
  ),
];
