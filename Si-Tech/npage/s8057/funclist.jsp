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
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String opCode = "8057";
	String opName = "工号角色管理";
	
	//ArrayList retArray = new ArrayList();
	//String[][] result = new String[][]{};
	String loginNo = (String)session.getAttribute("workNo");		
	String nopass  = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
	
	String roleCode = request.getParameter("roleCode");	//角色代码
	String roleName = request.getParameter("roleName");	//角色名称
	
	String popeDomCodeIn = request.getParameter("popeDomCode");	//权限代码
	String popeDomNameIn = request.getParameter("popeDomName");	//权限代码

	System.out.println("popeDomCodeIn="+popeDomCodeIn);

	
	String op_name = "角色与权限代码互斥配置";

	//输出参数
	String	checkFlag [][] = new String[][]{};		//配置标志（Y选中  N不选中）
	String	rolePdom [][] = new String[][]{};       //权限代码
	String	rolePdomName [][]= new String[][]{};    //权限名称


	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	
	//ArrayList acceptList = new ArrayList();
	
	
	String paramsIn[] = new String[5];
	
	paramsIn[0] = loginNo;
	paramsIn[1] = nopass;
	paramsIn[2] = "8057";
	paramsIn[3] = roleCode;
	paramsIn[4] = popeDomCodeIn; 
		   
	//acceptList = callView.callFXService("sQryPowPdomRela", paramsIn,"3","region",regionCode);
%>
	<wtc:service name="sQryPowPdomRela" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>		
	</wtc:service>
	<wtc:array id="checkFlag1" start="0" length="1" scope="end"/>
	<wtc:array id="rolePdom1" start="1" length="1" scope="end"/>
	<wtc:array id="rolePdomName1" start="2" length="1" scope="end"/>
<%
	
	String errCode = retCode1;
	String errMsg = retMsg1;
	if(!errCode.equals("000000"))
	{
	%>        
	  <script language='jscript'>
	     rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	     parent.window.close();	    
	  </script> 
	     
	<%  
	}		
	if(errCode.equals("000000"))
	{
		checkFlag=checkFlag1;
		rolePdom= rolePdom1; 
		rolePdomName= rolePdomName1;
	}     
	%>    
<html>  
<head>  
<title><%=op_name%></title>
<script language=javascript>

//--------全选--------------
function allSelect()
{
	var i = 0;
	
	//一行都没有
	if(document.all.check==undefined)
	{
		rdShowMessageDialog("此目录下没有权限,无法全部选中！");
		return;
	}
	//只有一行
	if(document.all.check.length==undefined)
	{
		document.all.check.checked=true;
		document.all.new_check.value = "Y";
	}
	for(i=0;i<document.all.check.length;i++)
	{
		document.all.check[i].checked=true;
		document.all.new_check[i].value = "Y";
	}
}

//----------全部去掉--------
function noSelect()
{
	var i = 0;
	
	//一行都没有		
	if(document.all.check==undefined)
	{
		rdShowMessageDialog("此目录下没有权限,无法全部取消！");
		return;
	}
	
	//只有一行
	if(document.all.check.length==undefined)
	{
		document.all.check.checked=false;
		document.all.new_check.value = "N";
	}	
	
	for(i=0;i<document.all.check.length;i++)
	{
		document.all.check[i].checked=false;
		document.all.new_check[i].value = "N";
	}
	
}

function chg_check(index)
{
	if(document.all.check.length==undefined)
	{
		if(document.all.check.checked==true)
		{
			document.all.new_check.value="Y";
		}
		else
		{
			document.all.new_check.value="N";
		}
	}
	else
	{
		if(document.all.check[index].checked==true)
		{
			document.all.new_check[index].value="Y";
		}
		else
		{
			document.all.new_check[index].value="N";
		}
	}
}

function doSubmit()
{
	getAfterPrompt();
	if(document.all.check==undefined)
	{
		rdShowMessageDialog("此目录下没有权限,无法提交！");
		return;
	}
	
	document.form1.action="f8057_rolePowerCfm.jsp?&roleCode=<%=roleCode%>&popeDomCode=<%=popeDomCodeIn%>";
	document.form1.submit();
}
</script>
</head>
<body>

<FORM METHOD=POST ACTION="" name="form1">
	<%@ include file="/npage/include/header.jsp" %>   		
	<table   cellspacing="0" >
				<tr>
					<th>选择</th>
					<th>权限代码</th>
					<th>权限名称</th>
				</tr>
			<%
			for(int i = 0; i < checkFlag.length; i++)
			{
				if((i+1)%2==1)
				{
			%>
				<tr>
			<%	}
				else
				{
			%>
				<tr>
			<%
				}
			%>
					<td>
					<%if(checkFlag[i][0].trim().equals("Y"))
					{%>
						<input type="checkbox" name="check" value="<%=i%>" onclick="chg_check(<%=i%>)" checked>
						<input type="hidden" name="check2" value="<%=i%>" checked>
					<%
					}
					else
					{
					%>
						<input type="checkbox" name="check" value="<%=i%>" onclick="chg_check(<%=i%>)">
				<%	}
				%>
					</td>
					<td>
						<%=rolePdom[i][0]%>
						<input type=hidden name="rolePdom" value="<%=rolePdom[i][0]%>">
						<input type=hidden name=old_check value="<%=checkFlag[i][0]%>" >
						<input type=hidden name=new_check value="<%=checkFlag[i][0]%>" >
					</td>
					<td>
						<%=rolePdomName[i][0]%>
					</td>
				</tr>
			<%
			}
			%>
	</talbe>
	<table   cellspacing="0" >
		<TR>
			<TD id="footer">
				<input class="b_foot_long" name=allSelectt type=button    value="全部选中" onclick="allSelect()" >&nbsp;
				<input class="b_foot_long" name=noSelectt  type=button    value="全部取消" onclick="noSelect()" >&nbsp;
				<input class="b_foot" name="doButton" type="button" value="提  交" onclick="doSubmit()">&nbsp;
				<input class="b_foot" name="doButton" type="button" value="关  闭" onclick="parent.window.close()">&nbsp;
			</TD>
		</TR>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>  
</form>
</html>







