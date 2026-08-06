const Booking = require("../models/booking_model");

// =========================
// Create Booking
// =========================
const createBooking = async (req, res) => {
  try {
    const booking = await Booking.create(req.body);

    res.status(201).json({
      success: true,
      booking,
    });
  } catch (error) {
    console.log(error);

    res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

// =========================
// Get All Bookings
// =========================
const getBookings = async (req, res) => {
  try {
    const bookings = await Booking.find()
      .populate("customer")
      .populate("truck");

    res.status(200).json({
      success: true,
      bookings,
    });
  } catch (error) {
    console.log(error);

    res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

// =========================
// Get Pending Bookings
// =========================
const getPendingBookings = async (req, res) => {
  try {
    const bookings = await Booking.find({
      status: "Pending",
    })
      .populate("customer")
      .populate("truck");

    res.json({
      success: true,
      bookings,
    });
  } catch (err) {
    console.log(err);

    res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

// =========================
// Get Customer Bookings
// =========================
const getCustomerBookings = async (req, res) => {
  try {
    const bookings = await Booking.find({
      customer: req.params.customerId,
    })
      .populate("truck")
      .sort({ createdAt: -1 });

    res.json({
      success: true,
      bookings,
    });
  } catch (err) {
    console.log(err);

    res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

// =========================
// Update Booking Status
// =========================
const updateBookingStatus = async (req, res) => {
  try {
    const booking = await Booking.findByIdAndUpdate(
      req.params.id,
      {
        status: req.body.status,
      },
      {
        new: true,
      }
    );

    res.json({
      success: true,
      booking,
    });
  } catch (error) {
    console.log(error);

    res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

// =========================
// START TRIP
// =========================
const startTrip = async (req, res) => {
  try {
    const booking = await Booking.findByIdAndUpdate(
      req.params.id,
      {
        tripStarted: true,
        status: "In Transit",
      },
      {
        new: true,
      }
    );

    res.json({
      success: true,
      booking,
    });
  } catch (err) {
    console.log(err);

    res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

// =========================
// UPDATE DRIVER LOCATION
// =========================
const updateLocation = async (req, res) => {
  try {
    const { latitude, longitude } = req.body;

    const booking = await Booking.findByIdAndUpdate(
      req.params.id,
      {
        currentLatitude: latitude,
        currentLongitude: longitude,
      },
      {
        new: true,
      }
    );

    res.json({
      success: true,
      booking,
    });
  } catch (err) {
    console.log(err);

    res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

// =========================
// GET LIVE LOCATION
// =========================
const getLiveLocation = async (req, res) => {
  try {
    const booking = await Booking.findById(req.params.id);

    res.json({
      success: true,
      latitude: booking.currentLatitude,
      longitude: booking.currentLongitude,
      status: booking.status,
      tripStarted: booking.tripStarted,
      tripCompleted: booking.tripCompleted,
    });
  } catch (err) {
    console.log(err);

    res.status(500).json({
      success: false,
      message: "Server Error",
    });
  }
};

module.exports = {
  createBooking,
  getBookings,
  getPendingBookings,
  getCustomerBookings,
  updateBookingStatus,
  startTrip,
  updateLocation,
  getLiveLocation,
};