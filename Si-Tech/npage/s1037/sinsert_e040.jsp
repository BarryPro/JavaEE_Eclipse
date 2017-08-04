<%
/********************
 version v2.0
开发商: si-tech
********************/
%>


<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>

<HTML>
<HEAD>
    <TITLE>黑龙江移动BOSS__________________________________________</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"></HEAD>

<%
	request.setCharacterEncoding("gb2312");
    
    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String nopass = (String)session.getAttribute("password");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String org_code = baseInfoSession[0][16];
	//String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	%>
		<script language = "javascript">
			//alert("test for org_code is  "+"<%=org_code%>"+" and work_no is "+"<%=work_no%>"+" and loginName is "+"<%=loginName%>");
		</script>
	<%
 	String nopass1 = ((String[][])arrSession.get(4))[0][0];
	String paraStr[]=new String[5];
    String op_code="e040"; 
 
    String dythyhs = request.getParameter("dythyhs");
	String monthId = request.getParameter("monthId");
	String select_value = request.getParameter("select_value");
	String select_value2 = request.getParameter("select_value2");
	 
	String dyttsr = request.getParameter("dyttsr");
	String dyydsr = request.getParameter("dyydsr");

 
	String[] inParas = new String[8];
	inParas[0] = monthId;
	inParas[1] = dythyhs;
	inParas[2] = dyttsr;
	inParas[3] = dyydsr;
	inParas[4] = select_value;
	inParas[5] = select_value2;
	inParas[6] = work_no;
	inParas[7] = op_code;
	 
	 
  
	 
 
 	String result[][] = new String[][]{};
	 
	//String return_code = result[0][0];
	String return_code ="";
 	//String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
	String error_msg ="1";
  %>
<wtc:service name="bs_e040Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	<wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/>
	
	
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>

	
  <%

	result = sVerifyTypeArr;
	return_code  =  result[0][0];
%>
<!--
<SCRIPT LANGUAGE="JavaScript">
	alert("111111111 "+"<%=return_code%>");
	</script>
-->
<%
	if (!return_code.equals("000000") ){
	%>
 
	    <SCRIPT LANGUAGE="JavaScript">
		 
			rdShowMessageDialog("数据录入失败！错误原因:"+"<%=result[0][1]%>",0);
			document.location.replace("e040.jsp");

	 
		</SCRIPT>
<%
	}else{
%>
<SCRIPT LANGUAGE="JavaScript">
            
			rdShowMessageDialog("本月记录录入成功!",2);
			document.location.replace("e040.jsp");
	

</SCRIPT>
<!--**************************************************************************************-->
 
</html>
<%}%>