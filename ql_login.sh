check() {
    local currentTimeStamp=$(date +%s)
    local api=$(
        curl -s --noproxy "*" "http://0.0.0.0:5600/api/user?t=$currentTimeStamp" \
            -H 'Accept: */*' \
            -H "Authorization: Bearer $1" \
            -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36' \
            -H 'Referer: http://0.0.0.0:5700/crontab' \
            -H 'Accept-Language: en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7' \
            --compressed
    )
    code=$(echo $api | jq -r .code)
    if [[ $code != 200 ]]; then
        return 0
    else
        return 1
    fi    
}
login(){
    local currentTimeStamp=$(date +%s)
    local api=$(
        curl -s --noproxy "*" "http://127.0.0.1:5700/api/login?t=$currentTimeStamp" -H 'Accept: application/json' -H 'Content-Type: application/json;charset=UTF-8' --data-raw "{\"username\":\"$1\",\"password\":\"$2\"}" --compressed
    )
    code=$(echo $api | jq -r .code)
    if [[ $code != 200 ]]; then
        echo "登录失败"
    else
        echo "登录成功"
    fi
}
ql_login(){
    if [ ! -f "/ql/data/config/auth.json" ]; then
        echo "新版青龙"
        local token=$(cat /ql/data/config/auth.json | jq --raw-output .token)
        local username=$(cat /ql/data/config/auth.json | jq --raw-output .username)
        local password=$(cat /ql/data/config/auth.json | jq --raw-output .password) 
    else
        echo "旧版青龙"
        local token=$(cat /ql/config/auth.json | jq --raw-output .token)
        local username=$(cat /ql/config/auth.json | jq --raw-output .username)
        local password=$(cat /ql/config/auth.json | jq --raw-output .password)    
    fi
    
    if check $token; then
        echo "未登录"
        login $username $password
    else
        echo "已登录"
    fi    
}
ql_login