<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-25 页面改造,修改样式
********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.ParseException"%>
<%
	
	String opCode = "8002";
	String opName = "工号管理";
	String regionCode=(String)session.getAttribute("regCode");
	String loginNo = (String)session.getAttribute("workNo");	
	
	String roleCode = request.getParameter("roleCode");	//角色代码
	String roleName = request.getParameter("roleName");	//角色名称
	String loginNo1 = request.getParameter("loginNo1");	//新建或修改的工号代码		
	String popeDomCodeIn = request.getParameter("popeDomCode");	//权限代码
	String popeDomNameIn = request.getParameter("popeDomName");	//权限代码

	System.out.println("popeDomCodeIn="+popeDomCodeIn);
	
	if(popeDomNameIn==null)
	popeDomNameIn="全部权限";
	
	String op_name = "工号权限管理";
	String note = "您正在修改工号<b>("+loginNo1+")</b>的<b>"+popeDomNameIn+"</b>下的权限信息";

	//输出参数
	String	checkFlag    [][]= new String[][]{};	//配置标志（0不选中 1选中 2不允许选择）
	String	rolePdom     [][]= new String[][]{};    //权限代码
	String	rolePdomName [][]= new String[][]{};    //权限名称
	String	rolePdomType [][]= new String[][]{};    //关系类型
	String	beginTime    [][]= new String[][]{};    //开始时间
	String	endTime      [][]= new String[][]{};    //结束时间
	String	authWorkNo   [][]= new String[][]{};    //授权工号
	String	authTime     [][]= new String[][]{};    //授权时间
	String	groupId      [][]= new String[][]{};    //授权机构
	String	operCode     [][]= new String[][]{};    //操作代码

	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	//ArrayList acceptList = new ArrayList();
		
	String paramsIn[] = new String[10];
	
	paramsIn[0] = loginNo;
	paramsIn[1] = loginNo1;
	paramsIn[2] = "8002";
	paramsIn[3] = "1";      //修改查询
	paramsIn[4] = "0";      //报表权限代码
	paramsIn[5] = ""; 
	paramsIn[6] = ""; 
	paramsIn[7] = ""; 
	paramsIn[8] = ""; 
	paramsIn[9] = popeDomCodeIn; 
	
	//acceptList = callView.callFXService("sSetLoginRole", paramsIn,"9","region",regionCode);
%>
	<wtc:service name="sSetLoginRole" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="10" >
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>			
		<wtc:param value="<%=paramsIn[5]%>"/>
		<wtc:param value="<%=paramsIn[6]%>"/>
		<wtc:param value="<%=paramsIn[7]%>"/>
		<wtc:param value="<%=paramsIn[8]%>"/>
		<wtc:param value="<%=paramsIn[9]%>"/>	
	</wtc:service>	
	<wtc:array id="checkFlag1" start="0" length="1" scope="end"/>
	<wtc:array id="rolePdom1" start="1" length="1" scope="end"/>
	<wtc:array id="rolePdomName1" start="2" length="1" scope="end"/>
	<wtc:array id="rolePdomType1" start="3" length="1" scope="end"/>
	<wtc:array id="beginTime1" start="4" length="1" scope="end"/>
	<wtc:array id="endTime1" start="5" length="1" scope="end"/>
	<wtc:array id="authWorkNo1" start="6" length="1" scope="end"/>
	<wtc:array id="authTime1" start="7" length="1" scope="end"/>
	<wtc:array id="groupId1" start="8" length="1" scope="end"/>
	<wtc:array id="operCode1" start="9" length="1" scope="end"/>
<%	
	String errCode = retCode1;
	String errMsg =retMsg1;
	if(!errCode.equals("000000"))
	{
	%>
		  <script language='jscript'>
		     rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
		     parent.window.close();
		     //document.location="blank.html";
		  </script> 
	  
	<%
	}
	if(errCode.equals("000000"))
	{
		checkFlag  	 = checkFlag1;
		rolePdom	 = rolePdom1;
		rolePdomName = rolePdomName1;
		rolePdomType = rolePdomType1;
		beginTime    = beginTime1;
		endTime    	 = endTime1;
		authWorkNo   = authWorkNo1;
		authTime     = authTime1;
		groupId      = groupId1;
		operCode    = operCode1;
		
		for(int j = 0; j < rolePdomType.length; j++)
		{
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+rolePdomType[j][0]);
			/* 开始结束时间为 yyyyMMddHHmmss 时，转换时间格式 */
			try {
			SimpleDateFormat v_dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
		  beginTime[j][0] = dateFormat2.format(v_dateFormat.parse(beginTime[j][0]));
		  endTime[j][0] = dateFormat2.format(v_dateFormat.parse(endTime[j][0]));
		  System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>"+beginTime[j][0]+"---"+beginTime[j][0]);
		  }catch(ParseException e){
		  	e.printStackTrace();
		  }
		}
	}
