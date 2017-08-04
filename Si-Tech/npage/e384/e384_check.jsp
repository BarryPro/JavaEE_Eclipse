<%
  /*
   * 功能: 用户信誉度修改2308
   * 版本: 1.0
   * 日期: 2009/1/15
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	 					//操作工号
	String phoneNo = request.getParameter("phoneNo").trim();					//用户号码
	//String opCode = request.getParameter("opCode");						//操作代码
	String opCode = "e384";	
	String orgCode = request.getParameter("orgCode");					//归属代码
	String regionCode = (String)session.getAttribute("regCode");		//地市代码
	String iLoginAccept ="0";
	//String iChnSource  =request.getParameter("channelId");
	String iChnSource  ="01";
	String workno = (String)session.getAttribute("workNo");
	//String pwd = request.getParameter("pwd");
	String pwd ="";
	String nopass = (String)session.getAttribute("password");
	//System.out.println("1111111111111111111111iChnSource is "+iChnSource+" and pwd is "+pwd);
	//String sql_name = "select a.cust_name from dcustdoc a where a.cust_id =  ( select cust_id from dcustmsg b where b.phone_no ='?' )   ";
	//new 新增 查询wChargeCardMsg的add_pay_money 针对分转增的 和 单个的都要写 多个的在getUserMore里面写
	String add_money="";
	//String sql_money="select to_char(add_pay_money) from wChargeCardMsg where phone_no1='?' and phone_no2='?' ";

	String ipAddr =  (String)session.getAttribute("ipAddr");
	
	String s_note="";
	s_note="根据手机号码"+phoneNo+"进行查询";
	String detail_id = request.getParameter("detail_id");
	String[] strArray = detail_id.split(",");   
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaa detail_id is "+detail_id+" and strArray[0] is "+strArray[0]+" and strArray[1] is "+strArray[1]);
%>
 
	<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="40">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=ipAddr%>"/>
			<wtc:param value="<%=s_note%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
</wtc:service>
<wtc:array id="resultName" scope="end"/>



<%
	String errCode2 = retCode2;
	String errMsg2 = retMsg2;
	String custName = "";
	if(resultName!=null)
	{
		custName=resultName[0][16];
		System.out.println("aaaaaaaaaaaaa~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~aaaaaaaaaa custName is "+custName);
	}
%>	
 
	<wtc:service name="sQryAwardCardBD" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=pwd%>"/>
		<wtc:param value="<%=strArray[0]%>"/>
		<wtc:param value="<%=strArray[1]%>"/>
	</wtc:service>
	<wtc:array id="mainInfo1"  scope="end"/>
 
<%
	String errCode = retCode;
	String errMsg = retMsg;
	
	/*以下可能有多值*/
	String oStoreNo="";/*充值卡开始卡号*/
	String oEndStoreNo="";/*充值卡结束卡号*/
	String oTranMianzhi=""; /*充值卡面值*/
	
	String oCustName="";
	String cardFlag = "";
	String scount="";
	int icount=0;//卡数量
	String[][] out_money  = null ;
	String[][] result1  = null ;
	String[][] result2  = null ;
	String[][] result3  = null ;

	result1 = mainInfo1;
 
	if(errMsg.equals("")){
		errMsg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errCode));
		if( errMsg.equals("null")){
			errMsg ="未知错误信息";
		}
	} 
	
	%>//alert("retCode is "+"<%=retCode%>");<%
	if(retCode.equals("0")||retCode.equals("000000"))
	{
		scount = result1[0][3];
		System.out.println("QQQQQQQQQQQQQQQQQ scount is "+scount);
		icount = Integer.parseInt(scount);
		System.out.println("AAAAAAAAAAAAAAAAAAaQQQQQQQQQQQQQQQQQ icount is "+icount);
		%>
		var response = new AJAXPacket();
		<%
		 
		 
		 
		%>
			
			//alert("scount is "+"<%=scount%>"+" and result1.length is "+"<%=result1.length%>");
			response.data.add("flag1","0");//查询成功

			
			<%
				
				for(int i = 0;i<result1.length;i++)
				{
					%>
						response.data.add("oStoreNo"+"<%=i%>","<%=result1[i][0]%>"); //开始
						response.data.add("oEndStoreNo"+"<%=i%>","<%=result1[i][1]%>");//结束
						response.data.add("oTranMianzhi"+"<%=i%>","<%=result1[i][2]%>");
						response.data.add("icardNum"+"<%=i%>","<%=result1[i][3]%>");//卡号段内的数量
						
						//alert("oStoreNo is "+"<%=result1[i][0]%>");
					<%
					
				}
					
				
			%>
			 
	        response.data.add("iNumLen","<%=result1.length%>");//看有几组 明天试试   
			 
		 
			response.data.add("custName","<%=custName%>");
			core.ajax.receivePacket(response);
		<%
	}
	else
	{
		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA失败啦 errCode is "+errCode+" and errMsg is "+errMsg);
		%>
			var response = new AJAXPacket();
			
			response.data.add("flag1","1");
			
			response.data.add("errCode","<%=errCode%>");
			response.data.add("errMsg","<%=errMsg%>");
			core.ajax.receivePacket(response);
		<%
	}
	

%>
	
 