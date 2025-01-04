import 'package:connectify/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/experience.dart';
import '../models/education.dart';
import '../../../core/services/location_service.dart';
// import '../../home/screens/home_screen.dart';

class EmployeeInfoScreen extends StatefulWidget {
  const EmployeeInfoScreen({super.key});

  @override
  State<EmployeeInfoScreen> createState() => _EmployeeInfoScreenState();
}

class _EmployeeInfoScreenState extends State<EmployeeInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  Position? _currentPosition;
  String? _currentAddress;
  final List<Experience> _experiences = [
    Experience(
        role: '', company: '', duration: '', location: '', description: '')
  ];
  final List<Education> _education = [];
  final List<String> _selectedSkills = [];
  final List<String> _selectedRoles = [];

  // Predefined lists
  final List<String> _technicalSkills = [
    'JavaScript',
    'Python',
    'Java',
    'C++',
    'Ruby',
    'PHP',
    'Swift',
    'Kotlin',
    'React',
    'Angular',
    'Vue.js',
    'Node.js',
    'Django',
    'Flask',
    'Spring',
    'AWS',
    'Azure',
    'GCP',
    'Docker',
    'Kubernetes',
    'SQL',
    'NoSQL',
    'Machine Learning',
    'AI',
    'Data Science',
    'DevOps',
    'UI/UX Design'
  ];

  final List<String> _possibleRoles = [
    'Software Engineer',
    'Frontend Developer',
    'Backend Developer',
    'Full Stack Developer',
    'DevOps Engineer',
    'Data Scientist',
    'Machine Learning Engineer',
    'Product Manager',
    'UI/UX Designer',
    'Mobile Developer',
    'QA Engineer',
    'System Administrator',
    'Cloud Architect',
    'Security Engineer',
    'Technical Lead'
  ];

  Future<void> _getCurrentLocation() async {
    final position = await LocationService.getCurrentLocation();
    if (position != null) {
      setState(() {
        _currentPosition = position;
      });

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
        title: const Text('Complete Your Profile'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
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
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter your email' : null,
              ),
              const SizedBox(height: 16),

              // Location
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Location',
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
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Contact Number'),
                validator: (value) => value?.isEmpty ?? true
                    ? 'Please enter your contact number'
                    : null,
              ),
              const SizedBox(height: 24),

              // Experience Section
              const Text('Experience',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ..._experiences.asMap().entries.map((entry) {
                int index = entry.key;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Role'),
                          validator: (value) => value?.isEmpty ?? true
                              ? 'Please enter role'
                              : null,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Company'),
                          validator: (value) => value?.isEmpty ?? true
                              ? 'Please enter company'
                              : null,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Duration'),
                          validator: (value) => value?.isEmpty ?? true
                              ? 'Please enter duration'
                              : null,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Location'),
                          validator: (value) => value?.isEmpty ?? true
                              ? 'Please enter location'
                              : null,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Description'),
                          maxLines: 3,
                          validator: (value) => value?.isEmpty ?? true
                              ? 'Please enter description'
                              : null,
                        ),
                        if (index == _experiences.length - 1)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _experiences.add(Experience(
                                    role: '',
                                    company: '',
                                    duration: '',
                                    location: '',
                                    description: ''));
                              });
                            },
                            child: const Text('Add Another Experience'),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              const SizedBox(height: 24),

              // Education Section
              const Text('Education',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Institute Name'),
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter institute name'
                            : null,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Duration'),
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter duration'
                            : null,
                      ),
                      DropdownButtonFormField<EducationType>(
                        decoration:
                            const InputDecoration(labelText: 'Education Type'),
                        items: EducationType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type.toString().split('.').last),
                          );
                        }).toList(),
                        onChanged: (value) {},
                        validator: (value) => value == null
                            ? 'Please select education type'
                            : null,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Course Name (if applicable)'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Skills Section
              const Text('Skills',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8.0,
                children: _technicalSkills.map((skill) {
                  return FilterChip(
                    label: Text(skill),
                    selected: _selectedSkills.contains(skill),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedSkills.add(skill);
                        } else {
                          _selectedSkills.remove(skill);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Desired Roles Section
              const Text('Desired Roles',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8.0,
                children: _possibleRoles.map((role) {
                  return FilterChip(
                    label: Text(role),
                    selected: _selectedRoles.contains(role),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedRoles.add(role);
                        } else {
                          _selectedRoles.remove(role);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Additional Sections
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Extra Curriculars'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Achievements'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Portfolio Links'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // if (_formKey.currentState?.validate() ?? false) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen(isEmployee: true),
                    ));
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
