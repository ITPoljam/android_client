class ProdukModel {
  final int? id;
  final String nama;
  final double harga;
  final int stok;
  final String kategori;

  ProdukModel({
    this.id,
    required this.nama,
    required this.harga,
    required this.stok,
    required this.kategori,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    return ProdukModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      nama: json['nama']?.toString() ?? '',
      harga: (json['harga'] is num)
          ? (json['harga'] as num).toDouble()
          : double.tryParse(json['harga'].toString()) ?? 0.0,
      stok: (json['stok'] is int)
          ? json['stok'] as int
          : int.tryParse(json['stok'].toString()) ?? 0,
      kategori: json['kategori']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'nama': nama,
      'harga': harga,
      'stok': stok,
      'kategori': kategori,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }
}

