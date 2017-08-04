<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-19 页面改造,修改样式
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

	String shrName = request.getParameter("shrName").trim();
	String jsrName = request.getParameter("jsrName").trim();
	String zbrName = request.getParameter("zbrName").trim();
	String org_code = (String)session.getAttribute("orgCode");
	String region_code = org_code.substring(0,2);
	String dis_code = org_code.substring(2,4);
	String [] inParas = new String[5];
	String return_page = "e900_3.jsp";
	String return_code="";
	String ret_msg="";
	String[] inParas1 = new String[2];
	String[] inParas2 = new String[2];
	
	String region_group = "" ;
	String dis_group = "" ;
	
	
	inParas1[0]="select group_id from sregioncode  where region_code=:region_code";
	inParas1[1]="region_code="+region_code;
	
	inParas2[0]="select group_id from sdiscode  where region_code=:region_code and district_code=:district_code";
	inParas2[1]="region_code="+region_code+",district_code="+dis_code;
	
%>
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=region_code%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParas1[0]%>"/>
	<wtc:param value="<%=inParas1[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
		
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=region_code%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val2" scope="end" />
			
<%
	
	region_group = ret_val[0][0];
	dis_group = ret_val2[0][0];
	
	inParas[0]=region_group;
	inParas[1]=dis_group;
	inParas[2]=shrName;
	inParas[3]=jsrName;
	inParas[4]=zbrName;
	
	

%>
	<wtc:service name="bs_9003Cfm" routerKey="region" routerValue="<%=region_code%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
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
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("设置成功！");
			window.location.href="<%=return_page%>";
		</SCRIPT>

<%
	}else{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("设置失败！);
			window.location.href="<%=return_page%>";
		</SCRIPT>
<%	}
%>
</body></html>