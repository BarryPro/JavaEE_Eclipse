<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String loginNo = (String)session.getAttribute("login_no");

	String returnCode = "000000";
	String returnMsg = "";
	String memberNo = request.getParameter("memberNo");
	String memType = request.getParameter("memType");
	String operType =  request.getParameter("operType");
	System.out.println("||||||||||||||||||||||||========================================memberNo"+memberNo);
	System.out.println("||||||||||||||||||||||||========================================memType"+memType);
	System.out.println("||||||||||||||||||||||||========================================operType"+operType);
	String idNo = "";
	String custId = "";
	String belongCode = "";
	String smCode = "";
	String modeCode = "";
	if("B".equals(memType)){
%>
	<s:service name="sQryBroadInfoWS_XML">
		<s:param name="ROOT">
		<s:param name="LOGIN_ACCEPT " type="string" value="0" />
		<s:param name="CHN_CODE " type="string" value="0" />
		<s:param name="OP_CODE " type="string" value="g794" />
		<s:param name="LOGIN_NO " type="string" value="" />
		<s:param name="LOGIN_PWD " type="string" value="" />
		<s:param name="PHONE_NO " type="string" value="" />
		<s:param name="USER_PWD " type="string" value="" />
		<s:param name="BD_CODE " type="string" value="<%=memberNo %>" />
		<s:param name="OPER_TYPE " type="string" value="<%=operType %>" />
		</s:param>
	</s:service>
<%		
		returnCode = retCode; 
		returnMsg = retMsg;
		memberNo = result.getString("OUT_DATA.PHONE_NO");
		idNo = result.getString("OUT_DATA.ID_NO");
		custId = result.getString("OUT_DATA.CUST_ID");
		belongCode = result.getString("OUT_DATA.GROUP_ID");
		smCode = result.getString("OUT_DATA.SM_CODE");
	}else{
 %>
	<s:service name="sMKTGetUsrInf">
		<s:param name="ROOT">
			<s:param name="PHONE_NO" type="string" value="<%=memberNo %>" />
		</s:param>
	</s:service>
<%	
		returnMsg = retMsg;
		idNo = result.getString("OUT_DATA.USER_INFO.ELEMENT0");
		custId = result.getString("OUT_DATA.USER_INFO.ELEMENT1");
		belongCode = result.getString("OUT_DATA.USER_INFO.ELEMENT27");
		smCode = result.getString("OUT_DATA.USER_INFO.ELEMENT4");
		modeCode = result.getString("OUT_DATA.USER_INFO.ELEMENT31");
		if(idNo == null || "N/A".equals(idNo)){
			returnCode = "999999";
		}
	}
	System.out.println("||||||||||||||||||||||||========================================memberNo"+memberNo);
	System.out.println("||||||||||||||||||||||||========================================idNo"+idNo);
	System.out.println("||||||||||||||||||||||||========================================custId"+custId);
	System.out.println("||||||||||||||||||||||||========================================belongCode"+belongCode);
	System.out.println("||||||||||||||||||||||||========================================smCode"+smCode);
%>			
	var response = new AJAXPacket();
	response.data.add("returnCode","<%=returnCode%>");
	response.data.add("returnMsg","<%=returnMsg%>");
	response.data.add("memberNo","<%=memberNo%>");
	response.data.add("idNo","<%=idNo%>");
	response.data.add("custId","<%=custId%>");
	response.data.add("belongCode","<%=belongCode%>");
	response.data.add("smCode","<%=smCode%>");
	response.data.add("modeCode","<%=modeCode%>");
	core.ajax.receivePacket(response);
