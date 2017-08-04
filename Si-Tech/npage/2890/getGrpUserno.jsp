<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.19
 模块:EC产品订购
********************/
%>


<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>


<%
	String orgCode = request.getParameter("orgCode");
	String smCode = request.getParameter("smCode");
	String regionCode = orgCode.substring(0,2);
	String []inputPara = new String[]{regionCode,smCode};
    String grpno = "";

    String returnCode = "000000";
    String retMessage = "查询成功！";
    
    try
    {
        //String []result = impl.callService("sGetGrpUserNo",inputPara,"1");
%>
		<wtc:service name="sGetGrpUserNo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
		<wtc:param value="<%=regionCode%>"/>	
		<wtc:param value="<%=smCode%>"/>	
		</wtc:service>	
		<wtc:array id="result"  scope="end"/>
<%
    	returnCode = retCode1;
        retMessage = retMsg1;
        grpno = result[0][0];
    }catch(Exception e){
        e.printStackTrace();
    }
%>   
var response = new AJAXPacket();
var retType = '<%= request.getParameter("retType") %>';
var retCode = "<%=returnCode%>";
var retMessage = "<%=retMessage%>";
var grpno = "<%=grpno%>";
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("GrpNo",grpno);
core.ajax.receivePacket(response);

