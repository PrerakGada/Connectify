import 'package:auto_route/auto_route.dart';
import 'package:connectify/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/job.dart';

class JobsScreen extends StatefulWidget {
  final bool isEmployee;

  const JobsScreen({
    super.key,
    required this.isEmployee,
  });

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  bool _isMapView = false;
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _updateMarkers();
  }

  void _updateMarkers() {
    _markers.clear();
    for (var job in sampleJobs) {
      _markers.add(
        Marker(
          markerId: MarkerId(job.id),
          position: LatLng(job.latitude, job.longitude),
          infoWindow: InfoWindow(
            title: job.role,
            snippet: job.pay,
            onTap: () {
              context.router.push(EmployeeJobDetailsRoute(job: job));
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
          if (widget.isEmployee)
            IconButton(
              icon: Icon(_isMapView ? Icons.list : Icons.map),
              onPressed: () {
                setState(() {
                  _isMapView = !_isMapView;
                });
              },
            ),
          if (!widget.isEmployee)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                context.router.push(const CreateJobRoute());
              },
            ),
        ],
      ),
      body: _isMapView
          ? GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(40.7128, -74.0060),
                zoom: 12,
              ),
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: sampleJobs.length,
              itemBuilder: (context, index) {
                final job = sampleJobs[index];
                return Card(
                  child: ListTile(
                    title: Text(job.role),
                    subtitle: Text(job.pay),
                    trailing: widget.isEmployee
                        ? null
                        : Text('${job.applications.length} applications'),
                    onTap: () {
                      if (widget.isEmployee) {
                        context.router.push(EmployeeJobDetailsRoute(job: job));
                      } else {
                        context.router.push(EmployerJobDetailsRoute(job: job));
                      }
                    },
                  ),
                );
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
