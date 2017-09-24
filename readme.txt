a nginx-lua-thumbnail-sample



1.支持2种格式的url name_widexhigh.imgtype  or  name.imgtype_widexhigh
2.可设置合法尺寸
3.本地不保存缩略图(看到网上很多利用nginx+lua做的缩略图都是基于本地保存)



require
magick,lfs


适用环境
browser <----> cache <-----> nginx

----------------nginx conf example------------------
    location ~ (.jpg|.png|.gif) {
        root /home/webuser/www/views/static;
	access_by_lua_file  /home/webuser/www/module/resizeimg.lua;
	expires 30d;
        }
  


