<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<%
String opName  = "������������";
String opCode = "";
%>
<head>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script language="javascript">
	
	function queryMod(PospecNum,productNum,vcharacternum,v_id)
{	
	  
    var packet = new AJAXPacket("s2039EndPro.jsp","���Ժ�......");
	 	packet.data.add("PospecNum",PospecNum);
	  packet.data.add("productNum",productNum);
	  packet.data.add("vcharacternum",vcharacternum);
	  packet.data.add("v_id",v_id);
	  packet.data.add("tempflag","2");
	  
	   core.ajax.sendPacket(packet);
	  
		 packet =null;				
}

	function queryMod1(vcharacternum,v_id)
{	
	  
    var packet = new AJAXPacket("s2039EndPro.jsp","���Ժ�......");
	  packet.data.add("vcharacternum",vcharacternum);
	  packet.data.add("v_id",v_id);
	  packet.data.add("tempflag","3");
	  
	   core.ajax.sendPacket(packet);
	  
		 packet =null;				
}

function doProcess(packet)
{
		var retType = packet.data.findValueByName("retType");
	   	var retFlag = packet.data.findValueByName("retFlag");
	   	var v_id= packet.data.findValueByName("v_id");
	   	//alert(retFlag);
	   	
	   	
	   	
	   	if(retType!="3")
	   	{
	   			if(retFlag!="0")
	   			{
	   				rdShowMessageDialog("������Կ������ʧ��"+retType);
					  return;
	   			}
	   			else
	   			{
	   				rdShowMessageDialog("�����ɹ���");
	   				if(document.getElementById('status'+v_id.trim()).value=="��")
	   				{
	   				  document.getElementById('status'+v_id.trim()).value="��";
	   				}
	   				 else
	   				{
	   				 	 document.getElementById('status'+v_id.trim()).value="��";
	   				}
	   				//window.refresh();
	   			}
	   }
	   else
	   {
	   	  if(retFlag!="0")
	   			{
	   				rdShowMessageDialog("ɾ�����Զ�Ӧ��ϵʧ��"+retType);
					  return;
	   			}
	   			else
	   			{
	   				rdShowMessageDialog("�����ɹ���");
	   				
	   				  document.getElementById('code'+v_id.trim()).value="";
	   				 	 document.getElementById('codename'+v_id.trim()).value="";
	   				 	 document.getElementById('operdel'+v_id.trim()).disabled=true;
	   				
	   				//window.refresh();
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
	              + " a.productcharacter_num,a.productcharacter_name,b.field_code,b.character_name,decode(substr(a.character_attr_code,1,1),'0','��','1','��') "
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

<wtc:pubselect name="sPubSelect" outnum="9" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql>
		 select a.pospec_number,a.productspec_number,c.productspec_name,a.productcharacter_num,a.productcharacter_name,b.field_code,b.character_name,decode(substr(a.character_attr_code,1,1),'0','��','1','��') from dproductcharacterinfo a,sprodcharactercode b,dproductspecinfo c
    where a.productcharacter_num=b.character_number(+) and a.pospec_number=c.pospec_number and a.productspec_number=c.productspec_number
    and a.pospec_number like '?%'
    and a.productspec_number like '?%'
    order by b.field_code
</wtc:sql>
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
				<!--<th nowrap align='center'><b>��ӦBOSS���Դ���</b></th>
				<th nowrap align='center'><b>��ӦBOSS��������</b></th>-->
				<th nowrap align='center'><b>�Ƿ��������</b></th>
				<th nowrap align='center'><b>�޸Ŀ�������־</b></th>
			<!--	<th nowrap align='center'><b>ɾ�����Զ�Ӧ��ϵ</b></th> -->
				
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
				
			<!--	<td nowrap align='center'>
					<input name="code<%=i+1%>" type="text" style="text-align:center" Class="InputGrey" value="<%=rateCodeStr[i][5].trim()%>" />&nbsp;
				</td>
				<td nowrap align='center'><input name="codename<%=i+1%>" type="text" style="text-align:center" Class="InputGrey" value="<%=rateCodeStr[i][6].trim()%>" />&nbsp;</td>-->
				<td nowrap align='center'><input name="status<%=i+1%>" type="text" style="text-align:center" Class="InputGrey" value="<%=rateCodeStr[i][7].trim()%>" />&nbsp;</td>		
				<td align="center">
					
					<input name="operator<%=i+1%>" style="cursor:hand"  type="button" value="�޸�" class="b_text" onclick="queryMod('<%=rateCodeStr[i][0].trim()%>','<%=rateCodeStr[i][1].trim()%>','<%=rateCodeStr[i][3].trim()%>','<%=i+1%>')"  />
				</td>	
			<!--	<td align="center">
					<% if (rateCodeStr[i][5].trim().equals(""))
					{
					%>
					<input name="operdel<%=i+1%>" style="cursor:hand"  type="button" value="ɾ��" class="b_text" onclick="" disabled />
				  <%}else{ %>
				  <input name="operdel<%=i+1%>" style="cursor:hand"  type="button" value="ɾ��" class="b_text" onclick="queryMod1('<%=rateCodeStr[i][3].trim()%>','<%=i+1%>')"  />
				  <%}%>
				</td>	-->
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
