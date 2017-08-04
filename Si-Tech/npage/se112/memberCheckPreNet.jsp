<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%
	String loginNo = (String)session.getAttribute("workNo");
	String svcNum = request.getParameter("svcNum");
	String netCode = request.getParameter("netCode");
	String actType = request.getParameter("actType");
	String netFee = request.getParameter("netFee");
	String netScoreMoney = request.getParameter("netScoreMoney");
	System.out.println("-------------------------sYXKDCheck_XML svcNum:==="+svcNum);
	System.out.println("-------------------------sYXKDCheck_XML netCode:==="+netCode);
	System.out.println("-------------------------sYXKDCheck_XML actType:==="+actType);
	System.out.println("-------------------------sYXKDCheck_XML netFee:==="+netFee);
	System.out.println("-------------------------sYXKDCheck_XML login_no:==="+loginNo);
	System.out.println("-------------------------sYXKDCheck_XML netScoreMoney:==="+netScoreMoney);
 %>
<s:service name="sYXKDCheck_XML">
	<s:param name="ROOT">
		<s:param name="LOGIN_ACCEPT " type="string" value="0" />
		<s:param name="CHN_CODE " type="string" value="0" />
		<s:param name="OP_CODE " type="string" value="g794" />
		<s:param name="LOGIN_NO " type="string" value="<%=loginNo %>" />
		<s:param name="LOGIN_PWD " type="string" value="" />
		<s:param name="PHONE_NO " type="string" value="<%=svcNum %>" />
		<s:param name="USER_PWD " type="string" value="<%=netScoreMoney %>" />
		<s:param name="BD_CODE " type="string" value="<%=netCode %>" />
		<s:param name="BD_FEE " type="string" value="<%=netFee %>" />
		<s:param name="ACT_CLASS " type="string" value="<%=actType %>" />
	</s:param>
</s:service>

<%
	String returnCode = result.getString("RETURN_CODE");	
	String returnMsg = result.getString("RETURN_MSG");	
	String netFlag = result.getString("OUT_DATA.BD_FLAG").trim();
	String effDate = result.getString("OUT_DATA.EFF_DATE").trim();
	String expDate = result.getString("OUT_DATA.EXP_DATE").trim();
	/* returnCode = "000000";
	effDate = "20131001000000";
	expDate = "20141001000000"; */
	System.out.println("-------------------------sYXKDCheck_XML RETURN_CODE:==="+returnCode);
	System.out.println("-------------------------sYXKDCheck_XML RETURN_MSG:==="+returnMsg);
	System.out.println("-------------------------sYXKDCheck_XML netFlag:==="+netFlag);
	System.out.println("-------------------------sYXKDCheck_XML effDate:==="+effDate);
	System.out.println("-------------------------sYXKDCheck_XML expDate:==="+expDate);
	if("000000".equals(returnCode) && "5".equals(netFlag)){
		DateFormat indf = new SimpleDateFormat("yyyyMMddHHmmss");
		DateFormat outdf = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
		Date effectDate = indf.parse(effDate);
		Date expertDate = indf.parse(expDate);
		effDate = outdf.format(effectDate);
		expDate = outdf.format(expertDate);
	}
	System.out.println("-------------------------sYXKDCheck_XML effDate×ª»»:==="+effDate);
	System.out.println("-------------------------sYXKDCheck_XML expDate×ª»»:==="+expDate);
	
%>
	var response = new AJAXPacket();
	response.data.add("returnCode","<%=returnCode %>");
	response.data.add("returnMsg","<%=returnMsg %>");
	response.data.add("netFlag","<%=netFlag %>");
	response.data.add("effDate","<%=effDate %>");
	response.data.add("expDate","<%=expDate %>");
	core.ajax.receivePacket(response);
