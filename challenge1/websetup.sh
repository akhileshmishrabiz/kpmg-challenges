#!/bin/bash
sudo yum install httpd
systemctl enable https
systemctl start httpd