<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-08
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
    String opCode = "2296";
    String opName = "�������־��ֲ�����(��)��Ա";
    String loginNo = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String regionCode = orgCode.substring(0,2);
%>
<%
    String retFlag="",retMsg="";
    //SPubCallSvrImpl impl = new SPubCallSvrImpl();
    //ArrayList retList = new ArrayList();
    String[] paraAray1 = new String[3];
    String phoneNo = request.getParameter("srv_no");
    String opcode = request.getParameter("opcode");
    
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

  //retList = impl.callFXService("s2296Qry", paraAray1, "12","phone",phoneNo);
%>
<wtc:service name="s2296Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s2296QryCode" retmsg="s2296QryMsg" outnum="12">
	<wtc:param value="<%=paraAray1[0]%>"/> 
	<wtc:param value="<%=paraAray1[1]%>"/> 
    <wtc:param value="<%=paraAray1[2]%>"/> 
</wtc:service>
<wtc:array id="s2296QryArr" scope="end" />
<%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  //String[][] tempArr= new String[][]{};
  String errCode = s2296QryCode;
  String errMsg = s2296QryMsg;
  if(s2296QryArr == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s12fbInit��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(s2296QryArr == null))
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(!errCode.equals("000000")){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
  <%}
	if (errCode.equals("000000") ){
	  //tempArr = (String[][])retList.get(2);
	  if(!(s2296QryArr[0][2].equals(""))){
	    bp_name = s2296QryArr[0][2];//��������
	    System.out.println(bp_name);
	  }
	  //tempArr = (String[][])retList.get(3);
	  if(!(s2296QryArr[0][3].equals(""))){
	    bp_add = s2296QryArr[0][3];//�ͻ���ַ
	  }
	  //tempArr = (String[][])retList.get(4);
	  if(!(s2296QryArr[0][4].equals(""))){
	    cardId_type = s2296QryArr[0][4];//֤������
	  }
	  //tempArr = (String[][])retList.get(5);
	  if(!(s2296QryArr[0][5].equals(""))){
	    cardId_no = s2296QryArr[0][5];//֤������
	  }
	  //tempArr = (String[][])retList.get(6);
	  if(!(s2296QryArr[0][6].equals(""))){
	    sm_code = s2296QryArr[0][6];//ҵ��Ʒ��
	  }
	  //tempArr = (String[][])retList.get(7);
	  if(!(s2296QryArr[0][7].equals(""))){
	    region_name = s2296QryArr[0][7];//������
	  }
	  //tempArr = (String[][])retList.get(8);
	  if(!(s2296QryArr[0][8].equals(""))){
	    run_name = s2296QryArr[0][8];//��ǰ״̬
	  }
	  //tempArr = (String[][])retList.get(9);
	  if(!(s2296QryArr[0][9].equals(""))){
	    vip = s2296QryArr[0][9];//�֣ɣм���
	  }
	  //tempArr = (String[][])retList.get(10);
	  if(!(s2296QryArr[0][10].equals(""))){
	    posint = s2296QryArr[0][10];//��ǰ����
	  }
	  //tempArr = (String[][])retList.get(11);
	  if(!(s2296QryArr[0][11].equals(""))){
	    prepay_fee = s2296QryArr[0][11];//����Ԥ��
	  }
	}else{
		//if(!retFlag.equals("1"))
		//{
		  // retFlag = "1";
	      // retMsg = "s126bInit��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		//}
	}
  }

%>

<%
//******************�õ�����������***************************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
  //comImpl co=new comImpl();
  //����������
  String sqlAgentCode = " select  unique user_type,trim(user_name) from sMusicCfg where user_type in ('3','4','5')";
  System.out.println("sqlAgentCode====="+sqlAgentCode);
  //ArrayList agentCodeArr = co.spubqry32("2",sqlAgentCode);
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:sql><%=sqlAgentCode%></wtc:sql>
</wtc:pubselect>
<wtc:array id="agentCodeStr" scope="end" />
<%
  //String[][] agentCodeStr = (String[][])agentCodeArr.get(0);
  
  //��Ʒ����
  String sqlPhoneType = "select unique gift_code,gift_name,user_type from sMusicGiftCfg where region_code=:regionCode and valid_flag='Y'";
  //System.out.println("sqlPhoneType====="+sqlPhoneType);
  //ArrayList phoneTypeArr = co.spubqry32("3",sqlPhoneType);
  
  String [] paraIn = new String[2];
  paraIn[0] = sqlPhoneType;    
  paraIn[1]="regionCode="+regionCode;

%>
<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="3" >
	<wtc:param value="<%=paraIn[0]%>"/>
	<wtc:param value="<%=paraIn[1]%>"/> 
