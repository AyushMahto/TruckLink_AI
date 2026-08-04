const express = require("express");

const {
  createBooking,
  getBookings,
} = require("../controllers/booking_controller");

const router = express.Router();

// Create Booking
router.post("/", createBooking);

// Get All Bookings
router.get("/", getBookings);

module.exports = router;