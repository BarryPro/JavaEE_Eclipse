<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
/********************
 version v2.0
������: si-tech
*
*e662  ģ����ѯ��ҳ��
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%
		String[] inParas1 = new String[2];
		String opCode = "e662";
		String opName = "�ֹ�ϵͳ��ֵ��ѯ";
		String regionCode = (String)session.getAttribute("regCode");
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String ip_Addr =  (String)session.getAttribute("ipAddr");

    String document_accept	= request.getParameter("document_accept") ;
    String busi_flag 				= request.getParameter("busi_flag") ;
    String action_note = "";
%>

<wtc:service name="sE660_audit" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="0">
	<wtc:param value="<%=busi_flag%>"/>
	<wtc:param value="<%=document_accept%>"/>
	<wtc:param value="<%=workno%>"/>
	<wtc:param value="<%=ip_Addr%>"/>
</wtc:service>

<%
	if( ! retCode.equals("000000") )
	{
%>
	<SCRIPT type=text/javascript>
		rdShowMessageDialog("����sE660_audit����ʧ�ܡ�<br>������룺'<%=retCode%>'��<br>������Ϣ��'<%=retMsg%>'��",0);
		history.go(-1);
	</SCRIPT>
<%
	}
%>

	
</script> 
<title>�ֹ�ϵͳ��ֵ��ѯ</title>
</head>
<BODY onload=""> 
	<form>
		
		<%@ include file="/npage/include/header.jsp" %>  
  <table>
    <tr> 
      <td class="blue" width="100%"> 
				�����ɹ�����������
       </td>
    </tr>
    <tr> 
      <td id="footer"> 
				<input type="button" name="return2" class="b_foot" value="����" onClick="history.go(-1)" >
				&nbsp;
  
        &nbsp;
		  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>
</form>
</BODY>
</HTML>