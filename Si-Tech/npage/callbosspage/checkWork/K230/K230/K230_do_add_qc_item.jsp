<%
  /*
   * 功能: 添加考评项
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K230";
	//String opName = "添加考评项";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("############################################");

	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String object_id = WtcUtil.repNull(request.getParameter("object_id"));
	String contect_id = WtcUtil.repNull(request.getParameter("contect_id"));
	String is_leaf = WtcUtil.repNull(request.getParameter("is_leaf"));
	String item_name = WtcUtil.repNull(request.getParameter("item_name"));
	String low_score = WtcUtil.repNull(request.getParameter("low_score"));
	String high_score = WtcUtil.repNull(request.getParameter("high_score"));
	String weight = WtcUtil.repNull(request.getParameter("weight"));
	String formula = WtcUtil.repNull(request.getParameter("formula"));
	String note = WtcUtil.repNull(request.getParameter("note"));
	String isDefault = WtcUtil.repNull(request.getParameter("isDefault"));
	String isScore = WtcUtil.repNull(request.getParameter("isScore"));
	String parent_item_id = WtcUtil.repNull(request.getParameter("parent_item_id"));
	String crete_login_no = WtcUtil.repNull(request.getParameter("crete_login_no"));
	System.out.println("parent_item_id:"+parent_item_id);
	System.out.println("isScore:"+isScore);
	
   System.out.println("############################################");
   
%>

<wtc:service name="sK230istIm" outnum="3">
	<wtc:param value="<%=parent_item_id%>"/>
	<wtc:param value="<%=object_id%>"/>
	<wtc:param value="<%=contect_id%>"/>
	<wtc:param value="<%=is_leaf%>"/>
	<wtc:param value="<%=item_name%>"/>
	<wtc:param value="<%=low_score%>"/>
	<wtc:param value="<%=high_score%>"/>
	<wtc:param value="<%=weight%>"/>
	<wtc:param value="<%=formula%>"/>
	<wtc:param value="<%=note%>"/>
	<wtc:param value="<%=crete_login_no%>"/>
	<wtc:param value="<%=isDefault%>"/>
	<wtc:param value="<%=isScore%>"/>
				
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
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
response.data.add("item_id","<%=row[2]%>");
core.ajax.receivePacket(response);

</wtc:row>