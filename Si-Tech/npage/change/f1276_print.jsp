   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-13
********************/
%>
              
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%
//�ڴ˴���ȡsession��Ϣ

%>

<%
ArrayList arr = (ArrayList)session.getAttribute("allArr");
String[][] info = (String[][])arr.get(2);//��ȡ��½IP����ɫ���ƣ����ڲ��ţ���ϣ�

String phone = ReqUtil.get(request,"phone");//�ֻ�����
String date = ReqUtil.get(request,"date");//����
String name = ReqUtil.get(request,"name");//����
String address = ReqUtil.get(request,"address");//��ַ
String cardno = ReqUtil.get(request,"cardno");//֤������
String stream = ReqUtil.get(request,"stream");//��ˮ
String toprintdata = ReqUtil.get(request,"kx_want") + ReqUtil.get(request,"kx_cancle") + ReqUtil.get(request,"kx_running") ;//���������ҵ���������
String sysnote = ReqUtil.get(request,"sysnote");//ȡ��ϵͳ��־
String donote = ReqUtil.get(request,"tonote");//ȡ�ò�����־
String work_no = ReqUtil.get(request,"work_no");//��������

String regionCode = (String)session.getAttribute("regCode");
%>
<%
      if(stream.equals("0"))//�ж��Ƿ���ˮ����0 �������0 ��ʾ��һ�ε��ô�ӡ
		{

%>		
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="stream1" /> 
<%
		  stream = stream1;
		}
%>

<html>
<!---------------------------------����JS--����ҳ������ʽ��----------------------------->

<META http-equiv=Content-Type content="text/html; charset=gb2312">
<OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>

<body onload="ifprint()">
<form action="" name="form" method="post">
</form>
</body>
</html>
<script language="javascript">
function ifprint()
{
 printInvoice();
 rdShowMessageDialog('��ӡ�ɹ�!',2);
 var end = true;
 var stream = <%=stream%>;
 var theend = "true" + stream;
 //alert(theend);
 window.returnValue=theend;
 window.close();

}

function printInvoice()
{
<%
out.println("try{");
out.println("printctrl.Setup(0)");
out.println("printctrl.StartPrint()");
out.println("printctrl.PageStart()");
out.println("printctrl.Print(18,11,10,0,'"+phone+"')");//�ֻ�����
out.println("printctrl.Print(47,11,10,0,'"+date+"')"); //����
out.println("printctrl.Print(12,14,10,0,'"+name+"')");//�ͻ�����
out.println("printctrl.Print(12,17,10,0,'"+address+"')");//��ϵ��ַ
out.println("printctrl.Print(12,20,10,0,'"+cardno+"')");//֤������
out.println("printctrl.Print(12,23,10,0,'"+address+"')");//֤����ַ

/*****************************ѭ����ӡҵ���������************************************/
String retInfo = toprintdata;
		int chPos = 0;
		int row = 51;
		int col = 6;
		chPos = retInfo.indexOf("|"); 
		String valueStr =""; 
	    while(chPos > -1)
	    {
		 valueStr = retInfo.substring(0,chPos);
		 out.println("printctrl.Print('"+col+"','"+row+"',9,0,'"+valueStr+"')" );
		 row = row +1;

			retInfo = retInfo.substring(chPos + 1);
			chPos = retInfo.indexOf("|");
            if( !(chPos > -1)) break;
		}
out.println("printctrl.Print(6,'"+row+"',9,0,'"+sysnote+"')");//ϵͳ��ע
out.println("printctrl.Print(6,53,9,0,'"+donote+"')");//������ע
//out.println("printctrl.Print(12,60,10,0,'"+cardno+"')");//���֤��
out.println("printctrl.Print(12,76,10,0,'"+info[0][5]+info[0][6]+info[0][7]+"')");//����Ӫҵ��
out.println("printctrl.Print(12,79,10,0,'"+work_no+"')");//ӪҵԱ����
/*******************************************************************************/
out.println("printctrl.PageEnd()");
out.println("printctrl.StopPrint()");
out.println("}catch(e){}finally{return true;}");
//out.println("sdfasdfsa");
%>
	return true;
}
</script>