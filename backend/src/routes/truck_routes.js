const express = require("express");
const router = express.Router();

const {
  getAvailableTrucks,
  addTruck,
  updateTruckLocation,
  getTruckLocation,
} = require("../controllers/truck_controller");

// Truck APIs
router.get("/available", getAvailableTrucks);
router.post("/add", addTruck);

// Live Tracking APIs
router.put("/location/:truckId", updateTruckLocation);
router.get("/location/:truckId", getTruckLocation);

module.exports = router;