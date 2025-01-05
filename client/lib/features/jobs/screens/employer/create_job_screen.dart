import 'package:connectify/features/auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:connectify/features/auth/cubits/user_details_cubit/user_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectify/core/constants/job_constants.dart';
import 'package:connectify/features/jobs/models/job_model/job_model.dart';
import 'package:connectify/features/jobs/cubits/job_cubit/job_cubit.dart';

class CreateJobScreen extends StatefulWidget {
  const CreateJobScreen({super.key});

  @override
  State<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedRole;
  final _payController = TextEditingController();
  final List<String> _selectedSkills = [];
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _payController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Job'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Role Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Role'),
                value: _selectedRole,
                items: JobConstants.possibleRoles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a role' : null,
              ),
              const SizedBox(height: 16),

              // Pay
              TextFormField(
                controller: _payController,
                decoration: const InputDecoration(labelText: 'Pay Range'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter pay range' : null,
              ),
              const SizedBox(height: 16),

              // Required Skills
              const Text('Required Skills',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Job Description'),
                maxLines: 5,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Please enter job description'
                    : null,
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final userDetails = (context
                          .read<UserDetailsCubit>()
                          .state) as UserDetailsLoaded;
                      final auth = (context.read<AuthCubit>().state)
                          as AuthAuthenticated;

                      context.read<JobCubit>().createJob(
                            role: _selectedRole!,
                            pay: _payController.text,
                            requiredSkills: _selectedSkills,
                            description: _descriptionController.text,
                            employerId: auth.user.id,
                            latitude: userDetails.userDetails.latitude,
                            longitude: userDetails.userDetails.longitude,
                          );

                      // Navigate back
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Create Job'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
