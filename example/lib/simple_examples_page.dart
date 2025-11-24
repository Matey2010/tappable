import 'package:flutter/material.dart';
import 'package:tappable/tappable.dart';

class SimpleExamplesPage extends StatefulWidget {
  const SimpleExamplesPage({super.key});

  @override
  State<SimpleExamplesPage> createState() => _SimpleExamplesPageState();
}

class _SimpleExamplesPageState extends State<SimpleExamplesPage> {
  String _lastTapped = 'None';

  void _onTap(String label) {
    setState(() => _lastTapped = label);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tappable Examples'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Last tapped: $_lastTapped',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // 1. Ripple
          _buildExample(
            number: 1,
            title: 'Ripple (Default)',
            description: 'Material Design ink ripple effect',
            tapMechanics: [RippleTapMechanic()],
            color: Colors.blue,
            label: 'Ripple',
          ),

          // 2. Scale
          _buildExample(
            number: 2,
            title: 'Scale',
            description: 'Shrinks to 95% when pressed',
            tapMechanics: [ScaleTapMechanic(scaleFactor: 0.95)],
            color: Colors.purple,
            label: 'Scale',
          ),

          // 3. Press
          _buildExample(
            number: 3,
            title: 'Press (3D Effect)',
            description: 'Simulates 3D button press with shadow',
            tapMechanics: [
              PressTapMechanic(pressDepth: 4.0, shadowColor: Colors.black26),
            ],
            color: Colors.orange,
            label: 'Press',
          ),

          // 4. Opacity
          _buildExample(
            number: 4,
            title: 'Opacity',
            description: 'Fades to 60% opacity (iOS-style)',
            tapMechanics: [OpacityTapMechanic(opacity: 0.6)],
            color: Colors.green,
            label: 'Opacity',
          ),

          // 5. None
          _buildExample(
            number: 5,
            title: 'None',
            description: 'No visual feedback',
            tapMechanics: [NoneTapMechanic()],
            color: Colors.grey,
            label: 'None',
          ),

          // 6. Bevel (Bottom)
          _buildExample(
            number: 6,
            title: 'Bevel (3D Trapezoid)',
            description: 'Realistic 3D raised button effect',
            tapMechanics: [
              BevelTapMechanic(
                bevelHeight: 14.0,
                bevelColor: Colors.indigo.shade900,
              ),
            ],
            color: Colors.indigo,
            label: 'Bevel',
            noBorderRadius: true,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: const Center(
                child: Text(
                  'Test Bevel\nDistortion',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // 7. Ripple + Scale
          _buildExample(
            number: 7,
            title: 'Ripple + Scale',
            description: 'Combines ripple effect with scale animation',
            tapMechanics: [
              RippleTapMechanic(
                splashColor: Colors.blue.withValues(alpha: 0.3),
              ),
              ScaleTapMechanic(scaleFactor: 0.95),
            ],
            color: Colors.blue,
            label: 'Ripple+Scale',
          ),

          // 8. Press + Opacity
          _buildExample(
            number: 8,
            title: 'Press + Opacity',
            description: '3D press effect combined with fade',
            tapMechanics: [
              PressTapMechanic(pressDepth: 4.0, shadowColor: Colors.black26),
              OpacityTapMechanic(opacity: 0.8),
            ],
            color: Colors.deepOrange,
            label: 'Press+Opacity',
          ),

          // 9. Keyboard Button
          _buildKeyboardButtonExample(),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildKeyboardButtonExample() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '9',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Keyboard Button (Isometric 3D)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 44),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mechanical keyboard key with different perspectives',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Left perspective
                    Column(
                      children: [
                        TKeyboardButton(
                          onPressed: () => _onTap('Keyboard Left'),
                          width: 80,
                          height: 80,
                          topColor: Colors.grey.shade100,
                          bevelColor: Colors.grey.shade600,
                          depth: 14.0,
                          pressDepth: 10.0,
                          borderRadius: 12.0,
                          perspective: KeyboardButtonPerspective.left,
                          child: const Text(
                            'A',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Left',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    // Center perspective
                    Column(
                      children: [
                        TKeyboardButton(
                          onPressed: () => _onTap('Keyboard Center'),
                          width: 80,
                          height: 80,
                          topColor: Colors.grey.shade100,
                          bevelColor: Colors.grey.shade600,
                          depth: 14.0,
                          pressDepth: 10.0,
                          borderRadius: 12.0,
                          perspective: KeyboardButtonPerspective.center,
                          child: const Text(
                            'S',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Center',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    // Right perspective
                    Column(
                      children: [
                        TKeyboardButton(
                          onPressed: () => _onTap('Keyboard Right'),
                          width: 80,
                          height: 80,
                          topColor: Colors.grey.shade100,
                          bevelColor: Colors.grey.shade600,
                          depth: 14.0,
                          pressDepth: 10.0,
                          borderRadius: 12.0,
                          perspective: KeyboardButtonPerspective.right,
                          child: const Text(
                            'D',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Right',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExample({
    required int number,
    required String title,
    required String description,
    required List<TapMechanic> tapMechanics,
    required Color color,
    required String label,
    bool noBorderRadius = false,
    Widget? child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    '$number',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 44),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 12),
                Container(
                  color: Colors.blueGrey,
                  child: Tappable(
                    onTap: () => _onTap(label),
                    tapMechanics: tapMechanics,
                    child: child ??
                        Container(
                          width: 200,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: noBorderRadius
                                ? null
                                : BorderRadius.circular(16),
                          ),
                          child: const Text(
                            'Tap Me!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
