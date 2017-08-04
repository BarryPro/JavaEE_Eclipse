<%
  /*
   * 功能:
   * 版本: 1.0
   * 日期: 
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/*************************************************************
  *@ 服务名称:sPosPayPre
  *@ 编码日期:20121009
  *@ 服务版本:1.0
  *@ 编码人员:
  *@ 功能描述:实现pos机办理业务提交第一次调用MIS-POS，在收到银行返回后，将返回信息保存到数据库中
  *@ 输入参数:
  *@     iLoginAccept  流水
  *@		 iChnSource    渠道标识(必须输入01-BOSS；02-网上营业厅；
                             03-掌上营业厅；04-短信营业厅；05-多媒体查询机；06-10086)
  *@		 iOpCode       操作代码	
  *@		 iLoginNo      工号
  *@		 iLoginPwd     工号密码
  *@		 iPhoneNo,     用户号码
  *@		 iUserPwd,     号码密码
  *@     iPayType      缴费类型
  *@     iPayFee       缴费金额
  *@     iCatdNo       卡序列号
  *@     iInstNum      分期付款期数
  *@     iResponseTime 原交易日期
  *@     iTerminalId   原交易终端号
  *@     iRrn          原交易系统检索号
  *@     iRequestTime  提交日期
  *@     iOtherS       预留字段
  *@
  *@ 返回参数:
  *@    SVC_ERR_NO32,oRetCode 返回信息代码
  *@    SVC_ERR_MSG32,oRetMsg  返回信息        
  **************************************************************/


	/*===========获取参数============*/
	String  regionCode     = (String)session.getAttribute("regCode");
  String  iLoginAccept   = (String)request.getParameter("iLoginAccept");  
  String  iChnSource     = (String)request.getParameter("iChnSource");  
  String  iOpCode        = (String)request.getParameter("iOpCode"); 
  String  iLoginNo       = (String)request.getParameter("iLoginNo");
  String  iLoginPwd      = (String)request.getParameter("iLoginPwd");
  String  iPhoneNo       =  (String)request.getParameter("iPhoneNo");
  String  iUserPwd       = (String)request.getParameter("iUserPwd");
  String  iPayType       = (String)request.getParameter("iPayType");
  String  iPayFee        = (String)request.getParameter("iPayFee");
  String  iCatdNo        = (String)request.getParameter("iCatdNo");
  String  iInstNum       = (String)request.getParameter("iInstNum");
  String  iResponseTime  = (String)request.getParameter("iResponseTime");
  String  iTerminalId    = (String)request.getParameter("iTerminalId"); 
  String  iRrn           = (String)request.getParameter("iRrn"); 
  String  iRequestTime   = (String)request.getParameter("iRequestTime"); 
  String  iOtherS        = (String)request.getParameter("iOtherS"); 
%>
<wtc:service name="sPosPayPre" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=iOpCode%>" />
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="<%=iUserPwd%>" />
		<wtc:param value="<%=iPayType%>" />
		<wtc:param value="<%=iPayFee%>" />
		<wtc:param value="<%=iCatdNo%>" /> 
		<wtc:param value="<%=iInstNum%>" />
		<wtc:param value="<%=iResponseTime%>" />
		<wtc:param value="<%=iTerminalId%>" />  
		<wtc:param value="<%=iRrn%>" />
		<wtc:param value="<%=iRequestTime%>" />
		<wtc:param value="<%=iOtherS%>" />
 	</wtc:service>
	<wtc:array id="result1" scope="end" />



	var response = new AJAXPacket();
	response.data.add("retCode12","<%=errCode%>");
	response.data.add("retMsg12","<%=errMsg%>");
	core.ajax.receivePacket(response);
