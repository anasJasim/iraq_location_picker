# Iraq Location Picker

Enhanced location picker beyond a simple dropdown using Flutter with interactive map functionality.

## 🌐 Live Demo
Try the interactive demo: **[https://anasjasim.github.io/iraq_location_picker/](https://anasjasim.github.io/iraq_location_picker/)**

## 📸 Screenshots

<div align="center">
  <img src="https://raw.githubusercontent.com/anasjasim/iraq_location_picker/main/example/assets/screenshots/location_picker_screenshot.png" alt="Location Picker Widget" width="400"/>
  <br/>
  <em>Main location picker with dropdown and map integration</em>
  <br/><br/>
  <img src="https://raw.githubusercontent.com/anasjasim/iraq_location_picker/main/example/assets/screenshots/map_page_screenshot.png" alt="Interactive Map" width="600"/>
  <br/>
  <em>Interactive map showing all Iraqi governorates with clickable polygons</em>
</div>

## Features

🗺️ **Interactive Map Selection**
- Click on Iraq governorates directly on the map
- GeoJSON polygon rendering with visual feedback
- Zoom and pan capabilities with OpenStreetMap tiles

📋 **Dropdown Selection**  
- Traditional dropdown with all Iraqi governorates
- Quick selection with search capabilities
- Integrated map button for enhanced experience

## Use Cases

- **Store Owners**: Instantly know which region they belong to, especially near borders
- **End Users**: Quickly see stores available in each region  
- **Enhanced UX**: A 'cool' interactive option alongside normal dropdowns

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  iraq_location_picker: ^0.1.1
```

## Usage

### Iraq Governorate Picker

```dart
import 'package:flutter/material.dart';
import 'package:iraq_location_picker/iraq_location_picker.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IraqGovernoratePicker(
      onGovernorateSelected: (governorate) {
        print('Selected governorate: ${governorate?.governorateCode}');
      },
    );
  }
}
```

### Iraq Governorate Dropdown Only

```dart
import 'package:iraq_location_picker/iraq_location_picker.dart';

IraqGovernorateDropdown(
  selectedGovernorate: selectedGovernorate,
  onGovernorateSelected: (governorate) {
    // Handle selection
  },
  governorates: governorates,
  isLoading: false,
)
```

### Interactive Map

```dart
import 'package:iraq_location_picker/iraq_location_picker.dart';

// Show interactive map
await showInteractiveMap(
  context,
  initialLocation: centerOfIraq,
  initialZoom: 6.5,
  polygons: polygons,
  title: 'Select Iraqi Governorate',
  onPolygonHit: (hitValues) {
    // Handle governorate selection
  },
);
```

## Data Models

The package provides several data models:

- `IraqGovernorate`: Represents a single governorate
- `IraqLocationData`: Contains all location data
- `GeoJsonData`: For handling map polygon data

## Example

See the `example/` folder for a complete implementation.

## Dependencies

- `flutter_map`: Interactive map functionality
- `latlong2`: Geographic coordinates handling

## Data Sources

- Iraqi governorates GeoJSON boundary data from [geoBoundaries](https://www.geoboundaries.org)
- Governorate names and codes in Arabic/English

## License

MIT License - see LICENSE file for details.

## Acknowledgements

The administrative boundary data is from geoBoundaries. For academic use, please cite:

> Runfola D, Anderson A, Baier H, Crittenden M, Dowker E, Fuhrig S, et al. (2020) 
> geoBoundaries: A global database of political administrative boundaries. 
> PLoS ONE 15(4): e0231866. https://doi.org/10.1371/journal.pone.0231866.