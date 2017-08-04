<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-22 页面改造,修改样式
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt;"%>
<%
 
		
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String loginAccept = request.getParameter("loginAccept");
		String offerId = request.getParameter("offerId");
		String loginNo = request.getParameter("loginNo");
		String opCode = request.getParameter("opCode");
		String phoneNo = request.getParameter("phoneNo");
		
			
		
  System.out.println("mylog-------------------------loginAccept  ----------------------------"+loginAccept        );     
  System.out.println("mylog-------------------------offerId  --------------------------------"+offerId        );     
	System.out.println("mylog-------------------------loginNo----------------------------------"+loginNo      );     
	System.out.println("mylog-------------------------opCode-----------------------------------"+opCode      );     
	System.out.println("mylog-------------------------phoneNo ---------------------------------"+phoneNo       );     
	String errorCode = "";
	String errorMsg   = "";
	
try
{	
%>		

 <wtc:utype name="sOrderCmtChk" id="retVal" scope="end">
	 <wtc:uparam value="<%=loginAccept%>" type="LONG" />
	 <wtc:uparam value="<%=offerId%>" type="LONG" />
	 <wtc:uparam value="<%=loginNo%>" type="STRING" />
	 <wtc:uparam value="<%=opCode%>" type="STRING" />
	 <wtc:uparam value="<%=phoneNo%>" type="STRING" />
</wtc:utype>

<%

	
	 errorCode = String.valueOf(retVal.getValue(0));
	 errorMsg = String.valueOf(retVal.getValue(1));
	
}catch(Exception ex){

	 errorCode = "000404";
	 errorMsg   = "系统错误，请联系管理员";

}	
	System.out.println("mylog--------------errorCode---------------------"+errorCode);
	System.out.println("mylog--------------errorMsg---------------------"+errorMsg);
%>

var response = new AJAXPacket();
response.data.add("errorCode","<%=errorCode%>");
response.data.add("errorMsg","<%=errorMsg%>");
core.ajax.receivePacket(response);