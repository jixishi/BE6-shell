#!/bin/bash
echo -e "欢迎使用\033[36mBE6\033[0m自动化环境安装脚本"
echo -e "QQ群\033[36m780806682\033[0m"
echo -e "第二次启动代码"
echo -e "\033[4;36mcd xs && sh start.sh\033[0m"
systemctl stop firewalld.service
echo -e "\033[31m端口以放通\033[0m"
sleep 5s

echo -e "…\033[36m正在安装Java环境\033[0m…"

yum -y install java-1.8.0-openjdk*

echo -e "…\033[36m安装压缩包管理工具\033[0m…"

yum install -y unzip zip

echo -e "………\033[36m1.进程名 小白单服 大佬开环境隔离\033[0m………"
echo -e "………\033[36m2.端口号 小白多服 手动输入端口号\033[0m………"
read -p "请输入需要的模式: " mode
case $mode in
"1")
    echo -e "欢迎使用\033[36mBE6\033[0m自动化开服脚本"
    echo -e "………\033[36m更新配置文件中\033[0m………"
    wget http://be6.top/xsgc/name.sh
    chmod +x name.sh
    ./name.sh && >>./shpid
    ;;
"2")
    echo -e "欢迎使用\033[36mBE6\033[0m自动化开服脚本"
    echo -e "………\033[36m更新配置文件中\033[0m………"
    read -p "请输入端口号: " port
    echo -e "………\033[36m端口号：$port\033[0m………"
    read -p "二次确认: " port0
    if [[ $port == $port0 ]]; then
        $port >>port
        wget http://be6.top/xsgc/port.sh
        chmod +x port.sh
        ./port.sh && >>./shpid
    else
        echo -e "………\033[36m端口号不同\033[0m………"
        read -p "请输入端口号: " port
        echo -e "………\033[36m端口号：$port\033[0m………"
        read -p "二次确认: " port0
        $port >>port
        wget http://be6.top/xsgc/port.sh
        chmod +x port.sh
        ./port.sh && >>./shpid
    fi
    ;;
esac
wget http://be6.top/xsgc/start.sh
chmod +x start.sh
curl https://github.com/Anuken/Mindustry 2>/dev/null | grep -E 'href="/Anuken/Mindustry/releases/tag/v[0-9]*' | sed 's/^.*\/tag\/v//g' | sed 's/\.[0-9]">.*$//g' | sed 's/">.*$//g' >>./bb1
echo -e "………\033[36m 游戏版本获取成功 \033[0m………"
curl https://github.com/way-zer/ScriptAgent4MindustryExt 2>/dev/null | grep -E '/way-zer/ScriptAgent4MindustryExt/releases/tag/v[0-9]*' | sed 's/^.*\/tag\/v//g' | sed 's/">.*$//g' >>./bb3
echo -e "………\033[36m 插件版本获取成功 \033[0m………"
data1=$(cat bb1)
data3=$(cat bb3)
curl http://www.iyuji.cn/iyuji/s/Zk9HWjhRNk5tWmVYTklQS2FRRmxxUT09/1612931423341522 2>/dev/null | grep -E '<div>【wlgg】' | sed 's/<div>【wlgg】/【网络公告】/g' | sed 's/{wlgg}<\/div>/\n/g' | sed 's/^.*【wlggt】/【网络公告】/g' | sed 's/{wlggw}.*$//g'
echo -e "………\033[36m下载游戏核心中\033[0m………"
wget -O server.jar https://gh.api.99988866.xyz/https://github.com/Anuken/Mindustry/releases/download/v${data1}/server-release.jar
mv bb1 bb2
echo -e "………\033[36m下载配置文件中\033[0m………"
echo -e "-----\033[36m插件官网\033[0m-----"
echo -e "\033[36mhttps://github.com/way-zer/ScriptAgent4MindustryExt\033[0m"
wget -O config.zip http://be6.top/xsgc/config.zip -q
wget -O scripts.zip https://gh.api.99988866.xyz/https://github.com/way-zer/ScriptAgent4MindustryExt/releases/download/v${data3}/ScriptAgent4Mindustry-${data3}-scripts.zip
echo -e "………\033[36m解压配置文件中\033[0m………"
jar=$(curl https://api.github.com/repos/way-zer/ScriptAgent4MindustryExt/releases/latest 2>/dev/null | grep -E '"browser_download_url": ".*+jar"' | sed 's/^.*"browser_download_url": "//g' | sed 's/"//g')
wget -O wayzer.jar $jar
rm -f config/mods/wayzer.jar
mv wayzer.jar config/mods/wayzer.jar
unzip config.zip
rm -f config.zip
echo -e "………\033[36ms删除旧配置中\033[0m………"
mv bb3 bb4
rm -rf config/scripts/
echo -e "………\033[36m解压脚本文件中\033[0m………"
unzip -o scripts.zip -d config/scripts/
rm -f scripts.zip
echo -e "………\033[36m启动服务器\033[0m………"
java -jar server.jar
