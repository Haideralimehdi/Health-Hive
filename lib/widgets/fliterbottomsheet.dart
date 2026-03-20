// ignore_for_file: unused_import, use_key_in_widget_constructors, sort_child_properties_last

// import 'package:doctor_app/utils/appconstant.dart';
import 'package:flutter/material.dart';

import '../utils/appconstant.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<String> specialties;
  final String selectedSpecialty;
  final Function(String) onSelect;
  final VoidCallback onApply;

  const FilterBottomSheet({
    required this.specialties,
    required this.selectedSpecialty,
    required this.onSelect,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String tempSelectedSpecialty;

  @override
  void initState() {
    super.initState();
    tempSelectedSpecialty = widget.selectedSpecialty;
  }

  void applyAndClose() {
    widget.onSelect(tempSelectedSpecialty);
    widget.onApply();
    // Navigator.pop(context); // ✅ Closes the sheet
  }

  void clearAndClose() {
    widget.onSelect(""); // Clears the filter
    widget.onApply();
    // Navigator.pop(context); // ✅ Closes the sheet
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.specialties.map((specialty) {
              bool isSelected = tempSelectedSpecialty == specialty;
              return ChoiceChip(
                label: Text(specialty),
                selected: isSelected,
                selectedColor: Colors.teal,
                onSelected: (_) {
                  setState(() {
                    tempSelectedSpecialty = specialty;
                  });
                },
              );
            }).toList(),
          ),
          SizedBox(height: 20),

          // Apply Button
          ElevatedButton(
            onPressed: applyAndClose,
            child: Text("Apply",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConstant.iconTextColor)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstant.Appsecondarycolor,
              minimumSize: Size(double.infinity, 50),
            ),
          ),

          SizedBox(height: 10),

          // Clear Filter Button
          TextButton(
            onPressed: clearAndClose,
            child: Text("Clear Filter",
                style: TextStyle(
                  color: AppConstant.Appsecondarycolor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
    );
  }
}
