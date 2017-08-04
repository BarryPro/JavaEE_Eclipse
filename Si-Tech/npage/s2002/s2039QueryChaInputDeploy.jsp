<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<%
String opName  = "属性填写配置";
String opCode = "";
%>
<head>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script language="javascript">
	
	function queryMod(PospecNum,productNum,vcharacternum,v_id)
{	
	// alert('['+PospecNum+']['+productNum+']['+vcharacternum+']['+v_id+']');
	var attr_codes = document.getElementsByName('attr_code'+v_id);
	var attr_code = '';
	for(var i = 0 ; i < attr_codes.length ; i++){
			attr_code += attr_codes[i].value;
	}
	
	// alert(attr_code);
	

  var packet = new AJAXPacket("s2039EndPro.jsp","请稍候......");
 	packet.data.add("PospecNum",PospecNum);
  packet.data.add("productNum",productNum);
  packet.data.add("vcharacternum",vcharacternum);
  packet.data.add("attr_code",attr_code);
  packet.data.add("tempflag","7");
	//  packet.data.add("v_id",v_id); 不要了
	//  packet.data.add("code_th",code_th); 不要了
	
	
	  
	   core.ajax.sendPacket(packet);
	
		 packet =null;				
}

	
function doProcess(packet)
{
		  var retType = packet.data.findValueByName("retType");
	    var retFlag = packet.data.findValueByName("retFlag");
	   	if(retType!="3")
	   	{
	   			if(retFlag!="0")
	   			{
	   				rdShowMessageDialog("变更属性填写配置失败"+retType);
					  return;
	   			}
	   			else
	   			{
	   				rdShowMessageDialog("操作成功！");
	   			}
	   }
	   else
	   {
	   	  if(retFlag!="0")
	   			{
	   				rdShowMessageDialog("删除属性填写配置失败"+retType);
					  return;
	   			}
	   			else
	   			{
	   				rdShowMessageDialog("操作成功！");
	   			}
	   	
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
	String sqlStr = " select a.pospec_number,a.productspec_number,c.productspec_name, "
	              + " a.productcharacter_num,a.productcharacter_name,a.productcharacter_num,a.productcharacter_name,substr(a.character_attr_code,1,1),substr(a.character_attr_code,2,1),substr(a.character_attr_code,3,1),substr(a.character_attr_code,4,1)"
	              +" from dproductcharacterinfo a,dproductspecinfo c "
                +" where  a.pospec_number=c.pospec_number "
                + " and a.productspec_number=c.productspec_number "
                +" and a.pospec_number like '?%' "
                +" and a.productspec_number like '?%' "
                +" order by a.productcharacter_num ";
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

<wtc:pubselect name="sPubSelect" outnum="12" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
	<wtc:param value="<%=PospecNum%>" />	
	<wtc:param value="<%=PospecProNum%>" />	
</wtc:pubselect>

<wtc:array id="rateCodeStr" scope="end" />
	
	
<body bgcolor="#FFFFFF" text="#000000" background="" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="/npage/include/header_pop.jsp" %> 
<form name="form1" method="post" action="">	
	
	 <div style="height: 360px;width: 99%;overflow: auto">
  <table cellspacing=0>		

			<tr>		
				<th nowrap align='center'><b>商品规格编码</b></th>
				<th nowrap align='center'><b>产品规格编码</b></th>
				<th nowrap align='center'><b>产品规格名称</b></th>
				<th nowrap align='center'><b>BBOSS属性代码</b></th>
				<th nowrap align='center'><b>BBOSS属性名称</b></th>
			  <th nowrap align='center' colspan=4><b>属性设置</b></th>
			</tr>
		
<%	
	
		for(int i = 0; i < rateCodeStr.length; i++)
		{		
		    
%>		
		<tr bgcolor="#F5F5F5">			
				<td nowrap align='center' ><%=rateCodeStr[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center' ><%=rateCodeStr[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center' ><%=rateCodeStr[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center' ><%=rateCodeStr[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center' ><%=rateCodeStr[i][4].trim()%>&nbsp;</td>
				
		
				
				<td nowrap align='center'><select name="attr_code<%=i+1%>"    value="<%=rateCodeStr[i][7].trim()%>" ><option value='0' <%if("0".equals(rateCodeStr[i][7].trim())){%>selected<%}%> >可空</option><option value='1' <%if("1".equals(rateCodeStr[i][7].trim())){%>selected<%}%>>必填</option><option value='2' <%if("2".equals(rateCodeStr[i][7].trim())){%>selected<%}%> >必空</option><option value='3' <%if("3".equals(rateCodeStr[i][7].trim())){%>selected<%}%> >不传</option></select></td>		
				
				
				<td nowrap align='center'><select name="attr_code<%=i+1%>"    value="<%=rateCodeStr[i][8].trim()%>" ><option value='0' <%if("0".equals(rateCodeStr[i][8].trim())){%>selected<%}%> >可修改</option><option value='1' <%if("1".equals(rateCodeStr[i][8].trim())){%>selected<%}%>>不可修改</option></select></td>		
				
			
				<td nowrap align='center'><select name="attr_code<%=i+1%>"    value="<%=rateCodeStr[i][9].trim()%>" ><option value='0' <%if("0".equals(rateCodeStr[i][9].trim())){%>selected<%}%> >不唯一</option><option value='1' <%if("1".equals(rateCodeStr[i][9].trim())){%>selected<%}%>>唯一</option></select></td>		
				
			
				<td nowrap align="center">
				<input style="cursor:hand"  type="button" value="修改" class="b_text"  onclick="queryMod('<%=rateCodeStr[i][0].trim()%>','<%=rateCodeStr[i][1].trim()%>','<%=rateCodeStr[i][3].trim()%>','<%=i+1%>')" />
				</td>		
			</tr>
<%
    }
%>	
		
</table>
<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=关闭>
            </TD>
        </TR>
    </TBODY>
</TABLE>
	</div>

</form>                                 
<%@ include file="/npage/include/footer.jsp" %>     

</body>
</html>
