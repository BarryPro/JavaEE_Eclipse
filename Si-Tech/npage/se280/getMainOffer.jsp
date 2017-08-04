<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  //主资费
	String opCode = request.getParameter("opCode");
	String parentPhone = request.getParameter("parentPhone");
	String famCode = request.getParameter("famCode");
	String prodCode = request.getParameter("prodCode");
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
	
	/*
	String getSaleSql = "SELECT a.mode_code, a.mode_code || '--' || c.offer_name"
						 + " FROM dchnressaleplanmoderel a, dphonesalecode b, product_offer c"
						 +" WHERE a.sale_code = b.sale_code"
						  +" AND b.region_code = :regionCode"
						  +" AND b.sale_type = :saleType"
						  +" AND TRIM (a.mode_code) = TO_CHAR (c.offer_id)"
						  +" AND b.valid_flag = 'Y'"
						  +" AND a.sale_code = :saleCode";
				
	String[] inParams = new String[2];
	inParams[0] = getSaleSql;
	inParams[1] = "regionCode=" + regionCode+",saleType=" + saleType+",saleCode=" + saleCode;
	for(int i = 0; i < inParams.length; i++){
		System.out.println("=== getMainOffer.jsp === [" + inParams[i] + "]");
	}
	*/
%>

		<wtc:service name="sFamSelCheck" routerKey="region" 
			 routerValue="<%=regionCode%>"  retmsg="msg2" retcode="code2" outnum="3">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=parentPhone%>"/>
				<wtc:param value=""/>
				<wtc:param value="6"/>
				<wtc:param value="<%=famCode%>"/>
				<wtc:param value="<%=prodCode%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
		</wtc:service>
		<wtc:array id="result2" scope="end"/>
			
		<option value ="">--请选择--</option>
<%
System.out.println("getPhoneSale.jsp=====[" + code2 + "]" + result2.length);
	if("000000".equals(code2)){
		for(int i = 0; i < result2.length; i++){
%>
			<option value ="<%=result2[i][0]%>" ><%=result2[i][1]%></option>
			<script>
				//添加主资费
				var offerObj = {};
				offerObj.code = '<%=result2[i][0]%>';
				offerObj.name = '<%=result2[i][1]%>';
				offerObj.comment = '<%=result2[i][2]%>';
				mainOfferArray.push(offerObj);
			</script>
			
<%
		}
	}
%>