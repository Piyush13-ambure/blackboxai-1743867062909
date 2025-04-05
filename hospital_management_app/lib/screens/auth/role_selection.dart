import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;
  bool _isLoading = false;

  Future<void> _assignRole() async {
    if (_selectedRole == null) return;

    setState(() => _isLoading = true);

    try {
      final user = Provider.of<AuthService>(context, listen: false).currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'role': _selectedRole});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error assigning role: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Your Role')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please select your role in the hospital system:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            _buildRoleCard(AuthService.adminRole, Icons.admin_panel_settings),
            _buildRoleCard(AuthService.doctorRole, Icons.medical_services),
            _buildRoleCard(AuthService.nurseRole, Icons.medical_services_outlined),
            _buildRoleCard(AuthService.patientRole, Icons.person),
            _buildRoleCard(AuthService.receptionistRole, Icons.receipt),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedRole == null || _isLoading ? null : _assignRole,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(String role, IconData icon) {
    return Card(
      color: _selectedRole == role
          ? Theme.of(context).primaryColor.withOpacity(0.2)
          : null,
      child: ListTile(
        leading: Icon(icon),
        title: Text(role[0].toUpperCase() + role.substring(1)),
        onTap: () => setState(() => _selectedRole = role),
      ),
    );
  }
}