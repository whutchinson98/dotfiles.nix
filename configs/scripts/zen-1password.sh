#!/bin/sh

sudo mkdir /etc/1password
sudo touch /etc/1password/custom_allowed_browsers
echo "zen-bin" >> /etc/1password/custom_allowed_browsers
