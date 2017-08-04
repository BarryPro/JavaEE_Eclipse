<%
/********************
 * version v2.0
 * ������: si-tech
 * update by wangjya @ 2009-04-14
 ********************/
%>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="../../npage/public/fPubPrintNote.jsp" %>

<%		
    String opCode = (String)request.getParameter("opcode");
    String opName = "�Ų��ܼҰ�������";
    String loginNo = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String regionCode = orgCode.substring(0,2);
    
    System.out.println("opName="+opName);
%>
<%
    String retFlag="";

    String[] paraAray1 = new String[3];
    String phoneNo = request.getParameter("srv_no");
    
    paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
    paraAray1[1] = loginNo;	    /* ��������   */
    paraAray1[2] = opCode; 	    /* ��������   */
	for(int i=0; i<paraAray1.length; i++)
	{		
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		  
		}
	}

 /* ��������� �����룬������Ϣ���ͻ�����, �ͻ���ַ,֤������,֤������,ҵ��Ʒ��
		  �����أ���ǰ״̬��VIP���� ����ǰ����, �û�Ԥ�� �����Ƿ��������
 */

 
%>
	<wtc:service name="s6907Query" routerKey="phone" routerValue="<%=phoneNo%>" retcode="errCode" retmsg="errMsg" outnum="13">
		<wtc:param value="<%=paraAray1[0]%>"/> 
		<wtc:param value="<%=paraAray1[1]%>"/> 
	    <wtc:param value="<%=paraAray1[2]%>"/> 
	</wtc:service>
	<wtc:array id="s6907QryArr" scope="end" />
<%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",favour_name="",favour_type="";
  if(!errCode.equals("000000"))
  {
   %>
	<script language="JavaScript">
  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
    history.go(-1);
	</script>
	<%		
		return;				 			   
  }
  else 
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
	if(!(s6907QryArr[0][2].equals("")))
	{
		bp_name = s6907QryArr[0][2];//��������
		System.out.println(bp_name);
	}
	if(!(s6907QryArr[0][3].equals("")))
	{
		bp_add = s6907QryArr[0][3];//�ͻ���ַ
	}
	if(!(s6907QryArr[0][4].equals("")))
	{
		cardId_type = s6907QryArr[0][4];//֤������
	}
	if(!(s6907QryArr[0][5].equals("")))
	{
		cardId_no = s6907QryArr[0][5];//֤������
	}
	
	if(!(s6907QryArr[0][6].equals("")))
	{
		sm_code = s6907QryArr[0][6];//ҵ��Ʒ��
	}
	
	if(!(s6907QryArr[0][7].equals("")))
	{
		region_name = s6907QryArr[0][7];//������
	}
	
	if(!(s6907QryArr[0][8].equals("")))
	{
		run_name = s6907QryArr[0][8];//��ǰ״̬
	}
	
	if(!(s6907QryArr[0][9].equals("")))
	{
		vip = s6907QryArr[0][9];//�֣ɣм���
	}
	
	if(!(s6907QryArr[0][10].equals("")))
	{
		posint = s6907QryArr[0][10];//��ǰ����
	}	
	if(!(s6907QryArr[0][11].equals("")))
	{
		prepay_fee = s6907QryArr[0][11];//����Ԥ��
	}
	if(!(s6907QryArr[0][12].equals("")))
	{
		favour_type = s6907QryArr[0][12];
		if(0 == Integer.parseInt(s6907QryArr[0][12].trim()))//�Ƿ���������Ż� 0����������� 
		{
			favour_name = "��";
		}
		else
		{
			favour_name = "��";
		}
	}
	
  }
  
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�Ų��ܼҰ�������</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language="JavaScript">

