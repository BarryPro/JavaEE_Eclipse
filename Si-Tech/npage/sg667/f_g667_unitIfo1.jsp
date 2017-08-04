<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>


<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
</head>
<body>
<%
String s_loginacc=request.getParameter("hd_loginacc");
String s_chnSrc=request.getParameter("hd_chnSrc");
String s_opCode=request.getParameter("hd_opCode");
String s_workNo=request.getParameter("hd_workNo");
String s_passwd=request.getParameter("hd_passwd");
String s_phone=request.getParameter("hd_phone");
String s_userPwd=request.getParameter("hd_userPwd");

String iOfferId=request.getParameter("iOfferId");
String iNetWorkId=request.getParameter("iNetWorkId");
String opType=request.getParameter("opType");
String index=request.getParameter("index");

String s_regCode=(String)session.getAttribute("regCode");
String s_ret="";
%>	
	
	
<form method="POST" action = "" name="frm">
<wtc:service name="sg599QrySerAttr" outnum="50" routerKey="region" routerValue="<%=s_regCode%>" 
	retcode="rc_qryCust" retmsg="rm_qryCust" >
	<wtc:param value="<%=s_loginacc%>"/>
	<wtc:param value="<%=s_chnSrc%>"/>
	<wtc:param value="<%=s_opCode%>"/>
	<wtc:param value="<%=s_workNo%>"/>
	<wtc:param value="<%=s_passwd%>"/>
	<wtc:param value="<%=s_phone%>"/>
	<wtc:param value="<%=s_userPwd%>"/>
		
	<wtc:param value="<%=iOfferId%>"/>
	<wtc:param value="<%=iNetWorkId%>"/>
</wtc:service>
<wtc:array id="rst_qryCust" start="7" length="8" scope="end" />
	
<%
System.out.println("chenleikaishi0---"+"s_loginacc:"+s_loginacc+"iOfferId"+iOfferId+"iNetWorkId"+iNetWorkId+"----phone:"+s_phone);
System.out.println("chenleikaishi1---rst_qryCust.length"+rst_qryCust.length);
for (int i=0;i<rst_qryCust.length;i++){
		System.out.println("chenlei---"+i+"-"+0+"------"+rst_qryCust[i][0]);
		System.out.println("chenlei---"+i+"-"+1+"------"+rst_qryCust[i][1]);
		System.out.println("chenlei---"+i+"-"+2+"------"+rst_qryCust[i][2]);
		System.out.println("chenlei---"+i+"-"+3+"------"+rst_qryCust[i][3]);
		System.out.println("chenlei---"+i+"-"+4+"------"+rst_qryCust[i][4]);
		System.out.println("chenlei---"+i+"-"+5+"------"+rst_qryCust[i][5]);
		System.out.println("chenlei---"+i+"-"+6+"------"+rst_qryCust[i][6]);
		System.out.println("chenlei---"+i+"-"+7+"------"+rst_qryCust[i][7]);
	System.out.println("chenleikaishi2------------------------------------------------------");
}
if ( !rc_qryCust.equals("000000") )
{
%>
<script>
	alert("<%=rc_qryCust%>:<%=rm_qryCust%>");
	window.close();
</script>
<%
}
%>
	
<DIV id="Operation_Table" style="display:none">
	<div class="title">
		<div id="title_zi">产品服务附加属性</div>
	</div>
	<table	id="productInfo" style="display:block">
		<tr>
			<th align="center" >服务代码</th>
			
			<th align="center" >附加属性代码</th>
			<th align="center" >附加属性名称</th>
			<th align="center" >附加属性默认值</th>
			<th align="center" >是否必须</th>
			
		</tr>						
		
			<%
			for ( int i=0;i<rst_qryCust.length;i++ )
			{
				String ifNeeds="否";
				if (rst_qryCust[i][4].equals("1"))
				{
					ifNeeds="是";
				}
			%>
					
				<tr>
			<td align="center"><input type="text" 
				name="t_prodAAServId_1" value="<%=rst_qryCust[i][0]%>" class="InputGrey" readOnly>
			</td>
			<td align="center"><input type="text" 
				name="t_prodAAId_1" value="<%=rst_qryCust[i][1]%>" class="InputGrey" readOnly>
			</td>
			<td align="center"><input type="text" 
				name="t_prodAAName_1" value="<%=rst_qryCust[i][2]%>" class="InputGrey" readOnly>
			</td>
			
			
			<td align="center">
				<%
				if("text".equals(rst_qryCust[i][5])){%>
					<input type="text" ch_name='附加属性默认值' name="t_prodAADef_1" value="<%=rst_qryCust[i][3]%>">
					<input type="hidden" ch_name='附加属性默认值' name="t_prodAADef_2" value="<%=rst_qryCust[i][7]%>">
				<%}else if("select".equals(rst_qryCust[i][5])){%>
					<select id="t_prodAADef_1" name="t_prodAADef_1">
						<%
							String selectStr=rst_qryCust[i][6];
							System.out.println("chenlei---------------"+selectStr);
							String[] selectVal = selectStr.split(",");
							for(int j=0;j<selectVal.length;j++){
								String[] selValue = selectVal[j].split(":");
								
								%>
								<option value="<%=selValue[0]%>" <%=(selValue[0]==rst_qryCust[i][7])?"selected='selected'":""%> ><%=selValue[1]%></option>
								
								<%
							}
						%>
						<input type="hidden" ch_name='附加属性默认值' name="t_prodAADef_2" value="<%=rst_qryCust[i][7]%>">
					</select>
				<%}%>
				
			</td>
			<td align="center"><input type="text" 
				name="t_prodAAIfNeeds_1" value="<%=ifNeeds%>" class="InputGrey"  readOnly>
			<input type="hidden" name="t_needsCode_1" value="<%=rst_qryCust[i][4]%>" class="InputGrey" readOnly>
	
			</td>	
			</tr>
			<%
			}
			%>
				
	</table>	
	<table>
		<tr> 
			<td  id="footer">
				<input class="b_foot" type="button" name="b_cls" value="确定"
					onClick="fn_next();">	
				<input class="b_foot" type="button" name="b_cls" value="关闭"
					onClick="window.close();">								
			</td>
		</tr>
	</table>		
