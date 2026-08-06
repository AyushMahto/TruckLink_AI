const express = require("express");
const router = express.Router();

const {
  createBooking,
  getBookings,
  getPendingBookings,
  getCustomerBookings,
  updateBookingStatus,
  startTrip,
  updateLocation,
  getLiveLocation,
} = require("../controllers/booking_controller");

// =========================
// Create Booking
// =========================
router.post("/", createBooking);

// =========================
// Get All Bookings
// =========================
router.get("/", getBookings);

// =========================
// Get Pending Bookings
// =========================
router.get("/pending", getPendingBookings);

// =========================
// Get Customer Bookings
// =========================
router.get("/customer/:customerId", getCustomerBookings);

// =========================
// Update Booking Status
// =========================
router.put("/:id", updateBookingStatus);

// =========================
// Live Tracking Routes
// =========================

// Driver starts trip
router.put("/start/:id", startTrip);

// Driver updates location
router.put("/location/:id", updateLocation);

// Customer gets live location
router.get("/location/:id", getLiveLocation);

module.exports = router;