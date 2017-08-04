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
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1500";
  String opName = "综合信息查询之用户入网信息";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String id_no  = request.getParameter("idNo");
	String phone_no  = request.getParameter("phoneNo");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	
	String sql_str="select to_char(open_time,'yyyymmdd hh24 mi ss'),machine_code,to_char(hand_fee),to_char(choice_fee),to_char(machine_fee),to_char(sim_fee),to_char(cash_pay),to_char(check_pay),to_char(cash_pay+check_pay),OP_NOTE,b.login_no||'->'||b.login_name,c.group_name from dCustInnet a, dLoginMsg b, dchngroupmsg c where a.login_no = b.login_no and b.group_id = c.group_id and a.id_no="+id_no;
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="12">
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
		rdShowMessageDialog("查询结果为空,换卡记录信息不存在!");
	</script>
<%
		return;
	}
%>
<HTML><HEAD><TITLE>入网信息表</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dCustInnet">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">用户入网信息</div>
		</div>
    <table cellspacing="0">
      <TBODY>
        <TR>
          <TD class="blue" width="15%">入网时间</td>
          <td width="18%"><%=result[0][0]%>&nbsp;</TD>
          <TD class="blue" width="15%">机器代码</td>
          <td width="18%"><%=result[0][1]%>&nbsp;</TD>
          <TD class="blue" width="15%">入网工号</td>
          <td width="17%"><%=result[0][10]%>&nbsp;</TD>
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
        <TR>
          <TD class="blue">网点名称</td>
          <td colspan="5"><%=result[0][11]%></TD>
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
