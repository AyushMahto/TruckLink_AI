// const express = require('express');
// const cors = require('cors');

// const app = express();

// // Middleware
// app.use(cors());
// app.use(express.json());

// // Test Route
// app.get('/', (req, res) => {
//   res.json({
//     success: true,
//     message: 'Welcome to TruckLink AI Backend 🚚',
//   });
// });

// module.exports = app;

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

module.exports = app;
