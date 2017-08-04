   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-16
********************/
%>
              
<%
  
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
	String opCode = (String)request.getParameter("opCode");
  	String opName = (String)request.getParameter("opName");
	String workNo = (String)session.getAttribute("workNo");
	String nopass  = (String)session.getAttribute("password");
	String regionCode= (String)session.getAttribute("regCode");
	
	String role_codeIn = request.getParameter("role_code"); 			 //角色代码

		/********************* 输出参数 *************************/
		String role_code     = ""; //角色代码 
		String roleType_code = ""; //角色类型
		String role_name     = ""; //角色名称   
		String role_describe = ""; //角色描述  
		String create_login  = ""; // 创建工号 
		String use_flag      = "";	// 使用标志    
		String create_date   = ""; // 创建日期 
		String op_note       = ""; // 操作备注 
		String create_login_name    = ""; // 创建者名称
		String create_login_GrpName  = ""; //创建者组织节点
		/******************************************************/
		
		
		String paramsIn[] = new String[4];		 	
	 	paramsIn[0] = workNo;
	 	paramsIn[1] = nopass;
	 	paramsIn[2] = "8029";
	 	paramsIn[3] = role_codeIn;
	 	
			   
	//	acceptList = callView.callFXService("s8029_Qry06", paramsIn, "10","region", regionCode);
%>

    <wtc:service name="s8029_Qry06" outnum="10" retmsg="msg6" retcode="code6" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />			
		</wtc:service>
		<wtc:array id="result_t" scope="end" />

<%		
		String errCode = code6;   
	  String errMsg = msg6;		
		  
	 	if(errCode.equals("000000"))
	 	{	
			

		role_code    			= result_t[0][0];
		role_name				= result_t[0][1];
		roleType_code			= result_t[0][2];
		role_describe			= result_t[0][3];
		create_login 			= result_t[0][4];
		use_flag     			= result_t[0][5];
		create_date  			= result_t[0][6];
		op_note      			= result_t[0][7];
		create_login_name      	= result_t[0][8];			
		create_login_GrpName   = result_t[0][9];		
			
			if(result_t.length == 0)
			{			
%>
				<script language='jscript'>
					rdShowMessageDialog("没有查到相关记录！",0);
					window.close();
				</script>
<%  
		}else if(result_t.length == 1)
			{
%>
		
				<script language='jscript'>
					window.opener.form3.role_code.value="<%=result_t[0][0].trim()%>";
				  window.opener.form3.role_name.value="<%=result_t[0][1].trim()%>";
					window.opener.form3.role_describe.value="<%=result_t[0][3].trim()%>";
				  window.opener.form3.roleType_code.value="<%=result_t[0][2].trim()%>";
				  window.opener.form3.roleType_codeIn.value="<%=result_t[0][2].trim()%>";
					window.opener.form3.use_flag.value="<%=result_t[0][5].trim()%>";
					window.opener.form3.create_login.value="<%=result_t[0][4].trim()%>";
				  window.opener.form3.create_date.value="<%=result_t[0][6].substring(0,8).trim()%>";
					window.opener.form3.op_note.value="<%=result_t[0][7].trim()%>";
					window.opener.form3.create_login_name.value="<%=result_t[0][8].trim()%>";
					window.opener.form3.create_login_GrpName.value="<%=result_t[0][9].trim()%>";
					window.opener.form3.query_role.disabled=true;	
					window.opener.form3.role_relationmsg.disabled=false;	
					window.opener.form3.role_code.readOnly=true;  	
					window.opener.form3.role_name.readOnly=true;			
					window.close();
				</script>
<%  			
			}	 	
	 	}
	 	else
	 	{
%>
			<script language='jscript'>
			     rdShowMessageDialog("错误信息：<%=errMsg%>[<%=errCode%>]" ,0);
			     window.close();
		    </script> 
<%
		}	
%>	
<html>
<head>
<title>角色列表</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>
<body>
<form name="frm" method="POST" >
	<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table width="99%" border="0" align="center" cellpadding="1" cellspacing="1">
	
	<%-- added by hanfa 20061109--%>
	<TR>
	<TD>
	<DIV style="overflow:auto;<%if(result_t.length>17)out.print("height:440px;");%>">			    	
	<TABLE id="tab1" width="100%">
	
	<tr bgColor="#eeeeee">
		<td colspan="3"> 
			<%-- added by hanfa 20061109 --%>	
			
					<strong><font color='blue'>正在加载数据......</font></strong>
		</td>
   </tr>
			   
	<tr bgColor="#eeeeee">
		<td height="26" align="center">
			选择
		</td>
		<td  align="center">
			角色代码
		</td>
		<td align="center">
			角色名称
		</td>
	</tr>
	
	</TABLE>
    </DIV>
	</TD>
	</TR>
</table>
   

