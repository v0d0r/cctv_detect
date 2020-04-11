# cctv_detect
Some scripts to take CCTV motion image capture files and scan for people using Google Vision API.
Requires: Google Vision API account and python modules to be installed 

Once you have a google vision account and api credentials store them update the bash script and install python modules
sudo pip install google-cloud-vision


- Init script

- Bash script (customised for my setup but you can change the variables inside to suite your needs)

- Python script provided by google vision api to talk to their API


If a person is detected alert via communicaiton channel of choise. In my case Telegram but you can change this to any other communication medium.

