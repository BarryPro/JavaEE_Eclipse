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
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
 <%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>


<%		
	    
  String loginNo =    (String)session.getAttribute("workNo");  
  String loginName =  (String)session.getAttribute("workName");
  String regionCode = (String)session.getAttribute("regCode");
%>
<%
String retFlag="",retMsg="";
 SPubCallSvrImpl impl = new SPubCallSvrImpl();
  ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String vUnitCotract=request.getParameter("vUnitCotract");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = opcode; 	    /* ��������   */
  paraAray1[2] = loginNo;	    /* ��������   */
  paraAray1[3] = vUnitCotract;

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

  retList = impl.callFXService("s8609Qry", paraAray1, "19","phone",phoneNo);
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String vUnitAlowFee="",vUnitUsedFee="",vUnitPayFee="",vUnitName="",vUnitId="";
  String[][] tempArr= new String[][]{};
  int errCode = impl.getErrCode();
  String errMsg = impl.getErrMsg();
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s1141Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }
  else
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
	if(errCode != 0 ){%>
		<script language="JavaScript">
			rdShowMessageDialog("�������<%=errCode%>��������Ϣ<%=errMsg%>");
			history.go(-1);
		</script>
	<%}
	else
	{
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
	  tempArr = (String[][])retList.get(13);
	  if(!(tempArr==null)){
	    passwordFromSer = tempArr[0][0];  //����
	  }
	  tempArr = (String[][])retList.get(14);
	  if(!(tempArr==null)){
	    vUnitId = tempArr[0][0];  //����
	  }
	  tempArr = (String[][])retList.get(15);
	  if(!(tempArr==null)){
	    vUnitName = tempArr[0][0];  //����
	  }
	  tempArr = (String[][])retList.get(16);
	  if(!(tempArr==null)){
	    vUnitPayFee = tempArr[0][0];  //����
	  }
	  tempArr = (String[][])retList.get(17);
	  if(!(tempArr==null)){
	    vUnitUsedFee = tempArr[0][0];  //����
	  }
	  tempArr = (String[][])retList.get(18);
	  if(!(tempArr==null)){
	    vUnitAlowFee = tempArr[0][0];  //����
	  }
	}
  }

%>
 <%  //�Ż���Ϣ//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//   

  String[][] favInfo = (String[][])session.getAttribute("favInfo");   //���ݸ�ʽΪString[0][0]---String[n][0]
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
System.out.println("passTrans==="+passTrans);
System.out.println("passwordFromSer==="+passwordFromSer);
  if(!pwrf)
  {
     if(0==Encrypt.checkpwd1(passTrans,passwordFromSer)){
	   if(!retFlag.equals("1"))
		{%>
			<script language="JavaScript">
				rdShowMessageDialog("������֤�����������������룡");
				history.go(-1);
			</script>
		<%}
	    
    }       
  }
 %>
 
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
<%
//******************�õ�����������***************************//
String printAccept="";
printAccept = sysAcceptl;
System.out.println(printAccept);

  //�ֻ�Ʒ��
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='16' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'C%' and is_valid='1' and prepay_limit<=to_number('"+vUnitAlowFee+"')";
  System.out.println("sqlAgentCode====="+sqlAgentCode);
  //ArrayList agentCodeArr = co.spubqry32("2",sqlAgentCode);
  %>
 	
 	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlAgentCode%></wtc:sql>
 	  </wtc:pubselect>
	<wtc:array id="result_t" scope="end"/> 
  
  <%
  String[][] agentCodeStr = result_t;
  if(agentCodeStr.length==0){
  %>
			<script language="JavaScript">
				rdShowMessageDialog("����ʺ���û�п��Բμ�Ӫ�����Ľ�");
				history.go(-1);
			</script>
<%
  }
  //�ֻ�����
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and sale_type='16' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'C%' and is_valid='1' and prepay_limit<=to_number('"+vUnitAlowFee+"')";
  System.out.println("sqlPhoneType====="+sqlPhoneType);
  //ArrayList phoneTypeArr = co.spubqry32("3",sqlPhoneType);
  %>
	<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlPhoneType%></wtc:sql>
 	  </wtc:pubselect>
	<wtc:array id="result_t1" scope="end"/>   
  <%
  String[][] phoneTypeStr = result_t1;
  //Ӫ������
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.cost_price,a.brand_code,a.type_code from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='16' and valid_flag='Y' and a.spec_type like 'C%' and prepay_limit<=to_number('"+vUnitAlowFee+"')";
  System.out.println("sqlsaleType====="+sqlsaleType);
  //ArrayList saleTypeArr = co.spubqry32("5",sqlsaleType);
  %>
  <wtc:pubselect name="sPubSelect" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlsaleType%></wtc:sql>
 	  </wtc:pubselect>
	<wtc:array id="result_t2" scope="end"/>  
  
  <%
  String[][] saleTypeStr = result_t2;
  
