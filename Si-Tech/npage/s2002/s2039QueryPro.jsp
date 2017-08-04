<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
	<%
String opName  = "查询主资费";
String opCode = "";
%>
<head>

<script language="javascript">
	
function queryMod(PospecNum,vProductCode,productNum,planCode,v_id)
{	
	
   var packet = new AJAXPacket("s2039EndPro.jsp","请稍候......");
	 	packet.data.add("PospecNum",PospecNum);
	  	packet.data.add("ProductCode",vProductCode);
	  	packet.data.add("productNum",productNum);
	  	packet.data.add("planCode",planCode);
	  	packet.data.add("v_id",v_id);
  	
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
	Logger logger = Logger.getLogger("s2039QueryPro.jsp");
	 
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
		//wuxy alter 20090622 修改取值逻辑
		System.out.println("1");
		//sqlStr1="select d.productspec_number ,e.Productspec_name,d.Product_RatePlanID,f.Product_rateplandesc,"
		//+"c.product_code ,c.product_name ,c.note,a.POSPECPRONUMBER,"
		//+"case when a.end_time>=sysdate then '1' else '0' end end_flag"
		//+"from spospecproprodrela a , dPospecInfo b ,sproductcode c,sproductspecprodrela d,"
		//+"dproductspecInfo e,dproductrateplanInfo f"
		//+" where a.PospecProType='1' and  a.PospecProNumber=b.Pospec_number "
    //  	+"and a.product_code=c.product_code and d.product_code=c.product_code "
    //  	+"and d.Pospec_Number like '?%' and e.productspec_number=d.productspec_number "
    //  	+"and f.productspec_number=d.productspec_number and f.Product_rateplanid=d.Product_RatePlanID "
    //  	+"and b.End_date>=sysdate "
    //  	+"and a.PospecProNumber like '?%' "
    //  	+"order by end_flag desc";
    sqlStr1="select a.productspec_number ,e.Productspec_name,a.Product_RatePlanID,f.Product_rateplandesc, "
           +" c.product_code ,c.product_name ,c.note,a.pospec_number, "
           +" case when a.end_time>=sysdate then '1' else '0' end end_flag "
           +" from sproductspecprodrela a , dPospecInfo b ,sproductcode c , "
           +" dproductspecInfo e,dproductrateplanInfo f "
           +" where   a.pospec_number=b.Pospec_number "
           +" and a.product_code=c.product_code and e.productspec_number=a.productspec_number "
           +" and f.productspec_number=a.productspec_number and f.Product_rateplanid=a.Product_RatePlanID "
           +" and a.End_time>=sysdate and a.begin_time<=sysdate "
           +" and a.productspec_number like '?%' "
           +" and a.pospec_number like '?%' "
           +" order by end_flag desc ";
		       
		System.out.println("sqlStr1="+sqlStr1);       
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
%>

<wtc:pubselect name="sPubSelect" outnum="9" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql>
		select a.productspec_number ,e.Productspec_name,a.Product_RatePlanID,f.Product_rateplandesc,
		c.offer_id ,c.offer_name ,c.offer_name,a.pospec_number,
		case when a.end_time>=sysdate then '1' else '0' end end_flag
		from sproductspecprodrela a , dPospecInfo b ,product_offer c ,
		dproductspecInfo e,dproductrateplanInfo f
		where   a.pospec_number=b.Pospec_number
      	and e.productspec_number=a.productspec_number
      	and f.productspec_number=a.productspec_number and f.Product_rateplanid=a.Product_RatePlanID
      	and a.End_time>=sysdate and a.begin_time<=SYSDATE
        AND a.Offer_Id = c.offer_id
        and a.productspec_number like '?%' 
      	and a.pospec_number like '?%'
      	order by end_flag DESC
	</wtc:sql>
	<wtc:param value="<%=PospecProNum%>" />
	<wtc:param value="<%=PospecNum%>" />
</wtc:pubselect>
<wtc:array id="rateCodeStr" scope="end" />


<body bgcolor="#FFFFFF" text="#000000" background="" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="/npage/include/header_pop.jsp" %>   
<form name="form1" method="post" action="">	
	
	<div style="height: 360px;width: 99%;overflow: auto">
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0 >		

		<tr>
				<th nowrap align='center'><b>商品规格编码</b></td>				
				<th nowrap align='center'><b>产品规格编码</b></td>
				<th nowrap align='center'><b>产品规格名称</b></td>
				<th nowrap align='center'><b>资费计划标识</b></td>
				<th nowrap align='center'><b>资费计划描述</b></td>
				<th nowrap align='center'><b>产品代码</b></td>
				<th nowrap align='center'><b>产品名称</b></td>
				<th nowrap align='center'><b>产品描述</b></td>
				<th nowrap align='center'><b>操作</b></td>
		</tr>

<%	
	
		for(int i = 0; i < rateCodeStr.length; i++)
		{		  
%>		
		<tr>
				<td nowrap align='center'><%=rateCodeStr[i][7].trim()%>&nbsp;</td>				
				<td nowrap align='center'><%=rateCodeStr[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][4].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][5].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][6].trim()%>&nbsp;</td>
				<td>
					<%if("1".equals(rateCodeStr[i][8])){%>
					<input name="operator<%=i+1%>"  style="cursor:hand" type="button" value="终止" class="button"  
					onclick="queryMod('<%=rateCodeStr[i][7].trim()%>','<%=rateCodeStr[i][4].trim()%>','<%=rateCodeStr[i][0].trim()%>','<%=rateCodeStr[i][2].trim()%>','<%=i+1%>')">
					
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
<!--<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=关闭>
            </TD>
        </TR>
    </TBODY>
</TABLE>		-->
	</div>

</form>
<%@ include file="/npage/include/footer.jsp" %>      
</body>
</html>
