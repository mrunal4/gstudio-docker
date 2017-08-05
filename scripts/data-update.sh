#!/bin/bash

# Following variables are used to store the color codes for displaying the content on terminal
black="\033[0;90m" ;
red="\033[0;91m" ;
green="\033[0;92m" ;
brown="\033[0;93m" ;
blue="\033[0;94m" ;
purple="\033[0;95m" ;
cyan="\033[0;96m" ;
grey="\033[0;97m" ;
white="\033[0;98m" ;
reset="\033[0m" ;

# Mrunal : 20161123 : below part is added by Mrunal as suggested by Nagarjuna
echo -e "\n${cyan}***   Learning Studio - DOER Edition (August 2017 update patch)   ***${reset}\n" ;
echo -e "${cyan}      school server installation      ${reset}\n" ;
echo -e "\n${brown}Note : \nThis installation is a one-time used process.${reset}" ;
echo -e "${brown}It uses a terminal-console which may show many details during updations.${reset}" ;
echo -e "${brown}This is normal. Please let the updation proceed.${reset}\n" ;
sleep 5

filename=$(basename $(ls -r /mnt/update_*.tar.gz |  head -n 1));
update_patch="${filename%.*.*}";

echo -e "\n${cyan}copy updated patch from /mnt/home/core/${update_patch} to /home/docker/code/ in gstudio container ${reset}";
sudo docker cp /mnt/${update_patch} gstudio:/home/docker/code/;

echo -e "\n${cyan}copy updated patch from /home/docker/code./${update_patch}/data-updates/* to /data/ in gstudio container ${reset}";
docker exec -it gstudio /bin/sh -c "rsync -avzPh /home/docker/code/${update_patch}/data-updates/* /data/data_export/";

echo -e "\n${cyan}Update offline patch ${reset}";
docker exec -it gstudio /bin/sh -c "/bin/bash /home/docker/code/${update_patch}/data-updates/course-import-and-export-update.sh";

echo -e "\n${cyan}Restart gstudio container ${reset}";
sudo docker restart gstudio;
