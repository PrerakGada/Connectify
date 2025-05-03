import 'package:connectify/core/constants/job_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../core/services/location_service.dart';
import '../cubits/user_details_cubit/user_details_cubit.dart';
import '../models/user_details_model/user_details_model.dart' as user_details;
import '../cubits/auth_cubit/auth_cubit.dart';
import '../../home/screens/home_screen.dart';
// import '../../home/screens/home_screen.dart';

class EmployeeInfoScreen extends StatefulWidget {
  const EmployeeInfoScreen({super.key});

  @override
  State<EmployeeInfoScreen> createState() => _EmployeeInfoScreenState();
}

class _EmployeeInfoScreenState extends State<EmployeeInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _extraCurricularsController = TextEditingController();
  final _achievementsController = TextEditingController();
  final _portfolioLinksController = TextEditingController();
  final _locationController = TextEditingController();
  File? _image;
  Position? _currentPosition;
  String? _currentAddress;
  final List<user_details.ExperienceModel> _experiences = [
    user_details.ExperienceModel(
        role: '', company: '', duration: '', location: '', description: '')
  ];
  final List<user_details.EducationModel> _educations = [
    user_details.EducationModel(
        instituteName: '', duration: '', type: '', courseName: '')
  ];
  final List<String> _selectedSkills = [];
  final List<String> _selectedRoles = [];

  // Add controllers for experience and education
  final List<Map<String, TextEditingController>> _experienceControllers = [
    {
      'role': TextEditingController(),
      'company': TextEditingController(),
      'duration': TextEditingController(),
      'location': TextEditingController(),
      'description': TextEditingController(),
    }
  ];
  final List<Map<String, TextEditingController>> _educationControllers = [
    {
      'instituteName': TextEditingController(),
      'duration': TextEditingController(),
      'type': TextEditingController(),
      'courseName': TextEditingController(),
    }
  ];
  final List<String> _educationTypes = [
    'High School',
    'Diploma',
    'Bachelor\'s',
    'Master\'s',
    'PhD',
    'Other'
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
          _locationController.text = address;
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
  void dispose() {
    _emailController.dispose();
    _contactController.dispose();
    _extraCurricularsController.dispose();
    _achievementsController.dispose();
    _portfolioLinksController.dispose();
    _locationController.dispose();
    for (var controllers in _experienceControllers) {
      controllers.values.forEach((controller) => controller.dispose());
    }
    for (var controllers in _educationControllers) {
      controllers.values.forEach((controller) => controller.dispose());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDetailsCubit, UserDetailsState>(
      listener: (context, state) {
        if (state is UserDetailsLoaded) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                isEmployee: state.userDetails.isEmployee,
              ),
            ),
            (route) => false,
          );
        } else if (state is UserDetailsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
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
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child:
                          _image == null ? const Icon(Icons.add_a_photo) : null,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                TextFormField(
                  controller: _emailController,
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
                        controller: _locationController,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          hintText: 'Click to get location',
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
                  controller: _contactController,
                  decoration:
                      const InputDecoration(labelText: 'Contact Number'),
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Please enter your contact number'
                      : null,
                ),
                const SizedBox(height: 24),

                // Experience Section
                const Text('Experience',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ..._experiences.asMap().entries.map((entry) {
                  int index = entry.key;
                  final controllers = _experienceControllers[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controllers['role'],
                            decoration:
                                const InputDecoration(labelText: 'Role'),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Please enter role'
                                : null,
                          ),
                          TextFormField(
                            controller: controllers['company'],
                            decoration:
                                const InputDecoration(labelText: 'Company'),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Please enter company'
                                : null,
                          ),
                          TextFormField(
                            controller: controllers['duration'],
                            decoration:
                                const InputDecoration(labelText: 'Duration'),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Please enter duration'
                                : null,
                          ),
                          TextFormField(
                            controller: controllers['location'],
                            decoration:
                                const InputDecoration(labelText: 'Location'),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Please enter location'
                                : null,
                          ),
                          TextFormField(
                            controller: controllers['description'],
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
                                  _experiences.add(user_details.ExperienceModel(
                                      role: '',
                                      company: '',
                                      duration: '',
                                      location: '',
                                      description: ''));
                                  _experienceControllers.add({
                                    'role': TextEditingController(),
                                    'company': TextEditingController(),
                                    'duration': TextEditingController(),
                                    'location': TextEditingController(),
                                    'description': TextEditingController(),
                                  });
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
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ..._educations.asMap().entries.map((entry) {
                  int index = entry.key;
                  final controllers = _educationControllers[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controllers['instituteName'],
                            decoration: const InputDecoration(
                                labelText: 'Institute Name'),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Please enter institute name'
                                : null,
                          ),
                          TextFormField(
                            controller: controllers['duration'],
                            decoration:
                                const InputDecoration(labelText: 'Duration'),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Please enter duration'
                                : null,
                          ),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                                labelText: 'Education Type'),
                            items: _educationTypes.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            value: controllers['type']!.text.isEmpty
                                ? null
                                : controllers['type']!.text,
                            onChanged: (value) {
                              if (value != null) {
                                controllers['type']!.text = value;
                              }
                            },
                            validator: (value) => value == null
                                ? 'Please select education type'
                                : null,
                          ),
                          TextFormField(
                            controller: controllers['courseName'],
                            decoration: const InputDecoration(
                                labelText: 'Course Name (if applicable)'),
                          ),
                          if (index == _educations.length - 1)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _educations.add(user_details.EducationModel(
                                      instituteName: '',
                                      duration: '',
                                      type: '',
                                      courseName: ''));
                                  _educationControllers.add({
                                    'instituteName': TextEditingController(),
                                    'duration': TextEditingController(),
                                    'type': TextEditingController(),
                                    'courseName': TextEditingController(),
                                  });
                                });
                              },
                              child: const Text('Add Another Education'),
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 24),

                // Skills Section
                const Text('Skills',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 8.0,
                  children: JobConstants.technicalSkills.map((skill) {
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
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 8.0,
                  children: JobConstants.possibleRoles.map((role) {
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
                  controller: _extraCurricularsController,
                  decoration:
                      const InputDecoration(labelText: 'Extra Curriculars'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _achievementsController,
                  decoration: const InputDecoration(labelText: 'Achievements'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _portfolioLinksController,
                  decoration:
                      const InputDecoration(labelText: 'Portfolio Links'),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final authState = context.read<AuthCubit>().state;
                        if (authState is AuthAuthenticated) {
                          // Create experience models from controllers
                          final experiences =
                              _experienceControllers.map((controllers) {
                            return user_details.ExperienceModel(
                              role: controllers['role']!.text,
                              company: controllers['company']!.text,
                              duration: controllers['duration']!.text,
                              location: controllers['location']!.text,
                              description: controllers['description']!.text,
                            );
                          }).toList();

                          // Create education models from controllers
                          final educations =
                              _educationControllers.map((controllers) {
                            return user_details.EducationModel(
                              instituteName: controllers['instituteName']!.text,
                              duration: controllers['duration']!.text,
                              type: controllers['type']!.text,
                              courseName: controllers['courseName']!.text,
                            );
                          }).toList();

                          final userDetails = user_details.UserDetailsModel(
                            userId: authState.user.id,
                            isEmployee: true,
                            email: _emailController.text,
                            latitude: _currentPosition?.latitude ?? 0.0,
                            longitude: _currentPosition?.longitude ?? 0.0,
                            address: _currentAddress ?? '',
                            imageLink: '',
                            contactNumber: _contactController.text,
                            experiences: experiences,
                            educations: educations,
                            skills: _selectedSkills,
                            desiredRoles: _selectedRoles,
                            extraCurriculars: _extraCurricularsController.text,
                            achievements: _achievementsController.text,
                            portfolioLinks: _portfolioLinksController.text,
                          );
                          context
                              .read<UserDetailsCubit>()
                              .postUserDetails(userDetails);
                        }
                      }
                    },
                    child: const Text('Save Profile'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
