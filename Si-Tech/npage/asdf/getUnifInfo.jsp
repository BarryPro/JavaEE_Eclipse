<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String unitid = request.getParameter("unitid");
		//String phoneNo = request.getParameter("phoneNo");
		//String workno = (String)session.getAttribute("workNo");
		String[] inParas = new String[2];
		inParas[0]="select user_name from dgrpcustimpmanmsg where unit_id=:unitId";
		inParas[1]="unitId="+unitid;
%>			
		<wtc:service name="sgetGrpInfo" routerKey="phone" routerValue="15004678912"  retcode="retCode41" retmsg="retMsg41" outnum="6">
		    <wtc:param value="<%=unitid%>"/>
			 
		</wtc:service>
		<wtc:array id="result41" scope="end" />			
<%
		String result = "";
		String unitName = "";
		 
		String return_code = retCode41;
		String return_msg = retMsg41;
		//xl ÅĞ¶Ï 
		String flag="";
		String imp_name=""; 
		
		if(result41.length <= 0)
		{
		   flag="1";
		   unitName="";	
		}
		else
		{
			
			unitName = result41[0][0].trim();
			flag="0";
		}

%>
		var response = new AJAXPacket();
	 
		var return_code = "<%=return_code%>";
		var return_msg = "<%=return_msg%>";
		var unitName = "<%=unitName%>";
		var flag = "<%=flag%>";
		 
		response.data.add("return_code",return_code);
		response.data.add("return_msg",return_msg);
		response.data.add("unitName",unitName);
	    response.data.add("flag",flag);
		
		core.ajax.receivePacket(response);
