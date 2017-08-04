<%
    /********************
     	version v2.0
     	开发商: si-tech
			*
			*update:zhanghonga@2008-09-18 页面改造,修改样式
			*
     ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
    String verifyType = request.getParameter("verifyType");
		String org_code = (String)session.getAttribute("orgCode");
		String flag_code = request.getParameter("flag_code");          //flag_code
		String region_code = org_code.substring(0,2);          //region_code
		String flag_code_name="";
		String rate_code="";
		String errCode="",errMsg="";
    String sqlRateCode = "";  

    sqlRateCode = "select flag_code_name,rate_code from sRateFlagCode where region_code='" + region_code + "' and flag_code= '" + flag_code + "'";
		System.out.println("sqlRateCode======"+sqlRateCode);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  outnum="2">
		<wtc:sql><%=sqlRateCode%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="rateCodeStr" scope="end" />
<%	    
    for(int i=0;i<rateCodeStr.length;i++){
      flag_code_name = rateCodeStr[0][0];
      rate_code = rateCodeStr[0][1];
		}

    if((flag_code.trim()).equals("") || (rate_code.trim()).equals("") ){
	   	errCode="000000";
	  	errMsg="success";
    }else{
      errCode="000000";
	  	errMsg="success";
    }

%>
  var response = new AJAXPacket();
  response.data.add("verifyType","<%= verifyType %>");
  response.data.add("errorCode","<%= errCode %>");
  response.data.add("errorMsg","<%= errMsg %>");
  response.data.add("flag_code","<%= flag_code %>");
  response.data.add("flag_code_name","<%= flag_code_name %>");
  response.data.add("rate_code","<%= rate_code %>");
  core.ajax.receivePacket(response);
