<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
System.out.println("------------------------getPproductInfo.jsp-------------------");

		String userId=WtcUtil.repNull(request.getParameter("userId"));
		System.out.println("------------------------userId------------------------"+userId);
		
		String beforSellId=WtcUtil.repNull(request.getParameter("beforSellId"));
		System.out.println("------------------------beforSellId------------------------"+beforSellId);
		
		String laterSellId=WtcUtil.repNull(request.getParameter("laterSellId"));
		System.out.println("------------------------laterSellId------------------------"+laterSellId);
		
		String laterEffTime=WtcUtil.repNull(request.getParameter("laterEffTime"));
		System.out.println("------------------------laterEffTime------------------------"+laterEffTime);
		
		String laterDeadTime=WtcUtil.repNull(request.getParameter("laterDeadTime"));
		System.out.println("------------------------laterDeadTime------------------------"+laterDeadTime);
		
%>

  <wtc:utype name="sGetChgServProd" id="retVal4" scope="end" >
				<wtc:uparam value="<%=userId%>" type="long" />
				<wtc:uparam value="<%=beforSellId%>" type="long"/>
				<wtc:uparam value="<%=laterSellId%>" type="long"/>	
				<wtc:uparam value="<%=laterEffTime%>" type="string"/>	
				<wtc:uparam value="<%=laterDeadTime%>" type="string"/>
	</wtc:utype>	
	
	<%
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal4,1,"2",logBuffer);
	System.out.println(logBuffer.toString());



	StringBuffer sbRe = new StringBuffer(80);


	  String  retCode4=retVal4.getValue(0);
		String  retMsg4  =retVal4.getValue(1);
		if(retCode4.equals("0"))
		{
	for(int i=0;i<retVal4.getUtype("2").getSize();i++)
			{		
					sbRe.append("#");
					sbRe.append(retVal4.getUtype("2."+i).getValue(0).trim());
					sbRe.append("¡ì");
					sbRe.append(retVal4.getUtype("2."+i).getValue(1).trim());
					sbRe.append("¡ì");
					sbRe.append(retVal4.getUtype("2."+i).getValue(2).trim());
					sbRe.append("¡ì");
					sbRe.append(retVal4.getUtype("2."+i).getValue(3).trim());
					sbRe.append("¡ì");
					sbRe.append(retVal4.getUtype("2."+i).getValue(4).trim());
					sbRe.append("¡ì");
					sbRe.append(retVal4.getUtype("2."+i).getValue(5).trim());
					sbRe.append("¡ì");
					sbRe.append(retVal4.getUtype("2."+i).getValue(6).trim());
					sbRe.append("¡ì");
					sbRe.append(retVal4.getUtype("2."+i).getValue(7).trim());
					sbRe.append("¡ì");
					sbRe.append(retVal4.getUtype("2."+i).getValue(8).trim());
					sbRe.append("¡ì");
					sbRe.append(retVal4.getUtype("2."+i).getValue(9).trim());
					sbRe.append("¡ì");
					sbRe.append(retVal4.getUtype("2."+i).getValue(10).trim());
					sbRe.append("¡ì");
					sbRe.append(retVal4.getUtype("2."+i).getValue(11).trim());
					sbRe.append("¡ì");
					sbRe.append(retVal4.getUtype("2."+i).getValue(12).trim());
					sbRe.append("¡ì");
					sbRe.append(retVal4.getUtype("2."+i).getValue(13).trim());
					sbRe.append("¡ì");
					sbRe.append(retVal4.getUtype("2."+i).getValue(14).trim());
					sbRe.append("¡ì");
					
					 
					
			}
		}
		System.out.println(sbRe.toString());
		
		String reStr = sbRe.toString();
	%>
	
	
	
var response = new AJAXPacket();
response.data.add("errorCode","<%=retCode4 %>");
response.data.add("errorMsg","<%=retMsg4 %>");
response.data.add("tableInfo","<%=reStr%>");
core.ajax.receivePacket(response);
