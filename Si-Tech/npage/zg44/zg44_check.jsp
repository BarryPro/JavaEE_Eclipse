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
	String phoneNo = request.getParameter("phoneNo").trim();					//用户号码
	String[] inParam_idno = new String[2];
	inParam_idno[0]="select trim(unit_name) from DvirtualgrpMSG where unit_id = :s_id ";
	inParam_idno[1]="s_id="+phoneNo;
	String s_cust_name="";
	String s_flag="";
	
%>
 
 
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="15004675829"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:param value="<%=inParam_idno[0]%>"/>
		<wtc:param value="<%=inParam_idno[1]%>"/>
	</wtc:service>
	<wtc:array id="resultName" scope="end" />
<%
	String errCode2 = retCode2;
	String errMsg2 = retMsg2;
	//System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa phoneNo is "+phoneNo+" and resultName is "+resultName+" and resultName[0][0] is "+resultName[0][0]);
	if(resultName!=null &&resultName.length>0)
	{
		s_cust_name=resultName[0][0];
		s_flag="0";
	}
	else
	{
		s_flag="1";
	}
 
%>	
     
 

	var response = new AJAXPacket();
			
	response.data.add("s_cust_name","<%=s_cust_name%>");
	
	response.data.add("flag1","<%=s_flag%>");
 
	core.ajax.receivePacket(response);
	
 