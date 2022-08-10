import 'dart:math';

int showBasicMetabolism(int sex, int w, int h, int a) {
  if (sex == 0) {
    return (pow(10, -1) * (230 * pow(w, 0.48) * pow(h, 0.5) * pow(a, -0.13)).toDouble()).toInt();
  } else {
    return (pow(10, -1) * (259 * pow(w, 0.48) * pow(h, 0.5) * pow(a, -0.13)).toDouble()).toInt();
  }
}

int showCaloricNeed(int basic, double activity) {
  return (basic * activity).toInt();
}