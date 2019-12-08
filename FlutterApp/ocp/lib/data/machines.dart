import 'package:ocp/configs/AppColors.dart';

import 'package:ocp/models/machine.dart';

const List<Machine> machines = [
  Machine(
    name: "Apple",
    types: const ["Apple"],
    image: "assets/images/apple.png",
    color: AppColors.lightRed,
  ),
  Machine(
    name: "Blueberry",
    types: const ["Blueberry"],
    image: "assets/images/blueberry.png",
    color: AppColors.lightBlue,
  ),
  Machine(
    name: "Cherry",
    types: const ["Cherry"],
    image: "assets/images/cherry.png",
    color: AppColors.lightTeal,
  ),
  Machine(
    name: "Peach",
    types: const ["Peach"],
    image: "assets/images/peach.png",
    color: AppColors.lightBrown,
  ),
  Machine(
    name: "Grape",
    types: const ["Grape"],
    image: "assets/images/grape.png",
    color: AppColors.lightBlue,
  ),
  Machine(
    name: "Pepper",
    types: const ["Pepper"],
    image: "assets/images/pepper.png",
    color: AppColors.lightBrown,
  ),
  Machine(
    name: "Corn",
    types: const ["Corn"],
    image: "assets/images/corn.png",
    color: AppColors.lightYellow,
  ),
];
