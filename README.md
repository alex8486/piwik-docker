# piwik-docker
Piwik analytics platform for OpenShift v3

# General

This is a fork to work with OpenShift v 3.3 as non Root. 
Added a config.ini.php file so no installation has to be done after restart of container. 
For first installation remove it!

Look into default.conf file and edit the trusted Hosts. The sed command in entrypoint.sh is not working for me.



## Environment variables
ALLOWED_HOSTNAME = your-domain-name
