class Hewan {
  String nama;
  double berat;

  Hewan(this.nama, this.berat);

  void makan(double porsi) {
    berat += porsi / 1000; 
  }

  void lari(double porsi) {
    berat -= porsi; 
  }
}
