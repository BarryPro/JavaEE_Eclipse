<%
   /*
   * 功能: 公务测试号当前用户清单
　 * 版权: sitech
   * 作者: dujl
 　*/
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page errorPage="/page/common/error.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 

	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
    
	String loginNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
		
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList = new ArrayList(); 
	ArrayList retList1 = new ArrayList();  
	String sqlStr="";
	String sqlStr1="";
	String whereSql="";
	String[][] allNumStr = new String[][]{};
	String[][] result1 = new String[][]{};
	String region_code = request.getParameter("regionCode");
  	String modeCode1 = request.getParameter("modeCode1");
  	System.out.println("regionCode= " + regionCode);
	System.out.println("modeCode1= " + modeCode1);
	
	if(!(region_code.equals("请点选择")))
	{
	    whereSql = whereSql + " where  region_code like '"+region_code+"%' ";
	}
	if(!(modeCode1.equals("")))
	{
	    whereSql = whereSql + " and  mode_code like '"+modeCode1+"%' ";
	}
	   System.out.println("whereSql= " + whereSql);
	
	 //查询总记录数
	 sqlStr = "select * from sMusicModeCfg  "
	 			+ whereSql 
	 			+ " order by region_code  ";
	 //查询内容
     sqlStr1="select region_code,mode_code,add_mode,note from sMusicModeCfg  "
            + whereSql 
            + " order by region_code  ";
            
	try {
	    retList = impl.sPubSelect("1",sqlStr, "region", regionCode);
			retList1 = impl.sPubSelect("4",sqlStr1, "region", regionCode);		  	  
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
				<td  align='center' class="blue"><div ><b>地区代码</b></div></td>
				<td  align='center' class="blue"><div ><b>主资费代码</b></div></td>
				<td  align='center' class="blue"><div ><b>绑定资费</b></div></td>
				<td  align='center' class="blue"><div ><b>备注</b></div></td>
			</tr>
	<%
		for(int i = 0; i < result1.length; i++)
		{
	%>			
			<tr>				
				<td  align='center' class="blue"><%=result1[i][0].trim()%>&nbsp;</td>
				<td  align='center' class="blue"><%=result1[i][1].trim()%>&nbsp;</td>
				<td  align='center' class="blue"><%=result1[i][2].trim()%>&nbsp;</td>
				<td  align='center' class="blue"><%=result1[i][3].trim()%>&nbsp;</td>
			</tr>
	<%
		}
	%>		
		</table>
	</div>   
</form>
</body>
</html>
