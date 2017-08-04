<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%
	String loginNo = (String)session.getAttribute("workNo");
	String password =(String)session.getAttribute("password");
	DateFormat df = new SimpleDateFormat("yyyyMMdd");
	String today = df.format(new Date());
	String feeCodes = request.getParameter("feeCodes");
	String effTimes = request.getParameter("effTimes");
%>
   <s:service name="sDateFollowQryWS_XML">
		<s:param name="ROOT">
	 		<s:param name="LOGIN_ACCEPT" type="string" value="0" />
	 		<s:param name="CHN_SOURCE" type="string" value="01" />
	 		<s:param name="OP_CODE" type="string" value="g794" />
	 		<s:param name="LOGIN_NO" type="string" value="<%=loginNo %>" />
			<s:param name="LOGIN_PWD" type="string" value="<%=password %>" />
	 		<s:param name="PHONE_NO" type="string" value="" />
	 		<s:param name="PHONE_PWD" type="string" value="" />
	 		<s:param name="SET_TYPE" type="string" value="1" />
	 		<s:param name="START_DATE" type="string" value="<%=today %>" />
	 		<s:param name="FEE_CODES" type="string" value="<%=feeCodes %>" />
	 		<s:param name="EFF_TIMES" type="string" value="<%=effTimes %>" />
		</s:param>
	</s:service>
<%	
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");
	String effDateStr ="";
	String expDateStr ="";
	String split="";
	List timeList = result.getList("OFFER_TIME.TIME_INFO");
	if(!"N/A".equals(timeList)){
		for(int i=0; i<timeList.size(); i++){
			Map timeInfo = MapBean.isMap(timeList.get(i));
			if(timeInfo == null) continue;
			String effTime = timeInfo.get("EFF_DATE").toString();
			String expTime = timeInfo.get("EXP_DATE").toString();
			effDateStr =  effDateStr + split + effTime;
			expDateStr =  expDateStr + split + expTime;
			split = "#";			
		}
	}
%>			
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	response.data.add("effDateStr","<%=effDateStr%>");
	response.data.add("expDateStr","<%=expDateStr%>");
	core.ajax.receivePacket(response);
