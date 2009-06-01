# php/manifests/init.pp - various ways of installing php
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# changed and improved by immerda project group admin(at)immerda.ch
# adapated by Puzzle ITC puzzle.ch
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
# See LICENSE for the full license granted to you.

class php {
    case $operatingsystem {
        centos: { include php::centos }
        debian: { include php::debian }
        ubuntu: { include php::ubuntu }
        gentoo: { include php::gentoo }
        default: { include php::base }
    }
}
