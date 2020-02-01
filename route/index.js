'use strict'

const get = (req, res) => {
  res.send('Index JS GET')
}

const post = (req, res) => {
  res.send('Index JS POST')
}

module.exports = {
  get,
  post
}