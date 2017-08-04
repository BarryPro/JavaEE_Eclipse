<%
  /*
   * 功能: 添加考评内容
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K230";
	//String opName = "添加考评内容";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("############################################");

	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String object_id = WtcUtil.repNull(request.getParameter("object_id"));
	String source_id = WtcUtil.repNull(request.getParameter("source_id"));
	String name = WtcUtil.repNull(request.getParameter("content_name"));
	String weight = WtcUtil.repNull(request.getParameter("weight"));
	String auto_get = WtcUtil.repNull(request.getParameter("auto_get"));
	String formula = WtcUtil.repNull(request.getParameter("formula"));
	String note = WtcUtil.repNull(request.getParameter("note"));
	String crete_login_no = WtcUtil.repNull(request.getParameter("crete_login_no"));
	
	//formula = java.net.URLDecoder.decode(formula);
	formula = formula.replaceAll(" ","+");
	
	System.out.println("---------  " + formula + "  -------------");

   System.out.println("############################################");
   
%>

<wtc:service name="sK230istCt" outnum="3">
	<wtc:param value="<%=object_id%>"/>
	<wtc:param value="<%=source_id%>"/>
	<wtc:param value="<%=name.trim()%>"/>
	<wtc:param value="<%=weight%>"/>
	<wtc:param value="<%=auto_get%>"/>
	<wtc:param value="<%=formula%>"/>
	<wtc:param value="<%=note%>"/>
	<wtc:param value="<%=crete_login_no%>"/>		
</wtc:service>

<wtc:row id="row" start="0" length="3">

<%
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");

System.out.println(row[0]);
System.out.println(row[1]);
System.out.println(row[2]);
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");

%>


var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=row[0]%>");
response.data.add("retMsg","<%=row[1]%>");
response.data.add("content_id","<%=row[2]%>");
core.ajax.receivePacket(response);

</wtc:row>