#!/bin/sh

# Switch to the directory where code is located
# Binary will be built in the same directory
cd /home/madhurbhaiya/code/Daemonize-Webserver-Example || exit

echo "Building new binary of SimpleWebserver"
go build -o SimpleWebserver

# Get process ID of the existing process, if running
processId=$(pidof SimpleWebserver)

# -z flag is use to check for empty string. When processId is not found, it will be empty string
if [ -z "$processId" ]; then
  echo "SimpleWebserver service is not running."
else
  echo "Found running SimpleWebserver service - Process ID: ${processId}"

  # Kill the process. -9 flag is used to force kill the process
  kill -9 "$processId"

  # The process may be gracefully exiting, so it may not get killed right away
  # So, we need to wait in a loop for the process to exit.

  # kill -0 does not kill a process, but only simulates the behaviour
  # It fails when there is no process to kill, and that effectively breaks the loop
  while kill -0 "$processId" 2> /dev/null; do
    sleep 1
  done

  echo "Killed Process ID: ${processId}"
fi

echo "Starting SimpleWebserver service..."

# & creates a subshell and attaches to the existing shell (terminal) and sends the process to background
# We can start running other commands in the shell (terminal). However, when we kill the terminal,
# all sub-shells are also killed as well (SIGHUP signal is sent to them as well).

# "nohup" command to rescue - It is the poor man's way of running a process as a daemon
# Prevents SIGHUP (hangup) signal to reach the process (when terminal is killed)
# It arranges for input to come from /dev/null and output / errors go to nohup.out

# We can redirect output/errors to our specified log file using >> OR >
# >> appends to log file ; > overwrites to log file ; Avoid overwrite so that when service is restarted, old logs dont go away
nohup ./SimpleWebserver >> background.log.out 2>&1 &

# Sleep for 2 seconds, as sometimes, nohup does not start the new process right-away
sleep 2

processIdNew=$(pidof SimpleWebserver)
echo "Process ID of new SimpleWebserver service: ${processIdNew}"
