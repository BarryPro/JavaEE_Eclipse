<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<%
String opName  = "�����޸���������";
String opCode = "";
%>
<head>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script language="javascript">
	
	function queryMod(PospecNum,productNum,vcharacternum,v_id,code_th)
{	
	  
    var packet = new AJAXPacket("s2039EndPro.jsp","���Ժ�......");
	 	packet.data.add("PospecNum",PospecNum);
	  packet.data.add("productNum",productNum);
	  packet.data.add("vcharacternum",vcharacternum);
	  packet.data.add("v_id",v_id);
	  packet.data.add("code_th",code_th);
	  packet.data.add("tempflag","6");
	  
	   core.ajax.sendPacket(packet);
	  
		 packet =null;				
}

	
function doProcess(packet)
{
		var retType = packet.data.findValueByName("retType");
	   	var retFlag = packet.data.findValueByName("retFlag");
	   	var v_id= packet.data.findValueByName("v_id");
	   	var code_th = packet.data.findValueByName("code_th");
	   	//alert(retFlag);
	   	
	   	
	   	
	   	if(retType!="3")
	   	{
	   			if(retFlag!="0")
	   			{
	   				rdShowMessageDialog("���������д����ʧ��"+retType);
					  return;
	   			}
	   			else
	   			{
	   				rdShowMessageDialog("�����ɹ���");
	   				//alert('status'+v_id.trim()+'_'+code_th.trim());
	   				if(document.getElementById('status'+v_id.trim()+'_'+code_th.trim()).value=="��")
	   				{
	   				  document.getElementById('status'+v_id.trim()+'_'+code_th.trim()).value="��";
	   		  	}
	   				 else
	   				{
	   				 	 document.getElementById('status'+v_id.trim()+'_'+code_th.trim()).value="��";
	   				}
	   			}
	   }
	   else
	   {
	   	  if(retFlag!="0")
	   			{
	   				rdShowMessageDialog("ɾ��������д����ʧ��"+retType);
					  return;
	   			}
	   			else
	   			{
	   				rdShowMessageDialog("�����ɹ���");
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
	              + " a.productcharacter_num,a.productcharacter_name,b.field_code,b.character_name,decode(substr(a.character_attr_code,1,1),'0','��','1','��') ,decode(substr(a.character_attr_code,2,1),'0','��','1','��'),decode(substr(a.character_attr_code,3,1),'0','��','1','��'),decode(substr(a.character_attr_code,4,1),'0','��','1','��')"
	              +" from dproductcharacterinfo a,sprodcharactercode b,dproductspecinfo c "
                +" where a.productcharacter_num=b.character_number(+) and a.pospec_number=c.pospec_number "
                + " and a.productspec_number=c.productspec_number "
                +" and a.pospec_number like '?%' "
                +" and a.productspec_number like '?%' "
                +" order by b.field_code ";
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
				<th nowrap align='center'><b>��Ʒ������</b></th>
				<th nowrap align='center'><b>��Ʒ������</b></th>
				<th nowrap align='center'><b>��Ʒ�������</b></th>
				<th nowrap align='center'><b>BBOSS���Դ���</b></th>
				<th nowrap align='center'><b>BBOSS��������</b></th>
			  <th nowrap align='center' colspan=3><b>��������</b></th>
			</tr>
		
<%	
	
		for(int i = 0; i < rateCodeStr.length; i++)
		{		
		    
%>		
		<tr bgcolor="#F5F5F5">			
				<td nowrap align='center' rowspan=4><%=rateCodeStr[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center' rowspan=4><%=rateCodeStr[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center' rowspan=4><%=rateCodeStr[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center' rowspan=4><%=rateCodeStr[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center' rowspan=4><%=rateCodeStr[i][4].trim()%>&nbsp;</td>
				
		
				<td nowrap>����</td>
				<td nowrap align='center'><input size=2 name="status<%=i+1%>_1" type="text" style="text-align:center" Class="InputGrey" value="<%=rateCodeStr[i][7].trim()%>" />&nbsp;</td>		
				<td align="center">
					
					<input name="operator<%=i+1%>" style="cursor:hand"  type="button" value="�޸�" class="b_text" onclick="queryMod('<%=rateCodeStr[i][0].trim()%>','<%=rateCodeStr[i][1].trim()%>','<%=rateCodeStr[i][3].trim()%>','<%=i+1%>','1')"  />
				</td>	
			
			</tr>
			<tr>
				<td nowrap>�����޸�</td>
				<td nowrap align='center'><input size=2 name="status<%=i+1%>_2" type="text" style="text-align:center" Class="InputGrey" value="<%=rateCodeStr[i][8].trim()%>" />&nbsp;</td>		
				<td align="center">
					
					<input name="operator<%=i+1%>" style="cursor:hand"  type="button" value="�޸�" class="b_text" onclick="queryMod('<%=rateCodeStr[i][0].trim()%>','<%=rateCodeStr[i][1].trim()%>','<%=rateCodeStr[i][3].trim()%>','<%=i+1%>','2')"  />
				</td>		
			</tr>
			<tr>
				<td nowrap>Ψһ</td>
				<td nowrap align='center'><input size=2 name="status<%=i+1%>_3" type="text" style="text-align:center" Class="InputGrey" value="<%=rateCodeStr[i][9].trim()%>" />&nbsp;</td>		
				<td align="center">
					
					<input name="operator<%=i+1%>" style="cursor:hand"  type="button" value="�޸�" class="b_text" onclick="queryMod('<%=rateCodeStr[i][0].trim()%>','<%=rateCodeStr[i][1].trim()%>','<%=rateCodeStr[i][3].trim()%>','<%=i+1%>','3')"  />
				</td>		
			</tr>
			<tr>
				<td nowrap>����ؿ�</td>
				<td nowrap align='center'><input size=2 name="status<%=i+1%>_4" type="text" style="text-align:center" Class="InputGrey" value="<%=rateCodeStr[i][10].trim()%>" />&nbsp;</td>		
				<td align="center">
					
					<input name="operator<%=i+1%>" style="cursor:hand"  type="button" value="�޸�" class="b_text" onclick="queryMod('<%=rateCodeStr[i][0].trim()%>','<%=rateCodeStr[i][1].trim()%>','<%=rateCodeStr[i][3].trim()%>','<%=i+1%>','4')"  />
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
                <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=�ر�>
            </TD>
        </TR>
    </TBODY>
</TABLE>
	</div>

</form>                                 
<%@ include file="/npage/include/footer.jsp" %>     

</body>
</html>
