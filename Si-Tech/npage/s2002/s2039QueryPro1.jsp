<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html><head>

<script language="javascript">
	
</script>

</head>

<%
	Logger logger = Logger.getLogger("f5102.jsp");
	 
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String  implRegion = baseInfo[0][16].substring(0,2);
%>

<%
	String sqlStr = "";
	String sqlStr1 = "";
	String sqlStmt = "";
	String whereSql = "";
	
	
	String PospecNum = request.getParameter("PospecNum")==null?"":request.getParameter("PospecNum"); 
	String PospecProNum = request.getParameter("PospecProNum")==null?"":request.getParameter("PospecProNum"); 
	
	System.out.println("PospecNum="+PospecNum);
	System.out.println("PospecProNum="+PospecProNum);
	
		System.out.println("2");
		sqlStr1="select a.PospecNumber,d.Pospec_name,a.PospecProNumber ,b.Productspec_name ,c.product_code ,"
			   +" c.product_name ,c.note , case when a.end_time>=sysdate then '1' else '0' end abc "
		       +" from spospecproprodrela a , dproductspecInfo b,sproductcode  c,dPospecInfo d  "
		       +" where a.PospecProType='2' and  a.PospecProNumber=b.productspec_number  "
		       +" and a.PospecNumber=b.Pospec_number and a.PospecNumber=d.Pospec_number "
		       +" and d.end_date>=sysdate "
		       +" and a.product_code=c.product_code  "
		       +" and a.PospecProNumber like '?%' "
		       +" and a.PospecNumber like '?%'";
		       
		System.out.println("sqlStr1="+sqlStr1);       
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
%>

<wtc:pubselect name="sPubSelect" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql>
		select a.PospecNumber , d.Pospec_name , a.PospecProNumber , b.Productspec_name ,
		c.product_code , c.product_name , c.note ,case when a.end_time>=sysdate then '1' else '0' end abc 
		from spospecproprodrela a ,dproductspecInfo b ,sproductcode c ,dpospecInfo d 
		where a.PospecProType='2' and a.PospecProNumber=b.productspec_number 
		and d.end_date>=sysdate and a.product_code=c.product_code
		and a.pospecProNumber like '?%'
		and a.PospecNumber like '?%'
		</wtc:sql>
	<wtc:param value="<%=PospecProNum%>" />	
	<wtc:param value="<%=PospecNum%>" />	
</wtc:pubselect>

<wtc:array id="rateCodeStr" scope="end" />

<body bgcolor="#FFFFFF" text="#000000" background="" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<form name="form1" method="post" action="">	
	
	<div id="Operation_Table">	
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0 bgcolor="#FFFFFF">		

		<tr bgcolor="#F5F5F5">				
				<td nowrap align='center'><div><b>商品规格编码</b></div></td>
				<td nowrap align='center'><div><b>商品规格名称</b></div></td>
				<td nowrap align='center'><div><b>产品规格编码</b></div></td>
				<td nowrap align='center'><div><b>产品规格名称</b></div></td>
				<td nowrap align='center'><div><b>产品代码</b></div></td>
				<td nowrap align='center'><div><b>产品名称</b></div></td>
				<td nowrap align='center'><div><b>产品描述</b></div></td>
				<td nowrap align='center'><div><b>操作</b></div></td>
		</tr>
		
<%	
	
		for(int i = 0; i < rateCodeStr.length; i++)
		{		  
%>		
		<tr bgcolor="#F5F5F5">				
				<td nowrap align='center'><%=rateCodeStr[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][4].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][5].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][6].trim()%>&nbsp;</td>
				<td>
					<%if("1".equals(rateCodeStr[i][7])){%>
					<input name="operator<%=i+1%>"  style="cursor:hand" type="button" value="终止" class="button"  
					onclick="queryMod('<%=rateCodeStr[i][0].trim()%>','<%=rateCodeStr[i][2].trim()%>')">
					
					<%}else{%>
					已终止
					<%}%>
				</td>

			</tr>
<%
    }
%>	
		
</table>
		
	</div>   
</form>
</body>
</html>
