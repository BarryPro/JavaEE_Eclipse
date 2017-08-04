<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-22 页面改造,修改样式
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt;"%>
<%
  String regionCode = (String)session.getAttribute("regCode");
	String phoneNo = request.getParameter("phoneNo");    
	String errorCode = "";
	String errorMsg   = "";
	
	//增加对开户的验证，如果是网上开户的号码，则要求其去b893进行开户操作
	String scheckflag="0";
	String[] inParamsdd = new String[2];
	inParamsdd[0] = "	Select count(*) From dwebOpenPhonemsg a Where ((a.CHECK_STATUS = '3' and CHECKLD_FLAG is null AND sysdate <=to_date(to_char(a.open_time + 2, 'yyyy-mm-dd ') || '23:59:59','yyyy-mm-dd hh24:mi:ss')) or(a.CHECK_STATUS != '3' AND sysdate <=to_date(to_char(a.open_time + 15, 'yyyy-mm-dd ') || '23:59:59','yyyy-mm-dd hh24:mi:ss')))and a.phone_no= :v0";
	//inParamsdd[0] ="Select count(*) From dcustmsg where phone_no=:v0";
	inParamsdd[1] = "v0="+phoneNo;
	%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsdd[0]%>"/>
	<wtc:param value="<%=inParamsdd[1]%>"/>	
	</wtc:service>	
  <wtc:array id="phoncount" scope="end" />

	<%
	  if(retCode1ss.equals("000000")) {
  	if(phoncount[0][0].equals("0") ) {//如果不是网上开户
  	scheckflag="1";
		errorCode="0";
  	}
  }
if(scheckflag.equals("1")) {//如果不是网上开户的号码
}
else {//如果是网上开户的号码则提示去b893去办理业务
	 errorCode = "000893";
	 errorMsg   = "该号码是网上开户，请到b893网上开户功能进行操作！";

}

%>

var response = new AJAXPacket();
response.data.add("errorCode","<%=errorCode%>");
response.data.add("errorMsg","<%=errorMsg%>");
core.ajax.receivePacket(response);