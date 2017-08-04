<%
   /*
   * 功能: 公务测试号当前用户清单
　 * 版权: sitech
   * 作者: dujl
 　*/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.*" %>


<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 

	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
    
	String loginNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	
	/**************** 分页设置 ********************/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	/**********************************************/	
		
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList = new ArrayList(); 
	ArrayList retList1 = new ArrayList();  
	String sqlStr="";
	String sqlStr1="";
	String whereSql="";
	String[][] allNumStr = new String[][]{};
	String[][] result1 = new String[][]{};
	String typeCode = request.getParameter("typeCode");
  	String useUnit = request.getParameter("useUnit");
  	String useDepartment = request.getParameter("useDepartment");
  	String useCenter = request.getParameter("useCenter");
  	System.out.println("typeCode= " + typeCode);
	System.out.println("useUnit= " + useUnit);
	System.out.println("useDepartment= " + useDepartment);
	System.out.println("useCenter= " + useCenter);
		
	if(!(typeCode.equals("")))
	{
	    whereSql = whereSql + " and    b.type_code like '"+typeCode+"%' ";
	}
	if(!(useUnit.equals("")))
	{
	    whereSql = whereSql + " and    b.UNIT_CODE like '"+useUnit+"%' ";
	}
	if(!(useDepartment.equals("")))
	{
	    whereSql = whereSql + " and  b.DEPARTMENT_CODE like '"+useDepartment+"%' ";
	}
	if(!(useCenter.equals("")))
	{
	    whereSql = whereSql + " and  b.CENTER_CODE like '"+useCenter+"%' ";
	}
	   System.out.println("whereSql= " + whereSql);
	
	 //查询内容
 sqlStr1="select nvl(i.region_name, '省公司'),d.UNIT_NAME, " +
					      "e.DEPARTMENT_NAME, f.CENTER_NAME, " +
					      "b.CUST_NAME, g.LEVEL_NAME, " +
					      "b.PHONE_NO, decode(b.phone_type, '0', '测试号', '1', '公务号'), " +
					      "c.run_name, h.APPLICATION_NAME, " +
					      "to_char(b.end_time, 'yyyymmdd'), b.warning_money, " +
					      "b.limit_money, " +
					      "wm_concat(decode(x.monitor_type,'01',x.field_value)), " +
					      "wm_concat(decode(x.monitor_type,'02',x.field_value)), " +
					      "wm_concat(decode(x.monitor_type,'03',x.field_value)), " +
					      "wm_concat(decode(x.monitor_type,'04',x.field_value)) " +
         "from dcustmsg a ,dtestphonemsg b ,sruncode c ,sUseUnit d,sUseDepartment e,sUseCenter f,sUseLevel g,sUseApplication h ,sregioncode i,dtestphoneaddmsg x  " +
		     "where a.id_no=b.id_no and substr(a.run_code,2,1)=c.run_code and c.region_code='"+regionCode+"' and a.belong_code like '"+regionCode+"%' "
            + " and b.UNIT_CODE = d.UNIT_CODE and b.DEPARTMENT_CODE = e.DEPARTMENT_CODE and b.CENTER_CODE = f.CENTER_CODE and b.type_code=i.region_code(+)"
            + " and b.level_code = g.level_code and b.application_code = h.application_code and b.UNIT_CODE=e.UNIT_CODE "
            + " and b.type_code=d.type_code and b.type_code=e.type_code and b.UNIT_CODE=f.UNIT_CODE and d.UNIT_CODE=f.UNIT_CODE "
            + " and b.type_code=f.type_code and b.PHONE_TYPE=h.PHONE_TYPE and b.dEPARTMENT_CODE=f.dEPARTMENT_CODE and x.id_no(+) = a.id_no " + whereSql;
  
  sqlStr1 += " group by nvl(i.region_name, '省公司'),d.UNIT_NAME , " +
       								" e.DEPARTMENT_NAME,f.CENTER_NAME ,b.CUST_NAME, " +
       								" g.LEVEL_NAME, b.PHONE_NO ,decode(b.phone_type, '0', '测试号', '1', '公务号'), " +
       								" c.run_name,h.APPLICATION_NAME ,to_char(b.end_time, 'yyyymmdd'), " +
       								" b.warning_money ,b.limit_money";
  
  //查询总记录数
	 sqlStr = " select count(*) from ( " + sqlStr1 + " )";
   
	try {
	    retList = impl.sPubSelect("1",sqlStr, "region", regionCode);
			retList1 = impl.sPubSelect("17",sqlStr1, "region", regionCode);		  	  
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
		if(result1==null || result1.length == 0){
%>
			<script language="javascript">
			rdShowMessageDialog("没有查到相关记录！");		
			</script>
<%						 			
	  	}
%>	
<html>
<head>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
</head>
<STYLE>
	.Button 
	{
		font-size: 12px;
	}
	#Operation_Table td{background-color: #EEEEEE;	font-size: 12px;padding: 4px; border-right:1px solid #FFFFFF; border-bottom:1px solid #FFFFFF;}
</STYLE> 
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
</script>
<body onload="initAd()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<form name="form1" method="post" action="">	
	<div id="Operation_Table">	
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0>			
			<tr>	
				<td  align='center' class="blue"><div ><b>省市标志</b></div></td>
				<td  align='center' class="blue"><div ><b>使用单位</b></div></td>
				<td  align='center' class="blue"><div ><b>使用部门</b></div></td>
				<td  align='center' class="blue"><div ><b>使用中心</b></div></td>
				<td  align='center' class="blue"><div ><b>使用人</b></div></td>
				<td  align='center' class="blue"><div ><b>职位</b></div></td>
				<td  align='center' class="blue"><div ><b>使用号码</b></div></td>
				<td  align='center' class="blue"><div ><b>号码类别</b></div></td>
				<td  align='center' class="blue"><div ><b>用户状态</b></div></td>
				<td  align='center' class="blue"><div ><b>用途</b></div></td>
				<td  align='center' class="blue"><div ><b>到期时间</b></div></td>
				<td  align='center' class="blue"><div ><b>费用告警值</b></div></td>
				<td  align='center' class="blue"><div ><b>限额告警值</b></div></td>
				<td  align='center' class="blue"><div ><b>对端号码</b></div></td>
				<td  align='center' class="blue"><div ><b>APN接入节点</b></div></td>
				<td  align='center' class="blue"><div ><b>基站</b></div></td>
				<td  align='center' class="blue"><div ><b>小区</b></div></td>
			</tr>
	<%	
		for(int i = iStartPos; i < Math.min(iEndPos,result1.length); i++)
		{
	%>			
			<tr>				
				<td  align='center'><%=result1[i][0].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][1].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][2].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][3].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][4].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][5].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][6].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][7].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][8].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][9].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][10].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][11].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][12].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][13].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][14].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][15].trim()%>&nbsp;</td>
				<td  align='center'><%=result1[i][16].trim()%>&nbsp;</td>
			</tr>
	<%
		}
	%>		
			<tr>
				<td>
				<div align="center">
				<input class="b_foot" name="sure" type="button" value="导出" onClick="printTable(tabList);">
				</div>
				</td>
				<td colspan="16">
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
		</table>
	</div>   
</form>
</body>
</html>

<script>
var excelObj;
function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	excelObj = new ActiveXObject('excel.Application');
	excelObj.Visible = true;
	excelObj.WorkBooks.Add; 

	for(j=0;j<17;j++)
	{
		excelObj.Cells(1,j+1).Value=obj.rows[0].cells[j].innerText;
	}
	<%	
	for(int i = 0; i < result1.length; i++)
	{
	%>
		try
		{
			
			<%	
			for(int j = 0; j < 17; j++)
			{
			%>
				excelObj.Cells(<%=i%>+2,<%=j%>+1).NumberFormatLocal="@"; 
				excelObj.Cells(<%=i%>+2,<%=j%>+1).Value="<%=result1[i][j].trim()%>";
			<%	
			}
			%>
		}
		catch(e)
		{
			rdShowMessageDialog('生成excel失败!');
		}
	<%	
	}
	%>
}
</script>
