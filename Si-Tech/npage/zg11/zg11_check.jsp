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
   String phone_no =  request.getParameter("phone_no");
   String[] inParas2 = new String[2];
   String[] inParas1 = new String[2];
   inParas1[0]="select to_char(count(phone_no)) from dcustmsg where phone_no=:phone_no ";
   inParas1[1]="phone_no="+phone_no;
   inParas2[0]="select to_char(count(a.phone_no)) from dGprsShortMsgOffOn a where a.phone_No=:s_phone_no  ";  
   inParas2[1]="s_phone_no="+phone_no;
   String s_flag="";
   String s_result="";
   
   //xl add for 亲情网查询
   String[] inParas_qqw = new String[2];
   inParas_qqw[0]="select to_char(count(*)) from dbbillprg.remind_warn_user_info where trim(MSISDN)=:s_no and warn_rule_id in ('100030','100031') and is_remind='0' ";
   inParas_qqw[1]="s_no="+phone_no;
   String s_qqw_flag="";
   String s_qqw_result="";
%>
	<wtc:service name="TlsPubSelBoss" retcode="retCode_qqw" retmsg="retMsg_qqw" outnum="1">
		<wtc:param value="<%=inParas_qqw[0]%>"/>
		<wtc:param value="<%=inParas_qqw[1]%>"/>
	</wtc:service>
	<wtc:array id="ret_val_qqw" scope="end" />
<%
	if(ret_val_qqw.length>0)
	{
		if(ret_val_qqw[0][0]=="0" ||ret_val_qqw[0][0].equals("0"))
		{
			System.out.println("ddddddddddddddd");
			s_qqw_flag="kt";//没有数据 说明是开通状态 通过关闭按钮 插入一条记录?
		}
		else
		{
			s_qqw_flag="gb";//有数据 说明是关闭状态 -->不提供开通功能
			s_qqw_result=ret_val_qqw[0][0];
		}
	}	
%>
	
	<wtc:service name="TlsPubSelBoss" retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/>
	</wtc:service>
	<wtc:array id="ret_val1" scope="end" />
<%
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ret_val1 is "+ret_val1[0][0]+" and ret_val1 is "+ret_val1+" and ret_val1.legnth is "+ret_val1.length);
	if(ret_val1.length>0)
	{
		System.out.println("ccccccccccccccccccccccccccccc");
		if(ret_val1[0][0]=="0" ||ret_val1[0][0].equals("0"))
		{
			System.out.println("ddddddddddddddd");
			s_flag="N";
		}
		else
		{
			System.out.println("eeeeeeeeeeeeeeeeee");
		}
	}
%>	
	<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
<%
	if(ret_val.length==0)
	{
		s_result="N";
	}
	else
	{
		s_result = ret_val[0][0];
	}
%>
	 
 
var response = new AJAXPacket();
var s_flag = "<%=s_flag%>"; 
var s_result = "<%=s_result%>";

var s_qqw_flag =  "<%=s_qqw_flag%>";
var s_qqw_result = "<%=s_qqw_result%>";
response.data.add("s_qqw_flag",s_qqw_flag); 
response.data.add("s_qqw_result",s_qqw_result); 


response.data.add("s_flag",s_flag); 
response.data.add("s_result",s_result); 
core.ajax.receivePacket(response);



 