</div>
<script>
function fn_selUnitIfo(str)
{
	window.returnValue =str;
	window.close();
}

$(document).ready(
	function ()
	{
		$("#Operation_Table").show("slow");
	}
);
function fn_next()
{
	var flag = 1;
	for(var i=0;i<document.getElementsByName("t_prodAAId_1").length;i++){
		var value = document.getElementsByName("t_prodAADef_2")[i].value;//原值
		var value1 = document.getElementsByName("t_prodAADef_1")[i].value;//改值
		//alert(value+":"+value1);
		if(value!=""&&value1!=""){
			if(value!=value1){
				flag = 2;
				break;
			}
			
		}else if(value==""){
			flag = 2;
			break;
		}
		
	}
	
	if(flag==2){
		//alert("校验非空:"+retStr_1);
		for(var k=0;k<document.getElementsByName("t_prodAAId_1").length;k++){
			if (document.getElementsByName("t_prodAADef_1")[k].value=="")
			{
				//alert("校验非空:"+document.getElementsByName("t_prodAADef_1")[i].value);
				rdShowMessageDialog("产品默认值不能为空",0);
				return false;
			}
		}
			
		var retStr="";	
		alert(document.getElementsByName("t_prodAAServId_1").length);
		/*产品服务附加属性*/
		var retStr_1="";
		if("0"==document.getElementsByName("t_prodAAServId_1").length)
		{
			retStr_1="";
		}
		else
		{
			var s_srvId_1="";
			for ( var i=0; i<document.getElementsByName("t_prodAAServId_1").length ; i++)
			{
				s_srvId_1 =s_srvId_1+document.getElementsByName("t_prodAAServId_1")[i].value+"@";
			}
		
				
			var s_addId_1="";
			for (var i=0; i<document.getElementsByName("t_prodAAId_1").length ; i++)
			{
				s_addId_1=s_addId_1+document.getElementsByName("t_prodAAId_1")[i].value+"@";
			}
			
			var s_addName_1="";
			for (var i=0; i<document.getElementsByName("t_prodAAName_1").length ; i++)
			{
				s_addName_1=s_addName_1+document.getElementsByName("t_prodAAName_1")[i].value+"@";
			}	
			
			var s_addDef_1="";
			for (var i=0; i<document.getElementsByName("t_prodAADef_1").length ; i++)
			{
				s_addDef_1=s_addDef_1+document.getElementsByName("t_prodAADef_1")[i].value+"@";
			}		
			
			var s_ifNeeds_1="";
			for (var i=0; i<document.getElementsByName("t_prodAAIfNeeds_1").length ; i++)
			{
				s_ifNeeds_1=s_ifNeeds_1+document.getElementsByName("t_prodAAIfNeeds_1")[i].value+"@";
			}
			retStr_1=s_srvId_1.substr(0,s_srvId_1.length-1)
			+"~"+s_addId_1.substr(0,s_addId_1.length-1)
			+"~"+s_addName_1.substr(0,s_addName_1.length-1)
			+"~"+s_addDef_1.substr(0,s_addDef_1.length-1)
			+"~"+s_ifNeeds_1.substr(0,s_ifNeeds_1.length-1);
		}
		alert("变更出参:"+retStr_1);	
		window.returnValue=retStr_1;
		window.close();
	}else{
		alert(value+"qian:hou"+value1);
		window.close();
	}
	
	
	
};
</script>
</form>
</body>
</html>
