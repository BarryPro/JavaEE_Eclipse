<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ������Ϣ��ҵ������1465
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/public/fPubPrintNote.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
  response.setDateHeader("Expires", 0);
%>
<%		
	String opCode="1465";
	String opName="������Ϣ��ҵ������";
	String phoneNo =(String)request.getParameter("phoneNo");
	String loginNo = (String)session.getAttribute("workNo");			//����
	String loginName = (String)session.getAttribute("workName");		//����
	String ip_Addr = (String)session.getAttribute("ipAddr");  		//IP��ַ
	String regionCode = (String)session.getAttribute("regCode");		//���д���
	String[][] favInfo = (String[][])session.getAttribute("favInfo");   //���ݸ�ʽΪString[0][0]---String[n][0]
%>
<%
  	String retFlag="";//�����ж�ҳ��ս���ʱ����ȷ��
//  SPubCallSvrImpl impl = new SPubCallSvrImpl();
//  ArrayList retList = new ArrayList();
 
	String strUserPassword = "";
	String func_type = request.getParameter("func_type");
	Map map = (Map)session.getAttribute("contactInfoMap");
	ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
	String passFromPage = contactInfo.getPasswdVal (2);
	System.out.println("passFromPage====================="+passFromPage);
	String[] paraAray1 = new String[5];
	paraAray1[0] = loginNo;					/* ��¼����*/ 
	paraAray1[1] = passFromPage; 			/*�û�����   */
	paraAray1[2] = "1465";	    			/*��������*/
	paraAray1[3] = phoneNo;	    			/*�ֻ�����*/
	paraAray1[4] = func_type;	    		/*���幦������*/
  
	for(int i=0; i<paraAray1.length; i++){		
	if( paraAray1[i] == null ){
			paraAray1[i] = "";
		}
	}
//	retList = impl.callFXService("s5510Init", paraAray1, "9","phone",phoneNo);
%>
	<wtc:service name="s5510Init" routerKey="region" routerValue="<%=regionCode%>" outnum="9" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=paraAray1[3]%>"/>
		<wtc:param value="<%=paraAray1[4]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	String  phone_no="";	/*�ֻ�����*/
	String  user_name="";	/*�û�����*/
	String  run_type="";	/*�û�״̬*/  
	String  sm_name="";	/*�û�Ʒ��*/   
	String  id_type="";	/*֤������*/  
	String  id_name="";	/*֤������*/ 
	String  prepayfee="";	/*Ԥ���*/   
	String  unpayfee="";	/*δ���ʻ���*/  
  
  String sm_code="",family_code="",rate_code="",bigCust_flag="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",print_note="",contract_flag="",high_flag="";
//  String[][] tempArr= new String[][]{};
	String errCode = retCode;
	String errMsg = retMsg;

  if(tempArr == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s5510Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(tempArr == null)){
  	System.out.println("errCode                          ="+errCode);
	if (errCode.equals("000000") ){
	    phone_no = tempArr[0][0];					//�ֻ�����
	    user_name = tempArr[0][3];					//�û�����
	    run_type = tempArr[0][2];					//�û�״̬
	    sm_name = tempArr[0][1];					//�û�Ʒ��
	    id_type = tempArr[0][4];					//֤������
	    id_name = tempArr[0][5];					//֤������
	    prepayfee = tempArr[0][6];					//Ԥ���
	    unpayfee = tempArr[0][7];					//δ���ʻ���
	    strUserPassword = tempArr[0][8];			//�û�����
	  }	  	  	
      else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s1460Init��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}
	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s1460Init��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}
	System.out.println("retFlag==========================================="+retFlag);
	if(retFlag.equals("1"))
	{
    %>
			<script language="JavaScript">
				rdShowMessageDialog(retMsg,0);
				history.go(-1);
			</script>
      <%
      }
  String handFee_Favourable = "readonly";        //a230  ������
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
    
	if(tempStr.compareTo(favorcode) == 0)
    {
      handFee_Favourable = "";
    }
  }
 
