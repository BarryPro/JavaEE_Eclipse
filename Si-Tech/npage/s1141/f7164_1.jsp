<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: "ũ��ͨ"����Ӫ���7164
   * �汾: 1.0
   * ����: 2009/1/13
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%		
	String opCode=request.getParameter("opCode");	
	String opName=request.getParameter("opName");	
	String loginNo = (String)session.getAttribute("workNo");				//��������
	String loginName = (String)session.getAttribute("workName");			//��������
	String regionCode = (String)session.getAttribute("regCode");			//���д���
	String phoneNo = request.getParameter("srv_no");						//�ֻ�����
  	String opcode = request.getParameter("opcode");							//��������
  	
	String retFlag="",retMsg="";
	String passwordFromSer="";
	String[] paraAray1 = new String[3];
	paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
	paraAray1[1] = opcode; 	    /* ��������   */
	paraAray1[2] = loginNo;	    /* ��������   */
	
	for(int i=0; i<paraAray1.length; i++)
	{		
		if( paraAray1[i] == null )
		{
			paraAray1[i] = "";
		}
	}
 /* ��������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ�
 			�����أ���ǰ״̬��VIP���𣬵�ǰ����,����Ԥ��
 */
%>
	<wtc:service name="s7160Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="15" retcode="retCode" retmsg="retMsg1">
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String errCode = retCode;
  String errMsg = retMsg1;
  if(tempArr == null)
  {
  	System.out.println("retFlagaaaaaaaaaaaaaaaaaa="+retFlag);
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s7160Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(tempArr == null))
  {
	  System.out.println("errCode="+errCode);
	  System.out.println("retFlagbbbbbbbbbbbbbbbbbbbbb="+retFlag);
	  System.out.println("errMsg="+errMsg);
	  if(!errCode.equals("000000") ){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
  <%}
	if (errCode.equals("000000") ){
	    bp_name = tempArr[0][2];//��������
	    System.out.println(bp_name);
	    bp_add = tempArr[0][3];//�ͻ���ַ
	    cardId_type = tempArr[0][4];//֤������
	    cardId_no = tempArr[0][5];//֤������
	    sm_code = tempArr[0][6];//ҵ��Ʒ��
	    region_name = tempArr[0][7];//������
	    run_name = tempArr[0][8];//��ǰ״̬
	    vip = tempArr[0][9];//�֣ɣм���
	    posint = tempArr[0][10];//��ǰ����
	    prepay_fee = tempArr[0][11];//����Ԥ��
	    passwordFromSer = tempArr[0][12];//����Ԥ��
	  }
	}
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>
<%
//******************�õ�����������***************************//
  //ҵ������
  String sqlAgentCode = " select opr_code,opr_name,opr_money,effect_month from sSpOprCfg where op_code='"+opcode+"' and valid_flag='Y' ";
  System.out.println("sqlAgentCode====="+sqlAgentCode);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode1" retmsg="retMsg2">
		<wtc:sql><%=sqlAgentCode%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="agentCodeStr" scope="end" />
<%  
  //��Ʒ����
  String sqlGiftCode = " select gift_code,gift_name from sAwardOprCfg where op_code='"+opcode+"' and valid_flag='Y'";
  System.out.println("sqlGiftCode====="+sqlGiftCode);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode2" retmsg="retMsg3">
		<wtc:sql><%=sqlGiftCode%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="giftCodeStr" scope="end" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>"ũ��ͨ"����Ӫ���</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
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
  
  var arrpapercode =new Array();
  var arrpapername=new Array();
  var arrpapermoney=new Array();
  var arrspcode=new Array();
  var arropercode=new Array();
  var arrawardcode=new Array();
  var arrawarddetailcode=new Array();
  var arrgiftcode=new Array();
  var arrconsumeterm=new Array();
  var arrservercode=new Array();
 
<%  
  for(int i=0;i<agentCodeStr.length;i++)
  {
	out.println("arrpapercode["+i+"]='"+agentCodeStr[i][0]+"';\n");
	out.println("arrpapername["+i+"]='"+agentCodeStr[i][1]+"';\n");
	out.println("arrpapermoney["+i+"]='"+agentCodeStr[i][2]+"';\n");
	out.println("arrconsumeterm["+i+"]='"+agentCodeStr[i][3]+"';\n");
  }  
 
%>

