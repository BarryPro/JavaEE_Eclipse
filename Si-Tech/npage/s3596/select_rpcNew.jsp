<% 
  /*
   * 功能: 农信通业务集团产品选择
　 * 版本: v1.00
　 * 日期: 2009/05/28
　 * 作者: wuxy
　 * 版权: sitech
   * 功能：根据传入的SQL查询 
   * 修改历史
   * 修改日期      修改人      修改目的
   *  
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% request.setCharacterEncoding("GBK");%>


<%@ page import="com.sitech.boss.pub.util.*" %>




<%
    String retType = request.getParameter("retType");
	  String bizcodeadd = request.getParameter("bizcodeadd");
	  String region_code = request.getParameter("region_code");
	  String opCode = request.getParameter("opCode");
	  
	  String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
	  String workNo = (String)session.getAttribute("workNo");
	  String password = (String)session.getAttribute("password"); 
    String[][] retStr = new String[][]{};
	  String retResult  = "false";
	  String retCode="000000";
	  String retMessage="";
		
	  int recordNum1=0;
		

%>
<wtc:service name="sGrpCustQry" routerKey="region" routerValue="<%=regionCode%>"  retcode="code1" retmsg="msg1" outnum="1">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opCode%>" />	
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=password%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=bizcodeadd%>" />
			<wtc:param value="<%=opCode%>" />	
			<wtc:param value="" />	
			<wtc:param value="" />	
			<wtc:param value="<%=region_code%>" />	
			<wtc:param value="" />
			<wtc:param value="" />	
			<wtc:param value="2" />	
			<wtc:param value="" />	
			<wtc:param value="" />			
			<wtc:param value="" />					
			</wtc:service>
			<wtc:array id="result1" scope="end" />
<%       
        
        //System.out.println("--------------result_t--------------hjw"+result_t.length);
        
        retStr = result1;
        //System.out.println("------------="+retStr[0][0]);
        retCode = code1;
        retMessage = msg1;
        if (retCode.equals("000000")&&retStr.length>0)
        {
        	retResult  = "true";
        	retCode  = "000000";
        }
    	else
    	{
    		retResult  = "false";
    	}

	
%>
var response = new AJAXPacket();
var retType = "<%=retType%>";
var retMessage="<%=retMessage%>";
var retCode= "<%=retCode%>";
var retResult = "<%=retResult%>";

response.data.add("retType",retType);
response.data.add("retResult",retResult);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
<%
    if (retCode.equals("000000")&&retStr.length>0)
	{
%>
		
		response.data.add("vidNo","<%=retStr[0][0]%>");
		
<%
	}
%>
core.ajax.receivePacket(response);
