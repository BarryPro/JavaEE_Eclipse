
<%
/********************
 version v2.0
 开发商 si-tech
 create haoyy@2010-8-20
********************/
%>


<%
  	String opCode = "b465";
	String opName = "地市级角色批量赋权";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@page contentType="text/html;charset=gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%
System.out.println("********************* funclist *********************");
	String[][] result = new String[][]{};
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);

	String loginNo = (String)session.getAttribute("workNo");
	String powerCode= baseInfoSession[0][4];
	String regionCode = (String)session.getAttribute("regCode");

	String roleName = request.getParameter("roleName");	//角色名称
	String roleTypeCode  = request.getParameter("roleTypeCode");
	String popeDomCodeIn = request.getParameter("popeDomCode");	//权限代码
	String popeDomNameIn = request.getParameter("popeDomName");	//权限代码
	String roles = request.getParameter("roles");	//所有所选的角色代码
	int Num=0;

	if(popeDomNameIn==null)
	popeDomNameIn="全部权限";

	String op_name = "地市级角色批量赋权";
	String note = "您正在修改角色<b>("+roleName+")</b>的<b>"+popeDomNameIn+"</b>下的权限信息";

	//输出参数
	String checkFlag   [][]=new String[][]{};				//选中标志
	String popeDomCode [][]=new String[][]{};				//权限代码
	String popeDomName [][]=new String[][]{};				//权限名称
	String reflectCode [][]=new String[][]{};				//操作代码
	String bakLeafFlag [][]=new String[][]{};				//备用

	String paramsIn[] = new String[6];

	paramsIn[0]=loginNo;
	paramsIn[1]="b465";
	paramsIn[2]="";
	paramsIn[3]=popeDomCodeIn;
	paramsIn[4]=powerCode;
	paramsIn[5]=roleTypeCode;

	ArrayList acceptList = new ArrayList();

	//acceptList = callView.callFXService("sQryRolePDOM", paramsIn, "25","region",regionCode);
%>

    <wtc:service name="sQryRolePDOM" outnum="25" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />
		</wtc:service>
		<wtc:array id="checkFlag1" scope="end" start="0"  length="1" />
		<wtc:array id="popeDomCode1" scope="end" start="1"  length="1" />
		<wtc:array id="popeDomName1" scope="end" start="2"  length="1" />
		<wtc:array id="reflectCode1" scope="end" start="3"  length="1" />
		<wtc:array id="bakLeafFlag1" scope="end" start="4"  length="1" />

<%


	String errCode = code;
	String errMsg = msg;
	if(!errCode.equals("000000"))
	{
	%>
	  <script language='jscript'>
	     rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	     window.close();
	  </script>

	<%
	}
 if(errCode.equals("000000")){
 	  checkFlag =checkFlag1;		//选中标志
	  popeDomCode = popeDomCode1;
	  popeDomName = popeDomName1;
	  reflectCode = reflectCode1;
	  bakLeafFlag = bakLeafFlag1;
	  Num=popeDomCode.length;
 }
	%>
<html>
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
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
	}

	for(i=0;i<document.all.check.length;i++)
	{
		document.all.check[i].checked=true;
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
	}

	for(i=0;i<document.all.check.length;i++)
	{
		document.all.check[i].checked=false;
	}

}
//--------获得所有所选的权限代码--------------
function getPopes()
{
	var popes='';
	var i=0;
	for( i=0;i<document.all.check.length;i++)
	{
		if(document.all.check[i].checked==true){
			if(popes==''){
				popes+=document.all.check[i].value;
			}else{
				popes+=","+document.all.check[i].value;
			}
		}
	}
	return popes;
}

function doSubmit(num)
{

	if(document.all.check==undefined)
	{
		rdShowMessageDialog("此目录下没有权限,无法提交！");
		return;
	}
	var popes='';
	if(num>1){
		popes=getPopes();
	}else if(document.all.check.checked==true){
		popes=document.all.check.value;
	}
	if(popes=='')
	{
		rdShowMessageDialog("请选择具体的权限！",1);
		return false;
	}else{
		form1.action="fb465_setrolepdom.jsp?parPopeDomCode="+"<%=popeDomCodeIn%>"+"&popes="+popes+"&roleName="+"<%=roleName%>"+"&roles="+"<%=roles%>";
		form1.submit();
	}
}
</script>
</head>
<body>

<FORM METHOD=POST ACTION="" name="form1">
<%@ include file="/npage/include/header_pop.jsp" %>


	<div class="title">
		<div id="title_zi"><script language="javascript">document.write(document.title);</script></div>
	</div>



				<table cellspacing="0">
					<tr height="20">
						<td align="center" colspan=5>
							<font color=green><%=note%></font>
						</td>
					</tr>
					<tr height="20">
						<th align="center">选择</th>
				  	<th align="center">权限代码</th>
				  	<th align="center">权限名称</th>
				  	<th align="center">操作代码</th>
				</tr>
				<%
				String class_str="";
					for(int i = 0; i < checkFlag.length; i++)
					{
					if(i%2==0)
						class_str = "Grey";
					else
						class_str = "";
				%>
							<td align="center" class="<%=class_str%>"  height="20">
								<input type=checkbox name=check value="<%=popeDomCode[i][0]%>"
								<%if(checkFlag[i][0].equals("Y")){out.println("checked");}%>></td>
							<td align="center" class="<%=class_str%>"  height="20"><%=popeDomCode[i][0]%></td>
							<td align="center" class="<%=class_str%>"  height="20"><%=popeDomName[i][0]%></td>
							<td align="center" class="<%=class_str%>"  height="20"><font class=orange><b>
								<%=reflectCode[i][0]%></b></font>
							</td>
							<input type=hidden name=popeDomCode value="<%=popeDomCode[i][0]%>" >
						</tr>
				<%
					}
				%>
						<TR>
							<TD height="30" align="center" colspan=5 id="footer">
								<input class="b_foot_long" name=allSelectt type=button    value="全部选中" onclick="allSelect()" >&nbsp;
								<input class="b_foot_long" name=noSelectt  type=button    value="全部取消" onclick="noSelect()" >&nbsp;
								<input class="b_foot" name="doButton" type="button"  value="提  交"   onclick="doSubmit(<%=Num %>)">&nbsp;
								<input class="b_foot" name="doButton" type="button"  value="关  闭"   onclick="parent.window.close()">&nbsp;
							</TD>
						</TR>
			 		</table>

		<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>


