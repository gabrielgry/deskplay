#!/bin/bash

sudo dnf install ansible -y &&
ansible-playbook main.yml --ask-become-pass
