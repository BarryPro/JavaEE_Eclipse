<%
/********************
 version v2.0
 ������: si-tech
 ģ�飺ͳһ�콱
 update zhaohaitao at 2008.12.31
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%
  response.setDateHeader("Expires", 0);
%>
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%		

  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");	
	    
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%>
<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/****************���ƶ�����õ����롢���������� ����Ϣ s126bInit***********************/
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String award_type= request.getParameter("award_type");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
  paraAray1[1] = loginNo; 	    /* ��������   */
  paraAray1[2] = orgCode;	    /* ��������   */
  paraAray1[3] = "1557";	    /* ��������   */
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s1557Init", paraAray1, "29","phone",phoneNo);
%>
	<wtc:service name="s1557Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="29">			
		<wtc:param value="<%=paraAray1[0]%>" />
		<wtc:param value="<%=paraAray1[1]%>" />
		<wtc:param value="<%=paraAray1[2]%>" />
		<wtc:param value="<%=paraAray1[3]%>" />
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",print_note="",contract_flag="",high_flag="";
  //String[][] tempArr= new String[][]{};
  String errCode = retCode1;
  String errMsg = retMsg1;
  if(tempArr.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1557Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(retCode1.equals("000000") && tempArr.length>0)
  {
	
	    bp_name = tempArr[0][3];//��������
	
	    bp_add = tempArr[0][4];//�ͻ���ַ
	 
	    passwordFromSer = tempArr[0][2];//����
	
	    sm_code = tempArr[0][11];//ҵ�����
	
	    sm_name = tempArr[0][12];//ҵ���������
	 
	    hand_fee = tempArr[0][13];//������
	 
	    favorcode = tempArr[0][14];//�Żݴ���
	 
	    rate_code = tempArr[0][5];//�ʷѴ���
	 
	    rate_name = tempArr[0][6];//�ʷ�����
	 
	    next_rate_code = tempArr[0][7];//�����ʷѴ���
	 
	    next_rate_name = tempArr[0][8];//�����ʷ�����
	
	    bigCust_flag = tempArr[0][9];//��ͻ���־
	 
	    bigCust_name = tempArr[0][10];//��ͻ�����
	  
	    lack_fee = tempArr[0][15];//��Ƿ��
	 
	    prepay_fee = tempArr[0][0];//��Ԥ��
	  
	    cardId_type = tempArr[0][17];//֤������
	 
	    cardId_no = tempArr[0][18];//֤������
	 
	    cust_id = tempArr[0][19];//�ͻ�id
	  
	    cust_belong_code = tempArr[0][20];//�ͻ�����id
	  
	    group_type_code = tempArr[0][21];//���ſͻ�����
	 
	    group_type_name = tempArr[0][22];//���ſͻ���������
	 
	    imain_stream = tempArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	 
	    next_main_stream = tempArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	
	    print_note = tempArr[0][25];//�������
	
	    contract_flag = tempArr[0][27];//�Ƿ������˻�
	 
	    high_flag = tempArr[0][28];//�Ƿ��и߶��û�
	 
	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s1557Init��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}

//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//   
   //�Ż���Ϣ
  String[][] favInfo = (String[][])session.getAttribute("favInfo");   //���ݸ�ʽΪString[0][0]---String[n][0]
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

  //ҵ������ 
  //sqlsawardop  = "select distinct awardop_code,awardop_name,mode_flag,mode_code from sawardop order by awardop_code" ;
  //ArrayList sawardopArr  = co.spubqry32("4",sqlsawardop );
  //��Ʒ����
  String sqlawardCode  = "";  
  sqlawardCode  = "select distinct awardflag_code,awardflag_name,awardtype_code,awardop_code from sawardsinfo order by awardflag_code";
  //ArrayList awardCodeArr  = co.spubqry32("4",sqlawardCode );
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="4">
	<wtc:sql><%=sqlawardCode%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="awardCodeStr" scope="end" />
<%
  //��ֵ�ֵ�
  String sqlmoney  = "";  
  sqlmoney  = "select distinct money_flag,awardtype_code,awardop_code,awardflag_code from sawardsinfo order by money_flag";
  //ArrayList moneyflagArr  = co.spubqry32("4",sqlmoney );
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode3" retmsg="retMsg3" outnum="4">
	<wtc:sql><%=sqlmoney%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="moneyflagStr" scope="end" />
<%
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();  
%>
<head>
<title>ͳһ�콱 </title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
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

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  var arrFlagOne = new Array();//�۷ѷ�ʽ1
  var arrOrderCode = new Array();//��������
  var arrOrderName = new Array();//��������
  var arrMachineTypeTwo = new Array();//��������2
  var arrFlagTwo = new Array();//�۷ѷ�ʽ2
  var arrMachineFee= new Array();
  var arrPreparePay= new Array();
  var arrBindMoney= new Array();

   onload=function()
  {		

  } 

  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//У��
  function check(){
 	with(document.frm){	  
	  
	 	if( money_flag.value==""){
			rdShowMessageDialog("��ѡ���ֵ�ֵ�");
			return false;
		}
		if(awardflag_code.value==""){
			rdShowMessageDialog("��ѡ����Ʒ����");
			return false;
		}
		if(award_info.value==""){
			rdShowMessageDialog("��ѡ��һ����Ʒ");
			return false;
		}
	}
	
	  return true;
	}

  function printCommitTwo(subButton){
   	getAfterPrompt();
	//У��
	if(!check()) 
	{
		
	    return false;
	}
	setOpNote();//Ϊ��ע��ֵ
	frm.action = "f1557Confirm_1.jsp";
    //��ӡ�������ύ��
    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
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
     var h=200;
     var w=400;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	 var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	 var sysAccept=<%=printAccept%>;                            // ��ˮ��
	 var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
	 var mode_code=null;                                        //�ʷѴ���
	 var fav_code=null;                                         //�ط�����
	 var area_code=null;                                        //С������
	 var opCode="<%=opCode%>";                                  //��������
	 var phoneNo=document.frm.phoneNo.value;                    //�ͻ��绰
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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
	
	cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
	cust_info+="�ͻ�������"+document.frm.bp_name.value+"|";
	//cust_info+="�ͻ���ַ��"+"<%=bp_add%>"+"|";
	//cust_info+="֤�����룺"+"<%=cardId_no%>"+"|";
	
    opr_info+="ҵ�����ͣ�"+"��Ʒ��ȡ"+"|";
    opr_info+="��ˮ��"+"<%=printAccept%>"+"|";
    opr_info+="��Ʒ���ƣ�"+document.frm.award_info.value+"|";
    opr_info+="������棺"+"<%=print_note%>"+"|"; 

	note_info1+="��ע��"+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;
  }




  
 /******Ϊ��ע��ֵ********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	   document.frm.opNote.value = "��Ʒ��ȡ;"+document.frm.phoneNo.value+";"+";"+document.frm.award_info.value; 
	}
	
	return true;
}
function awardoptypeChange(){

	if(document.all.awardop_type.value==""){
	rdShowMessageDialog("��ѡ��ҵ������");
	return false;
	}
	//if( (document.all.awardop_type.value=="0001") ||(document.all.awardop_type.value=="0002") || (document.all.awardop_type.value=="0003")||(document.all.awardop_type.value=="0004"))
	//if (parseInt(document.all.awardop_type.value,10)<=10)
	//{
   		var getAccountId_Packet = new AJAXPacket("pubGetopType.jsp","");
    	getAccountId_Packet.data.add("retType","getawardType");
		getAccountId_Packet.data.add("awardtype","<%=award_type%>");
		getAccountId_Packet.data.add("awardop_code",document.all.awardop_type.value);
	
		getAccountId_Packet.data.add("cust_id","<%=cust_id%>");
	
		getAccountId_Packet.data.add("regionCode","<%=regionCode%>");
	
		core.ajax.sendPacket(getAccountId_Packet);
		getAccountId_Packet=null;
	//}

}
function doProcess(packet)
{	
	var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage");	
    if(retType=="getawardType")
    {
    	if(retCode=="000000")
	 {
	  	awardflagcode();
	  	
	  	
         	//var sawardflagcode()im_type = packet.data.findValueByName("sim_type");    	    
        	// var sim_typename = packet.data.findValueByName("sim_typename");
		//document.all.simType.value=jtrim(sim_type);
		// document.all.simTypeName.value=jtrim(sim_typename);
	  }
      	else
      	{
		retMessage = retMessage + "[errorCode2:" + retCode + "]";
		rdShowMessageDialog(retMessage,0);
		dawardflagcode();
		dmoneyflag();
		return false;
      	}
      	
     }
     
    

}
 var arrawardcode= new Array();
 var arrawardname= new Array();
 var arrawardtype= new Array();
 var arrawardop= new Array();
 var arrmoneytype= new Array();
 var arrmoneyop= new Array();
 var arrmoney= new Array();
 var arrmoneyawardflag=new Array();
  <%
 for(int i=0;i<awardCodeStr.length;i++)
  {
	out.println("arrawardcode["+i+"]='"+awardCodeStr[i][0]+"';\n");
	out.println("arrawardname["+i+"]='"+awardCodeStr[i][1]+"';\n");
	out.println("arrawardtype["+i+"]='"+awardCodeStr[i][2]+"';\n");
	out.println("arrawardop["+i+"]='"+awardCodeStr[i][3]+"';\n");
  } 
  for(int l=0;l<moneyflagStr.length;l++)
  {
	out.println("arrmoney["+l+"]='"+moneyflagStr[l][0]+"';\n");
	System.out.println("arrmoney["+l+"]='"+moneyflagStr[l][0]+"';\n");
	out.println("arrmoneytype["+l+"]='"+moneyflagStr[l][1]+"';\n");
	out.println("arrmoneyop["+l+"]='"+moneyflagStr[l][2]+"';\n");
	out.println("arrmoneyawardflag["+l+"]='"+moneyflagStr[l][3]+"';\n");
	
  } 
  %> 
//�����Ʒ����������
function dawardflagcode(){
	for (var q= document.all.awardflag_code.options.length;q>=0;q--){  document.all.awardflag_code.options[q]=null;}
}
//������Ʒ����������
function awardflagcode(){
   
	var y ;
	 var myEle ;
   var x ;
   
   // Empty the second drop down box of any choices
   for (var q= document.all.awardflag_code.options.length;q>=0;q--){  document.all.awardflag_code.options[q]=null;}
   
   // ADD Default Choice - in case there are no values
   myEle = document.createElement("option") ;
   myEle = document.createElement("option") ;
        myEle.value = "";
        myEle.text ="--��ѡ��--";
         document.all.awardflag_code.add(myEle) ;
   for ( x = 0 ; x <  arrawardcode.length  ; x++ )
 {
  	
      if ( document.all.awardop_type.value==arrawardop[x] && <%=award_type%>==arrawardtype[x] )
      {
        myEle = document.createElement("option") ;
        myEle.value = arrawardcode[x] ;
        myEle.text = arrawardname[x] ;
         document.all.awardflag_code.add(myEle) ;
       
      }
   }
}
//��ռ�ֵ�ֵ�������
function dmoneyflag(){
	for (var q= document.all.money_flag.options.length;q>=0;q--){  document.all.money_flag.options[q]=null;}
	 dawardinfo();
}
function moneyflagchange(){
moneyflag();
dawardinfo();
}
//���ɼ�ֵ�ֵ�������
function moneyflag(){
	var y ;
	 var myEle ;
   var x ;
   
   // Empty the second drop down box of any choices
   for (var q= document.all.money_flag.options.length;q>=0;q--){  document.all.money_flag.options[q]=null;}
   
   // ADD Default Choice - in case there are no values
   myEle = document.createElement("option") ;
   myEle = document.createElement("option") ;
        myEle.value = "";
        myEle.text ="--��ѡ��--";
         document.all.money_flag.add(myEle) ;
        // alert(arrmoneyop.length);
   for ( x = 0 ; x <  arrmoneyop.length  ; x++ )
 {
  	
      if ( document.all.awardop_type.value==arrmoneyop[x] && <%=award_type%>==arrmoneytype[x] && document.all.awardflag_code.value==arrmoneyawardflag[x])
      {
        myEle = document.createElement("option") ;
        myEle.value = arrmoney[x] ;
        myEle.text = arrmoney[x] ;
         document.all.money_flag.add(myEle) ;
       
      }
   }
   dawardinfo();
}
function choiceSelWay(){
	if( document.all.money_flag.value==""){
		rdShowMessageDialog("��ѡ���ֵ�ֵ�");
		return false;
	
	}
	if(document.all.awardflag_code.value==""){
		rdShowMessageDialog("��ѡ����Ʒ����");
		return false;
	}
	getawardinfo();
}
function getawardinfo(){
 	var pageTitle = "��Ʒ��Ϣ��ѯ";
	var fieldName = "��ƷID|��Ʒ����|";
	var sqlStr = "select awardinfo_code,award_info from sawardsinfo where awardtype_code='"+"<%=award_type%>"+"' and awardop_code='"+document.all.awardop_type.value+"' and awardflag_code='"+document.all.awardflag_code.value+"' and money_flag='"+document.all.money_flag.value+"'";	
	var selType = "S";    //'S'��ѡ��'M'��ѡ
   	var retQuence = "2|0|1|";
	var retToField = "in0|in1|";
	custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 
}
function custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    ����1(pageTitle)����ѯҳ�����
    ����2(fieldName)�����������ƣ���'|'�ָ��Ĵ�
    ����3(sqlStr)��sql���
    ����4(selType)������1 rediobutton 2 checkbox
    ����5(retQuence)����������Ϣ������������� �������ʶ����'|'�ָ�����"3|0|2|3"��ʾ����3����0��2��3
    ����6(retToField))������ֵ����������,��'|'�ָ�
    */
  
    var path = "pubGetawardInfo.jsp";   //����Ϊ*
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
   
    retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");

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
function dawardinfo(){
   document.all.award_info.value="";
   document.all.awardinfo_code.value="";
}
//-->
</script>

</head>


<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

<table cellspacing="0">
	<tr>
		<td class="blue">�ֻ�����</td>
		<td>
			<input name="phoneNo" type="text" class="InputGrey" id="phoneNo" value="<%=phoneNo%>" readonly> 
		</td> 
		<td class="blue">��������</td>
		<td>
			<input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>	
			<input name="award_type" type="hidden" value=<%=award_type%>> 		  
		</td>           
	</tr>
	<tr > 
		<td class="blue">ҵ��Ʒ��</td>
		<td>
			<input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
		</td>
		<td class="blue">��ͻ���־</td>
		<td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
		</td>            
	</tr>
	<tr> 
		<td class="blue">֤������</td>
		<td>
			<input name="cardId_type" type="text" class="InputGrey" id="cardId_type" value="<%=cardId_type%>" readonly>
		</td>
		<td class="blue">֤������</td>
		<td>
			<input name="cardId_no" type="text" class="InputGrey" id="cardId_no" value="<%=cardId_no%>" readonly>
		</td>            
	</tr>
	<tr> 
		<td class="blue">��ǰ���ײ�</td>
		<td colspan="3">
			<input name="rate_name" type="text" class="InputGrey" id="rate_name" value="<%=rate_code+"--"+rate_name%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">ҵ������</td>
		<td colspan="3">
		<select  name="awardop_type" class="button"  onChange="awardoptypeChange()">
		<option value="">--��ѡ��--</option>
		<wtc:qoption name="sPubSelect" outnum="4">
		<wtc:sql>select distinct awardop_code,awardop_name,mode_flag,mode_code from sawardop order by awardop_code</wtc:sql>
		</wtc:qoption>
		</select>
		<font color="orange">*</font>
		</td>
	</tr>
	<tr>
		<td class="blue">��Ʒ����</td>
		<td>
		<select  name="awardflag_code" size=1 class="button" onChange="moneyflagchange()" >
		
		</select>
		<font color="orange">*</font>
		</td> 
		<td class="blue">��ֵ�ֵ�</td>
		<td>
		<select  name="money_flag" size=1 class="button" onChange="dawardinfo()">
		
		</select>
		<font color="orange">*</font>
		</td> 
	</tr>
	<tr >
		<td class="blue">��Ʒ����</td>
		<td colspan="3">
			<input name="award_info" type="text" class="InputGrey" id='in1' readonly>
			<input name="awardinfo_code" type="hidden" id='in0'>
			<input name=custIdQuery type=button onClick="choiceSelWay();" class="b_text" style="cursor:hand" id="custIdQuery" value=��Ϣ��ѯ>
		</td>
	</tr>
	<tr> 
		<td class="blue">��ע</td>
		<td colspan="3">
			<input name="opNote" type="text" value="" size="40" onfocus="setOpNote()" readOnly> 
		</td>
	</tr>
	<tr> 
	<td id="footer" colspan="4"> 
		<div align="center"> 
		<input name="commit" id="commit" type="button" class="b_foot" value="ȷ��&��ӡ" onClick="printCommitTwo(this)" >
		<input name="reset" type="reset" class="b_foot" value="���" >
		<input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
		</div>
	</td>
	</tr>
</table>
 
  <input type="hidden" name="iOpCode">
  <input type="hidden" name="iAddStr">
  <input type="hidden" name="belong_code">
  <input type="hidden" name="i2">
  <input type="hidden" name="i16">
  <input type="hidden" name="ip">
  <input type="hidden" name="i1">
  <input type="hidden" name="i4" value="<%=bp_name%>">
  <input type="hidden" name="i5">
  <input type="hidden" name="i6">
  <input type="hidden" name="i7">
  <input type="hidden" name="ipassword">
  <input type="hidden" name="group_type">
  <input type="hidden" name="ibig_cust">
  <input type="hidden" name="i18">
  <input type="hidden" name="i19">
  <input type="hidden" name="i20">
  <input type="hidden" name="i8">
  <input type="hidden" name="do_note">
  <input type="hidden" name="favorcode">
  <input type="hidden" name="maincash_no">
  <input type="hidden" name="imain_stream">
  <input type="hidden" name="next_main_stream">
  <input type="hidden" name="new_rate_code">
  <input type="hidden" name="pay_type">
  <input type="hidden" name="flag_code_1">
  <input type="hidden" name="region_code" value='<%=regionCode%>'>
  <input type="hidden" name="sm_code" value='<%=sm_code%>'>
  <input type="hidden" name="order_code">
  <input type="hidden" name="print_note" value="<%=print_note%>">
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
  <input type="hidden" name="opCode" value="<%=opCode%>">
  <input type="hidden" name="opName" value="<%=opName%>">
  <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
<script language="JavaScript">
  <%if((high_flag.trim()).equals("Y")){%>
    rdShowMessageDialog('��ʾ: ��ע��,���û�Ϊ�и߶��û���');
  <%}%>
</script>
