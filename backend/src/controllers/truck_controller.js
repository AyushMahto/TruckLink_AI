const Truck = require("../models/truck_model");

// =============================
// Get Available Trucks
// =============================
const getAvailableTrucks = async (req, res) => {
  try {
    const trucks = await Truck.find({
      available: true,
    });

    res.status(200).json({
      success: true,
      trucks,
    });
  } catch (error) {
    console.log(error);

    res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

// =============================
// Add Truck
// =============================
const addTruck = async (req, res) => {
  try {
    const truck = await Truck.create(req.body);

    res.status(201).json({
      success: true,
      truck,
    });
  } catch (error) {
    console.log(error);

    res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

// =============================
// Update Truck Location
// =============================
const updateTruckLocation = async (req, res) => {
  try {
    const { truckId } = req.params;
    const { latitude, longitude } = req.body;

    const truck = await Truck.findByIdAndUpdate(
      truckId,
      {
        latitude,
        longitude,
      },
      {
        new: true,
      }
    );

    if (!truck) {
      return res.status(404).json({
        success: false,
        message: "Truck not found",
      });
    }

    res.json({
      success: true,
      truck,
    });
  } catch (error) {
    console.log(error);

    res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

// =============================
// Get Truck Location
// =============================
const getTruckLocation = async (req, res) => {
  try {
    const { truckId } = req.params;

    const truck = await Truck.findById(truckId);

    if (!truck) {
      return res.status(404).json({
        success: false,
        message: "Truck not found",
      });
    }

    res.json({
      success: true,
      latitude: truck.latitude,
      longitude: truck.longitude,
    });
  } catch (error) {
    console.log(error);

    res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

module.exports = {
  getAvailableTrucks,
  addTruck,
  updateTruckLocation,
  getTruckLocation,
};