#!/bin/bash

##set some custom variables. edit these if needed
# google vision credintials location
export GOOGLE_APPLICATION_CREDENTIALS="/home/pi/googlevision"
export GOOGLE_APPLICATION_CREDENTIALS="/home/pi/googlevision/google.json"
# what folder does this application run from
apphome="/home/pi/googlevision"
# date variable is used for my camera ftp folder structure in 2020/01/15 format
date=$(date +%Y/%m/%d)
folder=$date 
path="/mnt/cctv/braai"
# datetime is used for syslog timestamps in the logs below
datetime=$(date)
${datetime} : ${countpersons} person/s detected in braai area")

# some calculations. check for new image files on the ftp folder less than 1 minute old
lastfile=$(find $path/$folder -name "*.jpg" -mmin -0.6)
filecount=$(find $path/$folder -name "*.jpg" -mmin -0.6 | wc -l)
# Count amount of persons detected from log file
countpersons=$(grep Person $apphome/detect.log | wc -l)


if [ "$filecount" -gt "0" ]; then
$apphome/detect.py object-localization $lastfile > $apphome/detect.log
    if [ "$countpersons" -gt "0" ]; then
        echo "$datetime : Alert: $countpersons person detected" >> $apphome/detect_history.log
	# change this to whatever form of communication channel you want to use I prefer Telegram This can be email sms api provider etc.
        curl "https://api.telegram.org/bot123456789:AAE1234_123456789_12345678-AAA/sendMessage?chat_id=XXXXXXXXXX&text=CCTV ALERT: ${datetime} : ${countpersons} person/s detected in braai area"
        # clean out log file again to avoid false possitives for next round
	echo > $apphome/detect.log
	exit 1
    else
        echo "$datetime : Motion but NO People detected" >> $apphome/detect_history.log
        echo "$datetime : No People" >> $apphome/detect.log
	exit 0
    fi
else
   echo "$datetime : No Motion" >> $apphome/detect.log
   exit 0
fi
