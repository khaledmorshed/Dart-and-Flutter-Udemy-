void main() {
  PowerGrid grid = PowerGrid();
  NuclearPlant nuclear = NuclearPlant();
  SolarPlant solar = SolarPlant();

  grid.addPlant(nuclear);
  grid.addPlant(solar);
}

class PowerGrid {
  List<PowerPlant> connectedPlants = [];

  addPlant(PowerPlant plant) {
    plant.turnOn();
    connectedPlants.add(plant);
  }
}

//So now that our NuclearPlant and SolarPlant qualify as PowerPlant.
abstract class PowerPlant {
  turnOn();
}

//Now NuclearPlant can act as a PowerPlant
class NuclearPlant implements PowerPlant {
  turnOn() {
    print("I am a nuclear plant turning on");
  }
}

class SolarPlant implements PowerPlant {
  turnOn() {
    print("I am a solar plant turnig on");
  }
}
