var admin = require("firebase-admin");

var serviceAccount = require("../smartwarehousemanager-1523c-firebase-adminsdk-fbsvc-a46a049d73.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

module.exports = admin;