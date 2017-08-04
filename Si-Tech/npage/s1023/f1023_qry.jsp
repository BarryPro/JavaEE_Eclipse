 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-13 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	String workNo= (String)session.getAttribute("workNo");	
	String groupId=  (String)session.getAttribute("groupId");	
	String implRegion= (String)session.getAttribute("regCode");	
	String unit_id =  request.getParameter("unit_id")==null?"":request.getParameter("unit_id");
	String owner_code =  request.getParameter("owner_code")==null?"":request.getParameter("owner_code");
	String trade_code =  request.getParameter("trade_code")==null?"":request.getParameter("trade_code");
	String unit_name =  request.getParameter("unit_name")==null?"":request.getParameter("unit_name");
	String opCode = "";		
	String opName = "集团客户列表";	//header.jsp需要的参数 	
	System.out.println("\n============1023======++++++++++++zhoujf+++++workNo++++++++++++++++++++++++++\n"+workNo);


	String sqlStr = "";
	String sqlStr1 = "";
	String sqlStmt = "";
	String whereSql = "";
	
	if(!(unit_id.equals("")))
	{
	    whereSql = whereSql + " and a.unit_id = '"+unit_id+"' ";
	}
	if(!(unit_name.equals("")))
	{
	    whereSql = whereSql + " and a.unit_name like '%"+unit_name+"%' ";
	}
	if(!(owner_code.equals("")))
	{
	    whereSql = whereSql + " and a.owner_code = '"+owner_code+"' ";
	}
	if(!(trade_code.equals("")))
	{
	    whereSql = whereSql + " and a.big_trade_code = '"+trade_code+"' ";
	}
	

		sqlStmt ="select a.unit_id,a.unit_name,a.contact_person,a.service_no,b.name,c.owner_name  from  dgrpcustmsg a left join dgrpmanagermsg b on a.service_no = b.service_no left join sgrpownercode c on a.owner_code = c.owner_code ,dbvipadm.dgrpgroups d where a.org_code = d.group_id  and d.ACTIVE_FLAG = 'Y' and d.PARENT_GROUP_ID = (select org_code from dbvipadm.dgrpmanagermsg where service_no='"+workNo+"')";

	


	sqlStmt = sqlStmt + whereSql; 
System.out.println("\n============1023======+++++++++++++++++sqlStmt++++++++++++++++++++++++++"+sqlStmt);

	/**************** 分页设置 ********************/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	/**********************************************/
		
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList = new ArrayList(); 
	ArrayList retList1= new ArrayList(); 

	
	//查询总记录数
	sqlStr  =  "SELECT count(*) from ("	+ sqlStmt + ")"; 
	System.out.println("sqlStr:\n"+sqlStr);	        
	//查询内容        
	sqlStr1 = "select * from (select row_.*,rownum id from (" + sqlStmt + ") row_ where rownum <= "+iEndPos+") where id > "+iStartPos; //查询指定条数的记录
	System.out.println("sqlStr1:\n"+sqlStr1);
	

		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
		
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode2" retmsg="retMsg2" outnum="8">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result2" scope="end" />	
			
		<%
		System.out.println("result=================="+result.length);
		System.out.println("result2=================="+result2.length);
		for(int ii=0;ii<result2.length;ii++){
				for(int jj=0;jj<result2[ii].length;jj++){
					System.out.println("result2["+ii+"]["+jj+"]="+result2[ii][jj]);
				}
		}
		
		System.out.println("\n==================\nok1");	
	
		String[][] allNumStr = new String[][]{};
		String[][] result1   = new String[][]{};

	try 
	{
		//allNumStr = (String[][])retList.get(0);
		allNumStr=result;
		//System.out.println("allNumStr = " + allNumStr[0][0]);
		System.out.println("\n==================\nok2");	
	}
	catch(Exception e)
	{
		System.out.println("\n==================\nerror2");
	}
	
	try 
	{
		//result1 = (String[][])retList1.get(0);	
		result1=result2;	
		System.out.println("\n==================\nok3");	
	}
	catch(Exception e)
	{
		System.out.println("\n==================\nerror3");
	}
	
	System.out.println("allNumStr = " + allNumStr[0][0]);
	
	if(result1 == null || result1.length == 0)
	{
	%>
		<script language='javascript'>
			rdShowMessageDialog("没有查到相关记录！");
			parent.location="f1023_main.jsp";				
		</script>      
	<%            
	}
	%>	

<html>
<head>
</head>

<script type=text/javascript>
		
	//控制窗体的移动
	function initAd() 
	{		
		document.all.page0.style.posLeft = -200;
		document.all.page0.style.visibility = 'visible'
		MoveLayer('page0');
	}
	
	function MoveLayer(layerName) 
	{
		var x = 10;
		var x = document.body.scrollLeft + x;		
		eval("document.all." + layerName + ".style.posLeft = x");
		setTimeout("MoveLayer('page0');", 20);
	}
	
	
	function grp(unit_id){
			var url = "grp_main.jsp?unit_id="+unit_id;
    	window.open(url,"","width=800,height=600,left=10,top=10,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
	}
</script>

<body onload="initAd()" >
	<form name="form1" method="post" action="">	
		<%@ include file="/npage/include/header.jsp" %>   			
		<table id="tabList"  cellspacing=0 >			
			<tr align='center'>				
				<th>集团编码</th>
				<th>集团名称</th>
				<th>联系人</th>
				<th>客户经理工号</th>
				<th>客户经理名称</th>
				<th>集团规模</th>
				<th>操作</th>
				
			</tr>
		<%	
		for(int i = 0; i < result1.length; i++)
		{		  
		%>			
			<tr>				
				<td nowrap align='center'><%=result1[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][4].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][5].trim()%>&nbsp;</td>
				<td nowrap align='center'>
				<input name="queryAcBtn" class="b_foot"  type="button"  value="统一视图" onClick="grp(<%=result1[i][0].trim()%>);">
				</td>
			</tr>
		<%
		}
		%>				
			<tr>	
				<td colspan="10">
					<div id="page0" style="position:relative;font-size:12px;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
		</table>
 		<%@ include file="/npage/include/footer_simple.jsp" %>  
</form>
</body>
</html>

