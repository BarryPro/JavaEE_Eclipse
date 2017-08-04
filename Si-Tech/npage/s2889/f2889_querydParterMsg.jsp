<%
   /*
   * 功能: 集团客户项目申请 - 查询dpartermsg
　 * 版本: v1.0
　 * 日期: 2007/2/7
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>

<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.10
 模块：合作伙伴业务申请
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=Gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>

<%
	String op_name = "合作伙伴信息列表";
	String opName = "合作伙伴业务申请";
	
	//-----------------------------------------------
	String regCode = (String)session.getAttribute("regCode");
	String queryType = request.getParameter("queryType");
	String queryInfo = request.getParameter("queryInfo");	
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);	
	%>
	 
	<wtc:service name="sCustQryMsg" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6" >
            	<wtc:param value=""/>
            	<wtc:param value=""/>
              <wtc:param value="2889"/>
              <wtc:param value="<%=workNo%>"/>
              <wtc:param value="<%=workPwd%>"/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value="<%=queryType%>"/>
              <wtc:param value="<%=queryInfo%>"/>
   </wtc:service>
   <wtc:array id="colNameArrTemp" scope="end" />
	<%
	String[][] colNameArr = colNameArrTemp;
	    
    System.out.println("colNameArr.length="+colNameArr.length);
    
    for(int i=0;i < colNameArr.length;i++){ 
			System.out.println("colNameArr[i][0]="+colNameArr[i][0]);
			System.out.println("colNameArr[i][1]="+colNameArr[i][1]);
			System.out.println("colNameArr[i][2]="+colNameArr[i][2]);
			System.out.println("colNameArr[i][3]="+colNameArr[i][3]);
	}
	    
	    
  if(colNameArr.length==0)
 	{
%>
			<script language='jscript'>
				rdShowMessageDialog("没有查到相关记录！",0);
				window.close();
			</script>
<%  
	}else
    {
%>        
		              

<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
	window.onkeydown(window.event) 
</SCRIPT>

</head>
<body>
<form name="frm" method="POST" >
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">查询结果</div>
	</div>	
	
	<table id="tab2" cellpadding="0">
				<tr>
					<td><strong><font color='blue'>正在加载数据......</font></strong></td>
				</tr>
	</table>
	
	<TABLE id="tab1" cellspacing="0">
	<tr>
		<th nowrap>选择</th>
		<th nowrap>集团客户或合作伙伴编码</th>
		<th nowrap>集团客户或合作伙伴名称</th>
		<th nowrap>联系电话</th>
	</tr>
	</TABLE>
    
	<table cellspacing="0">
		<tr>
			<td  id="footer">
				<div align="center">
			      <input type="button" class="b_foot" name="commit" style="cursor:hand" onClick="doCommit();" value=" 确定 ">
			      <input type="button" class="b_foot" name="back" style="cursor:hand" onClick="doClose();" value=" 关闭 ">
		    	</div>
			</td>
		</tr>
	</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

<script>
	  
	<%for(int i=0;i < colNameArr.length;i++){ %>
		var str='<input type="hidden" name="parterId" value="<%=colNameArr[i][0]%>">';
		str+='<input type="hidden" name="parterName" value="<%=colNameArr[i][1]%>">';
		str+='<input type="hidden" name="spTel" value="<%=colNameArr[i][2]%>">';
		str+='<input type="hidden" name="oTypeCode" value="<%=colNameArr[i][3]%>">';
					
		var rows = document.getElementById("tab1").rows.length;
		var newrow = document.getElementById("tab1").insertRow(rows);
		newrow.align="center";
		newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
	  	newrow.insertCell(1).innerHTML = '<%=colNameArr[i][0]%>';
	  	newrow.insertCell(2).innerHTML = '<%=colNameArr[i][1]%>';
	  	newrow.insertCell(3).innerHTML = '<%=colNameArr[i][2]%>';
	<%}%>
	
	var hintTab = document.getElementById("tab2"); 
	hintTab.style.display="none";  

	function doCommit()
	{			
		if("<%=colNameArr.length%>"=="0")
		{
			rdShowMessageDialog("没有可选择的记录！");
			return false;
		}
		else if("<%=colNameArr.length%>"=="1")
		{//值为一条时不需要用数组
			
			if(document.all.num.checked)
			{	
					
				window.opener.form1.parterId.value = document.all.parterId.value;									
				window.opener.form1.parterName.value = document.all.parterName.value;						
				window.opener.form1.spTel.value = document.all.spTel.value;
				window.opener.form1.oTypeCode.value =document.all.oTypeCode.value;			
       	window.opener.tabEC.style.display="";
       	       	
       	window.opener.tabBusi.style.display="none";
				
				var newTable = window.opener.document.getElementById("tabEC");
				if (newTable.rows.length >= 3)
				{
					newTable.deleteRow(newTable.rows.length-1);
				}
       		
       			var newRow = window.opener.tabEC.insertRow();
				newRow.insertCell().innerHTML = '<center>' + document.all.parterId.value + '</center>';				
				newRow.insertCell().innerHTML = '<center>' + document.all.parterName.value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.spTel.value + '&nbsp;</center>';				
				newRow.insertCell().innerHTML = '<center><a href="f2889_2.jsp?parterId=' + document.all.parterId.value + '&oTypeCode=' + document.all.oTypeCode.value + '" target="_blank" >查询</a></center>';
				newRow.insertCell().innerHTML = '<center><input name="queryBusiBtn" style="cursor:hand" type="button" class="b_text" value="查询业务信息" onclick="queryBusiInfo()"></center>';
		
				window.close();
			}
			else
			{
				rdShowMessageDialog("请选择记录！");
				return false;
			}
		}
		else
		{//值为多条时需要用数组
			var a=-1;
			for(i=0;i<document.all.num.length;i++)
			{
				if(document.all.num[i].checked)
				{
					a=i;
					break;
				}
			}
			
			if(a!=-1)
			{	
							
				window.opener.form1.parterId.value=document.all.parterId[a].value;
				window.opener.form1.parterName.value=document.all.parterName[a].value;
				window.opener.form1.spTel.value=document.all.spTel[a].value;
				window.opener.form1.oTypeCode.value =document.all.oTypeCode[a].value;
	
       			window.opener.tabEC.style.display="";
       			window.opener.tabBusi.style.display="none";
       			
       			var newTable = window.opener.document.getElementById("tabEC");
       			if (newTable.rows.length >= 3)
				{
					newTable.deleteRow(newTable.rows.length-1);
				}
       			
       			var newRow = window.opener.tabEC.insertRow();
				newRow.insertCell().innerHTML = '<center>' + document.all.parterId[a].value + '</center>';	
				newRow.insertCell().innerHTML = '<center>' + document.all.parterName[a].value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.spTel[a].value + '&nbsp;</center>';
				newRow.insertCell().innerHTML = '<center><a href="f2889_2.jsp?parterId=' + document.all.parterId[a].value + '&parterName=' + document.all.parterName[a].value + '&oTypeCode=' + document.all.oTypeCode[a].value + '" target="_blank">查询</a></center>';
				newRow.insertCell().innerHTML = '<center><input name="queryBusiBtn" style="cursor:hand" type="button" class="b_text" value="查询业务信息" onclick="queryBusiInfo()">&nbsp;</center>' ;
						
				window.close();
			}
			else
			{
				rdShowMessageDialog("请选择记录！");
				return false;
			}
		}
	}
	
	function onkeydown(event) 
	{
		if (event.srcElement.type!="button")
		{
			if (event.keyCode == 13)
			{
				doCommit();
			}
		}
	}
	function doClose()
	{
		window.close();
	}
</script>
<%            
    }
%>


