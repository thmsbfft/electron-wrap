#### electron-wrap

---

Package any static web folder into a desktop application (macOS). The process requires Node/npm.

To do so, `cd` to the folder that contains the files, and run:

```
bash <(curl -s https://raw.githubusercontent.com/thmsbfft/electron-wrap/master/wrap.sh)
```

The script will:

**➀** Download `package.json`, `index.js`, and `icon.icns` from this repository

**➁** Replace the name of the app by your folder's name

**➂** Install the dependencies (electron, express to serve the files)

**➃** Package the folder into an Electron executable
