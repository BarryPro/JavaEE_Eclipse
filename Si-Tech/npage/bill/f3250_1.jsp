<%
/********************
* ����: ��ѡ�ײͰ��� 3250
* version v3.0
* ������: si-tech
* update by qidp @ 2008-11-25
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>

<%@ page import="java.io.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="../../npage/public/fPubPrintNote.jsp" %>

<%
    String opCode = "3250";
    String opName = "��ѡ�ײͰ���";
    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
    ArrayList retArray = new ArrayList();
    String[][] baseInfoSession = (String[][])arrSession.get(0);
    String[][] otherInfoSession = (String[][])arrSession.get(2);
    String[][] pass = (String[][])arrSession.get(4);

    String iPhoneNo = request.getParameter("srv_no");
    String iLoginNo = (String)session.getAttribute("workNo");
    String iOrgCode = request.getParameter("iOrgCode");
    String iOpCode = opCode;
    //String pw_favor = request.getParameter("pw_favor");
    String thepassword = request.getParameter("ipassword");
             
String printAccept="";                                                 
printAccept = getMaxAccept();                                          
System.out.println("**************************sysAccept="+printAccept);

    String loginNo = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String powerCode= otherInfoSession[0][4];
    String orgCode = baseInfoSession[0][16];
    String ip_Addr = request.getRemoteAddr();
    String regionCode = orgCode.substring(0,2);
    String disCode = orgCode.substring(2,4);
    String regionName = otherInfoSession[0][5];
    String loginNoPass = pass[0][0];
    String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
    String aftertrim = baseInfoSession[0][5].trim();
    String[][] result = new String[][]{};
    //S1100View callView = new S1100View();
    String sqlStr="";
    int recordNum=0;
    int i=0;
    
    //comImpl co1 = new comImpl();
    String paraStr[]=new String[1];
    String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
  %>
    <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=iPhoneNo%>" outnum="2" retmsg="retMsg2">
        <wtc:sql><%=prtSql%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retPubSelectArr"  scope="end"/>

  <%
  paraStr[0]=retPubSelectArr[0][0];
%>
<%
    ArrayList arrSession2 = (ArrayList)session.getAttribute("allArr");
	  String[][] baseInfoSession2 = (String[][])arrSession2.get(0);


  ArrayList retList = new ArrayList();
  String[][] tempArr= new String[][]{};

  String retFlag="",retMsg="";
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";


	


	//SPubCallSvrImpl co2 = new SPubCallSvrImpl();
	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = "3250";
	System.out.println("iPhoneNo === "+ iPhoneNo);
	System.out.println("loginNo === "+ loginNo);
	System.out.println("orgCode === "+ orgCode);
	System.out.println("iOpCode === "+ iOpCode);
%>
<wtc:service name="s3250Qry" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="err_code_s3250Qry" retmsg="err_msg_s3250Qry" outnum="29">
    <wtc:param value="<%=inputParsm[0]%>"/>
    <wtc:param value="<%=inputParsm[1]%>"/>
    <wtc:param value="<%=inputParsm[2]%>"/>
    <wtc:param value="<%=inputParsm[3]%>"/>
</wtc:service>
<wtc:array id="retS3250QryArr"  scope="end"/>


<%
  //retList = co2.callFXService("s3250Qry", inputParsm, "29","phone",iPhoneNo);
  String errCode = err_code_s3250Qry;
  String errMsg = err_msg_s3250Qry;


	//co2.printRetValue();

  if(retS3250QryArr == null)
  {
	   retFlag = "1";
	   retMsg = "s3250Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals("000000") ){
//	  tempArr = retS3250QryArr[0][3];
	  if(!(retS3250QryArr[0][3].equals(""))){
	    bp_name = retS3250QryArr[0][3];           //��������
	  }

//	  tempArr = retS3250QryArr[0][4];
	  if(!(retS3250QryArr[0][4].equals(""))){
	    bp_add = retS3250QryArr[0][4];            //�ͻ���ַ
	  }

//	  tempArr = retS3250QryArr[0][2];
	  if(!(retS3250QryArr[0][2].equals(""))){
	    passwordFromSer = retS3250QryArr[0][2];  //����
	  }

//	  tempArr = retS3250QryArr[0][11];
	  if(!(retS3250QryArr[0][11].equals(""))){
	    sm_code = retS3250QryArr[0][11];         //ҵ�����
	  }

//	  tempArr = retS3250QryArr[0][12];
	  if(!(retS3250QryArr[0][12].equals(""))){
	    sm_name = retS3250QryArr[0][12];        //ҵ���������
	  }

//	  tempArr = retS3250QryArr[0][13];
	  if(!(retS3250QryArr[0][13].equals(""))){
	    hand_fee = retS3250QryArr[0][13];      //������
	  }

//	  tempArr = retS3250QryArr[0][14];
	  if(!(retS3250QryArr[0][14].equals(""))){
	    favorcode = retS3250QryArr[0][14];     //�Żݴ���
	  }

//	  tempArr = retS3250QryArr[0][5];
	  if(!(retS3250QryArr[0][5].equals(""))){
	    rate_code = retS3250QryArr[0][5];     //�ʷѴ���
	  }

//	  tempArr = retS3250QryArr[0][6];
	  if(!(retS3250QryArr[0][6].equals(""))){
	    rate_name = retS3250QryArr[0][6];    //�ʷ�����
	  }

//	  tempArr = retS3250QryArr[0][7];
	  if(!(retS3250QryArr[0][7].equals(""))){
	    next_rate_code = retS3250QryArr[0][7];//�����ʷѴ���
	  }

//	  tempArr = retS3250QryArr[0][8];
	  if(!(retS3250QryArr[0][8].equals(""))){
	    next_rate_name = retS3250QryArr[0][8];//�����ʷ�����
	  }

//	  tempArr = retS3250QryArr[0][9];
	  if(!(retS3250QryArr[0][9].equals(""))){
	    bigCust_flag = retS3250QryArr[0][9];//��ͻ���־
	  }

//	  tempArr = retS3250QryArr[0][10];
	  if(!(retS3250QryArr[0][10].equals(""))){
	    bigCust_name = retS3250QryArr[0][10];//��ͻ�����
	  }

//	  tempArr = retS3250QryArr[0][15];
	  if(!(retS3250QryArr[0][15].equals(""))){
	    lack_fee = retS3250QryArr[0][15];//��Ƿ��
	  }

//	  tempArr = retS3250QryArr[0][16];
	  if(!(retS3250QryArr[0][16].equals(""))){
	    prepay_fee = retS3250QryArr[0][16];//��Ԥ��
	  }

//	  tempArr = retS3250QryArr[0][17];
	  if(!(retS3250QryArr[0][17].equals(""))){
	    cardId_type = retS3250QryArr[0][17];//֤������
	  }

//	  tempArr = retS3250QryArr[0][18];
	  if(!(retS3250QryArr[0][18].equals(""))){
	    cardId_no = retS3250QryArr[0][18];//֤������
	  }

//	  tempArr = retS3250QryArr[0][19];
	  if(!(retS3250QryArr[0][19].equals(""))){
	    cust_id = retS3250QryArr[0][19];//�ͻ�id
	  }

//	  tempArr = retS3250QryArr[0][20];
	  if(!(retS3250QryArr[0][20].equals(""))){
	    cust_belong_code = retS3250QryArr[0][20];//�ͻ�����id
	  }

//	  tempArr = retS3250QryArr[0][21];
	  if(!(retS3250QryArr[0][21].equals(""))){
	    group_type_code = retS3250QryArr[0][21];//���ſͻ�����
	  }

//	  tempArr = retS3250QryArr[0][22];
	  if(!(retS3250QryArr[0][22].equals(""))){
	    group_type_name = retS3250QryArr[0][22];//���ſͻ���������
	  }

//	  tempArr = retS3250QryArr[0][23];
	  if(!(retS3250QryArr[0][23].equals(""))){
	    imain_stream = retS3250QryArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	  }

//	  tempArr = retS3250QryArr[0][24];
	  if(!(retS3250QryArr[0][24].equals(""))){
	    next_main_stream = retS3250QryArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	  }

//	  tempArr = retS3250QryArr[0][25];
	  if(!(retS3250QryArr[0][25].equals(""))){
	    print_note = retS3250QryArr[0][25];//�������
	  }

//	  tempArr = retS3250QryArr[0][27];
	  if(!(retS3250QryArr[0][27].equals(""))){
	    contract_flag = retS3250QryArr[0][27];//�Ƿ������˻�
	  }

//	  tempArr = retS3250QryArr[0][28];
	  if(!(retS3250QryArr[0][28].equals(""))){
	    high_flag = retS3250QryArr[0][28];//�Ƿ��и߶��û�
	  }
	 }else{%>
	 <script language="JavaScript">
<!--
  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
<%	 }
	}





%>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
<title>��ѡ�ײͰ���</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>



<script language="JavaScript">
<!--
  var arrbrandcode = new Array();//�ֻ��ͺŴ���
  var arrbrandname = new Array();//�ֻ��ͺ�����
  var arrbrandmoney = new Array();//�����̴���

  var arrPhoneType = new Array();//�ֻ��ͺŴ���
  var arrPhoneName = new Array();//�ֻ��ͺ�����
  var arrAgentCode = new Array();//�����̴���
  var selectStatus = 0;

  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();
  var arrtypemoney=new Array();
  var arrsalemoney=new Array();

  var arrdetbase=new Array();
  var arrdetfree=new Array();
  var arrdetfavour=new Array();
  var arrdetconsume=new Array();
  var arrdetmonbase=new Array();
  var arrdetmode=new Array();
  var arrdetsummoney=new Array();
  var arrdetsalecode=new Array();
//core.loadUnit("debug");
//core.loadUnit("rpccore");

//onload = function()
//{
//core.rpc.onreceive = doProcess;
//} 

function doProcess(packet){
	var mode_note = packet.data.findValueByName("mode_note");
	document.all.mode_note.value=mode_note;
}

function getModeNote()
{
	var mode_code = document.all.addModeCode.value;
	var region_code = "<%=regionCode%>";
	var getmodenote_Packet = new AJAXPacket("../bill/getModeNote.jsp","���ڲ�ѯ�ײ����������Ժ�......");
	getmodenote_Packet.data.add("mode_code",mode_code);
	getmodenote_Packet.data.add("region_code",region_code);
	getmodenote_Packet.data.add("op_code","<%=iOpCode%>");
	core.ajax.sendPacket(getmodenote_Packet);
	getmodenote_Packet = null;

}


  //--------2---------��֤��ťר�ú���-------------

function frmCfm()
{
	frm.submit();
	return true;
}

 function chkType()
 {
 	document.all.addModeCode.value ="";
 	document.all.addModeName.value ="";
 }
 function getInfo_code()
	{
  	//���ù���js
  	var regionCode = "<%=regionCode%>";
  	var disCode = "<%=disCode%>";
  	var modeCode = "<%=rate_code%>";
		modeCode = replaceSpacialCharacter(modeCode);
  	var modeType = document.all.modeType.value;
  	//alert("region_code="+regionCode);
  	//alert("disCode="+disCode);
  	//alert("modeCode="+modeCode);
  	//alert("modeType="+modeType);
    var pageTitle = "��ѡ�ײ�ѡ��";
    var fieldName = "�ײʹ���|�ײ�����|�������|��������|��Ч��ʽ|";//����������ʾ���С�����
    var sqlStr = "";
    if (modeType == "YnL1")
    {
    	sqlStr = "select b.mode_code,b.mode_name,to_char(c.prepay_least),to_char(d.time_cycle)||'����',decode(e.send_flag,'0','24Сʱ����Ч','����') "+
				 "from sBillModeCode b,sBillModeRelease c,sBillModeDetail d,sBillModeType e "+
				 "where b.region_code='"+regionCode+"' "+
				 "and b.mode_type='"+modeType+"' "+
				 "and b.region_code=e.region_code "+
				 "and b.mode_type=e.mode_type "+
				 "and b.region_code=substr(c.group_id,1,2) "+
				 "and b.mode_code=c.mode_code "+
				 "and b.region_code=d.region_code "+
				 "and b.mode_code=d.mode_code "+
				 "and d.mode_time='Y' and d.time_flag='1' "+
				 "and sysdate between b.start_time and b.stop_time order by b.order_fav";
    }
    else
    {
    	sqlStr = "select a.add_mode,b.mode_name,to_char(c.prepay_least),to_char(d.time_cycle)||'����',decode(e.send_flag,'0','24Сʱ����Ч','����') "+
				 "from cBillBaDepend a,sBillModeCode b,sBillModeRelease c,sBillModeDetail d,sBillModeType e "+
				 "where a.region_code='"+regionCode+"' and a.district_code in ('"+disCode+"','99')"+
				 "and a.mode_code='"+modeCode+"' and b.mode_type='"+modeType+"' "+
				 "and a.region_code=b.region_code "+
				 "and a.region_code=e.region_code "+
				 "and b.mode_type=e.mode_type "+
				 "and a.region_code=d.region_code "+
				 "and a.region_code=substr(c.group_id,1,2) "+
				 "and a.add_mode=c.mode_code "+
				 "and a.add_mode=d.mode_code "+
				 "and a.add_mode=b.mode_code and a.choiced_flag ='0' "+
				 "and d.mode_time='Y' and d.time_flag='1' "+
				 "and sysdate between b.start_time and b.stop_time order by b.order_fav";
    }
    //alert(sqlStr);
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "5|0|1|2|3|4|";//�����ֶ�
    var retToField = "addModeCode|addModeName|prePayLeast|timeCycle|send_flag|";//���ظ�ֵ����
    if(MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50));

	document.all.do_note.value = "��ѡ�����ײ����룬�ײʹ��룺"+document.all.addModeCode.value;
 	getModeNote();
 	getMidPrompt("10442",codeChg(document.getElementById("addModeCode").value),"ipTd");
	}

function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
    if(retInfo ==undefined)
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
	return true;
}

function printCommit()
{ 
    getAfterPrompt();
 	if(!checkElement(document.all.phoneNo)) return;
	if(document.all.addModeCode.value==""){
		rdShowMessageDialog("��ѡ���ѡ�ײʹ���!");
		document.all.addModeCode.focus();
		return false;
	}
	if (document.all.i9.value == "Y")
	{
		rdShowMessageDialog("�����û�����������ҵ��");
		return false;
	}
	if (parseInt(document.all.prePayLeast.value,10)>parseInt(document.all.oPrepayFee.value,10))
	{
		rdShowMessageDialog("�û�����Ԥ��С�ڰ�������Ƚ��ѣ�");
		return false;
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
   
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var pType="subprint";
   var billType="1";
   var sysAccept = "<%=printAccept%>";
   var phone_no = "<%=iPhoneNo%>"
   var mode_code = document.all.addModeCode.value+"~";
   var fav_code = null;
   var area_code = null;
   var printStr = printInfo(printType);

   
   //var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   //var path = "<%=request.getContextPath()%>/page/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
   //var ret=window.showModalDialog(path,printStr,prop);

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
   var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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
	//retInfo+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
	//retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺 "+document.all.phoneNo.value+"|";
	cust_info+="�ͻ������� "+document.all.oCustName.value+"|";
	cust_info+="�ͻ���ַ�� "+document.all.i5.value+"|";
	cust_info+="֤�����룺 "+document.all.i7.value+"|";
	
	opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm	:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"�û�Ʒ��: "+document.all.oSmName.value+ "|";

	opr_info+="����ҵ�񣺿�ѡ�����ײ�����"+"  ������ˮ��"+document.all.login_accept.value+"|";
	opr_info+="����Ŀ�ѡ�����ʷѣ�"+document.all.addModeName.value+"--"+document.all.addModeCode.value+"|";
	opr_info+="ҵ����Чʱ�䣺"+document.all.send_flag.value+"|";
	
	note_info1+="��ѡ�����ʷ�������"+document.all.mode_note.value+"|";
	note_info2+=" "+"|";
	if (document.all.modeType.value == "YnL1")
	{
		note_info2+="��ע:"+"|";
		if (document.all.timeCycle.value == "12����")
			note_info2+="1���������Ѱ������30Ԫ/�꣬��ʱ����24Сʱ����Ч����ʱȡ����24Сʱ����Ч��"+"|";
		else if (document.all.timeCycle.value == "3����")
			note_info2+="1���������Ѱ�������9Ԫ/������ʱ����24Сʱ����Ч����ʱȡ����24Сʱ����Ч��"+"|";
		note_info2+="2�������������Ѱ��ꡢ����ҵ���൱�����ò��ɼ���ת��13800XYZ309���ֻ��ն˲���ȡ�����������ò��ɼ���ת����������,���ɼ���ת��13800XYZ309�Ĺ��ܽ�ʧЧ��"+"|";
		note_info2+="3���˶��������Ѱ���������ҵ�񣬰������˲�ת��"+"|";
		note_info2+="4���˶�������Ӫҵǰ̨����"+"|";
	}	
	else
		note_info2+="��ע:"+document.all.do_note.value+"|";
	//document.all.cust_info.value=cust_info+"#";
	//document.all.opr_info.value=opr_info+"#";
	//document.all.note_info1.value=note_info1+"#";
	//document.all.note_info2.value=note_info2+"#";
	//document.all.note_info3.value=note_info3+"#";
	//document.all.note_info4.value=note_info4+"#";
	//retInfo=document.all.cust_info.value+" "+"|"+"---------------------------------------------"+"|"+" "+"|"+document.all.opr_info.value+" "+"|"+" "+"|"+document.all.note_info1.value+document.all.note_info2.value+document.all.note_info3.value+document.all.note_info4.value+" "+"|"+" "+"|"+" "+"|"+" "+"|"+"<%=loginNote.trim()%>"+"#";

    //retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
}

function replaceSpacialCharacter(source)
{
	source = source.replace("#","%23");
	source = source.replace("&","%26");
	source = source.replace("+","%2b");
	source = source.replace("?","%3f");
	source = source.replace("_","%5f");
	source = source.replace('"',"%22");
	source = source.replace("'","%27");
	return source;
}
//-->
</script>

</head>

<body>
	<form name="frm" method="post" action="f3250Cfm.jsp" onKeyUp="chgFocus(frm)">
	    <%@ include file="/npage/include/header.jsp" %>
	    <div class="title">
       <div id="title_zi">�ײ�ѡ��</div>
    </div>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=paraStr[0]%>">
	<table border="0" >
		<tr>
			<td class="blue">�ײ����</td>
			<td class="blue" colspan="3">
			<select id=modeType name=modeType onChange="chkType()">
<%				//sqlStr ="select distinct trim(mode_type),trim(type_name) from sAddModeType a where region_code='"+regionCode+"'" ;
				//System.out.println("sqlStr === "+ sqlStr);
				//retArray = callView.view_spubqry32("2",sqlStr);
				//result = (String[][])retArray.get(0);
				//recordNum = result.length;
				//for(i=0;i<recordNum;i++)
				//{
				//	out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][0]+"-->"+result[i][1] + "</option>");
				//}
%>
                <wtc:qoption name="sPubSelect" outnum="2">
                    <wtc:sql>select distinct trim(mode_type),trim(mode_type)||'-->'||trim(type_name) from sAddModeType a where region_code='?'</wtc:sql>
                    <wtc:param value="<%=regionCode%>"/>
                </wtc:qoption>
			</select>
			</td>
		</tr>
		<tr>
			<td class="blue">�ֻ�����</td>
            <td class="blue">
				<input type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" v_name="�ֻ�����" readonly >
            <td class="blue">�ͻ�ID</td>
            <td class="blue">
				<input name="oIdNo" type="text" id="oIdNo" value="<%=cust_id%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">�ͻ�����</td>
			<td class="blue">
				<input name="oCustName" type="text" id="oCustName" value="<%=bp_name%>" readonly>
			</td>
			<td class="blue">֤������</td>
            <td class="blue">
				<input name="oIdType" type="text" id="oIdType" value="<%=cardId_type%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">ҵ��Ʒ��</td>
            <td class="blue">
				<input name="oSmName" type="text" id="oSmName" value="<%=sm_name%>" readonly>
			</td>
			<td class="blue">
				�˻�Ԥ��
			</td>
            <td class="blue">
				<input name="oPrepayFee" type="text" id="oPrepayFee" value="<%=prepay_fee%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">��ǰ�ʷ�</td>
            <td class="blue">
				<input name="oModeCode" type="text" id="oModeCode" value="<%=rate_code%>" readonly>
			</td>
            <td class="blue">�ʷ�����</td>
            <td class="blue">
				<input name="oModeName" type="text" id="oModeName" value="<%=rate_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">�����ʷ�</td>
            <td class="blue">
				<input name="oNextModeCode" type="text" id="oNextModeCode" value="<%=next_rate_code%>" readonly>
			</td>
            <td class="blue">�ʷ�����</td>
            <td class="blue">
				<input name="oNextModeName" type="text" id="oNextModeName" value="<%=next_rate_name%>" readonly>
			</td>
		</tr>
		<tr style="display:none">
			<td class="blue">&nbsp;</td>
            <td class="blue">
				<input name="oCustadd" type="hidden" id="oCustadd" value="<%=bp_add%>" readonly>
			</td>
            <td class="blue">&nbsp;</td>
            <td class="blue">
				<input name="oIdName" type="hidden" id="oIdName" value="<%=cardId_no%>" readonly>
			</td>
		</tr>
          <tr>
            <td class="blue">�ײʹ���</td>
            <td class="blue" id="ipTd">
              <input type="text" name="addModeCode" id="addModeCode" readonly>
			  <input class="b_text" type="button" name="qryId_No" value="��ѯ" onClick="getInfo_code()" >

			  <font class="orange">*</font>
			</td>
            <td class="blue">
            	�ײ�����
            </td>
            <td class="blue">
				<input name="addModeName" type="text" id="addModeName" v_type="string" v_must=1 value="" readonly>
			</td>

          </tr>
          <tr>
            <td class="blue">�������</td>
            <td class="blue">
			  <input name="prePayLeast" type="text" id="prePayLeast" v_type="string" v_must=1 value="" readonly>
			</td>
            <td class="blue">��������</td>
            <td class="blue">
			  <input name="timeCycle" type="text" id="timeCycle" v_type="string" v_must=1 value="" readonly>
			  <input name="send_flag" type="hidden" id="send_flag" v_type="string" v_must=1 value="" readonly>
			  <input name="mode_note" type="hidden" id="mode_note" v_type="string" v_must=1 value="" readonly>
			</td>
          </tr>
		</tr>
		<tr>
 			<td class="blue" style="display:none">
				�û���ע
			</td>
            <td colspan="3" class="blue" style="display:none">
				<input name="do_note" type="text" class="button" id="do_note" value="" size="60" maxlength="60" >
			</td>
		</tr>
		
		<tr>
                <td nowrap colspan="4" id="footer">
                    <div align="center"> 
        				<input name="commit" id="commit" type="button" class="b_foot"   value="ȷ��&��ӡ" onClick="printCommit();">
                        <input name="reset" type="reset" class="b_foot" value="���" >
                        <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
                    </div>
                </td>
            </tr>
	</table>


			<input type="hidden" name="iOpCode" value="3250">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<input type="hidden" name="i2" value="<%=cust_id%>">
			<input type="hidden" name="i16" value="<%=rate_code%>">
			<input type="hidden" name="ip" value="">

			<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">
			<input type="hidden" name="print_note" value="<%=print_note%>">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="">
			<input type="hidden" name="i4" value="<%=bp_name%>">
			<input type="hidden" name="i5" value="<%=bp_add%>">
			<input type="hidden" name="i6" value="<%=cardId_type%>">
			<input type="hidden" name="i7" value="<%=cardId_no%>">
			<input type="hidden" name="i8" value="<%=sm_code%>--<%=sm_name%>">
			<input type="hidden" name="i9" value="<%=contract_flag%>">

			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">
			<input type="hidden" name="ipassword" value="<%=thepassword%>">
			<input type="hidden" name="mode_type" value="">
			<input type="hidden" name="New_Mode_Name" value=" ">
			<input type="hidden" name="return_page" value="/npage/bill/f3250_login.jsp">
			<input type="hidden" name="login_accept" value="<%=printAccept%>">
			<input type="hidden" name="choiced_flag" value="">
			
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
