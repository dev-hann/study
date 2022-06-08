void main(List<String> arguments) {
  final List<int> targetList = List.generate(100000, (index) => index);
  final List<Duration> resultList = [];

  final Stopwatch watch = Stopwatch();

  for (int index = 0; index < 100; index++) {
    watch.start();
    targetList.remove(-1);
    // if (targetList.contains(-1)) {
      // targetList.remove(-1);
    // }
    watch.stop();
    resultList.add(watch.elapsed);
    watch.reset();
  }

  resultList.sort();
  print("min: ${resultList.first}");
  print("max: ${resultList.last}");
  final sum =
      resultList.map((e) => e.inMicroseconds).fold<int>(0, (a, b) => a + b);
  print("sum in micSec : $sum");
}