onload=function initLoad(){
	var op_code=<%=opcode%>;
	if(op_code=="7176"){
		document.all.type_7164.style.display="none";
		document.all.type_7176.style.display="block";
		document.all.giftcodeid.style.display="none";
		document.all.opNote.value="'����ũ��ͨ'����Ӫ���";
	}else{
		document.all.type_7164.style.display="block";
		document.all.type_7176.style.display="none";
		document.all.opNote.value="'ũ��ͨ'����Ӫ���";

	}
}
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***IMEI ����У��
 
 function printCommit()
 { 
 	getAfterPrompt();
  //У��
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("����������!");
      cust_name.focus();
	  return false;
	}
	
	if(prepay_fee.value-paper_money.value<0){
		rdShowMessageDialog("Ԥ��������ҵ�����Ƚɷ�!");
		return false;
	}
	 }
 //��ӡ�������ύ��
  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
      {
	    frmCfm();
      }
	}
	if(ret=="continueSub")
	{
      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
      {
	    frmCfm();
      }
	}
  }
  else
  {
     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
     {
	   frmCfm();
     }
  }
  return true;
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   	var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=printAccept%>;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode="7164" ;                   			 		//��������
	var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰
   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phone_no.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;        
}

function printInfo(printType)
{
	var cust_info="";  				//�ͻ���Ϣ
	var opr_info="";   				//������Ϣ
	var note_info1=""; 				//��ע1
	var note_info2=""; 				//��ע2
	var note_info3=""; 				//��ע3
	var note_info4=""; 				//��ע4
	var retInfo = "";  				//��ӡ����
	
	var op_code = '<%=opcode%>';
	if(op_code=="7164"){
		var opname="";
		if(document.all.op_type.value=="0"){
			opname="����";
		}else{
			opname="������";
		}
  
		opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
		opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
		cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
		cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
		cust_info+="֤�����룺"+document.all.cardId_no.value+"|";

		opr_info+="�û�Ʒ��:"+"<%=sm_code%>" +"              ҵ�����ͣ�ũ��ͨ"+opname+"|";
  		opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  		if(document.all.op_type.value=="0"){
			note_info1+="��Ʒ���ƣ�"+document.all.gift_code.options[document.all.gift_code.selectedIndex].text+"|";
		}
		opr_info+="ҵ�����ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		opr_info+="��תԤ�滰�ѣ�"+document.all.paper_money.value+" Ԫ"+"|";
		opr_info+="ר��Ԥ�滰�����ޣ�"+document.all.consume_term.value+" ����"+"|";

  		note_info2+="ע����������ΰ���ũ��ͨ��ҵ��������ý�ֱ�Ӵ���ԭ��Ԥ�滰���п۳����������Ԥ�滰�Ѳ������Ƚ������Ԥ�滰�ѡ������ζ����ġ�ũ��ͨ��ҵ��ԭ������������Чԭ��ִ�С�������ת����ֻ�ܳ�������ΰ���ġ�ũ��ͨ��ҵ���������ķ��ã����ܳ������ҵ���������ķ��ã�������ת�����԰���ҵ�����������ھŸ���ĩ��ʣ�ཫȫ�����㡣���ΰ���ġ�ũ��ͨ��ҵ����ǰȡ�������ò��˻���ҵ���ں���������ȡ����ȡ�����С�ũ��ͨ��ҵ�񣺷��Ͷ��š�00000����12582��ȡ�����ũ��ͨ��ҵ�񣺷��Ͷ��š�0000����12582��"+"|";	

	}else{
		opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
		opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
		cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
		cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
		cust_info+="֤�����룺"+document.all.cardId_no.value+"|";

		retInfo+=" "+"|";
		opr_info+="�û�Ʒ��:"+"<%=sm_code%>" +"              ҵ�����ͣ�����ũ��ͨ������|";
  		opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
		opr_info+="ҵ�����ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		opr_info+="��תԤ�滰�ѣ�"+document.all.paper_money.value+" Ԫ"+"|";
		opr_info+="ר��Ԥ�滰�����ޣ�"+document.all.consume_term.value+" ����"+"|";

  		note_info4+="ע����������ΰ���ũ��ͨ��ҵ��������ý�ֱ�Ӵ���ԭ��Ԥ�滰���п۳����������Ԥ�滰�Ѳ������Ƚ������Ԥ�滰�ѡ������ζ����ġ�ũ��ͨ��ҵ��ԭ������������Чԭ��ִ�С�������ת����ֻ�ܳ�������ΰ���ġ�ũ��ͨ��ҵ���������ķ��ã����ܳ������ҵ���������ķ��ã�������ת�����԰���ҵ������������12����ĩ��ʣ�ཫȫ�����㡣����ͨҵ����ǰȡ�������ò��˻���ҵ���ں���������ȡ����"+"|";	
	}
    retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
}



