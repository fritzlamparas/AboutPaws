class DogDisplay {
  String? description;
  DogDisplay();

  Map<String, dynamic> toJson() => {
        'description': description,
      };

  DogDisplay.fromSnapshot(snapshot)
      : description = snapshot.data()['description'];
}
