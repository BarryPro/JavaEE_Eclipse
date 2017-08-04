<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-20
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "个人产品配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.util.regex.*"%>
<%
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");                //工号
	String nopass  = (String)session.getAttribute("password");                    	//登陆密码
	String regionCode = (String)session.getAttribute("regCode");
	
	//获取从上页得到的信息
	String login_accept = request.getParameter("login_accept");	
	String mode_code = request.getParameter("mode_code");
	String mode_code_new = request.getParameter("mode_code_new");
	String mode_name = request.getParameter("mode_name");
	String region_code = request.getParameter("region_code");
	String select_type = request.getParameter("select_type")==null?"0":request.getParameter("select_type");
	String trans_type = request.getParameter("trans_type");	
	String sm_code_new = request.getParameter("sm_code_new");
	String mode_name_new = request.getParameter("mode_name_new");
	String whereSql = request.getParameter("whereSql");
	String modeTypeCond = request.getParameter("modeTypeCond");
	//获取所有的优惠信息
	String[] paramsIn=new String[13];
	paramsIn[0]=workNo;
	paramsIn[1]=nopass;
	paramsIn[2]="5238";
	paramsIn[3]=login_accept;
	paramsIn[4]=mode_code_new;
	paramsIn[5]=region_code;
	paramsIn[6]=select_type;
	paramsIn[7]=trans_type;
	paramsIn[8]=mode_code;	
	paramsIn[9]=sm_code_new;
	paramsIn[10]=mode_name_new;
	paramsIn[11]=whereSql;
	paramsIn[12]=modeTypeCond+"|";
	
	//retArray=callView.callFXService("s5238_ModDepQry",paramsIn,"4");	
	%>
	
		 <wtc:service name="s5238_ModDepQry" outnum="6" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />		
			<wtc:param value="<%=paramsIn[3]%>" />	
			<wtc:param value="<%=paramsIn[4]%>" />				
			<wtc:param value="<%=paramsIn[5]%>" />
			<wtc:param value="<%=paramsIn[6]%>" />
			<wtc:param value="<%=paramsIn[7]%>" />
			<wtc:param value="<%=paramsIn[8]%>" />		
			<wtc:param value="<%=paramsIn[9]%>" />
			<wtc:param value="<%=paramsIn[10]%>" />
			<wtc:param value="<%=paramsIn[11]%>" />
			<wtc:param value="<%=paramsIn[12]%>" />				
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />
	
	<%
%>
<html>
<head>
<title>无标题文档</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script>
//------将列表中选中的信息返回到f5238_deployChange.jsp页面中---------
function commit()
{
	//parent.submitAdd();
	//parent.opener.document.form1.mode_code.value="test";
	var old_modes = new Array();
	var new_modes = new Array();
	var mode_flags = new Array();
	if(document.all.checkbox1==undefined)
	{
		rdShowMessageDialog("没有选择的产品代码！");
		parent.document.form1.conmit.disabled=false;
		return;
	}
	else if(document.all.checkbox1.length==undefined)
	{
		if(document.all.checkbox1.checked)
		{
			document.form1.old_mode_array.value=document.all.old_mode.value;
			document.form1.new_mode_array.value="<%=mode_code%>";
		  	document.form1.mode_flag_array.value=document.all.mode_flag.value;
		}
		else
		{
			document.form1.new_mode_array.value="<%=mode_code%>";
		}
	}
	else if(document.all.checkbox1.length>0)
	{
		var j=0;
		for(var i=0;i<document.all.checkbox1.length;i++)
		{
			if(document.all.checkbox1[i].checked)
			{	
				old_modes[j]=document.all.old_mode[i].value;
				new_modes[j]="<%=mode_code%>";
				mode_flags[j]=document.all.mode_flag[i].value;
				j++;
			}	
		}
		if(j==0)
		{
			new_modes[j]="<%=mode_code%>";
		}
		document.form1.old_mode_array.value=old_modes;
		document.form1.new_mode_array.value=new_modes;
		document.form1.mode_flag_array.value=mode_flags;

	}
	
	document.form1.action="f5238_modeDependCfm.jsp";
	document.form1.submit();
}



//--------全部选中---------
function selectAll()
{
	if(document.all.checkbox1.length==undefined)
	{
		document.all.checkbox1.checked=true;
	}
	else if(document.all.checkbox1.length>0)
	{
		for(var i=0;i<document.all.checkbox1.length;i++)
		{
			document.all.checkbox1[i].checked=true;
		}
	}
}

//----全部取消------
function selectNone()
{
	if(document.all.checkbox1.length==undefined)
	{
		document.all.checkbox1.checked=false;
	}
	else if(document.all.checkbox1.length>0)
	{
		for(var i=0;i<document.all.checkbox1.length;i++)
		{
			document.all.checkbox1[i].checked=false;
		}
	}
}
</script>

</head>
<body >
<form target="middle" action="" method="post" name="form1">
	
<div id="Main">
   <DIV id="Operation_Table">                       

<input type="hidden" name="login_accept" value="<%=login_accept%>"> 
<input type="hidden" name="mode_code" value="<%=mode_code%>">
<input type="hidden" name="mode_name" value="<%=mode_name%>">
<input type="hidden" name="old_mode_array" value="">
<input type="hidden" name="new_mode_array" value="">
<input type="hidden" name="mode_flag_array" value="">
<input type="hidden" name="region_code" value="<%=region_code%>">
<input type="hidden" name="trans_type" value="<%=trans_type%>">
      		<table cellspacing="0">
				<%  
					if(code.equals("000000"))
					{
						for(int i=0;i<result_t.length;i++)
						{
				%>
						<tr bgcolor="#F5F5F5" height="20">
							<TD width="74"><input type="checkbox" name="checkbox1" <%=result_t[i][0].equals("1")==true?"checked":""%>></TD>
							<TD width="190"><input type="text" name="old_mode" size="10" class="InputGrey" readonly value="<%=result_t[i][1]%>"></TD>
							<TD width="418"><input type="text" name="old_name" size="30" class="InputGrey" readonly value="<%=result_t[i][2]%>"></TD>
							<TD width="53"><input type="text" name="mode_flag" size="6"   value="<%=result_t[i][3]%>"></TD>
						</tr>
				<%
						}
					}
	  			%>
      		</table>
		</td>
  	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>	
</body>
</html>  
	