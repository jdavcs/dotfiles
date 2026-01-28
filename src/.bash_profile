#!/bin/bash

# hide annoying zsc message
if [[ $(uname -s) == 'Darwin' ]]; then
	export BASH_SILENCE_DEPRECATION_WARNING=1
fi

. .bashrc