%>
<head>
<title>���ſͻ�ͳһ��������Ӫ����</title>
<script language="JavaScript">
 
 function doProcess(packet)
 {
 
 		var errorCode = packet.data.findValueByName("errorCode");
		var errorMsg =  packet.data.findValueByName("errorMsg");
		var retType = packet.data.findValueByName("retType");
		var retResult =  packet.data.findValueByName("retResult");
		self.status="";
		var tmpObj="";
		var i=0;
		var j=0;
		var ret_code=0;
		var tmpstr="";
		
		ret_code =  parseInt(errorCode);
		if(retResult == "000000")
		{
			rdShowMessageDialog("IMEI��У��ɹ�1��");
			document.frm.IMEINo.readonly =true;
			document.frm.IMEINo.className="InputGrey" 
			document.frm.confirm.disabled=false;
			return ;

		}else if(retResult == "000001")
		{
			rdShowMessageDialog("IMEI��У��ɹ�2��");
			document.frm.IMEINo.readonly =true;
			document.frm.IMEINo.className="InputGrey" 
			document.frm.confirm.disabled=false;
			return ;

		}else if(retResult == "000003"){
			rdShowMessageDialog("IMEI�Ų���ӪҵԱ����Ӫҵ����IMEI����ҵ�������Ͳ�����");
			document.frm.confirm.disabled=true;
			return false;
		}else{
			rdShowMessageDialog("IMEI�Ų����ڻ����Ѿ�ʹ�ã�");
			document.frm.confirm.disabled=true;
			return false;
		}
		
 }

function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.confirm.disabled=true;
	}

}


 


<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
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
  var arrsalePrice=new Array();
  var arrsaleLimit=new Array();
  var arrsaletype=new Array();
  var arrsalebrand=new Array();
  


 
<%  
  for(int i=0;i<phoneTypeStr.length;i++)
  {
	out.println("arrPhoneType["+i+"]='"+phoneTypeStr[i][0]+"';\n");
	out.println("arrPhoneName["+i+"]='"+phoneTypeStr[i][1]+"';\n");
	out.println("arrAgentCode["+i+"]='"+phoneTypeStr[i][2]+"';\n");
  }  
  for(int l=0;l<saleTypeStr.length;l++)
  {
	out.println("arrsalecode["+l+"]='"+saleTypeStr[l][0]+"';\n");
	out.println("arrsaleName["+l+"]='"+saleTypeStr[l][1]+"';\n");
	out.println("arrsalePrice["+l+"]='"+saleTypeStr[l][2]+"';\n");
	out.println("arrsalebrand["+l+"]='"+saleTypeStr[l][3]+"';\n");
	out.println("arrsaletype["+l+"]='"+saleTypeStr[l][4]+"';\n");
	
	
  }  
