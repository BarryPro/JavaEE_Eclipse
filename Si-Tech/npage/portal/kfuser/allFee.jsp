<%
   /*
   * 功能: 话费简况
　 * 版本: v1.0
　 * 日期: 2008/09/12
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
var allfee = new Array();
<%

	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
	String retType = request.getParameter("retType");
	String phone_no = request.getParameter("phone_no");
	String begin_time = request.getParameter("begin_time");
	String end_time = request.getParameter("end_time");
	
%> 
 	<wtc:service name="sKF_AllFee"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="3">
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=begin_time%>"/>
		<wtc:param value="<%=end_time%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end"/>
		
<%
	if(retCode.equals("000000")){
		for(int i=0;i<result.length;i++){
%>
			allfee[<%=i%>] = new Array();
			allfee[<%=i%>][0] = "<%=result[i][0]%>";
			allfee[<%=i%>][1] = "<%=result[i][1]%>";
<%
		}
%>
	var response = new AJAXPacket(); 
	response.data.add("retType","<%=retType%>"); 
	response.data.add("retCode","<%=retCode%>" );
	response.data.add("retMsg","<%=retMsg%>" );
	response.data.add("allfee",allfee);
	core.ajax.receivePacket(response);	
<%		
	}else{
%>		

  var response = new AJAXPacket(); 
	response.data.add("retType","<%=retType%>"); 
	response.data.add("retCode","<%=retCode%>" );  
	response.data.add("retMsg","<%=retMsg%>" );<ol>
</ol>
	core.ajax.receivePacket(response);	 
	
<%
	}
%>