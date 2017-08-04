<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String brandCode = request.getParameter("brand");
	String saleType = request.getParameter("saleType");
	String getResSql = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b " 
					+ " where a.region_code=:regionCode"
					+ " and  a.type_code=b.res_code and a.brand_code=b.brand_code " 
					+ " and a.sale_type=:saleType and a.valid_flag='Y' and b.brand_code=:brandCode";
	String[] inParams = new String[2];
	inParams[0] = getResSql;
	inParams[1] = "regionCode=" + regionCode + ",saleType=" + saleType +",brandCode=" + brandCode;
	System.out.println("===[" + getResSql + "]");
%>

		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg2" retcode="code2" outnum="3">
			<wtc:param value="<%=inParams[0]%>"/>
			<wtc:param value="<%=inParams[1]%>"/>
		</wtc:service>
		<wtc:array id="result2" scope="end" />
		
		<option value ="">--«Î—°‘Ò--</option>
<%
System.out.println("getRes.jsp=====[" + code2 + "]" + result2.length);
	if("000000".equals(code2)){
		for(int i = 0; i < result2.length; i++){
%>
			<option value="<%=result2[i][0]%>"><%=result2[i][1]%></option>
<%
		}
	}
%>