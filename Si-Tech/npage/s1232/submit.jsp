<%
  /*
   * 功能: 账户密码修改
   * 版本: 1.0
   * 日期: 2009/1/19
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<%
	String opName = (String)request.getParameter("opName");
	String regionCode = (String)session.getAttribute("regCode");
	String retCode = "0";
	String retMsg = "";
	String retLoginAccept= "0";
	String loginAccept = request.getParameter("loginAccept");
	//System.out.println("loginAccept is : " + loginAccept);
	String vConID = request.getParameter("vConID");
	System.out.println("vConID ================="+vConID);
	String opCode= request.getParameter("opCode");
	//System.out.println("opCode is : " + opCode);
	String workNo= request.getParameter("workNo");
	//System.out.println("workNo is : " +  workNo);
	String noPass  = (String)session.getAttribute("password");
	//System.out.println("noPass is : "+ noPass);
	String orgCode= request.getParameter("orgCode");
	//System.out.println("orgCode is : "+ orgCode);
	String idNo= request.getParameter("idNo");
	System.out.println("idNo is : "+idNo);
	String payFee= request.getParameter("payFee");
	//System.out.println("payFee is : "+payFee);
	String factPay= request.getParameter("realFee");
	//System.out.println("realFee is : "+factPay);
	String sysRemark= request.getParameter("systemRemark");
	//System.out.println("sysRemark is : " + sysRemark);
	String remark= request.getParameter("remark");
	//System.out.println("remark is : "+remark);
	String ipAdd= request.getParameter("ipAddr");
	//System.out.println("ipAddr is : "+ipAdd);
	String opType = request.getParameter("opType");
	//System.out.println("opType is : "+opType);
	String opFlag = request.getParameter("opFlag");
	//System.out.println("opFlag is : "+opFlag);
	String oldPass = request.getParameter("oldPass");
	//System.out.println("oldPass is  : "+oldPass);
	String newPass = request.getParameter("newPass");
	//System.out.println("newPass is : "+newPass);
	String asNotes = WtcUtil.repNull(request.getParameter("vOpNote"));
	
	String ecNewPass =  Encrypt.encrypt(newPass);
	String iPhoneNo = request.getParameter("cus_id");
  String iChnSource = "01";
  String iUserPwd = "";
  
  
	String [] inputParam = new String [18];
	inputParam[0] = loginAccept;
	inputParam[1] = iChnSource;
	inputParam[2] = opCode;
	inputParam[3]= workNo;
	inputParam[4] = noPass;
	inputParam[5] = iPhoneNo;
	inputParam[6] = iUserPwd;
	inputParam[7] = orgCode;
	inputParam[8] = opType;
	inputParam[9] = opFlag;
	inputParam[10] = idNo;
	inputParam[11] = oldPass;
	inputParam[12] = ecNewPass;
	inputParam[13] = payFee;
	inputParam[14] = factPay;
	inputParam[15] = sysRemark;
	inputParam[16] = remark;
	inputParam[17] = ipAdd;
	
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
//	String backInfo[] = impl.callService("s1234Cfm", paraStr,"1");

%>
	<wtc:service name="s1234Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="returnCode" retmsg="returnMsg">
		<wtc:param value="<%=inputParam[0]%>"/>
		<wtc:param value="<%=inputParam[1]%>"/>
		<wtc:param value="<%=inputParam[2]%>"/>
		<wtc:param value="<%=inputParam[3]%>"/>
		<wtc:param value="<%=inputParam[4]%>"/>
		<wtc:param value="<%=inputParam[5]%>"/>
		<wtc:param value="<%=inputParam[6]%>"/>
		<wtc:param value="<%=inputParam[7]%>"/>
		<wtc:param value="<%=inputParam[8]%>"/>
		<wtc:param value="<%=inputParam[9]%>"/>
		<wtc:param value="<%=inputParam[10]%>"/>
		<wtc:param value="<%=inputParam[11]%>"/>
		<wtc:param value="<%=inputParam[12]%>"/>
		<wtc:param value="<%=inputParam[13]%>"/>
		<wtc:param value="<%=inputParam[14]%>"/>
		<wtc:param value="<%=inputParam[15]%>"/>
		<wtc:param value="<%=inputParam[16]%>"/>
		<wtc:param value="<%=inputParam[17]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	retCode = returnCode;
	retMsg  = returnMsg;	
	if(retCode.equals("000000"))
	{
		retLoginAccept = result[0][0];
	}

	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+returnCode
		+"&retMsgForCntt="+returnMsg+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+retLoginAccept
		+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+idNo+"&contactType=acc";
	
	System.out.println(url);
%>
	<jsp:include page="<%=url%>" flush="true" />

	var response = new AJAXPacket();
	
	var errCode = "<%=retCode%>";
	var errMsg = "<%=retMsg%>";
	var loginAccept = "<%=retLoginAccept%>";
	
	response.data.add("loginAccept","<%=retLoginAccept%>");
	response.data.add("errCode","<%=retCode%>");
	response.data.add("errMsg","<%=retMsg%>");
	response.data.add("rpc_page","1");
	
	core.ajax.receivePacket(response);
