<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String custmoter_ec_id = request.getParameter("custmoter_ec_id");
		String selectSql = "select customer_prov from dcustomerinfo where custmoter_ec_id='"+custmoter_ec_id+"'";
		System.out.println("------f2029 getECInfo-"+selectSql);
%>

		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
					<wtc:sql><%=selectSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="ret" scope="end"/>
<%
	String printFlag = "N";
	if("000000".equals(retCode)){
		System.out.println(" ======== sPubSelect 调用成功 ========" + ret.length + " | " + ret[0].length);
		if(ret[0][0].equals("451")){
			printFlag = "Y";
		}else{
			printFlag = "N";
		}
	}
%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("printFlag","<%= printFlag %>");
	core.ajax.receivePacket(response);