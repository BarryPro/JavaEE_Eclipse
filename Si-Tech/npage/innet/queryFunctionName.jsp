<%
    /*************************************
    * 功  能: 验证用户139邮箱
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: wanghyd @ 2012-8-1
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    String loginNo= (String)session.getAttribute("workNo");   
	  String opCode= WtcUtil.repStr(request.getParameter("opCode"), "");
	  String funcitons="";
	  String returncodes="";
	  String returnmsgs="";
	
		String[] insRoleArr=opCode.split(",");
		for(int i=0; i<insRoleArr.length; i++){
					
		String[] inParamsss1 = new String[2];
	  inParamsss1[0] = "select function_name from sfunccodenew where function_code=:funcodes";
	  inParamsss1[1] = "funcodes="+insRoleArr[i];
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>	
		</wtc:service>	
	  <wtc:array id="dcustarry" scope="end" />
<%
		if(dcustarry.length>0) {
					funcitons+=dcustarry[0][0]+",";	
		}
		returncodes=retCode1ss;
		returnmsgs=retMsg1ss;

    }
    
    if(funcitons.length()>0) {
      funcitons=funcitons.substring(0,funcitons.length()-1);
    }
    System.out.println("funcitons==============================="+funcitons);
%>
var response = new AJAXPacket();
response.data.add("errCode","<%=returncodes%>");
response.data.add("errMsg","<%=returnmsgs%>");
response.data.add("opName","<%=funcitons%>");
core.ajax.receivePacket(response);
 
	    