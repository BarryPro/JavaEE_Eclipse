<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ���Ŵ߽ɶ���2280
   * �汾: 1.0
   * ����: 2008/01/13
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>���Ŵ߽ɶ���</TITLE>

<%
	String opCode="2280";
	String opName="���Ŵ߽ɶ���";
	String phoneNo = (String)request.getParameter("activePhone");			//�ֻ�����
	String workName = (String)session.getAttribute("workName");				//����
	String region_code=(String)session.getAttribute("regCode");				//��������
	Map map = (Map)session.getAttribute("contactInfoMap");
	ContactInfo contactInfo = (ContactInfo) map.get(activePhone);
	String cus_pass = contactInfo.getPasswdVal (2);								//ȡ�û�����
	//ȡϵͳ��ˮ
%>
	<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_code%>" id="loginAccept"/>
<%	
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[]{"","","","","",""};

    Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4),10),
                      (Integer.parseInt(dateStr.substring(4,6),10) - 1),Integer.parseInt(dateStr.substring(6,8),10));
	for(int i=0;i<=5;i++)
      {
	      if(i!=5)
	      {
	        mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
	        cal.add(Calendar.MONTH,-1);
	      }
	      else
	        mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
      }
%>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
</HEAD>

<body>
<SCRIPT language="JavaScript">

onload=function(){
	document.frm1109.Button2.disabled=true;
	document.all.phone_no.focus();
}

//���յ�RPC���صĲ�ѯֵ
function doProcess(packet){
	var re_errcode=packet.data.findValueByName("errcode");
	var re_user_status=packet.data.findValueByName("user_status");
	var re_card_type=packet.data.findValueByName("card_type");
	var re_card_no=packet.data.findValueByName("card_no");
	var re_user_name=packet.data.findValueByName("user_name");
    
	var re_awake_fee=packet.data.findValueByName("awake_fee");
	var re_awake_times=packet.data.findValueByName("awake_times");
	var re_calling_times=packet.data.findValueByName("calling_times");
	var re_begin_hm=packet.data.findValueByName("begin_hm");
	var re_end_hm=packet.data.findValueByName("end_hm");
	//var re_time_flag=packet.data.findValueByName("time_flag");
	var re_time_flag =0;
	var re_forbid_flag=packet.data.findValueByName("forbid_flag");
	var re_contact_address=packet.data.findValueByName("contact_address");
	var re_contact_phone=packet.data.findValueByName("contact_phone");
	
	self.status="";
	
	if (re_errcode=="0"){
		rdShowMessageDialog("��Ϣ��ѯʧ�ܣ�",0);
		return false;
	}
	else{
		rdShowMessageDialog("ȷ����Ϣ���أ���˲飡");
		
		document.frm1109.user_address.value=re_user_status;
		document.frm1109.id_type.value=re_card_type;
		document.frm1109.id_code.value=re_card_no;
		document.frm1109.user_name.value=re_user_name;
	    
		document.frm1109.awake_times.value=re_awake_times;
        document.frm1109.awake_fee.value=re_awake_fee;
        document.frm1109.calling_times.value=re_calling_times;
        document.frm1109.begin_hm.value=re_begin_hm;
		document.frm1109.end_hm.value=re_end_hm;
		document.frm1109.contact_address.value=re_contact_address;
		document.frm1109.contact_phone.value=re_contact_phone;
		//if (re_time_flag==0)
			//document.frm1109.time_flag[1].checked=true;
		//else
		//	document.frm1109.time_flag[0].checked=true;

		
		if (re_forbid_flag==0)
			document.frm1109.forbid_flag[1].checked=true;
		else
			document.frm1109.forbid_flag[0].checked=true;
			
		change();		
	}
	document.frm1109.Button2.disabled=false;
}


