<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType= "text/html;charset=GBK" %>
<html>
<head>
<title>在线速度测试</title>
<meta http-equiv=Content-Language content=zh-cn>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<meta content="MSHTML 6.00.2800.1106" name=GENERATOR>
<meta content=FrontPage.Editor.Document name=ProgId>
</head>
<body style="background:#FFFFFF;">
 
<div style="position:relative;height:100px;background-image:none;">	
	
	<img style="position:absolute;top:40%;left:120px;" src="/nresources/default/images/net.jpg" />

<%

		out.println("<script language='JavaScript'>var tSpeedStart=new Date();</script>")	;
		out.println("<!--\n");
		for(int i=0;i<1000;i++)
		{
			out.println("####################################################################################################");
		}
		out.println("-->\n");
		out.println("<script language='JavaScript'>var tSpeedEnd=new Date();</script>\n");
		out.println("<script language='JavaScript'>");
		out.println("var iSpeedTime=0;iSpeedTime=(tSpeedEnd - tSpeedStart) / 1000;");
		out.println("if(iSpeedTime>0) iKbps=Math.round(Math.round(100 * 8 / iSpeedTime * 10.5) / 10); else iKbps=10000 ;");
		out.println("</script>\n");				
		out.println("<script language='JavaScript'>");
		out.println("document.write('<span style=display:block;position:absolute;top:40%;font-size:14px;font-weight:bold;left:200px;color:#000;line-height:100px>当前连接速度:<span style=color:red;>'+Math.round(iKbps/8*10)/10+ ' KB/s</span></span>');");  
		out.println("</script>\n") ;
%>
	
</div>	


</body>
</html>
