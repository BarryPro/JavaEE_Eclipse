<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2008.11.26
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%		
  String OpCode = "8679";
  String opCode = "8679";
  String opName = "���ֻ�G3����������";	 
  
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String regionCode = (String)session.getAttribute("regCode");   
  String groupId = (String)session.getAttribute("groupId");
  String orgCode = (String)session.getAttribute("orgCode");
  String payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
%>
<%
  String retFlag="",retMsg="";
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String backaccept= request.getParameter("backaccept");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = opcode; 	    /* ��������   */
  paraAray1[2] = loginNo;	    /* ��������   */
  paraAray1[3] = backaccept;

  /*****��÷ ��� 20060605*****/
  
  String sqlStr = "";
  String awardName="";
  sqlStr = "select award_name from wawardpay where phone_no ='"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;
		
  //retArray = callView.sPubSelect("1",sqlStr);
 %>
    <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCodeNo" retmsg="retMsgNo" outnum="1">
    <wtc:sql><%=sqlStr%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end"/>
 <% 
  //result = (String[][])retArray.get(0);
  if(result != null && result.length > 0)
  	awardName = result[0][0];	
    System.out.println("awardName="+awardName);
    
  if(!awardName.equals("")){
 %>
  //rdShowMessageDialog("���û�Ϊ���н��û����н���ƷΪ��"<%=awardName%>", ���û�������𷵻ؽ�Ʒ���ټ����������ҵ��");
   if(rdShowConfirmDialog("���û�Ϊ���н��û����н���ƷΪ��<%=awardName%> ���û�������𷵻ؽ�Ʒ���ټ����������ҵ��")!=1)
	{	
		location='f8678_login.jsp';
	}
	  
	</script>
  
<%}
  //sunzx add at 20070904
  sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;
		
  //retArray = callView.sPubSelect("1",sqlStr);
%>
   <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCodeNo2" retmsg="retMsgNo2" outnum="2">
     <wtc:sql><%=sqlStr%>
     </wtc:sql>
     </wtc:pubselect>
   <wtc:array id="result2" scope="end"/>  
<%  
  if(result2 != null && result2.length > 0)
  {
	  awardName = result2[0][0];		  
	  System.out.println("awardName2="+awardName);
  	  if(!awardName.equals("")){
%>
		  <script language="JavaScript" >
		  	rdShowMessageDialog("���û����ڴ���Ʒͳһ�����н���<%=awardName%>�콱������д���Ʒͳһ������������ȷ����Ʒ���");
			location='f8678_login.jsp';
		  </script>
<%	  }
  }
	String IMEINo="";
	sqlStr="select imei_no from wMachSndOprhis where phone_no ='"+phoneNo+"'"+
		    " and login_accept="+backaccept; 
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCodeNo2" retmsg="retMsgNo2" outnum="2">
  	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray" scope="end"/>
<%
	if(retArray!=null&& retArray.length > 0){
		IMEINo = retArray[0][0];
		System.out.println("IMEINo="+IMEINo);
	}
/*****��÷ ��� 20060605*******/

  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
 /* ��������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ�
 			�����أ���ǰ״̬��VIP���� ����ǰ���֣��û�Ԥ�棬
 			Ӫ����������Ӧ���������������������ͻ��ѣ����ѻ�����
 */
  //retList = impl.callFXService("s8679Qry", paraAray1, "24","phone",phoneNo);
%>  
  <wtc:service name="s8679Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="26" >
	<wtc:param value="<%=paraAray1[0]%>"/>
    <wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=paraAray1[3]%>"/>
	</wtc:service>
  <wtc:array id="tempArr" scope="end"/>
