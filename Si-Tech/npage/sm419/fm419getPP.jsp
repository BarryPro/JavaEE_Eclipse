<%
  /*
   * 功能: 获取产品品牌
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
	paraAray[0] = "select sm_code,phone_no from DBCUSTADM.dcustmsg where phone_no in(SELECT PHONE_NO FROM DBCUSTADM.DBROADBANDMSG WHERE CFM_LOGIN =:CFM_LOGIN)";
	paraAray[1] = "CFM_LOGIN="+kuandaiNum;  
	String ppName="";
	String phoneNum="";
		
%>
	<wtc:service name="TlsPubSelCrm" outnum="2" retmsg="retMsg1" retcode="retCode1" routerKey="regionCode" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
	</wtc:service>
	<wtc:array id="result11" scope="end"/>
<%
	if("000000".equals(retCode1)){
		if(result11.length > 0){
			ppName = result11[0][0];
			phoneNum = result11[0][1];
		}else{
			ppName= "";	
			phoneNum="";
		}
	}else{
		System.out.println("获产品品牌执行失败 ["+retCode1+"],"+retMsg1+"");
	}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode1%>");
response.data.add("retMsg","<%=retMsg1%>");
response.data.add("ppName","<%=ppName%>");
response.data.add("phoneNum","<%=phoneNum%>");
core.ajax.receivePacket(response);