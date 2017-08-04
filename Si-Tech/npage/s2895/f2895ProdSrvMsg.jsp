<%
   /*
   * 功能: 查询集团产品信息
　 * 版本: v1.0
　 * 日期: 2007/10/25
　 * 作者: sunzg
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.17
 模块:集团订购信息管理(修改)
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	String[][] result = new String[][]{};
	String regionCode=(String)session.getAttribute("regCode");
	String unitId = request.getParameter("unitId");

	/**************** 分页设置 ********************/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	/**********************************************/

	String sqlStr="";
	String sqlStr1="";
	String whereSql="";
	String[][] allNumStr = new String[][]{};
	String[][] result1 = new String[][]{};
 	String idNo = request.getParameter("idNo");

   //查询总记录数
   sqlStr = "select count(*) from dGrpSrvMsg  where id_no =" + idNo;
	
		 //查询内容  
     sqlStr1="select id_no, PRODUCT_CODE, SERVICE_CODE, b.TYPE_NAME, substr(BEGIN_TIME,1,8), substr(END_TIME,1,8),to_char(op_time,'yyyymmdd') "
              + " from dGrpSrvMsg a, sSrvType b where b.srv_type = a.service_type and a.id_no =" + idNo;
     System.out.println(sqlStr1);
	
    //retList = impl.sPubSelect("1",sqlStr, "region", regionCode);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="allNumStrTemp" scope="end" />
		
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="7">
	<wtc:sql><%=sqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1Temp" scope="end" />
<%
	//retList1 = impl.sPubSelect("7",sqlStr1, "region", regionCode);		  	  
		
	try{
		allNumStr = allNumStrTemp;
		System.out.println("allNumStr = " + allNumStr[0][0]);
	}	
		catch(Exception e)
	{
		System.out.println("\n==================\nerror2");
	}	
			
	try{
	   result1   = result1Temp;
	}		
			catch(Exception e)
	{
		System.out.println("\n==================\nerror3");
	}			
			
			if(result1==null || result1.length == 0){
%>
				<script language="javascript">
				 	rdShowMessageDialog("没有查到相关记录！");
				 	//parent.location="f2893_1.jsp";		
				</script>
  <%						 			
		  }
	%>	
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
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
	
  function showProdInfo(idNo)
	{
		alert(idNo);
		location="f2895ProdSrvMsg.jsp?idNo=" + idNo;
		
		//window.open(path,'','height=500,width=800,left=100,top=60,scrollbars=yes,resizable=yes,location=no, status=yes');				
	}	
</script>

<body onload="initAd()">

<form name="form1" method="post" action="">	
	<div id="Operation_Table">	
		<table id="tabList" cellspacing="0">			
			<tr>				
				<th nowrap align='center'><div ><b>产品ID</b></div></th>
				<th nowrap align='center'><div ><b>产品代码</b></div></th>
				<th nowrap align='center'><div ><b>服务代码</b></div></th>
				<th nowrap align='center'><div ><b>服务类型</b></div></th>
				<th nowrap align='center'><div ><b>开始时间</b></div></th>
				<th nowrap align='center'><div ><b>结束时间</b></div></th>
				<th nowrap align='center'><div ><b>订购时间</b></div></th>
			</tr>
	<%	
		for(int i = 0; i < result1.length; i++)
		{
	%>			
			<tr>				
				<!--<td nowrap align='center' onclick="showProdInfo('<%=result1[i][0].trim()%>')" style="cursor:hand"><font color="blue"><%=result1[i][0].trim()%></font>&nbsp;</td> -->
				<td nowrap align='center'><%=result1[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][4].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][5].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][6].trim()%>&nbsp;</td>
			</tr>
	<%
		}
	%>		
			<tr>	
				<td colspan="10">
					<div id="page0" style="position:relative;font-size:12px;">
           			<%	
					    //实现分页
					    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
					    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						PageView view = new PageView(request,out,pg); 
					   	view.setVisible(true,true,0,0);      
					%> 
					   <input name="retButton" type="button" style="cursor:hand" class="b_text" value="返 回" onClick="javascript:history.go(-1);" >	
					</div>
				</td>				
			</tr>		
		</table>		
	</div>   
</form>
</body>
</html>