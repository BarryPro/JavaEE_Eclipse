<%@ page contentType= "text/html;charset=gbk" %>

<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%//------根据offerid查询出资费名称和资费描述

		String workNo = (String)session.getAttribute("workNo");

		String regionCode= (String)session.getAttribute("regCode");

		String password = (String)session.getAttribute("password");

		String offername ="";
		String offercomments ="";
	

		String offerid = request.getParameter("offerid");



			

	String[] inParamsss1 = new String[2];

	inParamsss1[0] = "SELECT offer_name,offer_comments FROM product_offer a where offer_id = :iCfmLogin";

	inParamsss1[1] = "iCfmLogin="+offerid;

	

System.out.println(offerid+"=======wanghyd");

%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="2">			

	<wtc:param value="<%=inParamsss1[0]%>"/>

	<wtc:param value="<%=inParamsss1[1]%>"/>	

	</wtc:service>	

  <wtc:array id="dcust" scope="end" />

<%

if(dcust.length>0) {

	offername=dcust[0][0];
	offercomments=dcust[0][1];

}


%>		



	var response = new AJAXPacket();

	response.data.add("offername","<%=offername%>");
	response.data.add("offercomments","<%=offercomments%>");
	core.ajax.receivePacket(response);