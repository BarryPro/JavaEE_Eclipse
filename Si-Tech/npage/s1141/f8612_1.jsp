<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
/********************
 version v2.0
������: si-tech
********************/
%>

<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  
	String opCode = "8609";
	String opName = "���ſͻ�ͳһ��������Ӫ����";

%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.math.*"%>
<%@ include file="../../page/bill/getMaxAccept.jsp" %>


<%		
  ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
  String[][] baseInfoSession = (String[][])arrSession.get(0);
  String[][] otherInfoSession = (String[][])arrSession.get(2);
  String[][] pass = (String[][])arrSession.get(4);
	    
  String loginNo = baseInfoSession[0][2];
  String loginName = baseInfoSession[0][3];
  String powerCode= otherInfoSession[0][4];
  String orgCode = baseInfoSession[0][16];
  String ip_Addr = request.getRemoteAddr();  
  String regionCode = orgCode.substring(0,2);
  String regionName = otherInfoSession[0][5];
  String loginNoPass = pass[0][0];  	    
  String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];	    
%>
<%

String retFlag="",retMsg="";
 SPubCallSvrImpl impl = new SPubCallSvrImpl();
  ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String backaccept = request.getParameter("backaccept");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = opcode; 	    /* ��������   */
  paraAray1[2] = loginNo;	    /* ��������   */
  paraAray1[3] = backaccept;	    /* ������ˮ   */

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

  retList = impl.callFXService("s8612Qry", paraAray1, "17","phone",phoneNo);
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="";
  String vip="",posint="",prepay_fee="",sale_name="";
  String mach="",machine_type="" ,unit_id="",unit_name="",unit_contract="";
  String[][] tempArr= new String[][]{};
  int errCode = impl.getErrCode();
  String errMsg = impl.getErrMsg();
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s8612Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(retList == null))
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(errCode != 0 ){%>
<script language="JavaScript">
<!--
  	alert("�������<%=errCode%>������Ϣ<%=errMsg%>");
  	 //history.go(-1);
  	//-->
  </script>
  <%}
	if (errCode == 0 ){
	  tempArr = (String[][])retList.get(2);
	  if(!(tempArr==null)){
	    bp_name = tempArr[0][0];//��������
	    System.out.println(bp_name);
	  }
	  tempArr = (String[][])retList.get(3);
	  if(!(tempArr==null)){
	    bp_add = tempArr[0][0];//�ͻ���ַ
	  }
	  tempArr = (String[][])retList.get(4);
	  if(!(tempArr==null)){
	    cardId_type = tempArr[0][0];//֤������
	  }
	  tempArr = (String[][])retList.get(5);
	  if(!(tempArr==null)){
	    cardId_no = tempArr[0][0];//֤������
	  }
	  tempArr = (String[][])retList.get(6);
	  if(!(tempArr==null)){
	    sm_code = tempArr[0][0];//ҵ��Ʒ��
	  }
	  tempArr = (String[][])retList.get(7);
	  if(!(tempArr==null)){
	    region_name = tempArr[0][0];//������
	  }
	  tempArr = (String[][])retList.get(8);
	  if(!(tempArr==null)){
	    run_name = tempArr[0][0];//��ǰ״̬
	  }
	  tempArr = (String[][])retList.get(9);
	  if(!(tempArr==null)){
	    vip = tempArr[0][0];//�֣ɣм���
	  }
	  tempArr = (String[][])retList.get(10);
	  if(!(tempArr==null)){
	    posint = tempArr[0][0];//��ǰ����
	  }
	  tempArr = (String[][])retList.get(11);
	  if(!(tempArr==null)){
	    prepay_fee = tempArr[0][0];//����Ԥ��
	  }
	  tempArr = (String[][])retList.get(12);
	  if(!(tempArr==null)){
	    sale_name = tempArr[0][0];//Ӫ��������
	  }
	  tempArr = (String[][])retList.get(13);
	  if(!(tempArr==null)){
	    machine_type = tempArr[0][0];//��������
	  }
	  tempArr = (String[][])retList.get(14);
	  if(!(tempArr==null)){
	    unit_contract = tempArr[0][0];//�ʺ�
	  }
	  tempArr = (String[][])retList.get(15);
	  if(!(tempArr==null)){
	    unit_id = tempArr[0][0];//unitid
	  }
	  tempArr = (String[][])retList.get(16);
	  if(!(tempArr==null)){
	    unit_name = tempArr[0][0];//��������
	  }
	}else{
		
	}
  }

