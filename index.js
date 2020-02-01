const app = require('express')()
const ROUTES = require('./route/routes')
const indexRoute = require('./route/index')
const detailsRoute = require('./route/details')

app.get(ROUTES.index, indexRoute.get);
app.get(ROUTES.details, detailsRoute.get);

app.listen('4000');