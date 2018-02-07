const {app, Menu, BrowserWindow} = require('electron')

const express = require('express')

const path = require('path')
const url = require('url')

var w

var app_ready = false
var server_ready = false

const server = express()
const port = 3000

server.use(express.static(__dirname))
server.listen(port, function() {
  server_ready = true
  if (app_ready) open()
})

function open () {
  let bw_options = {
    width: 1680,
    height: 800
  }

  w = new BrowserWindow(
    bw_options
  )

  w.loadURL(url.format({
    pathname: 'localhost' + ':' + port,
    protocol: 'http:',
    slashes: true
  }))

  // w.webContents.openDevTools()

  w.on('closed', function () {
    w = null
  })
}

app.on('ready', function () {
  app_ready = true
  create_menus()
  if (server_ready) open()
})

app.on('window-all-closed', function () {
  app.quit()
})

function create_menus () {
  const template = [
    {
      label: app.getName(),
      submenu: [
        {
          role: 'quit'
        }
      ]
    },
    {
      label: 'Edit',
      submenu: [
        {role: 'undo'},
        {role: 'redo'},
        {type: 'separator'},
        {role: 'cut'},
        {role: 'copy'},
        {role: 'paste'},
        {role: 'pasteandmatchstyle'},
        {role: 'delete'},
        {role: 'selectall'}
      ]
    },
    {
      label: 'View',
      submenu: [
        {
          label: 'Open in Browser...',
          click () {
            require('electron').shell.openExternal('http://localhost:' + port)
          }
        },
        {
          type: 'separator'
        },
        {role: 'reload'},
        {role: 'forcereload'},
        {role: 'toggledevtools'},
        {type: 'separator'},
        {role: 'resetzoom'},
        {role: 'zoomin'},
        {role: 'zoomout'},
        {type: 'separator'},
        {role: 'togglefullscreen'}
      ]
    }
  ]

  const menu = Menu.buildFromTemplate(template)
  Menu.setApplicationMenu(menu)
}