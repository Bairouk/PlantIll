import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MachineContainer extends StatelessWidget {
  const MachineContainer({
    Key key,
    @required this.children,
    this.height,
    this.decoration,
    this.appBar = false,
  }) : super(key: key);

  final bool appBar;
  final List<Widget> children;
  final Decoration decoration;
  final double height;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final MachineSize = screenSize.width * 0.66;
    final MachineTop = -(screenSize.width * 0.154);
    final MachineRight = -(screenSize.width * 0.23);
    final appBarTop = MachineSize / 2 + MachineTop - IconTheme.of(context).size / 2;

    return Container(
      width: screenSize.width,
      decoration: decoration,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: MachineTop,
            right: MachineRight,
            child: Image.asset(
              "assets/images/ocplogo.png",
              width: MachineSize,
              height: MachineSize,
              color: Color(0xFF303943).withOpacity(0.05),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (appBar)
                Padding(
                  padding: EdgeInsets.only(left: 26, right: 26, top: appBarTop),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        child: Icon(Icons.arrow_back),
                        onTap: Navigator.of(context).pop,
                      ),
                      Icon(Icons.menu),
                    ],
                  ),
                ),
              if (children != null) ...children,
            ],
          ),
        ],
      ),
    );
  }
}
