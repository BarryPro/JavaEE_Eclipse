<%
   /*
   * 功能: 角色发布 - 主界面
　 * 版本: v1.0
　 * 日期: 2007/06/25
　 * 作者: hanfa
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>

<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.05
 模块: 角色发布
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.text.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>

<%
	
	String loginName = (String)session.getAttribute("workName");
	String loginNo = (String)session.getAttribute("workNo");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	
	String workNo = loginNo;
	String workName = loginName;
	String opName = "角色发布";
	
	String returnFlag = request.getParameter("returnFlag");
	String opCode = "8055";
	
%>

<head>
<title><%=opName%></title>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

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
		}else if(returnFlag==3)
		{
			showtbs3_view();
		}	
	}
	
	function fsubmit1()
	{
		getAfterPrompt();
		if(document.form1.power_code.value==""){
			rdShowMessageDialog("请选择角色代码！");	
			return false;
		}
		if(document.form1.objectId.value==""){
			rdShowMessageDialog("请选择发布组织节点！");	
			return false;
		}
		document.form1.action="f8055_submit_add.jsp"; //insert
		document.form1.submit();
		document.form1.bSubmit1.disabled=true;
	}
	
	function fsubmit2()
	{
		getAfterPrompt();
		if(document.form2.power_code.value==""){
			rdShowMessageDialog("请选择角色代码！");	
			return false;
		}
		if(document.form2.objectId.value==""){
			rdShowMessageDialog("请选择发布组织节点！");	
			return false;
		}
		if(rdShowConfirmDialog("将删除该节点和该节点以下组织节点发布的角色代码。<br>是否删除？") == 1)
		{
			document.form2.action="f8055_submit_del.jsp"; //delete
			document.form2.submit();
			document.form2.bSubmit2.disabled=true;
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
			
	function showtbs3()
	{
		showtbs3_view();
		resetQry();
	}		
		
	function showtbs1_view(){	
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

	function showtbs2_view(){	
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
	function queryObjectId(formName)
	{
		var path = "";
		
		if(formName == "form3")
		{
		/*	var path = "../rpt/common/grouptree.jsp?grouptype=form3&grpType=0&grpId=groupId&grpName=objectId";*/
			var path = "<%=request.getContextPath()%>/npage/public/pubtree/grouptree.jsp?frmName=form3&groupId=groupId&groupName=objectId&serverType=ALL";
 		 	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
		}
		else
		{
			path = "f8055_grouptree.jsp";//"f8055_queryObjectId.jsp";
			var roleCode = document.form2.power_code.value;
			window.open(path + "?groupType=" + formName+"&roleCode="+roleCode,"","height=530,width=450,scrollbars=yes");
		}
	}
	
	//查询已发布的角色信息
	function queryPulishPowerInfo()
	{
		getAfterPrompt();
		var power_code = document.form3.power_code.value;
		var objectId = document.form3.groupId.value;
		
		if(power_code=="" && objectId=="")
		{
			rdShowMessageDialog("请选择“角色代码”或“发布组织节点”进行查询！");	
			return false;
		}

		var str = "?power_code=" + power_code + "&objectId=" + objectId;
		document.middle.location="f8055_pulishPowerInfo.jsp"+str;

		tabBusi.style.display="";
	}
	

</script>

