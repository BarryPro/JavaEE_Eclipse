<%@ page contentType= "text/html;charset=gb2312" %>
 <%@ page import="java.math.BigDecimal"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String sale_type = request.getParameter("sale_type");//定值：54
	String method = request.getParameter("method");
	String brand_code = request.getParameter("brand_code");//手机品牌

	//通过手机品牌获得手机型号
	if(method != null && method != "" && method.equals("apply_getPhoneTypes")) {
     //lj. 绑定参数
     String sql_select1 = "SELECT UNIQUE b.res_code, TRIM (b.res_name) FROM dphonesalecode a, dbchnterm.schnrescode b WHERE a.region_code = :region_code and a.type_code=b.res_code  AND a.brand_code = b.brand_code AND a.valid_flag = 'Y' AND a.sale_type = :sale_type ";
  	 //String sql_select1 = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b  where a.region_code=:region_code and  a.type_code=b.res_code and a.brand_code=b.brand_code  and a.sale_type=:sale_type and a.valid_flag='Y' ";
  	 String srv_params1 = "region_code=" + regionCode + ",sale_type=" + sale_type ;
  	 if(!"all".equals(brand_code)){
  	   sql_select1 = sql_select1 + " and b.brand_code=:brand_code";
  	   srv_params1 = srv_params1+ ",brand_code=" + brand_code;
  	 }
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="3" >
			<wtc:param value="<%=sql_select1%>"/>
			<wtc:param value="<%=srv_params1%>"/>
		</wtc:service>
		<wtc:array id="phone_type" scope="end" />
		var array = [];
<%
	  if(retCode.equals("000000")) {
			//封装js数组
			for(int i=0;i<phone_type.length;i++) 
			{
		%>
					var type = {};
					type.value = '<%=phone_type[i][0]%>';
				  type.name = '<%=phone_type[i][1]%>';
				  array.push(type);
		<%
			}
	 }	
%>
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode %>");
		response.data.add("retmsg","<%= retMsg %>");
		response.data.add("result",array);
		core.ajax.receivePacket(response);
<%
  }
%>