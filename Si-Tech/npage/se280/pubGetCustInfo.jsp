<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
	String idNo = "";
	String custId = "";
	String custName = "";
	String idICCID = "";
	String smName = "";
	String offerName = "";
	String offerComment = "";
	String offerId = "";
	String getCustInfoSql = "SELECT to_char(msg.ID_NO),msg.cust_id,doc.cust_name,doc.ID_ICCID,s.sm_name"+
	 		" FROM dcustmsg msg, dcustdoc doc, ssmcode s"+
	 		" WHERE msg.phone_no = :phoneNo AND msg.cust_id = doc.cust_id "+
	 		" AND msg.sm_code = s.sm_code AND SUBSTR (msg.belong_code, 1, 2) = s.region_code";
	 		
	String[] inParams = new String[2];
	inParams[0] = getCustInfoSql;
	inParams[1] = "phoneNo="+phoneNo;
	for(int i = 0;i < inParams.length; i++){
		System.out.println(" ----------- pubGetCustInfo ----- " + inParams[i]);
	}
%>
	<wtc:service name="TlsPubSelCrm" outnum="5" routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
		if(retCode.equals("000000")){
			if(result != null && result.length > 0){
				idNo = result[0][0];
				custId = result[0][1];
				custName = result[0][2];
				idICCID = result[0][3];
				smName = result[0][4];
			}
		}
	String getOfferCommentSql = "select b.offer_name,b.offer_comments,b.offer_id from product_offer_instance a, product_offer b "+
 				" where a.serv_id = :idNo and a.offer_id = b.offer_id and b.offer_type=10" + 
 				"and a.eff_date<=sysdate and a.exp_date>sysdate";

 	String[] inParams2 = new String[2];
	inParams2[0] = getOfferCommentSql;
	inParams2[1] = "idNo="+idNo;
%>
	<wtc:service name="TlsPubSelCrm" outnum="3" routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2">
		<wtc:param value="<%=inParams2[0]%>"/>
		<wtc:param value="<%=inParams2[1]%>"/>
	</wtc:service>
	<wtc:array id="result2" scope="end"/>
<%
	if(retCode2.equals("000000")){
		if(result2 != null && result2.length > 0){
			offerName = result2[0][0];
			offerComment = result2[0][1];
			offerId = result2[0][2];
		}
	}
	
%>

	var response = new AJAXPacket();
	response.data.add("retcode","<%=retCode%>");
	response.data.add("retmsg","<%=retMsg%>");
	response.data.add("idNo","<%=idNo%>");
	response.data.add("custId","<%=custId%>");
	response.data.add("custName","<%=custName%>");
	response.data.add("idICCID","<%=idICCID%>");
	response.data.add("smName","<%=smName%>");
	response.data.add("offerName","<%=offerName%>");
	response.data.add("offerComment","<%=offerComment%>");
	response.data.add("v_offerId","<%=offerId%>");
	core.ajax.receivePacket(response);