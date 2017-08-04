<%
  /*
   * 功能: 关于与浦发银行合作实现手机钱包联名卡产品业务支撑系统改造需求
   * 版本: 1.0
   * 日期: 20110524
   * 作者: 王怀峰wanghfa
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	String printAccept = WtcUtil.repStr(request.getParameter("printAccept"), "");
	String accept = WtcUtil.repStr(request.getParameter("accept"), "");
	String opNote = WtcUtil.repStr(request.getParameter("opNote"), "");
	String idType = WtcUtil.repStr(request.getParameter("idType"), "");
	String phoneNo = WtcUtil.repStr(request.getParameter("activePhone"), "");
	String idIccid = WtcUtil.repStr(request.getParameter("idIccid"), "");
	String maturity = WtcUtil.repStr(request.getParameter("maturity"), "");
	String idName = WtcUtil.repStr(request.getParameter("idName"), "");
	String AuthFlag = WtcUtil.repStr(request.getParameter("AuthFlag"), "");
	String authFailReason = WtcUtil.repStr(request.getParameter("authFailReason"), "");
	String creditFlag = WtcUtil.repStr(request.getParameter("creditFlag"), "");
	String yearIncome = WtcUtil.repStr(request.getParameter("yearIncome"), "");

	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String applicationNo = ""; //diling add for 申请编号 @2012/6/8
	
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm====0==== iLoginAccept = " + printAccept);
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm====1==== iChnSource = 01");
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm====2==== inOpCode = " + opCode);
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm====3==== iLoginNo = " + workNo);
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm====4==== iLoginPwd = " + password);
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm====5==== iPhoneNo = " + phoneNo);
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm====6==== iUserPwd = ");
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm====7==== iOpNote = " + opNote);
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm====8==== iIdCardType = " + idType);
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm====9==== iIdCardNum = " + idIccid);
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm===10==== iMaturity = " + maturity);
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm===11==== iIdCardName = " + idName);
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm===12==== iAuthFlag = " + AuthFlag);
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm===13==== iAuthFail = " + authFailReason);
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm===14==== iCreditFlag = " + creditFlag);
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm===15==== iYearIncome = " + yearIncome);
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm===16==== accept = " + accept);

%>
	<wtc:service name="sD877Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=opNote%>"/>
		<wtc:param value="<%=idType%>"/>
		<wtc:param value="<%=idIccid%>"/>
		<wtc:param value="<%=maturity%>"/>
		<wtc:param value="<%=idName%>"/>
		<wtc:param value="<%=AuthFlag%>"/>
		<wtc:param value="<%=authFailReason%>"/>
		<wtc:param value="<%=creditFlag%>"/>
		<wtc:param value="<%=yearIncome%>"/>
		<wtc:param value="<%=accept%>"/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
	
<%
	System.out.println("====wanghfa====fd877_cfm.jsp====sD877Cfm==== " + retCode1 + ", " + retMsg1);
	
	if ("000000".equals(retCode1)) {
  	if(result1.length>0){
      applicationNo = result1[0][1];
      System.out.println("----------d877----result1.length="+result1.length);
  	}
	    System.out.println("----------d877----applicationNo="+applicationNo);
		%>
			<script language="javascript">
				rdShowMessageDialog("操作成功！", 2);
				if("<%=AuthFlag%>"=="1"){ //验证通过
				  rdShowMessageDialog("下面打印申请表申请编号！", 1);
			    window.location = "fd877_printApplicationNo.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>&applicationNo=<%=applicationNo%>";
				}else{
				  window.location = "fd877.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
				}
			</script>
		<%
	} else {
		%>
			<script language="javascript">
				rdShowMessageDialog("sD877Cfm服务：<%=retCode1%>，<%=retMsg1%>", 0);
				window.history.go(-1);
				//window.location = "fd877.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
			</script>
		<%
	}
%>
