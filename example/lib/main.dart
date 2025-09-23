import 'package:flutter/material.dart';
import 'package:iraq_location_picker/utils/theme_utils.dart';
import 'package:iraq_location_picker/widgets/location_picker_widget.dart';

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
      title: 'Iraq Location Picker',
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
  String? selectedGovernorateCode;

  void _onLocationSelected(String? governorateCode) {
    setState(() {
      selectedGovernorateCode = governorateCode;
    });

    // Here you could add additional logic such as:
    // - Fetching stores in the selected governorate
    // - Updating a map view
    // - Filtering search results
    if (governorateCode != null) {
      debugPrint('Selected governorate: $governorateCode');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iraq Location Picker'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: LocationPickerWidget(onLocationSelected: _onLocationSelected),
        ),
      ),
    );
  }
}
