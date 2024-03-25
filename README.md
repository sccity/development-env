# Santa Clara Development Environment

The Santa Clara Development Environment is a simple Linux build with R Studio and JupyterLab. It comes preconfigured with the most common packages used for our development and data analysis workflow.

## Requirements
* [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Install & Run (Windows)
Download & Install Docker Desktop

Run this command:
```
docker run -d -p 8000:8787 -p 8001:8888 --name development-env --restart=unless-stopped --mount source=dev-env-home,target=/home sccity/development-env:beta
```

## Access R Studio and JupyterLab
Username & Password is sccity
R Studio: http://localhost:8000
JupyterLab: http://localhost:8001

## Python Packages
click
lxml
PyMySQL
PyYAML
requests
xmltodict
python-dotenv
cachetools
Flask
Flask_RESTful
waitress
Werkzeug
flask_swagger_ui
sqlalchemy
bs4
ratelimit
numpy
scipy
pandas

## R Packages
DBI
RMySQL
XLConnect
xlsx
tidyverse
dplyr
tidyr
stringr
formatR
lubridate
ggplot2
tidymodels
repr
caret
ggmap
zoo
xts
quantmod
jsonlite
httr
ggrepel
sqldf
xml2
XML
xml2
safer
stringr
protolite
sf
geojsonio
scales
broom
viridis
sp
tidyr
tigris
mapview
leaflet
htmlwidgets
forecast
webshot