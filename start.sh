#!/bin/bash
echo -e "欢迎使用\033[36mBE6\033[0m自动化开服脚本"
curl http://www.iyuji.cn/iyuji/s/Zk9HWjhRNk5tWmVYTklQS2FRRmxxUT09/1612931423341522 2>/dev/null | grep -E '<p>【wlgg】' | sed 's/<p>【wlgg】/【网络公告】/g' | sed 's/{wlgg}<\/p>/\n/g' | sed 's/^.*【wlggt】/【网络公告】/g' | sed 's/{wlggw}.*$//g' | sed 's/<br>//g' | sed 's/<p><\/p>//g'
systemctl stop firewalld.service
echo -e "\033[31m端口以放通\033[0m"
sleep 5s
shpid=$(cat shpid)
kill -9 $shpid
rm -f shpid
rm -f bb1
rm -f bb3
echo -e "………\033[36m检测更新中\033[0m………"
curl https://github.com/Anuken/Mindustry 2>/dev/null | grep -E 'href="/Anuken/Mindustry/releases/tag/v[0-9]*' | sed 's/^.*\/tag\/v//g' | sed 's/\.[0-9]">.*$//g' | sed 's/">.*$//g' >>./bb1
echo -e "………\033[36m 游戏版本获取成功 \033[0m………"
curl https://github.com/way-zer/ScriptAgent4MindustryExt 2>/dev/null | grep -E '/way-zer/ScriptAgent4MindustryExt/releases/tag/v[0-9]*' | sed 's/^.*\/tag\/v//g' | sed 's/">.*$//g' >>./bb3
echo -e "………\033[36m 插件版本获取成功 \033[0m………"
data1=$(cat bb1)
data2=$(cat bb2)
data3=$(cat bb3)
data4=$(cat bb4)
if [ -e name.sh ]; then
    ./name.sh && >>./shpid
fi
if [ -e port.sh ]; then
    ./port.sh && >>./shpid
fi
echo -e "………\033[36m 游戏核心 \033[0m………"
echo -e "\033[36m最新版本\t当前版本\033[0m\n$data1\t$data2"
echo -e "………\033[36m=============\033[0m………"
echo -e "………\033[36m 游戏插件 \033[0m………"
echo -e "\033[36m最新版本\t当前版本\033[0m\n$data3\t$data4"
if [[ $data1 == $data2 ]]; then
    echo -e "………\033[36m核心没有更新\033[0m………"
    if [[ $data3 == $data4 ]]; then
        echo -e "………\033[36m插件没有更新\033[0m………"
        java -jar server.jar
    else
        echo -e "………\033[36m更新配置文件中\033[0m………"
        echo -e "………\033[36m更新说明\033[0m………"
        curl https://api.github.com/repos/way-zer/ScriptAgent4MindustryExt/releases/latest 2>/dev/null | grep -E '"body": "' | sed 's/^.*"body": "//g' | sed 's/\\r\\n*/\n/g' | sed 's/".*$//g'
        echo -e "-----\033[36m插件官网\033[0m-----"
        sleep 5s
        echo -e "\033[36mhttps://github.com/way-zer/ScriptAgent4MindustryExt\033[0m"
        jar=$(curl https://api.github.com/repos/way-zer/ScriptAgent4MindustryExt/releases/latest 2>/dev/null | grep -E '"browser_download_url": ".*+jar"' | sed 's/^.*"browser_download_url": "//g' | sed 's/"//g')
        wget -O wayzer.jar $jar
        wget -O scripts.zip https://gh.api.99988866.xyz/https://github.com/way-zer/ScriptAgent4MindustryExt/releases/download/v${data3}/ScriptAgent4Mindustry-${data3}-scripts.zip
        echo -e "………\033[36m删除旧配置中\033[0m………"
        rm -f bb4
        rm -f config/mods/wayzer.jar
        mv bb3 bb4
        mv wayzer.jar config/mods/wayzer.jar
        mv config/scripts/data /be6/data
        rm -rf config/scripts/
        echo -e "………\033[36m解压配置文件中\033[0m………"
        unzip -o scripts.zip -d config/scripts/
        rm -f scripts.zip
        mv /be6/data/ config/scripts/data/
        java -jar server.jar
    fi
else
    echo -e "………\033[36m更新游戏核心中\033[0m………"
    echo -e "………\033[36m更新说明\033[0m………"
    curl https://api.github.com/repos/Anuken/Mindustry/releases/latest 2>/dev/null | grep -E '"body": "' | sed 's/^.*"body": "//g' | sed 's/".*$//g' | sed 's/\\n-/\n/g'
    sleep 5s
    rm -f bb2
    mv bb1 bb2
    rm -f server.jar
    wget -O server.jar https://gh.api.99988866.xyz/https://github.com/Anuken/Mindustry/releases/download/v${data1}/server-release.jar
    if [[ $data3 == $data4 ]]; then
        echo -e "………\033[36m插件没有更新\033[0m………"
        java -jar server.jar &
    else
        echo -e "………\033[36m更新配置文件中\033[0m………"
        echo -e "………\033[36m更新说明\033[0m………"
        curl https://api.github.com/repos/way-zer/ScriptAgent4MindustryExt/releases/latest 2>/dev/null | grep -E '"body": "' | sed 's/^.*"body": "//g' | sed 's/\\r\\n*/\n/g' | sed 's/".*$//g'
        echo -e "-----\033[36m插件官网\033[0m-----"
        sleep 5s
        echo -e "\033[36mhttps://github.com/way-zer/ScriptAgent4MindustryExt\033[0m"
        jar=$(curl https://api.github.com/repos/way-zer/ScriptAgent4MindustryExt/releases/latest 2>/dev/null | grep -E '"browser_download_url": ".*+jar"' | sed 's/^.*"browser_download_url": "//g' | sed 's/"//g')
        wget -O wayzer.jar $jar
        wget -O scripts.zip https://gh.api.99988866.xyz/https://github.com/way-zer/ScriptAgent4MindustryExt/releases/download/v${data3}/ScriptAgent4Mindustry-${data3}-scripts.zip
        echo -e "………\033[36m删除旧配置中\033[0m………"
        rm -f bb4
        rm -f config/mods/wayzer.jar
        mv bb3 bb4
        mv wayzer.jar config/mods/wayzer.jar
        mv config/scripts/data /be6/data
        rm -rf config/scripts/
        echo -e "………\033[36m解压配置文件中\033[0m………"
        unzip -o scripts.zip -d config/scripts/
        rm -f scripts.zip
        mv /be6/data/ config/scripts/data/
        java -jar server.jar
    fi
fi
