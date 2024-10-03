ZSH_BWS_DELIMITER='\t'

function _bw_ensure_token() {
    if [ -z $BWS_ACCESS_TOKEN ]; then >&2 echo "BWS_ACCESS_TOKEN is not set - aborting" && return 1; else return 0; fi
}

function _bws_select() {
    jq -r ".[] | [.key, .id] | join(\"$ZSH_BWS_DELIMITER\")" <(bws secret list 2>&/dev/null) | fzf -0 --with-nth 1 -d "$ZSH_BWS_DELIMITER" | awk -F "$ZSH_BWS_DELIMITER" '{print $2}'
}

function _bws_id() {
    jq -r ".[] | select(.key == \"$1\") | .id" <(bws secret list 2>&/dev/null)
}


function bws_get_full() {
    local arg_key arg_id arg_format

    zparseopts -D -F -K -- \
      k:=arg_key \
      i:=arg_id \
      o:=arg_format ||
    return 1
    _bw_ensure_token
	if [[ "$?" == "1" ]]; then
		return 1
	fi
    local secret_id


    if [[ ! -z "$arg_key" && ! -z "$arg_id" ]]; then
        >&2 echo "Specify only one of -i or -k"
        return 1
    elif [[ -z "$arg_key" && -z "$arg_id" ]]; then
        secret_id=$(_bws_select)
    elif [[ ! -z "$arg_id" ]]; then
        secret_id=${arg_id[-1]}
    elif [[ ! -z "$arg_key" ]]; then
        secret_id=$(_bws_id ${arg_key[-1]})
    fi
    local out_format=${arg_format[-1]:-json}
    bws secret get -o $out_format $secret_id
}

function bws_get() {
    local arg_key arg_id
    zparseopts -D -F -K -- \
      k:=arg_key \
      i:=arg_id ||
    return 1
    jq -c '.value' -r <(bws_get_full $arg_id $arg_key -o json)
}

function bws_copy() {
    local arg_key arg_id
    local copy_cmd="${ZSH_BWS_COPY_CMD:-clipcopy}"
    zparseopts -D -F -K -- \
      k:=arg_key \
      i:=arg_id ||
    return 1
    jq -c '.value' -r <(bws_get_full $arg_id $arg_key -o json) | eval "$copy_cmd"
}

alias bwsc='bws_copy'
alias bwsg='bws_get'
alias bwsgf='bws_get_full'
alias bwsl='bws secret list'