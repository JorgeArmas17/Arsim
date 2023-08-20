class Food {
  String nombre;
  String precio;
  String imagenUrl;
  String descripcion;
  String estrellas;

  Food(
      {required this.nombre,
      required this.precio,
      required this.imagenUrl,
      required this.descripcion,
      required this.estrellas});

  String get _nombre => nombre;
  String get _price => precio;
  String get _imagenUrl => imagenUrl;
  String get _descripcion => descripcion;
  String get _estrellas => estrellas;
}
