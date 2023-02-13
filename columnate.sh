#!/usr/bin/env bash
# -------------------------------------------
#       @script: columnate.sh
#         @link: https://github.com/NRZCode/Columnate
#  @description: Shell script to format text columnate
#      @license: GNU/GPL v3.0
#      @version: 0.0.1
#       @author: Romeu Alfa <nrzcode@protonmail.com>
#      @created: 13/02/2023 10:49
#
# @requirements: ---
#         @bugs: ---
#        @notes: ---
#     @revision: ---
# -------------------------------------------
# Copyright (C) 2023 Romeu Alfa <nrzcode@protonmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
# -------------------------------------------
# USAGE
#   columnate.sh [OPTIONS] FILE
# -------------------------------------------
version='0.0.1'
usage='Usage: columnate.sh [OPTIONS] FILE

DESCRIPTION
    Script Description

OPTIONS
  General options
    width=COLUMNS
    height=LINES
    page=PAGE
    -h, --help        Print this help usage and exit
    -v, --version     Display version information and exit
'

# functions ---------------------------------
mapbuffer() { (( ${#2} > wcol )) && wcol=${#2}; }

show_page() {
    l=1
    for k in $(grep "^$1:" <<< "$idx"); do
        : ${k#*:}; [[ ${_%:*} != $l ]] && { l=${_%:*}; printf '\n'; }
        printf '%s%*s%s' "${buffer[$k]}" $((wcol - ${#buffer[$k]})) '' "$sep"
    done
echo; echo $SECONDS s printing page $1
}

main() {
    declare -A buffer
    sep=' | '

    mapfile -t < <(grep -n '' "$1")
    wcol=$(awk '{if (length($0) > wcol) wcol=length($0)} END {print wcol}' <(grep -n '' "$1"))

    (( width=COLUMNS, height=LINES - 4 ))
    (( lim=width / (wcol + ${#sep}) ))
echo $SECONDS s loading mapfile
    p=1; l=1; c=1
    for v in "${MAPFILE[@]}"; do
        buffer[$p:$l:$c]=$v
        (( c++, c > lim )) && (( c=1, l++ ))
        (( height > 0 && l > height )) && (( p++, l=1 ))
    done
echo $SECONDS s loading buffer

echo $SECONDS s loading buffer
    (( n=(${#MAPFILE[@]} + lim - 1)/lim, pages=(n + height - 1)/height ))

    idx="$(printf '%s\n' "${!buffer[@]}" | sort -t : -k 1,1n -k 2,2n -k 3,3n)"
echo $SECONDS s sorting keys
    : "$(echo "$idx")"
echo $SECONDS s printing keys
    show_page 1
    show_page 200
}

# main --------------------------------------
shopt -s checkwinsize
:|:                                             # Necessário para carregar a var LINES
main "$@"
