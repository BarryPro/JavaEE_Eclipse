<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-9-6 TD固话重新购机
     *
     ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode = WtcUtil.repStr(request.getParameter("regionCode"), "");
	String saleType = WtcUtil.repStr(request.getParameter("saleType"), "");
	String saleCode = WtcUtil.repStr(request.getParameter("saleCode"), "");
	
	System.out.println("===========wanghfa========= regionCode = " + regionCode);
	System.out.println("===========wanghfa========= saleType = " + saleType);
	System.out.println("===========wanghfa========= saleCode = " + saleCode);
	
	//营销明细
	String sqlSale = "select to_char(to_number(sale_price)-to_number(prepay_gift)-to_number(prepay_limit)),prepay_gift,consume_term,prepay_limit,to_char(active_term),mon_base_fee,all_gift_price,sale_price,trim(sale_code),market_price from dphoneSaleCode  where region_code='" + regionCode + "' and sale_type='" + saleType + "' and valid_flag='Y'";
	String[] inParamS = new String[2];
	inParamS[0] = "select to_char(to_number(sale_price)-to_number(prepay_gift)-to_number(prepay_limit)),prepay_gift,consume_term,prepay_limit,to_char(active_term),mon_base_fee,all_gift_price,sale_price,trim(sale_code),market_price from dphoneSaleCode where region_code=:region_code and sale_type='" + saleType + "' and valid_flag='Y'";
	inParamS[1] = "region_code=" + regionCode;
	System.out.println("===========wanghfa========= 营销明细sql = " + sqlSale);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCodeS" retmsg="retMsgS" outnum="12">
	<wtc:param value="<%=inParamS[0]%>"/>
	<wtc:param value="<%=inParamS[1]%>"/>
	</wtc:service>
	<wtc:array id="resultS"  scope="end"/>
	
<%
	System.out.println("===========wanghfa========= retCodeS = " + retCodeS);
	System.out.println("===========wanghfa========= retMsgS = " + retMsgS);
	if ("000000".equals(retCodeS) && resultS.length != 0) {
%>
		var salePhone = "";
		var saleBase = "";
		var saleConsumeTerm = "";
		var saleFree = "";
		var saleActiveTerm = "";
		var saleMonBase = "";
		var saleAllGiftPrice = "";
		var saleSalePrice = "";
		var saleCode = "";
		var saleMarketPrice = "";
<%
		for (int i = 0; i < resultS.length; i ++) {
			System.out.println("=wanghfa= Sale = " + i + " phone = " + resultS[i][0] + "," + resultS[i][1] + "," + resultS[i][2] + "," + resultS[i][3] + "," + resultS[i][4] + "," + resultS[i][5] + "," + resultS[i][6] + "," + resultS[i][7] + "," + resultS[i][8] + "," + resultS[i][9]);
			if (saleCode.equals(resultS[i][8])) {
				System.out.println("===========wanghfa=================== Sale this = " + i);
%>
				salePhone = "<%=resultS[i][0]%>";
				saleBase = "<%=resultS[i][1]%>";
				saleConsumeTerm = "<%=resultS[i][2]%>";
				saleFree = "<%=resultS[i][3]%>";
				saleActiveTerm = "<%=resultS[i][4]%>";
				saleMonBase = "<%=resultS[i][5]%>";
				saleAllGiftPrice = "<%=resultS[i][6]%>";
				saleSalePrice = "<%=resultS[i][7]%>";
				saleCode = "<%=resultS[i][8]%>";
				saleMarketPrice = "<%=resultS[i][9]%>";
<%
			}
		}
	} else {
		System.out.println("===========wanghfa========= Sale 无信息");
		//查询TD固话型号信息错误
	}
%>

var response = new AJAXPacket();
response.data.add("salePhone", salePhone);
response.data.add("saleBase", saleBase);
response.data.add("saleConsumeTerm", saleConsumeTerm);
response.data.add("saleFree", saleFree);
response.data.add("saleActiveTerm", saleActiveTerm);
response.data.add("saleMonBase", saleMonBase);
response.data.add("saleAllGiftPrice", saleAllGiftPrice);
response.data.add("saleSalePrice", saleSalePrice);
response.data.add("saleCode", saleCode);
response.data.add("saleMarketPrice", saleMarketPrice);

core.ajax.receivePacket(response);
