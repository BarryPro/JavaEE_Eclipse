<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-10
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	String op_code = request.getParameter("op_code");          /*操作代码*/
	String loginAccept = request.getParameter("sysAccept");;  /*操作流水*/
	System.out.println("()()()()()()()()()()()()()()()()"+loginAccept);
	String phoneno = request.getParameter("phoneno");
	String strOpType = request.getParameter("op_type");
	String strUnPayLevel = request.getParameter("UnPayLevel");
	String strUnPayFrom = request.getParameter("UnPayFrom");
	String strSpEnterCode = request.getParameter("spEnterCode");
	String strSpTranCode = request.getParameter("spTranCode");
	String strSpTranName = request.getParameter("spTranName");
	String strSpTranType = request.getParameter("spTranType");
	String strSpMark = request.getParameter("sp_mark");
	String strOpMark = request.getParameter("op_mark");
	String strFeeMoney = request.getParameter("feeMoney");//退费金额
	String strBackMoney = request.getParameter("backMoney");//补收金额
	//String strBackPreMoney = request.getParameter("backPreMoney"); //退费现金
	String strBackPreMoney = "0"; //退费现金
	String strCompMoney = request.getParameter("compMoney"); //赔偿金额
	String strUseingTime = request.getParameter("useing_time"); //使用时间
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	
	String pass = (String)session.getAttribute("password");
	
	String paraAray[] = new String[19]; 
	
	System.out.println("strOpType="+strOpType);
	
	if (strOpType.equals("a")){ 
	  System.out.println("inser into \n");
		paraAray[0] = work_no;  		//操作工号
		paraAray[1] = pass;  				//操作密码
		paraAray[2] = loginAccept; 	//流水
		paraAray[3] = op_code; 			//操作代代码
		paraAray[4] = phoneno;			//用户号码
		paraAray[5] = strOpType;		//操作类型
		paraAray[6] = strUnPayLevel;   //退费标示
		paraAray[7] = strUnPayFrom; //退费责任
		paraAray[8] = strSpEnterCode;  //Sp企业代码
		paraAray[9] = strSpTranCode; //业务代码
		paraAray[10] = strSpTranName;	//业务名称
		paraAray[11] = strSpTranType;	//业务类型
		paraAray[12] = strSpMark;	    //退费原因描述
		paraAray[13] = strOpMark;	    //操作备注 
		paraAray[14] = strFeeMoney;	  //退费金额
		paraAray[15] = strBackMoney;	//补收金额 
		paraAray[16] = strBackPreMoney;	//现金预存金额 
		paraAray[17] = strCompMoney;	//赔偿金额 
		paraAray[18] = strUseingTime;	//使用时间 
	}else{
		System.out.println("delete into \n");
		paraAray[0] = work_no;  		//操作工号
		paraAray[1] = pass;  				//操作密码
		paraAray[2] = loginAccept; 	//流水
		paraAray[3] = op_code; 			//操作代代码
		paraAray[4] = phoneno;			//用户号码
		paraAray[5] = strOpType;		//操作类型
		paraAray[6] = "0";   //退费标示
		paraAray[7] = "0"; //退费责任
		paraAray[8] = strSpEnterCode;  //Sp企业代码
		paraAray[9] = strSpTranCode; //业务代码
		paraAray[10] = "0";	//业务名称
		paraAray[11] = "0";	//业务类型
		paraAray[12] = "0";	    //退费原因描述
		paraAray[13] = "0";	    //操作备注
		paraAray[14] = "0";	  //退费金额
		paraAray[15] = "0";	//补收金额 
		paraAray[16] = "0";	//退费金额 	
		paraAray[17] = "0";	//赔偿金额 	
		paraAray[18] = "0";	//使用时间 
	}
	

	//String[] ret = impl.callService("s1469Cfm",paraAray,"1","phone",phoneno);
	System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+paraAray[2]);
%>
<wtc:service name="s1469Cfm" routerKey="phone" routerValue="<%=phoneno%>" retcode="s1469CfmCode" retmsg="s1469CfmMsg" outnum="2" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/> 
    <wtc:param value="<%=paraAray[2]%>"/>
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    
    <wtc:param value="<%=paraAray[5]%>"/>
    <wtc:param value="<%=paraAray[6]%>"/>
    <wtc:param value="<%=paraAray[7]%>"/>
    <wtc:param value="<%=paraAray[8]%>"/>
    <wtc:param value="<%=paraAray[9]%>"/>
    
    <wtc:param value="<%=paraAray[10]%>"/>
    <wtc:param value="<%=paraAray[11]%>"/>
    <wtc:param value="<%=paraAray[12]%>"/>
    <wtc:param value="<%=paraAray[13]%>"/>
    <wtc:param value="<%=paraAray[14]%>"/>
    
    <wtc:param value="<%=paraAray[15]%>"/>
    <wtc:param value="<%=paraAray[16]%>"/>
    <wtc:param value="<%=paraAray[17]%>"/>
    <wtc:param value="<%=paraAray[18]%>"/>
</wtc:service>
<wtc:array id="s1469CfmArr" scope="end"/>
<%
	String retCode= s1469CfmCode;
	String retMsg = s1469CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
	//int errCode = impl.getErrCode();
	
	 System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+"1469"+"&retCodeForCntt="+retCode+"&opName="+"全网sp业务退费"+"&workNo="+work_no+"&loginAccept="+s1469CfmArr[0][0]+"&pageActivePhone="+phoneno+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");

	String errMsg = s1469CfmMsg;
	//String loginAccept = "";
	if (s1469CfmArr.length > 0 && s1469CfmCode.equals("000000"))
	{
	loginAccept = s1469CfmArr[0][0]; 
	System.out.println("success");
%>
<script language="JavaScript">
	rdShowMessageDialog("SP全网退费业务处理成功！",2);
	window.location="../s1300/s1300.jsp?opCode=1300&opName=缴费";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("SP全网退费业务失败: <%=retCode%>",0);
	window.location="s1469.jsp?opCode=1469&opName=全网sp业务退费";
	</script>
<%}
%>

