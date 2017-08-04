<%
/********************
 version v2.0
开发商: si-tech
Updat :  sunaj 20100531
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
   //得到输入参数

   	String org_Code = (String)session.getAttribute("orgCode");
   	String group_id = (String)session.getAttribute("groupId");
	String project_type = WtcUtil.repStr(request.getParameter("Project_Type")," ");
	String project_code = WtcUtil.repStr(request.getParameter("Project_Code")," ");
    String retType = WtcUtil.repStr(request.getParameter("retType")," ");
	String op_code = WtcUtil.repStr(request.getParameter("Op_Code")," ");
	String IdNo = WtcUtil.repStr(request.getParameter("IdNo")," ");
	String regionCode = org_Code.substring(0,2);
	String num="";

	System.out.println("op_code====="+op_code);
	System.out.println("project_type===="+project_type);
	System.out.println("project_code===="+project_code);

	String sqlStr = "";
	sqlStr="select count(*) from wprojectgift a,sactivecode b                              "+
		   "where a.id_no="+IdNo+" and a.project_type=b.project_type and a.project_code=b.project_code "+
		   "and substr(a.belong_code,1,2)=b.region_code and a.op_code='8379' and a.back_flag='0'       "+
		   "and to_char(add_months(to_date(to_char(a.begin_time,'YYYYMM')||lpad(to_char(b.return_date),2,'0'),'YYYYMMDD'),b.return_term),'YYYYMMDD') >= to_char(sysdate,'YYYYMMDD')  "+
		   "and b.project_type='"+project_type+"' and b.project_code='"+project_code+"' and b.region_code ='"+regionCode+"' " ;
		   
	System.out.println("sqlStr="+sqlStr);
%>         
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retResult" retmsg="retMsg" outnum="1">
<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
           
<%         
	if(retResult.equals("0") || retResult.equals("000000"))
	{
		num = result[0][0];
		System.out.println("num======="+num);
 	}	
%>
var response = new AJAXPacket();
var num = "<%=num%>";
var retType = "<%=retType%>";
response.data.add("retType","<%= retType %>");
response.data.add("num","<%=num%>");
core.ajax.receivePacket(response);



 
