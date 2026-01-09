SKIPUNZIP=0

if [ -z "$(find '/data/adb' -mindepth 2 -maxdepth 2 -type f -name 'package_config' 2>/dev/null)" ]; then
  abort "未检测到配置，安装退出！"
fi

ui_print "说明："
ui_print "① 模块只是自动对第三方应用开启“排除修改”，不提供额外隐藏功能！"
ui_print "② 只要安装完成就会对所有第三方应用开启“排除修改”，包括系统多开空间内第三方应用，"
ui_print "③ 新安装应用自动排除功能需要在模块安装完成后重启一次手机(或平板)才生效。"
ui_print "④ 如果还安装了TrickyStore模块，也会顺便添加TrickyStore列表"
ui_print ""

chmod 0755 "$MODPATH/weix"
chmod 0755 "$MODPATH/boot-completed.sh"

manager="$(echo "$ZIPFILE" | awk -F '/' '{print $5}')"
if [ "$(pm list packages "$manager" 2>/dev/null | wc -l)" -eq 1 ]; then
  sed -i "10 a\\manager='$manager'" "$MODPATH/boot-completed.sh"
fi

"$MODPATH/boot-completed.sh" i

ui_print "模块安装完成！"
ui_print ""
ui_print ""
