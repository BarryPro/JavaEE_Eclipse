<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
var result = new Array();
var result1 = new Array(new Array(),new Array());
<%
	String org_code = (String)session.getAttribute("orgCode");
	String phone_no = request.getParameter("phone_no").trim();
	String opType = request.getParameter("opType").trim();
	System.out.print("\n\n\n[调用开始]\n\n\n");
%>

	<wtc:service name="s1874Init" routerKey="phone" routerValue="<%=phone_no%>"  outnum="14">
		<wtc:param value="<%=phone_no%>"/>
	</wtc:service>
	<wtc:array id="result" start="0" length="12"  scope="end"/>
	<wtc:array id="result1" start="12" length="2"  scope="end"/>
		
<%
	if(result.length > 0){
	System.out.println("===================================result[0].length:"+result[0].length);
		for(int i=0;i<result[0].length;i++){
%>
			result[<%=i%>] = "<%=result[0][i]%>";
<%
		}
	}
%>	
<%
	if(result1.length > 0){
	System.out.println("===================================result1[0].length:"+result1[0].length);
		for(int i=0;i<result1.length;i++){
			for(int j=0;j<result1[i].length;j++){
			System.out.println("===================================result1[0].length:"+result1[i][j]);
%>
			result1[<%=j%>][<%=i%>] = "<%=result1[i][j]%>";
<%
			}
		}
	}
%>		
	var response = new AJAXPacket();
	response.guid = '<%= request.getParameter("guid") %>';
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	response.data.add("opType","<%=opType%>");
	response.data.add("result",result);
	response.data.add("result1",result1);
	core.ajax.receivePacket(response);