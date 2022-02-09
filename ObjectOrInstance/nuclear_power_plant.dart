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
    //turnOn method accept a string and return a boolean
    bool confirmation = plant.turnOn("5 hours");
    connectedPlants.add(plant);
  }
}

//So now that our NuclearPlant and SolarPlant qualify as PowerPlant.
abstract class PowerPlant {
  int? costOfEnergy;
  bool turnOn(String duration);
}

abstract class Abuilding {
  int? height;
}

//Now NuclearPlant can act as a PowerPlant
class NuclearPlant implements PowerPlant {
  //it comes from PowePlant instance variable
  int? costOfEnergy;
  bool turnOn(String tiemToStayOn) {
    print("I am a nuclear plant turning on");
    return true;
  }

  //just make sure that we can add so many method inside of this class
  //and PowerPlant doesn't have any issue.This class is independet.
  meltDown() {
    print("Blows up");
  }
}

//so A single class can implements multiple abstract classes. 
class SolarPlant implements PowerPlant, Abuilding {
  int? costOfEnergy;
  int? height;

  bool turnOn(String timeToStayOn) {
    print("I am a solar plant turnig on");
    return false;
  }
}
