<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%

	String iLoginAccept = (String)request.getParameter("iLoginAccept");
	String iChnSource = (String)request.getParameter("iChnSource");
	String iOpCode = (String)request.getParameter("iOpCode");
	String iLoginNo = (String)request.getParameter("iLoginNo");
	String iLoginPwd = (String)request.getParameter("iLoginPwd");
	String iPhoneNo = (String)request.getParameter("iPhoneNo");
	String iUserPwd = (String)request.getParameter("iUserPwd");
	String iOfferStr = (String)request.getParameter("iOfferStr");
	System.out.println("||||||||||||||||||||||||========================================start");
	System.out.println("||||||||||||||||||||||||==================sMultiOffQryWS_XML========iLoginAccept="+iLoginAccept);
	System.out.println("||||||||||||||||||||||||==================sMultiOffQryWS_XML========iChnSource="+iChnSource);
	System.out.println("||||||||||||||||||||||||==================sMultiOffQryWS_XML========iOpCode="+iOpCode);
	System.out.println("||||||||||||||||||||||||==================sMultiOffQryWS_XML========iLoginNo="+iLoginNo);
	System.out.println("||||||||||||||||||||||||==================sMultiOffQryWS_XML========iLoginPwd="+iLoginPwd);
	System.out.println("||||||||||||||||||||||||==================sMultiOffQryWS_XML========iPhoneNo="+iPhoneNo);
	System.out.println("||||||||||||||||||||||||==================sMultiOffQryWS_XML========iUserPwd="+iUserPwd);
	System.out.println("||||||||||||||||||||||||==================sMultiOffQryWS_XML========iOfferStr="+iOfferStr);
 %>
	<s:service name="sMultiOffQryWS_XML">
		<s:param name="ROOT">
			<s:param name="iLoginAccept" type="string" value="<%=iLoginAccept %>" />
			<s:param name="iChnSource" type="string" value="<%=iChnSource%>" />
			<s:param name="iOpCode" type="string" value="<%=iOpCode %>" />
			<s:param name="iLoginNo" type="string" value="<%=iLoginNo%>" />
			<s:param name="iLoginPwd" type="string" value="<%=iLoginPwd%>" />
			<s:param name="iPhoneNo" type="string" value="<%=iPhoneNo%>" />
			<s:param name="iUserPwd" type="string" value="<%=iUserPwd %>" />
			<s:param name="iOfferStr" type="string" value="<%=iOfferStr %>" />
		</s:param>
	</s:service>
<%	
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");
	System.out.println("||||||||||||||||||||||||======sMultiOffQryWS_XML============RETURN_CODE==="+RETURN_CODE+"===RETURN_MSG="+RETURN_MSG);
	String feeCodeStr ="";
	String feeDescStr ="";
	String feeNoteStr = "";
	String split="";
	if("000000".equals(RETURN_CODE)){
		Map b = new HashMap();
		List felist = result.getList("OUT_DATA.FEE_INFO");
		for(int i =0;i<felist.size();i++){
			b = MapBean.isMap(felist.get(i));
			if(b==null) continue;
			String FEE_CODE= (String)b.get("FEE_CODE");
			String FEE_DESC= (String)b.get("FEE_DESC");
			feeCodeStr =  feeCodeStr + split + FEE_CODE;
			feeDescStr =  feeDescStr + split + FEE_DESC;
			split = "#";
		}
		feeNoteStr = result.getString("FEE_NOTE");	
		System.out.println("feeCodeStr:"+feeCodeStr+"------feeDescStr:"+feeDescStr);
		System.out.println("feeNoteStr:"+feeNoteStr);
		
	}
%>			
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","<%=RETURN_CODE%>"); 
		response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
		response.data.add("feeCodeStr","<%=feeCodeStr%>");
		response.data.add("feeDescStr","<%=feeDescStr%>");
		response.data.add("feeNoteStr","<%=feeNoteStr%>");
		core.ajax.receivePacket(response);
