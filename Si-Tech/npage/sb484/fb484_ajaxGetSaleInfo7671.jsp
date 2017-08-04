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
	String sqlsaledet = "select sale_price,sale_price-prepay_gift-prepay_limit,base_fee*consume_term,free_fee,consume_term,prepay_limit,active_term,sale_code from dphoneSaleCode  where region_code='" + regionCode + "' and sale_type='" + saleType + "' and valid_flag='Y'";
	System.out.println("===========wanghfa========= 7671营销明细sql = " + sqlsaledet);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="8" retcode="retCodeS" retmsg="retMsgS">
		<wtc:sql><%=sqlsaledet%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultS" scope="end" />
	
<%
	System.out.println("===========wanghfa========= retCodeS = " + retCodeS);
	System.out.println("===========wanghfa========= retMsgS = " + retMsgS);
	if ("000000".equals(retCodeS) && resultS.length != 0) {
%>
		var Sale_Price;
		var Price;
		var Base_Fee2;
		var Free_Fee2;
		var Consume_Term2;
		var Phone_Fee;
		var Active_Term2;
		var saleCode;
<%
		for (int i = 0; i < resultS.length; i ++) {
			System.out.println("=wanghfa= Sale Sale_Price = " + resultS[i][0] + "Price = " + resultS[i][1] + "Base_Fee2 = " + resultS[i][2] + "Free_Fee2 = " + resultS[i][3] + "Consume_Term2 = " + resultS[i][4] + "Phone_Fee = " + resultS[i][5] + "Active_Term2 = " + resultS[i][6] + "saleCode = " + resultS[i][7]);
			if (saleCode.equals(resultS[i][7])) {
				System.out.println("===========wanghfa=================== Sale this = " + i);
%>
				Sale_Price = "<%=resultS[i][0]%>";
				Price = "<%=resultS[i][1]%>";
				Base_Fee2 = "<%=resultS[i][2]%>";
				Free_Fee2 = "<%=resultS[i][3]%>";
				Consume_Term2 = "<%=resultS[i][4]%>";
				Phone_Fee = "<%=resultS[i][5]%>";
				Active_Term2 = "<%=resultS[i][6]%>";
				saleCode = "<%=resultS[i][7]%>";
<%
			}
		}
	} else {
		System.out.println("===========wanghfa========= Sale 无信息");
		//查询TD固话型号信息错误
	}
%>

var response = new AJAXPacket();
response.data.add("Sale_Price", Sale_Price);
response.data.add("Price", Price);
response.data.add("Base_Fee2", Base_Fee2);
response.data.add("Free_Fee2", Free_Fee2);
response.data.add("Consume_Term2", Consume_Term2);
response.data.add("Phone_Fee", Phone_Fee);
response.data.add("Active_Term2", Active_Term2);
response.data.add("saleCode", saleCode);

core.ajax.receivePacket(response);
