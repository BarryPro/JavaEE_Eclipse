<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	StringBuffer buf = new StringBuffer(80);
	String group_id = (String)session.getAttribute("groupId");
	String login_no = (String)session.getAttribute("workNo");
	String phone_no = (String)request.getParameter("phoneNo");
	String saleSeq = (String)request.getParameter("saleSeq");
	String opCode = (String)request.getParameter("opCode");
	System.out.println("++++++++++++++++++++++g795 opCode="+opCode);
	//调服务 解析返回值
%>

<s:service name="sMKTGetUsrInf">
	<s:param name="ROOT">
		<s:param name="PHONE_NO" type="string" value="<%=phone_no%>" />
	</s:param>
</s:service>
<%
	Map UserInfoMap = null;

	if ("0".equals(retCode) && result != null) {
		com.sitech.crmpd.core.bean.MapBean mp = new com.sitech.crmpd.core.bean.MapBean();
		List actions = result.getList("OUT_DATA.USER_INFO");
		HashMap map = new HashMap();
		if (null != actions) {
			Iterator itr = actions.iterator();
			while (itr.hasNext()) {
				UserInfoMap = mp.isMap(itr.next());
			}
		}
	}

	String vCurPoint = (String) UserInfoMap.get("ELEMENT36")==null?"":(String) UserInfoMap.get("ELEMENT36");;//当前积分//WsGetMeansList
	System.out.println("&&&&&&&&&&&&&&&&&&&&&&当前积分："+vCurPoint);
	
%>
<s:service name="WsGetActInfoMessage">
	<s:param name="ROOT">
		 <s:param name="REQUEST_INFO">
	 		<s:param name="ORDER_ID" type="string" value="<%=saleSeq%>" />
	 		<s:param name="CUR_POINT" type="string" value="<%=vCurPoint%>" />
		</s:param>
	</s:param>
  </s:service>
<%
  String return_code = result.getString("RETURN_CODE");	
	String return_msg = result.getString("RETURN_MSG");		
	String actId = result.getString("OUT_DATA.ACT_ID");
	String meansId = result.getString("OUT_DATA.MEANS_ID");
	System.out.println("actid=============================="+actId);
	buf.append(return_code).append("~").append(return_msg).append("~");
%>
	

<s:service name="sMarketOrderWS_XML">
	<s:param name="ROOT">
		 <s:param name="REQUEST_INFO">
	 		<s:param name="PHONE_NO" type="string" value="<%=phone_no %>" />
			<s:param name="LOGIN_NO" type="string" value="<%=login_no %>" />
			<s:param name="ACTIVE_NO" type="string" value="<%=meansId %>" />
			<s:param name="OPR_CODE" type="string" value="2" />
	 		<s:param name="PLAYER_CODE " type="string" value="0" />
			<s:param name="FLAG" type="string" value="0" />
			<s:param name="BUSI_ID" type="string" value="<%=saleSeq %>" />
		</s:param>
	</s:param>
</s:service>	
<%
  String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");	
	buf.append(RETURN_CODE).append("~").append(RETURN_MSG).append("~");	
%>


<s:service name="WsMktCheckChnCancel">
	<s:param name="ROOT">
		 <s:param name="REQUEST_INFO">
	 		<s:param name="GROUP_ID" type="string" value="<%=group_id %>" />
			<s:param name="ORDER_ID" type="string" value="<%=saleSeq %>" />
			<s:param name="OP_CODE" type="string" value="<%=opCode %>" />
		</s:param>
	</s:param>
</s:service>	
<%
  	String RE_CODE = result.getString("RETURN_CODE");	
	String RE_MSG = result.getString("RETURN_MSG");	
	buf.append(RE_CODE).append("~").append(RE_MSG);	
	out.print(buf.toString());
%>

