   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-23
********************/
%>
              
<%
  String opCode = "1451";
  String opName = "�����ʵ�����";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
    String loginName = (String)session.getAttribute("workName");
String regionCode = (String)session.getAttribute("regCode");

	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));

	String dirtPage=request.getParameter("dirtPage");

String accountType = (String)session.getAttribute("accountType");

//----------------------------------------------------------
  
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl_t" /> 


<%

String  sysAcceptl =sysAcceptl_t;
  request.setCharacterEncoding("GBK");

  HashMap hm=new HashMap();
  hm.put("1","û�пͻ�ID��");
  hm.put("3","�������");
  hm.put("4","�����Ѳ�ȷ���������ܽ����κβ�����");
  
  hm.put("2","δȡ������1����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("10","δȡ������2����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("11","δȡ������3����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("12","δȡ������4����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("13","δȡ������5����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("14","δȡ������6����˲����ݻ���ѯϵͳ����Ա��");
  String op_name="";
  String op_code = request.getParameter("op_code");
  //System.out.println("op_code === "+ op_code );
  //op_code="1250";
 
  if(op_code.equals("1220"))
    op_name="�������";
  else if(op_code.equals("1217"))
    op_name="Ԥ���ָ�";
  else if(op_code.equals("1260"))
    op_name="Ԥ��ָ�";
  else if(op_code.equals("2419"))
    op_name="����ת��ҵ������";
  else if(op_code.equals("1296"))
    op_name="���еش�����ת��";
  else if(op_code.equals("1250"))
    op_name="���ֶҽ�";
  else if(op_code.equals("1221"))
    op_name="��������";
  else if(op_code.equals("1353"))
    op_name="��������";
  else if(op_code.equals("1290"))
    op_name="���֤��ʧ";
  else if(op_code.equals("1291"))
    op_name="�ֻ�֤ȯ����";
  else if(op_code.equals("1295"))
    op_name="������";
  else if(op_code.equals("1299"))
    op_name="���еش�Mֵ�һ�";
  else if(op_code.equals("2420"))
    op_name="����ת��ҵ�����";
  else if(op_code.equals("2421"))
    op_name="�ĺ�֪ͨҵ��";
  else if(op_code.equals("1442"))
    op_name="SIM��Ӫ��";
  else if(op_code.equals("1445"))
    op_name="ȫ��ͨǩԼ�ƻ�";
  else if(op_code.equals("1448"))
    op_name="�ʼ��ʵ�";
  else if(op_code.equals("7114"))
    op_name="�굥��ѯ��������";
  else if(op_code.equals("1458"))
    op_name="��Ϣ�ռ�";
  else if(op_code.equals("1469"))
    op_name="ȫ��spҵ���˷�";
  else if(op_code.equals("7115"))
    op_name="����绰��ѻ���";
  else if(op_code.equals("2299"))
    op_name="�������֤����������";
  else if(op_code.equals("1499"))
    op_name="����ҵ�񸶽�����ά��";
  else if(op_code.equals("1451"))
    op_name="�����ʵ�����";
  else if(op_code.equals("1452"))
    op_name="�������֤";
  else if(op_code.equals("5036"))
    op_name="�ͷ�ϵͳ�ײ�����";
  else if(op_code.equals("5037"))
    op_name="������ò�ѯ";
  else if(op_code.equals("1577"))
    op_name="���ź˼컰����ѯ";
  else if(op_code.equals("1446"))
    op_name="�ĺ�֪ͨ";
  else if(op_code.equals("1440"))
    op_name="��ҵ��ҽ�";
  else if(op_code.equals("5118"))
    op_name="����ҵ�񸶽�";
  else if(op_code.equals("1449"))
    op_name="ȫ��ͨǩԼ�ƻ�����";
  else if(op_code.equals("1450"))
    op_name="���ֶһ�����";
  else if(op_code.equals("1443"))
    op_name="�ļ�����";
  else if(op_code.equals("2267"))
    op_name="�ֻ��û�ʵ��Ԥ�Ǽǲ�ѯ/ȷ��";
  else if(op_code.equals("2266"))
    op_name="����Ʒͳһ����";
  else if(op_code.equals("2849"))
    op_name="�������ż��ŷ��������Ϣ��ѯ";
  else if(op_code.equals("5303"))
    op_name="���ŵ�½������������";
  else if(op_code.equals("5309"))
    op_name="���ŵ�½��������������ʷ��ѯ";
%>


<html>
<head>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>


<title><%=op_name%></title>

<!-------------------------------------------->
<!---����:  2005-11-22                    ---->
<!---����:  ����                          ---->
<!---����:  f1451.jsp                     ---->
<!---���� Email����                     ---->
<!---�޸�                               ---->
<!-------------------------------------------->

<script language=javascript>
<!--
 
  onload=function()
  {
    	self.status="";
  }
 
function simChk()
{
 
  var myPacket = new AJAXPacket("postSimEmail.jsp","���ڲ�ѯ�ͻ������Ժ�......");
	myPacket.data.add("phoneNo",(document.all.phoneno.value).trim());
	myPacket.data.add("opCode",(document.all.op_code.value).trim());
	for(var i = 0 ; i < document.all.r_cus.length ; i ++){
	if(document.all.r_cus[i].checked){
			var value = document.all.r_cus[i].value;
			myPacket.data.add("r_cus",(value).trim());
		}
	}
	core.ajax.sendPacket(myPacket);
	myPacket = null;
  }


 //--------4---------doProcess����----------------
function doProcess(packet)
{
 	var vRetPage=packet.data.findValueByName("rpc_page");  
	var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");

	var mail_address1 = packet.data.findValueByName("mail_address1");
	var mail_address2 = packet.data.findValueByName("mail_address2");
	var mail_address3 = packet.data.findValueByName("mail_address3");
	var cust_iccid = packet.data.findValueByName("cust_iccid");
	var cust_name = packet.data.findValueByName("cust_name");
	var has_paper_bill = packet.data.findValueByName("has_paper_bill");
	
	if(retCode == "000000"){
		if(mail_address1!="NULL")
		document.all.mail_address1.value = mail_address1;
		/*if(mail_address2!="NULL")
		document.all.mail_address2.value = mail_address2;
		if(mail_address3!="NULL")
		document.all.mail_address3.value = mail_address3;
		by wangdx 2009.7.7*/
		document.all.cust_iccid.value = cust_iccid;
		document.all.cust_name.value = cust_name;
		document.all.confirm.disabled=false;
		if (has_paper_bill == "1" &&(	document.all.r_cus[0].checked||document.all.r_cus[1].checked)){
			rdShowMessageDialog("��Ҫ��ʾ:\n    ����û����Ƶ����ʵ������ʼ��ʵ��͵����ʵ����з��������£������º��Զ�ȡ���ʼ��ʵ��ļ��͡�����û��ڲ�������ȡ�������ʵ����ʼ��ʵ��ڲ����ڽ�������֮ȡ��!");
		}
	}else
	{
		rdShowMessageDialog("����:"+ retCode + "->" + retMsg,0);
		return;
	}    
    
}

//-------2---------��֤���ύ����-----------------

function printCommit()
{
	getAfterPrompt();
	//У��
	
  if(!checkElement(document.f1451.phoneno)) return false;
  
  if (document.all.mail_address1.value == ""){
  	rdShowMessageDialog("����������û���Email��ַ1!",0);
  	document.f1451.mail_address1.focus();
  	return false;
  }
  else{
  	if(!forMail(document.f1451.mail_address1)) return false;
  	}
  
  //�����ӻ��޸�ʱ����ʾѡ��ͻ���Ϣ
	if(document.all.r_cus[0].checked||document.all.r_cus[1].checked){  
 		if (document.all.tran_content.value == "0"){
  		rdShowMessageDialog("��ѡ��ѯ�ʿͻ���Ϣ,�Ƿ����!",0);
  		document.f1451.tran_content.focus();
  		return false;
  	}
	}
   
 	if(!check(document.f1451)) return false;
	
   //��ӡ�������ύ��
	document.all.t_sys_remark.value="�û�"  + document.all.phoneno.value + "Email����";
  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");

  if((ret=="confirm")){
  	if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){  
	  	f1451.submit();
    }
		
		if(ret=="remark"){
         if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
         {
	       ��f1451.submit();
         }
	   }
	}
    else
    {
       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
       {
	     ��f1451.submit();
       }
    }	
    return true;
  }
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի��� 
     var h=150;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo(printType);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 

     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =<%=sysAcceptl%>;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = <%=activePhone%>;                            //�ͻ��绰
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
     return ret;    
  }

  function printInfo(printType)
  {
 
       	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
    cust_info+="�ֻ����룺"+document.all.phoneno.value+"|";
    cust_info+="�ͻ�������"+document.all.cust_name.value+"|";  
    
    
    opr_info+="E_maild��ַ1��"+document.all.mail_address1.value+"|||";
    /*opr_info+="E_maild��ַ2��"+document.all.mail_address2.value+"|";
    opr_info+="E_maild��ַ3��"+document.all.mail_address3.value+"|";*/
    opr_info+="���֤�ţ�"+document.all.cust_iccid.value+"|";
    
    
    if (document.all.tran_content.value == "Y"){
    	opr_info+="�����ƶ���˾����ʷѺ�ҵ����Ϣ�ǣ�"+"|";
  	}else{
  		opr_info+="�����ƶ���˾����ʷѺ�ҵ����Ϣ��"+"|";
  	}
    opr_info+="    ҵ�����ͣ�"+'<%=op_name%>'+"|";
    if(document.all.r_cus[0].checked)
	{
      opr_info+="    �������ͣ�"+"���"+"|";
	}
	if(document.all.r_cus[1].checked)
	{
      opr_info+="     �������ͣ�"+"�޸�"+"|";
	}
	if(document.all.r_cus[2].checked)
	{
      opr_info+="    �������ͣ�"+"ɾ��"+"|";
	}
    opr_info+="��ˮ��"+document.all.loginAccept.value+"|";
    note_info1+="��ע��"+document.all.t_sys_remark.value+"|";
    note_info2+="��ע��"+document.all.t_op_remark.value+" "+document.all.simBell.value+"|";
      

		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
    return retInfo;;	
  }

 //-->
 
//���Ϊ�ͷ�������ֱ��չ��ҳ��   hejwa add 2013��10��15��15:57:56         
$(document).ready(function(){
	if("<%=accountType%>"=="2"){
			$("#qryId_No").hide();
			simChk();
	}
});
 
</script>

<%@ include file="../../page/common/pwd_comm.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.S1100View" %>
 



</head>
<script language=javascript>
function showWorldMsg()
{
		
     if( document.all.r_cus[0].checked){}
}
</script>
<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<form action="f1451BackCfm.jsp" method="POST" name="f1451"  onKeyUp="chgFocus(f1451)">
	<%@ include file="/npage/include/header.jsp" %>                         

	<%@ include file="../../include/remark.htm" %>
	<div class="title">
		<div id="title_zi">�����ʵ�����</div>
	</div>
	<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	<input type="hidden" name="loginAccept" value="<%=sysAcceptl%>">

        <table cellspacing="0">
          <tr> 
            <td   nowrap width="10%" height=10 class="blue">��������</td>
            <td   nowrap colspan="3" height=10>
            <input type="radio" name="r_cus" index="0" value="0" checked >���
  					<input type="radio" name="r_cus"  index="1" value="1">�޸�
  					<input type="radio" name="r_cus" index= "2" value="2">ȡ��
            </td>
          </tr>
          <tr> 
            <td  nowrap width="10%" class="blue">�û�����</td>
            <td nowrap  colspan="3"> 
              <input   type="text" name="phoneno"   v_must=1  v_type="mobphone" onBlur="if(this.value!=''){if(checkElement(document.f1451.phoneno)==false){return false;}}" maxlength=11  index="6"  value =<%=activePhone%>  Class="InputGrey" readOnly >	               
            <font class="orange">*</font>
            <input class="b_text" type="button" name="qryId_No" id="qryId_No" value="��ѯ" onClick="simChk()" >            </td>
          </tr>
          <tr> 
            <td   nowrap width="16%" class="blue">�û�����</td>
            <td  nowrap  width="34%"> 
              <input type="text"  name="cust_name"  v_minlength=0 v_maxlength=60  v_type=string  v_name="�û�����" maxlength=10 value="" tabindex="0" readonly class="InputGrey"  >
            </td>
            <td  nowrap  width="16%" class="blue">���֤����</td>
            <td  nowrap  width="34%"> 
             <input type="text"  name="cust_iccid" maxlength=60 v_must=0 v_minlength=0 v_type=string v_name = "���֤����" value="" tabindex="0" readonly class="InputGrey"  >
            </td>
          </tr>
         <tr> 
            <td   nowrap width="16%" class="blue">E_mail��ַ</td>
            <td  nowrap  width="34%"> 
              <input  type="test" name="mail_address1" v_must=0 v_name="E_mail��ַ1"  v_type=string v_minlength=0 size="40" value="">
              <font class="orange">*</font>
            </td>
            <td  nowrap  width="16%" class="blue">ѯ�ʿͻ�</td>
            <td  nowrap  width="34%"> 
								<select name ="tran_content">
									<option class='button' value='0' selected>δѡ��</option>
									<option class='button' value='Y' >��</option>
									<option class='button' value='N' >��</option>
								</select>
								<font class="orange">*�����ƶ���˾����ʷѺ�ҵ����Ϣ</font>
							</td>
          </tr>
            <!--<td   nowrap height=10 class="blue">E_mail��ַ2</td>
             <td   nowrap colspan="3" height=10>
              <input  type="test" name="mail_address2" v_must=0 v_name="E_mail��ַ2"  v_type=string v_minlength=0 size="40" value="">
             </td>
          </tr>
          <tr> 
            <td   nowrap height=10 class="blue">E_mail��ַ3</td>
             <td   nowrap colspan="3" height=10>
              <input  type="test" name="mail_address3" v_must=0 v_name="E_mail��ַ3"  v_type=string v_minlength=0 size="40" value="">
             </td>
          </tr>-->
          <tr > 
            <td valign="top" class="blue"> 
              <div align="left">ϵͳ��ע</div>
            </td>
            <td colspan="4" valign="top"> 
              <input type="text" class="InputGrey"  name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30>
              <input type="hidden"  name="t_op_remark" id="t_op_remark" size="60" v_maxlength=60  v_type=string  v_name="�û���ע" index="28" maxlength=60> 
            </td>
          </tr>
 
          <tr > 
            <td colspan="4" height="30" id="footer"> 
              <div align="center"> 
                <input  type="button" name="confirm" class="b_foot_long" value="��ӡ&ȷ��"  onClick="printCommit()" index="26" disabled >
                <input  type=reset name=back value="���" class="b_foot" onClick="document.all.confirm.disabled=true;" >
                <input  type="button" name="b_back" value="����"  class="b_foot" onClick="window.close()" index="28">
              </div>
            </td>
          </tr>
        </table>
 
  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>


</html>
