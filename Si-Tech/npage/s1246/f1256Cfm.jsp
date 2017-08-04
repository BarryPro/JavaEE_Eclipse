<%
  /*
   * 功能: 用户属性修改1256
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opName = "用户属性修改";
	String loginAccept = request.getParameter("loginAccept");						//
	String opCode= request.getParameter("opCode");									//操作代码
	String workNo= (String)session.getAttribute("workNo");							//工号
	String noPass = (String)session.getAttribute("password");						//工号密码
	String orgCode= (String)session.getAttribute("orgCode");						//归属代码
	String phoneNo= request.getParameter("phoneNo");								//手机号码
	String ownerCode = request.getParameter("ownerCode");							//
	String stopFlag = request.getParameter("stopFlag");								//
	String handFee= request.getParameter("handFee");								//手续费
	String factPay= request.getParameter("factPay");								//
	String sysRemark= request.getParameter("sysRemark");							//系统备注
	String remark= request.getParameter("remark");									//备注
	String ipAdd= (String)session.getAttribute("ip_Addr");							//IP地址
	String ifDetail = request.getParameter("ifDetail");								//
	String asCustName = request.getParameter("asCustName");							//客户姓名
	String asCustPhone = request.getParameter("asCustPhone");						//
	String asIdType = request.getParameter("asIdType");								//
	String asIdIccid = request.getParameter("asIdIccid");							//
	String asIdAddress = request.getParameter("asIdAddress");						//
	String asContractAddress = request.getParameter("asContractAddress");			//
	String asNotes = request.getParameter("asNotes");								//
	//System.out.println("loginAccept is :"+loginAccept);
	//System.out.println("opCode is :"+opCode);
	//System.out.println("workNo is :"+workNo);
	//System.out.println("noPass is :"+noPass);
	//System.out.println("orgCode is :"+orgCode);
	//System.out.println("phoneNo is :"+phoneNo);
	//System.out.println("handFee is :"+handFee);
	//System.out.println("factPay is :"+factPay);
	//System.out.println("sysRemark is :"+sysRemark);
	//System.out.println("remark is :"+remark);
	//System.out.println("ipAdd is :"+ipAdd);
	//System.out.println("ownerCode is :"+ownerCode);
	//System.out.println("stopFlag is :" + stopFlag);
/*	ArrayList arr = F1256Wrapper.s1256Cfm(loginAccept,opCode,workNo,
	                                   noPass,orgCode,phoneNo,ownerCode,stopFlag,handFee,
	                                   factPay,sysRemark,remark,ipAdd,asCustName,asCustPhone,asIdType,
	                                   asIdIccid,asIdAddress,asContractAddress,
	                                   asNotes,ifDetail);*/
%>
	<wtc:service name="s1256CfmEx" routerKey="phone" routerValue="<%=phoneNo%>" outnum="1" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=noPass%>"/>
		<wtc:param value="<%=orgCode%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=ownerCode%>"/>
		<wtc:param value="<%=stopFlag%>"/>
		<wtc:param value="<%=handFee%>"/>
		<wtc:param value="<%=factPay%>"/>
		<wtc:param value="<%=sysRemark%>"/>
		<wtc:param value="<%=remark%>"/>
		<wtc:param value="<%=ipAdd%>"/>
		<wtc:param value="<%=asCustName%>"/>
		<wtc:param value="<%=asCustPhone%>"/>
		<wtc:param value="<%=asIdType%>"/>
		<wtc:param value="<%=asIdIccid%>"/>
		<wtc:param value="<%=asIdAddress%>"/>
		<wtc:param value="<%=asContractAddress%>"/>
		<wtc:param value="<%=asNotes%>"/>
		<wtc:param value="<%=ifDetail%>"/>			
	</wtc:service>
	<wtc:array id="backInfo" scope="end"/>	
<%	                                   
//	String[][] backInfo = (String[][])arr.get(0);
//	String[][] errInfo = (String[][])arr.get(1);
	String cnttLoginAccept = "";
	if(retCode.equals("000000")){
		if(backInfo.length>0){
			cnttLoginAccept = backInfo[0][0];
		}
	}
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+cnttLoginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
	if(retMsg.equals("")){
		retMsg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(retCode));
		if( retMsg.equals("null")){
			retMsg ="未知错误信息";
		}
	} 

%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	String strArray = WtcUtil.createArray("backInfo",backInfo.length);
%>
<%=strArray%>
<%
	for(int i = 0 ; i < backInfo.length ; i ++){
    	for(int j = 0 ; j < backInfo[i].length ; j ++){
%>
			backInfo[<%=i%>][<%=j%>] = "<%=backInfo[i][j].trim()%>";
<%
		}
	}
%>
	var response = new AJAXPacket();
	
	response.data.add("backString",backInfo);
	response.data.add("flag","1");
	response.data.add("errCode","<%=retCode%>");
	response.data.add("errMsg","<%=retMsg%>");
	
	core.ajax.receivePacket(response);
