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
   String phone_no = WtcUtil.repStr(request.getParameter("phone_no")," ");
   String s_flag = WtcUtil.repStr(request.getParameter("s_flag")," ");
   String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);      
   String s_return_flag="";//0=通过 1=失败
   String[] strSqlText = new String[2];
   String s_count="";
   int i_count=0;
   if(s_flag=="1" ||s_flag.equals("1"))//主卡
   {
		strSqlText[0]="select to_char(count(0)) from group_instance_member a,dcustmsg b where a.serv_id=b.id_no and b.phone_no=:s_no and  member_role_Id in (7005,21098)";
		strSqlText[1]="s_no="+phone_no;
   }
   else
   {
		strSqlText[0]="select to_char(count(0)) from group_instance_member a,dcustmsg b where a.serv_id=b.id_no and b.phone_no=:s_no and  member_role_Id  in (7006,21097,21099)";
		strSqlText[1]="s_no="+phone_no;
   }
	//strSqlText = "select a.id_no,sm_code from dCustMsg a where a.phone_no='" + phone_no + "'";
%>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="<%=strSqlText[0]%>"/>
		<wtc:param value="<%=strSqlText[1]%>"/>
	</wtc:service>
	<wtc:array id="strReturnArray" scope="end" />
<%
	if(strReturnArray!=null&&strReturnArray.length>0)
	{
		i_count = Integer.parseInt((strReturnArray[0][0]).trim());
	}
	if(i_count>0)
	{
		s_return_flag="0";
	}
	else
	{
		s_return_flag="1";
	}
%>


var response = new AJAXPacket();
var s_return_flag = "<%=s_return_flag%>";
response.data.add("s_return_flag",s_return_flag);
core.ajax.receivePacket(response);



 
