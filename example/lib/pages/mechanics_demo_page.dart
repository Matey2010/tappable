import 'package:flutter/material.dart';
import 'package:tappable/tappable.dart';

class MechanicsDemoPage extends StatefulWidget {
  const MechanicsDemoPage({super.key});

  @override
  State<MechanicsDemoPage> createState() => _MechanicsDemoPageState();
}

class _MechanicsDemoPageState extends State<MechanicsDemoPage> {
  String _lastTapped = 'None';

  void _onTap(String label) {
    setState(() => _lastTapped = label);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap Mechanics'),
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

          // Header: Single Mechanics
          const Text(
            'Single Mechanics',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const Divider(height: 32),

          // Ripple
          _buildMechanicDemo(
            title: 'Ripple (Default)',
            description: 'Material Design ink ripple effect',
            tapMechanics: [RippleTapMechanic()],
            color: Colors.blue,
            label: 'Ripple',
          ),

          // Scale
          _buildMechanicDemo(
            title: 'Scale',
            description: 'Shrinks to 95% when pressed',
            tapMechanics: [ScaleTapMechanic(scaleFactor: 0.95)],
            color: Colors.purple,
            label: 'Scale',
          ),

          // Press (3D)
          _buildMechanicDemo(
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

          // Opacity
          _buildMechanicDemo(
            title: 'Opacity',
            description: 'Fades to 60% opacity (iOS-style)',
            tapMechanics: [OpacityTapMechanic(opacity: 0.6)],
            color: Colors.green,
            label: 'Opacity',
          ),

          // None
          _buildMechanicDemo(
            title: 'None',
            description: 'No visual feedback',
            tapMechanics: [NoneTapMechanic()],
            color: Colors.grey,
            label: 'None',
          ),

          // Bevel (3D Trapezoid) - BOTTOM PRIMARY
          _buildMechanicDemo(
            title: 'Bevel (3D Trapezoid)',
            description: 'Realistic 3D raised button effect',
            tapMechanics: [
              BevelTapMechanic(
                bevelHeight: 6.0,
                bevelColor: Colors.indigo.shade900,
              ),
            ],
            color: Colors.indigo,
            label: 'Bevel',
          ),

          const SizedBox(height: 32),

          // Header: Combined Mechanics
          const Text(
            'Combined Mechanics',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const Text(
            'Multiple mechanics can be layered together!',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const Divider(height: 32),

          // Ripple + Scale
          _buildMechanicDemo(
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

          // Press + Opacity
          _buildMechanicDemo(
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

          // Ripple + Scale + Opacity
          _buildMechanicDemo(
            title: 'Ripple + Scale + Opacity',
            description: 'Triple combo!',
            tapMechanics: [
              RippleTapMechanic(
                splashColor: Colors.purple.withValues(alpha: 0.3),
              ),
              ScaleTapMechanic(scaleFactor: 0.92),
              OpacityTapMechanic(opacity: 0.7),
            ],
            color: Colors.deepPurple,
            label: 'Triple Combo',
          ),

          // Scale + Press
          _buildMechanicDemo(
            title: 'Scale + Press',
            description: 'Scale animation with 3D press',
            tapMechanics: [
              ScaleTapMechanic(scaleFactor: 0.95),
              PressTapMechanic(
                pressDepth: 6.0,
                shadowColor: Colors.black26,
              ),
            ],
            color: Colors.teal,
            label: 'Scale+Press',
          ),

          const SizedBox(height: 32),

          // Custom Configuration Example
          const Text(
            'Custom Configuration',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          const Divider(height: 32),

          _buildMechanicDemo(
            title: 'Heavy Scale + Slow Animation',
            description: 'Scale to 85% over 300ms',
            tapMechanics: [
              ScaleTapMechanic(
                scaleFactor: 0.85,
                duration: const Duration(milliseconds: 300),
                curve: Curves.elasticOut,
              ),
            ],
            color: Colors.pink,
            label: 'Heavy Scale',
          ),

          _buildMechanicDemo(
            title: 'Deep Press + Custom Shadow',
            description: 'Press 8px deep with custom shadow',
            tapMechanics: [
              PressTapMechanic(
                pressDepth: 8.0,
                shadowColor: Colors.red.withValues(alpha: 0.4),
                shadowBlurRadius: 12.0,
                pressedShadowBlurRadius: 4.0,
              ),
            ],
            color: Colors.red,
            label: 'Deep Press',
          ),

          const SizedBox(height: 32),

          // Standalone Widgets
          const Text(
            'Standalone Widgets',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const Divider(height: 32),

          _buildKeyboardButtonDemo(),

        ],
      ),
    );
  }

  Widget _buildKeyboardButtonDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Keyboard Button (Isometric 3D)',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Mechanical keyboard key with isometric perspective',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: TKeyboardButton(
            onPressed: () => _onTap('Keyboard Button'),
            width: 100,
            height: 100,
            topColor: Colors.grey.shade100,
            bevelColor: Colors.grey.shade600,
            depth: 14.0,
            pressDepth: 10.0,
            borderRadius: 12.0,
            child: const Text(
              'A',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildMechanicDemo({
    required String title,
    required String description,
    required List<TapMechanic> tapMechanics,
    required Color color,
    required String label,
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
        Center(
          child: Tappable(
            onTap: () => _onTap(label),
            tapMechanics: tapMechanics,
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Tap Me!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
