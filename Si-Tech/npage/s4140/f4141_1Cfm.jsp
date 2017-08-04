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
	String loginAccept = request.getParameter("sysAccept");;       //操作流水
	System.out.println("()()()()()()()()()()()()()()()()"+loginAccept);
	String phoneno = request.getParameter("phoneNo");              //投诉电话号码
	String acceptno = request.getParameter("acceptno");            //投诉电子流水
	String FirstClass = request.getParameter("FirstClass");        //退费一级原因
	String SecondClass = request.getParameter("SecondClass");      //退费二级原因
	String ThirdClass = request.getParameter("ThirdClass");        //退费三级原因
	String strUnPayLevel = request.getParameter("UnPayLevel");     //退费类型
	String strSpEnterCode = request.getParameter("spEnterCode");   //sp企业代码
	String strSpTranCode = request.getParameter("spTranCode");     //业务代码
	String useing_time = request.getParameter("useing_time");      //sp首次使用时间
	String op_time = request.getParameter("op_time");              //操作时间
	String end_time = request.getParameter("end_time");            //结束时间
	String strBackMoney = request.getParameter("backMoney1");      //退费金额
	String strCompMoney = request.getParameter("compMoney");       //赔偿金额
	String op_note = request.getParameter("op_note");              //备注
	String strUnPayKind = request.getParameter("UnPayKind");       //退费种类
	
	String work_no = (String)session.getAttribute("workNo"); 
	
	//work_no="800195";

	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	//xl add for zhangshuo
	String dj = request.getParameter("dj");       //单价
	String sl = request.getParameter("sl");       //数量
	
	String paraAray[] = new String[27]; 
	
	System.out.println("inser into \n");
	System.out.println("SSSSSSSSSSSSSSSSSSSSS dj is ========"+dj+" and sl is "+sl);
	System.out.println("regionCode============"+regionCode);
	System.out.println("op_code============"+op_code);
	System.out.println("loginAccept============"+loginAccept);
	System.out.println("phoneno============"+phoneno);
	System.out.println("acceptno============"+acceptno);
	System.out.println("FirstClass============"+FirstClass);
	System.out.println("SecondClass============"+SecondClass);
	System.out.println("ThirdClass============"+ThirdClass);
	System.out.println("strUnPayLevel============"+strUnPayLevel);
	System.out.println("strSpEnterCode============"+strSpEnterCode);
	System.out.println("strSpTranCode============"+strSpTranCode);
	System.out.println("useing_time============"+useing_time);
	System.out.println("op_time============"+op_time);
	System.out.println("end_time============"+end_time);
	System.out.println("strBackMoney============"+strBackMoney);
	System.out.println("strCompMoney============"+strCompMoney);
	System.out.println("op_note============"+op_note);
	System.out.println("work_no============"+work_no);
	System.out.println("loginName============"+loginName);
	System.out.println("org_Code============"+org_Code);
	System.out.println("pass============"+pass);
	System.out.println("strUnPayKind============"+strUnPayKind);
	/*xl add new 共有： 核减类型 计费类型 业务使用时间 核减时间 */
	String hjlx = "";
	String jflx = "";
	String ywsysj = "";
	String hjsj = "";
	hjlx = request.getParameter("kjlx");
	jflx = request.getParameter("jflx");
	ywsysj = request.getParameter("ywsysj");
	hjsj = request.getParameter("hjsj");
	/*xl add for ivrFlag*/
	String ivrFlag="";
    ivrFlag = request.getParameter("ivrflag");
	
	//xl add for gongjian
	String spname = request.getParameter("spname");
	
	//xl add for fanyan
	String spywname = request.getParameter("spywname");
	paraAray[0] = loginAccept;  		    //操作流水
	paraAray[1] = "01";  				//渠道标识
	paraAray[2] = op_code; 	        //操作代码
	paraAray[3] = work_no; 			    //操作工号
	paraAray[4] = pass;			    //工号密码
	paraAray[5] = phoneno; 			    //投诉电话号码
	paraAray[6] = "";			    //号码密码	
	paraAray[7] = acceptno;             //投诉电子流水
	paraAray[8] = strUnPayLevel;        //退费类型
	paraAray[9] = FirstClass;           //退费一级原因code
	paraAray[10] = SecondClass;          //退费二级原因code
	paraAray[11] = ThirdClass;           //退费三级原因code
	paraAray[12] = strSpEnterCode;      //Sp企业代码
	paraAray[13] = strSpTranCode;       //业务代码		
	paraAray[14] = strBackMoney;	    //退费金额 
	paraAray[15] = strCompMoney;	    //赔偿金额 
	paraAray[16] = op_note;             //备注
	paraAray[17] = regionCode;  //地市代码
	paraAray[18] = org_Code;   //归属代码
	paraAray[19] = strUnPayKind;      //退费种类
	/*new begin*/
	paraAray[20] = hjlx; 
	paraAray[21] = jflx; 
	paraAray[22] = ywsysj; 
	paraAray[23] = hjsj; 
	paraAray[24] =ivrFlag;
	//xl add for 单价 数量
	paraAray[25] =dj;
	paraAray[26] =sl;
	
	//xl add for hanfeng PB品牌不可以办理 
	String s_sm_code="";
	String inParas_sm[] = new String[2];
	inParas_sm[0]="select sm_code from dcustmsg where phone_no=:s_no";
	inParas_sm[1]="s_no="+phoneno;
	//end of PB
