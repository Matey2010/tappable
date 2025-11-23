import 'package:flutter/material.dart';
import 'tappable_demo_page.dart';
import 'tappable_container_demo_page.dart';
import 'mechanics_demo_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tappable Package Examples'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Explore the features of the Tappable package',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          _buildDemoCard(
            context,
            title: 'Tappable Widget',
            description: 'Basic tappable widget with customizable tap effects',
            icon: Icons.touch_app,
            color: Colors.blue,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TappableDemoPage()),
            ),
          ),
          const SizedBox(height: 16),
          _buildDemoCard(
            context,
            title: 'TappableContainer',
            description: 'Combine Container and Tappable for rich UI elements',
            icon: Icons.crop_square,
            color: Colors.purple,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const TappableContainerDemoPage()),
            ),
          ),
          const SizedBox(height: 16),
          _buildDemoCard(
            context,
            title: 'Tap Mechanics',
            description:
                'Explore different tap mechanics and combine them together',
            icon: Icons.gesture,
            color: Colors.green,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MechanicsDemoPage()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
