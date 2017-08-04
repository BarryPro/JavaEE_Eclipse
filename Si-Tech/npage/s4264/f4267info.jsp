<%
   /*
   * 功能: 备注信息查询
　 * 版权: sitech
   * 作者: dujl
 　*/
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
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
	String[][] allNumStr = new String[][]{};
	String[][] result1 = new String[][]{};
  	String opNote = request.getParameter("opNote");
	System.out.println("opNote= " + opNote);
	
	 //查询总记录数
	 sqlStr = "select count(*)  from dTestPhoneMsg a,sUseUnit b,Susedepartment c,susecenter d,suselevel e,suseapplication f  "
            + " where a.op_note like '%"+opNote+"%' and b.type_code=a.type_code and b.unit_code = a.unit_code "
            + " and c.type_code=a.type_code and c.unit_code=a.unit_code and c.department_code=a.department_code "
            + " and d.type_code=a.type_code and d.unit_code=a.unit_code and d.department_code=a.department_code and d.center_code=a.center_code "
            + " and e.level_code=a.level_code and f.application_code=a.application_code " ;
	 //查询内容  
     sqlStr1="select a.* from (select a.phone_no ,a.cust_name,decode(a.phone_type,'0','测试号','1','公务号'),b.unit_name,c.department_name,d.center_name,e.level_name,f.application_name ,a.op_note, rownum rnum "
            + " from dTestPhoneMsg a,sUseUnit b,Susedepartment c,susecenter d,suselevel e,suseapplication f " 
		    + " where a.op_note like '%"+opNote+"%' and b.type_code=a.type_code and b.unit_code = a.unit_code "
            + " and c.type_code=a.type_code and c.unit_code=a.unit_code and c.department_code=a.department_code "
            + " and d.type_code=a.type_code and d.unit_code=a.unit_code and d.department_code=a.department_code and d.center_code=a.center_code "
            + " and e.level_code=a.level_code and f.application_code=a.application_code) a where a.rnum <= "+iEndPos+" and  a.rnum > "+iStartPos;
	try {
	    retList = impl.sPubSelect("1",sqlStr, "region", regionCode);
			retList1 = impl.sPubSelect("9",sqlStr1, "region", regionCode);		  	  
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
				<td  align='center' class="blue"><div ><b>手机号码</b></div></td>
				<td  align='center' class="blue"><div ><b>客户名称</b></div></td>
				<td  align='center' class="blue"><div ><b>号码类别</b></div></td>
				<td  align='center' class="blue"><div ><b>使用单位</b></div></td>
				<td  align='center' class="blue"><div ><b>使用部门</b></div></td>
				<td  align='center' class="blue"><div ><b>使用中心</b></div></td>
				<td  align='center' class="blue"><div ><b>级别</b></div></td>
				<td  align='center' class="blue"><div ><b>用途</b></div></td>
				<td  align='center' class="blue"><div ><b>备注</b></div></td>
			</tr>
	<%	
		for(int i = 0; i < result1.length; i++)
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
			</tr>
	<%
		}
	%>		
			<tr>	
				<td colspan="10">
					<div id="page0" style="position:relative;font-size:12px;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%	
					    //实现分页
					    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
					    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						  PageViewCn view = new PageViewCn(request,out,pg); 
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
