<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.boss.util.page.*"%>

 
<%
      String opCode = "i282";
	  String opName = "流量提醒功能查询";
	  String phone_no=request.getParameter("phone_no"); 
	  String workno = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode = org_code.substring(0,2);
	  String nopass = (String)session.getAttribute("password");
	  String s_flag = request.getParameter("s_flag"); 
	  String s_rule_id = request.getParameter("s_rule_id"); 
	   
	  //开始 结束 
	  	


	  String ret_val[][];
	  String ret_val_new[][];
	  String[] inParas2 = new String[6];
	 
	  inParas2[0]=workno;
	  inParas2[1]=nopass;
	  inParas2[2]=phone_no;
	  inParas2[3]=s_rule_id  ;
	  inParas2[4]=s_flag;
	 
 
%>
<wtc:service name="sRemindOffOn" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
		    <wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
			<wtc:param value="<%=inParas2[2]%>"/>
			<wtc:param value="<%=inParas2[3]%>"/>
			<wtc:param value="<%=inParas2[4]%>"/>
</wtc:service>
<wtc:array id="mainInfo0"  scope="end"/>
 
<%
		String errCode = retCode2;
		String errMsg = retMsg2;
	 
		String[][] result1  = null ;
 
		result1 = mainInfo0; 
	 
		//retCode2="000000";
		if(retCode2.equals("0")||retCode2.equals("000000"))
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("业务受理成功！");
					window.location.href="i282_1.jsp?activePhone=<%=phone_no%>";
				</script>
			<%
		}
		else
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("业务受理失败！错误代码:"+"<%=errCode%>"+",错误信息:"+"<%=errMsg%>");
					window.location.href="i282_1.jsp?activePhone=<%=phone_no%>";
				</script>
			<%
		}
%>	 
 
 


