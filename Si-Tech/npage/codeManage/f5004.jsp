   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-11
********************/
%>
              
<%
  String opCode = "5004";
  String opName = "�ͻ����д������";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.config.INIT_DATA"%>


<%
		
	    String loginNo = (String)session.getAttribute("workNo");
	    String loginName = (String)session.getAttribute("workName");
	    String orgCode = (String)session.getAttribute("orgCode");
	    String ip_Addr = (String)session.getAttribute("ipAddr");
	    
	    String regionCode = (String)session.getAttribute("regCode");
	    String regionName = orgCode.substring(2,4);
	    
		  ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	    String[][] otherInfoSession = (String[][])arrSession.get(2);
	    String regionName1 = otherInfoSession[0][5];
	    
	    System.out.println("------------regionName1------------"+regionName1);
	    System.out.println("------------orgCode------------"+orgCode);
	    
	int		LISTROWS=16;
			
	//���й���Ȩ�޼���
%>

<%
	String[][] districtCodeData = new String[][]{};
	String[][] bankCodeData = new String[][]{};
	String[][] bankDetailData = new String[][]{};

	int		isGetDataFlag = 1;	//0:��ȷ,��������. add by yl.
	String errorMsg ="";
	String tmpStr="";

	
	StringBuffer  insql = new StringBuffer();
	
	//1.SQL ���ش���
	insql.delete(0,insql.length());
	insql.append("select trim(district_code),district_code||'-->'||trim(district_name) from  sDisCode ");
	insql.append(" where region_code='"+ regionCode +"'");
	insql.append(" order by district_code ");
	//al = s5010.getCommONESQL(insql.toString(),2,0);
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=insql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%	


	if( result_t1 == null ){
		isGetDataFlag = 2;
	}		
	if(code1.equals("000000"))
	districtCodeData = result_t1;

	//2.SQL ���д���
	insql.delete(0,insql.length());
	insql.append("select trim(district_code),trim(bank_code),trim(bank_code)||'-->'||trim(bank_name)  from sBankCode ");
	insql.append(" where region_code='"+ regionCode +"'");
	insql.append(" order by district_code,bank_code ");

	//al = s5010.getCommONESQL(insql.toString(),3,0);
%>

		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=insql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<%	
	

	if( result_t2 == null ){
		isGetDataFlag = 3;
	}		
	if(code2.equals("000000"))	
	bankCodeData = result_t2;


	//3.SQL �������ϸ
	insql.delete(0,insql.length());
	insql.append("select district_code,bank_code,trim(national_code),");
	insql.append(" trim(bank_name),trim(bank_phone)  ");
	insql.append(" from sBankCode  ");
	insql.append(" where region_code='"+ regionCode +"'");
	insql.append(" order by district_code,bank_code  ");

	//al = s5010.getCommONESQL(insql.toString(),5,0);
%>

		<wtc:pubselect name="sPubSelect" outnum="5" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=insql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>

<%	

	if( result_t3 == null ){
		isGetDataFlag = 4;
	}	
	if(code3.equals("000000"))	
	bankDetailData = result_t3;	

	isGetDataFlag = 0;


	 errorMsg = "ȡ���ݴ���:"+Integer.toString(isGetDataFlag);	    
	 //System.out.println(errorMsg);
%>

