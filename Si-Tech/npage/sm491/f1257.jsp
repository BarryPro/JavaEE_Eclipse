<%
/********************
* ����: ���ʷ�ԤԼȡ�� 127a || ���ʷѳ��� 127b
* version v3.0
* ������: si-tech
* update by qidp @ 2008-12-01
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%
	/*
	���������
	0��sInLoginNo   ����
	1��sInLoginPasswd ��������
	2��sInOpCode ��������
	3��sInOrgCode ���Ź���
	4��sInIpAddr IP��ַ
	5��sInPhoneNo �ֻ�����
	6��InOrgId ���Ź���
	7��sInLoginName ��������
	*/

	String work_no = (String)session.getAttribute("workNo");
	String pass = (String)session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode") ;
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String groupId = (String)session.getAttribute("groupId");
	String workName = (String)session.getAttribute("workName");

	String phone = (String)request.getParameter("servno");
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");

	String sInOldLoginAccept = (String)request.getParameter("backaccept");

	String[] paraAray1 = new String[9];
	paraAray1[0] = work_no;		/* ��������   */
	paraAray1[1] = pass; 	        /* �ֻ�����   */
	paraAray1[2] = opCode;
	paraAray1[3] = orgCode;
	paraAray1[4] = ip_Addr;
	paraAray1[5] = phone;
	paraAray1[6] = groupId;
	paraAray1[7] = workName;
	paraAray1[8] = sInOldLoginAccept;

	System.out.println("------------ly---------------");
	for (int i=0;i<paraAray1.length;i++)
	{
		System.out.println(paraAray1[i]);
	}
	System.out.println("------------ly---------------");
	String titleStr = opName;
 %>
 <wtc:service name="s1257CfmTemp" routerKey="phone" routerValue="<%=phone%>" outnum="32" retcode="s1270GetMsgCode" retmsg="s1270GetMsgMsg">
        <wtc:param value="<%=paraAray1[0]%>"/>
        <wtc:param value="<%=paraAray1[1]%>"/>
        <wtc:param value="<%=paraAray1[2]%>"/>
        <wtc:param value="<%=paraAray1[3]%>"/>
        <wtc:param value="<%=paraAray1[4]%>"/>
        <wtc:param value="<%=paraAray1[5]%>"/>
        <wtc:param value="<%=paraAray1[6]%>"/>
        <wtc:param value="<%=paraAray1[7]%>"/>
        <wtc:param value="<%=paraAray1[8]%>"/>
	</wtc:service>
	<wtc:array id="retS127aInitArr"  scope="end"/>
<%
	String errCode = s1270GetMsgCode;
    String errMsg = s1270GetMsgMsg;
    String ret_code = "" ;
    String ret_msg = "";
    if(errCode.equals("000000"))
    {
        ret_code = "000000";          // ���ش���
    }else
    {
        ret_code = errCode;
    }
    ret_msg = errMsg;			  // ��ʾ��Ϣ
 %>
 <html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=titleStr%></TITLE>
</HEAD>
<%
    if(!ret_code.equals("000000")){%>
        <script language='jscript'>
            var ret_code = "<%=ret_code%>";
            var ret_msg = "<%=ret_msg%>";
            rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��",0);
        	//document.location.replace("f1170Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
         	//window.close();
         	removeCurrentTab();
         </script>
<%  }
	else
	{
%>
	  <script language='jscript'>
       rdShowMessageDialog("���������ɹ���",1);
       //window.close();
       removeCurrentTab();
       </script>
<%}%>
</html>