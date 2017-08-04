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
	String opCode = "8175";
	String opName = "工号角色管理";
	
	String regionCode = (String)session.getAttribute("regCode");
	String loginNo =(String)session.getAttribute("workNo");	
	String returnFlag = request.getParameter("returnFlag");
		
%>
<html>
<head>
<title><%=opName%></title>
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
		else if(returnFlag==3)
		{
			showtbs3_view();
		}
	}
	
	function fsubmit1()
	{
		getAfterPrompt();
		if($("#oaNumber").val()==""){
			rdShowMessageDialog("请输入OA编号！");
			return;
		}
		if($("#oaTitle").val()==""){
			rdShowMessageDialog("请输入OA标题！");
			return;
		}
		document.form1.action="f8175_submit.jsp?loginNo="+document.form1.login_no1.value+"&powerCode="+document.form1.power_code.value+"&opType=0&oaNumber="+$("#oaNumber").val()+"&oaTitle="+$("#oaTitle").val(); //insert
		document.form1.submit();
		document.form1.bSubmit1.disabled=true;
	}
	
	function fsubmit2()
	{
		getAfterPrompt();
		if($("#oaNumberd").val()==""){
			rdShowMessageDialog("请输入OA编号！");
			return;
		}
		if($("#oaTitled").val()==""){
			rdShowMessageDialog("请输入OA标题！");
			return;
		}
		document.form2.action="f8175_submit.jsp?loginNo="+document.form2.login_no2.value+"&powerCode="+document.form2.power_code2.value+"&opType=1&oaNumber="+$("#oaNumberd").val()+"&oaTitle="+$("#oaTitled").val(); //delete
		document.form2.submit();
		document.form2.bSubmit2.disabled=true;
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
			
	function showtbs3()
	{
		showtbs3_view();
		resetQry();
	}		
		
	function showtbs1_view()
	{
		tbs1.style.display="";
		tbs2.style.display="none";
		tbs3.style.display="none";
		document.all.font1.color='222222';
		document.all.font2.color='999999';
		document.all.font3.color='999999';
		document.all.font1.parentNode.style.background = "999999";
		document.all.font1.parentNode.parentNode.style.background = "999999";
		document.all.font2.parentNode.style.background = "";
		document.all.font2.parentNode.parentNode.style.background = "";
		document.all.font3.parentNode.style.background = "";
		document.all.font3.parentNode.parentNode.style.background = "";
	}

	function showtbs2_view()
	{	
		tbs1.style.display="none";
		tbs2.style.display="";
		tbs3.style.display="none";
		document.all.font1.color='999999';
		document.all.font2.color='222222';
		document.all.font3.color='999999';
		document.all.font1.parentNode.style.background = "";
		document.all.font1.parentNode.parentNode.style.background = "";
		document.all.font2.parentNode.style.background = "999999";
		document.all.font2.parentNode.parentNode.style.background = "999999";
		document.all.font3.parentNode.style.background = "";
		document.all.font3.parentNode.parentNode.style.background = "";
	}
	function showtbs3_view()
	{
		tbs1.style.display="none";
		tbs2.style.display="none";
		tbs3.style.display="";
		document.all.font1.color='999999';
		document.all.font2.color='999999';
		document.all.font3.color='222222';
		document.all.font1.parentNode.style.background = "";
		document.all.font1.parentNode.parentNode.style.background = "";
		document.all.font2.parentNode.style.background = "";
		document.all.font2.parentNode.parentNode.style.background = "";
		document.all.font3.parentNode.style.background = "999999";
		document.all.font3.parentNode.parentNode.style.background = "999999";
	}
	
	//重置增加界面
	function resetAdd() 
	{
		document.form1.reset();	
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
	function queryPowerCode(str)
	{
		var path = "roletree.jsp?formFlag="+str;
		window.open(path,'_blank','height=600,width=300,scrollbars=yes');
	}
	
	//选择发布组织节点
	function queryRoleCode(formName)
	{
		var path = "";
		var path = "roletree.jsp?formFlag="+formName;
	  	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
	}
	
	function queryRoleCodeDel(formName)
	{
		if("" == document.form2.groupId.value)
		{
			alert("请先输入组织节点信息！");
			return;
		}
		
		var sqlStr = "90000018" ;
		var params = document.form2.login_no2.value + "|" + document.form2.login_no2.value + "|";
		
		var path = "/npage/public/fPubSimpSel.jsp";
		path = path + "?sqlStr=" + sqlStr + "&retQuence=2|0|1|";
		path = path + "&fieldName=角色代码|角色名称|&pageTitle=工号角色";
		path = path + "&selType=M";
		path = path + "&params=" + params;
		
		var retMsg = showModalDialog(path);
		if(typeof(retMsg)=="undefined")      
		{
			return;
		}
		
		document.form2.power_code2.value = retMsg;
	}
	
	//查询已发布的角色信息
	function queryLoginRole()
	{
		getAfterPrompt();
		var loginNo = document.form3.login_no3.value;
		var powerCode = document.form3.power_code.value;
		
		if(loginNo=="")
		{
			rdShowMessageDialog("请选择“工号信息”进行查询！");	
			return false;
		}
		
		var str = "?loginNo=" + loginNo + "&powerCode=" + powerCode + "&opType=2";
		document.middle.location="f8175_qry.jsp"+str;		
		tabBusi.style.display="";
	}
	
	function selectGroupId(frm)
	{
		var path = "<%=request.getContextPath()%>/npage/public/pubtree/grouptree.jsp?frmName="+frm+"&groupId=groupId&groupName=groupName&serverType=USE";
		window.open(path,'_blank','height=600,width=300,scrollbars=yes');
	}
	
	function changeLoginNo()
	{
		document.form1.login_name1.value="";
		document.form2.login_name2.value="";
	}
	
	function getLoginNo(i)
	{
		var retToField = "";
		var grpId = "";
		var loginNo = "";
		var validFlag = "";
		
		if(i==1)
		{
			validFlag = document.form1.validFlag.value;
			grpId = document.form1.groupId.value;
			loginNo = document.form1.login_no1.value;
			retToField = "login_no1|login_name1";
		}
		else if(i==2)
		{
			validFlag = document.form2.validFlag.value;
			grpId = document.form2.groupId.value;
			loginNo = document.form2.login_no2.value;
			retToField = "login_no2|login_name2";
		}
		else
		{
			validFlag = document.form3.validFlag.value;
			grpId = document.form3.groupId.value;
			loginNo = document.form3.login_no3.value;
			retToField = "login_no3|login_name3";
		}
		
		if("" == grpId)
		{
			alert("请先输入组织节点信息！");
			return;
		}
		
		var pageTitle = "工号信息";
		var fieldName = "工号代码|工号名称";
		
		var sqlStr = "select rtrim(login_no) ,rtrim(login_name) from dloginmsg " +
					 " where login_no like '"+loginNo+"%'" + 
					 " and vilid_flag = " + validFlag + " and group_id = '" + grpId + "'";
		
		sqlStr = sqlStr + " order by login_no" ;
		var selType = "S";    //'S'单选；'M'多选
		var retQuence = "0|1";
		PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
	}

</script>
</head> 
<body>
		<%@ include file="/npage/include/header.jsp" %>     
		<div class="title">
			<div id="title_zi">操作类型</div>
		</div>
		<TABLE  cellSpacing=0>
			<tr>
				<TD  style=background="999999"  nowrap><a style=background="999999" id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs1()" value="1">&nbsp;&nbsp;<font id="font1" color='222222'>增加&nbsp;&nbsp;</font></a></TD>
				<TD nowrap><a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs2()" value="1">&nbsp;&nbsp;<font id="font2" >删除&nbsp;&nbsp;</font></a></TD>
				<TD nowrap><a id="tabhead2" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs3()" value="1">&nbsp;&nbsp;<font id="font3" >查询&nbsp;&nbsp;</font></a></TD>
				
			</tr>
		</table>
	<!--add-->		
		<div id=tbs1 style="display:block">		
		<form name="form1" method="post" action="">	
		<div class="title">
			<div id="title_zi">操作信息</div>
		</div>		
			<TABLE   cellspacing="0" >
				<TBODY>
					<tr>
						<TD width="15%" class="blue">&nbsp;组织节点</td>
						<td width="35%">
							<input type="hidden" name="groupId">
							<input type="text" name="groupName"  maxlength="60" value="" readonly class="InputGrey">
							<input name="addButton" type="button"  class="b_text" value="选择" onClick="selectGroupId('form1')" >
							 <font class="orange">*</font>
						</TD>
						<TD width="15%" class="blue">&nbsp;工号有效性</td>
						<td width="35%">
							<select name=validFlag>
								<option value="1">有效</option>
								<option value="0">无效</option>
							</select>
						</td>
					</tr>
					<tr >
						<TD width="15%" class="blue">&nbsp;工号信息</td>
						<TD width="35%">
							<input type="text" name="login_no1" v_type="string" v_must=1 maxlength="6" size="8"  onKeyup="changeLoginNo()">
							<input type="text" name="login_name1"  readonly class="InputGrey" >
							<input name="loginNoQuery" type="button"  class="b_text" onClick="getLoginNo(1)" value="查询">
							<font class="orange">*</font>
						</TD>
						<TD nowrap class="blue">&nbsp;角色信息</TD>
						<TD nowrap>
							<input type=text name=power_code v_type="string"  v_must=1 size=8  value="">
							<input type=text name="power_name" value="" readonly class="InputGrey">
							<input type="button"  class="b_text" name="btnQueryRoleCode" onclick="queryRoleCode('form1')" value="选择">
							<font class="orange">*</font>
						</TD>
					</TR>
					<tr>
						<td class="blue">&nbsp;OA编号</td>
						<td><input type="text" id="oaNumber" name="oaNumber" maxlength="30"/><font color="orange">*</font></td>
						<td class="blue">&nbsp;OA标题</td>
						<td><input type="text" id="oaTitle" name="oaTitle" maxlength="30"/><font color="orange">*</font></td>
					</tr>
				</TBODY>
			</TABLE>
			
			<TABLE   cellspacing="0" >
				<TR>
					<TD id="footer">
						<input  type="button"  class="b_foot" name="bSubmit1" onclick="if(check(form1)) fsubmit1()" value="增加" >&nbsp;
						<input name="resetModBtn" class="b_foot" type="button"  value="重置" onclick="resetAdd()">&nbsp;	
						<input  type="button" class="b_foot" name="Return" onclick="removeCurrentTab()" value="关闭">
					</TD>
				</TR>
			</TABLE>
			</FORM>
 		</DIV>
		
	<!-- delete -->	
		<div id=tbs2 style="display:none">
			<form name="form2" method="post" action="">
			<div class="title">
				<div id="title_zi">操作信息</div>
			</div>	
			<TABLE   cellspacing="0">
				<TBODY>
					<tr >
						<TD width="15%" class="blue">&nbsp;组织节点</td>
						<td width="35%">
							<input type="hidden" name="groupId">
							<input type="text" name="groupName" maxlength="60" readonly class="InputGrey">
							<input name="addButton" type="button" class="b_text"  value="选择" onClick="selectGroupId('form2')" >
							<font class="orange">*</font>	
						</TD>
						<TD width="15%" class="blue">&nbsp;工号有效性</td>
						<td width="35%">
							<select name=validFlag>
								<option value="1">有效</option>
								<option value="0">无效</option>
							</select>
						</td>
					</tr>
					<tr >
						<TD width="15%" class="blue">&nbsp;工号信息</td>
						<td width="35%">
							<input type="text" name="login_no2" maxlength="6" v_type="string" size=8 v_must=1  onChange="changeLoginNo()">
							<input type="text" name="login_name2"  readonly class="InputGrey">
							<input name="loginNoQuery"  type="button" class="b_text" onClick="getLoginNo(2)" value="查询">
							<font class="orange">*</font>
						</TD>
						<TD nowrap class="blue">&nbsp;角色信息</TD>
						<TD nowrap >
							<input type=text name=power_code2 v_type="string" size=31 v_must=1   value="">							
							<input type="button"  class="b_text" name="btnQueryRoleCode" onclick="queryRoleCodeDel('form2')" value="选择">
							<font class="orange">*</font>
						</TD>
					</TR>
					<tr>
						<td class="blue">&nbsp;OA编号</td>
						<td><input type="text" id="oaNumberd" name="oaNumberd" maxlength="30"/><font color="orange">*</font></td>
						<td class="blue">&nbsp;OA标题</td>
						<td><input type="text" id="oaTitled" name="oaTitled" maxlength="30"/><font color="orange">*</font></td>
					</tr>
				</TBODY>
			</TABLE>
			<TABLE   cellspacing="0">
				<tr> 
					<td id="footer">
						<input  type="button" class="b_foot" name="bSubmit2" onclick="if(check(form2)) fsubmit2()" value="删除" >&nbsp;
						<input name="resetModBtn" class="b_foot" type="button"  value="重置" onclick="resetDel()">&nbsp;	
						<input  type="button"  class="b_foot" name="Return" onclick="removeCurrentTab()" value="关闭">
					</td>
				</tr>
			</table>
			</form>
		</div>
	<!--query list -->
		<div id=tbs3 style="display:none">
			<form name="form3" method="post" action="">
			<div class="title">
				<div id="title_zi">操作信息</div>
			</div>	
			<TABLE   cellspacing="0">
				<TBODY>
			    		<tr>
						<TD width="15%" class="blue">&nbsp;组织节点</td>
						<td width="35%">
							<input type="hidden" name="groupId">
							<input type="text" name="groupName" value="" maxlength="60" readonly class="InputGrey">
							<input name="qryButton" type="button" class="b_text" value="选择" onClick="selectGroupId('form3')" >
							<font class="orange">*</font>	
						</TD>
						<TD width="15%" class="blue">&nbsp;工号有效性</td>
						<td width="35%">
							<select name=validFlag>
								<option value="1">有效</option>
								<option value="0">无效</option>
							</select>
						</td>
					</tr>
					<tr >
						<TD width="15%" class="blue">&nbsp;工号信息</td>
						<td width="35%">
							<input type="text" name="login_no3" v_type="string" size=8 v_must=1   maxlength="6" size="8" onChange="changeLoginNo()">
							<input type="text" name="login_name3"  readonly class="InputGrey">
							<input name="loginNoQuery"  type="button" class="b_text" onClick="getLoginNo(3)" value="查询">
							<font class="orange">*</font>
						</TD>
						<TD nowrap class="blue">&nbsp;角色信息</TD>
						<TD nowrap >
							<input type=text size=8 name=power_code value="">
							<input type=text name="power_name" value="">
							<input type="button"  class="b_text" name="btnQueryRoleCode" onclick="queryRoleCode('form3')" value="选择">
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
		  
	  	<TABLE  cellSpacing=0>
			<TR> 
		         	<TD id="footer"> &nbsp;
		         	    <input name="btnSubmit3" class="b_foot" style="cursor:hand" type="button"  value="查询" onClick="queryLoginRole()">&nbsp;
		         	    <input name="" class="b_foot" style="cursor:hand" type="button"  value="重置" onclick="javascript:document.location='f8175_1.jsp?returnFlag=3'">&nbsp;  
		         	    <input name="" class="b_foot" style="cursor:hand" type="button"  value="关闭" onClick="removeCurrentTab();">
		         	    &nbsp;
				 </TD>
		       </TR>
		   </TABLE>	
		
	</form>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>

<script language=javascript>
	showDiv();
</script>