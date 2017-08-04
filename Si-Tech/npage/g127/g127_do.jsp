<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String tfhm = request.getParameter("tfhm");
 
	 
		String inParas[] = new String[2];
	//  String phoneNo = request.getParameter("phoneNo");
		
		inParas[0] ="select to_char(b.account_id), b.user_name,to_char(a.owe_fee) from dconmsg a,dgrpusermsg b  where a.contract_no=b.account_id  and b.cust_id in ( select cust_id from dgrpcustmsg where unit_id=:unit_id)";
		inParas[1] ="unit_id="+tfhm ;
%>			

		<wtc:service name="TlsPubSelBoss" retcode="sConMoreQryCode" retmsg="sConMoreQryMsg" outnum="3">
			<wtc:param value="<%=inParas[0]%>"/> 
			<wtc:param value="<%=inParas[1]%>"/>
		 
		</wtc:service>
		<wtc:array id="ret_val" scope="end" />

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
		   
		    
		}
		else
		{
			
			result = limits[0][0].trim();
			outPledge = limits[0][1].trim();
			f_temp_total_pay = limits[0][2].trim();
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
