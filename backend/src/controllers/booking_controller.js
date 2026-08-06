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
    const { customerId } = req.params;

    const bookings = await Booking.find({
      customer: customerId,
    })
      .populate("truck")
      .sort({ createdAt: -1 });

    res.json({
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
// Update Booking Status
// =========================

const updateBookingStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    const booking = await Booking.findByIdAndUpdate(
      id,
      { status },
      { new: true }
    );

    if (!booking) {
      return res.status(404).json({
        success: false,
        message: "Booking not found",
      });
    }

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

module.exports = {
  createBooking,
  getBookings,
  getPendingBookings,
  getCustomerBookings,
  updateBookingStatus,
};
