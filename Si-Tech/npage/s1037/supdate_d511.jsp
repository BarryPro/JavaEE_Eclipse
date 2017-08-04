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
	String regionCode = org_code.substring(0,2);
 	String nopass1 = ((String[][])arrSession.get(4))[0][0];
	String paraStr[]=new String[5];
    String op_code="d511"; 
 
    String custId = request.getParameter("custid");
	String custName = request.getParameter("custname");
	String zjxts  = request.getParameter("zjxts");
	String rateId  = request.getParameter("rateId");
	String local  = request.getParameter("local");
	String longs  = request.getParameter("longs");
    String jfje  = request.getParameter("jfje");
	String zsr  = request.getParameter("zsr");
	String jssr  = request.getParameter("jssr");
	if(local == null || local.equals("") ){
		local = "0";
	}
	if(longs == null || longs.equals("") ){
		longs = "0";
	}
	 //xl bs_d510Cfm
	//补充需求 begin
	String pbx_num = request.getParameter("pbx_num");
	String real_num = request.getParameter("real_num");
	String total_mins = request.getParameter("total_mins");
	String rentfee = request.getParameter("rentfee");
	String funcfee = request.getParameter("funcfee");
	String localincome = request.getParameter("localincome");
	String longincome = request.getParameter("longincome");
 
	//补充需求 end
	String[] inParas = new String[18];
	inParas[0] = op_code;
	inParas[1] = work_no;
	inParas[2] = custId;
	inParas[3] = custName;
	inParas[4] = zjxts;
	inParas[5] = rateId;
	inParas[6] = local;
	inParas[7] = longs;
	inParas[8] = jfje;
	inParas[9] = jssr;
	inParas[10] = zsr;
	//xl
	//xl add for 补充需求 begin
	inParas[11] = pbx_num;
	inParas[12] = real_num;
	inParas[13] = localincome;
	inParas[14] = longincome;
	inParas[15] = total_mins;
	inParas[16] = rentfee;
	inParas[17] = funcfee;
	//xl add for 补充需求 end 
  
	 
 
 	String result[][] = new String[][]{};
	 
	//String return_code = result[0][0];
	String return_code ="";
 	//String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
	String error_msg ="1";
  %>
<wtc:service name="bs_d511Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	<wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/>
	<wtc:param value="<%=inParas[8]%>"/>
	<wtc:param value="<%=inParas[9]%>"/>
	<wtc:param value="<%=inParas[10]%>"/>
	<wtc:param value="<%=inParas[11]%>"/>
	<wtc:param value="<%=inParas[12]%>"/>
	<wtc:param value="<%=inParas[13]%>"/>
	<wtc:param value="<%=inParas[14]%>"/>
	<wtc:param value="<%=inParas[15]%>"/>
	<wtc:param value="<%=inParas[16]%>"/>
	<wtc:param value="<%=inParas[17]%>"/>
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
		 
			rdShowMessageDialog("数据修改失败！失败原因:"+"<%=result[0][1]%>",0);
			document.location.replace("d511.jsp");

	 
		</SCRIPT>
<%
	}else{
%>
<SCRIPT LANGUAGE="JavaScript">
 
			rdShowMessageDialog("本月记录修改成功!",2);
			document.location.replace("d511.jsp");
	

</SCRIPT>
<!--**************************************************************************************-->
 
</html>
<%}%>