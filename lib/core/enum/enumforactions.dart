enum EnumForActions {
  markasdone(name: " Done / Not done"),
  edit(name: "Edit"),
  delete(name: "Delete");

  final String name;

  const EnumForActions({required this.name});
}
