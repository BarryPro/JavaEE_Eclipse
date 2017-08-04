<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%@ page import ="java.util.*" %>
<%
	String field_en_name = request.getParameter("field_en_name")==null?"":request.getParameter("field_en_name");
	String scoreValue = request.getParameter("scoreValue")==null?"":request.getParameter("scoreValue");
	
%>
	<s:service name="WsGetScoreDict" >
	    <s:param  name="ROOT">
		     <s:param  name="REQUEST_INFO">
				<s:param name="TABLE_EN_NAME" type="string" value="SCORE_RATE_DICT" />
				<s:param name="FIELD_EN_NAME" type="string" value="<%=field_en_name%>" />
		    </s:param>
	     </s:param>
	</s:service>
<%
	if ("0000".equals(retCode)) {
		String score_value = (String) result.getValue("OUT_DATA.SCOREVALUE");//服务返回的 积分抵消比率
		String money_value = (String) result.getValue("OUT_DATA.MONEYVALUE");//服务返回的 积分抵消单位值
		StringBuffer buf = new StringBuffer(80);
		System.out.println("score_value==="+score_value+"money_value=========="+money_value);
		buf.append(score_value).append(",").append(money_value);
		out.print(buf.toString());
	}
 %>



