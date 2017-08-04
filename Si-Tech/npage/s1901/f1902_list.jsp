<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 集团合同协议录入 - 列表(全部数据)
　 * 版本: v1.0
　 * 日期: 2006/10/31
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.GregorianCalendar"%>

<%	
	String opCode = "1902";
	String opName = "集团合同协议录入";
	//读取用户session信息
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //工号
	String workName = baseInfo[0][3];               //工号姓名
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //登陆密码
	
	
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	//out.println(dateStr);
	
	String strDate = "";
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	GregorianCalendar cal = new GregorianCalendar();
	cal.setTime(new Date());
	
	strDate = sdf.format(cal.getTime());
	
	cal.add(GregorianCalendar.DATE, 10);
	strDate = sdf.format(cal.getTime());
	//out.println(strDate);
	
	String QryFlag = request.getParameter("QryFlag");
	String QryValues = request.getParameter("QryValues");
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList acceptList = new ArrayList();
	if(QryFlag.equals("1"))
	{
		QryFlag="0";	
	}
	
	String paraArr[] = new String[6];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "1902";
	paraArr[3] = "";
	paraArr[4] = QryFlag;
	paraArr[5] = QryValues;
	
	acceptList = impl.callFXService("s1902AgrQry",paraArr,"9");
	int errCode=impl.getErrCode();   
	String errMsg=impl.getErrMsg(); 
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
	var oldrow = -1;
	var nowrow = -1;

	//鼠标点击某行处理函数
	function rowClick(objname,flag){
		var o = eval(objname);
		if(flag == 1)
			o.className = "opened";
		else
			o.className = "unopen";
	}
	
	//鼠标移到某行
	function rowMouseOver(node){
		if(node.className != "opened")
			node.className = "mouseover";
	}
	
	//鼠标移出某行
	function rowMouseOut(node){
		if(node.className != "opened")
			node.className = "unopen";
	}
	
	//鼠标点击某行
	function trfunc1(node){
		nowrow = parseInt(node.id.substring(3,node.id.length));  
		if(oldrow != nowrow){
			if(oldrow != -1) 
				rowClick("row" + oldrow,0);
			rowClick("row" + nowrow,1);
			oldrow = nowrow;
		}
	}
	
	//显示修改页面
	function showModify(agree_id)
	{
		var url = "f1902_modify.jsp?agreeId=" + agree_id;
    	window.open(url,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}
	
	//显示续签页面
	function showContinue(agree_id)
	{
		var url = "f1902_continue.jsp?agreeId=" + agree_id;
    	window.open(url,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}
	
	//显示录入页面
	function showAdd(agree_id,product_id)
	{
		//alert(product_id);
		var url = "f1902_add.jsp?idNo=" + agree_id+"&product_id="+product_id;
    	window.open(url,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}	
	
	//显示删除页面
	function showDelete(agree_id)
	{
		if (rdShowConfirmDialog("确认删除操作？")==1)
		{
			window.location= "f1902_submit_delete.jsp?agreeId=" + agree_id;
    	}
    	//window.open(url,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}
</script>
</head>

<body>
	<%@ include file="/npage/include/header.jsp" %>   
		<table cellspacing="0">
			<tr>
				<th><div align="center">集团用户名称</div></th>
				<!--td class="listformtop"  height="26" width="7%"><div align="center">产品编号</div></td-->
				<th><div align="center">产品名称</div></th>
				<th><div align="center">协议号</div></th>
				<th><div align="center">协议名称</div></th>
				<th><div align="center">签约日期</div></th>
				<th><div align="center">到期日期</div></th>
				<th><div align="center">协议录入</div></th>
				<th><div align="center">协议续签</div></th>
				<th><div align="center">删除</div></th>				
			</tr>
<%
		if(errCode==0){
			String[][] tmpresult0=(String[][])acceptList.get(0);
			String[][] tmpresult1=(String[][])acceptList.get(1);
			String[][] tmpresult2=(String[][])acceptList.get(2);
			String[][] tmpresult3=(String[][])acceptList.get(3);
			String[][] tmpresult4=(String[][])acceptList.get(4);
			String[][] tmpresult5=(String[][])acceptList.get(5);
			String[][] tmpresult6=(String[][])acceptList.get(6);
			String[][] tmpresult7=(String[][])acceptList.get(7);
			String[][] tmpresult8=(String[][])acceptList.get(8);

		//out.println("MM"+Integer.parseInt(tmpresult5[0][0].trim().substring(0,8)));

		for(int i = 0; i < tmpresult0.length; i++)
		{	
			
			if((i+1)%2==1){
%>
				      <tr>
				<%
							}else{
				%>
							<tr>
				<%
							}
				%>

				<td><%=tmpresult0[i][0]%></td>
				<!--td align="center" class="listformtext"  height="20" ><%=tmpresult7[i][0]%></td-->
				<td><%=tmpresult1[i][0]%></td>
				<td><a href="javascript:showModify('<%=tmpresult2[i][0].trim()%>');"><%=tmpresult8[i][0]%></a></td>
				<td><%=tmpresult3[i][0]%></td>
				<td><%=tmpresult4[i][0].trim().equals("")==true?"":tmpresult4[i][0].trim().substring(0,8)%></td>
				<td><%=tmpresult5[i][0].trim().equals("")==true?"":tmpresult5[i][0].trim().substring(0,8)%></td>
				<td><a href="javascript:showAdd('<%=tmpresult6[i][0].trim()%>','<%=tmpresult7[i][0].trim()%>');"><%=tmpresult2[i][0].trim().equals("")==true?"录入":""%></a></td>
				<td><a href="javascript:showContinue('<%=tmpresult2[i][0].trim()%>');"><%=Integer.parseInt(tmpresult5[i][0].trim().equals("")==true?"20500101":tmpresult5[i][0].trim().substring(0,8))>Integer.parseInt(strDate)?"":"续签"%></a></td>			
				<td><a href="javascript:showDelete('<%=tmpresult2[i][0].trim()%>');">删除</a></td>
		</tr>

<%
		}
	}	
	else{
%>
		<script language="javascript" >
			rdShowMessageDialog("错误代码：<%=errCode%>,错误信息：<%=errMsg%>",0);
		</script>
<%
}
%>	


		</table>
	
	<%@ include file="/npage/include/footer.jsp" %>   
</body>
</html>

