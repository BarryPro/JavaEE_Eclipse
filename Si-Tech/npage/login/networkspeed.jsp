<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<html>
<head>
<title>黑龙江CRM系统营业受理速度测试</title>
<meta http-equiv=Content-Language content=zh-cn>
<meta http-equiv=Content-Type content="text/html;charset=GBK">
<meta content="MSHTML 6.00.2800.1106" name=GENERATOR>
<meta content=FrontPage.Editor.Document name=ProgId>
</head>
<body style="background:#FFFFFF;">
 
<div style="position:relative;height:100px;background-image:none;">
<img style="position:absolute;top:0%;left:5px;" src="/nresources/default/images/net.jpg" />
<div align="right">
	<input type="button" class="b_text" id="saveMsgBtn" value="保存信息" onclick="saveMsg()" >
</div>
<span style=display:block;color:purple;position:absolute;top:100%;font-size:16px;left:5px;line-height:20px>网络传输性能信息：
<%
		out.println("<script language='JavaScript'>");
		out.println("var tClientStart=new Date();");
		out.println("document.write('<span style=display:block;absolute;font-size:14px;left:5px;line-height:20px>本机接收静态页面开始时间：'+tClientStart+'</span>');");
		out.println("</script>\n");
    Date tServerStart=new Date();
		out.println("<!--\n");
		for(int i=0;i<512;i++)
		{
			out.print("********************************************************************************************************************************");
			
		}
    out.println("-->\n");
		out.println("<script language='JavaScript'>var tClientEnd=new Date();</script>\n");
		out.println("<script language='JavaScript'>");

		out.println("document.write('<span style=display:block;absolute;font-size:14px;left:5px;line-height:20px>本机接收静态页面结束时间：'+tClientEnd+'</span>');");

		out.println("var iClientTime=0;iClientTime=(tClientEnd - tClientStart) / 1000;");

		out.println("if(iClientTime>0) iShowKbps=Math.round(Math.round(64 / iClientTime));else iShowKbps=0 ;");

		out.println("if(iShowKbps>=128) iShowNote='极好';else if(iShowKbps>=32 && iShowKbps<128) iShowNote='一般';else if(iShowKbps>=16 && iShowKbps<32) iShowNote='较差';else if(iShowKbps>=4 && iShowKbps<16) iShowNote='极差';else if(iShowKbps>=0 && iShowKbps<4) iShowNote='不可用';");
		out.println("document.write('<span style=display:block;absolute;font-size:16px;font-weight:bold;left:5px;line-height:20px>传输数据总量：<span style=color:red;>64KB</span>，耗时：<span style=color:red;>'+iClientTime+'秒</span>，连接速度：<span style=color:red;>'+Math.round(iShowKbps) + 'KB/s</span>，网络质量：<span style=color:red;>'+iShowNote+'</span></span>');");
		out.println("var netQuality = iShowNote;");
		
		out.println("</script>\n");
%>
</span>
<span style=display:block;color:green;position:absolute;top:300%;font-size:16px;left:5px;line-height:20px>PC机展示界面性能测试(无需查看)...... 
<%
		out.println("<script language='JavaScript'>");
		out.println("var tShowStart=new Date();")	;
    out.println("var iShowString='****************************************************************';");
    for(int i=0;i<1024;i++)
		{
		out.println("document.write('<span style=display:block;absolute;top:250%;font-size:16px;left:5px;line-height:20px>'+iShowString+'</span>');");
		}
		out.println("</script>\n");
%>
</span>
<span style=display:block;color:blue;position:absolute;top:200%;font-size:16px;left:5px;line-height:20px>PC机展示界面性能信息：
<%
		out.println("<script language='JavaScript'>");
		out.println("var tShowEnd=new Date();")	;
		out.println("var iShowTime=0;iShowTime=(tShowEnd - tShowStart) / 1000;");
		out.println("document.write('<span style=display:block;absolute;font-size:14px;left:5px;line-height:20px>本机执行静态页面程序开始时间：'+tShowStart+'</span>');");
		out.println("document.write('<span style=display:block;absolute;font-size:14px;left:5px;line-height:20px>本机执行静态页面程序结束时间：'+tShowEnd+'</span>');");
		out.println("if(iShowTime<0.5) iShowNote='好';else if(iShowTime>=0.5 && iShowTime<1) iShowNote='一般';else if(iShowTime>=1) iShowNote='差';");
		out.println("var pcQuality = iShowNote;");

		out.println("document.write('<span style=display:block;absolute;font-size:16px;font-weight:bold;left:5px;line-height:20px>本机执行静态页面程序消耗时间：'+iShowTime+'秒，您的PC机操作终端的性能：<span style=color:red;>'+iShowNote+'</span></span>');");

		out.println("</script>\n");
%>
</span>
<span style=display:block;color:maroon;position:absolute;top:70%;font-size:16px;font-weight:bold;left:5px;line-height:20px>省中心服务器性能信息：
<%
		Date tServerEnd=new Date();
		long iServerTime=tServerEnd.getTime() - tServerStart.getTime();
		out.println("生成页面耗时："+iServerTime+"毫秒");
%>
</span>

<span>
	<script language='JavaScript'>
		//核心对象变量
		var xmlHttp;
		
		//区分浏览器创建XMLHttpRequest核心对象
		function create(){
			if(window.XMLHttpRequset){
				xmlHttp = new XMLHttpRequest();
			}else if(window.ActiveXObject){
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		
		//ajax核心执行方法（此处为提交到servlet处理后,返回纯文本）
		function saveMsg(){
			create();
			var totalMillisecond = "<%=iServerTime%>";
			var acceptPageStartDate = tClientStart.toLocaleString().replace("年", "-").replace("月", "-").replace("日", "");
			var acceptPageEndDate = tClientEnd.toLocaleString().replace("年", "-").replace("月", "-").replace("日", "");
			var transferData = "64";
			var transferMilliSecond = iClientTime;
			var transferSpeed = Math.round(iShowKbps);
			//var netQuality = netQuality;
			var exePageStartDate = tShowStart.toLocaleString().replace("年", "-").replace("月", "-").replace("日", "");
			var exePageEndDate = tShowStart.toLocaleString().replace("年", "-").replace("月", "-").replace("日", "");
			var exePageMilliSecond = iShowTime;
			//var pcQuality = pcQuality;
			
			var pageUrl = "ajaxSaveUserMsg.jsp?totalMillisecond="+totalMillisecond+"&acceptPageStartDate="+acceptPageStartDate
				 + "&acceptPageEndDate="+acceptPageEndDate+"&transferData="+transferData+"&transferMilliSecond="+transferMilliSecond
				 + "&transferSpeed="+transferSpeed+"&netQuality="+netQuality+"&exePageStartDate="+exePageStartDate
				 + "&exePageEndDate="+exePageEndDate+"&exePageMilliSecond="+exePageMilliSecond+"&pcQuality="+pcQuality;
			xmlHttp.open("GET", pageUrl, true);
			xmlHttp.onreadystatechange=callback;
			xmlHttp.send(null);
		}
		
		//回调函数
		function callback(){
			if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var v = xmlHttp.responseText;
					if (v.indexOf("000000")) {
						alert("保存成功！");
						document.getElementById("saveMsgBtn").disabled = true;
					} 
				}
			}
		}
	</script>
</span>
</div>
</body>
</html>
