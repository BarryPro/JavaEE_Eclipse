<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    String loginNo= (String)session.getAttribute("workNo");   
	  String apncode= WtcUtil.repStr(request.getParameter("apncode"), "");
	  String funcitons="0";
	  String returncodes="";
	  String returnmsgs="";
		String[] inParamsss1 = new String[2];
	  inParamsss1[0] = "select count(*) from dbcustadm.sapncode where apn_code=:v1 and four_flag='1' and region_code=:v2 ";
	  inParamsss1[1] = "v1="+apncode+",v2="+regionCode;
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>	
		</wtc:service>	
	  <wtc:array id="dcustarry" scope="end" />
<%
		if(dcustarry.length>0) {
					funcitons=dcustarry[0][0];	
		}
		returncodes=retCode1ss;
		returnmsgs=retMsg1ss;

    

%>
var response = new AJAXPacket();
response.data.add("errCode","<%=returncodes%>");
response.data.add("errMsg","<%=returnmsgs%>");
response.data.add("opType","<%=funcitons%>");
core.ajax.receivePacket(response);
 
	    