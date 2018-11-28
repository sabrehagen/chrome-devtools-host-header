# Chrome DevTools Inspect Target Discovery Host Header

When Chrome DevTools polls configured network targets, the Host header on calls to `/json` and `/json/version` should be the hostname that was entered into the 'Target discovery settings' window. https://i.imgur.com/2bS0p8Y.png

## Reproducing the bug

Requires Docker and Yarn to be installed.

```sh
git clone git@github.com:sabrehagen/chrome-devtools-host-header.git
cd chrome-devtools-host-header
./index.sh
```

## What is the expected behavior?

When polling configured network targets, the Host header on calls to `/json` and `/json/version` should be 'inspect-nginx-proxy'.

## What went wrong?

When polling configured network targets, the Host header on calls to `/json` and `/json/version` is '127.0.0.1'.

## Use case

For development environments that have multiple node.js processes listening on 9229, it is convenient to use a reverse proxy to route to node.js instances to avoid port conflicts. Without the Host header being set correctly, nginx cannot route incoming requests appropriately.
