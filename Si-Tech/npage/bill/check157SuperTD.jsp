<%
  /*
   * 功能: 验证157号段只有TD公话号码才能办理该业务
   * 版本: 2.0
   * 日期: 2012/09/13
   * 作者: gaopeng
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
			if("157".equals(phoneHead) && "0000h".equals(noType)){
				flag = "true";
			}
		}
%>
var response = new AJAXPacket();
response.data.add("result","<%=flag%>");
core.ajax.receivePacket(response);

