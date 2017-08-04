<%
/********************
 version v2.0
开发商: si-tech
*
*create:wanghfa@2010-8-16 校验密码是否正确
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String accountType = (String)session.getAttribute("accountType"); 		//yanpx 添加 为判断是否为客服工号
	String custType = WtcUtil.repStr(request.getParameter("custType"),"");	//01:手机号码 02 客户密码校验 03帐户密码校验
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"),"");	//移动号码,客户id,帐户id
	String custPaswd = WtcUtil.repStr(request.getParameter("custPaswd"),"");//用户/客户/帐户密码
	String idType = WtcUtil.repStr(request.getParameter("idType"),"");		//en 密码为密文，其它情况 密码为明文
	String idNum = WtcUtil.repStr(request.getParameter("idNum"),"");		//传空
	String loginNo = WtcUtil.repStr(request.getParameter("loginNo"),"");	//工号
	String retCode1 = new String();
	String retMsg1 = new String();
	System.out.println("====pubCheckPwd.jsp====wanghfa=检查密码是否正确===========");
	System.out.println("===========wanghfa============ custType = " + custType);
	System.out.println("===========wanghfa============ phoneNo = " + phoneNo);
	System.out.println("===========wanghfa============ custPaswd = " + custPaswd);
	System.out.println("===========wanghfa============ idType = " + idType);
	System.out.println("===========wanghfa============ idNum = " + idNum);
	System.out.println("===========wanghfa============ loginNo = " + loginNo);

/*yanpx 添加 客服工号不进行密码验证 直接通过20100907 开始 */
if( accountType.equals("2") ){
	retCode1 = "000000";
	retMsg1  = "密码验证通过";
} else {
%>
<wtc:service name="sPubCustCheck" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="5">
	<wtc:param value="<%=custType%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=custPaswd%>"/>
	<wtc:param value="<%=idType%>"/>
	<wtc:param value="<%=idNum%>"/>
	<wtc:param value="<%=loginNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
	System.out.println("===========wanghfa============retCode=" + retCode);
	System.out.println("===========wanghfa============retMsg=" + retMsg);
	retCode1 = retCode;
	retMsg1  = retMsg;

	if ("000000".equals(retCode)) {
		for (int i = 0; i < result.length; i ++ ) {
			for (int j = 0; j < result[i].length; j ++) {
				System.out.println("=========wanghfa==========result[" + i + "][" + j + "]" + result[i][j]);
			}
		}
	}

}
/*yanpx 添加 结束*/
%>
var response = new AJAXPacket();
var retResult = "<%=retCode1%>";
var msg = "<%=retMsg1%>";

response.data.add("retResult",retResult);
response.data.add("msg",msg);

core.ajax.receivePacket(response);
