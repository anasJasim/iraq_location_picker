import 'package:flutter/material.dart';
import 'package:iraq_location_picker/iraq_location_picker.dart';

/// Entry point of the Iraq Location Picker application
void main() {
  runApp(const IraqLocationPickerApp());
}

/// Main application widget
class IraqLocationPickerApp extends StatelessWidget {
  const IraqLocationPickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iraq Location Picker Example',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

/// Home page showcasing the enhanced location picker
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IraqGovernorate? selectedGovernorate;

  void _onGovernorateSelected(IraqGovernorate? governorate) {
    setState(() {
      selectedGovernorate = governorate;
    });

    // Here you could add additional logic such as:
    // - Fetching stores in the selected governorate
    // - Updating a map view
    // - Filtering search results
    if (governorate != null) {
      debugPrint('Selected governorate: ${governorate.governorateCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iraq Location Picker Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Section
              const Icon(Icons.location_on, size: 64, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                'Iraq Location Picker',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enhanced location picker with interactive map',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Location Picker Widget
              SizedBox(
                width: 300,
                child: IraqGovernorateLocationPickerWidget(
                  selectedGovernorate: selectedGovernorate,
                  onGovernorateSelected: _onGovernorateSelected,
                ),
              ),

              // Selected governorate display
              if (selectedGovernorate != null) ...[
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            'Selected Governorate:',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            selectedGovernorate!.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            'Code: ${selectedGovernorate!.governorateCode}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
