<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-01-12 页面改造,修改样式
********************/
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	//输入参数 用户ID、手机号码、操作工号、操作员、角色、部门
	String id_no  = request.getParameter("idNo");
	String phone_no  = request.getParameter("phoneNo");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String org_Code = (String)session.getAttribute("orgCode");  //归属代码	
		
	String opCode = "1550";
  	String opName = "综合历史信息查询之用户入网信息";
	String sql_str="select to_char(open_time,'yyyymmdd hh24miss'),machine_code,to_char(hand_fee),to_char(choice_fee),to_char(machine_fee),to_char(sim_fee),to_char(cash_pay),to_char(check_pay),to_char(cash_pay+check_pay),OP_NOTE, b.login_no||'->'||b.login_name from dCustInnetDead a, dLoginMsg b where a.login_no = b.login_no and id_no="+id_no;
	
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=org_Code%>"  retcode="retCode1" retmsg="retMsg1" outnum="11">
	<wtc:sql><%=sql_str%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="result" scope="end" />
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
		rdShowMessageDialog("查询结果为空,没有符合条件的数据!");
	</script>
<%
		return;
	}
%>
<HTML>
	<HEAD>
		<TITLE>入网信息表</TITLE>
	</HEAD>
<body>
<FORM method=post name="f1550_dCustInnet">
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">入网信息表</div>
		</div> 	   
            	<table cellspacing="0">
		      <TBODY>
		        <TR>
		          <TD class="blue">入网时间</td>
		          <td><%=result[0][0]%>&nbsp;</TD>
		          <TD class="blue">机器代码</td>
		          <td><%=result[0][1]%>&nbsp;</TD>
		          <TD class="blue">入网工号</td>
		          <td><%=result[0][10]%>&nbsp;</TD>
		        </TR>
		        <TR>
		          <TD class="blue">手 续 费</td>
		          <td><%=result[0][2]%>&nbsp;</TD>
		          <TD class="blue">选 号 费</td>
		          <td><%=result[0][3]%>&nbsp;</TD>
		          <TD class="blue">机 器 费</td>
		          <td><%=result[0][4]%>&nbsp;</TD>
		        </TR>
		        <TR>
		          <TD class="blue">SIM 卡费</td>
		          <td><%=result[0][5]%>&nbsp;</TD>
		          <TD class="blue">现金交款</td>
		          <td><%=result[0][6]%>&nbsp;</TD>
		          <TD class="blue">支票交款</td>
		          <td><%=result[0][7]%>&nbsp;</TD>
		        </TR>
		        <TR>
		          <TD class="blue">交款总额</td>
		          <td><%=result[0][8]%>&nbsp;</TD>
		          <TD class="blue">用户备注</td>
		          <td colspan="3"><%=result[0][9]%>&nbsp;</TD>
		        </TR>
		      </TBODY>
    		</TABLE>
      <table cellspacing="0">
	    <tr> 
	    	<td id="footer"> 
		    	<input class="b_foot" name=back onClick="history.go(-1)" type=button value="  返  回  ">
		        <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value="  关  闭  ">
		        &nbsp; 
	   	</td>
	    </tr>
     </table>
  <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
