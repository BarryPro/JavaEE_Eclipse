<%
  /*
   * 功能: 获取用户信息
   * 版本: 2.0
   * 日期: 2016/11/2
   * 作者: liangyl
   * 版权: si-tech
   * update:
   */
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%
	String orgCode 		= (String)session.getAttribute("orgCode");
	String regionCode 	= orgCode.substring(0,2);
	
	String paraAray[] = new String[2];
	String kuandaiNum = request.getParameter("kuandaiNum");
	paraAray[0] = "select cust_name,id_address,id_type,id_iccid from DBCUSTADM.dcustdoc where cust_id in (select cust_id from DBCUSTADM.dcustmsg where phone_no in (SELECT phone_no FROM DBCUSTADM.DBROADBANDMSG WHERE CFM_LOGIN =:CFM_LOGIN))";
	paraAray[1] = "CFM_LOGIN="+kuandaiNum;  
	String userName="";
	String userAddr="";
	String idType="";
	String idIccid="";
		
%>
	<wtc:service name="TlsPubSelCrm" outnum="4" retmsg="retMsg1" retcode="retCode1" routerKey="regionCode" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
	</wtc:service>
	<wtc:array id="result11" scope="end"/>
<%
	if("000000".equals(retCode1)){
		if(result11.length > 0){
			userName = result11[0][0];
			userAddr = result11[0][1];
			idType = result11[0][2];
			idIccid = result11[0][3];
		}else{
			userName= "";
			userAddr="";
			idType = "";
			idIccid = "";
		}
	}else{
		System.out.println("获客户信息失败 ["+retCode1+"],"+retMsg1+"");
	}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode1%>");
response.data.add("retMsg","<%=retMsg1%>");
response.data.add("userName","<%=userName%>");
response.data.add("userAddr","<%=userAddr%>");
response.data.add("idType","<%=idType%>");
response.data.add("idIccid","<%=idIccid%>");
core.ajax.receivePacket(response);