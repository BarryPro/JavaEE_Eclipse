<%
   /*
   * ����: ��ѯ���Ų�Ʒ��Ϣ
�� * �汾: v1.0
�� * ����: 2007/10/25
�� * ����: sunzg
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.14
 ģ��:���Ŷ�����Ϣ����(�޸�)
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	String regionCode=(String)session.getAttribute("regCode");
	String unitId = request.getParameter("unitId");
	/**************** ��ҳ���� ********************/
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
    String custId = request.getParameter("custId");
  
	if(!(custId.equals("")))
	{
    whereSql = whereSql + " and   a.cust_id = "+custId;
	}

   System.out.println("whereSql= " + whereSql);

   //��ѯ�ܼ�¼��
   
   sqlStr = "select count(*) from dGrpUserMsg a, sProductCode b "
          + " where  a.product_code = b.product_code "
          + whereSql;

	 //��ѯ����  
     sqlStr1="select a.ID_NO, c.SM_NAME, a.PRODUCT_CODE, b.product_name, decode(a.RUN_CODE,'A','����','I','Ԥ��','a','����','δ֪'), to_char(a.RUN_TIME,'yyyy-mm-dd'), b.note,c.sm_code "
              + " from dGrpUserMsg a, sProductCode b , sSmCode c " 
						  + " where  a.product_code = b.product_code  and a.sm_code = c.sm_code and c.region_code='01' "
              + whereSql;
	System.out.println("sqlStr==="+sqlStr);
	System.out.println("sqlStr1==="+sqlStr1);
    //retList = impl.sPubSelect("1",sqlStr, "region", regionCode);
	//retList1 = impl.sPubSelect("8",sqlStr1, "region", regionCode);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="allNumStrTemp" scope="end" />
		
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="8">
	<wtc:sql><%=sqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1Temp" scope="end" />
<%		  	  
	System.out.println("result1Temp====="+result1Temp.length);	
	System.out.println("allNumStrTemp====="+allNumStrTemp.length);	
	System.out.println("sqlStr====="+sqlStr);	
	System.out.println("sqlStr1====="+sqlStr1);		
	try{
		allNumStr = allNumStrTemp;
		System.out.println("allNumStr = " + allNumStr[0][0]);
	}	
		catch(Exception e)
	{
		System.out.println("\n==================\nerror2");
	}	
			
	try{
	   result1 = result1Temp;
	}		
			catch(Exception e)
	{
		System.out.println("\n==================\nerror3");
	}			
			
			if(result1==null || result1.length == 0){
%>
				<script language="javascript">
				 	rdShowMessageDialog("û�в鵽��ؼ�¼��");
				 	//parent.location="f2893_1.jsp";		
				</script>
  <%						 			
		  }
	%>	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

</head>

<script type=text/javascript>
		
	//���ƴ�����ƶ�
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
		location="f2895ProdSrvMsg.jsp?idNo=" + idNo;
	}	
	
  function modifyProdSrvAdd(idNo,runCode,sm_code){
  	document.middle.location="f2895ModifyProdSrv.jsp?idNo="+idNo+"&runCode="+runCode+"&sm_code="+sm_code+"&custId=<%=custId%>&unitId=<%=unitId%>";
    tabBusi.style.display="";
  }
</script>

<body onload="initAd()">

<form name="form1" method="post" action="">	
	<div id="Operation_Table">	
		<table id="tabList" cellspacing="0">			
			<tr>				
				<th nowrap align='center'><div ><b>��ƷID</div></th>
				<th nowrap align='center'><div ><b>ҵ��Ʒ��</div></th>
				<th nowrap align='center'><div ><b>��Ʒ����</div></th>
				<th nowrap align='center'><div ><b>��Ʒ����</div></th>
				<th nowrap align='center'><div ><b>״̬</div></th>
				<th nowrap align='center'><div ><b>��������</div></th>
				<th nowrap align='center'><div ><b>��Ʒ����</div></th>
			</tr>
	<%	
		for(int i = 0; i < result1.length; i++)
		{
	%>			
			<tr>				
				<td nowrap align='center' title="�����ѯ���޸ĸ��Ӷ�����Ϣ��" onclick="modifyProdSrvAdd('<%=result1[i][0].trim()%>','<%=result1[i][4].trim()%>','<%=result1[i][7].trim()%>')" style="cursor:hand"><font color="blue"><%=result1[i][0].trim()%></font>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center' title="����鿴��Ʒ�Ĺ����" onclick="showProdInfo('<%=result1[i][0].trim()%>')" style="cursor:hand"><font color="blue"><%=result1[i][2].trim()%></font>&nbsp;</td>
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
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <%	
					    //ʵ�ַ�ҳ
					    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
					    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						  PageView view = new PageView(request,out,pg); 
					   	view.setVisible(true,true,0,0);      
					%>
					</div>
				</td>				
			</tr>			
		</table>
	<TABLE id="tabBusi" style="display:none" id="mainOne" width="100%" height="0px" cellspacing="0">	
			<TR> 
				<td nowrap>
					<IFRAME frameBorder=0 id=middle name=middle scrolling="yes"  
					style="HEIGHT:300px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
					</IFRAME>
				</td> 
			</TR>
	</TABLE>				
	</div>   
</form>
</body>
</html>
