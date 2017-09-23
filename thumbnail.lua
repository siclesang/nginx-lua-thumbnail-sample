--支持2种格式的url name_widexhigh.imgtype  or  name.imgtype_widexhigh

local allowsize=[[
30x30,
60x60,
100x100,
]]
local magick = require "magick"
local uri=ngx.var.uri
local document_root=ngx.var.document_root
local w,h=string.match(uri,"_(%d+)[x|X](%d+)")
if w==nil  or h==nil then
	return
else
	w=tonumber(w)
	h=tonumber(h)
	if string.match(allowsize,w.."[x|X]"..h..",") == nil then
		ngx.exit(403)
	end
	
	local imgtype=string.match(uri,"%.(%w+)_%d+[x|X]%d+")
	if imgtype then
		ngx.header.Content_Type="image/"..imgtype
	end
	uri=string.gsub(uri,"_%d+[x|X]%d+","")
end

local imgfile=document_root..uri

--local imgtype=string.match(imgfile,"%.(%w+)")
--ngx.header.Content_Type="image/"..imgtype


local lfs=require "lfs"
if lfs.attributes(imgfile,"mode") == "file" then
	local img = assert(magick.load_image(imgfile))
	--img:adaptive_resize(w,h)
	img:resize(w,h)
	local resizeImg=img:get_blob()
	img:destroy()
	ngx.say(resizeImg)
	--img:write("resized.png")
else
	ngx.exit(404)
end
