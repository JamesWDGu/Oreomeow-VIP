#!/usr/bin/env bash

<<'COMMENT'
cron: 32 6,18 * * *
new Env('自用更新');
COMMENT

## 导入通用变量与函数
dir_shell=/ql/shell
. $dir_shell/share.sh

file_db_env=/ql/db/env.db
file_raw_config=$dir_raw/config.sh
file_config_config=$dir_config/config.sh
file_raw_extra=$dir_raw/extra.sh
file_config_extra=$dir_config/extra.sh
file_raw_code=$dir_raw/code.sh
file_config_code=$dir_config/code.sh
file_raw_task_before=$dir_raw/task_before.sh
file_config_task_before=$dir_config/task_before.sh
file_config_notify_js=$dir_config/sendNotify.js

GithubProxyUrl=''
TG_BOT_TOKEN=''
TG_USER_ID=''
TG_PROXY_HOST=''
TG_PROXY_PORT=''
openCardBean=''
Recombin_CK_Mode='3'
Recombin_CK_ARG1='1'
Recombin_CK_ARG2='2'
Remove_Void_CK='1'

CollectedRepo='4'
OtherRepo='3 5 6 9 10'
Ninja='off'

repoNum='4'
HelpType='HelpType="0"'
BreakHelpType='BreakHelpType="1"'
BreakHelpNum='BreakHelpNum="31-1000"'
package_name='package_name="@types/node axios canvas crypto-js date-fns dotenv download form-data fs global-agent got jieba js-base64 jsdom json5 md5 png-js prettytable qrcode-terminal requests require tough-cookie tslib ts-md5 tunnel typescript ws"'
front_num='front_num="1"'

update_config() {
    curl -sfL https://git.io/config.sh -o $file_raw_config
    mv -b $file_raw_config $dir_config
    sed -ri "s/GithubProxyUrl=\"https\:\/\/ghproxy.com\/\"/GithubProxyUrl=\"${GithubProxyUrl}\"/g" $file_config_config
    sed -i "s/TG_BOT_TOKEN=\"\"/TG_BOT_TOKEN=\"${TG_BOT_TOKEN}\"/g" $file_config_config
    sed -i "s/TG_USER_ID=\"\"/TG_USER_ID=\"${TG_USER_ID}\"/g" $file_config_config
    sed -i "s/openCardBean=\"30\"/openCardBean=\"${openCardBean}\"/g" $file_config_config
    sed -i "s/Recombin_CK_Mode=\"\"/Recombin_CK_Mode=\"${Recombin_CK_Mode}\"/g" "$file_config_config"
    sed -i "s/Recombin_CK_ARG1=\"\"/Recombin_CK_ARG1=\"${Recombin_CK_ARG1}\"/g" "$file_config_config"
    sed -i "s/Recombin_CK_ARG2=\"\"/Recombin_CK_ARG2=\"${Recombin_CK_ARG2}\"/g" "$file_config_config"
    sed -i "s/Remove_Void_CK=\"\"/Remove_Void_CK=\"${Remove_Void_CK}\"/g" "$file_config_config"
}

update_extra() {
    curl -sfL https://git.io/extra.sh -o $file_raw_extra
    mv -b $file_raw_extra $dir_config
    sed -i "s/CollectedRepo=(4)/CollectedRepo=(${CollectedRepo})/g" $file_config_extra
    sed -i "s/OtherRepo=()/OtherRepo=(${OtherRepo})/g" $file_config_extra
    sed -i "s/Ninja=\"on\"/Ninja=\"${Ninja}\"/" $file_config_extra
    sed -i '/NOWTIME=/a\\tcp \/ql\/config\/sendNotify.js \/ql\/scripts\/sendNotify.js' $file_config_extra
    # echo 'cat /ql/db/wskey.list >> /ql/config/wskey.list && :> /ql/db/wskey.list' >> $file_config_extra
}

update_code() {
    curl -sfL https://git.io/code.sh -o $file_raw_code
    mv -b $file_raw_code $dir_config
    # sed -i "s/repo=\$repo4/repo=\$repo${repoNum}/g" $file_config_code
    sed -i "/^HelpType=/c${HelpType}" $file_config_code
    sed -i "/^BreakHelpType=/c${BreakHelpType}" $file_config_code
    sed -i "/^BreakHelpNum=/c${BreakHelpNum}" $file_config_code
    sed -i "/^package_name=/c${package_name}" "$file_config_code"
    sed -i "/^front_num=/c${front_num}" "$file_config_code"
}

update_task_before() {
    curl -sfL https://git.io/task_before.sh -o $file_raw_task_before
    mv -b $file_raw_task_before $dir_config
}

update_jdCookie() {
    curl -sfL https://raw.githubusercontent.com/Oreomeow/VIP/main/Scripts/sh/Helpcode2.8/jdCookie.js -o $dir_config/jdCookie.js
    mv -b $dir_config/jdCookie.js $dir_config
}

random_cookie() {
    c=1000000
    for r in {1..3}; do
        p=`expr $c - $r`
        sed -ri "s/\"position\"\:${p}/regular${r}/" $file_db_env
    done
    for line in {1..100}; do
        sed -ri "${line}s/(\"position\"\:)[^,]*/\"position\"\:${RANDOM}/" $file_db_env
    done
    for r in {1..3}; do
        p=`expr $c - $r`
        sed -ri "s/regular${r}/\"position\"\:${p}/" $file_db_env
    done
    ql check
}

update_notify() {
    wget -O sendNotify.js https://raw.githubusercontent.com/ccwav/QLScript2/main/sendNotify.js
    sed -ri 's/\\n\\n本通知 By ccwav Mod/\\n\\n本通知 By Oreo Mod/' "$file_config_notify_js"
}

update_config
update_extra
update_code
update_task_before
update_jdCookie

if [ $(date "+%H") -eq 18 ]; then
    random_cookie
fi

update_notify

case $@ in
    ck)
      random_cookie
      ;;
esac
echo "ql check" >> $file_config_extra

echo "
if [[ $(date "+%-H") -eq 0 || $(date "+%-H") -eq 8 || $(date "+%-H") -eq 16 ]] && [ $(date "+%-M") -eq 0 ] && [ $(date "+%-S") -gt 4 ]; then
  export JD_JOY_REWARD_NAME="20"
else
  export JD_JOY_REWARD_NAME="500"
fi
" >>$file_config_config
