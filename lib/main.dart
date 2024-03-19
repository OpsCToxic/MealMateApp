import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Profile',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.dark(
          primary: Colors.teal, // Used for the app's primary color
          secondary: Colors
              .tealAccent, // Used for the floating action button and switchable widgets
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.tealAccent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.teal[700]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.tealAccent),
          ),
          labelStyle: TextStyle(
            color: Colors.tealAccent,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Colors.teal, // Corrected from primary to backgroundColor
            foregroundColor:
                Colors.white, // Corrected from onPrimary to foregroundColor
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white70),
        ),
      ),
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
  String _dietaryRestriction = 'None';
  String _mealPreference = 'No preference';
  String _gender = 'Select';
  String _activityLevel = 'Select';
  List<String> _healthConditions = []; // Could be more complex in a real app
  TextEditingController _ageController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _targetWeightController = TextEditingController();
  TextEditingController _calorieIntakeController = TextEditingController();
  TextEditingController _favoriteFoodsController = TextEditingController();
  TextEditingController _dislikedFoodsController = TextEditingController();
  TextEditingController _budgetController = TextEditingController();

  List<String> genders = ['Select', 'Male', 'Female', 'Other'];
  List<String> activityLevels = [
    'Select',
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Very Active',
    'Extra Active'
  ];
  List<String> dietaryRestrictions = [
    'None',
    'Vegan',
    'Vegetarian',
    'Keto',
    'Paleo',
    'Allergies'
  ];
  List<String> mealPreferences = [
    'No preference',
    'Asian',
    'Western',
    'Mediterranean',
    'Latin',
    'African'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Health Profile'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField(
                value: _gender,
                onChanged: (String? newValue) {
                  setState(() {
                    _gender = newValue!;
                  });
                },
                items: genders.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _targetWeightController,
                decoration: InputDecoration(labelText: 'Target Weight (kg)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _calorieIntakeController,
                decoration: InputDecoration(
                    labelText: 'Daily Calorie Intake (optional)'),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField(
                value: _activityLevel,
                onChanged: (String? newValue) {
                  setState(() {
                    _activityLevel = newValue!;
                  });
                },
                items: activityLevels
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Activity Level'),
              ),
              DropdownButtonFormField(
                value: _dietaryRestriction,
                onChanged: (String? newValue) {
                  setState(() {
                    _dietaryRestriction = newValue!;
                  });
                },
                items: dietaryRestrictions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Dietary Restrictions'),
              ),
              DropdownButtonFormField(
                value: _mealPreference,
                onChanged: (String? newValue) {
                  setState(() {
                    _mealPreference = newValue!;
                  });
                },
                items: mealPreferences
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Meal Taste Preference'),
              ),
              TextFormField(
                controller: _budgetController,
                decoration:
                    InputDecoration(labelText: 'Weekly Budget for Meals'),
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    //  if (_formKey.currentState!.validate()) {
                    //   // Here you would typically collect all the data from the form
                    //   // and use it to calculate the user's nutritional needs,
                    //   // create a meal plan, etc. This might involve sending the data
                    //   // to a backend server where the calculation and meal planning logic resides.
                    //   final profileData = {
                    //     'age': _ageController.text,
                    //     'gender': _gender,
                    //     'height': _heightController.text,
                    //     'weight': _weightController.text,
                    //     'targetWeight': _targetWeightController.text,
                    //     'calorieIntake': _calorieIntakeController.text.isEmpty
                    //         ? 'To be calculated'
                    //         : _calorieIntakeController.text,
                    //     'activityLevel': _activityLevel,
                    //     'dietaryRestriction': _dietaryRestriction,
                    //     'mealPreference': _mealPreference,
                    //     'budget': _budgetController.text,
                    //   };
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
