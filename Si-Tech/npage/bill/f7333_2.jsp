<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ��ͥ����ƻ����
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
  System.out.println("=================fg333_2.jsp=============");
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");

  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String loginPwd    = (String)session.getAttribute("password");
  String regionCode = orgCode.substring(0,2);
  String flag = "false";
%>
<%
  String retFlag="",retMsg="";//����Ƿ�У��ʧ�ܵı�־����Ϣ
/****************���ƶ�����õ����롢������������ܰ��ͥ�������Ϣ s1251Init***********************/
  String[] paraAray1 = new String[4];

  String main_card = request.getParameter("chief_srv_no");
  String op_code = request.getParameter("opCode");
  String openType = request.getParameter("open_type");/* ��������*/
  String TmpPhoneNo = main_card.substring(0,3);
  String passwordFromSer="";

  paraAray1[0] = main_card;		/* �ֻ�����   */
  paraAray1[1] = loginNo; 	/* ��������   */
  paraAray1[2] = orgCode;	/* ��������   */
  paraAray1[3] = op_code;	/* ��������   */
  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s7328Qry", paraAray1, "39", "phone",main_card);
%>
	<wtc:service name="s7328Qry" routerKey="phone" routerValue="<%=main_card%>" retcode="retCode1" retmsg="retMsg1" outnum="39">
		<wtc:param value="0"/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=paraAray1[3]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=loginPwd%>"/>										
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value=""/>	
		<wtc:param value="<%=paraAray1[2]%>"/>		
	</wtc:service>
	<wtc:array id="result1"  start="0" length="25" scope="end"/>
	<wtc:array id="result0"  start="26" length="1" scope="end"/>
	<wtc:array id="result9"  start="27" length="1" scope="end"/>
	<wtc:array id="result10" start="28" length="1" scope="end"/>
	<wtc:array id="result2"  start="29" length="1" scope="end"/>
	<wtc:array id="result3"  start="30" length="1" scope="end"/>
	<wtc:array id="result4"  start="31" length="1" scope="end"/>
	<wtc:array id="result5"  start="32" length="1" scope="end"/>
	<wtc:array id="result6"  start="33" length="1" scope="end"/>
	<wtc:array id="result7"  start="34" length="1" scope="end"/>
	<wtc:array id="result8"  start="35" length="1" scope="end"/>

