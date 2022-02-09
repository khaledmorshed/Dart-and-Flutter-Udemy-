void main() {
  PowerGrid grid = PowerGrid();
  NuclearPlant nuclear = NuclearPlant();

  grid.addPlant(nuclear);
}

class PowerGrid {
  List<NuclearPlant> connectedPlants = [];

  addPlant(NuclearPlant plant) {
    plant.turnOn();
    connectedPlants.add(plant);
  }
}

class NuclearPlant {
  turnOn() {
    print("I am a nuclear plant turning on");
  }
}
