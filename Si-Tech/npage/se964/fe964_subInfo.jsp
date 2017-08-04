<%
    /*************************************
    * 功  能: 领取网上选号SIM卡 e964
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-7-6
    **************************************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String iPhoneNo = WtcUtil.repStr(request.getParameter("qryPhoneNo"), "");
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String opName=WtcUtil.repNull((String)request.getParameter("opName"));
  String simCode = WtcUtil.repStr(request.getParameter("simCodeBack"), "");/*sim卡卡号*/
  String cardNo = WtcUtil.repStr(request.getParameter("cardNo"), "");/*空卡卡号*/
  String idNo = WtcUtil.repStr(request.getParameter("idNo"), "");
  String simType = WtcUtil.repStr(request.getParameter("simType"), "");/*sim卡类型*/
  String prePayFee = WtcUtil.repStr(request.getParameter("prePayFee"), "");/*预存款*/
  String simPayFee = WtcUtil.repStr(request.getParameter("simPayFee"), "");/*sim卡费*/
  String loginNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
	String groupId = (String)session.getAttribute("groupId");
	String regCode = (String)session.getAttribute("regCode");
	String ipAdd = (String)session.getAttribute("ipAddr");
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sE964Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="1"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=ipAdd%>"/>
		<wtc:param value="<%=simCode%>"/>
		<wtc:param value="<%=cardNo%>"/>
		<wtc:param value="<%=idNo%>"/>
		<wtc:param value="<%=simType%>"/>
		<wtc:param value="<%=prePayFee%>"/>
		<wtc:param value="<%=simPayFee%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
 if(!"000000".equals(retCode)){
%>
  <script>
    rdShowMessageDialog("错误代码：<%=retCode%><br>错误信息：<%=retMsg%>",0);
    window.location.href="fe964_main.jsp?opCode=e964&opName=领取网上选号SIM卡";
  </script>
<%
 }else{
%>
  <script>
     rdShowMessageDialog("提交成功！",2);
     window.location.href="fe964_main.jsp?opCode=e964&opName=领取网上选号SIM卡";
  </script>
<%
 }
%>

	    