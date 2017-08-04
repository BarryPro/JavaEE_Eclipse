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
	String phoneno = request.getParameter("phoneno1");              //投诉电话号码
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
	String strBackMoney = request.getParameter("backMoney");      //退费金额
	String strCompMoney = request.getParameter("compMoney");       //赔偿金额
	String op_note = request.getParameter("op_note");              //备注
	String strUnPayKind = "1";//request.getParameter("UnPayKind");       //退费种类
	
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
	String ivrFlag="4";
    //ivrFlag = request.getParameter("ivrflag");
	
	//xl add for gongjian
	String spname = request.getParameter("spname");

	paraAray[0] = loginAccept;  		    //操作流水
	paraAray[1] = "01";  				//渠道标识
	paraAray[2] = op_code; 	        //操作代码
	paraAray[3] = work_no; 			    //操作工号
	paraAray[4] = pass;			    //工号密码
	paraAray[5] = phoneno; 			    //投诉电话号码
	paraAray[6] = "";			    //号码密码	
	paraAray[7] = acceptno;             //投诉电子流水
	paraAray[8] = strUnPayLevel;        //退费类型 refund_type
	paraAray[9] = "0";           //退费一级原因code 自有or梦网业务退费 一级原因=0
	paraAray[10] = "0000";//request.getParameter("UnPayKind");          //按照zlc意见,二级原因改为0000 退费二级原因code 用该字段区分是梦网业务=1还是自有业务=2
	paraAray[11] = request.getParameter("tfyw");           //退费三级原因code tfyw
	paraAray[12] = strSpEnterCode;      //Sp企业代码
	paraAray[13] = strSpTranCode;       //业务代码		
	paraAray[14] = strBackMoney;	    //退费金额 
	paraAray[15] = strCompMoney;	    //赔偿金额 
	paraAray[16] = op_note;             //备注
	paraAray[17] = regionCode;  //地市代码
	paraAray[18] = org_Code;   //归属代码
	paraAray[19] = strUnPayKind;      //退费种类 zg67时 跟二级原因一样 梦网业务=1还是自有业务=2 
	/*new begin*/
	paraAray[20] = hjlx; 
	paraAray[21] = jflx; 
	paraAray[22] = ywsysj; 
	paraAray[23] = hjsj; 
	paraAray[24] =ivrFlag;
	//xl add for 单价 数量
	paraAray[25] =dj;
	paraAray[26] =sl;

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
	window.location="zg67_1.jsp?opCode=4141&opName=投诉退费";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("投诉退费业务处理失败: <%=retMsg%>",0);
	window.location="zg67_1.jsp?opCode=4141&opName=投诉退费";
	</script>
<%}
%>

