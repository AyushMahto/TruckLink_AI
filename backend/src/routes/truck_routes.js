const express = require("express");
const router = express.Router();

const {
  getAvailableTrucks,
  addTruck,
} = require("../controllers/truck_controller");

router.get("/available", getAvailableTrucks);

router.post("/add", addTruck);

module.exports = router;