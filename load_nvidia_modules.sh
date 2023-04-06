#!/usr/bin/env bash

MODULES_LOAD=(nvidia nvidia_modeset nvidia_drm nvidia_uvm)
MODULES_UNLOAD=(i2c_nvidia_gpu nvidia_uvm nvidia_drm nvidia_modeset nvidia)

function load_modules {
  for module in "${MODULES_LOAD[@]}"
  do
    # Loading modules
    sudo modprobe "${module}"
  done
}

function unload_modules {
  for module in "${MODULES_UNLOAD[@]}"
  do
    # This line makes removing nvidia module possible
    sudo systemctl stop systemd-logind
    # Unloading modules
    sudo modprobe -r "${module}"
    # sudo rmmod "${module}"
    # sudo systemctl start systemd-logind
  done
}


if [[ "$1" == "load" ]]
then
	load_modules

elif [[ "$1" == "unload" ]]
then
	unload_modules
fi