<%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String sale_name="",sum_money="",phone_money="",net_money="",pay_money="",used_point="",consume_term="",type_name="";
  String active_term="";

  String errCode = retCode1;
  String errMsg = retMsg1;
  if(tempArr == null)
  {
	if(!retFlag.equals("1"))
	{
	   System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s12fbInit��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(tempArr == null))
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
  	if(!errCode.equals("000000")){%>
    	<script language="JavaScript">
    	<!--
  	  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);  	  	
  	  	history.go(-1);
  		//-->
        </script>
  <%}
	if (errCode.equals("000000")){
	 
	    bp_name = tempArr[0][2];                //��������
	    bp_add = tempArr[0][3];                 //�ͻ���ַ	 
	    cardId_type = tempArr[0][4];            //֤������	 
	    cardId_no = tempArr[0][5];              //֤������	
	    sm_code = tempArr[0][6];                //ҵ��Ʒ��	
	    region_name = tempArr[0][7];            //������	
	    run_name = tempArr[0][8];               //��ǰ״̬	 
	    vip = tempArr[0][9];                    //�֣ɣм���	 
	    posint = tempArr[0][10];                //��ǰ����	 
	    prepay_fee = tempArr[0][11];            //����Ԥ��	 
	    sale_name = tempArr[0][12];             //Ӫ��������	
	    sum_money = tempArr[0][13];             //Ӧ�����	 
	    phone_money = tempArr[0][14];           //��������	 
	    net_money = tempArr[0][15];             //������	 
	    pay_money = tempArr[0][16];             //���ͻ���	 
	    used_point = tempArr[0][17];            //���ѻ����� 
	    consume_term = tempArr[0][18];          //������������	  
	    type_name = tempArr[0][19];             //�������ͺ�	 
	    active_term = tempArr[0][20];            //��������������	   
	    ///////<!-- ningtn add for pos start @ 20100722 -->
		if(tempArr[0][21] != null && tempArr[0][21].trim().length() > 0){
			payType = tempArr[0][21].trim();
		}else{
			payType = "0";
		}
		Response_time = tempArr[0][22].trim();
		TerminalId = tempArr[0][23].trim();
		Rrn = tempArr[0][24].trim();
		Request_time = tempArr[0][25].trim();
		
		System.out.println("payType : " + payType);
		System.out.println("Response_time : " + Response_time);
		System.out.println("TerminalId : " + TerminalId);
		System.out.println("Rrn : " + Rrn);
		System.out.println("Request_time : " + Request_time);
		///////<!-- ningtn add for pos end @ 20100722 -->
	}
  }

