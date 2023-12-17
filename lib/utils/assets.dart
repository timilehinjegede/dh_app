// bath assets (svgs and pngs) path
const String baseSvgPath = 'assets/svgs/';
const String basePngPath = 'assets/pngs/';
const String baseJsonPath = 'assets/jsons/';
const String baseGifPath = 'assets/gifs/';

// extensions
extension ImageExtension on String {
  // get png paths
  String get png => '$basePngPath$this.png';
  // get svgs path
  String get svg => '$baseSvgPath$this.svg';
}
