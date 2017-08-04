<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.14
 模块:统一查询退订
********************/
%>
<%
/*****************************************************
 Copyright (c) SI-TECH  Version V2.0
 All rights reserved
******************************************************/
%>

<%
  /*
   * 功能: 定购关系受理：处理定购关系
　 * 版本: 1.8.2
　 * 日期: 2005/12/08
　 * 作者: bihua
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
　*/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
    //get info from session
   
   	String opCode = "1930";
   	String opName = "统一查询退订";
   	String sysAccept = "";
    String login_no = (String)session.getAttribute("workNo");//工号
    String org_code = (String)session.getAttribute("orgCode");//归属代码
	String login_passwd = (String)session.getAttribute("password");//工号密码

	String idType="01";
	String idValue  = request.getParameter("phoneno");
	String[] cbSpInfo = request.getParameterValues("cancle");
	
	String printAccept  = request.getParameter("printAccept");
	String custidNo  = request.getParameter("custidNo");	
	

	/*王乐 add on 20110527
	String[] bizName = null;
	for(int l = 0; l < cbSpInfo.length; l ++){
		bizName[l]  = request.getParameter("name" + l + "99");
	}*/

	String errCode = "";
	String errMsg = "退订成功";

	String errMsgAll = "";
		
	for(int k=0;k<cbSpInfo.length;k++){
		String tmpStr=cbSpInfo[k];
		System.out.println("=======我是王乐========");
		System.out.println("tmpStr="+tmpStr);
		String[] tmpArr=tmpStr.split(",");
		System.out.println("tmpArr.length="+tmpArr.length);
		for(int s=0;s<tmpArr.length;s++){
			System.out.println("tmpArr["+s+"]="+tmpArr[s]);
		}
		String bizType=tmpArr[0];
		String spCode=tmpArr[1];
		String spBizCode=tmpArr[2];
		
		/*王乐add on 20110531*/		
		String bizName=tmpArr[3];
		
		String iJtId=tmpArr[4];
		String iIntelNkId=tmpArr[5];
		String iFlag=tmpArr[6];
		
		
		//初始话服务所需要的参数
		
		/*王乐 alter on 20110324农信通百事易产品体验版需求
		//添加农信通处理开始
		if("27".equals(bizType)){
			spCode ="";
		}
		//添加农信通处理结束
		*/
		String optype="";
		if(bizType.equals("10")){
		optype = "02";
		}else{
		optype = "07";
		}
String[] paraArray = new String[14];
paraArray[0] = printAccept;
paraArray[1] = "01";
paraArray[2] = "1930";
paraArray[3] = login_no;
paraArray[4] = login_passwd;
paraArray[5] = idValue;
paraArray[6] = "";
paraArray[7] = org_code;
paraArray[8]= bizType;
paraArray[9] = spCode;
paraArray[10] = spBizCode;
paraArray[11] = iJtId;
paraArray[12] = iIntelNkId;
paraArray[13] = iFlag;
	
%>
		<wtc:service  name="sUnifyCfm"  routerKey="phone" routerValue="<%=idValue%>" retcode="retCode" retmsg="retMsg" outnum="9">
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
</wtc:service>


<%
if(!"000000".equals(retCode)){
String regionCode = (String)session.getAttribute("regCode");
	System.out.println("-------hejwa----------printAccept------------>"+printAccept);
	System.out.println("-------hejwa----------custidNo------------>"+custidNo);
 	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
 
 
%>
	<wtc:service name="sUpDserv" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="8" >
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="<%=custidNo%>"/>
		<wtc:param value="<%=dateStr%>"/>
	</wtc:service>
	<wtc:array id="bill_opy" scope="end"/>
<%
}


		errCode = retCode;
		errMsg = retMsg;
		System.out.println("errCode=hejwa===="+errCode);
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+login_no+"&loginAccept="+sysAccept+"&pageActivePhone="+idValue+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;

%>
		
		
		<jsp:include page="<%=url%>" flush="true" />
<%
		int transCount = k + 1;
		errMsgAll = errMsgAll + "第" + transCount + "笔交易(" + bizName + "):" + errMsg + "=====" ;	
	
}
%>
<script language="JavaScript">
        rdShowMessageDialog("<%=errMsgAll%>!",1);
        removeCurrentTab();
</script>


