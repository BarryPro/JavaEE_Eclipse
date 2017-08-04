   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-27
********************/
%>
            
              
<%
  String opCode = "8054";
  String opName = "角色权限管理";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@page contentType="text/html;charset=gbk"%>
<html>
<head>
<title><%=opName%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script language=javascript>

//----查询角色代码的明细------
function doQuery(roleCode,roleName)
{

	if(roleCode==""&&roleName=="")
	{
		var path = "roletree.jsp";
  	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
	}
	else
	{
		//window.open("f8054_getRole.jsp?roleCode="+roleCode+"&roleName="+roleName,"","height=500,width=400,scrollbars=yes");
		var path = "roletree.jsp";
		window.open(path,'_blank','height=600,width=300,scrollbars=yes');
	}
	
	document.form1.roleCode.readOnly=true;
	document.form1.roleName.readOnly=true;
	//document.getElementById("roleCode").Class="InputGrey";
	document.form1.roleCode.className ="InputGrey";
	document.form1.roleName.className ="InputGrey";
	document.form1.setPdButton.disabled=false;
	document.form1.qryButton.disabled=false;
}

function doReset()
{
	document.form1.roleCode.readOnly=false;
	document.form1.roleName.readOnly=false;
	document.form1.roleCode.className ="";
	document.form1.roleName.className ="";
	//将以前的信息置空
	document.form1.roleCode.value="";
	document.form1.roleName.value="";
	document.form1.roleTypeCode.value="";
	document.form1.roleDiscribe.value="";
	document.form1.roleTypeCode.value="";
	document.form1.roleTypeName.value="";

	document.form1.setPdButton.disabled=true;
	document.form1.qryButton.disabled=true;
}

function setPopedom()
{

	var roleCode = form1.roleCode.value;
	var roleName = form1.roleName.value;
	var roleTypeCode = form1.roleTypeCode.value;
	var win = window.open('f8054_setpdmain.jsp?roleCode='+roleCode+"&roleName="+roleName+"&roleTypeCode="+roleTypeCode,
		'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');

}

function qryPersonByrole()
{
	var roleCode = form1.roleCode.value;
	var path = "qryperson.jsp?roleCode="+roleCode;
	retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
}

function qryPopedom()
{
	var roleCode = form1.roleCode.value;
	if(roleCode == "")
	{
		rdShowMessageDialog("请先输入角色信息！",0);
		return;
	}
	var path = "f8054_qry.jsp?roleCode="+roleCode+"&roleName="+document.form1.roleName.value;
	retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
}

</script>
</head>
<body >

			<form name="form1" method="post" action="">
				<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
			<TABLE  cellspacing=0">
			<TBODY>

        	    <TR>
				    		<TD height = 20 class="blue">角色代码</TD>
	    	        <TD height = 20 align="left" >
	    	          	<input type=text  v_type="string"  v_must="0" v_minlength=0 v_maxlength=100 size=30 v_name="角色代码"  name="roleCode" id="roleCode" maxlength=30 onkeydown="if(event.keyCode==13)doQuery(document.form1.roleCode.value,document.form1.roleName.value)">&nbsp;
						<input  type="button" class="b_text" name="get" onclick="doQuery(document.form1.roleCode.value,document.form1.roleName.value)" value=" 查询 ">
	    	        </TD>
	    	        <TD>
	    	        	<input  type="button" name="qryPdom"  class="b_text" onclick="qryPopedom()" value="角色权限查询">
	    	        </TD>
	    	        <TD>&nbsp;</TD>
	    	    </TR>
	    	    <TR>
				    <TD width=12% height = 20  class="blue">角色名称</TD>
	    	        <TD width=38% height = 20 align="left">
	    	          	<input type=text  v_type="string"  size=30 v_must=1 v_minlength=0 v_maxlength=30 v_name="角色名称"  name="roleName" maxlength=30 >
					</TD>
					<TD width=12% height = 20 align="left"  class="blue">角色类型</TD>
	    	        <TD width=38% height = 20>
	    	          	<input type=hidden name="roleTypeCode" maxlength=5 readonly class="InputGrey">
	    	          	<input type=text   name="roleTypeName" maxlength=20 readonly class="InputGrey">
					</TD>
        	    </TR>
						<TR>
				    		<TD height = 20  class="blue">角色描述</TD>
	    	        <TD height = 20 align="left" colspan="3">
	    	          	<input type=text  v_type="string"  v_must=1 v_minlength=0 v_maxlength=80 v_name="角色描述"  name="roleDiscribe" maxlength=80 size="83" readonly class="InputGrey">
					</TD>
        	    </TR>
        		<TR>
        		<TD align="center" colspan="5" id="footer">
        			<input  type="button" name="qryButton"  class="b_foot_long" onclick="qryPersonByrole()" value="查询该角色工号" disabled >&nbsp;
        			<input  type="button" name="setPdButton"  class="b_foot_long"  onclick="setPopedom()" value="设置权限" disabled >&nbsp;
        			<input  type="button" name="reset"  class="b_foot" onclick="doReset()" value="重置">&nbsp;
							<input  type="button" name="Return"   class="b_foot"  onclick="removeCurrentTab()" value="关闭">
        		</TD>
        	   </TR>
         </TABLE>
         <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

