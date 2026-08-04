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

module.exports = {
  getAvailableTrucks,
  addTruck,
};