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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String flag="0";
	
	String opName = "合作伙伴信息列表";
	
	//-----------------------------------------------
	
	String queryType = request.getParameter("queryType");
	String queryInfo = request.getParameter("queryInfo");	
	
	String sqlStr = "";		
	
	if(queryType.equals("0"))//合作伙伴编码
	{
		sqlStr = "select parter_id,checkdoc_id,parter_name,customerservice_phone from dpartermsg where status='07' and parter_id ='"+queryInfo+"'";
	}else if(queryType.equals("1"))//合作伙伴名称
	{
		sqlStr = "select parter_id,checkdoc_id,parter_name,customerservice_phone from dpartermsg where status='07' and parter_name like '%"+queryInfo+"%'";
	}else if(queryType.equals("2"))//基本接入号
	{
		sqlStr = "select parter_id,checkdoc_id,parter_name,customerservice_phone from dpartermsg where status='07' and checkdoc_id ='"+queryInfo+"'";
	}
						
%>
    <wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="4" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:sql><%=sqlStr%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr" scope="end"/>
<%
	String[][] colNameArr = retArr;
	    
	    System.out.println("colNameArr.length="+colNameArr.length);
	    
	    for(int i=0;i < colNameArr.length;i++){ 
				System.out.println("colNameArr[i][0]="+colNameArr[i][0]);
				System.out.println("colNameArr[i][1]="+colNameArr[i][1]);
				System.out.println("colNameArr[i][2]="+colNameArr[i][2]);
				System.out.println("colNameArr[i][3]="+colNameArr[i][3]);
	}
	    
		if (colNameArr != null)
		{
			if (colNameArr[0][0].equals("")) 
			{
				colNameArr = null;
				System.out.println("colNameArr = null");
			}
		}	    
	    
  if(colNameArr==null)
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
		       



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
</head>
<body>
<form name="frm" method="POST" >
<%@ include file="/npage/include/header_pop.jsp" %>
<table cellspacing="0" id="tab1">	
	<tr bgColor="#eeeeee">
		<th height="26" align="center" nowrap>
			选择
		</th>
		<th  align="center" nowrap>
			合作伙伴代码
		</th>
		<th  align="center" nowrap>
			基本接入号
		</th>
		<th align="center" nowrap>
			合作伙伴名称
		</th>
		<th align="center" nowrap>
			客服电话
		</th>
	</tr>
</table>
<table cellspacing="0">
	<tr>
		<td id='footer'>
	      <input type="button" class='b_foot' name="commit" style="cursor:hand" onClick="doCommit();" value=" 确定 ">
	      <input type="button" class='b_foot' name="back" style="cursor:hand" onClick="doClose();" value=" 关闭 ">
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
		str+='<input type="hidden" name="checkdocId" value="<%=colNameArr[i][1]%>">';
		str+='<input type="hidden" name="parterName" value="<%=colNameArr[i][2]%>">';
		str+='<input type="hidden" name="spTel" value="<%=colNameArr[i][3]%>">';
					
		var rows = document.getElementById("tab1").rows.length;
		var newrow = document.getElementById("tab1").insertRow(rows);
		newrow.bgColor="#f5f5f5";
		newrow.height="20";
		newrow.align="center";
		newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
	  	newrow.insertCell(1).innerHTML = '<%=colNameArr[i][0]%>';
	  	newrow.insertCell(2).innerHTML = '<%=colNameArr[i][1]%>';
	  	newrow.insertCell(3).innerHTML = '<%=colNameArr[i][2]%>';
	  	newrow.insertCell(4).innerHTML = '<%=colNameArr[i][3]%>';
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
			  window.opener.form1.checkdocId.value = document.all.checkdocId.value;
				window.opener.form1.parterName.value = document.all.parterName.value;
			  window.opener.form1.spTel.value = document.all.spTel.value;
       			
       	window.opener.tabEC.style.display="";
       	window.opener.tabECsp.style.display="";
       			
       	var newTable = window.opener.document.getElementById("tabEC");
       	if (newTable.rows.length >= 2)
				{
					newTable.deleteRow(newTable.rows.length-1);
				}
       			
       			var newRow = window.opener.tabEC.insertRow();
				newRow.bgColor = "#F5F5F5";
				newRow.insertCell().innerHTML = '<center>' + document.all.parterId.value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.checkdocId.value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.parterName.value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.spTel.value + '</center>';
				newRow.insertCell().innerHTML = '<center><input name="queryBusiBtn" style="cursor:hand" type="button" value="查询业务信息" class="b_text" onclick="queryBusiInfo()">&nbsp;</center>';
		
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
				window.opener.form1.checkdocId.value=document.all.checkdocId[a].value;
				window.opener.form1.parterName.value=document.all.parterName[a].value;
				window.opener.form1.spTel.value=document.all.spTel[a].value;
       			
       			window.opener.tabEC.style.display="";
       			window.opener.tabECsp.style.display="";
       			
       			var newTable = window.opener.document.getElementById("tabEC");
       			
       			if (newTable.rows.length >= 2)
				{
					newTable.deleteRow(newTable.rows.length-1);
				}
       			
       			var newRow = window.opener.tabEC.insertRow();
				newRow.bgColor = "#F5F5F5";
				newRow.insertCell().innerHTML = '<center>' + document.all.parterId[a].value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.checkdocId[a].value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.parterName[a].value + '</center>';
				newRow.insertCell().innerHTML = '<center>' + document.all.spTel[a].value + '</center>';
				newRow.insertCell().innerHTML = '<center><input name="queryBusiBtn" style="cursor:hand" type="button" value="查询业务信息" class="b_text" onclick="queryBusiInfo()">&nbsp;</center>' ;
						
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