<%
  String  bp_name="",sm_code="",family_code="",rate_code="",op_type="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",prodId="",prodNote="";
  String otherCardFlag = "",mainDisabledFlag="",print_note="",bp_add="",cardId_no="",parent_prod="",prod_name="";
  String[][] tempArr= new String[][]{};
  String[][] familyCodeArr= new String[][]{};
  String[][] otherCodeArr= new String[][]{};
  String[][] cardTypeArr= new String[][]{};
  String[][] beginTimeArr= new String[][]{};
  String[][] endTimeArr= new String[][]{};
  String[][] opTimeArr= new String[][]{};
  String[][] newRateCodeArr= new String[][]{};
  String[][] FamilyProdArr= new String[][]{};
  String[][] FamilyNoteArr= new String[][]{};
  String[][] ParentProdArr= new String[][]{};

  String errCode = retCode1;
  String errMsg = retMsg1;
  tempArr = result1;
  FamilyProdArr = result0;  /*��Ʒ����*/
  ParentProdArr = result10;	/*��Ʒ��־��'0'������ͥ����Ʒ�����඼�Ǹ��Ӳ�Ʒ��*/
  System.out.println("errCode======"+errCode);
  if(result1.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag="1";
	   retMsg="s7328Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg ;
    }
  }else if(errCode.equals("000000") && result1.length>0)
  {

	    bp_name = tempArr[0][3];//��������

	     bp_add = tempArr[0][4];//�ͻ���ַ

	    passwordFromSer = tempArr[0][2];//����

	    sm_code = tempArr[0][11];//ҵ�����

	    sm_name = tempArr[0][12];//ҵ���������

	    rate_code = tempArr[0][5];//�ʷѴ���

	    rate_name = tempArr[0][6];//�ʷ�����

	    next_rate_code = tempArr[0][7];//�����ʷѴ���

	    next_rate_name = tempArr[0][8];//�����ʷ�����

	    bigCust_flag = tempArr[0][9];//��ͻ���־

	    bigCust_name = tempArr[0][10];//��ͻ�����

	    lack_fee = tempArr[0][15];//��Ƿ��

	    prepay_fee = tempArr[0][16];//��Ԥ��

	    cardId_no = tempArr[0][19];//֤������

	  if(result0.length!=0||result10.length!=0)
	  {
	  	  prodId = FamilyProdArr[0][0];
	   	  parent_prod = ParentProdArr[0][0];
	  }
	  FamilyNoteArr = result9;	//��Ʒ����
	  familyCodeArr = result2;//��ͥ����
	  otherCodeArr = result3;//��������--��Ա����
      cardTypeArr = result4;//������--����ʱ��
      beginTimeArr = result5;//��ʼʱ��--������
      endTimeArr = result6;//����ʱ��--������ˮ
      opTimeArr = result7;//����ʱ��--����
	  newRateCodeArr = result8;//��ܰ��ͥ�ʷѴ���
	  //�ж��Ƿ���������¼
	  if(familyCodeArr==null || familyCodeArr.length==0 || familyCodeArr[0][0].equals("")){
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="�ú���û�ж�Ӧ��������Ϣ!";
        }
	  }else if(familyCodeArr.length>1){
	    otherCardFlag = "1";//�ж��Ƿ���ڸ���
	  }
	}else{
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="s7328Qry��ѯ���������Ϣʧ��!"+errMsg;
        }
	}



  //******************�õ�����������***************************//
  String sqlRateCode = "";
    //�ʷ���Ϣ

	sqlRateCode = "select a.offer_id,a.offer_id||'--'||a.offer_name from product_offer a,region b, sregioncode c  where a.offer_id=b.offer_id and a.offer_attr_type = 'YnEb' and b.group_id = c.group_id and c.region_code='"+regionCode +"'" ;
	System.out.println("sqlRateCode="+sqlRateCode);
	String[] paramIn = new String[2];
	/*
	paramIn[0] = "select a.mode_code,a.mode_code||'--'||a.mode_name from sbillmodecode a,sFamModeCode b  where a.region_code=b.region_code and a.mode_code=b.mode_code and b.region_code=:regionCode";
	*/
	paramIn[0] = "select a.offer_id,a.offer_id||'--'||a.offer_name from product_offer a,region b, sregioncode c  where a.offer_id=b.offer_id and a.offer_attr_type = 'YnEb' and b.group_id = c.group_id and c.region_code=:regionCode";
	paramIn[1] = "regionCode="+regionCode;
	//ArrayList rateCodeArr = co.spubqry32("2",sqlRateCode);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:param value="<%=paramIn[0]%>"/>
	<wtc:param value="<%=paramIn[1]%>"/>
	</wtc:service>
	<wtc:array id="rateCodeStr"  scope="end"/>
<%

	System.out.println("retCode2==="+retCode2);
	System.out.println("rateCodeStr"+rateCodeStr.length);
  /****�õ���ӡ��ˮ****/
  String op_note="";
  op_note="��ͥ��Ʒ����";
  String printAccept="";
  printAccept = getMaxAccept();
%>


<%
	String sqlstrTD = "select no_type from dcustres where phone_no='"+main_card+"'";
	 System.out.println(main_card);
	String phoneHead = main_card.substring(0,3);
%>
	<wtc:pubselect name="sPubSelect" retcode="retc" retmsg="retm" outnum="1">
			<wtc:sql><%=sqlstrTD%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultTD" scope="end" />
<%
		System.out.println("===================="+resultTD[0][0]);
		if(resultTD.length > 0){
			String no_type = resultTD[0][0];
			if("147".equals(phoneHead) && "0000h".equals(no_type)){
				flag = "true";
			}
			else if ("157".equals(phoneHead) && "0000h".equals(no_type)){
				flag = "true";	
			}
			/*2014/12/12 16:50:23 gaopeng R_CMI_HLJ_xueyz_2014_1933493@��������������Ŷκ�Դ��������תTD���ݵ���ʾ
				����184�Ŷ�
			*/
			else if ("184".equals(phoneHead) && "0000h".equals(no_type)){
				flag = "true";	
			}
			else 
			{
				flag = "false";
			}
		}
			else
		{
			flag = "false";	
		}
		
		
		
