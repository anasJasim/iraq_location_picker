# Iraq Location Picker

Enhanced location picker beyond a simple dropdown using Flutter with interactive map functionality.

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

## Project Structure

```
lib/
├── data/               # JSON data files
├── models/             # Data models and structures
├── pages/              # Application pages
├── utils/              # Constants and utilities
├── widgets/            # Reusable UI components
└── main.dart          # Application entry point
```

## Key Components

- `LocationPickerWidget`: Main widget combining dropdown and map
- `GovernorateDropdown`: Traditional dropdown with trailing icon
- `InteractiveMapPage`: Full-screen map for governorate selection
- Iraq GeoJSON data with all 18 governorates

## Getting Started

1. **Clone the repository**
```bash
git clone <repository-url>
cd iraq_location_picker
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

## Dependencies

- `flutter_map`: Interactive map functionality
- `latlong2`: Geographic coordinates handling

## Data Sources

- Iraqi governorates GeoJSON boundary data from [geoBoundaries](https://www.geoboundaries.org)
- Governorate names and codes in Arabic/English


## Acknowledgements

The administrative boundary data is from geoBoundaries. For academic use, please cite:

> Runfola D, Anderson A, Baier H, Crittenden M, Dowker E, Fuhrig S, et al. (2020) 
> geoBoundaries: A global database of political administrative boundaries. 
> PLoS ONE 15(4): e0231866. https://doi.org/10.1371/journal.pone.0231866.