%>
<head>
<title><%=op_name%></title>
<script language=javascript>

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
		document.all.new_check.value="Y";	
	}
	for(i=0;i<document.all.check.length;i++)
	{
		document.all.check[i].checked=true;	
		document.all.new_check[i].value="Y";
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
		document.all.new_check.value="N";
	}	
	
	for(i=0;i<document.all.check.length;i++)
	{
		document.all.check[i].checked=false;
		document.all.new_check[i].value="N";
	}
}	

function doSubmit()
{
	rdShowMessageDialog("只能收回同授权机构或下属机构分配的权限代码！");
	
	if(form1.beginTime.length!=undefined )
	{
		for(var i =0;i<form1.beginTime.length;i++)
		{
			if(!forDate(document.form1.beginTime[i]) || !forDate(document.form1.endTime[i])){
			return false;
			}
		}
	}
	
	if(document.all.check==undefined)
	{
		rdShowMessageDialog("此目录下没有权限,无法提交！");
		return;
	}
	form1.action="f8058_powerCfm.jsp?loginNo1="+"<%=loginNo1%>"+"&roleCode="+"<%=roleCode%>"+"&parPopeDomCode="+"<%=popeDomCodeIn%>"+"&roleName="+"<%=roleName%>";
	form1.submit();
}

</script>
</head>
<body>
<FORM METHOD=POST ACTION="" name="form1">
<%@ include file="/npage/include/header.jsp" %>   
	<div class="title">
		<div id="title_zi"><%=note%></div>
	</div>

				<table  cellspacing="0" >	
					<tr>
						<th nowrap>选择</th>						
						<th  nowrap >操作代码</th>
						<th  nowrap >权限名称</th>
						<th  nowrap >关系类型</th>
						<th  nowrap >开始时间</th>
						<th  nowrap >结束时间</th>
						<th  nowrap >授权工号</th>
						<th  nowrap >授权时间</th>
						<th  nowrap >授权机构</th>
						<th  nowrap >权限代码</th>
					</tr>
			<%
			String tbclass = "";
			for(int i = 0; i < checkFlag.length; i++)
			{
			tbclass = (i%2==0)?"Grey":"";
			%>
			<tr>
						<td class="<%=tbclass%>" nowrap>
					<%
						if(checkFlag[i][0].trim().equals("2"))
						{
						%>
							<input type="checkbox" name="check" value="<%=i%>" checked disabled >
							<input type="hidden" name="check" value="<%=i%>" checked >
						<%
						}
						else
						{
						%>
							<input type="checkbox" name="check" value="<%=i%>" onclick="chg_check(<%=i%>)"
								<%if(checkFlag[i][0].trim().equals("Y")){out.println("checked");}%>>
						<%}%>
						</td>
						<td class="<%=tbclass%>" nowrap ><%=operCode[i][0]%> 
						</td>
						<td class="<%=tbclass%>" nowrap ><%=rolePdomName[i][0]%>
						</td>
						<td class="<%=tbclass%>" nowrap >
							<select name="rolePdomType" >
							<%
														
							if(rolePdomType[i][0].trim().equals("0"))
							{
								%>
								<option value="0" selected >叠加</option>
								<% //vf1="selected";
							}
							else if(rolePdomType[i][0].trim().equals("1"))
							{
								%>
								<option value="1" selected >互斥</option>
								<% //vf2="selected";
							}
							%>								
							</select>
						</td>
						<td class="<%=tbclass%>" nowrap >
							<input type="text"  v_type="date" v_format="yyyyMMdd HH:mm:ss" v_must="1" maxlength="17" size="17" name="beginTime" value="<%=beginTime[i][0]%>">
						</td>
						<td class="<%=tbclass%>" nowrap >
							<input type="text"  v_type="date" v_must="1" maxlength="17" size="17" name="endTime" v_format="yyyyMMdd HH:mm:ss"	 value="<%=endTime[i][0]%>">
							<input type=hidden name="old_check"   value="<%=checkFlag[i][0]%>" >
							<input type=hidden name="new_check"   value="<%=checkFlag[i][0]%>" >
							<input type=hidden name="rolePdom"    value="<%=rolePdom[i][0]%>" >
							<input type=hidden name="oldPdomType" value="<%=rolePdomType[i][0]%>">
						</td>
						<td class="<%=tbclass%>" nowrap ><%=authWorkNo[i][0]%></td>
						<td class="<%=tbclass%>" nowrap ><%=authTime[i][0]%></td>
						<td class="<%=tbclass%>" nowrap ><%=groupId[i][0]%></td>	
						<td class="<%=tbclass%>" nowrap ><%=rolePdom[i][0]%></td>	
					</tr>
	<%  	
			}
	%>  	
	</talbe>
	<table   cellspacing="0" >
		<TR>
			<TD id="footer">
				<input class="b_foot_long"  name=allSelectt type=button    value="全部选中" onclick="allSelect()" >&nbsp;
				<input  class="b_foot_long" name=noSelectt  type=button    value="全部取消" onclick="noSelect()" >&nbsp;
				<input  class="b_foot" name="doButton" type="button"  value="提  交"   onclick="doSubmit()">&nbsp;
				<input  class="b_foot" name="doButton" type="button"  value="关  闭"   onclick="parent.window.close()">&nbsp;
			</TD>	
		</TR>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>  
</form>
</html>