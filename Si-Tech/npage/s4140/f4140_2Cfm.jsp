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
	String loginAccept = request.getParameter("sysAccept");;       		//操作流水
	String FirstClass = request.getParameter("FirstClass2");          //退费一级原因
	String SecondClass = request.getParameter("SecondClass2");        //退费二级原因
	String ThirdClass = request.getParameter("ThirdClass2");					//退费三级原因
	String opFlag = request.getParameter("opFlag2");       						//操作类型
	String org_Code = (String)session.getAttribute("orgCode");
	String regionCode = org_Code.substring(0,2);
	String op_code = request.getParameter("op_code");              		//操作代码
	

	
	System.out.println("退费原因维护[删除]\n");
	System.out.println("loginName============"+loginName);
	
	System.out.println("work_no============"+work_no);
	System.out.println("pass============"+pass);
	System.out.println("loginAccept============"+loginAccept);
	System.out.println("FirstClass============"+FirstClass);
	System.out.println("SecondClass============"+SecondClass);
	System.out.println("ThirdClass============"+ThirdClass);
	System.out.println("opFlag============"+opFlag);
	System.out.println("org_Code============"+org_Code);
	System.out.println("regionCode============"+regionCode);
	System.out.println("op_code============"+op_code);

	String paraAray[] = new String[13];
	paraAray[0] = loginAccept;				//操作工号
	paraAray[1] = "01";						//操作密码
	paraAray[2] = op_code; 		//操作流水
	paraAray[3] = work_no;     //退费一级原因
	paraAray[4] = pass;    //退费二级原因
	paraAray[5] = "";     //退费三级原因
	paraAray[6] = "";        	//操作类型
	paraAray[7] = FirstClass;//地市代码
	paraAray[8] = SecondClass;//归属代码
	paraAray[9] = ThirdClass;//操作代码
	paraAray[10] = opFlag;//地市代码
	paraAray[11] = regionCode;//归属代码
	paraAray[12] = org_Code;//操作代码
%>
<wtc:service name="s4140_2Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s4140_2CfmCode" retmsg="s4140_2CfmMsg" outnum="2" >
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
</wtc:service>
<wtc:array id="s4140_2CfmArr" scope="end"/>
<%
	System.out.println("s4140_2CfmCode === "+ s4140_2CfmCode);
	System.out.println("s4140_2CfmMsg === "+ s4140_2CfmMsg);

	if (s4140_2CfmArr.length > 0 && s4140_2CfmCode.equals("000000"))
	{
		System.out.println("success");
%>
<script language="JavaScript">
	rdShowMessageDialog("删除退费原因处理成功！",2);
	window.location="../s4140/f4140.jsp?opCode=4140&opName=投诉退费原因维护";
	</script>
<%}else{%>
<script language="JavaScript">
	rdShowMessageDialog("删除退费原因处理失败: <%=s4140_2CfmCode%><%=s4140_2CfmMsg%>",0);
	window.location="../s4140/f4140.jsp?opCode=4140&opName=投诉退费原因维护";
	</script>
<%}%>
