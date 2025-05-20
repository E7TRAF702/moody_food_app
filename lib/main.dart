import 'package:flutter/material.dart';

void main() => runApp(const MoodyFoodApp());

class MoodyFoodApp extends StatelessWidget {
  const MoodyFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مِزاجي',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const MoodSelectionScreen(),
    );
  }
}

class MoodSelectionScreen extends StatelessWidget {
  const MoodSelectionScreen({super.key});

  final List<String> moods = [
    '😊 سعيد', '😢 حزين', '😰 متوتر', '🥱 خامل', '🤩 مشتاق'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("مِزاجي | اختر مزاجك")),
      body: ListView.builder(
        itemCount: moods.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Text(moods[index].split(' ')[0], style: const TextStyle(fontSize: 24)),
              title: Text(moods[index].split(' ')[1]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodSuggestionScreen(mood: moods[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class FoodSuggestionScreen extends StatelessWidget {
  final String mood;

  const FoodSuggestionScreen({super.key, required this.mood});

  final Map<String, List<String>> moodFoods = {
    '😊 سعيد': ['🍕 بيتزا', '🍔 برجر', '🍩 دونات'],
    '😢 حزين': ['🍫 شوكولاتة', '🍦 آيس كريم', '🍗 دجاج مقلي'],
    '😰 متوتر': ['🥗 سلطة', '🍵 شاي أخضر', '🍎 تفاح'],
    '🥱 خامل': ['☕ قهوة', '🍝 باستا', '🍳 فطور كامل'],
    '🤩 مشتاق': ['🍲 كبسة', '🍜 رامن', '🍛 كاري'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("اقتراحات لـ $mood")),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text("هذه الوجبات تناسبك!", style: TextStyle(fontSize: 20)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: moodFoods[mood]?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Text(moodFoods[mood]![index].split(' ')[0], 
                        style: const TextStyle(fontSize: 24)),
                    title: Text(moodFoods[mood]![index].split(' ')[1]),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("جاري طلب ${moodFoods[mood]![index]}...")),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