%>
 <%  //�Ż���Ϣ//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//   

  String[][] favInfo = (String[][])arrSession.get(3);   //���ݸ�ʽΪString[0][0]---String[n][0]
  boolean pwrf = false;//a272 ��������֤
  String handFee_Favourable = "readonly class='InputGrey' ";        //a230  ������
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
    if(tempStr.compareTo("a272") == 0)
    {
      pwrf = true;
    }
	
  }
 
  String passTrans=Pub_lxd.repNull(request.getParameter("cus_pass")); 
  if(!pwrf)
  {
     String passFromPage=Encrypt.encrypt(passTrans);
     if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage))	{
	   if(!retFlag.equals("1"))
	   {
	      retFlag = "1";
          retMsg = "�������!";
	   }
	    
    }       
  }
// **************�õ�������ˮ***************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���ſͻ�ͳһ��������Ӫ����</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="../../npage/s1400/pub.js"></script>
<script language="JavaScript">

<!--
 
  
  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***
 
 
 function printCommit()
 
 { 
  //У��
  //if(!check(frm)) return false;
  
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
/***
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var printStr = printInfo(printType);
   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/page/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
   return ret;    
}
***/

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
	 var pType="subprint";
	 var billType="1";
	 var sysAccept = document.all.login_accept.value;
   var printStr = printInfo(printType);

   var mode_code=null;
	 var fav_code=null;
	 var area_code=null

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg="+DlgMessage;
   var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opcode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   //alert(path);
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
}

/**
function printInfo(printType)
{
 	var retInfo = "";
	retInfo+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	retInfo+="�û����룺"+document.all.phone_no.value+"|";
	retInfo+="�û�������"+document.all.cust_name.value+"|";
	retInfo+="�û���ַ��"+document.all.cust_addr.value+"|";
	retInfo+="֤�����룺"+document.all.cardId_no.value+"|";
	retInfo+="�����ʺţ�"+document.all.unit_contract.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+="ҵ�����ͣ����ſͻ�ͳһ��������Ӫ����--����"+"|";
  retInfo+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  retInfo+="�ֻ��ͺ�: "+"<%=machine_type%>"+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";	
    return retInfo;	
}

**/
function printInfo(printType)
{
   var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	 var retInfo = "";

	cust_info+= "�ֻ����룺     "+document.all.phone_no.value+"|";
	cust_info+= "�ͻ�������     "+document.all.cust_name.value+"|";
	opr_info+="�û�Ʒ�ƣ�"+document.all.sm_code.value+" ����ҵ��<%=opName%>"+"|";
  	opr_info+="������ˮ��"+document.all.login_accept.value+"|";//14

  	opr_info+="�ֻ��ͺţ�"+document.all.machine_type.value;


   //var jkinfo="";
	//if(parseInt(document.all.card_money.value,10)==0){
		//jkinfo="�ɿ�ϼƣ�"+document.all.sum_money.value+"Ԫ ��:Ԥ�滰�� "+document.all.pay_money.value+"Ԫ";
	//}else{
		//jkinfo+="�ɿ�ϼƣ�"+document.all.sum_money.value+"Ԫ ��:Ԥ�滰�� "+document.all.pay_money.value+"Ԫ��"+document.all.cardy.value;
	//}

	//jkinfo="�ɿ�"+document.all.sum_money.value+"Ԫ ���������";
	//opr_info+=jkinfo+"|";
	//retInfo+=jkinfo+"|";//16
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";//20
	retInfo+=" "+"|";



		//retInfo+="ע��������λ����������Ԥ���˲�ת��������ǰ���ʷ�Ϊ�����ʷѣ�"+"|";
		//retInfo+="�ڰ����ڼ䣬����������Ŀ�������ȴӰ�����п۳�����������ķ��ÿ��Դ�"+"|";
		//retInfo+="���͵�Ԥ���(ר��)��֧�������͵�Ԥ�������ڰ�������ר����ҵ��"+"|";
		//retInfo+="(����ꡢ��������)�����͵�Ԥ���δ�����꣬���ܰ�������ҵ��"+"|";
		//retInfo+="���λ�е��ֻ��������й��ƶ�ҵ��"+"|";

		//retInfo+="ҵ����ǰ������ȡ������ΥԼ�涨�����Żݼ۹�����ֻ������ֻ�ԭ�۲�����"+"|";
		//retInfo+="����ʣ��Ԥ����30%����ΥԼ��"+"δ�漰���ʷѣ������е��ƶ��绰�ʷѱ�׼ִ�С�"+"|";
		//retInfo+="���λ�ֻ������й��ƶ�ҵ����Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�"+"|";



	note_info1 =retInfo;
	note_info1+="      ��ע��"+document.all.opNote.value+"|";
	//if(document.all.spec_fee.value!="0"){

		//note_info3+="�������Ƶ��ֻ���ҵ��������Ϊ:"+document.all.used_date.value+",���ں��粻�����ʹ�ã�������ȡ��������ǰȡ�������ò��˲�����"+"|";
	//}else{
		retInfo+=" "+"|";
		note_info3+=" "+"|";
	//}
	//retInfo+="�ֻ��ն˻��Զ��������϶�Ķ��Ž��в�֣���ͬ�ͺ��ֻ��ն˲��ԭ��ͬ���ҹ�˾�����ֻ��Զ�"+"|"+"��ֵ������շѡ�"+"|";

	//note_info3+="�ֻ��ն˻��Զ��������϶�Ķ��Ž��в�֣���ͬ�ͺ��ֻ��ն˲��ԭ��ͬ���ҹ�˾�����ֻ��Զ�"+"|"+"��ֵ������շѡ�"+"|";
	
		//#23->#
		retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}


