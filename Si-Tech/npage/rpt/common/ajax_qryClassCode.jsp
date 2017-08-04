
<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/05/11 liangyl 处理m432选择组织机构数权限问题
* 作者: liangyl
* 版权: si-tech
*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String regionCode = (String)session.getAttribute("regCode");
	String groupId = WtcUtil.repNull(request.getParameter("groupId"));
	String groupName = WtcUtil.repNull(request.getParameter("groupName"));
	System.out.println("---linagyl------"+groupId);
	System.out.println("---linagyl------"+groupName);
	String[] inParamsss1 = new String[2];
    inParamsss1[0] = "select count(1) from DBCUSTADM.dchngroupmsg c where c.group_id=:groupId and c.class_code='703'";
    inParamsss1[1] = "groupId="+groupId;
    
	String  available= "";
	
	String retCode = "";
	String retMsg = "";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region"
	routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss"
	outnum="1">
	<wtc:param value="<%=inParamsss1[0]%>" />
	<wtc:param value="<%=inParamsss1[1]%>" />
</wtc:service>
<wtc:array id="result1" scope="end" />
<%

		if(result1.length > 0){
			available = result1[0][0];
		}
		
		if(!"000000".equals(retCode1ss)){
			retCode = "444444";
			retMsg = "调用查询服务异常";
		}
		else{
			retCode = "000000";
			retMsg = "查询成功";
		}
		
%>
var response = new AJAXPacket(); 
response.data.add("retCode","<%=retCode %>");
response.data.add("retMsg","<%=retMsg %>");
response.data.add("available","<%=available%>");
response.data.add("groupId","<%=groupId%>");
response.data.add("groupName","<%=groupName%>");
core.ajax.receivePacket(response);