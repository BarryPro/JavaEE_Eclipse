<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-19 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%

	String return_code="";
	String ret_msg="";
	String return_page = "g508_1.jsp";
    String opCode = "g508";
	String opName = "ѡ������С��Ȩ������";
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);	

	int sum = 0;
	if(request.getParameter("sum") != null && !request.getParameter("sum").equals(""))
	{
		sum = Integer.parseInt(request.getParameter("sum"));
	}
	String str="";
	
	for (int i=0;i<sum;i++)
	{	
//		if(request.getParameter("attr4"+i) != null && !request.getParameter("attr4"+i).equals(""))
//		{
			str+=request.getParameter("attr0"+i);
			str+="|";
			str+=request.getParameter("attr1"+i);
			str+="|";
			str+=request.getParameter("attr2"+i);
			str+="|";
			str+=request.getParameter("attr4"+i);
			str+=",";
//		}
	}
	if(str.length()>0)
	{
		str = str.substring(0,str.length()-1);
	}

	String [] inParas = new String[3];
	inParas[0]  = workno;
	inParas[1]  = opCode;
	inParas[2]  = str;
%>
	<wtc:service name="bs_g5081Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%	
   return_code = retCode;
   ret_msg = retMsg;
   
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">

<body >
  <%	
	if (return_code.equals("000000"))
	{	
%>	
 <script language="javascript">
	  rdShowMessageDialog("ѡ������С��Ȩ�����óɹ���");
	  window.location.href="<%=return_page%>";
 </script>


<%
}else{
%>
 <script language="javascript">
	  rdShowMessageDialog("ѡ������С��Ȩ������ʧ�ܣ�");
	  window.location.href="<%=return_page%>";
 </script>
<%}
%>
</body></html>