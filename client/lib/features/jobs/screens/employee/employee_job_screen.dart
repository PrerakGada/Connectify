import 'package:connectify/features/auth/cubits/user_details_cubit/user_details_cubit.dart';
import 'package:connectify/features/jobs/screens/employee/employee_job_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:connectify/features/jobs/models/job_model/job_model.dart';
import 'package:connectify/features/jobs/cubits/job_cubit/job_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectify/features/auth/cubits/auth_cubit/auth_cubit.dart';

class EmployeeJobScreen extends StatefulWidget {
  const EmployeeJobScreen({
    super.key,
  });

  @override
  State<EmployeeJobScreen> createState() => _EmployeeJobScreenState();
}

class _EmployeeJobScreenState extends State<EmployeeJobScreen> {
  bool _isMapView = false;
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  void _loadJobs() {
    final auth = (context.read<AuthCubit>().state) as AuthAuthenticated;
    context.read<JobCubit>().getJobsByDistance(auth.user.id);
  }

  void _updateMarkers(List<Job> jobs) {
    _markers.clear();
    for (var job in jobs) {
      _markers.add(
        Marker(
          markerId: MarkerId(job.id),
          position: LatLng(job.latitude, job.longitude),
          infoWindow: InfoWindow(
            title: job.role,
            snippet: job.pay,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EmployeeJobDetailsScreen(
                  job: job,
                ),
              ));
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        actions: [
          IconButton(
            icon: Icon(_isMapView ? Icons.list : Icons.map),
            onPressed: () {
              setState(() {
                _isMapView = !_isMapView;
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<JobCubit, JobState>(
        builder: (context, state) {
          if (state is JobLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is JobError) {
            return Center(child: Text(state.message));
          }
          if (state is JobLoaded) {
            final jobs = state.jobs;
            if (_isMapView) {
              _updateMarkers(jobs);
              final userDetails =
                  (context.read<UserDetailsCubit>().state) as UserDetailsLoaded;
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    userDetails.userDetails.latitude,
                    userDetails.userDetails.longitude,
                  ),
                  zoom: 12,
                ),
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                return Card(
                  child: ListTile(
                    title: Text(job.role),
                    subtitle: Text(job.pay),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EmployeeJobDetailsScreen(
                          job: job,
                        ),
                      ));
                    },
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_mapController != null) {
      _mapController!.dispose();
    }
    super.dispose();
  }
}
