<%
/********************
 -------------------------创建-----------何敬伟(hejwa) 2015/4/7 9:29:28-------------------
 根据新卡号，查询对应的新卡面值
 -------------------------后台人员：jingang-------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String iNewCard          = WtcUtil.repNull(request.getParameter("iNewCard"));
  String regionCode        = (String)session.getAttribute("regCode"); 
  String getNewCardMoeySql = "SELECT card_money	 FROM DBCARDADM.DCHNCARDRES  WHERE card_no=:newCardStart";
  String param             = "newCardStart="+iNewCard;
  String NewCardMoney      = "";
try{
%>
		<wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=getNewCardMoeySql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
 	if(serverResult.length>0){
		NewCardMoney = serverResult[0][0];
	}
}catch(Exception ex){
	
}

%> 	
var response = new AJAXPacket();
response.data.add("NewCardMoney","<%=NewCardMoney%>");
core.ajax.receivePacket(response);
