<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%//------查看宽带是否是竣工宽带
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag ="0";
	
		String iCfmLogin = request.getParameter("iCfmLogin");

			
	String[] inParamsss1 = new String[2];
	inParamsss1[0] = "SELECT COUNT(1) FROM dbroadbandmsg a, dcustmsg b WHERE a.id_no = b.id_no AND b.run_code <> 'PP' AND a.cfm_login = :iCfmLogin";
	inParamsss1[1] = "iCfmLogin="+iCfmLogin;
	
System.out.println(iCfmLogin+"=======wanghyd");
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust" scope="end" />
<%
if(dcust.length>0) {
	smzflag=dcust[0][0];
}
System.out.println(smzflag+"=======wanghyd");
%>		

	var response = new AJAXPacket();
	response.data.add("smzvalue","<%=smzflag%>");
	core.ajax.receivePacket(response);