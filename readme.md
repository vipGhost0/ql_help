# 说明
青龙2.8.0更新后功能添加：  
1、tempBlockCookie功能  
2、内部互助功能
### 注意：
并发不调用task_before ，故并发暂时没有办法调用助力
环境变量的jd cookie 名称分命名为JD_COOKIE
原定时互助码 ql code 更改为bash /ql/repo/vipGhost0_ql_help/code.sh
#### task_before.sh
文件名精简为简称，用来作用TempBlockCookie参数

```
if [[ $1 =~ \. ]]; then
	echo 文件简称为：$(echo ${1%%.*}|sed -r "s/.*(j[d|x]_.*)/\1/g")（作用为屏蔽某个ck）
fi
case $(echo ${1%%.*}|sed -r "s/.*(j[d|x]_.*)/\1/g") in
    jd_pigPet | jd_daily_egg | jd_dreamFactory  )
     TempBlockCookie="2 4 5"      # 账号5不玩东东农场
     ;;
   jd_jdfactory | jd_jxnc | jd_jxmc | jd_car_exchange | jd_jin_tie | jd_cfd  )
     TempBlockCookie="1 2 3 4 5"      # 账号2不玩京喜工厂和东东工厂
     ;;
   jd_health | jd_health_collect | jd_jump | jd_mcxhd )
    TempBlockCookie="5"    # 新号火爆
     ;;
   jd_bean_home | jd_bean_sign | jd_blueCoin | jd_car | jd_cash | jd_club_lottery | jd_jdzz | jd_lotteryMachine | jd_redPacket | jd_superMarket | jd_beauty | jd_family | jd_sgmh | jd_speed_redpocke | jd_speed_sign | jd_syj | jd_carnivalcity | jd_xtg | jd_xtg_help | jd_gold_creator | jd_mohe )
    TempBlockCookie="2 5"    # 火爆
     ;;
   jd_getFollowGift | jd_EsportsManager)
    TempBlockCookie="2 5"    # 火爆
     ;;
   jd_ms )
    TempBlockCookie="2 3 4 5" #  金融限定
     ;; 
 esac
##调用助力
. /ql/repo/vipGhost0_ql_help/help.sh
```

#### 使用环境变量
使用原config.sh的参数,互助设置已添加为内置参数，可不添加  
添加 name_js_prefix参数批量前缀  
库为JDHelloWorld可设置为JDHelloWorld_jd_scripts_  
库为chinnkarahoi可设置为chinnkarahoi_jd_scripts_
```

## 自动按顺序进行账号间互助（选填） 设置为 true 时，将直接导入code最新日志来进行互助
AutoHelpOther="true"

## 定义 jcode 脚本导出的互助码模板样式（选填）
## 不填 使用“按编号顺序助力模板”，Cookie编号在前的优先助力
## 填 0 使用“全部一致助力模板”，所有账户要助力的码全部一致
## 填 1 使用“均等机会助力模板”，所有账户获得助力次数一致
## 填 2 使用“随机顺序助力模板”，本套脚本内账号间随机顺序助力，每次生成的顺序都不一致。
HelpType=""

##name_js_prefix 批量前缀，可设置为JDHelloWorld_jd_scripts_
name_js_prefix="JDHelloWorld_jd_scripts_"

```
以下为互助设置，已添加为内置参数，可不添加
```
## 需组合的环境变量列表，env_name需要和var_name一一对应，如何有新活动按照格式添加(不懂勿动)
env_name=(
  FRUITSHARECODES
  PETSHARECODES
  PLANT_BEAN_SHARECODES
  DREAM_FACTORY_SHARE_CODES
  DDFACTORY_SHARECODES
  JDZZ_SHARECODES
  JDJOY_SHARECODES
  JXNC_SHARECODES
  BOOKSHOP_SHARECODES
  JD_CASH_SHARECODES
  JDSGMH_SHARECODES
  JDCFD_SHARECODES
  JDHEALTH_SHARECODES
)
var_name=(
  ForOtherFruit
  ForOtherPet
  ForOtherBean
  ForOtherDreamFactory
  ForOtherJdFactory
  ForOtherJdzz
  ForOtherJoy
  ForOtherJxnc
  ForOtherBookShop
  ForOtherCash
  ForOtherSgmh
  ForOtherCfd
  ForOtherHealth
)

## name_js为脚本文件名，如果使用ql repo命令拉取，文件名含有作者名
## 所有有互助码的活动，把脚本名称列在 name_js 中，对应 config.sh 中互助码后缀列在 name_config 中，中文名称列在 name_chinese 中。
## name_js、name_config 和 name_chinese 中的三个名称必须一一对应。

name_js=(
  jd_fruit
  jd_pet
  jd_plantBean
  jd_dreamFactory
  jd_jdfactory
  jd_jdzz
  jd_crazy_joy
  jd_jxnc
  jd_bookshop
  jd_cash
  jd_sgmh
  jd_cfd
  jd_health
)
name_config=(
  Fruit
  Pet
  Bean
  DreamFactory
  JdFactory
  Jdzz
  Joy
  Jxnc
  BookShop
  Cash
  Sgmh
  Cfd
  Health
)
name_chinese=(
  东东农场
  东东萌宠
  京东种豆得豆
  京喜工厂
  东东工厂
  京东赚赚
  crazyJoy任务
  京喜农场
  口袋书店
  签到领现金
  闪购盲盒
  京喜财富岛
  东东健康社区
)
```