</wtc:service>
<wtc:array id="phoneTypeStr" scope="end"/>
<%
  //String[][] phoneTypeStr = (String[][])phoneTypeArr.get(0);
  
  //������ϸ
  String sqlsaleType = "select sp_fee,mode_code,user_type from sMusicCfg where user_type in ('3','4','5')";
  System.out.println("sqlsaleType====="+sqlsaleType);
  //ArrayList saleTypeArr = co.spubqry32("3",sqlsaleType);
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode3" retmsg="retMsg3" outnum="3">
	<wtc:sql><%=sqlsaleType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="saleTypeStr" scope="end" />
<%
  //String[][] saleTypeStr = (String[][])saleTypeArr.get(0);

  
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�������־��ֲ�����(��)��Ա</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

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
  var arrprinttype=new Array();
  


 
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
	out.println("arrsalebarnd["+l+"]='"+saleTypeStr[l][2]+"';\n");
	
	
  }  

%>
	
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***
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
	if(agent_code.value==""){
	  rdShowMessageDialog("�������û�����!");
      agent_code.focus();
	  return false;
	}
	if(gift_code.value==""){
	  rdShowMessageDialog("��������Ʒ����!");
      gift_code.focus();
	  return false;
	}
	if(sale_code.value==""){
	
     } 
    if(parseFloat(prepay_fee.value)<parseFloat(sum_money.value))
    {
    	rdShowMessageDialog("Ԥ���������ҵ�����Ƚ��ѣ�");
    	return false;
    }
  if(opNote.value==""){
		opNote.value=phone_no.value+"�����������ְ���(��)�û�����";
	}
	phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text;
	gift_name.value=document.all.gift_code.options[document.all.gift_code.selectedIndex].text
	
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
{  //��ʾ��ӡ�Ի��� 
   //var h=150;
   //var w=350;
   //var t=screen.availHeight/2-h/2;
   //var l=screen.availWidth/2-w/2;
   //
   //var printStr = printInfo(printType);
   //
   //var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   //  var path = "<%=request.getContextPath()%>/page/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
   //  var ret=window.showModalDialog(path,printStr,prop);
   //return ret;  
   
   var h=198;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var pType="subprint";
   var billType="1";
   var sysAccept = "<%=printAccept%>";
   var mode_code = codeChg(document.all.mode_code.value)+"~";
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
	var note_info3="";
	var note_info4="";
	var jkinfo="";
	//retInfo+=document.all.work_no.value+' '+'<%=loginName%>'+"|";
	//retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
	cust_info+="֤�����룺"+document.all.cardId_no.value+"|";
	
	opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"�û�Ʒ��: "+document.all.sm_code.value+ "|";
	opr_info+="����ҵ���������ְ���(��)��Ա����"+"  ҵ����ˮ��"+document.all.login_accept.value+"|";
  	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  	opr_info+="�û�����: "+document.all.phone_typename.value+"|";
  	opr_info+="��Ʒ����: "+document.all.gift_name.value+"|";
	//jkinfo="�ɿ�ϼƣ�"+parseInt(document.all.sum_money.value,10)+"Ԫ";
	//opr_info+=jkinfo+"|";
	
	
	
	
	
	//retInfo+="��ע��"+document.all.print1.value+"|";
	
	//retInfo+="��ע���������ɵ�1980Ԫ����60ԪΪ�������־��ֲ��߼���Ա��ѣ�ʣ��1920ԪΪ��ֵ������ã�������ֵ1740Ԫ������W300C�����ֻ�һ����һ�ų齱�ιο���ÿǧ�����н��岿����"+"|";
	//retInfo+="��ֵ100Ԫ�����ֱ���һ������ֵ380Ԫ�ı�Яʽ�ֻ����䣬��ֵ99Ԫ�Ĳ�����꿨������ע����գ�"+"|";
	if(document.all.agent_code.value=="3"){
		note_info1+="�������־��ֲ���������ܰ��ʾ��"+"|";
		note_info2+="1�� 30Ԫ������ʹ�÷�Ϊ�������־��ֲ�������ҵ��ר�ֻ�������������־��ֲ�������ҵ��ʹ�á�2��ÿ�´� 30Ԫר���л���5Ԫ���ֻ�����������֧���û����µ��������־��ֲ����á� "   +"|";                           
		note_info3+="3��ҵ����Ч��Ϊ6���Ʒ��¡�4����ǰȡ���������־��ֲ�������ҵ��ʣ��ķ��ò��ˡ���ת������ҵ��ʱ�䵽�ڵ�����ĩ����ʱ�����ƶ���˾�ջء� 5���������־��ֲ��������ʷѵ��ں��Զ�ת�ɰ����ʷѣ�5Ԫ/�¡�"+"|";

		note_info4+="��ע��"+document.all.opNote.value+"|";
	}
	if(document.all.agent_code.value=="4"){
		note_info1+="�������־��ֲ�������ܰ��ʾ��"+"|";
		note_info2+="1��60Ԫ����ʹ�÷�Ϊ�������־��ֲ�����ҵ��ר�ֻ�������������־��ֲ�����ҵ��ʹ�á�2��ÿ�´�60Ԫר���л���5Ԫ���ֻ�����������֧���û����µ��������־��ֲ����á� "   +"|";                           
		note_info3+="3��ҵ����Ч��Ϊ 12���Ʒ��¡�4����ǰȡ���������־��ֲ�����ҵ��ʣ��ķ��ò��ˡ���ת������ҵ��ʱ�䵽�ڵ�����ĩ����ʱ�����ƶ���˾�ջء� 5���������־��ֲ������ʷѵ��ں��Զ�ת�ɰ����ʷѣ�5Ԫ/�¡�"+"|";

		note_info4+="��ע��"+document.all.opNote.value+"|";
	}
	if(document.all.agent_code.value=="5"){
		note_info1+="�������־��ֲ�������ܰ��ʾ��"+"|";
		note_info2+="1��15Ԫ����ʹ�÷�Ϊ�������־��ֲ�����ҵ��ר�ֻ�������������־��ֲ�����ҵ��ʹ�á�2��ÿ�´�15Ԫר���л���5Ԫ���ֻ�����������֧���û����µ��������־��ֲ����á� "   +"|";                           
		note_info3+="3��ҵ����Ч��Ϊ3���Ʒ��¡�4����ǰȡ���������־��ֲ�����ҵ��ʣ��ķ��ò��ˣ���ת������ҵ��ʱ�䵽�ڵ�����ĩ����ʱ�����ƶ���˾�ջء� 5���������־��ֲ������ʷѵ��ں��Զ�ת�ɰ����ʷѣ�5Ԫ/�¡�"+"|";

		note_info4+="��ע��"+document.all.opNote.value+"|";
	}
    document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
	document.all.note_info1.value=note_info1+"#";
	document.all.note_info2.value=note_info2+"#";
	document.all.note_info3.value=note_info3+"#";
	document.all.note_info4.value=note_info4+"#";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
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
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=document.all.gift_code.options.length;q>=0;q--)document.all.gift_code.options[q]=null;
   // ADD Default Choice - in case there are no values
    
   myEle = document.createElement("option") ;
    myEle.value = "";
        myEle.text ="--��ѡ��--";
        document.all.gift_code.add(myEle) ;
   for ( x = 0 ; x < arrPhoneType.length  ; x++ )
   {
      if ( arrAgentCode[x] == document.all.agent_code.value )
      {
        myEle = document.createElement("option") ;
        myEle.value = arrPhoneType[x] ;
        myEle.text = arrPhoneName[x] ;
        document.all.gift_code.add(myEle) ;
      }
      if(document.all.agent_code.value==arrsalebarnd[x]){
      	  document.all.sum_money.value=arrsalecode[x]
      	  document.all.mode_code.value=arrsaleName[x]
      
      }
   }
   
   getMidPrompt("10442",codeChg(document.all.mode_code.value),"ipTd");
 } 
 
