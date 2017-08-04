<%
/********************
 version v1.0
开发商: si-tech
*
*create by lipf 20120322
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<HTML>
	<HEAD>
		<TITLE>宽带信息查询</TITLE>
<%
  String opCode = "e729";
  String opName = "宽带信息查询";
  String workNo = (String)session.getAttribute("workNo");
  String workName=(String)session.getAttribute("workName");
  String Department=(String)session.getAttribute("orgCode");
  String regionCode = Department.substring(0,2);
  String ip_Addr = "172.16.23.13";
%>
</HEAD>

<body>
<SCRIPT language="JavaScript">

function doCheck()
{
	/**
	if(document.frm1600.cus_pass.value.trim().length>0 && document.frm1600.cus_pass.value.trim().length !=6)
	{
	   rdShowMessageDialog("密码位数不正确！");
	   document.frm1600.cus_pass.focus();
	   return false;
	}
	 document.frm1600.custPass.value=document.frm1600.cus_pass.value;
	 */
	if(document.frm1600.condText.value=="")
	{	rdShowMessageDialog("请输入查询条件！");
		document.frm1600.condText.select();
		return false;
	} else {
	document.frm1600.action="f1600_2.jsp";
	frm1600.submit();
	}
	return true;
}

</SCRIPT>

<FORM method=post name="frm1600">
<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="opCode"  value="e729">
	<input type="hidden" name="custPass"  value="">
			<div class="title">
				<div id="title_zi">请输入查询条件</div>
			</div>
			<table cellspacing="0">
        <tr>
          <td class="blue" align="center" nowrap>查询条件</td>
          <td>
           <select align="left" name=QueryType width=50>
           		<option value="0" >铁通宽带账号</option>
              <option value="1">身份证号</option>
              <option value="2">客户姓名</option>
              <option value="3">宽带安装联系人</option>
              <option value="4">宽带安装联系电话</option>
            </select>
		  		</td>
          <td class="blue" align="center" nowrap> 条件信息</td>
          <td>
          	<input type="text" name="condText" size="20" maxlength="60" onKeyDown="if(event.keyCode==13){ doCheck();return false}">
          	<input type="button" name="Button1" class="b_text" value="查询" onclick="doCheck()">
          </td>
          <!--
          <td class="blue" align="center" nowrap> 用户密码</td>
          <td>
           	<jsp:include page="/npage/query/pwd_one.jsp">
		      	<jsp:param name="width1" value="16%"  />
		      	<jsp:param name="width2" value="34%"  />
		      	<jsp:param name="pname" value="cus_pass"  />
		      	<jsp:param name="pwd" value="12345"  />
	    	   	</jsp:include>
          </td>
          -->
        </tr>
    	</table>

<script>
	x = screen.availWidth;
	y = screen.availHeight;
	window.innerWidth = x;
	window.innerHeight = y;
</script>
<!------------------------>

	</div>


	<div id="Operation_Table">
		<div class="title">
				<div id="title_zi">查询结果</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
        <th>宽带账号</th>
        <th>身份证号</th>
        <th>客户姓名</th>
        <th>宽带安装联系人</th>
        <th>安装联系电话</th>
        <th>安装地址</th>
      </tr>
    </table>



<table cellspacing="0">
  <tr align="center">
    <td id="footer">
      &nbsp; <input name=reset class="b_foot" type=reset onClick="" value=清除>
      &nbsp; <input name=back class="b_foot" onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
      &nbsp;
    </td>
  </tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
</form>
</body>
</html>
<!--***********************************************************************-->
