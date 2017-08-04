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
	
	String opName = "电子有价卡充值";
	
	       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	
	String phone_no= request.getParameter("phone_no");
  String pay_accept= request.getParameter("pay_accept");

	String op_code = "zg32";//操作代码
	String work_no = (String)session.getAttribute("workNo");
	/**
	String sprid= request.getParameter("sprid");//审批人工号
	String lxr_phone= request.getParameter("lxr_phone");
	String hzyy= request.getParameter("hzyy");
	String ifcheck= request.getParameter("ifcheck");
	String squery_type="0";
	String snotice_number= request.getParameter("accepts");//通知单流水
	 
	 **/
  String sucessMoney=""; 
  String falseMoney=""; 
%>
<wtc:service name="szg32Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="sCode" retmsg="sMsg" outnum="10" >
    <wtc:param value="<%=phone_no%>"/>
    <wtc:param value="<%=pay_accept%>"/>
    <wtc:param value="<%=work_no%>"/>
    <wtc:param value="zg32"/>   
</wtc:service>
<wtc:array id="sArr" scope="end"/>
<%
	String retCode= sCode;
	String retMsg = sMsg;
	if(sArr!=null&&sArr.length>0){
		sucessMoney=sArr[0][4].trim();
		falseMoney=sArr[0][5].trim();
		System.out.println("----------zg322222---------------"+sArr[0][0]);
			System.out.println("----------zg322222---------------"+sArr[0][1]);
		System.out.println("----------zg322222---------------"+sArr[0][2]);
		System.out.println("----------zg322222---------------"+sArr[0][3]);
		System.out.println("----------zg322222---------------"+sArr[0][4]);
			System.out.println("----------zg322222---------------"+sArr[0][5]);
		System.out.println("----------zg322222---------------"+sArr[0][6]);
		System.out.println("----------zg322222---------------"+sArr[0][7]);
		System.out.println("----------zg322222---------------"+sArr[0][8]);
	
	}
	String errMsg = sMsg;
	if ( sCode.equals("000000"))
	{
 
%>
<script language="JavaScript">
	rdShowMessageDialog("充值完成,充值成功金额为："+"<%=sucessMoney%>"+"元,充值失败金额为："+"<%=falseMoney%>"+"元");
	window.location="zg32_1.jsp?opCode=zg32&opName=电子有价卡充值";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("充值失败: <%=retMsg%>,<%=sCode%>",0);
	window.location="zg32_1.jsp?opCode=zg32&opName=电子有价卡充值";
	</script>
<%}
%>