function doSearch(){
	//alert(document.frm1109.phone_no.value);
	var myPacket = new AJAXPacket("getUserInfo.jsp","���ڲ�ѯ�У����Ժ򡭡�");
	myPacket.data.add("phoneNo",document.frm1109.phone_no.value);
	myPacket.data.add("password","<%=cus_pass%>");
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

var temp_retCode;
var temp_retMsg;
var temp_cust_name;
var temp_cust_address;
var temp_id_type;
var temp_id_iccid;
var temp_awake_fee;
var temp_awake_times;


//�ú���ʵ���ˣ���������ӣ���XXXXҪ��д�������ȡ������XXXX������д
function change(){
	if(document.all.do_type[0].checked){
		document.all.calling_times.disabled=false;
		document.all.awake_times.disabled=false;
		document.all.awake_fee.disabled=false;
		document.all.begin_hm.disabled=false;
		document.all.end_hm.disabled=false;
		document.all.time_flag[0].disabled=false;
		document.all.time_flag[1].disabled=false;
		document.all.forbid_flag[0].disabled=false;
		document.all.forbid_flag[1].disabled=false;				
		isuse();
	}
	else{
		isuse();
	  document.all.forbid_flag[0].checked = true;
		document.all.calling_times.disabled=true;
		document.all.awake_times.disabled=true;
		document.all.awake_fee.disabled=true;
		document.all.begin_hm.disabled=true;
		document.all.end_hm.disabled=true;
		//document.all.time_flag[0].disabled=true;
		//document.all.time_flag[1].disabled=true;
		document.all.forbid_flag[0].disabled=true;
		document.all.forbid_flag[1].disabled=true;		
	}
}

function isusetime(){
    if (document.all.forbid_flag[1].checked) {
			//if (document.all.time_flag[1].checked) {
		//	document.all.begin_hm.value="0000";
		//	document.all.begin_hm.disabled=true;
		//	document.all.end_hm.value="0000";
		//	document.all.end_hm.disabled=true;
		//} else
			//{
			document.all.begin_hm.disabled=false;
			document.all.end_hm.disabled=false;
		//}

	}
}

function isuse(){
	if (document.all.forbid_flag[1].checked) {
	    document.all.begin_hm.disabled=false;
		document.all.end_hm.disabled=false;
		//document.all.time_flag[0].disabled=false;
		//document.all.time_flag[1].disabled=false;


		document.all.calling_times.disabled=false;
		document.all.awake_fee.disabled=false;
		document.all.awake_times.disabled=false;
	} else if (document.all.forbid_flag[0].checked){
		document.all.begin_hm.value="0000";
		document.all.begin_hm.disabled=true;
		document.all.end_hm.value="0000";
		document.all.end_hm.disabled=true;
		//document.all.time_flag[0].disabled=true;
		//document.all.time_flag[1].disabled=true;


		document.all.calling_times.value="0";
		document.all.awake_fee.value="0";
		document.all.awake_times.value="0";
		document.all.calling_times.disabled=true;
		document.all.awake_fee.disabled=true;
		document.all.awake_times.disabled=true;
	}
	isusetime();
}

function doCheck(){
	getAfterPrompt();
		//document.all.time_flag[0].disabled=false;
	//document.all.time_flag[1].disabled=false;
	document.all.forbid_flag[0].disabled = false;
	document.all.forbid_flag[1].disabled = false;

	if (document.all.do_type[0].checked && document.all.forbid_flag[1].checked){
		if (document.all.calling_times.value.length==0||document.all.awake_fee.value.length==0||document.all.awake_times.value.length==0){
			rdShowMessageDialog("�߽ɴ��������Ѵ��������ѷ��÷�ֵ����Ϊ�գ�");
			return false;
		}
		if (!forNonNegInt(document.all.calling_times)||!forMoney(document.all.awake_fee)||!forNonNegInt(document.all.awake_times)){
			rdShowMessageDialog("�߽ɴ��������Ѵ��������ѷ��÷�ֵ�������")
			return false;
		}
		if (parseInt(document.all.awake_times.value,10)==0||parseInt(document.all.awake_fee.value,10)==0){
			rdShowMessageDialog("���Ѵ��������ѷ��÷�ֵ����Ϊ0��")
			return false;
		}
		
		//if (document.all.time_flag[0].checked){
			if ( (document.all.begin_hm.value.length<4) || (document.all.end_hm.value.length<4) ){
				rdShowMessageDialog("ʱ���ʽ��������4λ����")
				return false;
			}
			if ((document.all.begin_hm.value)>(document.all.end_hm.value)){

	            rdShowMessageDialog("��ʼʱ�����С�ڽ���ʱ�䣡");
				return false;
			}
			if (parseInt(document.all.begin_hm.value.substring(0,2),10)>23||parseInt(document.all.end_hm.value.substring(0,2),10)>23){
				rdShowMessageDialog("��ʼʱ��ͽ���ʱ���Сʱ��(ǰ��λ)����С��24��")
				return false;
			}
			if (parseInt(document.all.begin_hm.value.substring(2,4),10)>59||parseInt(document.all.end_hm.value.substring(2,4),10)>59){
				rdShowMessageDialog("��ʼʱ��ͽ���ʱ��ķ�����(����λ)����С��60��")
				return false;
			}			
		//}
			
	}
		
	document.frm1109.action="f2280_confirm.jsp";
	//frm1109.submit();
	//return true;	

//--------------add by notturno begin
	 var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
      
    // if(typeof(ret)!="undefined")
    //{
     if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
        {
            
	      frm1109.submit();
        }
	  if(ret=="remark")
	  {
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
        {
	      frm1109.submit();
        }
		else
		{
					//document.all.time_flag[0].disabled=true;
					//document.all.time_flag[1].disabled=true;
					document.all.forbid_flag[0].disabled = true;
					document.all.forbid_flag[1].disabled = true;

	   }
    }
}
    else
    {
       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
       {
	     frm1109.submit();
       }
		   else
		   {
			    //document.all.time_flag[0].disabled=true;
				//document.all.time_flag[1].disabled=true;
				document.all.forbid_flag[0].disabled = true;
				document.all.forbid_flag[1].disabled = true;
    }	
}
}
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի��� 
     var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
	var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=loginAccept%>;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode="2280" ;                   			 		//��������
	var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;   
  }

  function printInfo(printType)
  {
     //   var   opType = document.all.Sel_Favour_name.options[document.all.Sel_Favour_name.options.selectedIndex].value;

    var cust_info="";  				//�ͻ���Ϣ
	var opr_info="";   				//������Ϣ
	var note_info1=""; 				//��ע1
	var note_info2=""; 				//��ע2
	var note_info3=""; 				//��ע3
	var note_info4=""; 				//��ע4
	var retInfo = "";  				//��ӡ����
    
    opr_info+='<%=workName%>'+"|";
    opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|"; 
   	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
    cust_info+="�ͻ�������"+document.all.user_name.value+"|";  
    cust_info+="֤�����룺"+document.all.id_code.value+"|";
    cust_info+="�ͻ���ַ��"+document.all.contact_address.value+ "|";
    cust_info+="��ϵ�˵绰��"+document.all.contact_phone.value + "|";

    opr_info+="���뺬��ֵ�߷Ѷ���ҵ��|";
	opr_info+="������ˮ:"+document.all.loginAccept.value + "|";
    opr_info+=document.all.awake_fee.value +"�����ռ��ʻ��е�ǰ���û������(Ԥ���-δ���˻���)С�ڵ��ڷ�ֵʱ,���㷢�ʹ߷Ѷ���.|";
    note_info1+="��ע��";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
  }
