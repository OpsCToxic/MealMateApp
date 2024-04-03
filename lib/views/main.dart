import 'package:flutter/material.dart';
import '../models/health_profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HealthProfileScreen(),
    );
  }
}

class HealthProfileScreen extends StatefulWidget {
  @override
  _HealthProfileScreenState createState() => _HealthProfileScreenState();
}

class _HealthProfileScreenState extends State<HealthProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController activityLevelController = TextEditingController();
  final TextEditingController targetWeightController = TextEditingController();
  final TextEditingController healthConditionsController =
      TextEditingController();
  final TextEditingController calorieNeedsController = TextEditingController();

  List<String> allergies = [
    'Peanuts',
    'Tree nuts',
    'Milk',
    'Eggs',
    'Shellfish',
    'Fish',
    'Wheat',
    'Soy'
  ];
  List<String> selectedAllergies = [];
  List<String> dietaryPreferences = [
    'None',
    'Vegetarian',
    'Vegan',
    'Keto',
    'Paleo'
  ];
  String? selectedDietaryPreference;
  int selectedMealPlanDuration = 1; // Default to 1 week

  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    activityLevelController.dispose();
    targetWeightController.dispose();
    healthConditionsController.dispose();
    calorieNeedsController.dispose();
    super.dispose();
  }

  void _showMultiSelect(BuildContext context) async {
    final List<String> selectedValues = await showDialog<List<String>>(
          context: context,
          builder: (BuildContext context) {
            return MultiSelectDialog(
                allergies: allergies, selectedAllergies: selectedAllergies);
          },
        ) ??
        [];

    if (selectedValues.isNotEmpty || selectedAllergies.contains('None')) {
      setState(() {
        selectedAllergies =
            selectedValues.contains('None') ? [] : selectedValues;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Health Profile'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  controller: ageController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Weight (lbs)'),
                  keyboardType: TextInputType.number,
                  controller: weightController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Height (inches)'),
                  keyboardType: TextInputType.number,
                  controller: heightController,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Activity Level (hours/week)'),
                  keyboardType: TextInputType.number,
                  controller: activityLevelController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Target Weight (lbs)'),
                  keyboardType: TextInputType.number,
                  controller: targetWeightController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Health Conditions'),
                  keyboardType: TextInputType.text,
                  controller: healthConditionsController,
                ),
                ElevatedButton(
                  onPressed: () => _showMultiSelect(context),
                  child: Text('Select Allergies'),
                ),
                Wrap(
                  children: selectedAllergies
                      .map((e) => Chip(label: Text(e)))
                      .toList(),
                ),
                DropdownButtonFormField<String>(
                  value: selectedDietaryPreference,
                  items: dietaryPreferences
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value == 'None' ? null : value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDietaryPreference = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Dietary Preferences',
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Calorie Needs'),
                  keyboardType: TextInputType.number,
                  controller: calorieNeedsController
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Submit form
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<String> allergies;
  final List<String> selectedAllergies;

  const MultiSelectDialog(
      {Key? key, required this.allergies, required this.selectedAllergies})
      : super(key: key);

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  final List<String> _tempSelectedAllergies = [];

  @override
  void initState() {
    super.initState();
    _tempSelectedAllergies.addAll(widget.selectedAllergies);
  }

  void _onItemCheckedChange(String allergyValue, bool isChecked) {
    setState(() {
      if (isChecked) {
        if (allergyValue == 'None') {
          _tempSelectedAllergies.clear();
        } else {
          _tempSelectedAllergies.remove('None');
        }
        _tempSelectedAllergies.add(allergyValue);
      } else {
        _tempSelectedAllergies.remove(allergyValue);
      }
    });
  }

  void _onSubmit() {
    Navigator.of(context).pop(_tempSelectedAllergies);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Allergies'),
      content: SingleChildScrollView(
        child: ListBody(
          children: ['None', ...widget.allergies]
              .map((allergy) => CheckboxListTile(
                    title: Text(allergy),
                    value: _tempSelectedAllergies.contains(allergy),
                    onChanged: (bool? value) {
                      _onItemCheckedChange(allergy, value!);
                    },
                  ))
              .toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: _onSubmit,
        ),
      ],
    );
  }
}
