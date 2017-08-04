 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		
		String regionCode= (String)session.getAttribute("regCode");
		String opCode = "3052";		
		String opName = "业务代码与成员资费关系维护";	//header.jsp需要的参数 	

  
		String sqlStr1="";		
		String spCode = request.getParameter("spCode");	
		String bizType = request.getParameter("bizType");	
		String[] inParams = new String[2];

		 if(bizType.equals("0"))
		{
		inParams[0] = "select to_char(parter_id), parter_name, parter_leader, link_name, link_phone  from dParterMsg where status='07' and parter_id like :spCode||'%' order by parter_id";
	}else{
		inParams[0] = "select to_char(unit_id),unit_name,nvl(unit_leader,' '),nvl(contact_person,' '),nvl(contact_mobile_phone,' ') from dgrpcustmsg where unit_id=:spCode";
             
		}
		inParams[1] = "spCode="+spCode;
		System.out.println("sql = " + inParams[0]);
		System.out.println("sql = " + inParams[1]);
	%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="5"> 
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/> 
		</wtc:service> 
		<wtc:array id="retListString1" scope="end" />		
	<%
		
		String  errCode=retCode1;
		String errMsg=retMsg1;		
	  	String op_name = "SI/EC列表";

%>

<html>
<head>
<title><%=op_name%></title>
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
	window.onkeydown(window.event) 
</SCRIPT>
</head>
<body>
	<form name="frm" method="POST" >
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">查询结果</div>
		</div>	
		<table  id="tab1" cellspacing="0">
			<tr>
				<th>选择</th>
				<th>企业编码</th>
				<th>企业名称</th>
				<th>法人代表</th>
				<th>联系人</th>
				<th >联系电话</th>
			</tr>
		</table>
		<table cellspacing="0">
			<tr>
				<td id="footer">					
					      <input type="button" class="b_foot" name="commit" onClick="doCommit();" value=" 确定 ">
					      &nbsp;
					      <input type="button" class="b_foot" name="back" onClick="doClose();" value=" 关闭 ">
				</td>
			</tr>
		</table>
		 <%@ include file="/npage/include/footer.jsp" %>  	
</form>
</body>
</html>
<script>
	  
		<%for(int i=0;i < retListString1.length;i++){ %>
			var str='<input type="hidden" name="spCode" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="spName" value="<%=retListString1[i][1]%>">';
			str+='<input type="hidden" name="ownPerson" value="<%=retListString1[i][2]%>">';
			str+='<input type="hidden" name="linkPerson" value="<%=retListString1[i][3]%>">';
			str+='<input type="hidden" name="linkPhone" value="<%=retListString1[i][4]%>">';
		
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  	newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  	newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		  	newrow.insertCell(3).innerHTML = '<%=retListString1[i][2]%>';
		  	newrow.insertCell(4).innerHTML = '<%=retListString1[i][3]%>';
		  	newrow.insertCell(5).innerHTML = '<%=retListString1[i][4]%>';
		<%}%>

		function doCommit()
		{
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("请选择一条记录！");
				return false;
			}
			else if("<%=retListString1.length%>"=="1"){//值为一条时不需要用数组
				if(document.all.num.checked){
					window.opener.form1.spCode.value=document.all.spCode.value;
					window.opener.form1.spName.value=document.all.spName.value;
					//window.close();
				}
				else{
					rdShowMessageDialog("请选择一条记录！");
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
					window.opener.form1.spCode.value=document.all.spCode[a].value;
					window.opener.form1.spName.value=document.all.spName[a].value;
					//window.close();
				}
				else{
					rdShowMessageDialog("请选择一条记录！");
					return false;
				}
			}
			window.close();
		}
	
	function doClose(){		
		window.close();
	}
</script>                                                                                                                                                           
