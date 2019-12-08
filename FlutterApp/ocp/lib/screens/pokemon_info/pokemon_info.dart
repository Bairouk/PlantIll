import 'package:flutter/material.dart';
import 'package:ocp/screens/pokemon_info/widgets/info.dart';
import 'package:ocp/screens/pokemon_info/widgets/tab.dart';
import 'package:ocp/widgets/slide_up_panel.dart';
import 'package:provider/provider.dart';

class MachineInfo extends StatefulWidget {
  @override
  _machineInfoState createState() => _machineInfoState();
}

class _machineInfoState extends State<MachineInfo> with TickerProviderStateMixin {
  static const double _machineSlideOverflow = 20;

  GlobalKey _machineInfoKey = GlobalKey();

  AnimationController _cardController;
  AnimationController _cardHeightController;

  double _cardMinHeight = 0.0;
  double _cardMaxHeight = 0.0;

  @override
  void initState() {
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _cardHeightController = AnimationController(vsync: this, duration: Duration(milliseconds: 220));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenHeight = MediaQuery.of(context).size.height;
      final appBarHeight = 60 + 22 + IconTheme.of(context).size;

      final RenderBox machineInfoBox = _machineInfoKey.currentContext.findRenderObject();

      _cardMinHeight = screenHeight - machineInfoBox.size.height + _machineSlideOverflow;
      _cardMaxHeight = screenHeight - appBarHeight;

      _cardHeightController.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    _cardController.dispose();
    _cardHeightController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      builder: (context) => _cardController,
      child: Scaffold(
        backgroundColor: Color(0xFF48D0B0),
        body: Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: _cardHeightController,
              child: MachineTabInfo(),
              builder: (context, child) {
                return SlidingUpPanel(
                  controller: _cardController,
                  minHeight: _cardMinHeight * _cardHeightController.value,
                  maxHeight: _cardMaxHeight,
                  child: child,
                );
              },
            ),
            IntrinsicHeight(
              child: Container(
                key: _machineInfoKey,
                child: MachineOverallInfo(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