<table  cellspacing="0">
	<tr>
		<td>
				<div align="center">
			      <input type="button" name="commit" onClick="doCommit();" value=" 确定 " class="b_foot">
			      &nbsp;
			      <input type="button" name="back" onClick="doClose();" value=" 关闭 " class="b_foot">
		    </div>
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

<script>

		<%for(int i=0;i < result_t.length;i++){ %>
			var str='<input type="hidden" name="role_code" value="<%=result_t[i][0].trim()%>">';
			str+='<input type="hidden" name="role_name" value="<%=result_t[i][1].trim()%>">';
			str+='<input type="hidden" name="role_describe" value="<%=result_t[i][3].trim()%>">';
			str+='<input type="hidden" name="roleType_code" value="<%=result_t[i][2].trim()%>">';
			str+='<input type="hidden" name="roleType_codeIn" value="<%=result_t[i][2].trim()%>">';
			str+='<input type="hidden" name="use_flag" value="<%=result_t[i][5].trim()%>">';
			str+='<input type="hidden" name="create_login" value="<%=result_t[i][4].trim()%>">';
			str+='<input type="hidden" name="create_date" value="<%=result_t[i][6].substring(0,8).trim()%>">';
			str+='<input type="hidden" name="op_note" value="<%=result_t[i][7].trim()%>">';
			str+='<input type="hidden" name="create_login_name" value="<%=result_t[i][8].trim()%>">';
			str+='<input type="hidden" name="create_login_GrpName" value="<%=result_t[i][9].trim()%>">';

						
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  	newrow.insertCell(1).innerHTML = '<%=result_t[i][1].trim()%>';
		  	newrow.insertCell(2).innerHTML = '<%=result_t[i][2].trim()%>';
		  
		  
		<%}%>
		
		var hintTab = document.getElementById("tab2"); //added by hanfa 20061108
		hintTab.style.display="none";  //added by hanfa 20061108
		
		function doCommit(){
			if("<%=result_t.length%>"=="0"){
				rdShowMessageDialog("您没有输入角色代码！");
				return false;
			}
			else if("<%=result_t.length%>"=="1"){//值为一条时不需要用数组
				if(document.all.num.checked){
					window.opener.form3.role_code.value=document.all.role_code.value;
				  window.opener.form3.role_name.value=document.all.role_name.value;
					window.opener.form3.role_describe.value=document.all.role_describe.value;
				  window.opener.form3.roleType_code.value=document.all.roleType_code.value;
				  window.opener.form3.roleType_codeIn.value=document.all.roleType_code.value;
					window.opener.form3.use_flag.value=document.all.use_flag.value;
					window.opener.form3.create_login.value=document.all.create_login.value;
				  window.opener.form3.create_date.value=document.all.create_date.value;
					window.opener.form3.op_note.value=document.all.op_note.value;
					window.opener.form3.create_login_name.value=document.all.create_login_name.value;
					window.opener.form3.create_login_GrpName.value=document.all.create_login_GrpName.value;
					
					window.opener.form3.query_role.disabled=true;			
					window.opener.form3.role_relationmsg.disabled=false;			
					window.opener.form3.role_code.readOnly=true;  
					window.opener.form3.role_name.readOnly=true;
					window.close();
				}
				else{
					rdShowMessageDialog("您没有输入角色代码！！");
					return false;
				}
			}
			else{//值为多条时需要用数组
				var a=-1;
				for(i=0;i<document.all.num.length;i++){
					if(document.all.num[i].checked){
						a=i;
						break;
					}
				}
				if(a!=-1){
					window.opener.form3.role_code.value=document.all.role_code[a].value;
					window.opener.form3.role_name.value=document.all.role_name[a].value;
					window.opener.form3.role_describe.value=document.all.role_describe[a].value;
					window.opener.form3.op_note.value=document.all.op_note[a].value;
					window.opener.form3.roleType_code.value=document.all.roleType_code[a].value;
					window.opener.form3.roleType_codeIn.value=document.all.roleType_code[a].value;
					window.opener.form3.use_flag.value=document.all.use_flag[a].value;
					window.opener.form3.create_login.value=document.all.create_login[a].value;
					window.opener.form3.create_date.value=document.all.create_date[a].value;
					window.opener.form3.create_login_name.value=document.all.create_login_name[a].value;
					window.opener.form3.create_login_GrpName.value=document.all.create_login_GrpName[a].value;
					window.opener.form3.query_role.disabled=true;					
					window.opener.form3.role_code.readOnly=true;  
					window.opener.form3.role_name.readOnly=true;  
					window.opener.form3.role_relationmsg.disabled=false;	
					window.close();
				}
				else{
					rdShowMessageDialog("您没有输入角色代码！！",0);
					return false;
				}
			}
		}
		
	function doClose(){
		window.close();
	}
</script>
