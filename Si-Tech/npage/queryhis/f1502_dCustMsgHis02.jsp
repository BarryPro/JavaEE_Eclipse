<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-13 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "1502";
  String opName = "用户历史信息";
  
  String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String id_no  = request.getParameter("id_no");
	String update_accept  = request.getParameter("update_accept");
	String work_no=request.getParameter("work_no");
	String work_name=request.getParameter("work_name");
	
%>
	<wtc:service name="sHisUserHis02" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="13">
		<wtc:param value="<%=id_no%>"/>
		<wtc:param value="<%=update_accept%>"/>
		<wtc:param value="<%=work_no%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" start="2" length="11"/>
<%	
	if(!retCode1.equals("000000")){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("服务未能成功,服务代码:<%=retCode1%><br>服务信息:<%=retMsg1%>!");
	</script>
<%
		return;
	}else if(result==null||result.length==0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("查询结果为空,用户历史信息不存在!");
	</script>
<%
		return;
	}
%>

<HTML><HEAD><TITLE>用户历史信息</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dCustMsgHis02">
    <%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">换卡记录信息</div>
		</div>
    <table cellspacing="0">
      <tbody>
        <tr>
          <TD class="blue">服务号码</td>
          <td><%=result[0][0]%></TD>
          <TD class="blue">入网日期</td>
          <td><%=result[0][1]%></TD>
          <TD class="blue">业务类型</td>
          <td><%=result[0][2]%></TD>
        </TR>
        <TR>
          <TD class="blue">服务类型</td>
          <td><%=result[0][3]%></TD>
          <TD class="blue">用户属性</td>
          <td><%=result[0][4]%></TD>
          <TD class="blue">信用度等级</td>
          <td><%=result[0][5]%></TD>
        </TR>
        <TR>
          <TD class="blue">信用度</td>
          <td><%=result[0][6]%></TD>
          <TD class="blue">用户状态</td>
          <td><%=result[0][7]%></TD>
          <TD class="blue">状态修改时间</td>
          <td><%=result[0][8]%></TD>
        </TR>
        <TR>
          <TD class="blue">出帐时间</td>
          <td><%=result[0][9]%></TD>
          <TD class="blue">出帐周期</td>
          <td colspan="3"><%=result[0][10]%></TD>
        </TR>
      </TBODY>
		</TABLE>
          
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value=关闭>
    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>

