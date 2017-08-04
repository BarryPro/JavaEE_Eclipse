<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	//记录用户接受状态
	//接受参数
	String responseStatus = "0";//接受
	String loginAccept = request.getParameter("loginAccept")==null?"":request.getParameter("loginAccept");
	String regionCode = request.getParameter("regionCode")==null?"":request.getParameter("regionCode");
	regionCode="11";
	String login_no = request.getParameter("loginNo")==null?"":request.getParameter("loginNo");
	String svcNum=request.getParameter("svcNum")==null?"":request.getParameter("svcNum");
	String chanType = request.getParameter("chnType")==null?"":request.getParameter("chnType");
	String group_id=request.getParameter("groupId")==null?"":request.getParameter("groupId");
	String actId = request.getParameter("actId")==null?"":request.getParameter("actId");
	String idNo=request.getParameter("idNo")==null?"":request.getParameter("idNo");
	System.out.println("login_no=================="+login_no);
	System.out.println("regionCode=================="+regionCode);
	System.out.println("chanType=================="+chanType);
	System.out.println("svcNum=================="+svcNum);
	System.out.println("group_id=================="+group_id);
	System.out.println("actId=================="+actId);
	System.out.println("idNo=================="+idNo);
 %>
	 <s:service name="WsRecordResponseforhlj" >
	    <s:param  name="ROOT">
		     <s:param  name="REQUEST_INFO">
		     	<s:param name="LOGIN_ACCEPT" type="string" value="<%=loginAccept%>" />
		    	<s:param name="PHONE_NO" type="string" value="<%=svcNum%>" />
				<s:param name="LOGIN_NO" type="string" value="<%=login_no%>" />
				<s:param name="REGION_CODE" type="string" value="<%=regionCode %>" />
				<s:param name="CHN_TYPE" type="string" value="<%=chanType%>" />
				<s:param name="GROUP_ID" type="string" value="<%=group_id%>" />
				<s:param name="ACT_ID" type="string" value="<%=actId%>" />
				<s:param name="ID_NO" type="string" value="<%=idNo%>" />
				<s:param name="ACCEPT_FLAG" type="string" value="<%=responseStatus %>" />
		    </s:param>
	     </s:param>
	</s:service>

<%
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");	
%>
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
		response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
		core.ajax.receivePacket(response);
