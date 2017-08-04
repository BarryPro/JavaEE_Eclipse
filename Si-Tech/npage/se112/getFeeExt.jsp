<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String loginNo = (String)session.getAttribute("workNo");
	String password =(String)session.getAttribute("password");
	String powerRight= (String)session.getAttribute("powerRight");
	String idNo = request.getParameter("idNo");
	String modeCode = request.getParameter("modeCode");
	String feeCode = request.getParameter("feeCode");
	String belongCode = request.getParameter("belongCode");
	System.out.println("-------------------------s1270Must loginNo:==="+loginNo);
	System.out.println("-------------------------s1270Must idNo:==="+idNo);
	System.out.println("-------------------------s1270Must modeCode:==="+modeCode);
	System.out.println("-------------------------s1270Must feeCode:==="+feeCode);
	System.out.println("-------------------------s1270Must belongCode:==="+belongCode);
%>
   <s:service name="s1270Must">
		<s:param name="ROOT">
	 		<s:param name="LoginAccept" type="string" value="" />
	 		<s:param name="ChnSource" type="string" value="01" />
	 		<s:param name="OpCode" type="string" value="g794" />
	 		<s:param name="LoginNo" type="string" value="<%=loginNo %>" />
			<s:param name="LoginPwd" type="string" value="<%=password %>" />
	 		<s:param name="PhoneNo" type="string" value="" />
	 		<s:param name="UserPwd" type="string" value="" />
	 		<s:param name="LoginRight" type="string" value="<%=powerRight %>" />
	 		<s:param name="IdNo" type="string" value="<%=idNo %>" />
	 		<s:param name="OldMode" type="string" value="<%=modeCode %>" />
	 		<s:param name="NewMode" type="string" value="<%=feeCode %>" />
	 		<s:param name="BelongCode" type="string" value="<%=belongCode %>" />
		</s:param>
	</s:service>
<%	
	String feeExtCodes = "";
	String feeExtNames = "";
	String feeExtChoiced = "";
	String feeExtSendFlags = "";
	String feeExtSendFlagStrs = "";
	String feeExtStatusStrs = "";
	String feeExtInstStrs = "";
	String feeExtStartStrs = "";
	String split = "";
	List feeExts = result.getList("OUT_DATA.BUSI_INFO");
	if(!"N/A".equals(feeExts.get(0))){
		for(int i=0; i<feeExts.size(); i++){
			Map feeExtMap = MapBean.isMap(feeExts.get(i));
			if(feeExtMap != null){
				String code = feeExtMap.get("mode_code")== null?"":(String)feeExtMap.get("mode_code");
				String name = feeExtMap.get("ModeName")== null?"":(String)feeExtMap.get("ModeName");
				String choiced = feeExtMap.get("ModeChoiced")== null?"":(String)feeExtMap.get("ModeChoiced");
				String sendFlag = feeExtMap.get("SendFlag")== null?"":(String)feeExtMap.get("SendFlag");
				String sendFlagStr = feeExtMap.get("SendFlagName")== null?"":(String)feeExtMap.get("SendFlagName");
				String statusStr = feeExtMap.get("ModeStatus")== null?"":(String)feeExtMap.get("ModeStatus");
				String instId = feeExtMap.get("login_accept")== null?"":(String)feeExtMap.get("login_accept");
				String start = feeExtMap.get("begin_time")== null?"":(String)feeExtMap.get("begin_time");
				feeExtCodes += split + code;
				feeExtNames += split + name;
				feeExtChoiced += split + choiced;
				feeExtSendFlags += split + sendFlag;
				feeExtSendFlagStrs += split + sendFlagStr;
				feeExtStatusStrs += split + statusStr;
				feeExtInstStrs += split + instId;
				feeExtStartStrs += split + start;
				split = "@";
			}
		}
	}
	System.out.println("-------------------------s1270Must feeExtCodes:==="+feeExtCodes);
	System.out.println("-------------------------s1270Must feeExtNames:==="+feeExtNames);
	System.out.println("-------------------------s1270Must feeExtChoiced:==="+feeExtChoiced);
	System.out.println("-------------------------s1270Must feeExtSendFlags:==="+feeExtSendFlags);
	System.out.println("-------------------------s1270Must feeExtSendFlagStrs:==="+feeExtSendFlagStrs);
	System.out.println("-------------------------s1270Must feeExtStatusStrs:==="+feeExtStatusStrs);
	System.out.println("-------------------------s1270Must feeExtInstStrs:==="+feeExtInstStrs);
	System.out.println("-------------------------s1270Must feeExtStartStrs:==="+feeExtStartStrs);
%>			
	var response = new AJAXPacket();
	response.data.add("returnCode","<%=retCode%>");
	response.data.add("returnMsg","<%=retMsg%>");
	response.data.add("feeExtCodes","<%=feeExtCodes%>");
	response.data.add("feeExtNames","<%=feeExtNames%>");
	response.data.add("feeExtChoiced","<%=feeExtChoiced%>");
	response.data.add("feeExtSendFlags","<%=feeExtSendFlags%>");
	response.data.add("feeExtSendFlagStrs","<%=feeExtSendFlagStrs%>");
	response.data.add("feeExtStatusStrs","<%=feeExtStatusStrs%>");
	response.data.add("feeExtInstStrs","<%=feeExtInstStrs%>");
	response.data.add("feeExtStartStrs","<%=feeExtStartStrs%>");
	core.ajax.receivePacket(response);
