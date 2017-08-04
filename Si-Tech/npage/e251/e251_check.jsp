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
	String opCode = "e251";	
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
	String sql_name = "select a.cust_name from dcustdoc a where a.cust_id =  ( select cust_id from dcustmsg b where b.phone_no ='?' )   ";
	//new 新增 查询wChargeCardMsg的add_pay_money 针对分转增的 和 单个的都要写 多个的在getUserMore里面写
	String add_money="";
	String sql_money="select to_char(add_pay_money) from wChargeCardMsg where phone_no1='?' and phone_no2='?' ";
	//xl add opOcdes
	String op_codes = request.getParameter("op_codes");
	
	System.out.println("B test QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ op_codes is "+op_codes);
%>
 
<%
%>
	<wtc:pubselect name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=sql_name%></wtc:sql>
		<wtc:param value="<%=phoneNo%>"/>
	</wtc:pubselect>
	<wtc:array id="resultName" scope="end" />
<%
	String errCode2 = retCode2;
	String errMsg2 = retMsg2;
	String custName = "";
	if(resultName!=null)
	{
		custName=resultName[0][0];
	}
	System.out.println("AAAAAAAAAAAAAAAAAAA test QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ op_codes is "+op_codes);
%>	
    //alert("555 "+"<%=op_codes%>");
	<wtc:service name="se257QryBD" routerKey="region" routerValue="<%=regionCode%>" outnum="13" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=pwd%>"/>
		<wtc:param value="<%=op_codes%>"/>
	</wtc:service>
	<wtc:array id="mainInfo1" start="0" length="2" scope="end"/>
	<wtc:array id="mainInfo2" start="2" length="3" scope="end"/>
	<wtc:array id="mainInfo3" start="5" length="2" scope="end"/>
	<wtc:array id="mainInfo4" start="7" length="4" scope="end"/>
	<wtc:array id="mainInfo5" start="11" length="2" scope="end"/>
