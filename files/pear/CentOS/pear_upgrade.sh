#!/bin/bash

pear update-channels > /dev/null && pear upgrade > /dev/null
pecl update-channels > /dev/null && pecl upgrade > /dev/null
