<%
  /*
   * 功能: 全球通VIP候车服务
   * 版本: 2.0
   * 日期: 2010/11/17
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>

<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
	//inparam
	String loginNo = (String)session.getAttribute("workNo");
	String loginPwd = (String)session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String custPhone = request.getParameter("custPhone");
	String cardType = request.getParameter("cardType");
	
	/*
	String userpwd  = request.getParameter("custPwd");			
	String custPwd 	= (String)Encrypt.encrypt(userpwd);		
	*/
	String custPwd  = request.getParameter("custPwd");		
	System.out.println("=================loginPwd=================:"+loginPwd);
	System.out.println("=================custPwd=================:"+custPwd);
	
	String cardNo = request.getParameter("cardNo");
	String servLevel = request.getParameter("servLevel");
	String personNum = request.getParameter("personNum");
	String iChnSource = "10";
	String iLoginAccept = "0";
	String opCode = "b878";
	String flag = "";//是否提供服务标识
	String sheng_flag= request.getParameter("sheng_flag");//huangrong add 省内省外标识，w：省外，n：省内
	//outparam
	String oRejectReason  = "";//归属方拒绝服务的理由
	String oCustName = "";//客户姓名
	String oUserStatus = "";//用户状态
	String oUserRank = "";//客户级别
	String oSvcPhNum = "";//大客户经理联系电话
	String oUserScore = "";//客户可用积分余额
	String oRemainTimes = "";//huangrong add 剩余免费次数
	String oUsedNu = "";//huangrong add 本省用户增加本次使用的免费次数
	String oUsedScor = "";//huangrong add 本省用户增加本次需要的积分数	
	System.out.println("loginNo=="+loginNo);
	System.out.println("loginPwd=="+loginPwd);
	System.out.println("orgCode=="+orgCode);
	System.out.println("regionCode=="+regionCode);
	System.out.println("custPhone=="+custPhone);
	System.out.println("cardType=="+cardType);
	System.out.println("custPwd=="+custPwd);
	System.out.println("cardNo=="+cardNo);
	System.out.println("servLevel=="+servLevel);
	System.out.println("personNum=="+personNum);
	//begin  huangrong add 
	String outnum="";
	if(sheng_flag.equals("n"))
	{
		outnum="11";
	}else
	{
		outnum="8";
	}
	//end  huangrong add 	
	System.out.println("---------------------------outnum---------==================="+outnum);
%>

	<wtc:service name="sb878Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="<%=outnum%>">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=loginNo%>" />
		<wtc:param value="<%=loginPwd%>" />
		<wtc:param value="<%=custPhone%>" />
		<wtc:param value="<%=custPwd%>" />
		<wtc:param value="<%=orgCode%>" />
		<wtc:param value="<%=cardType%>" />
		<wtc:param value="<%=cardNo%>" />
		<wtc:param value="<%=servLevel%>" />
		<wtc:param value="<%=personNum%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务sb878Qry in fb878.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
		flag = "true";
									System.out.println("result1 成功@@@@@@@@@@@@@@@@@@@@@@@@@@"+result1.length);	
		if(result1.length > 0){
											System.out.println("111111111111111111111111111");	
			oRejectReason = result1[0][2];
			oCustName = result1[0][3];    
			oUserStatus = result1[0][4];  
			oUserRank = result1[0][5];    
			oSvcPhNum = result1[0][6];    
			oUserScore = result1[0][7]; 
							System.out.println("oRejectReason 成功@@@@@@@@@@@@@@@@@@@@@@@@@@"+oRejectReason);	 
			if(sheng_flag.equals("n"))
			{
				oRemainTimes = result1[0][8]; 
				oUsedNu = result1[0][9];  
				oUsedScor = result1[0][10];  
					System.out.println("oRemainTimes 成功@@@@@@@@@@@@@@@@@@@@@@@@@@"+oRemainTimes);
					
					System.out.println("oUsedNu 成功@@@@@@@@@@@@@@@@@@@@@@@@@@"+oUsedNu);
					
					System.out.println("oUsedScor 成功@@@@@@@@@@@@@@@@@@@@@@@@@@"+oUsedScor);
			}
		}   
	}else{  
		System.out.println("调用服务调用服务sb878Qry in fb878.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
		flag = "false";
		System.out.println(result1[0][0]+"================="+result1[0][1]);
	}

%>
var response = new AJAXPacket();
response.data.add("flag","<%=flag%>");
response.data.add("errCode","<%=result1[0][0]%>");
response.data.add("errMsg","<%=result1[0][1]%>");
response.data.add("oRejectReason","<%=oRejectReason%>");
response.data.add("oCustName","<%=oCustName%>");
response.data.add("oUserStatus","<%=oUserStatus%>");
response.data.add("oUserRank","<%=oUserRank%>");
response.data.add("oSvcPhNum","<%=oSvcPhNum%>");
response.data.add("oUserScore","<%=oUserScore%>");
response.data.add("oRemainTimes","<%=oRemainTimes%>");
response.data.add("oUsedNu","<%=oUsedNu%>");
response.data.add("oUsedScor","<%=oUsedScor%>");
core.ajax.receivePacket(response);

