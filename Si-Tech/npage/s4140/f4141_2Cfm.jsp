<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	String op_code = request.getParameter("op_code");              //操作代码
	String loginAccept = request.getParameter("backaccept");;       //操作流水
	System.out.println("()()()()()()()()()()()()()()()()"+loginAccept);
	String phoneno = request.getParameter("phoneno");              //投诉电话号码
	String acceptno = request.getParameter("acceptno");            //投诉电子流水
	String FirstClass = request.getParameter("FirstClass");        //退费一级原因
	String SecondClass = request.getParameter("SecondClass");      //退费二级原因
	String ThirdClass = request.getParameter("ThirdClass");        //退费三级原因
	String strBackMoney = request.getParameter("backMoney");       //退费金额
	String strCompMoney = request.getParameter("compMoney");       //赔偿金额
	String op_note = request.getParameter("op_note");              //备注
	String UnPayKindcode = request.getParameter("UnPayKindcode");  //退费种类code
	
	String work_no = (String)session.getAttribute("workNo");       
	String loginName = (String)session.getAttribute("workName");   
	String org_code = (String)session.getAttribute("orgCode");	
	String pass = (String)session.getAttribute("password");
	
	System.out.println("inser into \n");
	System.out.println("org_Code============"+org_Code);
	System.out.println("regionCode============"+regionCode);
	System.out.println("op_code============"+op_code);
	System.out.println("loginAccept============"+loginAccept);
	System.out.println("phoneno============"+phoneno);
	System.out.println("acceptno============"+acceptno);
	System.out.println("FirstClass============"+FirstClass);
	System.out.println("SecondClass============"+SecondClass);
	System.out.println("ThirdClass============"+ThirdClass);
	System.out.println("strBackMoney============"+strBackMoney);
	System.out.println("strCompMoney============"+strCompMoney);
	System.out.println("op_note============"+op_note);
	System.out.println("work_no============"+work_no);
	System.out.println("loginName============"+loginName);
	System.out.println("org_code============"+org_code);
	System.out.println("pass============"+pass);

	String paraAray[] = new String[12]; 
	paraAray[0] = loginAccept; 	        //操作流水
	paraAray[1] = "01";  				//渠道标识
	paraAray[2] = op_code; 			    //操作代码
	paraAray[3] = work_no;  		    //操作工号
	paraAray[4] = pass;			    //工号密码
	paraAray[5] = phoneno;  		    //投诉电话号码
	paraAray[6] = "";			    //号码密码	
	paraAray[7] = acceptno;             //投诉电子流水
	paraAray[8] = strCompMoney;	        //赔偿金额 
	paraAray[9] = op_note;              //备注
	paraAray[10] = org_Code;    //归属代码
	paraAray[11] = UnPayKindcode;        //退费种类code

%>
<wtc:service name="s4141_2Cfm" routerKey="phone" routerValue="<%=phoneno%>" retcode="s4141_2CfmCode" retmsg="s4141_2CfmMsg" outnum="2" >
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
</wtc:service>
<wtc:array id="s4141_2CfmArr" scope="end"/>
<%
	String retCode= s4141_2CfmCode;
	String retMsg = s4141_2CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
	System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+"4141"+"&retCodeForCntt="+retCode+"&opName="+"投诉退费"+"&workNo="+work_no+"&loginAccept="+s4141_2CfmArr[0][0]+"&pageActivePhone="+phoneno+"&retMsgForCntt="+retMsg;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");

	String errMsg = s4141_2CfmMsg;
	if (s4141_2CfmArr.length > 0 && s4141_2CfmCode.equals("000000"))
	{
	loginAccept = s4141_2CfmArr[0][0]; 
	System.out.println("success");
%>
<script language="JavaScript">
	rdShowMessageDialog("投诉退费冲正处理成功！",2);
	window.location="../s4140/f4141.jsp?opCode=4141&opName=投诉退费";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("投诉退费冲正处理失败: <%=retMsg%>",0);
	window.location="f4141.jsp?opCode=4141&opName=投诉退费";
	</script>
<%}
%>

