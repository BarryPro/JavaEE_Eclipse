<%
/*
 * 功能: TD固话自备机入网
 * 版本: 1.0
 * 日期: 2012-09-07 8:56:17
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/
%>

<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String inPhone = request.getParameter("phoneNo");
	String sqlstr = "select no_type from dcustres where phone_no='"+inPhone+"'";
	String phoneHead = inPhone.substring(0,3);
	String flag = "false";
%>
	<wtc:pubselect name="sPubSelect" outnum="1">
			<wtc:sql><%=sqlstr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
<%
		if(result1.length > 0){
			String noType = result1[0][0];
			System.out.println("$$$$$$$$$$$$$$$$$$$$$4 noType="+noType + "$$$$$$$$$$$$phoneHead="+phoneHead);
			if("147".equals(phoneHead) && "0000h".equals(noType)){
				flag = "true";
			}
		}
%>
var response = new AJAXPacket();
response.data.add("result","<%=flag%>");
core.ajax.receivePacket(response);
