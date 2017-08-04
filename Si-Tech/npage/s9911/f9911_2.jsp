<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
String workNo = (String)session.getAttribute("workNo");
String workName = (String)session.getAttribute("workName");
String regionCode=(String)session.getAttribute("regCode");
String op_name =  "订购关系受理";
//ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
//String[][] baseInfoSession = (String[][])arrSession.get(0);
//String[][] fiveInfoSession = (String[][])arrSession.get(4);
String org_code = (String)session.getAttribute("orgCode");//归属代码
String login_passwd = (String)session.getAttribute("password");//工号密码
String region_code = org_code.substring(0,2);

String idType="01";
String phoneno  = request.getParameter("phoneno");
String optype  = request.getParameter("optype");
String opcode    = request.getParameter("opCode");//操作码
String NewPasswd = request.getParameter("NewPasswd");
String oldPasswd = request.getParameter("ConfirmPasswd");
String opnote = request.getParameter("opnote");
String thirdNo = WtcUtil.repNull(request.getParameter("thirdNo"));
String oprSource = WtcUtil.repNull(request.getParameter("oprSource"));
String selfIp = (String)session.getAttribute("ipAddr");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=phoneno%>" id="seq"/>
<%
String loginAccept = seq;
System.out.println("loginAccept === "+loginAccept);
if(optype.equals("03")){
	NewPasswd = request.getParameter("modiPasswd");
	oldPasswd = request.getParameter("NewPasswd");
}

String HomeProv = request.getParameter("HomeProv");
String bizType=request.getParameter("busytype");


String busytypeHit=request.getParameter("busytypeHit");
String bizTypeTemp = bizType;
if(bizType.equals("Y2")||bizType.equals("Y5")||bizType.equals("16")){
	bizType = busytypeHit;  //手机邮箱赋值处理  hejwa add 2010年3月10日18:02:38
}

System.out.println("----------------bizType-----------------"+bizType);
if(bizType.equals("50")){//新业务套餐按MMS处理
	bizType="05";
}
String spCode=request.getParameter("spCode");
if(spCode!=null){
	spCode=spCode.trim();
}
String spBizCode=request.getParameter("spBizCode");
if(spBizCode!=null){
	spBizCode=spBizCode.trim();
}
String infocode="";
String infovalue="";

String value001=request.getParameter("value001");
String code001=request.getParameter("code001");
if(value001!=null && !value001.equals("")){
        infocode+=code001+"|";
        infovalue+=value001.trim()+"|";
}
String value002=request.getParameter("value002");
String code002=request.getParameter("code002");
if(value002!=null && !value002.equals("")){
        infocode+=code002+"|";
        infovalue+=value002.trim()+"|";
}
String value003=request.getParameter("value003");
String code003=request.getParameter("code003");
if(value003!=null && !value003.equals("")){
        infocode+=code003+"|";
        infovalue+=value003.trim()+"|";
}
String value004=request.getParameter("value004");
String code004=request.getParameter("code004");
if(value004!=null && !value004.equals("")){
        infocode+=code004+"|";
        infovalue+=value004.trim()+"|";
}
String value300=request.getParameter("value300");
String code300=request.getParameter("code300");
if(value300!=null && !value300.equals("")){
        infocode+=code300+"|";
        infovalue+=value300.trim()+"|";
}
String value301=request.getParameter("value301");
String code301=request.getParameter("code301");
if(value301!=null && !value301.equals("")){
        infocode+=code301+"|";
        infovalue+=value301.trim()+"|";
}
String cmgp001=request.getParameter("cmgp001");
if(bizType.equals("28")&&optype.equals("21")){//游戏平台充值
	if(cmgp001!=null && cmgp001.length()>0){
		infovalue=cmgp001;
	}
	else{
		infovalue="0";
	}
}
 


String iLoginAccept = "0";                            //业务流水(iLoginAccept)
String iChnSource=request.getParameter("iChnSource"); //渠道标识(iChnSource)
String iOpCode = "9113";                              //操作代码(iOpCode)
String iLoginNo = workNo;                             //工号(iLoginNo)
String iLoginPwd = login_passwd;                      //工号密码(iLoginPwd）
String iPhoneNo = phoneno;                            //号码(iPhoneNo)
String iUserPwd = "";                                 //号码密码(iUserPwd)
String inOpCode = bizType;                            //用户指令(inOpCode)
String inPlatformCod = "01";                          //发起标识(inPlatformCod)

System.out.println("------------------------iLoginAccept--------------------------"+iLoginAccept);
System.out.println("------------------------iChnSource----------------------------"+iChnSource);
System.out.println("------------------------iOpCode-------------------------------"+iLoginAccept);
System.out.println("------------------------iLoginNo------------------------------"+iLoginNo);
System.out.println("------------------------iLoginPwd-----------------------------"+iLoginPwd);
System.out.println("------------------------iPhoneNo------------------------------"+iPhoneNo);
System.out.println("------------------------iUserPwd------------------------------"+iUserPwd);
System.out.println("------------------------inOpCode------------------------------"+inOpCode);
System.out.println("------------------------inPlatformCod-------------------------"+inPlatformCod);


%>
<wtc:service  name="s9911Cfm"  routerKey="phone" routerValue="<%=phoneno%>" retcode="retCode1" retmsg="retMsg1" outnum="3">
    <wtc:param  value="<%=iLoginAccept%>"/>	
    <wtc:param  value="<%=iChnSource%>"/>	
    <wtc:param  value="<%=iOpCode%>"/>	
    <wtc:param  value="<%=iLoginNo%>"/>	
    <wtc:param  value="<%=iLoginPwd%>"/>	
    <wtc:param  value="<%=iPhoneNo%>"/>	
    <wtc:param  value="<%=iUserPwd%>"/>	
    <wtc:param  value="<%=inOpCode%>"/>	
    <wtc:param  value="<%=inPlatformCod%>"/>	
</wtc:service>
	
<%

System.out.println("------s9911Cfm------retCode1----------"+retCode1);
System.out.println("------s9911Cfm------retMsg1----------"+retMsg1);
if(!retCode1.equals("000000")){%>
	<script language="JavaScript">
	    rdShowMessageDialog("业务受理失败，原因：<%=retMsg1%>!",0);
	    history.go(-1);
	</script>
<%
}
else{
%>
	<script language="JavaScript">
	   	rdShowMessageDialog("<%=retMsg1%>!",2);
	    location.href="f9911_1.jsp";
	</script>
<%
	
} %>