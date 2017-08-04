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
	/*String loginAccept	    = "";	//流水*/
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
	String offerId		= request.getParameter("offerId");	//套餐类型（01－基础	套餐，02－升级套餐）
	System.out.println("wanghyd----type_flag--1--"+type_flag);  
	System.out.println("wanghyd----offerId----"+offerId);                                   
	String propDistrict		= "";
	String propCommunity	= "";
	String ofrId=request.getParameter("ofrId");
	System.out.println("d077~~~~ofrId="+ofrId);
	

	if("34515".equals(offerId)) {
		type_flag ="01";	
	}
	if("34517".equals(offerId)) {
		type_flag ="02";	
	}
	if("36724".equals(offerId)) {
		type_flag ="01";	
	}
	if("36725".equals(offerId)) {
		type_flag ="01";	
	}
	if("36726".equals(offerId)) {
		type_flag ="01";	
	}
	if("46865".equals(offerId)) {
		type_flag ="01";	
	}
	System.out.println("wanghyd----type_flag--2--"+type_flag); 
	if("02".equals(type_flag)){ 
	    propDistrict = 	request.getParameter("propDistrict_select_hidd");	//行政区
	    propCommunity = request.getParameter("propCommunity_select_hidd");   //社区
	}else if("01".equals(type_flag)){
	    propDistrict = request.getParameter("propDistrict");	//行政区
	    propCommunity = request.getParameter("propCommunity");	//社区
	}       
	
	String propAddress		= request.getParameter("custAddr");	//常住详细地址      													                                                        
	String propTelephone	= request.getParameter("propTelephone");	//申请人常住固话    													                                                        
	String feeFlag			= request.getParameter("feeFlay");	//是否设定付费号码（N-否，Y-是）                                            
	String feePhone			= request.getParameter("feePhone");	//付费号码          													                                                        
	String feePwd			= request.getParameter("feePwdEnd");	//付费号码密码      													                                                        
	String userAccounts		= request.getParameter("userAccounts");	//用户登录帐号      													                                                        
	String propUrgentRoutes	= request.getParameter("propUrgentRoutes");	//详述急救车辆到达常住地的路线                                              
	String propLifestyle	= request.getParameter("propLifestyle");	//申请人生活情况    													                                                        
	String isReportSafe		= request.getParameter("isReportSafe");	//是否需要报平安服务													                                                        
	String reportCycle		= request.getParameter("reportCycle");	//报平安周期（每x天报一次）
	String reportName		= request.getParameter("reportName");	//报平安接收方姓名  													                                                        
	String reportMobile		= request.getParameter("reportMobile");	//报平安接收方移动电话                                                      
	String reportWay		= request.getParameter("reportWay");	//报平安方式选择（01－电话+短信，02－只是短信）                             
	String famRelaInfoStr	= request.getParameter("famRelaInfoStr");	//普通家属信息串(每个家属的信息之间用'~'进行连接，两个家属之间用'|'进行分割)
	String firstRelaInfoStr	= request.getParameter("firstRelaInfoStr");	//第一联系人信息    													                                                        
	String friRelaInfoStr	= request.getParameter("friRelaInfoStr");	//亲友信息串        													                                                        
	String neiRelaInfoStr	= request.getParameter("neiRelaInfoStr");	//邻居信息串 
	String propSex	= request.getParameter("custSex");	//邻居信息串 	
	String propBirthday		= request.getParameter("propBirthday");	//出生日期
	String phoneList	= request.getParameter("phoneList");	//删除的电话号码拼串
	String opFlag	= request.getParameter("opFlag");	//资费变更还是信息变更
	      													                                                        
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<wtc:service name="sD077Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=loginAccept%>" />
		<wtc:param value="<%=chnSource%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=loginNo%>" />
		<wtc:param value="<%=loginPwd%>" />
		<wtc:param value="<%=phoneNo%>" />
		<wtc:param value="<%=userPwd%>" />
		<wtc:param value="<%=type_flag%>" />
		<wtc:param value="<%=propDistrict%>" />
		<wtc:param value="<%=propAddress%>" />
		<wtc:param value="<%=propTelephone%>" />
		<wtc:param value="<%=feeFlag%>" />
		<wtc:param value="<%=feePhone%>" />
		<wtc:param value="<%=feePwd%>" />
		<wtc:param value="<%=userAccounts%>" />
		<wtc:param value="<%=propCommunity%>" />
		<wtc:param value="<%=propUrgentRoutes%>" />
		<wtc:param value="<%=propLifestyle%>" />
		<wtc:param value="<%=isReportSafe%>" />
		<wtc:param value="<%=reportCycle%>" />
		<wtc:param value="<%=reportName%>" />
		<wtc:param value="<%=reportMobile%>" />
		<wtc:param value="<%=reportWay%>" />
		<wtc:param value="<%=famRelaInfoStr%>" />
		<wtc:param value="<%=firstRelaInfoStr%>" />
		<wtc:param value="<%=friRelaInfoStr%>" />
		<wtc:param value="<%=neiRelaInfoStr%>" />
		<wtc:param value="<%=propSex%>" />
		<wtc:param value="<%=propBirthday%>" />		
		<wtc:param value="<%=phoneList%>" />					
		<wtc:param value="<%=ofrId%>" />					
		<wtc:param value="<%=opFlag%>" />					
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务sD077Cfm in fd077Cfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("亲情通业务变更成功！");
		window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
	</script>
<%
	}else{
		System.out.println("调用服务sD077Cfm in fd077Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
	</script>
<%
	}
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+ opCode +"&retCodeForCntt="+errCode+
			"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+loginAccept+
			"&pageActivePhone="+phoneNo+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
%>
		<jsp:include page="<%=url%>" flush="true" />
