<%
/********************
  version v2.0
  ������: si-tech
  update:diling@2012-06-08
********************/
%>
<!--
Setup ��ʾ��ӡ���öԻ��� 1 ��ʾ 0 ����ʾ
StartPrint ��ʼ��ӡ
PageStart �µ�ҳ
Print 
����1 x���꣨0 - 100��һ�����꣩
����2 y���꣨0 - 100��һ�����꣩
����3 �ֺţ�0 - 100��0Ϊϵͳȱʡ�ֺţ�
����4 �ִ�ϸ��0 - 10��0Ϊϵͳȱʡ��
����5 Ҫ��ӡ���ַ���

PageEnd ҳ����
StopPrint ֹͣ��ӡ
<!-------------------------------------------->
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
  String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
  String opName = WtcUtil.repStr(request.getParameter("opName"), "");
  String phoneNo = WtcUtil.repStr(request.getParameter("activePhone"), "");
  String applicationNo = WtcUtil.repStr(request.getParameter("applicationNo"), ""); //������
  System.out.println("----------d877--fd877_printApplicationNo.jsp---applicationNo="+applicationNo);
%>
<HTML>
<HEAD>
    <TITLE></TITLE>
</HEAD>

<SCRIPT type=text/javascript>
window.onload=function()
{
  try
  {
    //��ӡ��ʼ��
  	printctrl.Setup(0);
  	printctrl.StartPrint();
  	printctrl.PageStart();
      
  	printctrl.Print(78,3,7, 0, "<%=applicationNo%>");
   
  	//��ӡ����
  	printctrl.PageEnd();
  	printctrl.StopPrint();
  }
  catch(e)
  {
 	  rdShowMessageDialog("�쳣!",0);
  	alert(e.printstacktrace());	
  }
   finally
  {
    window.location = "fd877.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
  }
}
 </SCRIPT>
<!--**************************************************************************************-->
<FORM method=post name="spubPrint">
<!------------------------------------------------------>
    <BODY >
          
    </BODY>
</FORM>
<!-------�����ӡ�ؼ�---------->
<OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>
</HTML>    
