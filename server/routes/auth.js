const express = require("express");
// we are basically making own router so instead of app.get or app.post 
// we use authRouter.get etc
const authRouter = express.Router();

// exportingauthRouter, so we can use in index.js
module.exports = authRouter;