//--------------add by notturno end


function doReset(){
	frm1109.reset();
	document.frm1109.Button1.disabled=false;
	//document.frm1109.Button2.disabled=true;
	document.all.phone_no.disabled=false;
	document.frm1109.phone_no.focus();
}

function do_switch()
{
	if(document.all.forbid_switch[0].checked)
	{
		document.all.forbid_flag[0].value = '1';
//		document.all.forbid_flag[1].value = '0';
	}
	else if(document.all.forbid_switch[1].checked)
	{
		document.all.forbid_flag[0].value = '2';
//		document.all.forbid_flag[1].value = '0';
	}
	else
	{
		alert("error");
	}
	//alert(document.all.forbid_flag[0].value);
	//alert(document.all.forbid_flag[1].value);
	//alert(document.all.forbid_flag[0].value);
//	alert(document.all.forbid_flag[1].value);
}


</SCRIPT>

<FORM method=post name="frm1109" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">���Ŵ߽ɶ���</div>
	</div>
<table cellspacing="0">
		<tr>
	    		 <TD class="blue" colspan="2"><input type="radio" name="forbid_switch" id="forbid_switch" value="0" checked onclick="do_switch()"/>��ͨ����</TD>
		 <TD class="blue" colspan="2"><input type="radio" name="forbid_switch" id="forbid_switch" value="1" onclick="do_switch()" />�������</TD>

	  </tr>

	<tr>
		<TD class="blue">��������</TD>
		<TD class="blue">
			<input type="radio" name="do_type" id="do_type" value="0" checked onclick="change()"/>����</TD>
		<TD colspan="2" class="blue">
			<input type="radio" name="do_type" id="do_type" value="1" onclick="change()" />ɾ��</TD>
	</tr>

	<TR> 
		<TD class="blue">�ֻ�����</TD>
		<TD colspan="3">
			<input type="text" class="InputGrey" readOnly name="phone_no" id="phone_no" value="<%=phoneNo%>" v_type=int maxlength="11" onKeyDown="if(event.keyCode==13) doSearch();" >
			<input type="button" class="b_text" name="Button1" value="У��" onclick="doSearch()">
		</td>	
	</TR>
	<TR> 
		<TD class="blue">�ͻ�����</TD>        
		<TD>
			<input class="InputGrey" name="user_name" size="20" maxlength="8" readonly >
		</TD>   
		<TD class="blue">��ǰ״̬</TD>          
		<TD>
			<input readonly class="InputGrey" name="user_address" size="20" maxlength="8" >
		</TD>
	</TR>
	<TR> 
		<TD class="blue">֤������</TD>
		<TD>
			<input readonly class="InputGrey" name="id_type" size="20" maxlength="6">
		</TD>
		<TD class="blue">֤������</TD>
		<TD>
			<input readonly  class="InputGrey" name="id_code" size="20" maxlength="8" >
		</TD>
	</TR>
		
	<TR> 
		<TD class="blue">���Ѵ���</TD>
		<TD>
			<input class="button" name="awake_times" size="20" maxlength="8">
		</TD>
		<TD class="blue">���ѷ��÷�ֵ</TD>
		<TD>
			<input class="button" name="awake_fee" size="20" maxlength="6">
		</TD>
	</TR>
	<TR> 
		<TD class="blue">�߽ɴ���</TD>
		<TD colspan="3">
			<input class="button" name="calling_times" size="20" maxlength="6">
		</TD>
	</TR>
	<TR> 
		<TD class="blue">��ʼʱ��</TD>
		<TD>
			<input class="button" name="begin_hm" size="20" maxlength="4">(4λ���֣���ʾСʱ�ͷ���)
		</TD>
		<TD class="blue">����ʱ��</TD>
		<TD>
			<input class="button" name="end_hm" size="20" maxlength="4">(4λ���֣���ʾСʱ�ͷ���)
		</TD>
	</TR>
	<TR> 
		<TD class="blue">��������/�߽�ʱ��</TD>  
		<TD>
			<input type="radio" name="time_flag" id="time_flag" value="1" checked onclick="isusetime()"/>��
			<input type="radio" name="time_flag" id="time_flag" value="0" onclick="isusetime()"/>��
		</TD>
		<TD class="blue">��ֹ����/�߽�</TD>
		<TD>
			<input type="radio" name="forbid_flag" id="forbid_flag" value="1" checked onclick="isuse()"/>��
			<input type="radio" name="forbid_flag" id="forbid_flag" value="0" onclick="isuse()"/>��
		</TD>
	</TR>
		
	<TR> 
		<TD class="blue">��ע</TD>
		<TD colspan="3"><input type="text" class="InputGrey" readOnly name="note" value="" size="35"></TD>
		<TD><input class="button" type="hidden" name="busy_type" id="busy_type" ></TD>
	</TR>
		<input type="hidden" name="contact_address"  value="">
		<input type="hidden" name="contact_phone"  value="">
		<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
		<input type="hidden" name="region_code" value="<%=region_code%>">
	<tr> 
		<td align="center" id="footer" colspan="4">
			&nbsp; <input class="b_foot" name="Button2" id="Button2" type="button" onClick="doCheck()" value="  ȷ ��  " >
			&nbsp; <input class="b_foot" name="Button3" id="Button3" type="button" onClick="doReset()" value="  �� ��  " >
			&nbsp; <input class="b_foot" name="back" onClick="removeCurrentTab()" type=button value="�� ��">
		</td>
	</tr>
</table>
       <%@ include file="/npage/include/footer.jsp" %>

</FORM>
  <OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>
</BODY></HTML>
<!--***********************************************************************-->
