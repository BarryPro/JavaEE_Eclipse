<%
    /*************************************
    * 功  能: e224
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: gaopeng @ 2015/12/25 10:38:48
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("gaopengSeeLog===e224====");
		
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String workNo = (String)session.getAttribute("workNo");
		String password = (String) session.getAttribute("password");
		String opCode = request.getParameter("opCode");
		String groupId = (String)session.getAttribute("groupId");
		String regCode = (String)session.getAttribute("regCode");
		String accountType =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");//1 为营业工号 2 为客服工号
		
		String countryCode = request.getParameter("countryCode");
		String dayNum = request.getParameter("dayNum");
		
		String retCode11 = "";
		String retMsg11 = "";
		
		String offerId = "";
		String offerName = "";
		String offerFee = "";
		
		 String  inParamsGetOffer [] = new String[2];
		 if("2".equals(accountType)){
		 
		 
				 inParamsGetOffer[0] = 
				 " select b.offer_id, b.offer_name, c.offer_attr_value									"
				+" from pd_unicodedef_dict a,                                         "
				+"      product_offer      b,                                         "
				+"      product_offer_attr c,                                         "
				+"      region             m                                          "
				+" where 1 = 1 "
				+"  and to_number(trim(a.code_value)) = b.offer_id"
				+"  and b.offer_id = c.offer_id"
				+"  and sysdate between b.eff_date and b.exp_date"
				+"  and m.offer_id = b.offer_id"
				+"  and m.group_id in (SELECT e.parent_group_id"
				+"                       FROM dchngroupinfo e, dcustmsg f"
				+"                      WHERE e.group_id = f.group_id"
				+"                        AND f.phone_no =:phoneNo)"
				+"  and to_number(m.right_limit) <="
				+"      (select power_right from dloginmsg WHERE LOGIN_NO =:workNo) "
				+"  and a.code_class = 'CODE02'"
				+"  and a.code_id =:countryCode"
				+"  and a.popedom_code = to_number(:dayNum)"
				+"  and c.offer_attr_seq = 50003";
				inParamsGetOffer[1] = "phoneNo="+phoneNo+",workNo="+workNo+",countryCode="+countryCode+",dayNum="+dayNum;
		}else {
			inParamsGetOffer[0] = 
		 "select b.offer_id, b.offer_name, c.offer_attr_value"	
		+"  from pd_unicodedef_dict a,"
		+"       product_offer      b,"
		+"       product_offer_attr c,"
		+"       region             m "
		+" where 1 = 1 "
		+"   and to_number(trim(a.code_value)) = b.offer_id"
		+"   and b.offer_id = c.offer_id"
		+"   and sysdate between b.eff_date and b.exp_date"
		+"   and m.offer_id = b.offer_id"
		+"   and m.group_id in (select e.parent_group_id"
		+"                        from dChnGroupinfo e, dloginmsg f"
		+"                       where e.group_id = f.group_id"
		+"                         and f.login_no =:workNo1)"
		+"   and to_number(m.right_limit) <="
		+"       (select power_right from dloginmsg WHERE LOGIN_NO =:workNo2) "
		+"   and a.code_class = 'CODE02'"
		+"   and a.code_id =:countryCode "
		+"   and a.popedom_code =to_number(:dayNum) "
		+"   and c.offer_attr_seq = 50003";
	
	
		 inParamsGetOffer[1] = "workNo1="+workNo+",workNo2="+workNo+",countryCode="+countryCode+",dayNum="+dayNum;
		
			
		}
	
	
		 
		
		try{
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

 <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="3"> 
    <wtc:param value="<%=inParamsGetOffer[0]%>"/>
    <wtc:param value="<%=inParamsGetOffer[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_GetOffer"  scope="end"/>

<%
	
	retCode11 = retCode;
	retMsg11 = retMsg;
	System.out.println("gaopengSeeLog===e224====retCode==="+retCode);
	
	 if(result_GetOffer.length == 0){
	 	retCode11 = "e22499";
	 	retMsg11 = "未查询到可办理资费！";
	 }
	 if(result_GetOffer.length > 0 && "000000".equals(retCode)){
	 
	 	offerId = result_GetOffer[0][0];
	 	offerName = result_GetOffer[0][1];
	 	offerFee = result_GetOffer[0][2];
		
	 }

}catch(Exception e){
	e.printStackTrace();
	retCode11 = "444444";
	retMsg11 = "服务未启动或不正常，请联系管理员！";
}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11%>");
response.data.add("retMsg","<%=retMsg11%>");
response.data.add("offerId","<%=offerId%>");
response.data.add("offerName","<%=offerName%>");
response.data.add("offerFee","<%=offerFee%>");
core.ajax.receivePacket(response);