//-->
</script>


</head>
<body>
<form name="frm" method="post" action="f2296_2.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�������־��ֲ�����(��)��Ա</div>
</div>


<table cellspacing="0" >
    <tr> 
        <td class=blue>��������</td>
        <td colspan=3>�������־��ֲ�����(��)��Ա</td>
        </tr>
        <tr> 
        <td class=blue>�ͻ�����</td>
        <td>
            <input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="����"> 
        </td>
        <td class=blue>�ͻ���ַ</td>
        <td>
            <input name="cust_addr" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="20" > 
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
            <SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange();">  
                <option value ="">--��ѡ��--</option>
                <%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
                    <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
            </select>
            <font class="orange">*</font>	
        </td>
        <td class=blue>�ʷѴ���</td>
        <td id="ipTd">
            <input type="text" name="mode_code" readonly id="mode_code" v_must=1 >	
            <font class="orange">*</font>
        </td>
    </tr>
    <tr> 
        <td class=blue>��Ʒ����</td>
        <td colspan="3">
            <select size=1 name="gift_code" id="sale_code" v_must=1 >			  
            </select>
            <font class="orange">*</font>
        </td>
    </tr>
    <tr> 
        <td class=blue>Ӧ�����</td>
        <td colspan=3>
            <input name="sum_money" type="text" id="sum_money" readonly>
            <font class="orange">*</font>
        </td>
    </tr> 
    
    <tr> 
        <td class=blue>��ע</td>
        <td colspan="3" >
            <input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="�������־��ֲ�����(��)��Ա����" > 
        </td>
    </tr>
    <tr id="footer"> 
        <td colspan="4">
            <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()"  >
            <input name="reset" type="reset" class="b_foot" value="���" >
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
<input type="hidden" name="opcode" value="<%=opcode%>">
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
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>