//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f8612Cfm.jsp" onload="init()">
 
<%@ include file="/npage/include/header.jsp" %>                         
	<div class="title">
		<div id="title_zi">���ſͻ�ͳһ��������Ӫ��������</div>
	</div>
        <table  cellspacing="0"   >
 
          <tr> 
            <td class=blue>�ͻ�����</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly class="InputGrey"  id="cust_name" maxlength="20" v_name="����"> 
			  
            </td>
            <td class=blue>�ͻ���ַ</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1 readonly class="InputGrey"  id="cust_addr" maxlength="20" > 
			  
            </td>
            </tr>
            <tr> 
            <td class=blue>֤������</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1 readonly class="InputGrey"  id="cardId_type" maxlength="20" > 
			  
            </td>
            <td class=blue>֤������</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1 readonly class="InputGrey"  id="cardId_no" maxlength="20" > 
			  
            </td>
            </tr>
            <tr> 
            <td class=blue>ҵ��Ʒ��</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly class="InputGrey"  id="sm_code" maxlength="20" > 
			  
            </td>
            <td class=blue>����״̬</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly class="InputGrey"  id="run_type" maxlength="20" > 
			  
            </td>
            </tr>
            <tr> 
            <td class=blue>VIP����</td>
            <td>
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1 readonly class="InputGrey"  id="vip" maxlength="20" > 
			  
            </td>
            <td class=blue>����Ԥ��</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly class="InputGrey"  id="prepay_fee" maxlength="20" > 
			  
            </td>
            </tr>
           <tr> 
            <td class=blue>Ӫ������</td>
            <td >
				<input name="sale_name" value="<%=sale_name%>" type="text"  v_must=1 readonly class="InputGrey"  id="sale_name" maxlength="20" size="40"> 
			    
			</td>
			<td  class=blue>��������</td>
            <td >
			  <input name="machine_type" type="text"  id="machine_type" value="<%=machine_type%>" readonly class="InputGrey" >
			  
			</td>            
          </tr>
          <tr> 
            <td  class=blue>����ID</td>
            <td >
			  <input name="unit_id" type="text"  id="unit_id" value="<%=unit_id%>" readonly class="InputGrey"   >
			  	
			</td>
            <td class=blue>��������</td>
            <td>
			  <input name="unit_name" type="text"   id="unit_name" value="<%=unit_name%>" readonly class="InputGrey" >
			  
			</td>
          </tr>
          <tr> 
            
            <td class=blue>�����ʺ�</td>
            <td><input name="unit_contract" type="text"   id="unit_contract" value="<%=unit_contract%>" readonly class="InputGrey" >
			  		</td>
			  		<td class=blue>&nbsp;</td>
			  		<td class=blue>&nbsp;</td>
          </tr> 
          <tr> 
            <td height="32"  class=blue >��ע</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="���ſͻ�ͳһ��������Ӫ����--����" > 
            </td>
          </tr>
          <tr> 
            <td colspan="4"> <div align="center"> 
                <input name="confirm" type="button" class="b_foot_long" index="2" value="ȷ��&��ӡ" onClick="printCommit()">
                &nbsp; 
                <input name="reset" type="reset" class="b_foot"  value="���" >
                &nbsp; 
                <input name="back" onClick="removeCurrentTab();" class="b_foot"  type="button"  value="����">
                &nbsp; </div></td>
          </tr>
        </table>

    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	  <input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
	  <input type="hidden" name="backaccept" value="<%=backaccept%>">
    <input type="hidden" name="card_dz" value="0" >
	  <input type="hidden" name="sale_type" value="1" >
    <input type="hidden" name="used_point" value="0" >  
	  <input type="hidden" name="point_money" value="0" > 
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>