<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%

	String iChnSource = (String)request.getParameter("iChnSource");
	String iLoginNo = (String)request.getParameter("iLoginNo");
	String iLoginPWD = (String)request.getParameter("iLoginPWD");
	String iPhoneNo = (String)request.getParameter("iPhoneNo");
	String iOprAccept = (String)request.getParameter("iOprAccept");
	String netFlag = (String)request.getParameter("netFlag");
	System.out.println("||||||||||||||||||||||||========================================start");
	System.out.println("||||||||||||||||||||||||========================================"+iChnSource);
	System.out.println("||||||||||||||||||||||||========================================"+iLoginNo);
	System.out.println("||||||||||||||||||||||||========================================"+iLoginPWD);
	System.out.println("||||||||||||||||||||||||========================================"+iPhoneNo);
	System.out.println("||||||||||||||||||||||||========================================"+iOprAccept);
	System.out.println("||||||||||||||||||||||||=netFlag======================================="+netFlag);

if(!"Y".equals(netFlag)){
		
		
 %>
	<s:service name="sg511QryWS_XML">
		<s:param name="ROOT">
			<s:param name="iLoginAccept" type="string" value="" />
			<s:param name="iChnSource" type="string" value="<%=iChnSource%>" />
			<s:param name="iOpCode" type="string" value="g794" />
			<s:param name="iLoginNo" type="string" value="<%=iLoginNo%>" />
			<s:param name="iLoginPWD" type="string" value="<%=iLoginPWD%>" />
			<s:param name="iPhoneNo" type="string" value="<%=iPhoneNo%>" />
			<s:param name="iUserPwd" type="string" value="" />
		</s:param>
	</s:service>
<%	
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");
	System.out.println("||||||||||||||||||||||||========================================"+RETURN_CODE+"~~~"+RETURN_MSG);
	String spIdStr ="";
	String bizCodeStr ="";
	String split="";
	if("000000".equals(RETURN_CODE)){
		Map b = new HashMap();
		List felist = result.getList("OUT_DATA.SP_LIST.SP_INFO");
		for(int i =0;i<felist.size();i++){
			b = MapBean.isMap(felist.get(i));
			if(b==null) continue;
			String SP_ID= (String)b.get("SP_ID");
			String BIZ_CODE= (String)b.get("BIZ_CODE");
			spIdStr =  spIdStr + split + SP_ID;
			bizCodeStr =  bizCodeStr + split + BIZ_CODE;
			split = "#";
		}
		System.out.println("spIdStr:"+spIdStr+"------bizCodeStr:"+bizCodeStr);
		
	}
%>	
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
		response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
		
		response.data.add("spIdStr","<%=spIdStr%>");
		response.data.add("bizCodeStr","<%=bizCodeStr%>");
		core.ajax.receivePacket(response);	
<%	
}else{
%>
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","000000");
		response.data.add("RETURN_MSG","");
		
		response.data.add("spIdStr","");
		response.data.add("bizCodeStr","");
		core.ajax.receivePacket(response);	
<%
}

%>

