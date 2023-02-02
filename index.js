const app = require('express')()
const bodyParser = require('body-parser')

const ROUTES = require('./route/routes')
const indexRoute = require('./route/index')
const detailsRoute = require('./route/details')

//  MIDDLEWARE
app.use(bodyParser.json())

// GET
app.get(ROUTES.index, indexRoute.get);
app.get(ROUTES.details, detailsRoute.get);

// POST
app.post(ROUTES.index, indexRoute.post);
app.post(ROUTES.details, detailsRoute.post);


app.listen('4000');
