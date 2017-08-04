<%
   /*名称：集团客户项目申请 - 查询dParterOperation
　 * 版本: v1.0
　 * 日期: 2007/2/7
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%

	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	String opName = "业务信息查询";
	 
	String regCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

	String parterId = request.getParameter("parterId");
	String queryType = request.getParameter("oTypeCode");
	String parterName = request.getParameter("parterName");
	String grpParamSet="";
	String grpParamSetName="";

	System.out.println("parterId = " + parterId);
	System.out.println("queryType = " + queryType);
	%>
	 
	<wtc:service name="s2889QryServMsg" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6" >
            	<wtc:param value=""/>
            	<wtc:param value=""/>
              <wtc:param value="2896"/>
              <wtc:param value="<%=workNo%>"/>
              <wtc:param value="<%=workPwd%>"/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value="<%=queryType%>"/>
              <wtc:param value="<%=parterId%>"/>
   </wtc:service>
   <wtc:array id="colNameArrTemp" scope="end" />
	<%
	String[][] colNameArr = colNameArrTemp;
	
	if (colNameArr.length==0)
	{
		colNameArr = null;
	}	 
		
%>

<html >
<head>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>

<script language="javascript">
	onload=function()
	{
			
	}
    function doProcess(packet)
	{
		var errCode    = packet.data.findValueByName("errCode");
		var retMessage = packet.data.findValueByName("errMsg");//声明返回的信息
		var retFlag    = packet.data.findValueByName("retFlag");

		if (errCode==0)
		{  
			if(retFlag=="queryMod")
			{			
				rdShowMessageDialog("操作成功！",2);
				window.parent.document.all.queryBusiBtn.onclick();
			}
		}else{
			rdShowMessageDialog(retMessage,0);	
		}
	}
	
		//变更
	function  queryMod(OprCode,v_id)
	{				
		
		var myPacket = new AJAXPacket("f2896_modCfm.jsp?OprCode="+OprCode+"&operId=" + document.form1["operId" +v_id].value +  "&parterId=" +document.form1["parterId" +v_id].value+ "&trId=" + v_id,"正在获得信息，请稍候......");
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	}
	
	//显示某条业务信息
	function showInfo(v_id)
	{  
        var str = "?operId=" + document.form1["operId" +v_id].value +  "&parterId=" +document.form1["parterId" +v_id].value+ "&trId=" + document.all.queryType.value+ "&parterName=" + document.all.parterName.value;
        var path="f2896_showInfo.jsp" + str;
		window.open(path,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}

</script>


<body>

<form name="form1" method="post" action="">	
	<input type="hidden" name="queryType" value="<%=queryType.trim()%>">
	<input type="hidden" name="parterName" value="<%=parterName.trim()%>">
<div id="Operation_Table">
<%
if(colNameArr!=null)
{	
%>
<div class="title">
	<div id="title_zi">业务信息</div>
</div>
		

		<TABLE  id="tabList" cellSpacing=0 >			
			<tr>				
				<th align='center'><div style='color:green;'>业务编码</div></th>
				<th align='center'><div style='color:green;'>EC/SI编码</div></th>
				<th align='center'><div style='color:green;'>业务名称</div></th>
				<th align='center'><div style='color:green;'>业务状态</div></th>
				<th align='center'><div style='color:green;'>操作方式</div></th>
			</tr>
	<%	
		int len = colNameArr.length;	
		for(int i = 0; i < len; i++)
		{		  
		 
	%>			
			<tr id="tr<%=i+1%>">
				<input type="hidden" name="operId<%=i+1%>" value="<%=colNameArr[i][0].trim()%>">
				<input type="hidden" name="parterId<%=i+1%>" value="<%=colNameArr[i][1].trim()%>">
							
				<td align='center'><a style="CURSOR: hand; TEXT-DECORATION: none" href="javascript:showInfo(<%=i+1%>)"><%=colNameArr[i][0].trim()%></a></td>
				<td align='center'><%=colNameArr[i][1].trim()%></td>
				<td align='center'><%=colNameArr[i][2].trim()%></td>
				<td align='center'><%=colNameArr[i][3].trim()%></td>
				<td align='center'>
			<%
			String stopFlag="";  
			String resumeFlag="";
			if("03".equals(colNameArr[i][4].trim()))
			{
				stopFlag="disabled";
			}
			if("01".equals(colNameArr[i][4].trim()))
			{
				resumeFlag="disabled";
			}
			%>
					<input name="operator<%=i+1%>" <%=stopFlag%> style="cursor:hand" type="button" value="暂停" class="b_text" onclick="queryMod('03',<%=i+1%>)">&nbsp;&nbsp;	
					<input name="operator<%=i+1%>" <%=resumeFlag%> style="cursor:hand" type="button" value="恢复" class="b_text" onclick="queryMod('04',<%=i+1%>)">		
				</td> 
			</tr>
	<%
		}
	%>		
		</TABLE>
<%}%>		
</div>   
</form>
</body>
</html>

           