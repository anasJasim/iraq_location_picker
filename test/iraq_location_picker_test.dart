import 'package:flutter_test/flutter_test.dart';
import 'package:iraq_location_picker/iraq_location_picker.dart';

void main() {
  group('Iraq Location Picker Tests', () {
    test('IraqGovernorate model test', () {
      const governorate = IraqGovernorate(
        governorateCode: 'BG',
        countryCode: 'IRQ',
        name: 'Baghdad',
      );

      expect(governorate.governorateCode, 'BG');
      expect(governorate.countryCode, 'IRQ');
      expect(governorate.name, 'Baghdad');
    });

    test('IraqGovernorate JSON serialization', () {
      const governorate = IraqGovernorate(
        governorateCode: 'BG',
        countryCode: 'IRQ',
        name: 'Baghdad',
      );

      final json = governorate.toJson();
      final fromJson = IraqGovernorate.fromJson(json);

      expect(fromJson, equals(governorate));
    });

    test('Location constants', () {
      expect(centerOfIraq.latitude, isNotNull);
      expect(centerOfIraq.longitude, isNotNull);
    });
  });
}
