<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String brandCode = request.getParameter("brandCode");
	String saleType = request.getParameter("saleType");
	String typeCode = request.getParameter("typeCode");
	String familyProdCode = request.getParameter("familyProdCode");
	String getSaleSql = "select unique trim(a.sale_code),trim(a.sale_name),to_char(a.sale_price),"
					+" to_char(a.consume_term),to_char(a.prepay_limit),to_char(a.prepay_gift),to_char(a.consume_term) from dphoneSaleCode a,dbchnterm.dchnressaleplanactrelation b where a.region_code=:regionCode and a.sale_type=:saleType and a.valid_flag='Y'"
					+" and a.brand_code=:brandCode and a.type_code=:typeCode"
					+" and a.sale_code = b.sale_code ";
					if("1001".equals(familyProdCode)||"1002".equals(familyProdCode)||"1006".equals(familyProdCode))
					{
					getSaleSql = getSaleSql +"  and (a.sale_name like '%幸福家庭营销案%' or b.op_time>to_date('20130812','yyyymmdd'))";
					}
					else if("1015".equals(familyProdCode) || "1018".equals(familyProdCode)|| "1017".equals(familyProdCode))
						{
					getSaleSql = getSaleSql +" and (a.sale_name like '%新本地计划%' or b.op_time>to_date('20130812','yyyymmdd'))";
					 }
					else if("1016".equals(familyProdCode))
						{
					getSaleSql = getSaleSql +" and (a.sale_name like '%新省内计划%' or b.op_time>to_date('20130812','yyyymmdd'))";
					 }
					 else if("1019".equals(familyProdCode))
						{
					getSaleSql = getSaleSql +" and (a.sale_name like '%新本地计划%' or b.op_time>to_date('20130812','yyyymmdd'))";
					 }
	String[] inParams = new String[2];
	inParams[0] = getSaleSql;
	inParams[1] = "regionCode=" + regionCode + ",saleType=" + saleType 
							+ ",brandCode=" + brandCode +",typeCode=" + typeCode;
	System.out.println("=== getPhoneSale.jsp === [" + getSaleSql + "]");
%>

		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg2" retcode="code2" outnum="7">
			<wtc:param value="<%=inParams[0]%>"/>
			<wtc:param value="<%=inParams[1]%>"/>
		</wtc:service>
		<wtc:array id="result2" scope="end" />
			
		<option value ="">--请选择--</option>
<%
System.out.println("getPhoneSale.jsp=====[" + code2 + "]" + result2.length);
	if("000000".equals(code2)){
		for(int i = 0; i < result2.length; i++){
%>
			<option value ="<%=result2[i][0]%>" prepayfee="<%=result2[i][2]%>" consume="<%=result2[i][3]%>"  base_fee="<%=result2[i][4]%>" free_fee="<%=result2[i][5]%>"  active_term="<%=result2[i][6]%>"   ><%=result2[i][1]%></option>
<%
		}
	}
%>