<!--
  //����Ӧ��ȫ�ֵı���
  /*var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  var arrPhoneType = new Array();//�ֻ��ͺŴ���
  var arrPhoneName = new Array();//�ֻ��ͺ�����
  var arrAgentCode = new Array();//�����̴���
  var selectStatus = 0;
  
  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();
  
  var arrprint1=new Array();
  var arrprint2=new Array();
  var arrprintbrand=new Array();
  var arrprinttype=new Array();*/
  

	
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***
 function printCommit()
 { 
    getAfterPrompt();
	with(document.frm)
	{
		opNote.value=phone_no.value+"�Ų��ܼҰ����û�����";
	}
 //��ӡ�������ύ��
  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
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
{     
   var h=198;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var pType="subprint";
   var billType="1";
   var sysAccept = "<%=printAccept%>";
   var mode_code = null;
   var fav_code = null;
   var area_code = null;
   var printStr = printInfo(printType);
   var phoneno = "<%=phoneNo%>";
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
   var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneno+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
  
}

function printInfo(printType)
{
  

  	var retInfo = "";
  	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";


	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";

	
	opr_info+="�û�Ʒ�ƣ�"+document.all.sm_code.value+ "  "+"����ҵ�񣺺Ų��ܼҰ�������"+"|";
	opr_info+="������ˮ��"+document.all.login_accept.value+"|";
	opr_info+="ҵ�����ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	opr_info+="ҵ����Чʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	opr_info+="ҵ���ڹ��� ҵ����ת����" + "|";
	

	
	note_info1+="ָ���ʷ�������"+"|";
	<% if(favour_name.equals("��"))
	{
	%>
	note_info2+="����������ѣ������շѣ�3Ԫ/�£����鵱���˶�����ҵ���ܷѡ�" +"|";                           
	<%	
	}
	else{
	%>
	note_info2+="��ͨ���¿�ʼ�շѣ�3Ԫ/�¡�"+"|";
	<%}%>
	
    document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
	document.all.note_info1.value=note_info1+"#";
	document.all.note_info2.value=note_info2+"#";

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
}



//-->
</script>

</head>
<body>
<form name="frm" method="post" action="f6907_2.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�Ų��ܼҰ�������</div>
</div>

<table cellspacing="0" >
    <tr> 
        <td class=blue>��������</td>
        <td colspan=3>�Ų��ܼҰ�������</td>
        </tr>
        <tr> 
        <td class=blue>�ͻ�����</td>
        <td>
            <input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="����"> 
        </td>
        <td class=blue>�ͻ���ַ</td>
        <td>
            <input name="cust_addr" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="30" > 
        </td>
    </tr>
    <tr> 
        <td class=blue>֤������</td>
        <td>
            <input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" > 
        </td>
        <td class=blue>֤������</td>
        <td>
            <input name="cardId_no" value="<%=cardId_no%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" > 
        </td>
    </tr>
    <tr> 
        <td class=blue>ҵ��Ʒ��</td>
        <td>
            <input name="sm_code" value="<%=sm_code%>" type="text" class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" > 
        </td>
        <td class=blue>����״̬</td>
        <td>
            <input name="run_type" value="<%=run_name%>" type="text" class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" > 
        </td>
    </tr>
    <tr> 
        <td class=blue>VIP����</td>
        <td>
            <input name="vip" value="<%=vip%>" type="text" class="InputGrey" v_must=1 readonly id="vip" maxlength="20" > 
        </td>
        <td class=blue>����Ԥ��</td>
        <td>
            <input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" > 
        </td>
    </tr>
    <tr> 
        <td class=blue>�û�����</td>
        <td>
            <input name="user_type" value="�Ų��ܼҰ���" type="text" class="InputGrey" v_must=1 readonly id="user_type" maxlength="20" > 	
        </td>
        <td class=blue>�����������</td>
        <td><%=favour_name%></td>
    </tr>    
    <tr> 
        <td class=blue>��ע</td>
        <td colspan="3" >
            <input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="�Ų��ܼҰ�������" > 
        </td>
    </tr>
    <tr id="footer"> 
        <td colspan="4">
            <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()"  >
            <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
        </td>
    </tr>
</table>

<input type="hidden" name="phone_no" value="<%=phoneNo%>">
<input type="hidden" name="work_no" value="<%=loginNo%>">
<input type="hidden" name="login_accept" value="<%=printAccept%>">
<input type="hidden" name="card_dz" >
<input type="hidden" name="used_point" value="0" >
<input type="hidden" name="point_money" value="0" >
<input type="hidden" name="opcode" value="<%=opCode%>">
<input type="hidden" name="sale_type" value="7" >
<input type="hidden" name="phone_typename" >
<input type="hidden" name="gift_name" >
<input type="hidden" name="card_type" >
<input type="hidden" name="cardy" >
<input type="hidden" name="print1" >
<input type="hidden" name="print2" >
<input type="hidden" name="cust_info">
<input type="hidden" name="opr_info">
<input type="hidden" name="note_info1">
<input type="hidden" name="note_info2">
<input type="hidden" name="note_info3">
<input type="hidden" name="note_info4">
<input type="hidden" name="printcount">
<input type="hidden" name="favour_type" value="<%=favour_type%>">
<input type="hidden" name="ip_Addr" value="<%=ip_Addr%>">
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>


