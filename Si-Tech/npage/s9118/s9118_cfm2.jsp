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
String loginAccept = request.getParameter("loginAccept");
String phoneno  = request.getParameter("phoneno");
String optype  = request.getParameter("optype");
String opcode    = request.getParameter("opCode");//操作码
String NewPasswd = request.getParameter("modiPasswd");
String oldPasswd = request.getParameter("ConfirmPasswd");
String opnote = request.getParameter("opnote");
String thirdNo = WtcUtil.repNull(request.getParameter("thirdNo"));
String oprSource = WtcUtil.repNull(request.getParameter("oprSource"));
String selfIp = (String)session.getAttribute("ipAddr");

System.out.println("loginAccept === "+loginAccept);
if(optype.equals("03")){
	NewPasswd = request.getParameter("modiPasswd");
	oldPasswd = request.getParameter("NewPasswd");
}

String HomeProv = request.getParameter("HomeProv");
String bizType=request.getParameter("busytype");
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

if((bizType.equals("02"))&&(optype.equals("02")||optype.equals("04"))&&value001.equals("10")){
       value001 = "01";
}
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
//互联网电视添加

infocode="";
infovalue="";
String value302=request.getParameter("value302");
String code302=request.getParameter("code302");
if(value302!=null && !value302.equals("")){
        infocode+=code302+"|";
        infovalue+=value302.trim()+"|";
}
String value303=request.getParameter("value303");
String code303=request.getParameter("code303");
if(value303!=null && !value303.equals("")){
        infocode+=code303+"|";
        infovalue+=value303.trim()+"|";
}
String value304=request.getParameter("value304");
String code304=request.getParameter("code304");
if(value304!=null && !value304.equals("")){
        infocode+=code304+"|";
        infovalue+=value304.trim()+"|";
}
String value305=request.getParameter("value305");
String code305=request.getParameter("code305");
if(value305!=null && !value305.equals("")){
        infocode+=code305+"|";
        infovalue+=value305.trim()+"|";
}
String value311=request.getParameter("value311");
String code311=request.getParameter("code311");
if(value311!=null && !value311.equals("")){
        infocode+=code311+"|";
        infovalue+=value311.trim()+"|";
}
String value307=request.getParameter("value307");
if(value307!=null && !value307.equals("")){
        infocode+="307|";
        infovalue+=value307.trim()+"|";
}
 infocode+="313|";
 infovalue+=loginAccept+"|";
//
String cmgp001=request.getParameter("cmgp001");
if(bizType.equals("28")&&optype.equals("21")){//游戏平台充值
	if(cmgp001!=null && cmgp001.length()>0){
		infovalue=cmgp001;
	}
	else{
		infovalue="0";
	}
}
//初始话服务所需要的参数
String[] paraArray = new String[24];
paraArray[0] = loginAccept;
paraArray[1] = "01";
paraArray[2] = "9118";
paraArray[3] = workNo;
paraArray[4] = login_passwd;
paraArray[5] = phoneno;
paraArray[6] = "";
paraArray[7] = org_code;
paraArray[8]= idType;
paraArray[9] = optype;//交易类型01、06
paraArray[10] = bizType;
paraArray[11] = value302;//20160825 修改传机顶盒id供校验
paraArray[12] = NewPasswd;
paraArray[13] = spCode;
paraArray[14] = spBizCode;
paraArray[15] = infocode;
paraArray[16] = infovalue;
paraArray[17] = "";
//魔百合增加押金
paraArray[18] = value307;
//宽带单独传以便校验
paraArray[19] = value303;
paraArray[20] = selfIp;
paraArray[21] = thirdNo;
paraArray[22] = oprSource;
paraArray[23] = "1";

for(int j=0;j<21;j++){
    System.out.println("paraArray["+j+"]="+paraArray[j]);
}
%>
<wtc:service  name="s9113Cfm"  routerKey="phone" routerValue="<%=phoneno%>" retcode="retCode" retmsg="retMsg" outnum="9">
    <wtc:param  value="<%=paraArray[0]%>"/>	
    <wtc:param  value="<%=paraArray[1]%>"/>
    <wtc:param  value="<%=paraArray[2]%>"/>
    <wtc:param  value="<%=paraArray[3]%>"/>
    <wtc:param  value="<%=paraArray[4]%>"/>
    
    <wtc:param  value="<%=paraArray[5]%>"/>
    <wtc:param  value="<%=paraArray[6]%>"/>
    <wtc:param  value="<%=paraArray[7]%>"/>
    <wtc:param  value="<%=paraArray[8]%>"/>
    <wtc:param  value="<%=paraArray[9]%>"/>
    
    <wtc:param  value="<%=paraArray[10]%>"/>
    <wtc:param  value="<%=paraArray[11]%>"/>
    <wtc:param  value="<%=paraArray[12]%>"/>
    <wtc:param  value="<%=paraArray[13]%>"/>
    <wtc:param  value="<%=paraArray[14]%>"/>
    
    <wtc:param  value="<%=paraArray[15]%>"/>
    <wtc:param  value="<%=paraArray[16]%>"/>
    <wtc:param  value="<%=paraArray[17]%>"/>
    <wtc:param  value="<%=paraArray[18]%>"/>
    <wtc:param  value="<%=paraArray[19]%>"/>
    
    <wtc:param  value="<%=paraArray[20]%>"/>
    <wtc:param  value="<%=paraArray[21]%>"/>
    <wtc:param  value="<%=paraArray[22]%>"/>
    <wtc:param  value="<%=paraArray[23]%>"/>
</wtc:service>
<%
System.out.println("===========retCode===="+retCode);
//----------------------------
 System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/onceCnttInfo.jsp?opCode="+"9113"+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg
    +"&opName="+"用户信息服务功能受理"+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneno+"&opBeginTime="+opBeginTime+"&contactId="+phoneno+"&contactType=user";
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
//----------------------------

if(!retCode.equals("000000")){%>
	<script language="JavaScript">
	    rdShowMessageDialog("业务受理失败，原因：<%=retMsg%>!",0);
	    history.go(-1);
	</script>
<%
}
else{
%>
	<script language="JavaScript">
	   	rdShowMessageDialog("<%=retMsg%>!",2);
	   	removeCurrentTab();
	</script>
<%
}
%>
