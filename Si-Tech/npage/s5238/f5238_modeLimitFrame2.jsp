<% 
  /*
   * 功能: 产品互斥关系配置时显示查询到的产品代码 
　 * 版本: v1.00
　 * 日期: 2007/01/25
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   *  
 　*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.util.regex.*"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<%
	//读取用户session信息
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //工号
	String workName = baseInfo[0][3];               	//工号姓名
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     	//登陆密码
	String regionCode=org_code.substring(0,2);
	
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
	int errCode=0;
    String errMsg="";
	//获取所有的信息
	SPubCallSvrImpl callView = new SPubCallSvrImpl();
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
  	ArrayList retArray = new ArrayList();
	
	retArray=callView.callFXService("s5238_ModLimQry",paramsIn,"4");	
	callView.printRetValue();
	errCode = callView.getErrCode();
	errMsg = callView.getErrMsg();
%>
<html>
<head>
<title>无标题文档</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
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
	
	document.form1.action="f5238_modeLimitCfm.jsp";
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
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form target="middle" action="" method="post" name="form1">
<input type="hidden" name="login_accept" value="<%=login_accept%>"> 
<input type="hidden" name="mode_code" value="<%=mode_code%>">
<input type="hidden" name="mode_name" value="<%=mode_name%>">
<input type="hidden" name="old_mode_array" value="">
<input type="hidden" name="new_mode_array" value="">
<input type="hidden" name="mode_flag_array" value="">
<input type="hidden" name="region_code" value="<%=region_code%>">
<input type="hidden" name="trans_type" value="<%=trans_type%>">
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
  	<tr>
    	<td>
      		<table width="100%"  border="0"  align="center" bordercolor="#D6D3CE" bgcolor="#ffffff" cellspacing="1">
				<%  
					if(errCode==0)
					{
						String[][]mode_code_selected=(String[][])retArray.get(0);
						String[][]mode_code_newb=(String[][])retArray.get(1);
						String[][]mode_name_newb=(String[][])retArray.get(2);
						String[][]mode_flag_newb=(String[][])retArray.get(3);
						System.out.println("#########");
	                	
						for(int i=0;i<mode_code_selected.length;i++)
						{
				%>
						<tr bgcolor="#F5F5F5" height="20">
							<TD width="74"><input type="checkbox" name="checkbox1" <%=mode_code_selected[i][0].equals("1")==true?"checked":""%>></TD>
							<TD width="190"><input type="text" name="old_mode" size="10" class="likebutton4" readonly value="<%=mode_code_newb[i][0]%>"></TD>
							<TD width="418"><input type="text" name="old_name" size="30" class="likebutton4" readonly value="<%=mode_name_newb[i][0]%>"></TD>
							<TD width="53"><input type="text" name="mode_flag" size="6" class="likebutton4" readonly value="<%=mode_flag_newb[i][0]%>"></TD>
						</tr>
				<%
						}
					}
	  			%>
      		</table>
		</td>
  	</tr>
</table>
</form>	
</body>
</html>  
