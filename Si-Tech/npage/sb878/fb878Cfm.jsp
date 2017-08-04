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
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%

	System.out.println("================调用sb878Cfm in fb878Cfm.jsp=============");
	String iLoginAccept = "";										//流水
	String iChnSource   = "10";										//渠道标识
	String iOpCode      = "4400";									//操作代码
	String iOpName		= "全球通VIP候车服务";
	String iLoginNo     = (String)session.getAttribute("workNo");	//操作工号
	String iLoginPwd    = (String)session.getAttribute("password"); //工号密码 
	String iPhoneNo     = request.getParameter("custPhone");		//手机号码
	String iUserPwd  	= request.getParameter("custPwd");			//号码密码
	System.out.println("=================iLoginPwd=================:"+iLoginPwd);
	System.out.println("=================iUserPwd=================:"+iUserPwd);
	String iOrgCode		= (String)session.getAttribute("orgCode");	//工号归属
	String regionCode 	= iOrgCode.substring(0,2);
	String iCardType    = request.getParameter("cardType");			//证件类型
	String iCardNum     = request.getParameter("cardNo");			//证件号码
	String iEnterTime   = request.getParameter("enterTime");        //进入时间
	String iLeaveTime   = request.getParameter("leaveTime");        //离开时间
	String iSvcLevel = "";

	String iSvcCode		= request.getParameter("oneCodeArr");		//统计项目编码
	String iSvcDisc		= request.getParameter("oneNameArr");		//统计项目内容
	String iItemID		= request.getParameter("twoCodeArr");		//二级项目编码
	String iItemValue   = request.getParameter("twoNameArr");  		//二级项目值
	String iPrice      	= request.getParameter("priceArr");			//金额
	String iScore     	= request.getParameter("scoreArr");			//折合应扣积分
	String iAmount 		= request.getParameter("totalPrice");		//总金额
	String iTotalScore 	= request.getParameter("totalScore");		//折合应扣总积分
	String iWeatherFlag = request.getParameter("tqyb");				//是否查询该用户的所去目的地天气情况(0：是1：不是)
	String iDestProv 	= request.getParameter("proCode");			//目的地省份
	String iDestCity 	= request.getParameter("cityCode");			//目的地城市
	String iDestDate 	= request.getParameter("destDate");			//目的地当天天气预报日期
	String morrowFlag 	= request.getParameter("morrowFlag");		//是否预定第二天天气预报标识
	String iMorrowDate 	= "";										//目的地第二天天气预报日期
	String flag 	= request.getParameter("flag");		//inner：省内，out：省外
	String personNum 	= request.getParameter("personNum");		//随员人数
	String sheng_flag= request.getParameter("sheng_flag");//huangrong add 省内省外标识，w：省外，n：省内
	
	if("1".equals(morrowFlag)){
		try {
			java.util.Date mDay = new java.text.SimpleDateFormat("yyyyMMdd").parse(iDestDate);
			int day = mDay.getDate();
			mDay.setDate(day+1);
			iMorrowDate = new java.text.SimpleDateFormat("yyyyMMdd").format(mDay);
		} catch (java.text.ParseException e) {
			e.printStackTrace();
		}
	}
	if("n".equals(sheng_flag)){
	 iSvcLevel    = request.getParameter("servLeve");		//服务级别
	 iLoginAccept = request.getParameter("login_accept");	
}else
	{
	 iSvcLevel    = request.getParameter("servLevel");		//服务级别
	  iLoginAccept = "";
	}
	System.out.println("=================iSvcLevel=================:"+iSvcLevel);		
	System.out.println("=================iLoginAccept=================:"+iLoginAccept);		
%>
<wtc:service name="sb878Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=iOpCode%>" />
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="<%=iUserPwd%>" />
		<wtc:param value="<%=iOrgCode%>" />
		<wtc:param value="<%=iCardType%>" />
		<wtc:param value="<%=iCardNum%>" />
		<wtc:param value="<%=iEnterTime%>" />
		<wtc:param value="<%=iLeaveTime%>" />
		<wtc:param value="<%=iSvcLevel%>" />
		<wtc:param value="<%=iSvcCode%>" />
		<wtc:param value="<%=iSvcDisc%>" />
		<wtc:param value="<%=iItemID%>" />
		<wtc:param value="<%=iItemValue%>" />
		<wtc:param value="<%=iPrice%>" />
		<wtc:param value="<%=iScore%>" />
		<wtc:param value="<%=iAmount%>" />
		<wtc:param value="<%=iTotalScore%>" />
		<wtc:param value="<%=iWeatherFlag%>" />
		<wtc:param value="<%=iDestProv%>" />
		<wtc:param value="<%=iDestCity%>" />
		<wtc:param value="<%=iDestDate%>" />
		<wtc:param value="<%=iMorrowDate%>" />
<%
		if("inner".equals(morrowFlag))
		{
%>			
		<wtc:param value="<%=personNum%>" />
<%
		}
%>	

<%
		if("n".equals(sheng_flag))
		{
%>			
		<wtc:param value="<%=personNum%>" />
<%
		}
%>				
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务sb878Cfm in fb878Cfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");

 	    String statisLoginAccept =  iLoginAccept; /*流水*/
		String statisOpCode="4400";
		String statisPhoneNo= iPhoneNo;	
		String statisIdNo="";	
		String statisCustId="";
		String statisUrl = "/npage/public/pubCustSatisIn.jsp"
			+"?statisLoginAccept="+statisLoginAccept
			+"&statisOpCode="+statisOpCode
			+"&statisPhoneNo="+statisPhoneNo
			+"&statisIdNo="+statisIdNo	
			+"&statisCustId="+statisCustId;	
    	System.out.println("@zhangyan~~~~statisLoginAccept="+statisLoginAccept);
    	System.out.println("@zhangyan~~~~statisOpCode="+statisOpCode);
    	System.out.println("@zhangyan~~~~statisPhoneNo="+statisPhoneNo);
    	System.out.println("@zhangyan~~~~statisIdNo="+statisIdNo);
    	System.out.println("@zhangyan~~~~statisCustId="+statisCustId);
    	System.out.println("@zhangyan~~~~statisUrl="+statisUrl);
    	
   		if (statisOpCode.equals("4400"))
		{
		%>
		<jsp:include page="<%=statisUrl%>" flush="true" />	
		
		<%	
		}	
%>
	<script language="JavaScript">
		rdShowMessageDialog("办理全球通VIP候车服务成功！");
		window.location="/npage/s4400/f4400.jsp?opCode=4400&opName=电子VIP积分受理";
	</script>
<%
	}else{
		System.out.println("调用服务调用服务sb878Cfm in fb878Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		window.location="/npage/s4400/f4400.jsp?opCode=4400&opName=电子VIP积分受理";
	</script>
<%
	}
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+ iOpCode +"&retCodeForCntt="+errCode+
			"&opName="+iOpName+"&workNo="+iLoginNo+"&loginAccept="+iLoginAccept+
			"&pageActivePhone="+iPhoneNo+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;	
%>
		<jsp:include page="<%=url%>" flush="true" />