<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
    String opCode = "1508";
    String opName = "优惠操作查询";
	String queryType=request.getParameter("queryType");
	String begin_phoneNo=request.getParameter("begin_phoneNo");
	String end_phoneNo=request.getParameter("end_phoneNo");
	String begin_loginNo=request.getParameter("begin_loginNo");
	String end_loginNo=request.getParameter("end_loginNo");
	String begin_time=request.getParameter("begin_time");
	String end_time=request.getParameter("end_time");
	String work_no=request.getParameter("work_no");
	String work_name=request.getParameter("work_name");
	String function_code=request.getParameter("function_code");
	String favour_code=request.getParameter("favour_code");
	String region_code = ((String)session.getAttribute("orgCode")).substring(0,2);


	    //ArrayList arlist = new ArrayList();
		//s1520view viewBean = new s1520view();//实例化viewBean
		//arlist = viewBean.s1508Qry(queryType,begin_phoneNo,end_phoneNo,begin_loginNo,end_loginNo,begin_time,end_time,work_no,function_code,favour_code,region_code); 
%>
    <wtc:service name="s1508Qry" routerKey="region" routerValue="<%=region_code%>" retcode="s1508QryCode" retmsg="s1508QryMsg" outnum="11">
        <wtc:param value="<%=queryType%>"/>
        <wtc:param value="<%=begin_phoneNo%>"/>
        <wtc:param value="<%=end_phoneNo%>"/>
        <wtc:param value="<%=begin_loginNo%>"/>
        <wtc:param value="<%=end_loginNo%>"/>
        
        <wtc:param value="<%=begin_time%>"/>
        <wtc:param value="<%=end_time%>"/>
        <wtc:param value="<%=work_no%>"/>
        <wtc:param value="<%=function_code%>"/>
        <wtc:param value="<%=favour_code%>"/>
        <wtc:param value="<%=region_code%>"/>
    </wtc:service>
    <wtc:array id="result" scope="end" />
<%
    	//String [][] result = new String[][]{};
    	//result = (String[][])arlist.get(0);
	String return_code = s1508QryCode;
	String return_message = s1508QryMsg;
%>
<%
	if (!return_code.equals("000000"))
	{
%>
    <script language="JavaScript">
    	rdShowMessageDialog("<%=return_message%><br>错误代码 '<%=return_code%>'。",0);
    	history.go(-1);
    </script>
<% } %>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>优惠操作查询</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">用户信息</div>
</div>

      <table cellspacing="0">
                <tr> 
                  <th>移动号码</th>
                  <th>操作名称</th>
                  <th>操作时间</th>
                  <th>优惠名称</th>
                  <th>优惠前</th>
                  <th>优惠后</th>
                  <th>工号</th>
                  <th>操作流水</th>
                  <th>操作备注</th>
                </tr>
<%	      for(int y=0;y<result.length;y++)
	      {
%>
	        <tr>
<%    	        for(int j=2;j<result[0].length;j++)
	        {
%>
	              <td><%= result[y][j]%></td>
<%	        }
%>
	        </tr>
<%	      }
%>


          <tr id="footer"> 
      	    <td colspan="9">
    	      <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
    	    </td>
          </tr>
      </table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>

