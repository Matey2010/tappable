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
      appBar: AppBar(
        title: const Text('Tappable Examples'),
        centerTitle: true,
      ),
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
              PressTapMechanic(
                pressDepth: 4.0,
                shadowColor: Colors.black26,
              ),
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
                direction: BevelDirection.bottom,
                bevelHeight: 6.0,
                bevelColor: Colors.indigo.shade900,
              ),
            ],
            color: Colors.indigo,
            label: 'Bevel',
            noBorderRadius: true,
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
              PressTapMechanic(
                pressDepth: 4.0,
                shadowColor: Colors.black26,
              ),
              OpacityTapMechanic(opacity: 0.8),
            ],
            color: Colors.deepOrange,
            label: 'Press+Opacity',
          ),

          // 9. Bevel from Top
          _buildExample(
            number: 9,
            title: 'Bevel from Top',
            description: 'Top edge bulges toward user',
            tapMechanics: [
              BevelTapMechanic(
                direction: BevelDirection.top,
                bevelHeight: 8.0,
                bevelColor: Colors.cyan.shade900,
              ),
            ],
            color: Colors.cyan,
            label: 'Bevel Top',
            noBorderRadius: true,
          ),

          // 10. Bevel from Left
          _buildExample(
            number: 10,
            title: 'Bevel from Left',
            description: 'Left edge bulges toward user',
            tapMechanics: [
              BevelTapMechanic(
                direction: BevelDirection.left,
                bevelHeight: 8.0,
                bevelColor: Colors.amber.shade900,
              ),
            ],
            color: Colors.amber,
            label: 'Bevel Left',
            noBorderRadius: true,
          ),

          // 11. Bevel from Right
          _buildExample(
            number: 11,
            title: 'Bevel from Right',
            description: 'Right edge bulges toward user',
            tapMechanics: [
              BevelTapMechanic(
                direction: BevelDirection.right,
                bevelHeight: 8.0,
                bevelColor: Colors.lime.shade900,
              ),
            ],
            color: Colors.lime,
            label: 'Bevel Right',
            noBorderRadius: true,
          ),

          const SizedBox(height: 24),
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
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
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
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Tappable(
                    onTap: () => _onTap(label),
                    tapMechanics: tapMechanics,
                    child: Container(
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
