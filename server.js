const express = require('express')
const app = express()

app.get('/', (req, res) => {
  res.status(200).send('Hello World from a Node.js app!')
})

server = app.listen(3000, () => {
  console.log('Server is up on 3000')
})

module.exports = {
  server
}
