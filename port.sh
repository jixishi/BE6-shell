#!/bin/bash
port=$(cat port)
while true
do
sleep 1h
curl https://github.com/Anuken/Mindustry 2>/dev/null | grep -E 'href="/Anuken/Mindustry/releases/tag/v[0-9]*' | sed 's/^.*  <a class="link-gray-dark d-flex no-underline" href="\/Anuken\/Mindustry\/releases\/tag\/v//g' | sed 's/\.[0-9]">.*$//g' | sed 's/">.*$//g' >>./bb1
curl https://github.com/way-zer/ScriptAgent4MindustryExt 2>/dev/null | grep -E '/way-zer/ScriptAgent4MindustryExt/releases/tag/v[0-9]*' | sed 's/^.*<a class="link-gray-dark d-flex no-underline" href="\/way-zer\/ScriptAgent4MindustryExt\/releases\/tag\/v//g' | sed 's/">.*$//g' >>./bb3
data1=$(cat bb1)
data2=$(cat bb2)
data3=$(cat bb3)
data4=$(cat bb4)
if [[ $data1 == $data2 ]]; then
    if [[ $data3 == $data4 ]]; then
    else
        pid pid=$(netstat -nlp | grep :$port | awk '{print $7}' | awk -F"/" '{ print $1 }') 
        kill -9 $pid
        wget -O scripts.zip https://github.com/way-zer/ScriptAgent4MindustryExt/releases/download/v${data3}/ScriptAgent4Mindustry-${data3}-scripts.zip
        rm -f bb4
        mv bb3 bb4
        mv config/scripts/data /be6/data
        rm -rf config/scripts/
        unzip -o scripts.zip -d config/scripts/
        rm -f scripts.zip
        mv /be6/data/ config/scripts/data/
        java -jar server.jar &
    fi
else
    pid pid=$(netstat -nlp | grep :$port | awk '{print $7}' | awk -F"/" '{ print $1 }') 
    kill -9 $pid
    rm -f bb2
    mv bb1 bb2
    rm -f server.jar
    wget -O server.jar https://github.com/Anuken/Mindustry/releases/download/v${data1}/server-release.jar
    if [[ $data3 == $data4 ]]; then
        java -jar server.jar &
    else
        pid pid=$(netstat -nlp | grep :$port | awk '{print $7}' | awk -F"/" '{ print $1 }') 
        kill -9 $pid
        wget -O scripts.zip https://github.com/way-zer/ScriptAgent4MindustryExt/releases/download/v${data3}/ScriptAgent4Mindustry-${data3}-scripts.zip
        rm -f bb4
        mv bb3 bb4
        mv config/scripts/data /be6/data
        rm -rf config/scripts/
        unzip -o scripts.zip -d config/scripts/
        rm -f scripts.zip
        mv /be6/data/ config/scripts/data/
        java -jar server.jar &
    fi
fi
done
