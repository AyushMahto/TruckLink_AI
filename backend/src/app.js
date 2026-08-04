
// module.exports = app;
// const bookingRoutes = require("./src/routes/booking_routes");
const bookingRoutes = require("./routes/booking_routes");
const truckRoutes = require("./routes/truck_routes");
const express = require("express");
const cors = require("cors");

const authRoutes = require("./routes/auth_routes");

const app = express();

app.use(cors());
app.use(express.json());


// Home Route
app.get("/", (req, res) => {
  res.json({
    success: true,
    message: "Welcome to TruckLink AI Backend 🚚",
  });
});

// Auth Routes
app.use("/api/auth", authRoutes);
app.use("/api/trucks", truckRoutes);
app.use("/api/bookings", bookingRoutes);

module.exports = app;
