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
<title>������CRMϵͳӪҵ�����ٶȲ���</title>
<meta http-equiv=Content-Language content=zh-cn>
<meta http-equiv=Content-Type content="text/html;charset=GBK">
<meta content="MSHTML 6.00.2800.1106" name=GENERATOR>
<meta content=FrontPage.Editor.Document name=ProgId>
</head>
<body style="background:#FFFFFF;">
 
<div style="position:relative;height:100px;background-image:none;">
<img style="position:absolute;top:0%;left:5px;" src="/nresources/default/images/net.jpg" />
<div align="right">
	<input type="button" class="b_text" id="saveMsgBtn" value="������Ϣ" onclick="saveMsg()" >
</div>
<span style=display:block;color:purple;position:absolute;top:100%;font-size:16px;left:5px;line-height:20px>���紫��������Ϣ��
<%
		out.println("<script language='JavaScript'>");
		out.println("var tClientStart=new Date();");
		out.println("document.write('<span style=display:block;absolute;font-size:14px;left:5px;line-height:20px>�������վ�̬ҳ�濪ʼʱ�䣺'+tClientStart+'</span>');");
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

		out.println("document.write('<span style=display:block;absolute;font-size:14px;left:5px;line-height:20px>�������վ�̬ҳ�����ʱ�䣺'+tClientEnd+'</span>');");

		out.println("var iClientTime=0;iClientTime=(tClientEnd - tClientStart) / 1000;");

		out.println("if(iClientTime>0) iShowKbps=Math.round(Math.round(64 / iClientTime));else iShowKbps=0 ;");

		out.println("if(iShowKbps>=128) iShowNote='����';else if(iShowKbps>=32 && iShowKbps<128) iShowNote='һ��';else if(iShowKbps>=16 && iShowKbps<32) iShowNote='�ϲ�';else if(iShowKbps>=4 && iShowKbps<16) iShowNote='����';else if(iShowKbps>=0 && iShowKbps<4) iShowNote='������';");
		out.println("document.write('<span style=display:block;absolute;font-size:16px;font-weight:bold;left:5px;line-height:20px>��������������<span style=color:red;>64KB</span>����ʱ��<span style=color:red;>'+iClientTime+'��</span>�������ٶȣ�<span style=color:red;>'+Math.round(iShowKbps) + 'KB/s</span>������������<span style=color:red;>'+iShowNote+'</span></span>');");
		out.println("var netQuality = iShowNote;");
		
		out.println("</script>\n");
%>
</span>
<span style=display:block;color:green;position:absolute;top:300%;font-size:16px;left:5px;line-height:20px>PC��չʾ�������ܲ���(����鿴)...... 
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
<span style=display:block;color:blue;position:absolute;top:200%;font-size:16px;left:5px;line-height:20px>PC��չʾ����������Ϣ��
<%
		out.println("<script language='JavaScript'>");
		out.println("var tShowEnd=new Date();")	;
		out.println("var iShowTime=0;iShowTime=(tShowEnd - tShowStart) / 1000;");
		out.println("document.write('<span style=display:block;absolute;font-size:14px;left:5px;line-height:20px>����ִ�о�̬ҳ�����ʼʱ�䣺'+tShowStart+'</span>');");
		out.println("document.write('<span style=display:block;absolute;font-size:14px;left:5px;line-height:20px>����ִ�о�̬ҳ��������ʱ�䣺'+tShowEnd+'</span>');");
		out.println("if(iShowTime<0.5) iShowNote='��';else if(iShowTime>=0.5 && iShowTime<1) iShowNote='һ��';else if(iShowTime>=1) iShowNote='��';");
		out.println("var pcQuality = iShowNote;");

		out.println("document.write('<span style=display:block;absolute;font-size:16px;font-weight:bold;left:5px;line-height:20px>����ִ�о�̬ҳ���������ʱ�䣺'+iShowTime+'�룬����PC�������ն˵����ܣ�<span style=color:red;>'+iShowNote+'</span></span>');");

		out.println("</script>\n");
%>
</span>
<span style=display:block;color:maroon;position:absolute;top:70%;font-size:16px;font-weight:bold;left:5px;line-height:20px>ʡ���ķ�����������Ϣ��
<%
		Date tServerEnd=new Date();
		long iServerTime=tServerEnd.getTime() - tServerStart.getTime();
		out.println("����ҳ���ʱ��"+iServerTime+"����");
%>
</span>

<span>
	<script language='JavaScript'>
		//���Ķ������
		var xmlHttp;
		
		//�������������XMLHttpRequest���Ķ���
		function create(){
			if(window.XMLHttpRequset){
				xmlHttp = new XMLHttpRequest();
			}else if(window.ActiveXObject){
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		
		//ajax����ִ�з������˴�Ϊ�ύ��servlet�����,���ش��ı���
		function saveMsg(){
			create();
			var totalMillisecond = "<%=iServerTime%>";
			var acceptPageStartDate = tClientStart.toLocaleString().replace("��", "-").replace("��", "-").replace("��", "");
			var acceptPageEndDate = tClientEnd.toLocaleString().replace("��", "-").replace("��", "-").replace("��", "");
			var transferData = "64";
			var transferMilliSecond = iClientTime;
			var transferSpeed = Math.round(iShowKbps);
			//var netQuality = netQuality;
			var exePageStartDate = tShowStart.toLocaleString().replace("��", "-").replace("��", "-").replace("��", "");
			var exePageEndDate = tShowStart.toLocaleString().replace("��", "-").replace("��", "-").replace("��", "");
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
		
		//�ص�����
		function callback(){
			if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var v = xmlHttp.responseText;
					if (v.indexOf("000000")) {
						alert("����ɹ���");
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
