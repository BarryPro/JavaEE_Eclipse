<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String orgCode = (String) session.getAttribute("orgCode");
        String regionCode = orgCode.substring(0, 2);
		String custid = request.getParameter("custid");
		//System.out.println("11AAAAAAAAAAAAAAAAAAAA1111111111111111111custid = "+custid);
		String sqlStr1 = "select to_char(a.zjx_num), to_char(a.LOCAL_MINS),to_char(a.LONG_MINS),a.CUST_NAME,a.pay_money,a.count_money,a.total_money,to_char(b.rate_num),to_char(sysdate,'dd') as days,to_char(a.PBX_LINE_NUM) as pbx_line_num ,to_char(a.PBX_REAL_NUM) as real_num ,a.RENT_FEE as rent_fee ,a.FUNC_FEE as func_fee,to_char(a.total_mins) ,a.local_income,a.long_income from DPBX_GROUPINFO a, saccounts_rate b where a.cust_id ='"+custid+"' and a.total_date = to_char(add_months(sysdate,-1),'YYYYMM') and a.account_rate = b.rate_id";
%>			
		<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="16">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />			
<%
  System.out.println("------------result1 is ----"+result1+" and result1.length is "+result1.length);
		
		String zjx_num = "";
		String pay_money = "";
		String count_money = "";
		String total_money = "";
		String CUST_NAME = "";
		String LOCAL_TIMES = "";
		String LOCALLONG = "";
		String rate_num = "";
		String date1 = "";
		//String retCode1 = "";
		String pbx_num = "";
		String real_num = "";
		String rent_fee = "";
		String func_fee = "";
		String total_mins = "";
		String local_income = "";
		String long_income = "";
		if((result1 == null) || (result1.length== 0))
		{
			System.out.println(" 9999999999999999999999ccc查询结果为空~~~~~~~~~~~~~·");
			%>
			<script language= "javascript">
				alert("没有找到相关记录!");
				
				//return false;
			</script>
			<%
				System.out.println(" AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA查询结果为空~~~~~~~~retCode1~~~~~·"+retCode1);
		/*	zjx_num = "无结果";
		pay_money = "无结果";
		count_money = "无结果";
		total_money = "无结果";
		CUST_NAME = "无结果";
		LOCAL_TIMES = "无结果";
		LOCALLONG = "无结果"; */
		System.out.println(" AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA查询结果为空~~~~~~~~LOCALLONG~~~~~·"+LOCALLONG);
		}
		else{
		
		zjx_num = result1[0][0];
		pay_money = result1[0][4];
		count_money = result1[0][5];
		total_money = result1[0][6];
		CUST_NAME = result1[0][3];
		LOCAL_TIMES = result1[0][1];
		LOCALLONG = result1[0][2];
		rate_num = result1[0][7];
		date1 = result1[0][8];
		pbx_num = result1[0][9];
		real_num = result1[0][10];
		rent_fee = result1[0][11];
		func_fee = result1[0][12];
		total_mins = result1[0][13];
		local_income = result1[0][14];
		long_income = result1[0][15];
			 
		//retCode1 = result1[0][8];
 
		}
%>	
	
 
 var response = new AJAXPacket();
 var date1 = "<%=date1%>";
		var zjx_num = "<%=zjx_num%>";
		var pay_money = "<%=pay_money%>";
		var count_money = "<%=count_money%>";
		var total_money = "<%=total_money%>";
		var CUST_NAME = "<%=CUST_NAME%>";
		var LOCAL_TIMES = "<%=LOCAL_TIMES%>";
		var LOCALLONG = "<%=LOCALLONG%>";
		var retCode1 = "<%=retCode1%>";
		var rate_num =  "<%=rate_num%>";
		var pbx_num = "<%=pbx_num%>";
		var real_num = "<%=real_num%>";
		var rent_fee = "<%=rent_fee%>";
		var func_fee = "<%=func_fee%>";
		var total_mins = "<%=total_mins%>";
		var local_income = "<%=local_income%>";
		var long_income = "<%=long_income%>";
		response.data.add("total_mins",total_mins);
		response.data.add("local_income",local_income);
		response.data.add("long_income",long_income);
		response.data.add("zjx_num",zjx_num);
		response.data.add("pbx_num",pbx_num);
		response.data.add("real_num",real_num);
		response.data.add("rent_fee",rent_fee);
		response.data.add("func_fee",func_fee);
		response.data.add("pay_money",pay_money);
		response.data.add("count_money",count_money);
		response.data.add("total_money",total_money);
		response.data.add("CUST_NAME",CUST_NAME);
		response.data.add("LOCAL_TIMES",LOCAL_TIMES);
		response.data.add("LOCALLONG",LOCALLONG);
		response.data.add("rate_num",rate_num);
		response.data.add("date1",date1);
		response.data.add("retCode1",retCode1);
		core.ajax.receivePacket(response);