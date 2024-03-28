const { app, BrowserWindow, Menu } = require('electron');
const path = require('path');

let win;

function createWindow() {
    // Create the browser window
    win = new BrowserWindow({
        width: 1350,
        height: 810,
        minWidth: 530,
        minHeight: 740,
        resizable: true
    });

    // Load the default URL
    win.loadURL("http://localhost:8000")
        .catch(error => {
            // Show an error dialog if the URL couldn't be loaded
            dialog.showErrorBox(
                'Connection Error',
                'Make sure the Development Environment Docker Container is running.'
            );
        });

    // Listen for page title updates
    win.webContents.on('page-title-updated', (event, title) => {
        // Update the window title
        win.setTitle(`Development Environment - ${title}`);
    });

    // Define the menu template
    const menuTemplate = [
        {
            label: 'File',
            submenu: [
                {
                    label: 'Quit',
                    accelerator: 'CmdOrCtrl+Q',
                    click: () => app.quit()
                }
            ]
        },
        {
            label: 'Environment',
            submenu: [
                {
                    label: 'R Studio',
                    click: () => win.loadURL('http://localhost:8000')
                },
                {
                    label: 'JupyterLab',
                    click: () => win.loadURL('http://localhost:8001')
                },
                {
                    label: 'Retool',
                    click: () => win.loadURL('https://apps.santaclarautah.gov')
                }
            ]
        }
    ];

    // Build the menu
    const menu = Menu.buildFromTemplate(menuTemplate);
    Menu.setApplicationMenu(menu);
}

// When Electron is ready, create the window
app.whenReady().then(createWindow);
