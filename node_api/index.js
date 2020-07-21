const express = require('express')
const app = express()
const port = 8080

app.get('/node', (req, res) => res.send('Hello from node!'))

app.listen(port, () => console.log(`Example app listening at http://localhost:${port}`))