%>
<head>
<title>���ļ�ͥ��Ϣ��ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<script language=javascript>
 onload=function()
 {
	
 }
 function doProcess(packet)
 {
 		retType = packet.data.findValueByName("retType");

 		if(retType == "getModeInfo")
 		{
 			var errCode = packet.data.findValueByName("errCode");
	  		var errMsg = packet.data.findValueByName("errMsg");

			var Main_Prod = packet.data.findValueByName("MainProd");
 			var Main_ProdName = packet.data.findValueByName("MainName");
 			var Other_Prod = packet.data.findValueByName("OtherProd");
 			var Other_ProdName = packet.data.findValueByName("OtherProdName");
 			var Note = packet.data.findValueByName("note");
 			var Note1 = packet.data.findValueByName("note1");
 			if(errCode == 000000)
 			{
 				document.all.main_prod.value = Main_Prod;
 				document.all.main_prod_name.value = Main_ProdName;
 				document.all.other_prod.value = Other_Prod;
 				document.all.other_prod_name.value = Other_ProdName;
 				document.all.main_prod_note.value = Note;
 				document.all.other_prod_note.value = Note1;
 			}
 			else
			{
				rdShowMessageDialog("����:"+ errCode + "->" + errMsg,0);
				return false;
			}
 		}
}
</script>
<script language="JavaScript">
    //���У��ʧ�ܣ��򷵻���һ����
	<%if(retFlag.equals("1")){%>
	 rdShowMessageDialog("<%= retMsg %>");
	 history.go(-1);
	<%}%>
