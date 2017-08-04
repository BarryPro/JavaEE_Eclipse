<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	StringBuffer buf = new StringBuffer(80);
	String svcNum = request.getParameter("svcNum");
	String actId = request.getParameter("actId");
	String opCode = request.getParameter("opCode");
	String loginNo = (String)session.getAttribute("workNo");
	String actClass = request.getParameter("actClass"); 
	String reginCode = (String) session.getAttribute("regCode");//ÇøÓò
	String meanId = request.getParameter("meanId");
	String phoneNo =  (String)request.getParameter("phoneNo");
	System.out.println("((((((((((((((((((((()))))))))))))))))))))))):actClass:"+actClass+"||||reginCode:"+reginCode+"___phoneNo"+phoneNo);
	String paramValues = actId+"@@"+svcNum+"@@"+loginNo+"@@"+1+"@@"+actClass+"@@"+meanId;
 %>
<s:service name="WsMarketLimit">
	<s:param name="ROOT">
		 <s:param name="REQUEST_INFO">
			<s:param name="OP_CODE" type="string" value="<%=opCode %>" />
	 		<s:param name="PARAM_VALUES" type="string" value="<%=paramValues %>" />
		</s:param>
	</s:param>
</s:service>
<%
	String return_code = result.getString("RETURN_CODE");
	String return_msg = result.getString("RETURN_MSG");	
	buf.append(return_code).append("~").append(return_msg).append("~");
	if ("36".equals(actClass.trim())) {
%>
<s:service name="WsMktCheckCostControl">
	<s:param name="ROOT">
		 <s:param name="REQUEST_INFO">
	 		<s:param name="REGION_CODE" type="string" value="<%=reginCode %>" />
	 		<s:param name="ID_NO" type="string" value="<%=svcNum %>" />
		</s:param>
	</s:param>
</s:service>	
<%
  		String RETURN_CODE = result.getString("RETURN_CODE");	
		String RETURN_MSG = result.getString("RETURN_MSG");	
	 	buf.append(RETURN_CODE).append("~").append(RETURN_MSG);	
	}else{
		buf.append("0").append("~").append("³É¹¦"); 
	}
%>
<s:service name="sTrueNameWS_XML">
	<s:param name="ROOT">
 		<s:param name="LOGIN_NO" type="string" value="<%=loginNo %>" />
 		<s:param name="PHONE_NO" type="string" value="<%=phoneNo %>" />
 		<s:param name="CHN_TYPE" type="string" value="0" />
	</s:param>
</s:service>
<%
 	String reCode = result.getString("RETURN_CODE");	
	String reMsg = result.getString("RETURN_MSG");
	String oTrueCode = result.getString("oTrueCode");	
 	buf.append("~").append(reCode).append("~").append(reMsg).append("~").append(oTrueCode);	
	
	out.print(buf.toString());
%>	

