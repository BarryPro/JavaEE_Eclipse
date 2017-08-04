<%
  /* *********************
   * 版权: si-tech
   * *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));

  //前一个页面传入的参数
  String iOpType=request.getParameter("opType");//操作类型   a增加 u修改 d删除
  String iScopeType=request.getParameter("scopeType");// 操作范围	0地市	1区县
  String iGoodType=request.getParameter("choPhoneType"); //优良号码类型 
    System.out.println("!!!!!"+iGoodType+"-----------------------------------------------------------------!!!!______________________________-");
  if( iGoodType==null || iGoodType.equals("0") ) {
  iGoodType="";
  }

  String iDistrictCode=request.getParameter("disCode");//区县代码
  String iInterestRate=request.getParameter("interestRate");//银行利率
  String iInsuranceFee=request.getParameter("insuranceFee");//保险费
  String iTestFee=request.getParameter("testFee");//验机费
  String iContractHand=request.getParameter("contractHand");//托收手续费
  String iLockMonth=request.getParameter("lockMonth");//冷冻天数
  String iOwnPsw=request.getParameter("ownPsw");//密码标志
  String iIdNum=request.getParameter("idNum");//购机数
  String iAssureNum=request.getParameter("assureNum");//担保数
  String iDeadDelayRate=request.getParameter("deadDelayRate");//滞纳金率
  String iDeadDelayBegin=request.getParameter("deadDelayBegin");//滞纳金起算日
  String iCheckFlag=request.getParameter("checkFlag");//支票标志
  String iNoUserDay=request.getParameter("noUserDay");//无主停机天数
  String iNoUserMoney=request.getParameter("noUserMoney");//无主停机金额
  String iPreDelMonth=request.getParameter("predelMonth");//预拆月数
  String iPreDelDeposit=request.getParameter("predelDeposit");//预销押金
  String iInnetPredelMonths=request.getParameter("innetPredelMonths");//预销入网月数
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
		<wtc:service name="s5008Cfm" routerKey="region" routerValue="<%=regionCode%>" 
			 retcode="retCode1" retmsg="retMsg1" outnum="2">
				<wtc:param value="<%=loginAccept%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=ip_Addr%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=iOpType%>"/>
				<wtc:param value="<%=iScopeType%>"/>
				<wtc:param value="<%=iGoodType%>"/>
				<wtc:param value="<%=regionCode%>"/>
				<wtc:param value="<%=iDistrictCode%>"/>
				<wtc:param value="<%=iInterestRate%>"/>
				<wtc:param value="<%=iInsuranceFee%>"/>
				<wtc:param value="<%=iTestFee%>"/>
				<wtc:param value="<%=iContractHand%>"/>
				<wtc:param value="<%=iLockMonth%>"/>
				<wtc:param value="<%=iOwnPsw%>"/>
				<wtc:param value="<%=iIdNum%>"/>
				<wtc:param value="<%=iAssureNum%>"/>
				<wtc:param value="<%=iDeadDelayRate%>"/>
				<wtc:param value="<%=iDeadDelayBegin%>"/>
				<wtc:param value="<%=iCheckFlag%>"/>
				<wtc:param value="<%=iNoUserDay%>"/>
				<wtc:param value="<%=iNoUserMoney%>"/>
				<wtc:param value="<%=iPreDelMonth%>"/>
				<wtc:param value="<%=iPreDelDeposit%>"/>
				<wtc:param value="<%=iInnetPredelMonths%>"/>
									
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
		if (retCode1.equals("0")||retCode1.equals("000000")){
%>
			<script language="JavaScript">
				rdShowMessageDialog("操作成功！ ");
				window.location="f5008.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
<%
	}else{
%>
			<script language="JavaScript">
				rdShowMessageDialog("操作失败：" + "<%=retCode1%>" + "<%=retMsg1%>");
				window.location="f5008.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
<%
	}
%>