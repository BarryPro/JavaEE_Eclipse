<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-19 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	
	String opCode = "8057";
	String opName = "角色与权限代码互斥配置";
	
	String loginNo = (String)session.getAttribute("workNo");	
	String regionCode=(String)session.getAttribute("regCode");
	String workNo = loginNo;			
	String returnFlag = request.getParameter("returnFlag");

%>
<html>
<head>
	<title><%=opName%></title>
</head> 
<script language=javascript>
	
	var returnFlag="<%=returnFlag%>";		
	function showDiv()
	{
		if(returnFlag==null)
		{
			showtbs1_view();
		}		
		else if(returnFlag==2)
		{
			showtbs2_view();
		}		
	}	
	
	function showtbs1()
	{
		showtbs1_view();
		resetAdd();
	}
	
	function showtbs2()
	{
		showtbs2_view();
		resetDel();
	}		
		
	function showtbs1_view(){	
			tbs1.style.display="";
			tbs2.style.display="none";
			document.all.font1.color='222222';
			document.all.font2.color='999999';
			document.all.font1.parentNode.style.background = "999999";
			document.all.font1.parentNode.parentNode.style.background = "999999";
			document.all.font2.parentNode.style.background = "";
			document.all.font2.parentNode.parentNode.style.background = "";
	}

	function showtbs2_view(){	
			tbs1.style.display="none";
			tbs2.style.display="";
			document.all.font1.color='999999';
			document.all.font2.color='222222';
			document.all.font1.parentNode.style.background = "";
			document.all.font1.parentNode.parentNode.style.background = "";
			document.all.font2.parentNode.style.background = "999999";
			document.all.font2.parentNode.parentNode.style.background = "999999";
		}

	
	//重置增加界面
	function resetAdd() 
	{
		document.form1.reset();	
		document.form2.reset();
	}
	
	//重置删除界面
	function resetDel() 
	{
		document.form2.reset();
	}
	
	//重置查询界面
	function resetQry() 
	{
		document.form3.reset();
	}
	

	//选择角色
	function queryRoleCode(str)
	{
		var path = "roletree.jsp?formFlag="+str;
		window.open(path,'_blank','height=600,width=300,scrollbars=yes');
	}
	
	function queryPdomCode(str)
	{
		var path = "functree_qry.jsp?formFlag="+str;
		window.open(path,'_blank','height=600,width=300,scrollbars=yes');
	}
	
	function getPowerInfo1()
	{
		
		if(document.form1.role_code.value=="")
		{
			rdShowMessageDialog("请先选择“角色代码”！");
			return false;
		}
		var loginNo1 = "<%=loginNo%>";
		var roleCode = document.form1.role_code.value;
		var roleName = document.form1.role_name.value;
		
		var win = window.open('f8057_setpdmain.jsp?loginNo1='+loginNo1+'&roleCode='+roleCode+'&roleName='+roleName,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}
	
	function queryPdom()
	{
		getAfterPrompt();
		var role_code = document.form2.role_code.value;
		var pdom_code = document.form2.popedom_code.value;
		
		var str = "?role_code=" + role_code + "&pdom_code="+pdom_code;
		document.middle.location="f8057_qry.jsp"+str;
		
		tabBusi.style.display="";
	}

</script>
<body>
	<%@ include file="/npage/include/header.jsp" %>     
		<div class="title">
			<div id="title_zi">操作类型</div>
		</div>
		<TABLE  cellSpacing=0>
			<tr>
				<TD  style=background="999999"  nowrap>
					<a style=background="999999" id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs1()" value="1">&nbsp;&nbsp;<font id="font1" color='222222'>互斥配置&nbsp;&nbsp;</font></a></TD>
				<TD   nowrap>
					<a id="tabhead2" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs2()" value="1">&nbsp;&nbsp;<font id="font2" >互斥查询&nbsp;&nbsp;</font></a>
				</TD>
			
			</tr>
		</table>		
	<!--add-->
		<div id=tbs1 style="display:block">
			<form name="form1" method="post" action="">
			<div class="title">
				<div id="title_zi">操作信息</div>
			</div>
			<TABLE  cellSpacing=0>
				<TBODY>
					<TR>
						<TD nowrap class="blue">角色代码</TD>
						<TD nowrap>
							<input type=text  v_type="string"  v_must=1    name=role_code  maxlength=10 size="10" readonly>
							<input type=text  name=role_name maxlength=10 readonly>
							<input  type="button" class="b_text" name="query_rolecode" onclick="queryRoleCode('form1')" value="选择">
							<input  type="button" class="b_text" name="query_powercode" onclick="getPowerInfo1()" value="配置与权限代码的互斥关系 ">
							<font class="orange">*</font>
						</TD>
					</TR>
				</TBODY>
			</TABLE>		
			<TABLE  cellSpacing=0>
				<tr> 
					<td id="footer">	
						<input name="resetModBtn" type="button"  class="b_foot" value="重置" onclick="resetAdd()">&nbsp;	
						<input  type="button" name="Return" class="b_foot" onclick="removeCurrentTab()" value="关闭">
					</td>
				</tr>
			</table>
			</form>
		</div>
		
		<!--add-->
		<div id=tbs2 style="display:none">
			<form name="form2" method="post" action="">
			<div class="title">
				<div id="title_zi">操作信息</div>
			</div>	
			<TABLE  cellSpacing=0>
				<TBODY>
					<TR >
						<TD width="12%" nowrap class="blue">角色代码</TD>
						<TD width="38%" nowrap  >
							<input type=text  v_type="string"  v_must=1    name=role_code  maxlength=10 size="10" >
							<input type=text  name=role_name maxlength=10 readonly>
							<input  type="button" name="query_rolecode" class="b_text" onclick="queryRoleCode('form2')" value="选择">
						</TD>
						<TD width="12%" nowrap class="blue">权限信息</TD>
						<TD width="38%" nowrap  >
							<input type=text  v_type="string"  v_must=1    name=popedom_code  maxlength=10 size="10" >
							<input type=text  name=popedom_name maxlength=10 readonly>
							<input  type="button" name="query_Popedomcode" class="b_text" onclick="queryPdomCode('form2')" value="选择">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			
			<TABLE id="tabBusi" style="display:none"  cellspacing="0">	
				<TR> 
					<td nowrap>					
					 <IFRAME frameBorder=0 id=middle name=middle scrolling="yes" style=" VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
		   			 </IFRAME>
		   			 
					</td> 
					 
				</TR>
			</TABLE>
			
			<table cellspacing="0">
				<tr> 
					<td id="footer">
						<input name="qryPdom" type="button"  class="b_foot" value="查询" onclick="queryPdom()">&nbsp;	
						<input name="resetModBtn" type="button"  class="b_foot"  value="重置" onclick="resetAdd()">&nbsp;	
						<input  type="button" name="Return"   class="b_foot" onclick="removeCurrentTab()" value="关闭">
					</td>
				</tr>
			</table>
			</form>
		</div>
</div>
<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>
