<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String regionCode = (String)session.getAttribute("regCode");
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		
        String unit_id = (String)request.getParameter("unit_id");
		String[] inParas2 = new String[2];
		inParas2[0]="select to_char(count(*)) from dgrpcustmsg where unit_id=:unit_id and owner_code in ('A1','A2','B1','B2','C1') ";
		inParas2[1]="unit_id="+unit_id;
%>			
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="return_codes" retmsg="return_msgs" outnum="1">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
		 
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />			
<%

		//String return_codes = ret_val[0][0].trim();
		//String return_msgs = ret_val[0][1].trim();
		String return_code = return_codes;
		String return_msg = return_msgs;
		String counts ="";
System.out.println("9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 "+counts+" and "+inParas2[0]+" and is "+inParas2[1]);
		if(ret_val.length < 0)
		{
		   
		   //alert("服务调用出错！");
		   //return_code = "001001";
		   //return_msg = "查询额度信息为空!<br>errCode: " + return_code + "<br>errMsg+" + return_msg;
		   //result = return_code;
		   //System.out.println("0000000000000000000000查询的值是空111111111111111111111111111"+return_code+" and return_msg is  "+return_msg);	
		}
		else
		{
			 counts=ret_val[0][0];
		}
%>	
		
		var response = new AJAXPacket();
		response.data.add("retCode","<%=return_code%>");
		response.data.add("retMsg","<%=return_msg%>");
		response.data.add("counts","<%=counts%>");
		core.ajax.receivePacket(response);