<%
	/*
		GPARM32_0 活动名称 4组
		GPARM32_1 参与实践 4组
		GPARM32_2 是否办理转赠 1表示办理 2组
		GPARM32_3 总金额                 2组 
		GPARM32_4 给自己充值金额         2组   
		GPARM32_5 开始卡号               4组
		GPARM32_6 充值结束卡号           4组
		GPARM32_7 转赠金额               1个
		GPARM32_8 转赠时间               1个
		GPARM32_9 转赠电话               1个
		GPARM32_10 转赠name              1个
		GPARM32_11 opcode                4组 
		GPARM32_12 业务流水              4组

	*/
	//<wtc:array id="sVerifyTypeArr1" start="0" length="20" scope="end"/>
	//<wtc:array id="sVerifyTypeArr2" start="20" length="8" scope="end"/>
	String errCode = retCode;
	String errMsg = retMsg;
	String oProjectName = "";
	String oPartInTime = ""; /*参与时间*/
	String oOnlyMyFlag = "";/* 是否办理了转赠标识 1表示办理了*/
	String oAllFee=""; /*总金额*/
	String oMyFee="";/*给自己充值的金额*/
	/*以下可能有多值*/
	String oStoreNo="";/*充值卡开始卡号*/
	String oEndStoreNo="";/*充值卡结束卡号*/
	String oTranFee=""; /*转赠金额*/
	String oTranTime ="";/*转赠时间*/
	String oTranPhone="";/*转赠电话*/
	String oCustName="";
	String cardFlag = "";
	//xl add 2266新增需求
	String oTranOpCode="";
	String oTranAccept="";
	String[][] out_money  = null ;
	String[][] result1  = null ;
	String[][] result2  = null ;
	String[][] result3  = null ;
	String[][] result4  = null ;
	String[][] result5  = null ;
	result1 = mainInfo1;
	result2 = mainInfo2;
	result3 = mainInfo3;
	result4 = mainInfo4;
	result5 = mainInfo5;
	if(errMsg.equals("")){
		errMsg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errCode));
		if( errMsg.equals("null")){
			errMsg ="未知错误信息";
		}
	} 
	
	%>//alert("retCode is "+"<%=retCode%>");<%
	if(retCode.equals("0")||retCode.equals("000000"))
	{
		%>
		var response = new AJAXPacket();
		<%
		//xl add for sunqy 多组
		for(int i=0;i<result1.length;i++)
		{
			oProjectName = result1[i][0];
			oPartInTime  = result1[i][1];
		}
		int i_total=0;
		int i_all_fee=0;
		for(int i=0;i<result2.length;i++)
		{
			oOnlyMyFlag=result2[i][0];
			i_all_fee+=Integer.parseInt(result2[i][1]);
			i_total+=Integer.parseInt(result2[i][2]);
			//i_all_fee=Integer.parseInt(result2[i][1]);
			//i_total=Integer.parseInt(result2[i][2]);
			%>
			
			<%
		}
		oAllFee=i_all_fee+"";
		oMyFee=i_total+"";
		
		for(int i=0;i<result3.length;i++)
		{
			oStoreNo = result3[i][0];
			oEndStoreNo = result3[i][1];
		}
		
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa oMyFee is "+oMyFee+" and i_total is "+i_total);
		if(result4.length>0)
		{
			oTranFee = result4[0][0];
			oTranTime =result4[0][1];
			oTranPhone = result4[0][2];
			oCustName = result4[0][3];//这里传值 应该根据
		}
		//xl add
		for(int i=0;i<result5.length;i++)
		{
			oTranOpCode = result5[i][0];
			oTranAccept = result5[i][1];  	
		}
		 
		%>
			
			
			response.data.add("flag1","0");//flag1=0代表成功
			if("<%=result4.length%>">1)
			{
				//alert("多个转赠的");
				response.data.add("phoneFlag","0");//phoneFlag=0代表有多个转赠的
			}
			else
			{
				response.data.add("phoneFlag","1");
			}
			if("<%=result3.length%>">1)
			{
				//alert("多组充值卡");
				response.data.add("cardFlag","0");
			}
			else
			{
				response.data.add("cardFlag","1");
			}
			<%
				for(int i = 0;i<result3.length;i++)
				{
					%>
						response.data.add("oStoreNo","<%=result3[i][0]%>");
						response.data.add("oEndStoreNo","<%=result3[i][1]%>");
						response.data.add("oTranOpCode","<%=result5[i][0]%>");
						response.data.add("oTranAccept","<%=result5[i][1]%>");
						response.data.add("oProjectName","<%=result1[i][0]%>");
						response.data.add("oPartInTime","<%=result1[i][1]%>");
					<%
					
				}
				System.out.println("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNN "+result4.length);
				for(int i = 0;i<result4.length;i++)
				{
					System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA oTranOpCode is "+result3[i][4]+" and oTranAccept is "+result3[i][5]);
					%>
						//alert("test oPhone is "+"<%=result3[i][2]%>");
						response.data.add("oCustName","<%=result4[0][3]%>");
						response.data.add("oTranPhone","<%=result4[0][2]%>");
						 
					<%
					
				}
				//xl add
				
				//xl add for sunqy 增加办理活动名称、时间的多组出参 begin
				for(int i = 0;i<result2.length;i++)
				{
					%>
						response.data.add("oOnlyMyFlag","<%=result2[i][0]%>");
					<%
				 
				}
				//end of 多组出参
			%>
	 
			
 
			
		 
			response.data.add("oAllFee","<%=oAllFee%>");
			response.data.add("oMyFee","<%=oMyFee%>");
		
			response.data.add("oTranFee","<%=oTranFee%>");
			response.data.add("oTranTime","<%=oTranTime%>");
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
			
			//response.data.add("flag1","2");
			response.data.add("errCode","<%=errCode%>");
			response.data.add("errMsg","<%=errMsg%>");
			core.ajax.receivePacket(response);
		<%
	}
	

%>
	
 