<body>
<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		
       <TABLE cellSpacing="0">
        <tr>
        	<TD  style="background:999999" style="height=100%" width="5%" nowrap><a style="background:999999" id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs1()" value="1">&nbsp;&nbsp;<font id="font1" color='222222'>增加&nbsp;&nbsp;</font></a></TD>
			<TD  style="height=100%" width="5%" nowrap><a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs2()" value="1">&nbsp;&nbsp;<font id="font2" >删除&nbsp;&nbsp;</font></a></TD>
       		<TD  style="height=100%" width="5%" nowrap><a id="tabhead2" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs3()" value="1">&nbsp;&nbsp;<font id="font3" >查询&nbsp;&nbsp;</font></a></TD>
       		<td  style="height=100%"width="80%"></td> 
        </tr>
      </table>
		
	<!--add-->
   <div id=tbs1 style=display="">
	   <TABLE cellSpacing="0">
			<form name="form1" method="post" action="">
		    <TBODY>
		    	<TR>
				    <TD class="blue">角色代码</TD>
		 			<TD>
		  				<input type=text  v_type="string"  v_must=1  class="InputGrey" name=power_code  maxlength=10 size="10" readonly>
		  				<input type=text  name=power_name maxlength=10 class="InputGrey" readonly>
						<input class="b_text" type="button" name="query_powercode" onclick="queryPowerCode('form1')" value="选择">
		     		<font color="orange">*</font>
		     		</TD>
		     		<TD class="blue">发布组织节点</TD>
		 			<TD>
		 				<input type=hidden name="groupId" value="">
		  				<input type=text name="objectId" v_type="string"  v_must=1  class="InputGrey" readonly>
		            	<input class="b_text" type="button" name="btnQueryObjectId" onclick="queryObjectId('form1')" value="选择">
			     		<font color="orange">*</font>
		     		</TD>
		      	</TR>
			</TBODY>
	  	</TABLE>
  
  		<TABLE cellSpacing="0">
			<tr> 
				<td id="footer">
					<input class="b_foot" type="button" name="bSubmit1" onclick="if(check(form1)) fsubmit1()" value="增加" >&nbsp;
					<input name="resetModBtn" type="button" class="b_foot" value="重置" onclick="resetAdd()">&nbsp;	
					<input class="b_foot" type="button" name="Return" onclick="removeCurrentTab()" value="关闭">
				</td>
			</tr>
		</form>
		</table>
 </div>
 
  <!-- delete -->	
  <div id=tbs2 style="display:none">
	<TABLE cellSpacing="0">
		<form name="form2" method="post" action="">
    <TBODY>
    		<TR>          			
			    <TD class="blue">角色代码</TD>
	 			<TD>
	  				<input type=text  v_type="string"  v_must=1  name=power_code  maxlength=10 size="10" readonly class="InputGrey">
	  				<input type=text    name=power_name maxlength=10 readonly class="InputGrey">
					<input class="b_text" type="button" name="query_powercode" onclick="queryPowerCode('form2')" value="选择">
	     		<font color="orange">*</font>
	     		</TD>
	     		<TD class="blue">发布组织节点</TD>
	 			<TD>
	 				<input type=hidden name=groupId value="">
	  				<input type=text name="objectId" v_type="string"  v_must=1  readonly class="InputGrey">
	            	<input class="b_text" type="button" name="btnQueryObjectId" onclick="queryObjectId('form2')" value="选择">
		     		<font color="orange">*</font>
	     		</TD>
	      	</TR>
	</TBODY>
    </TABLE>
		<TABLE cellSpacing="0">
			<tr> 
				<td id="footer">		
					<input class="b_foot" type="button" name="bSubmit2" onclick="if(check(form2)) fsubmit2()" value="删除" >&nbsp;
					<input name="resetModBtn" type="button" class="b_foot" value="重置" onclick="resetDel()">&nbsp;	
					<input class="b_foot" type="button" name="Return" onclick="removeCurrentTab()" value="关闭">
				</td>
			</tr>
		</form>
		</table>
		
  </div>

  <!--query list -->
  <div id=tbs3 style="display:none">

	<TABLE cellSpacing="0">
		<form name="form3" method="post" action="">
       <TBODY>
    	<TR>          			
			    <TD class="blue">角色代码</TD>
	 			<TD>
	  				<input type=text  v_type="string"  v_must=0  name=power_code  maxlength=10 size="10" readonly class="InputGrey">
	  				<input type=text  name=power_name maxlength=10 class="InputGrey" readonly>
					<input class="b_text" type="button" name="query_powercode" onclick="queryPowerCode('form3')" value="选择">
	     		</TD>
	     		<TD class="blue">发布组织节点</TD>
	 			<TD>
	 				<input type=hidden name=groupId value="">
	  				<input type=text name="objectId" class="InputGrey" readonly>
	            	<input class="b_text" type="button" name="btnQueryObjectId" onclick="queryObjectId('form3')" value="选择">
	     		</TD>
	      	</TR>
		</TBODY>
     </TABLE>
	      
		<TABLE id="tabBusi" style="display:none" cellspacing="0">	
			<TR> 
				<td nowrap>
					<IFRAME frameBorder=0 id=middle name=middle scrolling="yes"  
					style="HEIGHT: 300px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
					</IFRAME>
				</td> 
			</TR>
		</TABLE>	
		  
		  <TABLE cellSpacing="0">
				 <TR> 
		         	<TD id="footer"> 
		         	    <input name="btnSubmit3" style="cursor:hand" type="button" class="b_foot" value="查询" onClick="queryPulishPowerInfo()">
		         	    &nbsp;
		         	    <input name="" style="cursor:hand" type="button" class="b_foot" value="重置" onclick="javascript:document.location='f8055_1.jsp?returnFlag=3'">
		         	    &nbsp;  
		         	    <input name="" style="cursor:hand" type="button" class="b_foot" value="关闭" onClick="removeCurrentTab();">
		         	    &nbsp; 		         	     	         	   
				 	</TD>
		       </TR>
		       </form>
		   </TABLE>	     
  	</div>
  	
 <%@ include file="/npage/include/footer.jsp" %>   
</body>
</html>

<script>
	showDiv();
</script>