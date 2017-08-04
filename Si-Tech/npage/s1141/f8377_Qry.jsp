<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%
  /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年12月20日
　 * 作者: wuxy
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<!--新分页用到的类-->
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
	String opCode = "8377";
	String opName = "赠送预存款配置信息";	
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String workName = (String)session.getAttribute("workName");
	String work_no = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password"); 
	String ipAddr = (String)session.getAttribute("ipAddr");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String tMemberProperty = "";
	String PrintAccept="";
	PrintAccept = getMaxAccept();

	String paraAray[] = new String[8];
	paraAray[0] = " ";
	paraAray[1] = "01";
    paraAray[2] = opCode;
	paraAray[3] = work_no;
    paraAray[4] = password;
    paraAray[5] = " ";
	paraAray[6] = " ";
	paraAray[7] = regionCode;
	
	/**分页要用的代码**/
    Map map = request.getParameterMap();
    String totalNumber = "";
    String currentPage = request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage");
    String pageSize = "11";
    /******************/    
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link href="s2002.css" rel="stylesheet" type="text/css">
	<script>
	
function DeleteActive(vProjectType,vProjectCode,obj)
{
	if(rdShowConfirmDialog('您确定要删除该条信息吗')==1)
	{
		form1.action="f8376_Del.jsp?projectcode="+vProjectCode+"&projecttype="+vProjectType+"";
		form1.submit();
	}
}
function FindInfo(vProjectType,vProjectCode,vExamineSituation,obj)
{
	var opCode='8377';
	form1.action="f8377_Detail.jsp?projectcode="+vProjectCode+"&opcode="+opCode+"&projecttype="+vProjectType+"&examineSituation="+vExamineSituation; // update by diling for 增加审批情况参数 @2011/10/26 
	form1.submit();
}	

	</script>
<!--************************分页的样式表**************************-->
<link rel="stylesheet" type="text/css" href="/nresources/default/css/fenye.css" media="all"/>
</head>
<body>
<form name="form1" method="post">
	<input type="hidden" name="pageOpCode" value="<%=opCode%>">
	<input type="hidden" name="pageOpName" value="<%=opName%>">
<%@ include file="/npage/include/header.jsp" %>

<div id="productList" >
<div class="title"><div id="title_zi">赠送预存款方案信息</div></div>
<wtc:service name="s8377Qry" routerKey="region" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg" outnum="9">
				<wtc:param value="<%=paraAray[0]%>"/>
				<wtc:param value="<%=paraAray[1]%>"/>
				<wtc:param value="<%=paraAray[2]%>"/>
				<wtc:param value="<%=paraAray[3]%>"/>
				<wtc:param value="<%=paraAray[4]%>"/>
				<wtc:param value="<%=paraAray[5]%>"/>
				<wtc:param value="<%=paraAray[6]%>"/>
				<wtc:param value="<%=paraAray[7]%>"/>
		</wtc:service>
<wtc:array id="rows"  start="2" length="7" scope="end" />
<%
	if(!errCode.equals("000000") && !errCode.equals("0"))
	{%> 
	<script language="JavaScript">
  		rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>");
    </script>
<%}%>
	
<table cellspacing="0" id="productTab" >
    <tr align="center">
			<th nowrap>活动类型</th>
			<th nowrap>类型名称</th>
			<th nowrap>活动代码</th>
			<th nowrap>活动名称</th> 
			<th nowrap>审批情况</th>
			<th nowrap>入网时间</th>
			<th nowrap>操作</th>
    </tr>
    <%
       for(int i=0;i<rows.length;i++){
       tMemberProperty = "";
       System.out.println(rows[i][0]);
       System.out.println(rows[i][1]);
       System.out.println(rows[i][2]);
       System.out.println(rows[i][3]);
       System.out.println(rows[i][4]);
       System.out.println(rows[i][5]);
    %>
    <tr align="center">

 <td nowrap>
        	<input type="hidden" name="tMemberProperty" id="tMemberProperty" value="<%=tMemberProperty%>" >
        	<input type="hidden" name="vProjectType" value="<%=rows[i][0]%>" ><%=rows[i][0]%>
        </td>
        <td nowrap><input type="hidden" name="vProjectTypeName" 	value="<%=rows[i][1]%>" ><%=rows[i][1]%></td>
        <td nowrap><input type="hidden" name="vProjectCode" 		value="<%=rows[i][2]%>" ><%=rows[i][2]%></td>   
        <td nowrap><input type="hidden" name="vProjectName"         value="<%=rows[i][3]%>" ><%=rows[i][3]%></td>
        <td nowrap><input type="hidden" name="vIsValid" 	        value="<%=rows[i][4]%>" ><%=rows[i][4]%></td>   
        <td nowrap><%=rows[i][5]%></td>
        <td nowrap>
        <input type="button" name="Find" onclick="FindInfo('<%=rows[i][0]%>','<%=rows[i][2]%>','<%=rows[i][4]%>',this)" class="b_text" value="查询详细信息" >&nbsp;&nbsp;<!--update by diling for 增加审批情况参数 @2011/10/26  -->
        <input type="button" name="Delete" onclick="DeleteActive('<%=rows[i][0]%>','<%=rows[i][2]%>',this)" class="b_text" value=" 删除 " >
        </td>
    </tr>
    <%
       }
    %>
</table>
</div>

<table cellSpacing=0> 
  <tr>
    <td align="center" id="footer" colspan="4">
      <input class="b_foot" name=next id=nextoper type=button value="返回" onclick="history.go(-1)" >
      <input class="b_foot" name=reset type=button value="关闭" onClick="parent.removeTab('8375')">
    </td>
  </tr>
</table>
    <input type="hidden" name="login_accept" value="<%=PrintAccept%>">
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
