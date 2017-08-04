<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String productID_list = request.getParameter("productID_list");
		String selectSql = "select b.id_no,b.account_id from dproductorderdet a,dgrpusermsg b where a.id_no=b.id_no and a.product_id in("+productID_list+")";
		System.out.println("------f2029 getPrintInfo-"+selectSql);
%>

		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
					<wtc:sql><%=selectSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="ret" scope="end"/>
<%
	String custId = "";
	String acconId = "";
	if("000000".equals(retCode)){
		System.out.println(" ======== sOpcodeQry 调用成功 ========" + ret.length + " | " + ret[0].length);
		for(int i = 0; i < ret.length; i++){
			custId += ret[i][0] + ",";
			acconId += ret[i][1] + ",";
			
		}
	}
%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("custId","<%= custId %>");
	response.data.add("acconId","<%= acconId %>");
	core.ajax.receivePacket(response);