//******************�õ�����������***************************//
//  comImpl co=new comImpl();
  //�������� 
//  String sqlMachineType  = "";  
//  sqlMachineType  = "select machine_type ,flag from sPrepaySendMarkCode where region_code='"+ regionCode +"' and op_code='1460'" ;
//  System.out.println("sqlMachineType==" + sqlMachineType);
//  ArrayList machineTypeArr  = co.spubqry32("2",sqlMachineType );
 // String[][] machineTypeStr  = (String[][])machineTypeArr.get(0);
  //�������� 
//  String sqlOrderCode  = "";  
//  sqlOrderCode  = "select a.order_code||'~'||a.prepay_fee||'~'||a.base_fee||'~'||a.free_fee||'~'||a.consume_term||'~'||a.mon_base_fee||'~'||a.mode_code||'~'||a.machine_fee||'~'||nvl(b.flag_code,'xxxx'),  a.order_code||'~'||a.order_name,a.machine_type,a.flag  from sMachOrderCode a, (select region_code,mode_code,flag_code from sModeFlagCode where region_code='"+regionCode+"' and op_code='1460') b  where a.region_code='"+regionCode +"' and a.op_code='1460' and (a.flag='9' or (a.flag='0' and a.mode_code in (select new_mode from cBillBbChg where op_code='1460' and old_mode='"+rate_code+"' and region_code='"+regionCode+"'))  ) and  a.mode_code=b.mode_code(+) order by a.flag,a.machine_type,a.order_code";
//  System.out.println("sqlOrderCode==" + sqlOrderCode);
//  ArrayList orderCodeArr  = co.spubqry32("4",sqlOrderCode );
//  String[][] orderCodeStr  = (String[][])orderCodeArr.get(0);
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>����ҵ������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
 
<script language="JavaScript">

  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}%>

