<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.16
 ģ��:���Ŷ�����Ϣ����(�޸�)
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	String custId = request.getParameter("custId");
	
	String loginNo = (String)session.getAttribute("workNo");
	String regionCode=(String)session.getAttribute("regCode");
	String iCount = "0";
	String iCount1 = "0";         /*�����Ƿ���2911-�޸����߼�ص����Ȩ��   */
    String iMonthFee="0";         /*���߼�صĻ�������� */
    /*  ��ȡ�����Ƿ���2885Ȩ�� */
	/* sunwt modify 20080429 */
	/*
    String sq2 = "select count(*) from sFuncPower where power_code = (select power_code from dLoginMsg where login_no = '" + loginNo + "') and function_code ='2885'";
	comImpl co=new comImpl();
	ArrayList noArr = co.spubqry32("1",sq2);
	String[][] nott = (String[][])noArr.get(0);
	iCount = nott[0][0];
	*/
	String paramsIn[] = new String[2];
 	paramsIn[0] = loginNo;       //����
 	paramsIn[1] = "2885";        //��������
 	
	ArrayList acceptList = new ArrayList();
	String errCode = "";
	String errMsg ="";
	
	
	//acceptList = callViewCheck.callFXService("sFuncCheck", paramsIn, "1","region", regionCode);	
%>
	<wtc:service name="sFuncCheck" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<wtc:param value="<%=paramsIn[0]%>"/>
	<wtc:param value="<%=paramsIn[1]%>"/>	
	</wtc:service>	
	<wtc:array id="acceptListTemp"  scope="end"/>
<%
	errCode = retCode1;
	errMsg = retMsg1;;
	
	iCount = acceptListTemp[0][0];
	
    /* ��ȡ�����Ƿ���2911Ȩ�� */
	/* sunwt modify 20080429
    String sq3 = "select count(*) from sFuncPower where power_code = (select power_code from dLoginMsg where login_no = '" + loginNo + "') and function_code ='2911'";
	comImpl co1=new comImpl();
	ArrayList noArr1 = co1.spubqry32("1",sq3);
	String[][] nott1 = (String[][])noArr1.get(0);
	iCount1 = nott1[0][0];   
	*/
	String paramsIn2[] = new String[2];
 	paramsIn2[0] = loginNo;       //����
 	paramsIn2[1] = "2911";        //��������
 	
	errCode = "";
	errMsg ="";
	
	//acceptList2 = callViewCheck2.callFXService("sFuncCheck", paramsIn2, "1","region", regionCode);	
%>
	<wtc:service name="sFuncCheck" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">			
	<wtc:param value="<%=paramsIn2[0]%>"/>	
	<wtc:param value="<%=paramsIn2[1]%>"/>	
	</wtc:service>	
	<wtc:array id="acceptList2Temp"  scope="end"/>
<%
	errCode = retCode2;
	errMsg = retMsg2;
			
	iCount1 = acceptList2Temp[0][0];
	/**************************************/
	/**************** ��ҳ���� ********************/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
/**********************************************/

	ArrayList retList = new ArrayList(); 
	ArrayList retList1 = new ArrayList();  
	ArrayList retList2 = new ArrayList(); 
	String sqlStr="";
	String sqlStr1="";
	String sqlStr2="";
	String whereSql="";
	String[][] allNumStr = new String[][]{};
	String[][] result1 = new String[][]{};
	String[][] result2 = new String[][]{};
	String idNo    = request.getParameter("idNo");
	String runCode = request.getParameter("runCode");
	String sm_code = request.getParameter("sm_code");
	String unitId = request.getParameter("unitId");
	
	//��ѯ�ܼ�¼��
	sqlStr = "select count(*) from dGrpSrvMsgAdd a, sProductAttrCode b "
	  + " where  a.SERVICE_ATTR = b.PRODUCT_ATTR  and  id_no =" + idNo;
	
	//��ѯ����  
	if(sm_code.equals("AD")||sm_code.equals("ML")||sm_code.equals("MA")){
		sqlStr1=" select a.id_no, d.product_code, b.param_code, c.param_name, a.field_value from dGrpuserMsgAdd a, sBizParamDetail b,sBizParamCode c,dGrpUserMsg d"+
		 " where a.busi_type = b.param_set and  a.field_code=b.PARAM_CODE and  b.PARAM_CODE=c.PARAM_CODE and a.id_no=d.id_no and a.id_no='"+idNo+"'";
	}else{
		sqlStr1="select a.id_no, a.product_code, a.service_attr, b.attr_name, a.attr_value "
		  + " from dGrpSrvMsgAdd a, sProductAttrCode b where  a.SERVICE_ATTR = b.PRODUCT_ATTR and id_no=" + idNo;
	}    
	//System.out.println("sqlStr=======>"+sqlStr);
	System.out.println("sqlStr1========>"+sqlStr1);
	
	//retList = impl.sPubSelect("1",sqlStr, "region", regionCode);
	//retList1 = impl.sPubSelect("5",sqlStr1, "region", regionCode);		
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="retListTemp" scope="end" />
		
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode4" retmsg="retMsg4" outnum="5">
	<wtc:sql><%=sqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="retList1Temp" scope="end" />
