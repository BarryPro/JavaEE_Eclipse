
<%
/********************
version v2.0
开发商: si-tech
模块：家庭合帐提交
日期：2013-4-27 14:09:08
作者：hejwa
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
	String error_code = "";
  String error_msg  = "";
	
	String nopass           = (String)session.getAttribute("password");
  String loginName        = (String)session.getAttribute("workName");
	String work_no          = (String)session.getAttribute("workNo");
	String org_code         = (String)session.getAttribute("orgCode");
	String regionCode       = (String)session.getAttribute("regCode");
	                        
	String iipAddr          = request.getRemoteAddr();   
	                        
	String opCode           = WtcUtil.repNull(request.getParameter("opCode"));
	String opName           = WtcUtil.repNull(request.getParameter("opName"));	
	String phoneNo          = WtcUtil.repNull(request.getParameter("srv_no"));
	String iloginAccept     = WtcUtil.repNull(request.getParameter("sysAccept"));
	String iopType          = WtcUtil.repNull(request.getParameter("opType"));
  String srv_no           = WtcUtil.repNull(request.getParameter("srv_no"));
	String cus_pass         = WtcUtil.repNull(request.getParameter("cus_pass"));
	String ipayFee          = WtcUtil.repNull(request.getParameter("oriHandFee"));
	String irealFee         = WtcUtil.repNull(request.getParameter("t_handFee"));
	String isystemNote      = WtcUtil.repNull(request.getParameter("t_sys_remark"));
	String iopNote          = WtcUtil.repNull(request.getParameter("t_op_remark"));
	String famContractNo    = WtcUtil.repNull(request.getParameter("famContractNo"));
	
	String memPhoneStr      = "";
	String defContNoStr     = "";
	String feeLimitStr      = "";
	String payorderStr      = "";
	String feeFlagStr       = "";
	String detFlagStr       = "";
	String rateFlagStr      = "";
	String stopflagStr      = "";
	String feeratioStr      = "";
	String orderNewStr      = "";
	
	String memPhoneArr[]    = new String[]{}; 
	String defContNoArr[]   = new String[]{}; 
	String feeLimitArr[]    = new String[]{}; 
	String payorderArr[]    = new String[]{}; 
	String feeFlagArr[]     = new String[]{}; 
	String detFlagArr[]     = new String[]{}; 
	String rateFlagArr[]    = new String[]{}; 
	String stopflagArr[]    = new String[]{}; 
	String feeratioArr[]    = new String[]{}; 
	String orderNewArr[]    = new String[]{}; 
	
						memPhoneStr   = WtcUtil.repNull(request.getParameter("memPhoneArray"));
						defContNoStr  = WtcUtil.repNull(request.getParameter("defContNoArray"));
						feeLimitStr   = WtcUtil.repNull(request.getParameter("feeLimitArray"));
						payorderStr   = WtcUtil.repNull(request.getParameter("payorderArray"));
						feeFlagStr    = WtcUtil.repNull(request.getParameter("feeFlagArray"));
						detFlagStr    = WtcUtil.repNull(request.getParameter("detFlagArray"));
						rateFlagStr   = WtcUtil.repNull(request.getParameter("rateFlagArray"));
						stopflagStr   = WtcUtil.repNull(request.getParameter("stopflagArray"));
						feeratioStr   = WtcUtil.repNull(request.getParameter("feeratioArray"));
						orderNewStr   = WtcUtil.repNull(request.getParameter("orderNewArray"));
						
					  memPhoneArr   = memPhoneStr.split(",");//手机号数组   
					  defContNoArr  = defContNoStr.split(",");//默认付费账户 
					  feeLimitArr   = feeLimitStr.split(",");//限额       
					  payorderArr   = payorderStr.split(",",-1);//冲销顺序     
					  feeFlagArr    = feeFlagStr.split(",",-1);//费用代码     
					  detFlagArr    = detFlagStr.split(",",-1);//明细代码     
					  rateFlagArr   = rateFlagStr.split(",",-1);//是否明细     
					  stopflagArr   = stopflagStr.split(",",-1);//固定值Y   
					  feeratioArr   = feeratioStr.split(",",-1);//费用比率    
					  orderNewArr   = orderNewStr.split(",",-1);//固定值1  
					  
		System.out.println("hejwa------------memPhoneArray----------------------"+memPhoneStr);
		System.out.println("hejwa------------defContNoArray---------------------"+defContNoStr);
		System.out.println("hejwa------------feeLimitArray----------------------"+feeLimitStr);
		System.out.println("hejwa------------payorderArray----------------------"+payorderStr);
		System.out.println("hejwa------------feeFlagArray-----------------------"+feeFlagStr);
		System.out.println("hejwa------------detFlagArray-----------------------"+detFlagStr);
		System.out.println("hejwa------------rateFlagArray----------------------"+rateFlagStr);
		System.out.println("hejwa------------stopflagArray----------------------"+stopflagStr);
		System.out.println(feeratioArr.length+"hejwa------------feeratioArray----------------------"+feeratioStr);
		System.out.println("hejwa------------orderNewArray----------------------"+orderNewStr);
 
%>
		<wtc:service name="sG630Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="code" retmsg="msg" outnum="2" >
		    <wtc:param value="<%=iloginAccept%>"/>
		    <wtc:param value="01"/>		            
        <wtc:param value="<%=opCode%>"/>      
        <wtc:param value="<%=work_no%>"/>     
        <wtc:param value="<%=nopass%>"/>      
        <wtc:param value="<%=srv_no%>"/>      
        <wtc:param value="<%=cus_pass%>"/>    
        <wtc:param value="<%=famContractNo%>"/> 
        <wtc:param value="<%=iopType%>"/>     
        <wtc:param value="<%=ipayFee%>"/>     
        <wtc:param value="<%=irealFee%>"/>    
        <wtc:param value="<%=isystemNote%>"/> 
        <wtc:param value="<%=iopNote%>"/>     
        <wtc:param value="<%=iipAddr%>"/>     
        <wtc:param value="<%=org_code%>"/>    
        <wtc:params value="<%=memPhoneArr%>"/>
        <wtc:params value="<%=rateFlagArr%>"/> 
        <wtc:params value="<%=orderNewArr%>"/>
        <wtc:params value="<%=feeLimitArr%>"/>
        <wtc:params value="<%=stopflagArr%>"/> 
        <wtc:params value="<%=feeFlagArr%>"/> 
				<wtc:params value="<%=detFlagArr%>"/> 
        <wtc:params value="<%=feeratioArr%>"/>  
		</wtc:service>			
<%	 
  error_code = code;
  error_msg  = msg;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+error_code+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+iloginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+error_msg+"&opBeginTime="+opBeginTime; 
	System.out.println(url);	
%>
<jsp:include page="<%=url%>" flush="true"/>
<%if(error_code.equals("000000")){%>
		<script>
	  	rdShowMessageDialog("家庭合帐业务操作成功！",2);
      location="familyAccountLogin.jsp?activePhone=<%=srv_no%>&opCode=<%=opCode%>&opName=<%=opName%>";
	  </script>
<%}else{%>
		<script>
	  	rdShowMessageDialog('错误<%=error_msg%>，请重新操作！',0);
    	location="familyAccountLogin.jsp?activePhone=<%=srv_no%>&opCode=<%=opCode%>&opName=<%=opName%>";
	 	</script>
<%}%>
