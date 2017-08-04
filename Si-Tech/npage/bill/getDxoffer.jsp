<%@ page contentType= "text/html;charset=gb2312" %>
 <%@ page import="java.math.BigDecimal"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String loginPwd  = (String)session.getAttribute("password");//µÇÂ½ÃÜÂë
		String groupId  = (String)session.getAttribute("groupId");
		String sale_code = request.getParameter("sale_code");
		String strArray = "var arrMsg; ";

	String[] inParamE = new String[2];
	inParamE[0] = "select a.mode_code,a.mode_code||'--'||c.offer_name,b.base_fee from dChnResSalePlanModeRel a , dphoneSaleCode b,product_offer c where c.offer_type=40 and a.sale_code=b.sale_code and b.region_code=:region_code and a.sale_code=:salecode and b.sale_type='12' and c.exp_date>sysdate and trim(a.mode_code) = to_char(c.offer_id) and b.valid_flag ='Y'";
	inParamE[1] = "region_code="+regionCode+",salecode="+sale_code;
	
	System.out.println("sdeeee"+inParamE[0]+""+inParamE[1]);
%>
		<wtc:service name="TlsPubSelCrm" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParamE[0]%>"/>
			<wtc:param value="<%=inParamE[1]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end" />
<%		
 if( result.length > 0) {
			strArray = WtcUtil.createArray("arrMsg",result.length);	
	}
	
%>
<%=strArray%>
	<%

		for(int i = 0 ; i < result.length ; i ++){
      for(int j = 0 ; j < result[i].length ; j ++){
      	if(result[i][j].trim().equals("") || result[i][j] == null){
				   result[i][j] = "";
				}
	%>
				arrMsg[<%=i%>][<%=j%>] = "<%=result[i][j].trim()%>";
	<%
			}
		}
	
	%>
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode %>");
		response.data.add("retmsg","<%= retMsg %>");
		response.data.add("result",arrMsg);
		core.ajax.receivePacket(response);		