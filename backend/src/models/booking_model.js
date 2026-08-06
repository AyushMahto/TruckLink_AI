const mongoose = require("mongoose");

const bookingSchema = new mongoose.Schema(
  {
    customer: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },

    truck: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Truck",
      required: true,
    },

    pickup: {
      type: String,
      required: true,
    },

    destination: {
      type: String,
      required: true,
    },

    goodsType: {
      type: String,
      required: true,
    },

    weight: {
      type: Number,
      required: true,
    },

    status: {
      type: String,
      enum: [
        "Pending",
        "Accepted",
        "Rejected",
        "Picked",
        "In Transit",
        "Delivered",
        "Cancelled",
      ],
      default: "Pending",
    },

    totalPrice: {
      type: Number,
      required: true,
    },

    // =========================
    // Live Tracking
    // =========================

    currentLatitude: {
      type: Number,
      default: 18.5204, // Pune
    },

    currentLongitude: {
      type: Number,
      default: 73.8567, // Pune
    },

    tripStarted: {
      type: Boolean,
      default: false,
    },

    tripCompleted: {
      type: Boolean,
      default: false,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Booking", bookingSchema);