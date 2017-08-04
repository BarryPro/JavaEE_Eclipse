<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 亲情通（原邦尼老年人服务解决方案）业务
   * 版本: 2.0
   * 日期: 2011/1/5
   * 作者: weigp
   * 版权: si-tech
   * update: wanglma 20110527
   */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	/*===========获取参数============*/
	String loginAccept	    = request.getParameter("loginAccept");		//流水
	String chnSource		= "10";	//渠道标识
	String opCode			= request.getParameter("opCode");	//操作代码
	String orgCode 			= (String)session.getAttribute("orgCode");
	String opName			= request.getParameter("opName");
	String regionCode 	    = orgCode.substring(0,2);
	String loginNo			= (String)session.getAttribute("workNo");	//操作工号
	String loginPwd			= (String)session.getAttribute("password");	//工号密码
	String phoneNo			= request.getParameter("phoneNo");			//手机号码
	String userPwd			= "";	//号码密码
	String type_flag		= request.getParameter("type_flag");	//套餐类型（01－基础	套餐，02－升级套餐）
	String offer_id			= "";	//测试：10806  资费代码：34515 资费名称：亲情通业务基础套餐   资费代码：34517   资费名称：亲情通业务升级套餐
	String propCommunity	= "";
	String propDistrict		= "";
	if(!"34517".equals(type_flag)){
	  if("34515".equals(type_flag)) {
		offer_id 			= "34515";	
		}
		if("36724".equals(type_flag)) {
		offer_id 			= "36724";	
		}
		if("36725".equals(type_flag)) {
		offer_id 			= "36725";	
		}
		if("36726".equals(type_flag)) {
		offer_id 			= "36726";	
		}
		if("46865".equals(type_flag)) {
		offer_id 			= "46865";	
		}
		type_flag="01";
		propCommunity	= request.getParameter("propCommunity");	//社区
		propDistrict		= request.getParameter("propDistrict");	//行政区
	}else{
		  offer_id 			= "34517";
		  type_flag="02";
	    propDistrict = 	request.getParameter("propDistrict_select_hidd");	//行政区
	    propCommunity = request.getParameter("propCommunity_select_hidd");   //社区
	}
	String beginTime		= request.getParameter("startTime");	//开始时间
	String endTime			= request.getParameter("endTime");	//结束时间
	String propName			= request.getParameter("custName");	//申请人姓名
	String propSex			= request.getParameter("custSex");	//申请人性别
	String propBirthday		= request.getParameter("propBirthday");	//出生日期
	String propCardNo		= request.getParameter("idNo");	//身份证号

	String propAddress		= request.getParameter("custAddr");	//常住详细地址
	String propTelephone	= request.getParameter("propTelephone");	//申请人常住固话
	String feeFlag			= request.getParameter("feeFlay");	//是否设定付费号码（N-否，Y-是）
	String feePhone			= request.getParameter("feePhone");	//付费号码
	String feePwd			= request.getParameter("password");	//付费号码密码
	String userAccounts		= request.getParameter("userAccounts");	//用户登录帐号
	
	String propUrgentRoutes	= request.getParameter("propUrgentRoutes");	//详述急救车辆到达常住地的路线
	String propLifeStyle	= request.getParameter("propLifestyle");	//申请人生活情况
	String isReportSafe		= request.getParameter("isReportSafe");	//是否需要报平安服务
	String reportCycle		= request.getParameter("reportCycle");	//报平安周期（每x天报一次）
	String reportName		= request.getParameter("reportName");	//报平安接收方姓名
	String reportMobile		= request.getParameter("reportMobile");	//报平安接收方移动电话
	String reportWay		= request.getParameter("reportWay");	//报平安方式选择（01－电话+短信，02－只是短信）
	String famRelaInfoStr	= request.getParameter("famRelaInfoStr");	//普通家属信息串(每个家属的信息之间用'~'进行连接，两个家属之间用'|'进行分割)
	String firstRelaInfoStr	= request.getParameter("firstRelaInfoStr");	//第一联系人信息
	String friRelaInfoStr	= request.getParameter("friRelaInfoStr");	//亲友信息串
	String neiRelaInfoStr	= request.getParameter("neiRelaInfoStr");	//邻居信息串
