<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
   String phone_no = WtcUtil.repStr(request.getParameter("phone_no")," ");
   String busy_type = WtcUtil.repStr(request.getParameter("busy_type")," ");
   String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);      
	 String retResult = "";
	 String returnCode="";
	 String sqlStr = "";
	 String strIdNo = "";
	 String strSzxFlag = "";
	 String strIsMarketingFlag ="";
	System.out.println("phone_no----------------------------------------------------------------:"+phone_no);
	/*王良 2006年8月29日 增加标准神州行判定*/	
	String strSqlText = "";
	
  //密码校验
	System.out.println("=zhangyan==14=pubCheckPwd.jsp====wanghfa=检查密码是否正确===========");

	String accountType = (String)session.getAttribute("accountType"); 		//yanpx 添加 为判断是否为客服工号
	String custType = WtcUtil.repStr(request.getParameter("custType"),"");	//01:用户密码校验 02 客户密码校验 03帐户密码校验
		System.out.println("=zhangyan==18=pubCheckPwd.jsp====wanghfa=检查密码是否正确===========");

	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"),"");	//移动号码,客户id,帐户id
		System.out.println("=zhangyan==21=pubCheckPwd.jsp====wanghfa=检查密码是否正确===========");

	String custPaswd = WtcUtil.repStr(request.getParameter("custPaswd"),"");//用户/客户/帐户密码
	custPaswd = Encrypt.encrypt(custPaswd);
	String idType = WtcUtil.repStr(request.getParameter("idType"),"");		//en 密码为密文，其它情况 密码为明文
	String idNum = WtcUtil.repStr(request.getParameter("idNum"),"");		//传空
	String loginNo = (String)session.getAttribute("workNo");//WtcUtil.repStr(request.getParameter("loginNo"),"");	//工号
	
	//loginNo="aa0101";
	String retCode1 = new String();
	String retMsg1 = new String();
	System.out.println("=zhangyan===pubCheckPwd.jsp====wanghfa=检查密码是否正确===========");
	System.out.println("=zhangyan==========wanghfa============ custType = " + custType);
	System.out.println("=zhangyan==========wanghfa============ phoneNo = " + phoneNo);
	System.out.println("=zhangyan==========wanghfa============ custPaswd = " + custPaswd);
	System.out.println("=zhangyan==========wanghfa============ idType = " + idType);
	System.out.println("=zhangyan==========wanghfa============ idNum = " + idNum);
	System.out.println("=zhangyan==========wanghfa============ loginNo = " + loginNo);

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
	System.out.println("=zhangyan==========wanghfa============retCode=" + retCode);
	System.out.println("=zhangyan==========wanghfa============retMsg=" + retMsg);
	retCode1 = retCode;
	retMsg1  = retMsg;

	if ("000000".equals(retCode)) {
		for (int i = 0; i < result.length; i ++ ) {
			for (int j = 0; j < result[i].length; j ++) {
				System.out.println("==zhangyan=======wanghfa==========result[" + i + "][" + j + "]" + result[i][j]);
			}
		}
	}

}
%>
 


var response = new AJAXPacket();
var retResult = "<%=retResult%>";
var SzxFlag = "<%=strSzxFlag%>";
var returnCode="<%=returnCode%>";
var IsMarketing="<%=strIsMarketingFlag%>";
var retResult_mm = "<%=retCode1%>";
var msg = "<%=retMsg1%>";
 



response.data.add("retResult",retResult);
response.data.add("SzxFlag",SzxFlag);
response.data.add("returnCode",returnCode);
response.data.add("IsMarketing",IsMarketing);
response.data.add("retResult_mm",retResult_mm);
response.data.add("msg",msg);
 


core.ajax.receivePacket(response);



 
