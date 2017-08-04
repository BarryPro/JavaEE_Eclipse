<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%

	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr  = request.getRemoteAddr();

		
	String nopass  = (String)session.getAttribute("password");//登陆密码
	
	String idNo = request.getParameter("idNo");//查询条件	
%>
    <wtc:service name="sGrpMemQryEXC"  outnum="7" retcode="errCode" retmsg="errMsg" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=idNo%>" />
    	<wtc:param value="" />
    	<wtc:param value="" />
    	<wtc:param value="5082" />
    	<wtc:param value="<%=workNo%>" />    		
    	</wtc:service>
    <wtc:array id="result0" start="1" length="6" scope="end"/>	

<%
	String []paraArr=new String[6];
	paraArr[0]="5082";
	paraArr[1]=workNo;
	paraArr[2]=nopass;
	paraArr[3]=org_code;
	paraArr[4]="操作员"+workNo+"对集团产品id为:"+idNo+"的客户进行信息查询导出";
	paraArr[5]=ip_Addr;
    %>
    	<wtc:service name="swLoginOpr"  outnum="2" retcode="errCode2" retmsg="errMsg2" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=paraArr[0]%>" />
    	<wtc:param value="<%=paraArr[1]%>" />
    	<wtc:param value="<%=paraArr[2]%>" />
    	<wtc:param value="<%=paraArr[3]%>" />
    	<wtc:param value="<%=paraArr[4]%>" />
    	<wtc:param value="<%=paraArr[5]%>" />    		
    	</wtc:service>
    	<wtc:array id="retArr1" scope="end"/>
<%	

	System.out.println("---liujian---errCode=" + errCode + "----errCode2=" + errCode2);
	if(errCode.equals("000000") && errCode2.equals("000000")) {
   	%>
   		var response = new AJAXPacket();
		response.data.add("retcode","000000");
		response.data.add("retmsg","导出申请记录成功，请到e079模块查询导出结果!");
		core.ajax.receivePacket(response);	
	<%
	}else {
		if(!errCode.equals("000000")) {
	%>
			var response = new AJAXPacket();
			response.data.add("retcode","<%=errCode%>");
			response.data.add("retmsg","<%=errMsg%>");
			core.ajax.receivePacket(response);	
	<%		
		}else {
		%>
			var response = new AJAXPacket();
			response.data.add("retcode","<%=errCode2%>");
			response.data.add("retmsg","<%=errMsg2%>");
			core.ajax.receivePacket(response);	
		<%	
		}
	}
%>
