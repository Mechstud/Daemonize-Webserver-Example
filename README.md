### Simple Webserver running in background

- Install go. Follow the instructions from: https://go.dev/doc/install

- Make the bash script executable
```shell
chmod +x startBackground.sh
```

- Run the bash script to start the service in background.
```shell
bash startBackground.sh
```

<b>Test by running following HTTP cURL requests:</b>

```shell
curl -X GET "http://127.0.0.1:12345/api/v1/ping"

curl -X POST "http://127.0.0.1:12345/api/v1/datetime"
```

### Simple Webserver running as daemon

- Create a daemon service file in the /etc/systemd/system folder. 

You can either create a file using editor like nano, and then write the contents there:
```shell
sudo nano /etc/systemd/system/simplewebserver.service

# Now write/copy the contents from simplewebserver.service file in the root of this repository.
```

OR, copy the file directly there:

```shell
sudo cp simplewebserver.service /etc/systemd/system/simplewebserver.service
```

- Ensure that the webserver binary is built
```shell
go build -o SimpleWebserver
```

- Ensure that the binary is executable
```shell
chmod +x SimpleWebserver
```

- Start the daemon service
```shell
sudo systemctl start simplewebserver
```

- Check the status of the daemon service
```shell
sudo systemctl status simplewebserver
```

- Stop the daemon service
```shell
sudo systemctl stop simplewebserver
```

- Restart the daemon service
```shell
sudo systemctl restart simplewebserver
```
- Enable the daemon for Simple Webserver, so that it gets started on OS reboot
```shell
sudo systemctl enable simplewebserver
```

- Disable the daemon service, so that it does not get started on reboot
```shell
sudo systemctl disable simplewebserver
```

- In case of any errors, you can debug by checking the logs
```shell
sudo journalctl -u simplewebserver # OR, sudo journalctl --unit=simplewebserver

# Or, if you want to tail the log, then use
sudo journalctl -u simplewebserver -f
```

- Whenever we manually edit the service file using nano/vim, etc, then we need to ensure the daemon is reload and service is restarted.
```shell
sudo systemctl daemon-reload

sudo systemctl restart simplewebserver
```

- To edit the service file, without needing a daemon-reload:
```shell
sudo systemctl edit simplewebserver --full
```

- Get a complete list of systemd service configuration parameters
```shell
man systemd.service
```

OR, visit: https://man7.org/linux/man-pages/man5/systemd.service.5.html
