<%
/*
 * ����: ʡ��Я��
 * �汾: 1.0
 * ����: 2012/3/9 14:19:13
 * ����: zhangyan
 * ��Ȩ: si-tech
 * update:
*/

%>
<%@ include file="/npage/include/public_title_name_p.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
String myJSONText	=request.getParameter("myJSONText");
String regCode		=	(String)session.getAttribute("regCode");
String phoneNo		=request.getParameter("phoneNo");
String opCode		=request.getParameter("opCode");
String opName		=request.getParameter("opName");
String custOrderId = WtcUtil.repNull(request.getParameter("custOrderId"));	  //�ͻ�������
String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));    //�ͻ��������

System.out.println("zhangyan~~~~~~~~~~~~~myJSONText~~~~~~~~~~~~```"+myJSONText);
%>
<wtc:utype name="sChgCityCfm" id="retVal" scope="end"  
	routerKey="region" routerValue="<%=regCode%>">
	<wtc:uparam value="<%=myJSONText%>" type="STRING"/>  
</wtc:utype>
<%
String retCodeCfm = (String)retVal.getValue(0);
String retMsgCfm = (String)retVal.getValue(1);
System.out.println("zhangyan~~~~~~~~~~~~~retCodeCfm~~~~~~~~~~~~```"+retCodeCfm);
System.out.println("zhangyan~~~~~~~~~~~~~retMsgCfm~~~~~~~~~~~~```"+retMsgCfm);

if( "0".equals(retCodeCfm))
{
%>
	<script>
		rdShowMessageDialog("e687�ύ�ɹ�!");
		window.location = 'fE687Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
	</script>
<%
}
else
{%>
	<script>
		rdShowMessageDialog("<%=retCodeCfm%>"+":"+"<%=retMsgCfm%>" , 0);
		window.location = 'fE687Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
	</script>
<%
}%>