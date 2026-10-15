import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/climate_data_model.dart';
import '../services/prediction_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/metric_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _rainfallController = TextEditingController(text: '120');
  final _tempController = TextEditingController(text: '28');
  final _humidityController = TextEditingController(text: '75');
  final _phController = TextEditingController(text: '6.5');

  double? _predictedYield;
  bool _isLoading = false;

  void _runYieldPrediction() async {
    setState(() => _isLoading = true);

    final data = ClimateDataModel(
      rainfall: double.tryParse(_rainfallController.text) ?? 0,
      temperature: double.tryParse(_tempController.text) ?? 0,
      humidity: double.tryParse(_humidityController.text) ?? 0,
      soilPh: double.tryParse(_phController.text) ?? 0,
    );

    double result = await PredictionService.predictCropYield(data);

    setState(() {
      _predictedYield = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Decision Support Dashboard'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Real-Time Environmental Metrics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                MetricCard(title: 'Avg Temp', value: '28 °C', icon: Icons.thermostat),
                MetricCard(title: 'Rainfall', value: '120 mm', icon: Icons.water_drop),
                MetricCard(title: 'Humidity', value: '75 %', icon: Icons.cloud),
                MetricCard(title: 'Soil pH', value: '6.5', icon: Icons.landscape),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Random Regression Crop Yield Inference Model',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: AppColors.cardShadow, blurRadius: 8, offset: Offset(0, 2)),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          label: 'Rainfall (mm)',
                          hint: 'e.g. 120',
                          controller: _rainfallController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppTextField(
                          label: 'Temperature (°C)',
                          hint: 'e.g. 28',
                          controller: _tempController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          label: 'Humidity (%)',
                          hint: 'e.g. 75',
                          controller: _humidityController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppTextField(
                          label: 'Soil pH',
                          hint: 'e.g. 6.5',
                          controller: _phController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : AppButton(
                          label: 'Calculate Predicted Productivity Yield',
                          onPressed: _runYieldPrediction,
                        ),
                  if (_predictedYield != null) ...[
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Estimated Productivity Yield: $_predictedYield Tons / Hectare',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}