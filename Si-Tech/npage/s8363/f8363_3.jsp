<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
/*
* 功能:营业厅与mac地址绑定配置查询结果界面
* 版本: 1.0
* 日期: 2009/12/18
* 作者: gaolw
* 版权: si-tech
*/
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="java.io.*"%>


<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
		String opCode = "8363";
		String opName = "营业厅与mac地址绑定配置";

		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		
		String iLoginAccept = "";
	  iLoginAccept = getMaxAccept();

		/**************** 分页设置 ********************/
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		int iPageSize = 10;
		int iStartPos = (iPageNumber-1)*iPageSize;
		int iEndPos = iPageNumber*iPageSize;
		/**********************************************/	
			
		SPubCallSvrImpl impl = new SPubCallSvrImpl();
		ArrayList retList = new ArrayList(); 
		ArrayList retList1 = new ArrayList();  
		
		String[][] allNumStr = new String[][]{};
		String[][] result1 = new String[][]{};
		
		String groupId1 = request.getParameter("groupId");
    System.out.println("groupId1================"+groupId1);
	  //查询总记录数
		String sqlStr = "SELECT COUNT(*) FROM DCHNGROUPMSG A, DTOWNMACBIND B"
		                + " WHERE A.GROUP_ID = B.GROUP_ID AND B.GROUP_ID = '"+groupId1+"' ORDER BY MAC_ADDR";
		             
	  //查询内容 
    String sqlStr1 = "SELECT B.GROUP_ID, A.GROUP_NAME, B.MAC_ADDR FROM DCHNGROUPMSG A, DTOWNMACBIND B" 
                    + " WHERE A.GROUP_ID = B.GROUP_ID AND B.GROUP_ID = '"+groupId1+"' ORDER BY MAC_ADDR";      
		try 
		{
	    retList = impl.sPubSelect("1",sqlStr, "region", regionCode);
			retList1 = impl.sPubSelect("3",sqlStr1, "region", regionCode);		  	  
		}
		catch(Exception e)
		{
			System.out.println("\n==================\n error1");
		}			
		try{
			allNumStr = (String[][])retList.get(0);
			System.out.println("allNumStr = " + allNumStr[0][0]);
		}	
			catch(Exception e)
		{
			System.out.println("\n==================\nerror2");
		}	
		try{
		   result1   = (String[][])retList1.get(0);
		}		
				catch(Exception e)
		{
			System.out.println("\n==================\nerror3");
		}			
%>
<html>
<head>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>
<script language="JavaScript">
function delInfoDetail(i)
{ 
	var tempMacAddr         = "macAddr"+i;
	var temMacAddr          = document.form1(tempMacAddr).value;
	var tempGroupId         = "groupId"+i;
	var temGroupId          = document.form1(tempGroupId).value;
  //alert("temGroupId======"+temGroupId);
  if(rdShowConfirmDialog('确认要删除该条信息吗？')==1)
	{
		document.form1.action="f8363_3del.jsp?"+"macAddr="+temMacAddr+"&groupId="+temGroupId;
 	  form1.submit();
	}
}
function modInfoDetail(i)
{ 
	var tempMacAddr         = "macAddr"+i;
	var temMacAddr          = document.form1(tempMacAddr).value;
	var tempGroupId         = "groupId"+i;
	var temGroupId          = document.form1(tempGroupId).value;
	var tempGroupName       = "groupName"+i;
	var temGroupName        = document.form1(tempGroupName).value;
  //alert("temGroupId======"+temGroupId);
  document.form1.action="f8363_3mod.jsp?"+"macAddr="+temMacAddr+"&groupId="+temGroupId+"&groupName="+temGroupName;
 	form1.submit();
}
</script>
<body>
<form name="form1" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>	
	<div class="title">
		<div id="title_zi">营业厅与mac地址绑定配置查询结果界面</div>
	</div>
  <table id="tabList" cellspacing="0" >
		<tr>
			<th nowrap>营业厅代码</th>
			<th nowrap>营业厅名称</th>
			<th nowrap>mac地址</th>
			<th nowrap>操作</th> 
	  </tr> 
		<%
			if(result1.length == 0)
			{
				out.println("<tr height='25' align='center'><td colspan='4'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
			}else if(result1.length>0){
			for(int i = iStartPos; i < Math.min(iEndPos,result1.length); i++)
			{
	%>			
			<tr>
				<td class="blue" align="left" nowrap><%=result1[i][0].trim()%>&nbsp;</td>
				<td class="blue" align="left" nowrap><%=result1[i][1].trim()%>&nbsp;</td>
				<td class="blue" align="left" nowrap><%=result1[i][2].trim()%>&nbsp;</td>
				<td class="blue" align="left" nowrap>
					<input name="del<%=i%>" class="b_text" type="button" value="删除" onClick="delInfoDetail(<%=i%>)" >&nbsp;
					<input name="mod<%=i%>" class="b_text" type="button" value="修改" onClick="modInfoDetail(<%=i%>)" >
					<input type=hidden name="opCode" value="<%=opCode%>"></input>
				  <input type=hidden name=groupId<%=i%> value="<%=result1[i][0]%>"></input>
				  <input type=hidden name=groupName<%=i%> value="<%=result1[i][1]%>"></input>
				  <input type=hidden name=macAddr<%=i%> value="<%=result1[i][2]%>"></input>
				</td>
				
				
		 </tr>
	<%
				}
			}
	%>		
	    <tr>
	    	<td colspan="10" align="center">
					<div id="page0" style="position:relative;font-size:12px;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           			<%	
					    //实现分页
					    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
					    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						  PageView view = new PageView(request,out,pg); 
					   	view.setVisible(true,true,0,0);      
					%>
					</div>
				</td>
	    </tr>
	    
			<tr> 
				<td align="center" id="footer" colspan="10"> 
					<input type="button" name="return" class="b_foot" value="返回" onclick="location='f8363_1.jsp'">
				</td>
	    </tr>
	</table>

<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>  