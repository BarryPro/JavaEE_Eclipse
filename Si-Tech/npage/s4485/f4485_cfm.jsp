<%
    /******************************************
     * @ OpCode    :  4485
     * @ OpName    :  全网生效成员关系失败列表
     * @ CopyRight :  si-tech
     * @ Author    :  wangzn
     * @ Date      :  2010-3-18 15:44:06
     * @ Update    :  
     ******************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String iOrgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String iLoginPwd = WtcUtil.repNull((String)session.getAttribute("password"));
    String iIpAddr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
    String regionCode = iOrgCode.substring(0,2);
    
    String unit_id = request.getParameter("unit_id");
    String productSpec_number = request.getParameter("productSpec_number");
		String product_id = request.getParameter("product_id");
		String phone_no = request.getParameter("phone_no");
		String id_no = request.getParameter("id_no");
		
System.out.println("/************************************************");
System.out.println("     * @ OpCode    :  4485                       ");
System.out.println("     * @ OpName    :  全网生效成员关系失败列表   ");
System.out.println("     * @ CopyRight :  si-tech                    ");
System.out.println("     * @ Author    :  wangzn                     ");
System.out.println("     * @ Date      :  2010-3-18 15:44:06         ");
System.out.println("     * @ Update    :                             ");
System.out.println("     * @ Parameter :                             ");
System.out.println("      workNo                "+workNo            +"  ");
System.out.println("      iOrgCode              "+iOrgCode          +"  ");
System.out.println("      iLoginPwd             "+iLoginPwd         +"  ");
System.out.println("      iIpAddr               "+iIpAddr           +"  ");
System.out.println("      regionCode            "+regionCode        +"  ");
System.out.println("                                                 ");
System.out.println("      unit_id               "+unit_id           +"  ");
System.out.println("      productSpec_number    "+productSpec_number+"  ");
System.out.println("      product_id            "+product_id        +"  ");
System.out.println("      phone_no              "+phone_no          +"  ");
System.out.println("      id_no                 "+id_no             +"  ");
System.out.println("***********************************************/ ");		
		
%>		
    <wtc:service name="s4485Cfm" outnum="2" retmsg="returnMessage" retcode="returnCode" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=iLoginPwd%>" />
			<wtc:param value="<%=iOrgCode%>" />
			<wtc:param value="<%=iIpAddr%>" />	
			<wtc:param value="<%=unit_id%>" />		
			<wtc:param value="<%=productSpec_number%>" />
			<wtc:param value="<%=product_id%>" />			
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="<%=id_no%>" />
		</wtc:service>
    <wtc:array id="result" scope="end" />


var response = new AJAXPacket();
response.data.add("returnCode","<%=returnCode%>");
response.data.add("returnMessage","<%=returnMessage%>");
core.ajax.receivePacket(response);