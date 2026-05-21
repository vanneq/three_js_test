import 'package:three_js/three_js.dart' as three;

import 'package:flutter/material.dart';

class ThreeScenePage extends StatefulWidget {
  const ThreeScenePage({super.key});

  @override
  State<ThreeScenePage> createState() => _ThreeScenePageState();
}

class _ThreeScenePageState extends State<ThreeScenePage> {
  late three.ThreeJS threeJS;
  late three.Mesh cube;
  @override
  void initState() {
    super.initState();
    threeJS = three.ThreeJS(
      onSetupComplete: () {
        setState(() {});
      },

      setup: setup,
    );
  }

  Future<void> setup() async {
    threeJS.camera = three.PerspectiveCamera(
      75,
      threeJS.width / threeJS.height,
      0.1,
      1000,
    );
    threeJS.camera.position.z = 3;
    final geometry = three.BoxGeometry(1, 1, 1);
    final material = three.MeshBasicMaterial.fromMap({
      "color": three.Color(0, 1, 0),
    });
    cube = three.Mesh(geometry, material);
    threeJS.scene.add(cube);

    threeJS.addAnimationEvent((dt) {
      cube.rotation.x += 0.01;
      cube.rotation.y += 0.01;
    });
  }

  @override
  void dispose() {
    super.dispose();
    threeJS.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: threeJS.build());
  }
}
