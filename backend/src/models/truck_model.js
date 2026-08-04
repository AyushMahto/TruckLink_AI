const mongoose = require("mongoose");

const truckSchema = new mongoose.Schema(
  {
    truckName: {
      type: String,
      required: true,
    },

    truckType: {
      type: String,
      required: true,
    },

    driverName: {
      type: String,
      required: true,
    },

    driverPhone: {
      type: String,
      required: true,
    },

    pricePerKm: {
      type: Number,
      required: true,
    },

    capacity: {
      type: Number,
      required: true,
    },

    currentLocation: {
      type: String,
      required: true,
    },

    available: {
      type: Boolean,
      default: true,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Truck", truckSchema);