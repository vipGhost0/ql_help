dir_code=$dir_log/code

default_env_name=(
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
default_var_name=(
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
import_help_config () {
    [ ! -n "$env_name" ] && env_name=($(echo ${default_env_name[*]}))
    [ ! -n "$var_name" ] && var_name=($(echo ${default_var_name[*]}))
}

gen_pt_pin_array() {
    local envs=$(eval echo "\$JD_COOKIE")
    local array=($(echo $envs | sed 's/&/ /g'))
    local user_sum=${#array[*]}
    local block_arr=${BlockPtPin:-""}
    local tmp1 i pt_pin_temp
    for ((i = 0; i < $user_sum; i++)); do        
        pt_pin_temp=$(echo ${array[i]} | perl -pe "{s|.*pt_pin=([^; ]+)(?=;?).*|\1|; s|%|\\\x|g}")
        [[ $block_arr =~ $pt_pin_temp ]] && block_pin[i]=true || block_pin[i]=false
        [[ $pt_pin_temp == *\\x* ]] && pt_pin[i]=$(printf $pt_pin_temp) || pt_pin[i]=$pt_pin_temp        
    done
}

combine_sub() {
    local what_combine=$1
    local combined_all=""
    local tmp1 tmp2
    for ((i = 1; i <= ${#pt_pin[*]}; i++)); do
        j=$(($i - 1))
        if [[ ${block_pin[j]} == true ]]; then
            continue 1
        fi
        local tmp1=$what_combine$i
        local tmp2=${!tmp1}
        combined_all="$combined_all&$tmp2"
    done
    echo $combined_all | perl -pe "{s|^&||; s|^@+||; s|&@|&|g; s|@+&|&|g; s|@+|@|g; s|@+$||}"
}

## 正常依次运行时，组合所有账号的Cookie与互助码
combine_all() {       
    echo "组合所有账号的Cookie与互助码,共"${#env_name[*]}"个"
    for ((i = 0; i < ${#env_name[*]}; i++)); do
        result=$(combine_sub ${var_name[i]})
        if [[ $result ]]; then
            export ${env_name[i]}="$result"
        fi
    done
}

if [[ $p1 == *.js ]]; then
     if [[ $AutoHelpOther == true ]] && [[ $(ls $dir_code) ]]; then
        echo "导入code生成的互助码"
        local latest_log=$(ls -r $dir_code | head -1)
        . $dir_code/$latest_log
    fi       
fi
import_help_config
gen_pt_pin_array
combine_all