%>
<%
//******************�õ�����������***************************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept); 
%>
<head>
<title>���ֻ�G3����������</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language=javascript>
 
  onload=function()
  {		
  }  
 </script>
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
  var arrsaleName =new Array();
  var arrsalebarnd=new Array();
  var arrsaletype =new Array();
	
  //***
  function frmCfm(){
	document.frm.confirm.disabled=true;
 	/* ningtn add for pos start @ 20100722 */
		if(document.all.payType.value=="BX")
		{
			/*set �������*/
			var transerial    = "000000000000";  	                  	//����Ψһ�� ������ȡ��
			var trantype      = "01";                                  	//��������
			var bMoney        = "<%=sum_money%>";					 		//�ɷѽ��
			if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
			var tranoper      = "<%=loginNo%>";                        	//���ײ���Ա
			var orgid         = "<%=groupId%>";                        	//ӪҵԱ��������
			var trannum       = "<%=phoneNo%>";                    		//�绰����
			getSysDate();       /*ȡbossϵͳʱ��*/
			var respstamp     = document.all.Request_time.value;       	//�ύʱ��
			var transerialold = "<%=Rrn%>";			    				//ԭ����Ψһ��,�ڽɷ�ʱ�����
			var org_code      = "<%=orgCode%>";                        	//ӪҵԱ����						
			CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
			if(ccbTran=="succ") posSubmitForm();
		}
		else if(document.all.payType.value=="BY")
		{
			var transType     = "04";																	/*�������� */         
			var bMoney        = "<%=sum_money%>";							/*���׽�� */         
			if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
			var response_time = "<%=Response_time%>";                 	/*ԭ�������� */       
			var rrn           = "<%=Rrn%>";                           	/*ԭ����ϵͳ������ */ 
			var instNum       = "";                                   	/*���ڸ������� */     
			var terminalId    = "<%=TerminalId%>";                    	/*ԭ�����ն˺� */
			getSysDate();       //ȡbossϵͳʱ��                                            
			var request_time  = document.all.Request_time.value;      	/*�����ύ���� */     
			var workno        = "<%=loginNo%>";                       	/*���ײ���Ա */       
			var orgCode       = "<%=orgCode%>";                       	/*ӪҵԱ���� */       
			var groupId       = "<%=groupId%>";                       	/*ӪҵԱ�������� */   
			var phoneNo       = "<%=phoneNo%>";                   		/*���׽ɷѺ� */       
			var toBeUpdate    = "";						          		/*Ԥ���ֶ� */         
			var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
			if(icbcTran=="succ") posSubmitForm();
		}else{
			posSubmitForm();
		}
		/* ningtn add for pos end @ 20100722 */
  }
  /* ningtn add for pos start @ 20100722 */
	function posSubmitForm(){
		frm.submit();
		return true;
	}
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","���ڻ��ϵͳʱ�䣬���Ժ�......");
		myPacket.data.add("verifyType","getSysDate");
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
	}
	function doSetStsDate(packet){
		var verifyType = packet.data.findValueByName("verifyType");
		var sysDate = packet.data.findValueByName("sysDate");
		if(verifyType=="getSysDate"){
			document.all.Request_time.value = sysDate;
			return false;
		}
	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	function getCardNoPingBi(cardno)
	{
			var cardnopingbi = cardno.substr(0,6);
			for(i=0;i<cardno.length-10;i++)
			{
				cardnopingbi=cardnopingbi+"*";
			}
			cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
			return cardnopingbi;
	}
 /* ningtn add for pos start @ 20100722 */
 //***
 function printCommit()
 { 
  getAfterPrompt();
  with(document.frm){
	opNote.value=phone_no.value+"������ֻ�G3����������ҵ��";
	//phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
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
	else{
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
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
   var billType="1";                                          // Ʊ�����ͣ�1���������2��Ʊ��3�վ�
   var sysAccept=document.all.login_accept.value;             // ��ˮ��
   var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
   var mode_code=null;                                        //�ʷѴ���
   var fav_code=null;                                         //�ط�����
   var area_code=null;                                        //С������
   var opCode="8679";                                         //��������
   var phoneNo=document.all.phone_no.value;                   //�ͻ��绰
 
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
   path+=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
}

function printInfo(printType)
{
  
    var cust_info=""; //�ͻ���Ϣ
	var opr_info=""; //������Ϣ
	var note_info1=""; //��ע1
	var note_info2=""; //��ע2
	var note_info3=""; //��ע3
	var note_info4=""; //��ע4
    var retInfo = "";  //��ӡ����
    
    cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
	cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
	cust_info+="֤�����룺"+document.all.cardId_no.value+"|";
	
	opr_info+="ҵ�����ͣ����ֻ�G3����������"+"|";
    opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
    opr_info+="������Ʒ���ͺ�: "+document.all.type_name.value+"|";
    opr_info+="IMEI�룺 "+"<%=IMEINo%>"+"|";

	var jkinfo="";

	jkinfo+="�˿�ϼƣ�"+document.all.sum_money.value+"Ԫ�����У�����"+document.all.pay_money.value+"Ԫ��������"+document.all.net_money.value+"Ԫ���˻���"+document.all.used_point.value+"��|";

	opr_info+=jkinfo+"|";
    note_info1="��ע��"+document.all.opNote.value+"|";
	//retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");	
    return retInfo;	
}

//-->
</script>

</head>
<body>
<form name="frm" method="post" action="f8679_2.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">���ֻ�G3����������</div>
		</div>
        <table cellspacing="0">
		  <tr> 
            <td class="blue">��������</td>
            <td colspan="3">���ֻ�G3����������</td>         
          </tr>
          <tr> 
            <td class="blue">�ͻ�����</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_name"> 
            </td>
            <td class="blue">�ͻ���ַ</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_addr" size="40"> 
            </td>
          </tr>
          <tr> 
            <td class="blue">֤������</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_type"> 
            </td>
            <td class="blue">֤������</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_no"> 
            </td>
          </tr>
          <tr> 
            <td class="blue">ҵ��Ʒ��</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text" Class="InputGrey" v_must=1 readonly id="sm_code"> 
            </td>
            <td class="blue">����״̬</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text" Class="InputGrey" v_must=1 readonly id="run_type"> 
            </td>
          </tr>
          <tr> 
            <td class="blue">��ǰ����</td>
            <td>
			  <input name="posint" value="<%=posint%>" type="text" Class="InputGrey" v_must=1 readonly id="posint"> 
            </td>
            <td class="blue">����Ԥ��</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text" Class="InputGrey" v_must=1 readonly id="prepay_fee"> 
            </td>
          </tr>                   
          <tr>          
            <td class="blue">Ӫ������</td>
            <td>
			  <input type="text" name="sale_code" Class="InputGrey" readonly id="sale_code" value="<%=sale_name%>" >			            
			</td>
			<td class="blue">����������</td>
			<td>
			  <input type="text" name="phone_money" Class="InputGrey" readonly id="phone_money" value="<%=phone_money%>" >			            
			</td>             
          </tr>
          <tr> 
            <td class="blue">���ͻ���</td>
            <td>
			  <input name="pay_money" type="text" Class="InputGrey" id="pay_money" v_type="0_9" v_must=1 readonly value="<%=pay_money%>">
			</td>
			<td class="blue">������������</td>
             <td>
			  <input name="consume_term" type="text" Class="InputGrey" id="consume_term" v_type="money" v_must=1 readonly value="<%=consume_term%>">
			</td>
          </tr>          
          <tr>           
            <td class="blue">����������</td>
            <td>
			  <input type="text" name="net_money" Class="InputGrey" id="net_money"  readonly value="<%=net_money%>">			  
			</td>                      
            <td class="blue">��������������</td>
            <td>
			  <input type="text" name="active_term" Class="InputGrey" id="active_term" value="<%=active_term%>" readonly>			  
			</td>
		  </tr>          
          <tr> 
          	 <td class="blue">�˻���</td>
            <td>
			  <input name="used_point" type="text" Class="InputGrey" id="used_point" readonly value="<%=used_point%>">
			</td>
            <td class="blue">Ӧ�����</td>
            <td>
			  <input name="sum_money" type="text" Class="InputGrey" id="sum_money" readonly value="<%=sum_money%>">
			</td>           
          </tr> 
          <tr style="display:none"> 
            <td class="blue">��ע</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" value="���ֻ�G3����������"> 
            </td>
          </tr>
          <tr> 
            <td colspan="4"> 
            	<div align="center"> 
                <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()">              
                <input name="reset" type="reset" class="b_foot" value="���" >            
                <input name="back" onClick="javascript:history.go(-1);" type="button" class="b_foot" value="����">
                </div>
            </td>
          </tr>
        </table>
  
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="backaccept" value="<%=backaccept%>">
    <input type="hidden" name="point_money" value="0" >
    <input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="sale_type" value="0" >
    <input type="hidden" name="phone_typename" >
    <input type="hidden" name="type_name" value="<%=type_name%>">
    <input type="hidden" name="IMEINo" value="<%=IMEINo%>" >
    <!-- ningtn add for pos start @ 20100722 -->
	<input type="hidden" name="payType"  value="<%=payType%>" ><!-- �ɷ����� payType=BX �ǽ��� payType=BY �ǹ��� -->
	<input type="hidden" name="MerchantNameChs"  value=""><!-- �Ӵ˿�ʼ����Ϊ���в��� -->
	<input type="hidden" name="MerchantId"  value="">
	<input type="hidden" name="TerminalId"  value="">
	<input type="hidden" name="IssCode"  value="">
	<input type="hidden" name="AcqCode"  value="">
	<input type="hidden" name="CardNo"  value="">
	<input type="hidden" name="BatchNo"  value="">
	<input type="hidden" name="Response_time"  value="">
	<input type="hidden" name="Rrn"  value="">
	<input type="hidden" name="AuthNo"  value="">
	<input type="hidden" name="TraceNo"  value="">
	<input type="hidden" name="Request_time"  value="">
	<input type="hidden" name="CardNoPingBi"  value="">
	<input type="hidden" name="ExpDate"  value="">
	<input type="hidden" name="Remak"  value="">
	<input type="hidden" name="TC"  value="">
	<!-- ningtn add for pos start @ 20100722 -->
    <%@ include file="/npage/include/footer.jsp" %>   
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
</body>
<!-- **** ningtn add for pos @ 20100722 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100722 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</html>


