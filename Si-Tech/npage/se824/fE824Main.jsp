<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
String regCode	=(String)session.getAttribute("regCode");
String opCode="e824";
String opName="省内携号用户信息查询";

String zPhoneNo = (String)request.getParameter("activePhone");
%>


<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title>省内携号用户信息查询</title>
		<script>

		function getTabList()
		{
			if (document.all.phoneNo.value.trim()=="")
			{
				rdShowMessageDialog("必须输入手机号码!",0);
				return false;
			}
			
			/*指定Ajax调用页*/
			var packet = new AJAXPacket("fE824MainAjax.jsp"
				,"请稍后...");
				
			/*给ajax页面传递参数*/
			packet.data.add("phoneNo",document.all.phoneNo.value.trim() );
			
			/*调用页面,并指定回调方法*/
			core.ajax.sendPacket(packet,setTabList,true);
			packet=null;
		}
		
		/*构造查询列表*/
		function setTabList(packet)
		{
			/*查询列表清空*/
			$("#tabList").empty();
			var	errCode	=packet.data.findValueByName("errCode"); 
			var	errMsg	=packet.data.findValueByName("errMsg"); 

			if (errCode=="000000")
			{
				/*获得查询结果数组*/
				var	arrTabList	=packet.data.findValueByName("arrTabList"); 
				
				/*查询结果不为空则展示*/
				if ( arrTabList.length!=0)
				{
					/*拼查询列表表头*/
					$("#tabList").append("<tr>"
						+"<th align='center'>办理时间</th>"
						+"<th align='center'>办理工号</th>"
						+"<th align='center'>生效时间</th>"
						+"<th align='center'>携入地</th>"
						+"<th align='center'>携出地</th>"
						+"</tr>"
					);				
					
					/*遍历查询结果二维数组每一行*/
					for (var i=0;i<arrTabList.length ;i++ )
					{
						/*jquery按行拼动态table*/
						$("#tabList").append("<tr>"
						+"<td><input type='text' id='oprTime"+i+"' name='oprTime"+i+"' "
							+"value='"+arrTabList[i][1]+"' class='InputGrey'></td>"
						+"<td><input type='text' id='oprWorkNo"+i+"' name='oprWorkNo"+i+"' "
							+"value='"+arrTabList[i][2]+"' class='InputGrey'></td>"					
						+"<td><input type='text' id='effTime"+i+"' name='oprEffTime"+i+"' "
							+"value='"+arrTabList[i][3]+"' class='InputGrey'></td>"					
						+"<td><input type='text' id='inGrp"+i+"' name='oprInGrp"+i+"' "
							+"value='"+arrTabList[i][4]+"' class='InputGrey'></td>"
						+"<td><input type='text' id='outGrp"+i+"' name='outGrp"+i+"' "
							+"value='"+arrTabList[i][5]+"' class='InputGrey'></td>"						
						+"</tr>"
						);
					}
				}
				else
				{
					$("#tabList").append("<tr>"
						+"<td colspan='5' align='center'>"
						+"无省内携号信息!"
						+"</tr>");		
				}
				/*展示查询结果div*/
				$("#divList").show();
			}
			else
			{
				rdShowMessageDialog(errCode+":"+errMsg);	
				document.getElementById("divList").style.display="none";

				return false;
			}

			
		}
		
		function clearFrm()
		{
			document.all.phoneNo.value="";
			$("#tabList").empty();
		}
		</script>
	</head>
	<body>
	<form name='frm' action='' method='POST'>
		<div	id="Operation_Title">
			<div	class="icon"></div>
				<B><%=opCode%>·<%=opName%></B>
		</div>
		<!--查询条件-->
		<DIV	id="Operation_Table">
			<div class="title">
				<div id="title_zi"><%=opName%></div>
			</div>
			
			<table id="libs">
				<tr>
					<th align="center">手机号码</th>
					<td><input	TYPE="TEXT" id='phoneNo' name='phoneNo' value="<%=zPhoneNo%>">
						<font color="orange">*<font>
						</td>
				</tr>	
			</table>
			<!--操作按钮-->
			<table>
				<tr>
					<td  id="footer">

						<input class="b_foot" type="button" name=qryPage value="查询"
							onClick="getTabList()">
						<input class="b_foot" type="button" name=qryPage value="清除"
							onClick="clearFrm()">							
						<input class="b_foot" type="button" name=qryPage value="关闭"
							onClick="removeCurrentTab();">						
					</td>
				</tr>
			</table>		
			
			<!--查询结果列表-->	
			<div id="divList" style="display:none">
				<div	class="title">
					<div	id="title_zi">查询结果列表</div>
				</div>
				<!--产品库列表-->
				<table id="tabList"></table>
			</div>
		</div>
	</form>
	</body>
<html>
