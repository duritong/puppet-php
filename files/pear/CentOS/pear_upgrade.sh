#!/bin/bash

pear update-channels > /dev/null && pear upgrade-all > /dev/null
pecl update-channels > /dev/null && pecl upgrade-all > /dev/null
