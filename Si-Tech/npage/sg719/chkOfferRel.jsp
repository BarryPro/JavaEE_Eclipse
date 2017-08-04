<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
		String[] offerIdArr=request.getParameter("offerIdArr").split(",");//销售品标识
System.out.println("==========1"+request.getParameter("offerIdArr"));		
		String[] pordIdArr=request.getParameter("pordIdArr").split(",");//产品标识
System.out.println("==========2"+request.getParameter("pordIdArr"));			
		String[] prodNameArr=request.getParameter("prodNameArr").split(",");//产品名称
		String[] offerNameArr=request.getParameter("offerNameArr").split(",");//销售品名称
		String retrunCode="";
		String returnMsg="";
%>
<wtc:utype name="sChkOfferRel" id="doubleChk" scope="end">
	<wtc:uparams>		
		<wtc:uparams name="offerList" iMaxOccurs="-1">
<%
	for(int i=0;i<offerIdArr.length;i++)
	{
%>
				<wtc:uparams name="offerInfo" iMaxOccurs="1">
						<wtc:uparam value="<%=offerIdArr[i]%>" type="long" />
						<wtc:uparam value="<%=offerNameArr[i]%>" type="string" />
				</wtc:uparams>
<%
	}
%>			
		</wtc:uparams>
		<wtc:uparams name="produceList" iMaxOccurs="-1">
<%
	for(int i=0;i<pordIdArr.length;i++)
	{
%>	
				<wtc:uparams name="produceInfo" iMaxOccurs="1">
						<wtc:uparam value="<%=pordIdArr[i]%>" type="long" />
						<wtc:uparam value="<%=prodNameArr[i]%>" type="string" />
				</wtc:uparams>
<%
	}
%>			
		</wtc:uparams>		
	</wtc:uparams>	
</wtc:utype>
<%
		retrunCode=doubleChk.getValue(0);
		returnMsg=doubleChk.getValue(1);
%>

var response = new AJAXPacket();
response.data.add("errorCode","<%=retrunCode%>");
response.data.add("errorMsg","<%=returnMsg%>");
core.ajax.receivePacket(response);