<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>

<html>
<head>
<title>�ٶȲ���</title>
<meta http-equiv=Content-Language content=zh-cn>
<meta http-equiv=Content-Type content="text/html;charset=GBK">
<meta content="MSHTML 6.00.2800.1106" name=GENERATOR>
<meta content=FrontPage.Editor.Document name=ProgId>
</head>
<body style="background:#FFFFFF;">
 
<div style="position:relative;height:100px;background-image:none;">	
<span style=color:blue;>
<%
		out.println("<script language='JavaScript'>");
		out.println("var tClientStart=new Date();")	;
		out.println("document.write('<span style=display:block;position:absolute;top:5%;font-size:16px;left:5px;line-height:20px>�������վ�̬ҳ�濪ʼʱ�䣺'+tClientStart+'</span>');");
		out.println("</script>\n");
    Date tServerStart=new Date();
		out.println("<!--\n");
		for(int i=0;i<512;i++)
		{
			out.print("********************************************************************************************************************************");
			
		}
    out.println("-->\n");
		Date tServerEnd=new Date();
		long iServerTime=tServerEnd.getTime() - tServerStart.getTime();
		out.println("<script language='JavaScript'>var tClientEnd=new Date();</script>\n");
		out.println("<script language='JavaScript'>");

		out.println("document.write('<span style=display:block;position:absolute;top:25%;font-size:16px;left:5px;line-height:20px>�������վ�̬ҳ�����ʱ�䣺'+tClientEnd+'</span>');");

		out.println("var iClientTime=0;iClientTime=(tClientEnd - tClientStart) / 1000;");

		out.println("if(iClientTime>0) iShowKbps=Math.round(Math.round(64 / iClientTime));else iShowKbps=0 ;");

		out.println("</script>\n");
		out.println("<script language='JavaScript'>");
		out.println("if(iShowKbps>=128) iShowNote='����';else if(iShowKbps>=32 && iShowKbps<128) iShowNote='һ��';else if(iShowKbps>=16 && iShowKbps<32) iShowNote='�ϲ�';else if(iShowKbps>=4 && iShowKbps<16) iShowNote='����';else if(iShowKbps>=0 && iShowKbps<4) iShowNote='������';");
		out.println("document.write('<span style=display:block;position:absolute;top:45%;font-size:16px;font-weight:bold;left:5px;line-height:20px>��������������<span style=color:red;>64KB</span>����ʱ��<span style=color:red;>'+iClientTime+'��</span>�����������ٶȣ�<span style=color:red;>'+Math.round(iShowKbps) + 'KB/s</span>����������������<span style=color:red;>'+iShowNote+'</span></span>');");
		
		out.println("</script>\n");
%>
<span style=color:black;display:block;position:absolute;top:85%;font-size:16px;left:5px;line-height:20px>���������ɾ�̬ҳ��ʱ����<span style=color:red><%=iServerTime%></span>����
<%
out.println("<script language='JavaScript'>");
out.println("var iShowString='';");
for(int i=0;i<512;i++)
		{
		  out.println("iShowString+='********************************************************************************************************************************'");
		}
		
		
		out.println("var tShowStart=new Date();")	;
		out.println("document.write(iShowString);");
		out.println("var tShowEnd=new Date();")	;
		out.println("var iShowTime=0;iShowTime=(tShowEnd - tShowStart) / 1000;");
		out.println("document.write('<span style=display:block;absolute;top:85%;font-size:16px;left:5px;line-height:20px>����չʾ��̬ҳ�濪ʼʱ�䣺'+tShowStart+'</span>');");
		out.println("document.write('<span style=display:block;absolute;top:105%;font-size:16px;left:5px;line-height:20px>����չʾ��̬ҳ�����ʱ�䣺'+tShowEnd+'</span>');");
		out.println("document.write('<span style=display:block;absolute;top:125%;font-size:16px;left:5px;line-height:20px>����չʾ��̬ҳ������ʱ�䣺'+iShowTime+'��</span>');");

		out.println("</script>\n");
%>
</span>
</div>
</body>
</html>
