
import 'package:flutter/material.dart';
import 'package:three_js/three_js.dart' as three;
import 'dart:math' as math;


class SphereThreeJs extends StatefulWidget {
  const SphereThreeJs({super.key});

  @override
  State<SphereThreeJs> createState() => _SphereThreeJsState();
}

class _SphereThreeJsState extends State<SphereThreeJs> {
  late three.ThreeJS threeJs;
  late three.Mesh sphere;
  var _time = 0.0;
  double _targetX = 0;
  double _targetY = 0;



  @override
  void initState() {
    super.initState();
  threeJs = three.ThreeJS(onSetupComplete: (){
    setState(() {});
    },
    setup: setup);

  }

  Future<void> setup() async {
    threeJs.scene = three.Scene();
    threeJs.scene.background = three.Color(0.05, 0.05, 0.15);
    threeJs.camera = three.PerspectiveCamera(
       75, threeJs.width / threeJs.height, 0.1, 1000
    );
    threeJs.camera.position.z = 10;
    final geometry = three.SphereGeometry( 1, 32,32);
    final material = three.MeshBasicMaterial.fromMap({
      "color": three.Color(1,0.32,0.32)
    });

    sphere = three.Mesh(geometry, material);
    threeJs.scene.add(sphere);

    threeJs.addAnimationEvent((dt){
      _time += dt;
      sphere.position.y = -(_targetY - sphere.position.y) * 0.1;
      sphere.position.x = (_targetX - sphere.position.x) * 0.1;


    });


  }
  @override
  void dispose() {
    threeJs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.black,
      body: SafeArea(
        minimum: EdgeInsets.symmetric(vertical: 20),
        child: Stack(
          children: [
            GestureDetector( onPanUpdate: (details){
              setState(() {
                _targetX = (details.globalPosition.dx/ threeJs.width - 0.5) * 70;
                _targetY = (details.globalPosition.dy/ threeJs.height - 0.5) * 70;
              });
            },
              child: threeJs.build()),
              Center(child: Text("He is chasing you", style: TextStyle(color: Colors.white, fontSize: 16),)),
          ],
        ),
      )
    );
  }
}