<%if( isGetDataFlag != 0 ){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<%=errorMsg%>");
	window.close();
	window.opener.focus();
//-->
</script>
<%}%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���д���Ĺ���</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<script language="JavaScript">
<!--
	//����Ӧ��ȫ�ֵı���
	var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
	var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
	var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�

	var oprType_Add = "a";
    var oprType_Upd = "u";
    var oprType_Del = "d";
    var oprType_Qry = "q";

	var INDEX_DisCode		= 0;	//���ݵ���SQL����е�λ�ö���ģ�������ͬ�� add by yl.
	    INDEX_DisBankCode 	= 1;
	    INDEX_DisBankName 	= 2;

	var INDEX_BankDisCode	= 0;
	    INDEX_BankCode		= 1;
	    INDEX_NationalCode	= 2;
	    INDEX_BankName		= 3;
	    INDEX_BankPhone		= 4;	    
	
	var bankCodeArr = new Array(<%=bankCodeData.length%>);
	
    <% for(int i=0; i<bankCodeData.length; i++){ 
    %>
    	bankCodeArr[<%=i%>] = new Array(<%=bankCodeData[i].length%>); 
    	<%
    	for(int j=0; j<bankCodeData[i].length; j++){
    %>
    		bankCodeArr[<%=i%>][<%=j%>] = "<%=bankCodeData[i][j]%>";
    <%	}
    }
    %>	

	var bankDetailArr = new Array(<%=bankDetailData.length%>);
	
    <% for(int i=0; i<bankDetailData.length; i++){ 
    %>
		    bankDetailArr[<%=i%>] = new Array(<%=bankDetailData[i].length%>);
    <%
    	for(int j=0; j<bankDetailData[i].length; j++){
    %>
    		bankDetailArr[<%=i%>][<%=j%>] = "<%=bankDetailData[i][j]%>";
    <%	}
    }
    %>	
            
	onload=function()
	{		
		init();
	}

	//---------1------RPC������------------------
	function doProcess(packet){
		//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
		error_code = packet.data.findValueByName("errorCode");
		error_msg =  packet.data.findValueByName("errorMsg");
		verifyType = packet.data.findValueByName("verifyType");
		backArrMsg = packet.data.findValueByName("backArrMsg");
	
		self.status="";
		
	}

	function fillSelectUseValue_noArr(fillObject,indValue)
	{	
			for(var i=0;i<document.all(fillObject).options.length;i++){
				if(document.all(fillObject).options[i].value == indValue){
					document.all(fillObject).options[i].selected = true;
					break;
				}
			}							
	}

	function init()
	{
		chg_opType();
		//DoList();
		
	}
	
	function chg_opType()
	{
		with(document.frm)
		{
			var op_type = opType[opType.selectedIndex].value;
			if( op_type == oprType_Add )
			{
				showAdd.style.display="";
				showOther.style.display="none";				
			}
			else
			{
				showAdd.style.display="none";
				showOther.style.display="";				
			}
			
			enabledInput();
			chg_districtCode();
			
			if( op_type == oprType_Add )
			{
				abankCode.value = "";
				clearInput();			
			}
								
		}
	}	

	function enabledInput()
	{
		with(document.frm)
		{
			var op_type = opType[opType.selectedIndex].value;
			if( (op_type == oprType_Add) ||
				(op_type == oprType_Upd)
			)
			{
				nationalCode.disabled =  false;
				bankName.disabled =  false;
				bankPhone.disabled =  false;			
			}
			else
			{
				nationalCode.disabled =  true;
				bankName.disabled =  true;
				bankPhone.disabled =  true;		
			}						
		}
	}
	
	function clearInput()
	{
		with(document.frm)
		{
			nationalCode.value = "";
			bankName.value = "";
			bankPhone.value = "";
		}		
	}

	function chg_districtCode()
	{
	var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
	if( op_type == oprType_Add )
	{
		document.frm.abankCode.value = "";
		clearInput();	
		return false;		
	}
			
			
	  with(document.frm)
	  {
		
	
		sbankCode.length = 0;
		if (districtCode.selectedIndex >= 0)
		{
		var distCode = districtCode[districtCode.selectedIndex].value;
			for( var i=0; i<bankCodeArr.length; i++ )
			{		
				if( distCode == bankCodeArr[i][INDEX_DisCode] )
				{
					sbankCode.length = sbankCode.length + 1;
					var option = new Option(bankCodeArr[i][INDEX_DisBankName],bankCodeArr[i][INDEX_DisBankCode]);
					sbankCode.options[sbankCode.length-1] = option;				
				}
			
			}
			if (sbankCode.length > 0)
			{
				sbankCode.options[0].selected = 0;
			}		
		}	

	  }
	  chg_sbankCode();
	}

	function chg_sbankCode()
	{
	  with(document.frm)
	  {
	  	clearInput();

	    
		if ( (districtCode.selectedIndex >= 0) && (sbankCode.selectedIndex >= 0 ) )
		{
		var distCode = districtCode[districtCode.selectedIndex].value;
		var bankCode = sbankCode[sbankCode.selectedIndex].value;
			for( var i=0; i<bankDetailArr.length; i++ )
			{		
				if( (distCode == bankDetailArr[i][INDEX_BankDisCode])
				  &&(bankCode == bankDetailArr[i][INDEX_BankCode])
				)
				{
					nationalCode.value =  bankDetailArr[i][INDEX_NationalCode];
					bankName.value =  bankDetailArr[i][INDEX_BankName];
					bankPhone.value =  bankDetailArr[i][INDEX_BankPhone];
					break;
				}
			
			}	
		 }

	  }	
	
	}

	function PubSimpSel_self(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
	{
	 
	    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
	    //var path = "../public/fPubSimpSel.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType;  
	
	    retInfo = window.showModalDialog(path);
		if(typeof(retInfo) == "undefined")     
	    {   return false;   }
	    var chPos_field = retToField.indexOf("|");
	    var chPos_retStr;
	    var valueStr;
	    var obj;
	    while(chPos_field > -1)
	    {
	        obj = retToField.substring(0,chPos_field);
	        chPos_retInfo = retInfo.indexOf("|");
	        valueStr = retInfo.substring(0,chPos_retInfo);
			
	        document.all(obj).value = valueStr;
	        retToField = retToField.substring(chPos_field + 1);
	        retInfo = retInfo.substring(chPos_retInfo + 1);
	        chPos_field = retToField.indexOf("|");
	        
	    }
	}

	function call_abankCodeQry()
	{
	    var pageTitle = "���д����ѯ";               
	    var fieldName = "���д���|��������|";
		var sqlStr ="";
		var distCode = document.frm.districtCode[document.frm.districtCode.selectedIndex].value;
					 
		sqlStr ="select bank_code,bank_name from sBankCode "+
				" where region_code='" + "<%=regionCode%>" +"'" +
				" and district_code='"+distCode+"'"+
				" order by bank_code ";
		
	    var selType = "S";    //'S'��ѡ��'M'��ѡ      
	    var retQuence = "1|0|";             
	    var retToField = "abankCode|";
	    
	    PubSimpSel_self(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 	
	}

	function judge_valid()
	{
		
	var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
	
		if( op_type == oprType_Add )
		{	
			if(!checkElement(document.frm.abankCode)) return false;	
		}

	  if( (op_type == oprType_Add) || (op_type == oprType_Upd) )
	  {
		if(!checkElement(document.frm.nationalCode)) return false;
		if(!checkElement(document.frm.bankName)) return false;
	  }
	
					
		return true;
	}

	function DoList()
	{
		//if (IList.style.visibility != "hidden")
		if (IList.style.display != "none")
		{
			//IList.style.visibility="hidden";
			IList.style.display = "none";
		}
		else
		{
			//IList.style.visibility="visible";
			IList.style.display = "";
		}
	}

	function resetJsp()
	{
	var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
	
		if( op_type == oprType_Add )
		{	
		document.frm.abankCode.value = "";
		clearInput();
		}	
		
	}
	
	function commitJsp()
	{
		var tmpStr="";
		var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
		var procSql = "";
		
		if( op_type == oprType_Qry )
		{
			rdShowMessageDialog("��ѯ����ȷ��!");
			return false;					
		}
			
		if( !judge_valid() )
		{
			return false;
		}

		//2.��form�������ֶθ�ֵ
		document.frm.opCode.value="5004";
		//4.�ύҳ��
		 procSql = " prc_5004_cfm('" + document.frm.opType.value+ "'";
		 procSql = procSql + ",'" + document.frm.regionCode.value+ "'";
		 procSql = procSql + ",'" + document.frm.districtCode.value+ "'";
		 if( op_type == oprType_Add ){
		 	procSql = procSql + ",'" + document.all.abankCode.value+ "'";
		 	tmpStr = "���� " + ",���д���:"+document.frm.abankCode.value+"";
		 }else{
		 	procSql = procSql + ",'" + document.all.sbankCode.value+ "'";
		 	tmpStr = "�޸� " + ",���д���:"+document.frm.sbankCode.value+"";
		 }
		 procSql = procSql + ",'" + document.all.nationalCode.value+ "'";
		 procSql = procSql + ",'" + document.all.bankName.value+ "'";
		 procSql = procSql + ",'" + document.all.bankPhone.value+ "'";
		 procSql = procSql + ",'" + document.frm.loginNo.value + "'";
		 procSql = procSql + ",'" + document.frm.opCode.value + "'";
		 procSql = procSql + ",'" + document.frm.IpAddr.value + "'";
		 
		 document.frm.opNote.value =  tmpStr;
		 procSql = procSql + ",'" + document.frm.opNote.value + "'";	
		

		//8.�ύҳ��
		document.frm.confirm.disabled = true;
		page = "f5004_confirm.jsp?procSql="+procSql;
		frm.action=page;
		frm.method="post";
	  frm.submit();
						 		
	
	}
				
				
//-->
</script>

</head>


<body>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">���д������</div>
	</div>


        
  <table  cellspacing="0">
    <tr> 
      <td class="blue">��������</td>
      <td><select name="opType"  id="select" onChange="chg_opType()">
          <option value="a">����</option>
          <option value="u">�޸�</option>
          <option value="d">ɾ��</option>
          <option value="q" selected>��ѯ </select> </td>
      <td class="blue">���д���</td>
      <td><input name="regionName" type="text"  id="regionName" value="<%=regionName1%>" maxlength="2" readonly  Class="InputGrey" > 
      </td>
    </tr>
    <tr> 
      <td class="blue">���ش���</td>
      <td><select name="districtCode"  id="districtCode" onChange="chg_districtCode()">
          <%
        	for(int i=0;i<districtCodeData.length; i++){
			out.println("<option class='button' value='"+districtCodeData[i][0]+"'>"+districtCodeData[i][1]+"</option>");
			}
		  %>
        </select> </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr id="showOther"> 
      <td class="blue">���д���</td>
      <td><select name="sbankCode"  id="sbankCode" onchange="chg_sbankCode()">
        </select></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr id="showAdd" > 
      <td class="blue">���д���</td>
      <td><input name="abankCode" type="text"  id="abankCode" maxlength="12" v_must=1 v_type=0_9 v_maxlength=12 v_name="���д���"> 
        <input name="abankCodeQry" type="button"  id="abankCodeQry" value="��ѯ" onClick="call_abankCodeQry()" class="b_text"> 
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td class="blue">�������д���</td>
      <td><input name="nationalCode" type="text"  id="nationalCode" maxlength="20" v_must=1 v_type=string v_minlength=1 v_name="��������"></td>
      <td class="blue">��������</td>
      <td><input name="bankName" type="text"  id="bankName" maxlength="60" v_must=1 v_type=string v_name="��������"></td>
    </tr>
    <tr> 
      <td class="blue">�� ��</td>
      <td><input name="bankPhone" type="text"  id="bankPhone" maxlength="20" v_type=phone v_name="�� ��" ></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="4" id="footer"> <div align="center" > 
          <input name="IList" type="button"  id="IList" value="�б�" onClick="DoList()" class="b_foot">
          &nbsp; 
          <input name="confirm" type="button"  value="ȷ��" onClick="commitJsp()" class="b_foot">
          &nbsp; 
          <input name="reset" type="button"  value="���" onClick="resetJsp()" class="b_foot">
          &nbsp; 
          <input name="back" onClick="removeCurrentTab()" type="button"  value="����" class="b_foot">
          &nbsp; </div></td>
    </tr>
  </table>
  <br>
   <table style="display:none" id="IList"  cellspacing="0">

 <%
 	out.println("<tr>");
 	out.println("<th align=center>���ش���</th>");
 	out.println("<th align=center>���д���</th>");
 	out.println("<th align=center>�������д���</th>");
 	out.println("<th align=center>��������</th>");
 	out.println("<th align=center>�� ��</th>");
 	out.println("</tr>");
 	String class_str="";
 	for(int i =0; i < bankDetailData.length; i++)
 	{
 			if(i%2==0)
 			class_str="Grey";
 			else
 			class_str="";
	 		out.println("<tr align=center>");
	 		out.println("<td class="+class_str+">" + bankDetailData[i][0]  +  "</td>");
	 		out.println("<td class="+class_str+">" + bankDetailData[i][1]  +  "</td>");
	 		out.println("<td class="+class_str+">" + bankDetailData[i][2]  +  "</td>");
	 		out.println("<td class="+class_str+">" + bankDetailData[i][3]  +  "</td>");
	 		if( bankDetailData[i][4]==null||bankDetailData[i][4].equals(""))
	 		out.println("<td class="+class_str+"> &nbsp;</td>");
	 	else
	 		out.println("<td class="+class_str+">" + bankDetailData[i][4]  +  "</td>");
	 		out.println("</tr>");
 	} 
 %>
   </table>
   </td>
   </tr>
   </table>

  
  	<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
  	<input type="hidden" name="loginName" id="loginName" value="">
  	<input type="hidden" name="opCode" id="opCode" value="">
  	<input type="hidden" name="orgCode" id="orgCode" value="">
  	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
  	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">
  	  	
	<input type="hidden" name="opNote" id="opNote" value="">
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
