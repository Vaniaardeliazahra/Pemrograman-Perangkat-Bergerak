import 'hewan.dart';

class Kucing extends Hewan {
  String warnaBulu;

  Kucing(String nama, double berat, this.warnaBulu) : super(nama, berat);

  String makan(double porsi) {
    super.makan(porsi);
    return 'Kucing $nama sedang makan sebanyak ${porsi.toInt()} gram';
  }

  String lari(double porsi) {
    super.lari(porsi);
    return 'Kucing $nama baru saja berlari dan kehilangan ${porsi} kg';
  }
}