//-->
</script>

<script language="JavaScript">
<!--
/****************����agent_code��̬����phone_type������************************/
 function selectChange()
 {
 	document.all.paper_money.value="";
 	document.all.consume_term.value="";
 	
  for ( x1 = 0 ; x1 < arrpapermoney.length  ; x1++ )
   	{
      		if ( arrpapercode[x1] == document.all.paper_code.value)
      		{
        				document.all.paper_money.value=arrpapermoney[x1] ;
        				//alert(document.all.paper_money.value);
        				document.all.consume_term.value=arrconsumeterm[x1] ;
        				
      		}
   	}
 } 
 
 function opTypeChang(){
 	//alert(document.all.op_type.value);
 	if(document.all.op_type.value=="0"){
 		document.all.giftcodeid.style.display = "";
 		
 	}else{
 		document.all.giftcodeid.style.display = "none";
 	}
}
//-->
</script>

</head>

<body>
<form name="frm" method="post" action="f7164Cfm.jsp?opCode=<%=opCode%>&opName=<%=opName%>" onKeyUp="chgFocus(frm)" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">"ũ��ͨ"����Ӫ���</div>
	</div>
<table cellspacing="0">
	<tr id="type_7164"> 
		<td class="blue">��������</td>
		<td colspan="3">
			<select name="op_type" onchange="opTypeChang()">
				<option value ="0">����</option>
				<option value ="1">������</option>
			</select>
		</td>
	</tr>
	<tr id="type_7176"> 
		<td class="blue">��������</td>
		<td colspan="3">
			<select name="op_type_7176" >
				<option value ="1" >������</option>
			</select>
		</td>
	</tr>
	<tr> 
		<td class="blue">�ͻ�����</td>
		<td>
			<input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20"> 
			<font color="orange">*</font>
		</td>
		<td class="blue">�ͻ���ַ</td>
		<td>
			<input name="cust_addr" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="20" size="40"> 
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td class="blue">֤������</td>
		<td>
			<input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" > 
			<font color="orange">*</font>
		</td>
		<td class="blue">֤������</td>
		<td>
			<input name="cardId_no" value="<%=cardId_no%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" > 
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td class="blue">ҵ��Ʒ��</td>
		<td>
			<input name="sm_code" value="<%=sm_code%>" type="text" class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" > 
			<font color="orange">*</font>
		</td>
		<td class="blue">����״̬</td>
		<td>
			<input name="run_type" value="<%=run_name%>" type="text" class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" > 
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
	<td class="blue">VIP����</td>
	<td>
		<input name="vip" value="<%=vip%>" type="text" class="InputGrey" v_must=1 readonly id="vip" maxlength="20" > 
		<font color="orange">*</font>
	</td>
	<td class="blue">����Ԥ��</td>
	<td>
		<input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" > 
		<font color="orange">*</font>
	</td>
	</tr>
	<tr> 
	<td class="blue">ҵ������</td>
	<td>
		<SELECT id="paper_code" name="paper_code" v_must=1  onchange="selectChange();">  
			<%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
			<option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
			<%}%>
		</select>
		<font color="orange">*</font>	
	</td>
	<td class="blue">ҵ����</td>
	<td >
		<input name="paper_money" type="text" class="InputGrey" id="paper_money" v_type="money" v_must=1 readonly>
		<font color="orange">*</font>	
	</td>
	</tr>
	<tr id="giftcodeid"> 
		<td class="blue">��Ʒ����</td>
		<td colspan="3">
			<SELECT id="gift_code" name="gift_code" v_must=1>  
				<%for(int i = 0 ; i < giftCodeStr.length ; i ++){%>
				<option value="<%=giftCodeStr[i][0]%>"><%=giftCodeStr[i][1]%></option>
				<%}%>
			</select>
			<font color="orange">*</font>	
		</td>
	</tr>
     
	<tr> 
		<td class="blue">��ע</td>
		<td colspan="3">
			<input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="" > 
		</td>
	</tr>
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()"  >
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="���" >
			&nbsp; 
			<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
			&nbsp; </div>
		</td>
	</tr>
</table>	
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
	<input type="hidden" name="op_type_1776"  value="">
    <input type="hidden" name="consume_term">
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<script>
	selectChange();
</script>
</html>
