#!/usr/bin/awk -f
# -------------------------------------------
#       @script: columnate.awk
#         @link: https://github.com/NRZCode/Columnate
#  @description: Awk script to format text columnate
#      @license: GNU/GPL v3.0
#      @version: 0.0.1
#       @author: Romeu Alfa <nrzcode@protonmail.com>
#      @created: 01/02/2023 03:54
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
#   awk -v width=COLUMNS -v height=LINES -v page=PAGE -f columnate.awk FILE
# -------------------------------------------
# DESCRIPTION
#   Format text columnate
#
# OPTIONS
#   General options
#     width     Output is formatted for a display columns wide.
#     height    Display output with the given height instead of using the full text.
#               (80 columns default)
#     page      Display a page number paginate output
function ceil(x) {return x%1 ? int(x)+1 : x}
{
    if (length($0) > maxlen)
        maxlen=length($0)
    records[NR]=$0
}
END {
    col=1
    lin=1
    pg=1
    if (width == 0)
        width=80
    maxlen+=3
    lim=int(sprintf("%.2f", width/maxlen))
    pages=1
    if (height > 0)
        pages=ceil(ceil(NR/lim)/height)
    if (page > pages) {
        print "Page out of range." | "cat 1>&2"
        exit(1)
    }

    for (k in records) {
        buffer[pg][lin][col]=records[k]
        col++
        if (col > lim) {
            col=1
            lin++
        }
        if (height > 0 && lin > height) {
            pg++
            lin=1
        }
    }
    for (p in buffer) {
        if (page == 0 || page == p) {
            for(l in buffer[p]) {
                for(c in buffer[p][l]) {
                    printf "%-*s", maxlen, buffer[p][l][c]
                }
                printf "\n"
            }
        }
    }
}
