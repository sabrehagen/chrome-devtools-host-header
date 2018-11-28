require('express')().all('*', (req, res) => {
  console.log({
    path: req.path,
    headers: req.headers,
    method: req.method,
    hostname: req.hostname,
    ip: req.ip,
  });

  res.json();
})
.listen(4444)
