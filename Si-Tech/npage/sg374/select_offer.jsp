
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% request.setCharacterEncoding("GBK");%> 
<%
	String orgCode = (String)session.getAttribute("orgCode");
   	String regionCode = orgCode.substring(0,2);
	String SQL = request.getParameter("SQL");
	String verifyType = request.getParameter("verifyType");
	int length1 = 0;
%>
 		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=SQL%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />
<%
	if(retCode1.equals("0")||retCode1.equals("000000"))
		{
			System.out.println("result1.length="+result1.length);
		}else{
 			System.out.println("调用服务sPubSelect in select_offer.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			System.out.println("retCode1="+retCode1+"retMsg1"+retMsg1);
%>
		<script language=javascript>
		rdShowMessageDialog("查询内容信息出错，错误代码："+retCode1+"错误信息："+retMsg1);
		</script>
<%
 		}
%>
var response = new AJAXPacket();
var myArrayId=new Array();
var myArrayName=new Array();

<%
		for(int i=0;i<result1.length;i++)
		{
		length1++;
%>	
	myArrayId.push("<%=result1[i][0]%>");
	myArrayName.push("<%=result1[i][1]%>");
	
<%
		}
%>

response.data.add("verifyType","<%=verifyType%>");
response.data.add("length1","<%=length1%>");
response.data.add("myArrayId",myArrayId);
response.data.add("myArrayName",myArrayName);
core.ajax.receivePacket(response);