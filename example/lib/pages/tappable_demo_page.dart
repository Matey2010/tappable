import 'package:flutter/material.dart';
import 'package:tappable/tappable.dart';

class TappableDemoPage extends StatefulWidget {
  const TappableDemoPage({super.key});

  @override
  State<TappableDemoPage> createState() => _TappableDemoPageState();
}

class _TappableDemoPageState extends State<TappableDemoPage> {
  String _lastTapped = 'None';

  void _onTap(String label) {
    setState(() => _lastTapped = label);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tappable Widget'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Last tapped: $_lastTapped',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Basic Tappable
          _buildSection(
            title: 'Basic Tappable',
            description: 'Default Material ripple effect',
            child: Tappable(
              onTap: () => _onTap('Basic'),
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue),
                ),
                child: const Center(
                  child: Text(
                    'Tap me!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Custom Ripple Colors
          _buildSection(
            title: 'Custom Ripple Colors',
            description: 'Using RippleTapMechanic with custom colors',
            child: Tappable(
              onTap: () => _onTap('Custom Ripple'),
              borderRadius: BorderRadius.circular(12),
              tapMechanics: [
                RippleTapMechanic(
                  splashColor: Colors.purple.withValues(alpha: 0.3),
                  highlightColor: Colors.purple.withValues(alpha: 0.1),
                ),
              ],
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.deepPurple],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Purple Ripple',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Sparkle Effect
          _buildSection(
            title: 'Sparkle Effect (Material 3)',
            description: 'Using InkSparkle splash factory',
            child: Tappable(
              onTap: () => _onTap('Sparkle'),
              borderRadius: BorderRadius.circular(12),
              tapMechanics: [
                RippleTapMechanic(
                  splashFactory: InkSparkle.splashFactory,
                  splashColor: Colors.amber.withValues(alpha: 0.5),
                ),
              ],
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.orange, Colors.amber],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Sparkle Effect',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Fill Parent
          _buildSection(
            title: 'Fill Parent',
            description: 'Tappable expands to fill available space',
            child: SizedBox(
              height: 100,
              child: Tappable(
                onTap: () => _onTap('Fill Parent'),
                fillParent: true,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green),
                  ),
                  child: const Center(
                    child: Text(
                      'Fills entire height',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Disabled State
          _buildSection(
            title: 'Disabled State',
            description: 'onTap: null makes it non-interactive',
            child: Opacity(
              opacity: 0.5,
              child: Tappable(
                onTap: null, // Disabled
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: const Center(
                    child: Text(
                      'Disabled',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Column(
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
        const SizedBox(height: 12),
        child,
        const SizedBox(height: 24),
      ],
    );
  }
}
