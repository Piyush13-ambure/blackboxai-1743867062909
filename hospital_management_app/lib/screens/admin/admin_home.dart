import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Provider.of<AuthService>(context, listen: false).signOut(),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Hospital Management',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('User Management'),
              onTap: () {
                // TODO: Navigate to user management
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Appointments'),
              onTap: () {
                // TODO: Navigate to appointments
              },
            ),
            ListTile(
              leading: const Icon(Icons.medical_services),
              title: const Text('Doctor Management'),
              onTap: () {
                // TODO: Navigate to doctor management
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_hospital),
              title: const Text('Patient Records'),
              onTap: () {
                // TODO: Navigate to patient records
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('Billing System'),
              onTap: () {
                // TODO: Navigate to billing
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          _buildDashboardCard(
            context,
            Icons.people,
            'Users',
            Colors.blue,
            () {},
          ),
          _buildDashboardCard(
            context,
            Icons.calendar_today,
            'Appointments',
            Colors.green,
            () {},
          ),
          _buildDashboardCard(
            context,
            Icons.medical_services,
            'Doctors',
            Colors.orange,
            () {},
          ),
          _buildDashboardCard(
            context,
            Icons.local_hospital,
            'Patients',
            Colors.purple,
            () {},
          ),
          _buildDashboardCard(
            context,
            Icons.receipt,
            'Billing',
            Colors.red,
            () {},
          ),
          _buildDashboardCard(
            context,
            Icons.settings,
            'Settings',
            Colors.grey,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}