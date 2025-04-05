import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/auth_service.dart';
import 'screens/auth/login_screen.dart';
import 'screens/admin/admin_home.dart';
import 'screens/doctor/doctor_home.dart';
import 'screens/nurse/nurse_home.dart';
import 'screens/patient/patient_home.dart';
import 'screens/receptionist/receptionist_home.dart';
import 'screens/auth/role_selection.dart';

class HospitalManagementApp extends StatelessWidget {
  const HospitalManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return const LoginScreen();
            }
            return FutureBuilder<String?>(
              future: Provider.of<AuthService>(context).getUserRole(user.uid),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.done) {
                  final role = roleSnapshot.data;
                  switch (role) {
                    case AuthService.adminRole:
                      return const AdminHomeScreen();
                    case AuthService.doctorRole:
                      return const DoctorHomeScreen();
                    case AuthService.nurseRole:
                      return const NurseHomeScreen();
                    case AuthService.patientRole:
                      return const PatientHomeScreen();
                    case AuthService.receptionistRole:
                      return const ReceptionistHomeScreen();
                    default:
                      return const RoleSelectionScreen();
                  }
                }
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              },
            );
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}