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
	String loginName = (String)session.getAttribute("workName");

	String work_no = (String)session.getAttribute("workNo");
	String pass = (String)session.getAttribute("password");
	String loginAccept = request.getParameter("sysAccept");;       	//操作流水
	String FirstClass = request.getParameter("FirstClass");					//退费一级原因
	String SecondClass = request.getParameter("SecondClass");				//退费二级原因
	String ThirdClass = request.getParameter("ThirdClass");					//退费三级原因
	String Inclassfirst = request.getParameter("inclassfirst");			//增加退费一级原因
	String Inclasssecond = request.getParameter("inclasssecond");		//增加退费二级原因
	String Inclassthird = request.getParameter("inclassthird");			//增加退费三级原因
	String opFlag1 = request.getParameter("opFlag1");								//操作类型
	String org_Code = (String)session.getAttribute("orgCode");
	String regionCode = org_Code.substring(0,2);
	String op_code = request.getParameter("op_code");              	//操作代码
	

	
	System.out.println("退费原因维护[增加]\n");
	System.out.println("loginName============"+loginName);
	
	System.out.println("work_no============"+work_no);
	System.out.println("pass============"+pass);
	System.out.println("loginAccept============"+loginAccept);
	System.out.println("FirstClass============"+FirstClass);
	System.out.println("SecondClass============"+SecondClass);
	System.out.println("ThirdClass============"+ThirdClass);
	System.out.println("Inclassfirst============"+Inclassfirst);
	System.out.println("Inclasssecond============"+Inclasssecond);
	System.out.println("Inclassthird============"+Inclassthird);
	System.out.println("opFlag1============"+opFlag1);
	System.out.println("regionCode============"+regionCode);
	System.out.println("org_Code============"+org_Code);
	System.out.println("op_code============"+op_code);

	String paraAray[] = new String[16];
	paraAray[0] = loginAccept;					//操作流水
	paraAray[1] = "01";  						//渠道标识
	paraAray[2] = op_code; 			//操作代码
	paraAray[3] = work_no;					//操作工号
	paraAray[4] = pass;  						//工号密码
	paraAray[5] = ""; 			//电话号码	
	paraAray[6] = ""; 			//号码密码
	paraAray[7] = FirstClass;				//退费一级原因
	paraAray[8] = SecondClass;			//退费二级原因
	paraAray[9] = ThirdClass;				//退费三级原因
	paraAray[10] = Inclassfirst;			//增加退费一级原因
	paraAray[11] = Inclasssecond;		//增加退费二级原因
	paraAray[12] = Inclassthird;			//增加退费三级原因
	paraAray[13] = opFlag1;					//操作类型
	paraAray[14] = regionCode;
	paraAray[15] = org_Code;
%>
<wtc:service name="s4140_1Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s4140_1CfmCode" retmsg="s4140_1CfmMsg" outnum="2" >
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
</wtc:service>
<wtc:array id="s4140_1CfmArr" scope="end"/>
<%
	System.out.println("s4140_1CfmCode === "+ s4140_1CfmCode);
	System.out.println("s4140_1CfmMsg === "+ s4140_1CfmMsg);

	if (s4140_1CfmArr.length > 0 && s4140_1CfmCode.equals("000000"))
	{
		System.out.println("success");
%>
<script language="JavaScript">
	rdShowMessageDialog("增加退费原因处理成功！",2);
	window.location="../s4140/f4140.jsp?opCode=4140&opName=投诉退费原因维护";
</script>
<%}else{%>
<script language="JavaScript">
	rdShowMessageDialog("增加退费原因处理失败: <%=s4140_1CfmCode%><%=s4140_1CfmMsg%>",0);
	window.location="../s4140/f4140.jsp?opCode=4140&opName=投诉退费原因维护";
	</script>
<%}%>
