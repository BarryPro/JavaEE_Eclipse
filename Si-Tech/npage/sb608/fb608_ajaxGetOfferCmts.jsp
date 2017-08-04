<%
/********************
 version v2.0
开发商: si-tech
*
*create:wanghfa@2010-12-15 获得资费描述
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>

<%
	String offerId = WtcUtil.repStr(request.getParameter("offerId"), "");
	String result = "";
	String comments = new String();
	String sql = "select offer_comments from product_offer where offer_id = '" + offerId + "'";
	System.out.println("===============wanghfa================ sql = " + sql);
%>
<wtc:pubselect name="sPubSelect" outnum="1" retcode="retCode1" retmsg="retMsg1">
	<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end" />
<%
	System.out.println("===============wanghfa================ result1[0][0] = " + result1[0][0]);
	result = retCode1;
	if ("000000".equals(retCode1) && result1[0][0] != null) {
		comments = result1[0][0];
	}
%>

var response = new AJAXPacket();
var retResult = "<%=result%>";
var comments = "<%=comments%>";

response.data.add("retResult",retResult);
response.data.add("comments",comments);

core.ajax.receivePacket(response);