%>
	
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***IMEI ����У��
 function checkimeino()
{
	 if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      document.frm.IMEINo.focus();
      document.frm.confirm.disabled = true;
	  return false;
     } 
	
	var myPacket = new AJAXPacket("queryimei.jsp","����У��IMEI��Ϣ�����Ժ�......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
	myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
	myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
	myPacket.data.add("retType","0");
	myPacket.data.add("opcode",(document.all.opcode.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket = null; 
    
}
 function printCommit()
 { 
  //У��
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("����������!");
      cust_name.focus();
	  return false;
	}
	if(agent_code.value==""){
	  rdShowMessageDialog("�������ֻ�Ʒ��!");
      agent_code.focus();
	  return false;
	}
	if(phone_type.value==""){
	  rdShowMessageDialog("�������ֻ��ͺ�!");
      phone_type.focus();
	  return false;
	}
	if(sale_code.value==""){
	  rdShowMessageDialog("������Ӫ������!");
      sale_code.focus();
	  return false;
	}
	if (IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI���벻��Ϊ�գ����������� !!");
      IMEINo.focus();
      confirm.disabled = true;
	  return false;
     } 
    if(parseFloat(vUnitAlowFee.value)<parseFloat(cost_price.value)){
      rdShowMessageDialog("�ֻ��ɱ��۲��ܴ��ڿ��ý��!");
      return false;
    }
    
	 document.all.phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
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
/*************
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var printStr = printInfo(printType);
   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
   return ret;    
}

*******/


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

/***
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

  var pType="print";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=printAccept%>;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode="8609" ;                   			 		//��������
	var phoneNo="<%=phoneNo%>";                  	 		//�ͻ��绰

    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo=<%=phoneNo%>"+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}

***/
/****
function printInfo(printType)
{
  
	var month_fee ;
	
  
	var retInfo = "";
	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	retInfo+="�û����룺"+document.all.phone_no.value+"|";
	retInfo+="�û�������"+document.all.cust_name.value+"|";
	retInfo+="�û���ַ��"+document.all.cust_addr.value+"|";
	retInfo+="֤�����룺"+document.all.cardId_no.value+"|";
	retInfo+="�����ʺ�: "+document.all.vUnitCotract.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+="ҵ�����ͣ����ſͻ�ͳһ��������Ӫ����"+"|";
  	retInfo+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  	retInfo+="�ֻ��ͺ�: "+document.all.phone_typename.value+"      IMEI�룺"+document.frm.IMEINo.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+="      ��ע��"+document.all.opNote.value+"|";
  return retInfo;	
}
********/

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

  	opr_info+="�ֻ��ͺţ�"+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text
  				+"      IMEI�룺"+document.frm.IMEINo.value+"|";


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

<script language="JavaScript">
<!--
/****************����agent_code��̬����phone_type������************************/
 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values
    
   myEle = document.createElement("option") ;
    myEle.value = "";
        myEle.text ="--��ѡ��--";
        controlToPopulate.add(myEle) ;
   for ( x = 0 ; x < ItemArray.length  ; x++ )
   {
      if ( GroupArray[x] == control.value )
      {
        myEle = document.createElement("option") ;
        myEle.value = arrPhoneType[x] ;
        myEle.text = ItemArray[x] ;
        controlToPopulate.add(myEle) ;
      }
   }
   
   
 } 
 function typechange(){
 
 	var myEle1 ;
   	var x1 ;
 
       document.all.sale_code.value="";
   	for ( x1 = 0 ; x1 < arrsalecode.length  ; x1++ )
   	{		
      		if ( arrsaletype[x1] == document.all.phone_type.value  && arrsalebrand[x1] == document.all.agent_code.value)
      		{
        		document.all.sale_code.value=arrsalecode[x1];
        		document.all.cost_price.value=arrsalePrice[x1];
      		}
   	}
   	
			
 }
 


 
//-->
</script>


</head>


<body>
<form name="frm" method="post" action="f8609Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>                         
	<div class="title">
		<div id="title_zi">���ſͻ�ͳһ��������Ӫ����</div>
	</div>
        <table cellspacing="0"  >
		 
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
            <td class=blue>����ID</td>
            <td>
			  <input name="vUnitId" value="<%=vUnitId%>" type="text"  v_must=1 readonly class="InputGrey"  id="vUnitId" maxlength="20" > 
			  
            </td>
            <td class=blue>��������</td>
            <td>
			  <input name="vUnitName" value="<%=vUnitName%>" type="text"  v_must=1 readonly class="InputGrey"  id="vUnitName" maxlength="20" > 
			  
            </td>
            </tr>
            <tr> 
            <td class=blue>���ѽ��</td>
            <td>
			  <input name="vUnitPayFee" value="<%=vUnitPayFee%>" type="text"  v_must=1 readonly class="InputGrey"  id="vUnitPayFee" maxlength="20" > 
			  
            </td>
            <td class=blue>���ý��</td>
            <td>
			  <input name="vUnitUsedFee" value="<%=vUnitUsedFee%>" type="text"  v_must=1 readonly class="InputGrey"  id="vUnitUsedFee" maxlength="20" > 
			  
            </td>
            </tr>
            <tr> 
            <td class=blue>���ý��</td>
            <td>
			  <input name="vUnitAlowFee" value="<%=vUnitAlowFee%>" type="text"  v_must=1 readonly class="InputGrey"  id="vUnitAlowFee" maxlength="20" > 
			 
            </td>
            <td></td>
            <td>
			  
            </td>
            </tr>
             <tr> 
            <td class=blue>�ֻ�Ʒ��</td>
            <td>
			  <SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="�ֻ�������">  
			    <option value ="">--��ѡ��--</option>
                <%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
              </select>
			  <font class="orange">*</font>	
			</td>
	 <td class=blue>�ֻ��ͺ�</td>
            <td>
			  <select size=1 name="phone_type" id="phone_type" v_must=1 v_name="�ֻ��ͺ�" onchange="typechange()">	
			  	  
              </select>
			  <font class="orange">*</font>
			</td>
          </tr>
          <tr> 
         
         <td class=blue>�ֻ��ɱ���
            </td>
            <td>
			  <input type="text" name="cost_price" id="cost_price" readonly class="InputGrey"  v_name="�ֻ��ɱ���" >			  
             
			  
			</td>
            <td>
            </td>
            <td>
            	 <input type="hidden" name="sale_code" id="sale_code" v_name="Ӫ������" >	
			</td>
          </tr>
         <TR > 
			<TD  nowrap  class=blue> 
				<div align="left">IMEI��</div>
            </TD>
            <TD > 
				<input name="IMEINo"  type="text" v_type="0_9" v_name="IMEI��"  maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei" class="b_text" type="button" value="У��" onclick="checkimeino()">
                <font class="orange">*</font>
            </TD>
			<TD>
			</td>
			<td>
			</td>
          </TR>
		  <TR  id=showHideTr > 
			<TD  nowrap> 
				<div align="left" class=blue>����ʱ��</div>
            </TD>
			<TD > 
				<input name="payTime"  type="text" v_name="����ʱ��"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
				(������)<font class="orange">*</font>                  
			</TD>
			<TD  nowrap class=blue> 
				<div align="left">����ʱ��</div>
			</TD>
			<TD > 
				<input name="repairLimit" v_type="date.month"  size="10" type="text" v_name="����ʱ��" value="12" onblur="viewConfirm()">
				(����)<font class="orange">*</font>
			</TD>
          </TR>
		  <tr> 
            <td height="32"   class=blue>��ע</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="���ſͻ�ͳһ��������Ӫ����" > 
            </td>
          </tr>
          <tr> 
            <td colspan="4"> <div align="center"> 
                <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()" disabled >
                &nbsp; 
                <input name="reset" type="reset"  class="b_foot"  value="���" >
                &nbsp; 
                <input name="back"  class="b_foot"  onClick="history.go(-1)" type="button"  value="����">
                &nbsp; </div></td>
          </tr>
        </table>
 
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="vUnitCotract" value="<%=vUnitCotract%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="16" >
    <input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="phone_typename" value="" >
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>