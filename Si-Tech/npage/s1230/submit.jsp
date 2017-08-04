<%
  /*
   * 功能: 客户密码重置1231/修改1230
   * 版本: 1.0
   * 日期: 2009/1/14
   * 作者: zhanghonga
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
	request.setCharacterEncoding("GBK");
%>

<%
	String opCode=(String)request.getParameter("opCode");				//操作代码
	String opName=(String)request.getParameter("opName");				//操作模块名称
	String loginAccept = request.getParameter("loginAccept");			//传入流水
	String workNo= request.getParameter("workNo");						//操作工号
	String noPass = (String)session.getAttribute("password");			//工号密码
	String orgCode= request.getParameter("orgCode");					//归属代码
	String idNo= request.getParameter("idNo");							//客户ID
	String payFee= request.getParameter("payFee");						//手续费
	String factPay= request.getParameter("realFee");					//实收
	String sysRemark= request.getParameter("systemRemark");				//系统备注
	String remark= request.getParameter("remark");						//用户备注
	String ipAdd= (String)session.getAttribute("ipAddr");				//登陆IP
	String opType = request.getParameter("opType");						//操作类型
	String opFlag = request.getParameter("opFlag");
	String oldPass = request.getParameter("oldPass");					//旧密码
	String newPass = request.getParameter("newPass");					//新密码
	String ecNewPass = Encrypt.encrypt(newPass);						//对新密码进行加密
	String retCode = "";												//返回代码
	String retMessage = "";												//返回信息
	String iPhoneNo = request.getParameter("cus_id");
  String iChnSource = "01";
  String iUserPwd = "";
  
//	SPubCallSvrImpl callWrapper = new SPubCallSvrImpl();
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
	//String backUserInfo[][] = new String[][]{{""}};
//	String [] userInfo = callWrapper.callService("s1234Cfm",inputParam,"1");
%>
	<wtc:service name="s1234Cfm" routerKey="region" routerValue="<%=orgCode.substring(0,2)%>" outnum="1" retcode="userInfoRetCode" retmsg="retMsg">
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
	<wtc:array id="backUserInfo" scope="end"/>
<%	
	retCode = userInfoRetCode;
	retMessage = retMsg;
	System.out.println(" retCode = " + retCode);
	System.out.println(" retMessage = " + retMessage);
	System.out.println("cnttLoginAccept"+backUserInfo[0][0]);
	String cnttLoginAccept = "";		//服务返回的流水
	if(retCode.equals("000000")&&backUserInfo.length>0){
		cnttLoginAccept = backUserInfo[0][0];
	}
	String url ="/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode
		+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+cnttLoginAccept+"&pageActivePhone="+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime+"&contactId="+idNo+"&contactType=cust";
%>
	<jsp:include page="<%=url%>" flush="true" />


  var impResultArr = new Array();	
	<%
			if(backUserInfo.length>0){
				for(int i=0;i<backUserInfo.length;i++){
	%>
					var temResultArr = new Array();
	<%
					for(int j=0;j<backUserInfo[i].length;j++){
					//System.out.println("backUserInfo["+i+"]["+j+"]=="+backUserInfo[i][j]);
	%>
						
						temResultArr[<%=j%>] = "<%=backUserInfo[i][j].replaceAll("\r\n","")%>";
	<%				
					}
	%>
					impResultArr[<%=i%>]=temResultArr;
	<%
				}	
			}
	%>
	var response = new AJAXPacket();	
	response.data.add("backString",impResultArr);
	response.data.add("errCode","<%=retCode%>");
	response.data.add("errMsg","<%=retMessage%>");
	
	core.ajax.receivePacket(response);

	
