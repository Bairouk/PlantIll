import 'package:flutter/material.dart';
import 'package:ocp/configs/AppColors.dart';
import 'package:ocp/data/machines.dart';
import 'package:ocp/models/machine.dart';
import 'package:provider/provider.dart';

class MachineDisp extends StatelessWidget {
  final Machine machine;

  const MachineDisp(this.machine, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final pokeDispSize = screenHeight * 0.1;
    final machineSize = pokeDispSize * 0.85;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/ocplogo.png",
              width: pokeDispSize,
              height: pokeDispSize,
              color: AppColors.lightGrey,
            ),
            Image.asset(
              machine.image,
              width: machineSize,
              height: machineSize,
            ),
          ],
        ),
        SizedBox(height: 3),
        Text(machine.name),
      ],
    );
  }
}

class machineEvolution extends StatelessWidget {
  Widget _buildRow({current: Machine, next: Machine, level: int}) {
    return Row(
      children: <Widget>[
        Expanded(child: MachineDisp(current)),
        Expanded(
            child: Column(
          children: <Widget>[
            Icon(Icons.arrow_forward, color: AppColors.lightGrey),
            SizedBox(height: 7),
            Text(
              "Lvl $level",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        )),
        Expanded(child: MachineDisp(next)),
      ],
    );
  }

  Widget _buildDivider() {
    return Column(
      children: <Widget>[
        SizedBox(height: 21),
        Divider(),
        SizedBox(height: 21),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardController = Provider.of<AnimationController>(context);

    return AnimatedBuilder(
      animation: cardController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Evolution Chain",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 0.8),
          ),
          SizedBox(height: 28),
          _buildRow(current: machines[0], next: machines[1], level: 16),
          _buildDivider(),
          _buildRow(current: machines[1], next: machines[2], level: 34),
        ],
      ),
      builder: (context, widget) {
        final scrollable = cardController.value.floor() == 1;

        return SingleChildScrollView(
          physics: scrollable ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 31, horizontal: 28),
          child: widget,
        );
      },
    );
  }
}
