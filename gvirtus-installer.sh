#! /bin/bash

if [ $# -ne 1 ]; then
  /bin/echo -e "\e[1;91mUsage: $0 \"path-of-installation-folder\"\e[0m"
  exit 1
fi

INSTALL_FOLDER=$1

for module in $(find . -maxdepth 1 -type d -regextype egrep -regex "./gvirtus(\.[a-zA-Z]*|\b)" | sort); do
  cd $module
  bash install.sh ${INSTALL_FOLDER}
  cd $OLDPWD
done

lpath=${INSTALL_FOLDER}/lib/frontend
for lib in $(find $lpath -name "*.so" | sed 's|^./||'); do
  ln -sf $lib $lib.9.0
done
/bin/echo -e "\e[1;30;102mSYMBOLIC LINKS TO LIBRARY CREATED!\e[0m"
echo

/bin/echo -ne "\e[1;97;44;5mDo you want clean build files? (y|n) [Default: n]:\e[0m  "
read flag
if [[ $flag == "y" || $flag == "yes" ]]; then
  echo
  echo "-- Build files will be removed!"
  echo "$(bash ./gvirtus-cleaner.sh)"
else
  echo
  echo "-- Build files will not be removed!"
  /bin/echo -e "-- If you want clean build files run \e[1;92m.$PWD/gvirtus-cleaner.sh\e[0m"
fi

echo
/bin/echo -e "\e[1;97;42mINSTALLATION COMPLETED!\e[0m"
echo
