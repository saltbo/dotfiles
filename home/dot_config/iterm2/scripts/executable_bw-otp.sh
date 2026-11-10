#!/bin/bash

source ~/.config/iterm2/scripts/bw.sh

echo $(bw get totp https://account.lixiang.com/login)
