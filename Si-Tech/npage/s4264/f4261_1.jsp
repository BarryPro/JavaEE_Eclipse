<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:到期告警查询
   * 版本: 1.0
   * 日期: 2009/3/30
   * 作者: dujl
   * 版权: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "4261";
	String opName = "到期告警查询";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	
	/**************** 分页设置 ********************/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	/**********************************************/
	
	ArrayList retList = new ArrayList(); 
	ArrayList retList1 = new ArrayList();  
	String sqlStr="";
	String sqlStr1="";
	String[][] allNumStr = new String[][]{};
	String[][] result1 = new String[][]{};
	
    //查询总记录数
	sqlStr = "select count(*) from dtestphonemsg a,dcustmsg b where  a.id_no=b.id_no   and sysdate>=end_time-30 and b.belong_code like '"+regionCode+"%'";
	
	//查询内容  
    sqlStr1="select a.* from (select a.phone_no,a.cust_name,to_char(end_time,'yyyymmdd'),decode(phone_type,'0','测试号','1','公务号') ,rownum rnum "
            + " from dtestphonemsg a,dcustmsg b " 
		    + " where a.id_no=b.id_no "
            + " and sysdate>=end_time-30   "
            + " and b.belong_code like '"+regionCode+"%' ) a  where a.rnum <= "+iEndPos+" and  a.rnum > "+iStartPos;
    
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
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--			
</script> 
 
<title>到期告警查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">

</head>
<BODY>
<form name="form" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">到期告警查询</div>
	</div>	
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0>			
			<tr>				
				<td nowrap align='center' class="blue"><div ><b>手机号码</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>客户名称</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>到期时间</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>号码类型</b></div></td>
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
			</tr>
	<%
		}
	%>		
			<tr>	
				<td colspan="10">
					<div id="page0" style="position:relative;font-size:12px;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
<%@ include file="/npage/include/footer.jsp" %> 
</form>
</BODY>
</HTML>