<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";	 	//����Ӫҵϵͳ������޸�

   onload=function()
  {		
	 	
  } 

  //---------1------RPC������------------------
  function doProcess(packet){
	//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg =  packet.data.findValueByName("errorMsg");
	var verifyType = packet.data.findValueByName("verifyType");
	var flag_code =  packet.data.findValueByName("flag_code");
	var flag_code_name =  packet.data.findValueByName("flag_code_name");
	var rate_code =  packet.data.findValueByName("rate_code");
	self.status="";
	if(verifyType=="confirm"){
	  if( parseInt(errorCode) == 0 ){
		 //rdShowMessageDialog("��Ϣ���أ���ȷ��!");
		 document.frm.flag_code.value=flag_code;
		 document.frm.flag_code_name.value=flag_code_name;
		 document.frm.rate_code.value=rate_code;
	  }else{
			rdShowMessageDialog("<br>������룺"+errorCode+"</br>������Ϣ��"+errorMsg);
			location="/bill/f1465.jsp";
			//return false;
	  }		
    }				
  }
  /**************/
  
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//У��
  function check()
  {
 	with(document.frm)
	{
	}
	return true;
  }


  function printCommitTwo(subButton){

	//У��
	if(!check()) 
	{
	 //   document.frm.next.disabled=false;
        return false;
	}
	setOpNote();//Ϊ��ע��ֵ
	frm.action = "f1465Confirm_1.jsp";
    //��ӡ�������ύ��
    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
        {
          document.all.printcount.value="1";
	      frmCfm();
        }
	  }
	  if(ret=="continueSub")
	  {
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
        {
          document.all.printcount.value="0";
	      frmCfm();
        }
	  }
    }
    else
    {
       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
       { 
       	 document.all.printcount.value="0";
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
	var opCode="1465" ;                   			 		//��������
	var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
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
  	cust_info+="�ͻ�������"+document.all.user_name.value+"|";
	cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
	cust_info+="�ͻ�Ʒ�ƣ�"+document.frm.sm_name.value+"|";
  	cust_info+="֤�����ͣ�: "+document.frm.id_type.value+"|";
  	cust_info+="֤�����룺: "+document.frm.id_name.value+"|";
	
    opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"�û�Ʒ��: "+document.all.sm_name.value+ "|";

	if ("01" == document.frm.func_type.value){      
  	opr_info+="����ҵ��"+"���幦��"+"  ������ˮ��"+'<%=printAccept%>'+"|";
  }else if ("02" == document.frm.func_type.value){  
  	opr_info+="����ҵ��"+"2Ԫ������Ϣ�Ѱ���"+"  ������ˮ��"+'<%=printAccept%>'+"|";
	}else if ("03" == document.frm.func_type.value){
		opr_info+="����ҵ��"+"12Ԫ������Ϣ�Ѱ���"+"  ������ˮ��"+'<%=printAccept%>'+"|";
	}else if ("04" == document.frm.func_type.value){
		opr_info+="����ҵ��"+"0Ԫ�������"+"  ������ˮ��"+'<%=printAccept%>'+"|";
	}else if ("05" == document.frm.func_type.value){
		opr_info+="����ҵ��"+"0Ԫ������Ϣ��"+"  ������ˮ��"+'<%=printAccept%>'+"|";
	} 	
 
  
  if ("02" == document.frm.func_type.value||"03" == document.frm.func_type.value){
  	note_info1+="�ƶ���˾ÿ���Ƽ�22�ײ������������¿������������5�ף�5�����ⰴ���������۸���ȡ��"+"|";
  	note_info1+="���Ƽ������������۸��շѡ�"+"|";

   }
 
  
	note_info2=" "+"|";
	note_info2+="��ע��"+document.frm.opNote.value+"|"; 
	document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
	document.all.note_info1.value=note_info1+"#";
	document.all.note_info2.value=note_info2+"#";
	document.all.note_info3.value=note_info3+"#";
	document.all.note_info4.value=note_info4+"#";
	retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;
}


 /******Ϊ��ע��ֵ********/
function setOpNote(){

	for(var i = 0 ; i < document.frm.r_cus.length ; i ++){
		if(document.frm.r_cus[i].checked)
		{
			if (i == 0){
				if ("01" == document.frm.func_type.value){      
  				document.frm.opNote.value = "�ֻ�����"+document.frm.phoneNo.value+"��ͨ����ҵ��";
				}else if ("02" == document.frm.func_type.value){  
  				document.frm.opNote.value = "�ֻ�����"+document.frm.phoneNo.value+"��ͨ2Ԫ������Ϣ�Ѱ���";
				}else if ("03" == document.frm.func_type.value){
					document.frm.opNote.value = "�ֻ�����"+document.frm.phoneNo.value+"��ͨ12Ԫ������Ϣ�Ѱ���";  
				}else if ("04" == document.frm.func_type.value){
					document.frm.opNote.value = "�ֻ�����"+document.frm.phoneNo.value+"��ͨ0Ԫ�������";  
				}else if ("05" == document.frm.func_type.value){
					document.frm.opNote.value = "�ֻ�����"+document.frm.phoneNo.value+"��ͨ0Ԫ������Ϣ��";  
				} 
			}else{
				if ("01" == document.frm.func_type.value){      
			  	document.frm.opNote.value = "�ֻ�����"+document.frm.phoneNo.value+"ȡ������ҵ��";
				}else if ("02" == document.frm.func_type.value){  
  				document.frm.opNote.value = "�ֻ�����"+document.frm.phoneNo.value+"ȡ��2Ԫ������Ϣ�Ѱ���";
				}else if ("03" == document.frm.func_type.value){
					document.frm.opNote.value = "�ֻ�����"+document.frm.phoneNo.value+"ȡ��12Ԫ������Ϣ�Ѱ���";  
				}else if ("04" == document.frm.func_type.value){
					document.frm.opNote.value = "�ֻ�����"+document.frm.phoneNo.value+"ȡ��0Ԫ�������";  
				}else if ("05" == document.frm.func_type.value){
					document.frm.opNote.value = "�ֻ�����"+document.frm.phoneNo.value+"ȡ��0Ԫ������Ϣ��";  
				} 
			}
		}
	}
	
	return true;
}
//-->
</script>

</head>

<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ҵ������</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue">��������</td>
		<td class="blue" colspan="3">
			<input type="radio" name="r_cus" index="0" value="05" checked >��ͨ
			<input type="radio" name="r_cus" index="1" value="06" >ȡ��  
		</td>
	</tr>
	
	<tr>
		<td class="blue">�ֻ�����</td>
		<td class="blue">
			<input name="phone_no" type="text" class="InputGrey" id="phone_no" value="<%=phone_no%>" readonly>			  
		</td> 
		<td class="blue">�û�����</td>
		<td>
			<input name="user_name" type="text" class="InputGrey" id="user_name" value="<%=user_name%>" readonly>			  
		</td> 
	</tr>
	
	<tr>
		<td class="blue">�û�״̬</td>
		<td>
			<input name="run_type" type="text" class="InputGrey" id="run_type" value="<%=run_type%>" readonly>
		</td>            
		<td class="blue">Ʒ������</td>
		<td>
			<input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_name%>" readonly>			  
		</td> 
	</tr>
	
	<tr> 
		<td class="blue">֤������</td>
		<td>
			<input name="id_type" type="text" class="InputGrey" id="id_type" value="<%=id_type%>" readonly>
		</td>            
		<td class="blue"> ֤������</td>
		<td>
			<input name="id_name" type="text" class="InputGrey" id="id_name" value="<%=id_name%>" readonly>
		</td>
	</tr>

	<tr> 
		<td class="blue">Ԥ���</td>
		<td>
			<input name="prepayfee" type="text" class="InputGrey" id="prepayfee" value="<%=prepayfee%>" readonly>
		</td>  
		<td class="blue">δ���ʻ���</td>
		<td>
			<input name="unpayfee" type="text" class="InputGrey" id="unpayfee" value="<%=unpayfee%>" readonly>
		</td>
	</tr>

	<tr> 
		<td class="blue">��ע</td>
		<td colspan="3">
			<input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="" onfocus="setOpNote()"> 
		</td>
	</tr> 
          
	<tr> 
		<td colspan="4" id="footer" align="center">
			&nbsp; 
			<input name="commit" id="commit" type="button" class="b_foot" value="ȷ��&��ӡ" onClick="printCommitTwo(this)">
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="���" >
			&nbsp; 
			<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
			&nbsp; 
		</td>
	</tr>
  
</table>
	  <input type="hidden" name="iOpCode">
	  <input type="hidden" name="iAddStr">
	  <input type="hidden" name="belong_code">
	  <input type="hidden" name="ip">
	  <input type="hidden" name="ipassword">
	  <input type="hidden" name="group_type">
	  <input type="hidden" name="favorcode">
	  <input type="hidden" name="maincash_no">
	  <input type="hidden" name="imain_stream">
	  <input type="hidden" name="next_main_stream">
	  <input type="hidden" name="new_rate_code">
	  <input type="hidden" name="pay_type">
	  <input type="hidden" name="flag_code_1">
	  <input type="hidden" name="order_code">
	  <input type="hidden" name="print_note" value="<%=print_note%>">
	  <input type="hidden" name="phoneNo" value="<%=phoneNo%>">
	  <input type="hidden" name="func_type" value="<%=func_type%>">
	  <input type="hidden" name="ip_Addr" value="<%=ip_Addr%>">
	  <input type="hidden" name="printAccept" value="<%=printAccept%>">
	  <input type="hidden" name="cust_info">
	  <input type="hidden" name="opr_info">
	  <input type="hidden" name="note_info1">
	  <input type="hidden" name="note_info2">
	  <input type="hidden" name="note_info3">
	  <input type="hidden" name="note_info4">
	  <input type="hidden" name="printcount">
	  <input type="hidden" name="passFromPage">
  	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<script language="JavaScript">
  <%if((high_flag.trim()).equals("Y")){%>
    rdShowMessageDialog('��ʾ: ��ע��,���û�Ϊ�и߶��û���');
  <%}%>
</script>                       
