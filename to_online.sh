#!/bin/bash

rsync_cmd="rsync -avz --delete --progress -c"
pass_file="/app/sdo/rsync/rsyncd.pass"
src_dir="/app/sdo/server_online"
aim="agent@$1::sdoserver/"

set -x
${rsync_cmd} --password-file="${pass_file}" --exclude-from=".exclude_bin.list"	$src_dir/bin	$aim || exit 1
${rsync_cmd} --password-file="${pass_file}" --exclude-from=".exclude_cfg.list"	$src_dir/config	$aim || exit 2
${rsync_cmd} --password-file="${pass_file}" $src_dir/zone	$aim	|| exit 4
${rsync_cmd} --password-file="${pass_file}" $src_dir/sql	$aim	|| exit 5
${rsync_cmd} --password-file="${pass_file}" $src_dir/update	$aim	|| exit 6
#${rsync_cmd} --password-file="${pass_file}" $src_dir/script	$aim	|| exit 3
