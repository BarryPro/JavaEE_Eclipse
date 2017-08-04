<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
		<%
String opName  = "查询成员资费";
String opCode = "";
%>
<head>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script language="javascript">
	
	function queryMod(PospecNum,vregioncode,vmodecode,productNum,planCode,v_id)
{	
	  
     var packet = new AJAXPacket("s2039EndPro.jsp","请稍候......");
	 	  packet.data.add("PospecNum",PospecNum);
	  	packet.data.add("modecode",vmodecode);
	  	packet.data.add("productNum",productNum);
	  	packet.data.add("planCode",planCode);
	  	packet.data.add("vregioncode",vregioncode);
	  	packet.data.add("v_id",v_id);
	  	packet.data.add("tempflag","1");
	  	
	 core.ajax.sendPacket(packet);
	 
		packet =null;				
}

function doProcess(packet)
{
		var retType = packet.data.findValueByName("retType");
	   	var retFlag = packet.data.findValueByName("retFlag");
	   	var v_id= packet.data.findValueByName("v_id");
	   	//alert(retFlag);
	   	if(retFlag!="0")
	   	{
	   		rdShowMessageDialog("终止产品资费绑定关系失败"+retType);
			  return;
	   	}
	   	else
	   	{
	   		rdShowMessageDialog("操作成功！");
	   		document.getElementById('operator'+v_id.trim()).disabled=true;
	   		//window.refresh();
	   	}
}
	
	
</script>

</head>

<%
	Logger logger = Logger.getLogger("f5102.jsp");
	 
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String  implRegion = baseInfo[0][16].substring(0,2);
%>

<%
	String sqlStr = "select a.region_code,a.pospec_number,a.productspec_number,c.productspec_name,e.product_rateplanid,e.product_rateplandesc,a.mode_code,b.mode_name "
		+",case when a.end_time>=sysdate then '1' else '0' end end_flag "
		+"from sproductspecmoderela a,sbillmodecode b,dproductspecinfo c,dpospecinfo d,dproductrateplaninfo e "
		+" where  "
		+" c.pospec_number=d.pospec_number and a.pospec_number =d.pospec_number "
		+" and a.productspec_number=c.productspec_number "
		+" and e.pospec_number=a.pospec_number  "
		+" and a.end_time>=sysdate "
		+" and e.productspec_number=c.productspec_number "
		+" and e.product_rateplanid=a.product_rateplanid"
		+" and b.mode_code=a.mode_code and a.region_code=b.region_code "
		+" and a.pospec_number like '?%' "
		+" and a.productspec_number like '?%' ";
	String sqlStr1 = "";
	String sqlStmt = "";
	String whereSql = "";
	
	
	String PospecNum = request.getParameter("PospecNum")==null?"":request.getParameter("PospecNum"); 
	String PospecProNum = request.getParameter("PospecProNum")==null?"":request.getParameter("PospecProNum"); 
	
	System.out.println("PospecNum="+PospecNum);
	System.out.println("PospecProNum="+PospecProNum);
	
		System.out.println("sqlStr="+sqlStr);
		
		String vregion="";
		String v_id="";
		String vmode="";
		 
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
%>

<wtc:pubselect name="sPubSelect" outnum="9" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql>
		  SELECT A.REGION_CODE,
         A.POSPEC_NUMBER,
         A.PRODUCTSPEC_NUMBER,
         C.PRODUCTSPEC_NAME,
         E.PRODUCT_RATEPLANID,
         F.OFFER_COMMENTS,
         F.OFFER_ID,
         F.OFFER_NAME,
         CASE
           WHEN A.END_TIME >= SYSDATE THEN
            '1'
           ELSE
            '0'
         END END_FLAG
    FROM SPRODUCTSPECMODERELA A,
         DPRODUCTSPECINFO     C,
         DPRODUCTRATEPLANINFO E,
         PRODUCT_OFFER        F
   WHERE A.PRODUCTSPEC_NUMBER = C.PRODUCTSPEC_NUMBER
     AND E.POSPEC_NUMBER = A.POSPEC_NUMBER
     AND E.PRODUCTSPEC_NUMBER = C.PRODUCTSPEC_NUMBER
     AND E.PRODUCT_RATEPLANID = A.PRODUCT_RATEPLANID
     AND A.END_TIME >= SYSDATE
     AND A.OFFER_ID = F.OFFER_ID
     AND A.POSPEC_NUMBER LIKE '?%'
     AND A.PRODUCTSPEC_NUMBER LIKE '?%'
</wtc:sql>
	<wtc:param value="<%=PospecNum%>" />	
	<wtc:param value="<%=PospecProNum%>" />	
</wtc:pubselect>

<wtc:array id="rateCodeStr" scope="end" />
	
	
<body bgcolor="#FFFFFF" text="#000000" background="" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="/npage/include/header_pop.jsp" %>   
<form name="form1" method="post" action="">	
	<div style="height: 360px;width: 99%;overflow: auto">
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0 bgcolor="#FFFFFF">		

		<tr>				
				<th nowrap align='center'><b>地区代码</b></th>
				<th nowrap align='center'><b>商品规格编码</b></th>
				<th nowrap align='center'><b>产品规格编码</b></th>
				<th nowrap align='center'><b>产品规格名称</b></th>
				<th nowrap align='center'><b>资费计划标识</b></th>
				<th nowrap align='center'><b>资费计划描述</b></th>
				<th nowrap align='center'><b>资费代码</b></th>
				<th nowrap align='center'><b>资费名称</b></th>
				<th nowrap align='center'><b>操作</b></th>
				
		</tr>
		
<%	
	
		for(int i = 0; i < rateCodeStr.length; i++)
		{		
		    
%>		
		<tr>				
				<td nowrap align='center'><%=rateCodeStr[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][4].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][5].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][6].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][7].trim()%>&nbsp;</td>
				<td>
					<%if("1".equals(rateCodeStr[i][8])){

					%>
					<input name="operator<%=i+1%>"  style="cursor:hand" type="button" value="终止" class="button"  
					onclick="queryMod('<%=rateCodeStr[i][1].trim()%>','<%=rateCodeStr[i][0].trim()%>','<%=rateCodeStr[i][6].trim()%>','<%=rateCodeStr[i][2].trim()%>','<%=rateCodeStr[i][4].trim()%>','<%=i+1%>')" />
					
					<%}else{%>
					已终止
					<%}%>
				</td>
				
			</tr>
<%
    }
%>	
		<TR>
            <TD id="footer" colspan='9'>
                <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=关闭>
            </TD>
        </TR>
</table>
<!--	<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=关闭>
            </TD>
        </TR>
    </TBODY>
</TABLE>	!-->
	</div>

</form>
<%@ include file="/npage/include/footer.jsp" %>      
</body>
</html>
