const express = require('express');
const redis = require('redis');

const app = express();
const client = redis.createClient({
  host: 'redis',
  port: 6379
});

client.on('error', (err) => {
  console.log('Error ' + err);
});

app.get('/', (req, res) => {
  client.incr('counter', (err, counter) => {
    if (err) {
      res.status(500).send('Error occurred');
      return;
    }
    res.send(`Welcome count ${counter}`);
  });
});

app.listen(80, () => {
  console.log('Server is running on port 80');
});
