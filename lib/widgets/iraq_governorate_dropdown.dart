import 'package:flutter/material.dart';
import 'package:iraq_location_picker/models/governorate_models.dart';

/// A dropdown widget for selecting Iraqi governorates with optional trailing icon
class IraqGovernorateDropdown extends StatefulWidget {
  final IraqGovernorate? selectedGovernorate;
  final Function(IraqGovernorate?) onGovernorateSelected;
  final List<IraqGovernorate> governorates;
  final bool isLoading;
  final Widget? trailingIcon;
  final String hintText;
  final String labelText;

  const IraqGovernorateDropdown({
    super.key,
    this.selectedGovernorate,
    required this.onGovernorateSelected,
    required this.governorates,
    required this.isLoading,
    this.trailingIcon,
    this.hintText = 'Select Governorate',
    this.labelText = 'Select Governorate',
  });

  @override
  State<IraqGovernorateDropdown> createState() => _IraqGovernorateDropdownState();
}

class _IraqGovernorateDropdownState extends State<IraqGovernorateDropdown> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const SizedBox(
        width: 300,
        height: 56,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return DropdownMenu<IraqGovernorate?>(
      initialSelection: widget.selectedGovernorate,
      expandedInsets: const EdgeInsets.only(),
      hintText: widget.hintText,
      label: Text(widget.labelText),
      trailingIcon: widget.trailingIcon,
      dropdownMenuEntries: [
        const DropdownMenuEntry<IraqGovernorate?>(value: null, label: 'All'),
        ...widget.governorates.map(
          (governorate) => DropdownMenuEntry<IraqGovernorate?>(
            value: governorate,
            label: governorate.name,
          ),
        ),
      ],
      onSelected: widget.onGovernorateSelected,
      enableSearch: false,
      enableFilter: false,
      requestFocusOnTap: false,
    );
  }
}
