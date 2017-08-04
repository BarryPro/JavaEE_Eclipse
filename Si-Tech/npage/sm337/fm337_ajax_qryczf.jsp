<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
*create liangyl 2016-03-23
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		
		String regCode = (String)session.getAttribute("regCode");
		String region_code=request.getParameter("region_code");
		String smCode = request.getParameter("sm_code");
		String tdindex=request.getParameter("tdindex");
		String sql = "select prefee from sbandprefee where region_code=:region_code and sm_code=:sm_code";
		String[] inParams = new String[2];
		inParams[0] = sql;
		inParams[1] = "region_code="+regCode+",sm_code="+smCode;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="result"  scope="end"/>
	var results="";
	<%
		System.out.println("liangyouliang:"+retCode);
		String results="";
		if(retCode.equals("000000")){
			for(int i=0;i<result.length;i++){
				results+="<option value='"+result[i][0]+"'>"+result[i][0]+"</option>";
			}
		}
	%>
	results="<%=results%>";
	var response = new AJAXPacket();
	response.data.add("tdindex",<%=tdindex%>);
	response.data.add("results",results);
	core.ajax.receivePacket(response);