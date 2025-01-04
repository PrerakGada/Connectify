import 'package:auto_route/auto_route.dart';
import 'package:connectify/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../core/services/location_service.dart';
import '../../home/screens/home_screen.dart';

@RoutePage()
class EmployerInfoScreen extends StatefulWidget {
  const EmployerInfoScreen({super.key});

  @override
  State<EmployerInfoScreen> createState() => _EmployerInfoScreenState();
}

class _EmployerInfoScreenState extends State<EmployerInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  Position? _currentPosition;
  String? _currentAddress;

  Future<void> _getCurrentLocation() async {
    final position = await LocationService.getCurrentLocation();
    if (position != null) {
      setState(() {
        _currentPosition = position;
      });

      // Get address from coordinates
      final address = await LocationService.getAddressFromLatLng(position);
      if (address != null) {
        setState(() {
          _currentAddress = address;
        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Could not get location. Please check your location permissions.')),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Company Profile'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Logo
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child:
                        _image == null ? const Icon(Icons.add_a_photo) : null,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Basic Info
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value?.isEmpty ?? true
                    ? 'Please enter company email'
                    : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Company Name'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter company name' : null,
              ),
              const SizedBox(height: 16),

              // Location
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Company Location',
                        hintText: _currentAddress ?? 'Click to get location',
                      ),
                      readOnly: true,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.location_on),
                    onPressed: _getCurrentLocation,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // if (_formKey.currentState?.validate() ?? false) {
                      context.router.push(HomeRoute(isEmployee: false));
                    // }
                  },
                  child: const Text('Save Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
