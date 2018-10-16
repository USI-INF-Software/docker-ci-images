# Docker Image for testing Visual Studio Code Extension

## What's included

- Node.js 8
- X11Vnc
- Xvfb
- Visual Studio Code

Based on [docker-node](https://github.com/nodejs/docker-node) image.

When using this image in a CI (e.g., GitLabCI), define a `postinstall` script in your package.json to install vscode dependencies as follows:

```json
"scripts": {
    ...
    "postinstall": "node ./node_modules/vscode/bin/install"
    ...
}
```

Always run the script after `npm install`.

```bash
npm install
npm run postintall
...
```