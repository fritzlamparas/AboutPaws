class PlantDisplay {
  String? description;
  PlantDisplay();

  Map<String, dynamic> toJson() => {
        'description': description,
      };

  PlantDisplay.fromSnapshot(snapshot)
      : description = snapshot.data()['description'];
}