%>
<wtc:service name="TlsPubSelBoss"  routerKey="phone" routerValue="<%=phoneno%>" retcode="ssmCode" retmsg="ssmMsg" outnum="1">
    	<wtc:param value="<%=inParas_sm[0]%>"/>
        <wtc:param value="<%=inParas_sm[1]%>"/>
</wtc:service>
<wtc:array id="result_pp" scope="end" />
<%
	if(result_pp!=null&&result_pp.length>0)
	{
		s_sm_code=result_pp[0][0];
	}
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaafffffffffffffffffff s_sm_code is "+s_sm_code);
	if(s_sm_code=="PB" ||s_sm_code.equals("PB"))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("物联网号码不允许进行退费操作！");
				window.location="../s4140/f4141.jsp?opCode=4141&opName=投诉退费";
			</script>
		<%
	}
	else
	{
		%>
		<wtc:service name="s4141Cfm" routerKey="phone" routerValue="<%=phoneno%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
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
    <wtc:param value="<%=paraAray[19]%>"/>
	<wtc:param value="<%=paraAray[20]%>"/>
	<wtc:param value="<%=paraAray[21]%>"/>
	<wtc:param value="<%=paraAray[22]%>"/>
	<wtc:param value="<%=paraAray[23]%>"/>
	<wtc:param value="<%=paraAray[24]%>"/>
	<wtc:param value="<%=paraAray[25]%>"/>
	<wtc:param value="<%=paraAray[26]%>"/>
	<wtc:param value="<%=spname%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=spywname%>"/>
	
</wtc:service>
<wtc:array id="s4141CfmArr" scope="end"/>
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
	System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+"4141"+"&retCodeForCntt="+retCode+"&opName="+"投诉退费"+"&workNo="+work_no+"&loginAccept="+s4141CfmArr[0][0]+"&pageActivePhone="+phoneno+"&retMsgForCntt="+retMsg;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");

	String errMsg = s4141CfmMsg;
	if (s4141CfmArr.length > 0 && s4141CfmCode.equals("000000"))
	{
	loginAccept = s4141CfmArr[0][0]; 
	System.out.println("success");
%>
<script language="JavaScript">
	rdShowMessageDialog("投诉退费业务处理成功！",2);
	window.location="../s4140/f4141.jsp?opCode=4141&opName=投诉退费";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("投诉退费业务处理失败: <%=retMsg%>",0);
	window.location="f4141.jsp?opCode=4141&opName=投诉退费";
	</script>
<%}
%>
		<%
	}
%>



