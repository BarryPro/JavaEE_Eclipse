
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
 
        String workNo =(String)session.getAttribute("workNo");
        String workName =(String)session.getAttribute("workName");

        String orgCode =(String)session.getAttribute("orgCode");
        String regionCode = orgCode.substring(0,2);
        String ip_Addr =(String)session.getAttribute("ip_Addr");

		    String retType = request.getParameter("retType");
        String custName = request.getParameter("custName");
        String custId=new String();
        String flag="";
        String password = (String)session.getAttribute("password");
        String ipAddrss = (String)session.getAttribute("ipAddr");
%>				
		<wtc:service name="sUserCustInfo" outnum="100" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" >
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="1100" />	
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=password%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="1100客户开户验证名字" />
			<wtc:param value="" />
			<wtc:param value="<%=custName%>" />
</wtc:service>
<wtc:array id="retListString1"  scope="end"/>
	
<%       
	if(retCode.equals("000000")){
	  if(retListString1.length==0){
        	flag="0";
        }
      	else{
      		flag="1";
      		custId=retListString1[0][0];
      	}
		

		System.out.println("retType:"+retType);
		System.out.println("custId:"+custId);
	
}else{
	System.out.println("访问服务sPubSelect(in f1100_checkname.jsp)失败");
	}			
      
%>
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("custId","<%=custId%>");
response.data.add("flag","<%=flag%>");
response.data.add("retCode","000000");
core.ajax.receivePacket(response);