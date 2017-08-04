<%
  /*
   * 功能: 用户信誉度修改2308
   * 版本: 1.0
   * 日期: 2009/1/15
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	 					//操作工号
	String unit_id = request.getParameter("unit_id").trim();					//用户号码
	String contract_name = request.getParameter("contract_name");
	String detail_phone = request.getParameter("detail_phone");
	String detail_contract = request.getParameter("detail_contract");
 
    String s_flag="";
	String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);
	String work_no = (String)session.getAttribute("workNo");
	String s_msg = "";
	String s_code = "";
	
%>
 
 
	<wtc:service name="sgrpdetailadd" routerKey="phone" routerValue="15004675829"  retcode="retCode2" retmsg="retMsg2" outnum="2">
		<wtc:param value="<%=unit_id%>"/>
		<wtc:param value="<%=contract_name%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=regionCode%>"/>
		<wtc:param value="<%=detail_phone%>"/>
		<wtc:param value="<%=detail_contract%>"/>
	</wtc:service>
	<wtc:array id="resultName" scope="end" />
<%
	String errCode2 = retCode2;
	String errMsg2 = retMsg2;
	s_msg=errMsg2;
	s_code=errCode2;
	//System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa phoneNo is "+phoneNo+" and resultName is "+resultName+" and resultName[0][0] is "+resultName[0][0]);
	if(errCode2=="000000" ||errCode2.equals("000000"))
	{
		s_flag="0";
		
	}
	else
	{
		s_flag="1";
	}
 
%>	
     
 

	var response = new AJAXPacket();
 
	response.data.add("flag1","<%=s_flag%>");
	response.data.add("s_msg","<%=s_msg%>");
	response.data.add("s_code","<%=s_code%>");
 
	core.ajax.receivePacket(response);
	
 