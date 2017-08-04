<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%//------修改先vp产品预销，增加限制，短号短信产品预销后才可以预销VP产品。
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String vpnflag ="0";
	
		String grp_id = request.getParameter("grp_id");

	String[] inParamsss1 = new String[2];
	inParamsss1[0] = "select count(a.id_no) from dgrpusermsg a,dgrpusermsg b where a.cust_id=b.cust_id and a.run_code='A' and a.sm_code='dd' and b.sm_code='vp' and b.id_no=:grp_id";
	inParamsss1[1] = "grp_id="+grp_id;
	
System.out.println(grp_id+"=======wanghyd");
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust" scope="end" />
<%
if(retCode1ss.equals("000000")) {
if(!dcust[0][0].equals("0")) {
vpnflag="1";
}
}else {
vpnflag="0";
}
%>		

	var response = new AJAXPacket();
	response.data.add("vpnflag","<%=vpnflag%>");
	core.ajax.receivePacket(response);