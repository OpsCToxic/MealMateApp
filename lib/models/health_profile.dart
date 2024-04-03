class HealthProfile {
  int age;
  double weight;
  double height;
  int activityLevel;
  double targetWeight;
  String healthConditions;
  List<String> allergies;
  String? dietaryPreference;
  int calorieNeeds;
  int mealPlanDuration;

  HealthProfile({
    required this.age,
    required this.weight,
    required this.height,
    required this.activityLevel,
    required this.targetWeight,
    required this.healthConditions,
    required this.allergies,
    this.dietaryPreference,
    required this.calorieNeeds,
    required this.mealPlanDuration,
  });

  Map<String, dynamic> toJson() => {
        'age': age,
        'weight': weight,
        'height': height,
        'activityLevel': activityLevel,
        'targetWeight': targetWeight,
        'healthConditions': healthConditions,
        'allergies': allergies,
        'dietaryPreference': dietaryPreference ?? 'None',
        'calorieNeeds': calorieNeeds,
        'mealPlanDuration': mealPlanDuration,
      };
}
