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
<%
    String login_no = WtcUtil.repStr(request.getParameter("login_no")," "); 
    String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);      
	String retResult = "";
	String ret_count="";
	 
	String[] inParas2 = new String[2];
	inParas2[0]="select to_char(d.region_code)  from dloginmsg a ,dchngroupinfo b ,schnregionlist c ,sregioncode d where a.group_id = b.group_id and b.parent_group_id = c.group_id and c.group_id = d.group_id and a.login_no = :login_no";
	inParas2[1]="login_no="+login_no;
	String s_group_Id="";
	 
%>
	 
	
	<wtc:service name="TlsPubSelCrm" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
<%
	if(ret_val==null||ret_val.length==0)
	{
		retResult="N";
	}
	else
	{
		retResult="Y";
		s_group_Id = ret_val[0][0];
	}
%>
var response = new AJAXPacket();
var retResult = "<%=retResult%>";
var s_group_Id = "<%=s_group_Id%>"; 
response.data.add("retResult",retResult);
response.data.add("s_group_Id",s_group_Id);
 
core.ajax.receivePacket(response);



 