<%  	  
			
	try{
		allNumStr = retListTemp;
		System.out.println("allNumStr = " + allNumStr[0][0]);
	}	
		catch(Exception e)
	{
		System.out.println("\n==================\nerror2");
	}	
			
	try{
	   result1 = retList1Temp;
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
      else{
    	 /* ��product_code��id_no ѡ�����߼�صĻ�������� */
    	  for(int z = 0; z < result1.length; z++){
    	     if(result1[z][2].equals("58")) {
    	       sqlStr2="SELECT a.srv_fee from  sGrpStaticCode a, dGrpSrvMsg  b"
                            + " where b.service_type='z'  "
                            + " and b.product_code='" + result1[z][1].trim() + "'" 
                            + " and a.srv_code=b.service_code "
                            + " and b.id_no=" + idNo;
    	       
    	       //retList2 = impl.sPubSelect("1",sqlStr2, "region", regionCode);	
%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode5" retmsg="retMsg5" outnum="1">
				<wtc:sql><%=sqlStr2%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="retList2Temp" scope="end" />	  	  
<%		        
    	      try{
            	   result2   = retList2Temp;
            	}		
            			catch(Exception e)
            	{
            		System.out.println("\n==================\nerror3");
            	}			
    	      iMonthFee=result2[0][0];
    	      
    	       break;
    	     }
    	  
    	  }
    	  
    	}
	
	
	
	%>	
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

</head>

<script type=text/javascript>

onload=function(){
	
}		
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
	
	function modifyProdSrvAdd(idNo, prodCode, attrCode, attrValue, index,iMonthFee,iCount1,runCode){
  var sm_code=document.all.sm_code.value;

  var newAttrValue;
  var myPacket;
  		if(runCode!="����") {
			rdShowMessageDialog("��Ʒ״̬�ǡ�������������������");
			document.all.attrValue[index].value =attrValue;
			return;
		}
  	
  	if(document.all.attrValue[index].value == attrValue){
			rdShowMessageDialog("���ԭֵ��"+attrValue+"�����е������ٵ���޸ģ�");
			document.all.attrValue[index].focus();
			return;
		}
		
		if(document.all.attrValue[index].value == ""){
			rdShowMessageDialog("�����޸�Ϊ��ֵ��");
			document.all.attrValue[index].focus();
			return;
		}

  if(sm_code=="AD"||sm_code=="ML"||sm_code=="MA"){
	
		newAttrValue = document.all.attrValue[index].value;
	  	myPacket = new AJAXPacket("f2895ModifyCfm1.jsp","�����ύ�����Ժ�...");
	  	myPacket.data.add("custId","<%=custId%>");
		myPacket.data.add("idNo",idNo);
		myPacket.data.add("prodCode",prodCode);
		myPacket.data.add("attrCode",attrCode);
		myPacket.data.add("newAttrValue",newAttrValue);
		myPacket.data.add("iMonthFee",iMonthFee );
		myPacket.data.add("unitId","<%=unitId%>" );
        core.ajax.sendPacket(myPacket);
        myPacket=null;	
	}else{	
        if(attrCode=="58"&&iCount1=="0") {
        	rdShowMessageDialog("����Աû���޸����߼�ص�ֵ��Ȩ�ޣ�"); 
        	return;    
        }
		newAttrValue = document.all.attrValue[index].value;
		myPacket = new AJAXPacket("f2895ModifyCfm.jsp","�����ύ�����Ժ�...");
		myPacket.data.add("custId","<%=custId%>");
		myPacket.data.add("idNo",idNo);
		myPacket.data.add("prodCode",prodCode);
		myPacket.data.add("attrCode",attrCode);
		myPacket.data.add("newAttrValue",newAttrValue);
		myPacket.data.add("iMonthFee",iMonthFee );
		myPacket.data.add("unitId","<%=unitId%>" );
	    core.ajax.sendPacket(myPacket);
	    myPacket=null;
    
  } 
    
	}

function doProcess(packet){
    //RPC ���ش���
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		
		if(retCode != "000000"){
			if(retCode=="291101") {
				rdShowMessageDialog("����dGrpSrvMSgAdd��ʧ�ܣ�",0);
			}
			else if(retCode=="291102") {
			    rdShowMessageDialog("����dGrpSrvMSg��deal_priceʧ�ܣ�",0);   
			}
			else {
			    rdShowMessageDialog("�޸�ʧ��:"+retMsg,0);
			}
		} else {
			rdShowMessageDialog("�޸ĳɹ���",2);
		}
		return;
}
	
</script>

<body onload="initAd()">

<form name="form1" method="post" action="">	
	<input type="hidden" name="sm_code" value="<%=sm_code%>">
	<div id="Operation_Table">	
		<table id="tabList" cellspacing="0">			
			<tr>				
				<th nowrap align='center'><div ><b>��ƷID</b></div></th>
				<th nowrap align='center'><div ><b>��Ʒ����</b></div></th>
				<th nowrap align='center'><div ><b>���Դ���</b></div></th>
				<th nowrap align='center'><div ><b>��������</b></div></th>
				<th nowrap align='center'><div ><b>����ֵ</b></div></th>
				<th nowrap align='center'><div ><b>�����</b></div></th>
			</tr>
	<%	
		for(int i = 0; i < result1.length; i++)
		{	
		/*	
		System.out.println("result1[i][2]"+result1[i][2]); 	
			if (result1[i][2].trim().equals("00003")){		
			System.out.println("result1[i][2]"+result1[i][2]);      		
			     if (result1[i][4].trim().equals("0")){
			       result1[i][4]="��֧��";
			       }
			    if (result1[i][4].trim().equals("1")){
			    	result1[i][4]="֧��"; 
			    	}
			 
			}
			
			if (result1[i][2].trim().equals("00008")){
			  if (result1[i][4].trim().equals("0")){
			       result1[i][4]="Ӣ��";
			       }
			 if (result1[i][4].trim().equals("1")){    
			    	result1[i][4]="����"; 
			    	}			 
		      		}*/             
		
	%>			
			<tr>				
				<!--<td nowrap align='center' onclick="showProdInfo('<%=result1[i][0].trim()%>')" style="cursor:hand"><font color="blue"><%=result1[i][0].trim()%></font>&nbsp;</td> -->
				<td nowrap><%=result1[i][0].trim()%>&nbsp;</td>
				<td nowrap><%=result1[i][1].trim()%>&nbsp;</td>
				<td nowrap><%=result1[i][2].trim()%>&nbsp;</td>
				<td nowrap><%=result1[i][3].trim()%>&nbsp;</td>
	             <% if (result1[i][2].trim().equals("00003")){		  %> 
	                 <td nowrap align=>
	                 	<select name="attrValue"  <% if(sm_code.equals("AD")||sm_code.equals("ML")||sm_code.equals("MA")){} else if((!result1[i][2].equals("51")&&!result1[i][2].equals("58")) || iCount.equals("0")){out.print("disable");}%> >  	                 		 
	                 		<option value="0" <%if("0".equals(result1[i][4].trim())){%>selected<%}%>>��֧��</option>  
	                 		<option value="1" <%if("1".equals(result1[i][4].trim())){%>selected<%}%>>֧��</option>
	                 	</select>
	                 	</td>         
	              
	             <%}%>
	             
	              <% if (result1[i][2].trim().equals("00008")){		  %> 
	                 <td nowrap >
	                 	<select name="attrValue"  <% if(sm_code.equals("AD")||sm_code.equals("ML")||sm_code.equals("MA")){} else if((!result1[i][2].equals("51")&&!result1[i][2].equals("58")) || iCount.equals("0")){out.print("disable");}%> >  
	                 		<option value="0" <%if("0".equals(result1[i][4].trim())){%>selected<%}%>>Ӣ��</option>  
	                 		<option value="1" <%if("1".equals(result1[i][4].trim())){%>selected<%}%>>����</option>
	                 	</select>
	                 	</td>         
	              
	             <%}%>
	             
				<%if (!result1[i][2].trim().equals("00008")&&!result1[i][2].trim().equals("00003")) {  %>
					<td nowrap ><input name="attrValue" type="text" class="button" value="<%=result1[i][4].trim()%>"  <% if(sm_code.equals("AD")||sm_code.equals("ML")||sm_code.equals("MA")){} else if((!result1[i][2].equals("51")&&!result1[i][2].equals("58")) || iCount.equals("0")){out.print("readonly");}%> maxlength=20> &nbsp;</td>
				
				<%}%>
				<td nowrap align='center'><input name="modiFy" type="button" class="b_text" value="�� ��" onClick="modifyProdSrvAdd('<%=result1[i][0].trim()%>','<%=result1[i][1].trim()%>','<%=result1[i][2].trim()%>','<%=result1[i][4].trim()%>', '<%=i%>',<%=iMonthFee%>,<%=iCount1%>,'<%=runCode.trim()%>')" <% if(sm_code.equals("AD")||sm_code.equals("ML")||sm_code.equals("MA")){} else if((!result1[i][2].equals("51")&&!result1[i][2].equals("58") )|| iCount.equals("0")){out.print("disabled");}%>>&nbsp;</td>
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
	</div>   
</form>
</body>
</html>
