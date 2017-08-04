<%
   /*
   * 功能: 订单缓装查询(订单缓装)分页查询_2
　 * 版本: v1.0
　 * 日期: 2009/01/30
　 * 作者: jiangxl
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
		

<%
	String orderId=request.getParameter("orderId");
%>
<wtc:pubselect name="sPubSelect" outnum="1" retval="content">
	<wtc:sql>
		SELECT COUNT(1) FROM dservordermsg WHERE 
		cust_order_id ='?'
		AND  pay_state IN ('1','2')
	</wtc:sql>
	<wtc:param value="<%=orderId%>"/>
</wtc:pubselect>
<wtc:array id="rows" property="content">

var response = new AJAXPacket();
response.data.add("retType","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("result","<%=rows[0][0]%>");

core.ajax.receivePacket(response);

</wtc:array>
