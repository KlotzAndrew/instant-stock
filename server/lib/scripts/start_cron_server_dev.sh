#! /bin/sh

whenever --update-crontab --set environment='development'
cron -f
