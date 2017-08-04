<%
  /*
   * 功能: 判断工号和办理号码是否在同一地市
   * 版本: 2.0
   * 日期: 2010/09/01
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>

<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String inPhone = request.getParameter("inPhone");
	String regioncode = (String)session.getAttribute("regCode");
	String sqlstr = "select substr(belong_code,0,2) from dcustmsg where phone_no = '"+inPhone+"'";
	String flag = "false";	//false 时为没有查询到记录 即工号和号码不在同一地市  true 查询出记录 说明工号和号码在同一地市
%>
	<wtc:pubselect name="sPubSelect" outnum="1">
			<wtc:sql><%=sqlstr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
<%
		if(result1.length > 0){
			String regCode = result1[0][0];
			if(regCode != null && !"".equals(regCode) && regioncode.equals(regCode)){
				flag = "true";
			}
		}
%>
var response = new AJAXPacket();
response.data.add("flag","<%=flag%>");
core.ajax.receivePacket(response);

