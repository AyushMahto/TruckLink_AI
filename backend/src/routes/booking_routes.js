const express = require("express");
const router = express.Router();

const {
  createBooking,
  getBookings,
  getPendingBookings,
  updateBookingStatus,
  getCustomerBookings,
} = require("../controllers/booking_controller");

// Create Booking
router.post("/", createBooking);

// All Bookings
router.get("/", getBookings);

// Pending Bookings
router.get("/pending", getPendingBookings);

// Customer Bookings
router.get("/customer/:customerId", getCustomerBookings);

// Update Booking Status
router.put("/:id", updateBookingStatus);

module.exports = router;