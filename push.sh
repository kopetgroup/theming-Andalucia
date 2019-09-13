#!/bin/bash

codename=`cat '.codename'`
dir=`echo $PWD`
bs="$(basename "$(dirname "$dir")")"
bs2="$(basename "$(dirname "$bs")")"
nm=`basename $dir`
project=$codename'-'$nm

# THEMES
repo="https://ikamai:kopet1234@gitlab.com/ikamai-19/themes/$project.git"

dir=`echo $PWD`
#echo 'deploy fast: '$project
echo $repo
#echo "DIR"$dir \n

#echo $project > .codename
echo "commit msg:"
read komit

#rm -rf /tmp/$project; exit
mkdir /tmp/$project

cd /tmp/$project/

git init
git remote add origin $repo
git checkout master
git pull origin master

cd $dir
rsync -rtv --delete ./ /tmp/$project --exclude '.git/' --exclude 'data_mongo/' --exclude 'dump/' --exclude 'data/' > /dev/null
cd /tmp/$project/


if [ -n "$1" ]; then
    git config --global user.name "system"
else
    git config --global user.name "ikamai"
fi

git add --all
git commit -m "$komit"
git push -u origin master


cd $dir
#docker build -t kopet .;
#docker run --rm -ti --name kopet kopet;