//	String affectionNoStr	= request.getParameter("affectionNoStr");	//亲情号码串

%>
<wtc:service name="sD076Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=loginAccept%>" />
		<wtc:param value="<%=chnSource%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=loginNo%>" />
		<wtc:param value="<%=loginPwd%>" /><!--5 -->
		<wtc:param value="<%=phoneNo%>" />
		<wtc:param value="<%=userPwd%>" />
		<wtc:param value="<%=type_flag%>" />
		<wtc:param value="<%=offer_id%>" />
		<wtc:param value="<%=beginTime%>" /><!--10 -->
		<wtc:param value="<%=endTime%>" />
		<wtc:param value="<%=propName%>" />
		<wtc:param value="<%=propSex%>" />
		<wtc:param value="<%=propBirthday%>" />
		<wtc:param value="<%=propCardNo%>" /><!--15 -->
		<wtc:param value="<%=propDistrict%>" />
		<wtc:param value="<%=propAddress%>" />
		<wtc:param value="<%=propTelephone%>" />
		<wtc:param value="<%=feeFlag%>" />
		<wtc:param value="<%=feePhone%>" /><!--20 -->
		<wtc:param value="<%=feePwd%>" />
		<wtc:param value="<%=userAccounts%>" />
		<wtc:param value="<%=propCommunity%>" />
		<wtc:param value="<%=propUrgentRoutes%>" />
		<wtc:param value="<%=propLifeStyle%>" /><!--25 -->
		<wtc:param value="<%=isReportSafe%>" />
		<wtc:param value="<%=reportCycle%>" />
		<wtc:param value="<%=reportName%>" />
		<wtc:param value="<%=reportMobile%>" />
		<wtc:param value="<%=reportWay%>" /><!--30 -->
		<wtc:param value="<%=famRelaInfoStr%>" />
		<wtc:param value="<%=firstRelaInfoStr%>" />
		<wtc:param value="<%=friRelaInfoStr%>" />
		<wtc:param value="<%=neiRelaInfoStr%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务sD076Cfm in fd076Cfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("亲情通业务申请成功！",2);
		window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
	</script>
<%
	}else{
		System.out.println("调用服务sD076Cfm in fd076Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
		window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
	</script>
<%
	}
System.out.println("%%%%%%%调用预约服务开始%%%%%%%%"); 	
String iOpCode = 		"d076";
String iLoginNo = 		"";
String iLoginPwd = 		"";
String iPhoneNo = 		phoneNo;
String iUserPwd = 		"";
String inOpNote = 		"";
String iBookingId = 	"";

System.out.println("zhangyan add iOpCode=["+iOpCode+"]");
System.out.println("zhangyan add iLoginNo=["+iLoginNo+"]");
System.out.println("zhangyan add iLoginPwd=["+iLoginPwd+"]");
System.out.println("zhangyan add iPhoneNo=["+iPhoneNo+"]");
System.out.println("zhangyan add iUserPwd=["+iUserPwd+"]");
System.out.println("zhangyan add inOpNote=["+inOpNote+"]");
System.out.println("zhangyan add iBookingId=["+iBookingId+"]");

String booking_url = "/npage/public/pubCfmBookingInfo.jsp?iOpCode="+iOpCode
	+"&iLoginNo="+iLoginNo
	+"&iLoginPwd="+iLoginPwd
	+"&iPhoneNo="+iPhoneNo
	+"&iUserPwd="+iUserPwd
	+"&inOpNote="+inOpNote
	+"&iLoginAccept="+loginAccept
	+"&iBookingId="+iBookingId;		
System.out.println("booking_url="+booking_url);
%>
<jsp:include page="<%=booking_url%>" flush="true" />
<%
System.out.println("%%%%%%%调用预约服务结束%%%%%%%%"); 	
	
	
	
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+ opCode +"&retCodeForCntt="+errCode+
			"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+loginAccept+
			"&pageActivePhone="+phoneNo+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
%>
		<jsp:include page="<%=url%>" flush="true" />
