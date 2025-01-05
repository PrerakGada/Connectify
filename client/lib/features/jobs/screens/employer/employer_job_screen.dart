import 'package:connectify/features/auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:connectify/features/jobs/screens/employer/create_job_screen.dart';
import 'package:connectify/features/jobs/screens/employer/employer_job_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectify/features/jobs/cubits/job_cubit/job_cubit.dart';

class EmployerJobScreen extends StatefulWidget {
  const EmployerJobScreen({
    super.key,
  });

  @override
  State<EmployerJobScreen> createState() => _EmployerJobScreenState();
}

class _EmployerJobScreenState extends State<EmployerJobScreen> {
  @override
  void initState() {
    super.initState();
    final auth = (context.read<AuthCubit>().state) as AuthAuthenticated;
    context.read<JobCubit>().getEmployerJobs(auth.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CreateJobScreen(),
              ));
            },
          ),
        ],
      ),
      body: BlocBuilder<JobCubit, JobState>(
        builder: (context, state) {
          if (state is JobLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JobError) {
            return Center(child: Text(state.message));
          } else if (state is JobLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.jobs.length,
              itemBuilder: (context, index) {
                final job = state.jobs[index];
                return Card(
                  child: ListTile(
                    title: Text(job.role),
                    subtitle: Text(job.pay),
                    trailing: Text('0 applications'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EmployerJobDetailsScreen(
                          job: job,
                        ),
                      ));
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No jobs found'));
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
