<%
	/********************
	 version v2.0方法
	开发商: si-tech
	update:zhaoht@2009-03-10 页面改造,修改样式
	********************/
%>

	
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=gbk" %>
<%

	String regCode = (String)session.getAttribute("regCode");
    
    String verifyType = request.getParameter("verifyType");
	String begin_no = request.getParameter("begin_no");
	String card_num = request.getParameter("card_num");

    String iErrorNo = null;
    String sErrorMessage = "";
	String return_msg = "";

	String[] inParas = new String[2];
    inParas[0] = begin_no;
	inParas[1] = card_num;

	try {
	    //callRemoteResultValue = viewBean.callService("0", null,"s1330_check","3",inParas);
%>
		<wtc:service name="s1330_check" routerKey="region" routerValue="<%=regCode%>" outnum="3">			
		<wtc:param value="<%=begin_no%>"/>	
		<wtc:param value="<%=card_num%>"/>	
		</wtc:service>	
		<wtc:array id="result"  scope="end"/>
<%	  
		iErrorNo = result[0][0];
	 	sErrorMessage = result[0][1];
		return_msg = result[0][2];
	} catch(Exception e) {
	    System.out.println("调用EJB发生失败！");
	}
%>

var response = new AJAXPacket();

response.data.add("verifyType","<%= verifyType %>");
response.data.add("iErrorNo","<%= iErrorNo %>");
response.data.add("sErrorMessage","<%= sErrorMessage %>");
response.data.add("return_msg","<%=return_msg %>" );
core.ajax.receivePacket(response);
