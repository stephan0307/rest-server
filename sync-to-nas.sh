#!/bin/bash

rsync -avh --delete --exclude .git . administrator@nas-paul:/share/Backup-Images/DockerImages/restic-server
