<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String payMoney = request.getParameter("payMoney");
		String phoneNo = request.getParameter("phoneNo");
		String workno = (String)session.getAttribute("workNo");
%>			
		<wtc:service name="bs_ChnPayLimit" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode5" retmsg="retMsg5" outnum="5">
	<wtc:param value="<%=workno%>"/>
	<wtc:param value="<%=payMoney%>"/>

	</wtc:service>
		<wtc:array id="limits" scope="end" />			
<%
		String result = "";
		String outPledge = "";
		String f_temp_total_pay ="";
		String return_code = retCode5;
		String return_msg = retMsg5;
		//xl 判断 
		System.out.println("88888888888888888888888 limits.length is "+limits.length);
		
		if(limits.length < 0)
		{
		   
		   //alert("服务调用出错！");
		   //return_code = "001001";
		   //return_msg = "查询额度信息为空!<br>errCode: " + return_code + "<br>errMsg+" + return_msg;
		   //result = return_code;
		   //System.out.println("0000000000000000000000查询的值是空111111111111111111111111111"+return_code+" and return_msg is  "+return_msg);	
		}
		else
		{
			
			result = limits[0][2].trim();
			outPledge = limits[0][3].trim();
			f_temp_total_pay = limits[0][4].trim();
			//System.out.println("0000000000000000000000000000查询的结果不是空 ···················");
			System.out.println("return_code is "+return_code+" and outPledge is "+outPledge+" and f_temp_total_pay is "+f_temp_total_pay );
		}

%>
		var response = new AJAXPacket();
	 
		var return_code = "<%=return_code%>";
		var return_msg = "<%=return_msg%>";
		var result = "<%=result%>";
		var outPledge = "<%=outPledge%>";
		var f_temp_total_pay = "<%=f_temp_total_pay%>";
		var payMoney = "<%=payMoney%>";
		response.data.add("return_code",return_code);
		response.data.add("return_msg",return_msg);
		response.data.add("result",result);
	    response.data.add("outPledge",outPledge);
		response.data.add("f_temp_total_pay",f_temp_total_pay);
		response.data.add("payMoney",payMoney);
		core.ajax.receivePacket(response);
