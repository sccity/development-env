```
docker run -d -p 8000:8787 -p 8001:8888 --name development-env --restart=unless-stopped --mount source=dev-env-home,target=/home sccity/development-env:beta
```