<%@ page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=GBK'>
<meta http-equiv='Cache-Control' content='no-store' />
<meta http-equiv='Pragma' content='no-cache' />
<meta http-equiv='Expires' content='0' />
<script src='/njs/extend/jquery/jquery123_pack.js' type=text/javascript></script>
<link href='./show_menu.css' rel='stylesheet' type='text/css' />
</head><body>
<div id=Operation_Table><div class=bar><div class=title>业务咨询</div></div>
<div class=tree id=002001 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >基础通信</div>
<div class=tree id=002002 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >信息服务</div>
<div class=tree id=002003 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >服务类</div>
<div class=tree id=002004 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >营销、资费类</div>
<div class=tree id=002005 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >集团客户类</div>
<div class=tree id=002006 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >其他</div>
<div class=tree id=002007 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >骚扰咨询</div>
<div class=tree id=002008 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >突发故障</div>
<div class=tree id=002009 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >短信群发</div>
<div class=tree id=002010 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >升级割接</div>
<div class=tree id=002011 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >外省、无声、骚扰客户</div>
<div class=tree id=002012 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >3G相关业务</div>
<div class=tree id=002013 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >试机、回拨、贵宾厅验卡、发测试信息</div>
<div class=tree id=002014 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >客户投诉/催单/撤诉/建议</div>
<div class=tree id=002015 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >拨测及测试</div>
<div class=tree id=002016 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >外呼内容相关咨询</div>
<div class=tree id=002017 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >夜间服务模式相关咨询</div>
</div>
<div id=Operation_Table><div class=bar><div class=title>业务查询</div></div>
<div class=tree id=003001 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >话费缴费信息类</div>
<div class=tree id=003002 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >服务、业务类</div>
<div class=tree id=003003 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >其它</div>
<div class=tree id=003006 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >自有业务</div>
<div class=tree id=003007 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >客户相关信息查询</div>
<div class=tree id=003008 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >为客户提供的增值服务</div>
</div>
<div id=Operation_Table><div class=bar><div class=title>业务办理</div></div>
<div class=tree id=004001 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >信息服务类</div>
<div class=tree id=004002 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >基础服务类</div>
<div class=tree id=004003 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >VIP服务</div>
<div class=tree id=004004 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >特色服务</div>
<div class=tree id=004005 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >其他服务</div>
</div>
<div id=Operation_Table><div class=bar><div class=title>网站投诉</div></div>
</div>
<div id=Operation_Table><div class=bar><div class=title>投诉申告</div></div>
<div class=tree id=009001 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >基础通信</div>
<div class=tree id=009002 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >信息安全</div>
<div class=tree id=009003 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >业务响应</div>
<div class=tree id=009004 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >通信费用</div>
<div class=tree id=009005 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >梦网业务</div>
<div class=tree id=009006 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >自有业务</div>
<div class=tree id=009007 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >市场营销</div>
<div class=tree id=009008 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >服务质量</div>
<div class=tree id=009009 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >集团业务</div>
<div class=tree id=009010 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >12580服务</div>
<div class=tree id=009011 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >业务办理及查询</div>
</div>
<div id=Operation_Table><div class=bar><div class=title>用户建议</div></div>
<div class=tree id=050001 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >(01)资费类</div>
<div class=tree id=050002 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >(02)服务类</div>
<div class=tree id=050003 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >(03)网络类</div>
<div class=tree id=050004 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >(04)业务类</div>
<div class=tree id=050005 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >(05)其它建议</div>
<div class=tree id=050006 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >(06)自动台建议</div>
<div class=tree id=050099 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >(07)未定建议</div>
<div class=tree id=050100 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >积分商城礼品配送</div>
</div>
<div id=Operation_Table><div class=bar><div class=title>部门业务单</div></div>
<div class=tree id=052001 style='display: none' onclick='getdetail(this);' onmouseover='changecolor(this);' onmouseout='changecolor(this);' >部门业务单</div>
</div>
<script src='./show_menu.js' type=text/javascript></script>
</body>
</html>