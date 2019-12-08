import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ocp/configs/AppColors.dart';
import 'package:ocp/data/machines.dart';
import 'package:ocp/screens/camerascreen/camera_screen.dart';
import 'package:ocp/screens/pokemon_info/pokemon_info.dart';
import 'package:ocp/widgets/fab.dart';
import 'package:ocp/widgets/machine_container.dart';
import 'package:ocp/widgets/machine_card.dart';


class machineActivity extends StatefulWidget {
  @override
  _machineActivityState createState() => _machineActivityState();
}

class _machineActivityState extends State<machineActivity> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _controller);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MachineContainer(
            appBar: true,
            children: <Widget>[
              SizedBox(height: 34),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Text(
                  "Plants",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  padding: EdgeInsets.only(left: 28, right: 28, bottom: 58),
                  itemCount: machines.length,
                  itemBuilder: (context, index) => MachineCard(
                    machines[index],
                    index: index,
                    onPress: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      => MachineInfo()));
//                      Navigator.of(context).pushNamed("/pokemon-info");
                    },
                  ),
                ),
              ),
            ],
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              return IgnorePointer(
                ignoring: _animation.value == 0,
                child: InkWell(
                  onTap: () {
                    _controller.reverse();
                  },
                  child: Container(
                    color: Colors.black.withOpacity(_animation.value * 0.5),
                  ),
                ),
              );
            },
          ),
        ],
      ),

      floatingActionButton:  FloatingActionButton(
        onPressed:  () {
          Navigator.push(context, MaterialPageRoute(builder: (context)
          => CameraScreen()));
//                      Navigator.of(context).pushNamed("/pokemon-info");
        },
        tooltip: 'Increment',
//        icon: new Icon(Icons.add),
        child: Icon(Icons.camera),
//        label: const Text("label"),
        backgroundColor: AppColors.lightBlue,

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        color: AppColors.lightTeal.withOpacity(0.7),
        shape: CircularNotchedRectangle(),
        child: Material(
          child: SizedBox(width: double.infinity, height: 40.0,),
          color:  AppColors.lightTeal.withOpacity(0.70),
        ),
      ),


    );
  }
}