<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

   function frmCfm()
  {
 		frm.submit();
		return true;
  }
 //***
  function printfrmCfm(){
  	getAfterPrompt();
  	var radioArr = document.all.radios ;
 	for(var i=0;i<radioArr.length;i++){
 		if(document.all.radios[i].checked == true){
 			radio = document.all.radios[i].value;
 		}
 	}
 	if(radio == "1"){
 	   	var len = $("#village option").length;
 		if((len > 1) && ($("#village option:selected").val() == "0")){
 			rdShowMessageDialog("��ѡ��С����Ϣ��");
 			return;
 		}
 	}
  	//alert(document.all.parent_prod_id.value);
  	if(document.all.parent_prod_id.value =="���Ӳ�Ʒ" && document.all.friend_no.value=="")
  	{
  		rdShowConfirmDialog('�������������!')
  		document.all.friend_no.focus();
  	}
  	else
  	{
	  	setOpNote();//Ϊ��ע��ֵ
	  	document.frm.action="f7333Cfm.jsp";	  	
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
		var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		var sysAccept=<%=printAccept%>;                            // ��ˮ��
		var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
		var mode_code=codeChg(document.all.main_prod.value)+"~"+codeChg(document.all.other_prod.value);          //�ʷѴ���
		var fav_code=null;                                         //�ط�����
		var area_code=null;                                        //С������
		var opCode="<%=op_code%>";                                  //��������
		var phoneNo=document.frm.main_card.value;                 //�ͻ��绰

		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.frm.main_card.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
  }

  function printInfo(printType)
  {
		var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//�õ�ִ��ʱ��

		var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
		var retInfo = "";  //��ӡ����
		var prod_name = "";

		cust_info+="�ֻ����룺"+"<%=main_card%>"+"|";
		cust_info+="�ͻ�������"+"<%=bp_name%>"+"|";

		opr_info+="�û�Ʒ�ƣ�"+document.all.sm_name.value+"  "+"����ҵ�񣺳��ļ�ͥ��Ʒ����֮<%=op_note%>"+"|";

		opr_info+="������ˮ��"+"<%=printAccept%>"+"|";

		if(document.all.parent_prod_id.value =="����Ʒ")
		{
			prod_name="����ͥ��������";
		}
		else
		{
			prod_name="���Ż��������";
		}
		opr_info+="���ΰ����ײͣ�  "+"|";
		opr_info+="  "+document.all.main_prod.value+"  "+document.all.main_prod_name.value+"|";		
		opr_info+="  "+document.all.other_prod.value+"  "+document.all.other_prod_name.value+"  "+prod_name+"|";
		/**********������*********/
		note_info1+="����������ʷ���Ϣ������"+"|";
		note_info1+=" "+codeChg(document.all.main_prod_note.value)+"|";
		
		note_info2+= " " +"|";
    	note_info2+=" "+codeChg(document.all.other_prod_note.value)+"|";
    	
    	if(document.all.main_prod.value.trim()=="35687") {
    	
    	note_info3+="��������ͻ�������ʷѵ��հ����ƶ�e�ҡ�֮���ߵ��ӻ���һδ���ڣ��ҳ����ɽ�ɢ��ͥ����ͥ��Ա�����˳���ͥ��" +"|";
    	}
    	
		if(document.all.friend_no.value.length !=0)
		{
			opr_info+="�趨����: "+document.all.friend_no.value+"|";
		}
		opr_info+="�ʷ���Чʱ�䣺 "+"����"+"|";

		note_info4+="��ע��"+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
  }

 function queryProdCode()
 {
 	document.all.confirm.disabled=false;
 	// add by wanglma 20110815
 	var radioArr = document.all.radios ;
 	var radio = "2" ;
 	for(var i=0;i<radioArr.length;i++){
 		if(document.all.radios[i].checked == true){
 			radio = document.all.radios[i].value;
 		}
 	}
 	
 	var parentprod="<%=prodId%>";
 	var Parent_prod_id;
 	var sqlStr;
 	if((parentprod=="")||(parentprod=="0"))
 	{
 		parentprod="0";
 		Parent_prod_id = "����Ʒ";
 	}
 	else if(parentprod!="0")
 	{
    	document.getElementById("friendno").style.display="";
    	document.all.friend_no.value="";
    	Parent_prod_id = "���Ӳ�Ʒ";
  }
    //alert(parentprod);
 	var regioncode="<%=regionCode%>";
 	var pageTitle = "��Ʒ��ѯ";
    var fieldName = "��Ʒ����|��Ʒ����|��Ʒ��ʶ|�ʷѴ���";//����������ʾ���С����� 
    if(radio == "0"){
            if("<%=flag%>"=="true")
   			 {
   			 	//alert(1);
    			sqlStr ="select fam_prod_id,trim(fam_prod_note),decode(trim(parent_prod_id),'0','����Ʒ','���Ӳ�Ʒ') parent_prod_id ,main_product from sFamilyProduct where region_code='"+regioncode+"' and parent_prod_id='"+parentprod+"' and fam_type='TDGH' and sysdate between begin_time and end_time"; 
   			 }
   		    else
            {	
            	//alert(2)
        	   sqlStr ="select fam_prod_id,trim(fam_prod_note),decode(trim(parent_prod_id),'0','����Ʒ','���Ӳ�Ʒ') parent_prod_id , main_product from sFamilyProduct where region_code='"+regioncode+"' and parent_prod_id='"+parentprod+"' and nvl(trim(fam_type),'T')<>'TDGH' and sysdate between begin_time and end_time"; 
	        }
    }else{
	   if(((radio == "1") && ("<%=flag%>"=="true")) ){
	    	sqlStr ="select fam_prod_id,trim(fam_prod_note),decode(trim(parent_prod_id),'0','����Ʒ','���Ӳ�Ʒ') parent_prod_id , main_product from sFamilyProduct where region_code='"+regioncode+"' and parent_prod_id='"+parentprod+"' and fam_type='TDTF' and sysdate between begin_time and end_time"; 
	   }else{
	        sqlStr ="select fam_prod_id,trim(fam_prod_note),decode(trim(parent_prod_id),'0','����Ʒ','���Ӳ�Ʒ') parent_prod_id ,main_product from sFamilyProduct where region_code='"+regioncode+"' and parent_prod_id='"+parentprod+"' and fam_type='XXXX' and sysdate between begin_time and end_time"; 
	   }
    }
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1|2|3";//�����ֶ�
    var retToField = "fam_prod_id|fam_prod_note|Parent_prod_id|main_product";//���ظ�ֵ����
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    if(document.all.fam_prod_id.value=="")
    {

    	document.getElementById("friendno").style.display="none";
    	document.all.confirm.disabled=true;
    }
    else
    {
    	document.all.confirm.disabled=false;
    	if(radio == "1"){
    	   getVillage();
        }
    	qryMode();
 		}
 }
 function getVillage(){
 	var myPacket = new AJAXPacket("getVillage.jsp","���ڻ�ȡС����Ϣ�����Ժ�......");
	myPacket.data.add("offerId",document.all.main_product.value);
	core.ajax.sendPacketHtml(myPacket,doMsg);
	myPacket=null;
 }
 function doMsg(data){
 	$("#village").empty().append(data);
 	setVillage();
 }
 function setVillage(){
 	var len = $("#village option").length;
 	if(len == 1){
 	  $("#village").empty().append("<option value='' >��С������</option>");
 	}
 }
 function checkShow(flag){
    if(flag == "0"){
    	$("#villageTr").hide();
    }else{
    	$("#villageTr").show();
    }
 }
function qryMode()
{
	var myPacket = new AJAXPacket("qryMode.jsp","���ڻ�ȡ�ʷ���Ϣ�����Ժ�......");
	myPacket.data.add("retType","getModeInfo");
	myPacket.data.add("fam_prod_id",(document.all.fam_prod_id.value).trim());
	myPacket.data.add("regionCode","<%=regionCode%>");
	myPacket.data.add("phone_no","<%=main_card%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}

function setOpNote(){
	if(document.all.opNote.value=="")
	{
	  document.all.opNote.value = "��ͥ��Ʒ����--<%=op_note%> �ҳ�����:"+document.all.main_card.value;
	}
	return true;
}

  /***����������Ҫ�õ��Ĺ��˺���**/
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
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
            <td class="blue">��������</td>
            <td colspan="3">����</td>
            <input name="op_type" type="hidden" class="InputGrey" id="op_type" value="<%=openType%>" >
          </tr>
          <tr>
		    <td class="blue">�ֻ�����</td>
            <td>
			  <input name="main_card" type="text" class="InputGrey" id="main_card" value="<%=main_card%>" readonly >
			</td>
            <td class="blue">ҵ������</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_name%>" readonly>
			</td>
          </tr>
          <tr>
            <td class="blue">��ǰ���ײ�</td>
            <td>
			  <input name="rate_name" type="text" class="InputGrey" id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">�������ײ�</td>
            <td>
			  <input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" size="30"  value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
			</td>
          </tr>
		  <tr>
		    <td class="blue">��������</td>
            <td>
			  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>
			</td>
            <td class="blue">��ͻ���־</td>
            <td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
			</td>
          </tr>
		</table>
		</div>

<div id="Operation_Table">
<div class="title">
	<div id="title_zi">ҵ����ϸ</div>
</div>
		<TABLE cellSpacing="0">
          <TBODY>
		  <tr>
			<tr>
		      <th align=center>��ͥ����</th>
			  <th align=center>��ͥ���</th>
			  <th align=center>�ֻ�����</th>
			  <th align=center>��ʼʱ��</th>
			  <th align=center>��������</th>
			  <th align=center>������ˮ</th>
			</tr>
			<%
			 for(int j=0;j<otherCodeArr.length;j++){
			 	String tdClass = (j%2==0)?"Grey":"";
                if(cardTypeArr[j][0].equals("0") && otherCardFlag.equals("1")){
				  mainDisabledFlag = "disabled";
				}else{
				  mainDisabledFlag = "";
				}
			%>
		    <tr>
			  <TD align=center class="<%=tdClass%>"><%=familyCodeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=newRateCodeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=otherCodeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=cardTypeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=beginTimeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=endTimeArr[j][0]%></TD>
			</tr>				
			<%
			 }
			%>
		</table>
	</div>
<div id="Operation_Table">
	<div class="title">
	<div id="title_zi">��ǰ��ͥ��Ʒ��Ϣ</div>
	</div>
	    <TABLE  cellSpacing="0">
          <TBODY>
          <tr>
			<tr align="middle" >
		      <th align=center>��ͥ��Ʒ����</th>
			  <th align=center>��Ʒ��ϸ</th>
			  <th align=center>��Ʒ����</th>
			</tr>
				<%
				 for(int i=0;i<FamilyProdArr.length;i++){
				 	String TdClass = (i%2==0)?"Grey":"";
				 	if(ParentProdArr[i][0].equals("0"))
				 	{
				 		prod_name="��ͥ����Ʒ";
				 	}
					else if(ParentProdArr[i][0].equals(""))
					{
						prod_name="";
					}
					else
					{
						prod_name="���Ӳ�Ʒ";
					}
				%>
			<tr>
				<TD align=center class="<%=TdClass%>"><%=FamilyProdArr[i][0]%></TD>
			   	<TD align=center class="<%=TdClass%>"><%=FamilyNoteArr[i][0]%></TD>
			   	<TD align=center class="<%=TdClass%>"><%=prod_name%></TD>
			</tr>
			<%}%>
		</tr>
		</table>
	 </div>
<div id="Operation_Table">
	<div class="title">
	<div id="title_zi">�����ͥ��Ʒ��Ϣ</div>
	</div>
		<TABLE cellSpacing="0">
          <TBODY>
          <tr>
          	<td class="blue">
				��ͥ��Ʒ����
          	</td>
          	<td class="blue" colspan="3">
				<input type="radio" name="radios" value= "0" onclick='checkShow("0")' /> ��ͨ���ļ�ͥ
				<input type="radio" name="radios" value= "1" onclick='checkShow("1")' /> �������⳩�ļ�ͥ
          	</td>
          </tr>
          <tr>
			<td class="blue">
				��ͥ��Ʒ����
			</td>
            <td>
				<input name="fam_prod_id" type="text" class="InputGrey" id="fam_prod_id" maxlength=8 >
				<input class="b_text" type="button" name="query_prodcode" onclick="queryProdCode()" value="��ѯ" >
			</td>
			<td class="blue">��Ʒ��ϸ</td>
			<td>
				<input name="fam_prod_note" type="text" class="InputGrey" id="fam_prod_note" maxlength=255 size="60" v_must=1 v_minlength=1 v_maxlength=30 >
        		<input name="parent_prod_id" type="hidden" class="InputGrey" id="parent_prod_id" >
        		<input name="main_product" type="hidden" class="InputGrey" id="main_product" >
        	</td>
        	<tr style="display:none" id="villageTr">
        		<td class="blue" >С��</td>
        	   <td colspan="3">
        	      <select name="village" id="village">
        	  </select>	
        	   </td>	
        	</tr>
        </tr>
        <tr></tr>
        <tr id="friendno" style="display:none">
        	<td class="blue">
              <div align="left">�������</div>
            </td>
        	<td colspan="3">
        		<input name="friend_no" type="text" class="button" maxlength=12 size="12" v_must=1 v_minlength=1 v_maxlength=12 >
        	</td>
		</tr>
		  <tr>
		  	 <tr></tr>
		  	 <tr></tr>
		  	 <tr></tr>
            <td id="footer" colspan="4"> <div align="center">
            	 &nbsp;
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="ȷ��" onClick="printfrmCfm(this)" disabled >
                 &nbsp;
                <input name="reset" type="hidden" class="b_foot" value="���" >
                &nbsp;
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
                &nbsp;

				</div>
			</td>
          </tr>
       </table>
 <input type="hidden" name="bp_addr" id="bp_addr" value="<%=bp_add%>"> <!--�ͻ���ַ-->
 <input name="cardId_no" type="hidden" id="cardId_no" value="<%=cardId_no%>"> <!--֤������-->
  <input type="hidden" name="phoneNoForPrt" ><!--Ҫȡ�����ֻ�����,���ڴ�ӡ-->
  <input type="hidden" name="cardTypeForPrt" ><!--Ҫȡ���Ŀ�����,���ڴ�ӡ-->
   <input type="hidden" name="print_note" value="<%=print_note%>"><!--��ӡ�������-->
  <input type="hidden" name="printAccept" value="<%=printAccept%>"><!--��ӡ��ˮ-->
  <input type="hidden" name="phoneNo" value="<%=main_card%>">
  <input type="hidden" name="op_code" value="<%=opCode%>">
  <input type="hidden" name="main_prod" >
  <input type="hidden" name="main_prod_name" >
  <input type="hidden" name="other_prod" >
  <input type="hidden" name="other_prod_name" >
  <input type="hidden" name="main_prod_note" >
  <input type="hidden" name="other_prod_note" >
  <input type="hidden" name="parent_prod">
  <input name="opNote" type="hidden" id="opNote" value="" onFocus="setOpNote();" >
  <input type="hidden" name="return_page" value="/npage/bill/f7333_login.jsp?activePhone=<%=main_card%>&opName=<%=opName%>&opCode=<%=opCode%>">
   <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>



