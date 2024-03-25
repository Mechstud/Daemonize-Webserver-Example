#!/bin/sh

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