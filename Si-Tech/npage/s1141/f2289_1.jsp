<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ͳһԤ������2289
   * �汾: 1.0
   * ����: 2008/12/31
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode="2289";
	String opName="ͳһԤ������";
  String loginNoPass = (String)session.getAttribute("password");
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionNo=orgCode.substring(0,2);//huangrong add
	String regionCode = (String)session.getAttribute("regCode");
	String[][] favInfo = (String[][])session.getAttribute("favInfo");  				//���ݸ�ʽΪString[0][0]---String[n][0]
	String groupId = (String)session.getAttribute("groupId");
	String flag= request.getParameter("flag");//huangrong add �Ƿ����ԤԼ���
	int recordNum=0;
	int i=0;

//  comImpl co1 = new comImpl();
//	String paraStr[]=new String[1];
	String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
//  paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<%
//	ArrayList retList = new ArrayList();
//	String[][] tempArr= new String[][]{};

	String retFlag="",retMsg="";
	String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
	String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
	String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
	String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
	String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
	String point_note="",open_time="";
	String  start_time="";//huangrong add
	
	String iPhoneNo = request.getParameter("srv_no");
	String iOpCode = request.getParameter("opcode");
	String cus_pass = request.getParameter("cus_pass");
	/*begin huangrong add ��ѯ�û��������к�����ʱ�� 2011-4-26 16:53*/
	String Infosql="SELECT subStr(belong_code,1,2),ceil(months_between(SYSDATE,open_time)) FROM dCustMsg  WHERE phone_no='"+iPhoneNo+"'";
	String cust_belongCode="";
	String cust_openTime="";	
	int opTimeTotal=0;
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="InfoRetCode" retmsg="InfoRetMsg" outnum="2">
	<wtc:sql><%=Infosql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="InfosqlStr" scope="end" />

<%
	if(InfoRetCode.equals("000000"))
	{
		if(InfosqlStr!=null && InfosqlStr.length>0)
	  	{
				cust_belongCode=InfosqlStr[0][0];
				cust_openTime=InfosqlStr[0][1];
				opTimeTotal=Integer.parseInt(cust_openTime);
			}	
	}else
	{
%>	
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=InfoRetCode%>��������Ϣ��<%=InfoRetMsg%>",0);
				history.go(-1);
			</script>
<%
	}
		/*end huangrong add ��ѯ�û��������к�����ʱ�� 2011-4-26 16:53*/
//	SPubCallSvrImpl co2 = new SPubCallSvrImpl();
	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = flag;//huangrong add
	System.out.println("inputParsm[0] = iPhoneNo  "+ iPhoneNo);
	System.out.println("inputParsm[1] = loginNo   "+ loginNo);
	System.out.println("inputParsm[2] = orgCode   "+ orgCode);
	System.out.println("inputParsm[3] = iOpCode   "+ iOpCode);


//	  retList = co2.callFXService("s2289Qry", inputParsm, "30","phone",iPhoneNo);
%>
<%/*wangdana  ͳһԤ������ר�����Ʋ�ѯ*******************/%>
<wtc:service name="q_s2289Query" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode2" retmsg="retMsg2">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
	</wtc:service>
	<wtc:array id="tempArr2" scope="end"/>
<%
if (retCode2.equals( "000000") ){
}
else{%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=retCode2%>��������Ϣ��<%=retMsg2%>",0);
				history.go(-1);
			</script>
      <%}
%>
<%/*wangdana  ͳһԤ������ר�����Ʋ�ѯ*******************/%>

	<wtc:service name="s2289Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="32" retcode="retCode" retmsg="retMsg1">

					<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNoPass%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=" "/>
		<wtc:param value="<%=orgCode%>"/>
			<wtc:param value="<%=flag%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
  String errCode = retCode;
  String errMsg = retMsg1;

  System.out.println("errCode="+errCode);
  System.out.println("errMsg ="+errMsg);

  if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s2289Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals( "000000") && tempArr.length>0){
	  	if(!(tempArr==null)){
		    bp_name = tempArr[0][3];           //��������
		    bp_add = tempArr[0][4];            //�ͻ���ַ
		    passwordFromSer = tempArr[0][2];   //����
		    sm_code = tempArr[0][11];          //ҵ�����
		    sm_name = tempArr[0][12];          //ҵ���������
		    hand_fee = tempArr[0][13];     	   //������
		    favorcode = tempArr[0][14];     	//�Żݴ���
		    rate_code = tempArr[0][5];    		 //�ʷѴ���
		    rate_name = tempArr[0][6];    		//�ʷ�����
		    next_rate_code = tempArr[0][7];		//�����ʷѴ���
		    next_rate_name = tempArr[0][8];		//�����ʷ�����
		    bigCust_flag = tempArr[0][9];		//��ͻ���־
		    bigCust_name = tempArr[0][10];		//��ͻ�����
		    lack_fee = tempArr[0][15];			//��Ƿ��
		    prepay_fee = tempArr[0][16];		//��Ԥ��
		    cardId_type = tempArr[0][17];		//֤������
		    cardId_no = tempArr[0][18];			//֤������
		    cust_id = tempArr[0][19];			//�ͻ�id
		    cust_belong_code = tempArr[0][20];	//�ͻ�����id
		    group_type_code = tempArr[0][21];	//���ſͻ�����
		    group_type_name = tempArr[0][22];	//���ſͻ���������
		    imain_stream = tempArr[0][23];		//��ǰ�ʷѿ�ͨ��ˮ
		    next_main_stream = tempArr[0][24];	//ԤԼ�ʷѿ�ͨ��ˮ
		    print_note = tempArr[0][25];		//�������
		    contract_flag = tempArr[0][27];		//�Ƿ������˻�
		    high_flag = tempArr[0][28];			//�Ƿ��и߶��û�
		    point_note = tempArr[0][29];		//����������ʾ
		    open_time = tempArr[0][30];			//����ʱ��
		    start_time= tempArr[0][31];     //huangrong add ԤԼ��Чʱ��
	 	}
	}else{%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
				history.go(-1);
			</script>
      <%}
 }

/*** 20091119 fengry begin for ����4������ ***/
	String Timesql = "select COUNT(*) from dcustmsg where phone_no = '"+iPhoneNo+"' and to_char(sysdate,'yyyymmdd') - to_char(open_time,'yyyymmdd') = 0";
  System.out.println("Timesql==="+Timesql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="TimeRetCode" retmsg="TimeRetMsg" outnum="1">
	<wtc:sql><%=Timesql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="TimeStr" scope="end" />
<%
System.out.println("TimeStr[0][0]==="+TimeStr[0][0]);
System.out.println("TimeRetCode==="+TimeRetCode);
System.out.println("TimeRetMsg==="+TimeRetMsg);


	String Goodsql = "select COUNT(*) from dual where substr('"+iPhoneNo+"',8,4) like '%4%' and not exists(select 1 from dgoodphoneres where phone_no='"+iPhoneNo+"' )";
  System.out.println("Goodsql==="+Goodsql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="GoodRetCode" retmsg="GoodRetMsg" outnum="1">
	<wtc:sql><%=Goodsql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="GoodStr" scope="end" />
<%
System.out.println("GoodStr[0][0]==="+GoodStr[0][0]);
System.out.println("GoodRetCode==="+GoodRetCode);
System.out.println("GoodRetMsg==="+GoodRetMsg);
/*** 20091119 end ***/

String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>ͳһԤ������</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--
//begin huangrong add for �Ƿ����齱ֻ��ĵ������ʾ
	onload=function()
	  {
	  	document.all.take_prize[0].checked=true;  		  	
	  	if("<%=regionNo%>"=="03")
	  	{
	  		var td2=document.getElementById("td2");
	  		td2.style.display="";
	  		var td3=document.getElementById("td3");
	  		td3.style.display="";
	  		var td1=document.getElementById("td1");
	  		td1.colSpan="1";
	  	}
	  }
//end huangrong add for �Ƿ����齱ֻ��ĵ������ʾ	  
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


  //--------2---------��֤��ťר�ú���-------------

function frmCfm()
{
		///////<!-- ningtn add for pos start @ 20100430 -->
		document.all.payType.value = document.all.payTypeSelect.value;
		if(document.all.payType.value=="BX")
  	{
    		/*set �������*/
				var transerial    = "000000000000";  	                    //����Ψһ�� ������ȡ��
				var trantype      = "00";         //��������
				var bMoney        = document.all.Prepay_Fee.value; 				//�ɷѽ��
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
				var tranoper      = "<%=loginNo%>";                       //���ײ���Ա
				var orgid         = "<%=groupId%>";                       //ӪҵԱ��������
				var trannum       = "<%=iPhoneNo%>";                      //�绰����
				getSysDate();       /*ȡbossϵͳʱ��*/
				var respstamp     = document.all.Request_time.value;      //�ύʱ��
				var transerialold = "";																		//ԭ����Ψһ��,�ڽɷ�ʱ�����
				var org_code      = "<%=orgCode%>";                       //ӪҵԱ����						
				CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
				if(ccbTran=="succ") posSubmitForm();
  	}
		else if(document.all.payType.value=="BY")
		{
				var transType     = "05";					/*�������� */         
				var bMoney        = document.all.Prepay_Fee.value;         /*���׽�� */
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
				var response_time = "";                								 		/*ԭ�������� */				
				var rrn           = "";                           				/*ԭ����ϵͳ������ */ 
				var instNum       = "";                                   /*���ڸ������� */     
				var terminalId    = "";                    								/*ԭ�����ն˺� */			
				getSysDate();       																			//ȡbossϵͳʱ��                                            
				var request_time  = document.all.Request_time.value;      /*�����ύ���� */     
				var workno        = "<%=loginNo%>";                        /*���ײ���Ա */       
				var orgCode       = "<%=orgCode%>";                       /*ӪҵԱ���� */       
				var groupId       = "<%=groupId%>";                       /*ӪҵԱ�������� */   
				var phoneNo       = "<%=iPhoneNo%>";                       /*���׽ɷѺ� */       
				var toBeUpdate    = "";						                        /*Ԥ���ֶ� */         
				var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
				if(icbcTran=="succ") posSubmitForm();
		}else{
				posSubmitForm();
		}
		
		//////<!-- ningtn add for pos end @ 20100430 -->
}
	/* ningtn add for pos start @ 20100430 */
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
	/* ningtn add for pos start @ 20100430 */
 function chkType()
 {			
 			//yuanqs add 2010/10/28 15:16:46 �ֲ����� begin
 			var regionCode = "<%=regionCode%>";
 			var sqlStr22="";
			// ���˰�������ǩԼ����   �������߶�Ԥ������   �׸��¿ͻ��ɳ���
			if((document.all.OLD_PROJECT_TYPE.value == "0011" && "<%=regionCode%>"=="12") || (document.all.OLD_PROJECT_TYPE.value == "0025" && "<%=regionCode%>"=="01") || (document.all.OLD_PROJECT_TYPE.value == "0026" && "<%=regionCode%>"=="08")){
				sqlStr22 = document.frm.openTime.value;
			}
	
			var myPacket = new AJAXPacket("getDetailNote2289.jsp","���ڲ�ѯ���Ժ�......");
			myPacket.data.add("sqlStr","");
			myPacket.data.add("sale_project_code",document.frm.projectType.value);
			myPacket.data.add("sqlStr22",sqlStr22);
			myPacket.data.add("retType",'01');
			core.ajax.sendPacket(myPacket);
			//rdShowMessageDialog("3");
			myPacket=null;
			
			//yuanqs add 2010/10/28 15:17:04 �ֲ����� end
	
		 	document.all.Gift_Code.value ="";
		 	document.all.Gift_Name.value ="";
		 	document.all.Base_Fee.value ="";
		 	document.all.Free_Fee.value ="";
		 	document.all.Mark_Subtract.value ="";
		 	document.all.Consume_Term.value ="";
		 	document.all.Mon_Base_Fee.value ="";
		 	document.all.Prepay_Fee.value ="";
		 	document.all.New_Mode_Name.value ="";
		 	document.all.do_note.value ="";
 }

 function doProcess(packet){
 		errorCode = packet.data.findValueByName("errorCode");
		errorMsg =  packet.data.findValueByName("errorMsg");
		retType = packet.data.findValueByName("retType");
		retResult= packet.data.findValueByName("retResult");
		self.status="";
		var tmpObj="";
		var i=0;
		var j=0;
		var ret_code=0;
		var tmpstr="";

		//rdShowMessageDialog("retType="+retType);
		ret_code =  parseInt(errorCode);
		
		//yuanqs add 2010/10/28 15:43:53 �ֲ����� begin
		if(retType=="01") {
				var detailCount = packet.data.findValueByName("detailCount");
				var js_detail_msg = packet.data.findValueByName("js_detail_msg");
				showMsg(js_detail_msg, detailCount);
		}
		//yuanqs add 2010/10/28 15:44:04 �ֲ����� end
		if(retType=="getProjectType")
		{
			//rdShowMessageDialog("getProjectType");
			//rdShowMessageDialog("ret_code="+ret_code);
			if(ret_code!=0){
				rdShowMessageDialog("ȡ��Ϣ����:"+errorMsg+"!");
				return;
			}
			document.all.OLD_PROJECT_TYPE.value=retResult;
			//rdShowMessageDialog("retResult="+retResult);
			//rdShowMessageDialog("document.all.OLD_PROJECT_TYPE.value="+document.all.OLD_PROJECT_TYPE.value);
		 }

 }

//yuanqs add 2010/10/29 10:35:38 �ֲ�����
function showMsg(js_detail_msg, detailCount) {
		var msgStr = "";
		if(1==detailCount) {				
				msgStr = "��ע��" + js_detail_msg[0][1];
		} else {
				var msgStr = "��������<br>";
				for(var p=0; p<js_detail_msg.length; p++) {
						msgStr = msgStr + (p+1) + "��" + js_detail_msg[p][0] + "<br>";
				}
		}
		$("#msgDiv").children("span").html(msgStr);
		
			var msgNode = $("#msgDiv").css("border","1px solid #999").width("260px")
                            .css("position","absolute").css("z-index","99")
                            .css("background-color","#dff6b3").css("padding","8");
    	var pt = $("#projectType");
    	msgNode.css("left",pt.offset().left + 300 + "px").css("top",pt.offset().top + 0 + "px");
    	msgNode.show();
}
function hideMessage() {
		$("#msgDiv").hide();
}
//yuanqs add 2010/10/29 15:27:18 �ֲ����� end

 function getInfo_code()
{
//	rdShowMessageDialog("1");
	var myPacket = new AJAXPacket("queryProjectType.jsp","ȡproject_type��Ϣ�����Ժ�......");
	myPacket.data.add("retType","getProjectType");
	myPacket.data.add("sale_project_code",(document.frm.projectType.value).trim());
//	rdShowMessageDialog("2");
	core.ajax.sendPacket(myPacket);
//	rdShowMessageDialog("3");
	myPacket=null;


// add by dujl*************************************************
	// wanglei modify sql and �򻯴���
	var regionCode = "<%=regionCode%>";
	var pageTitle = "Ӫ������ѡ��";
	var fieldName = "��������|��������|����Ԥ��|�Ԥ��|�ۼ�����|��������|�µ���|��Ԥ��|��ע|ϵͳʹ��|";//����������ʾ���С�����
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "10|0|1|2|3|4|5|6|7|8|9|";//�����ֶ�
	var retToField = "Gift_Code|Gift_Name|Base_Fee|Free_Fee|Mark_Subtract|Consume_Term|Mon_Base_Fee|Prepay_Fee|New_Mode_Name|OLD_PROJECT_TYPE|";//���ظ�ֵ����
	
	var sale_project_codess = document.frm.projectType.value;
	//rdShowMessageDialog(document.all.OLD_PROJECT_TYPE.value);
	var sqlStr11="";
	var sqlStr22="";
	

	// ���˰�������ǩԼ����   �������߶�Ԥ������   �׸��¿ͻ��ɳ���
	if((document.all.OLD_PROJECT_TYPE.value == "0011" && "<%=regionCode%>"=="12") || (document.all.OLD_PROJECT_TYPE.value == "0025" && "<%=regionCode%>"=="01") || (document.all.OLD_PROJECT_TYPE.value == "0026" && "<%=regionCode%>"=="08")){
		sqlStr11 =document.frm.openTime.value;
	}
	//begin huangrong add �����û�����ʱ���ѡ��ķ�������ѡ���Ե�չʾ����ķ������� 2011-4-26 16:56	 

	if(document.frm.projectType.value=="241738" || document.frm.projectType.value=="241743")
	{
		if("<%=opTimeTotal%>"<=12)
		{
			rdShowMessageDialog("���û�����ʱ�䲻��һ��,���ܰ���"+document.frm.projectType[document.frm.projectType.selectedIndex].text);
			return false;
		}else
		{				
			sqlStr22="<%=opTimeTotal%>";	
		}
	}	
	//end huangrong add �����û�����ʱ���ѡ��ķ�������ѡ���Ե�չʾ����ķ������� 2011-4-26 16:56	
	if(MySimpSel(pageTitle,fieldName,"",selType,retQuence,retToField,80,sqlStr11,sqlStr22,sale_project_codess));
	//document.all.do_note.value = "ͳһԤ�����񣬷������룺"+document.all.Gift_Code.value;
	// rdShowMessageDialog(document.all.OLD_PROJECT_TYPE.value);
}

function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth,sqlStr11,sqlStr22,sale_project_codess)
{
    var path = "fPubSimpSel2289.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+ "&sqlStr11=" + sqlStr11+ "&sqlStr22=" + sqlStr22+ "&sale_project_codess=" + sale_project_codess;
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

 //begin huangrong for  ���ڹ������ֹ�˾���뿪��Ӫҵ���Զ�����ϵͳ����ʾ 
function do_chnPayLimit(packet)
{	
	 	var errorCode = packet.data.findValueByName("retCode");
		var errorMsg =  packet.data.findValueByName("retMsg");
		if(errorCode!="000000"){
			rdShowMessageDialog("���÷���bs_ChnPayLimitʧ�ܣ�<br>������룺"+errorCode+"��������Ϣ��"+errorMsg);
			return false;
		}
		var pay_flag =  packet.data.findValueByName("pay_flag");
		var outPledge = packet.data.findValueByName("outPledge");
		var total_pay= packet.data.findValueByName("total_pay");
		document.all.payFlag.value=pay_flag;
		
		if(pay_flag=="1")
		{
			rdShowMessageDialog("���������Ѻ����Ϊ��"+outPledge+"<br>��ǰ���ۻ�Ӫҵ��Ϊ��"+total_pay+"<br>���ν��ɷ���Ϊ��"+document.all.Prepay_Fee.value+"<br>�뼰ʱ�����ʽ��Ͻɣ������޷���������ɷѣ�");
		}
} 
 //end huangrong for ���ڹ������ֹ�˾���뿪��Ӫҵ���Զ�����ϵͳ����ʾ 

function printCommit()
{
	getAfterPrompt();
 	if(!checkElement(document.all.phoneNo)) return;
	if(document.all.Gift_Code.value==""){
		rdShowMessageDialog("������Ӫ������!");
		document.all.Gift_Code.focus();
		return false;
	}
	if (document.all.i9.value == "Y")
	{
		rdShowMessageDialog("�����û�����������ҵ��");
		return false;
	}
	if (document.all.oSmCode.value == "dn" && document.all.OLD_PROJECT_TYPE.value == "0002")
	{
		rdShowMessageDialog("���еش��û�����������ҵ��");
		return false;
	}
	if (document.all.oSmCode.value != "dn" && document.all.OLD_PROJECT_TYPE.value == "0002" && parseInt(document.all.Mark_Subtract.value,10)>parseInt(document.all.oMarkPoint.value,10))
	{
		rdShowMessageDialog("�û�����С�ڿۼ����֣�����������ҵ��");
		return false;
	}
	if (document.all.oSmCode.value == "zn" && document.all.OLD_PROJECT_TYPE.value == "0008" && parseInt(document.all.Mark_Subtract.value,10)<0)
	{
		rdShowMessageDialog("�������û�����������ҵ��,�����Ԥ������ҵ��");
		return false;
	}
	if (document.all.OLD_PROJECT_TYPE.value == "0008" && parseInt(document.all.Mark_Subtract.value,10)<0 && "<%=point_note%>" !="no" )
	{
		rdShowMessageDialog("<%=point_note%>");
	}
	if (document.all.oSmCode.value != "dn" && document.all.OLD_PROJECT_TYPE.value == "0019" )
	{
		rdShowMessageDialog("ֻ�ж��еش��û����԰����ҵ��");
		return false;
	}
//20091119 begin
	if (document.all.OLD_PROJECT_TYPE.value == "0029")
	{
		if (<%=TimeStr[0][0]%> != "1")
		{
			rdShowMessageDialog("ֻ�е����¿��������û����԰����ҵ��");
			return false;
		}
		else
		{
			if (<%=GoodStr[0][0]%> != "1")
			{
				rdShowMessageDialog("�û����벻�����ҵ��");
				return false;
			}
		}
	}
	
	//begin huangrong for ���ڹ������ֹ�˾���뿪��Ӫҵ���Զ�����ϵͳ����ʾ 
		var sum_money=document.all.Prepay_Fee.value;
		var packet_chnPayLimit = new AJAXPacket("ajax_chnPayLimit.jsp");
    packet_chnPayLimit.data.add("sum_money", sum_money);
    core.ajax.sendPacket(packet_chnPayLimit,do_chnPayLimit);
    packet_chnPayLimit = null;
    var payFlag=document.all.payFlag.value;
    if(payFlag!="0" && payFlag!="1")
    {
    	rdShowMessageDialog("��ȡ����Ѻ���ʶʧ��!");
    	return false;
    }
	//end huangrong for ���ڹ������ֹ�˾���뿪��Ӫҵ���Զ�����ϵͳ����ʾ 
	document.all.commit.disabled = true;//Ϊ��ֹ����ȷ��

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

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

  	var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=printAccept%>;             	//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							  //�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		  //С������
	var opCode="2289" ;                   			 	//��������
	var phoneNo="<%=iPhoneNo%>";                  //�ͻ��绰

		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
    path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}

function printInfo(printType)
{
	var cust_info="";  				//�ͻ���Ϣ
	var opr_info="";   				//������Ϣ
	var note_info1=""; 				//��ע1
	var note_info2=""; 				//��ע2
	var note_info3=""; 				//��ע3
	var note_info4=""; 				//��ע4
	var retInfo = "";  				//��ӡ����

	opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
	cust_info+="�ͻ�������"+document.all.oCustName.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
	cust_info+="֤�����룺"+document.all.i7.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	opr_info+="�û�Ʒ�ƣ�"+document.all.oSmName.value+"    ҵ�����ͣ�ͳһԤ������"+"|";
  	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
  	if(document.all.OLD_PROJECT_TYPE.value=="0008")
  	{
		opr_info+="�������ƣ�"+document.all.Gift_Name.value+"|";
		opr_info+="Ԥ���"+document.all.Prepay_Fee.value+"Ԫ"+"  ���е���Ԥ�棺"+document.all.Base_Fee.value+"Ԫ���Ԥ�棺"+document.all.Free_Fee.value+"Ԫ"+"|";
	}

	else
	{
		retInfo+=" "+"|";
		retInfo+=" "+"|";
	}
	//begin huangrong add for �������ԤԼͳһԤ���������������
	if("<%=flag%>"=="1")
	{
		note_info1+="��ԤԼ����"+document.all.Gift_Name.value+"Ӫ����������<%=start_time%>��Ч��"+"|";
	}
	//end huangrong add for �������ԤԼͳһԤ���������������
	var gift_code = Number(document.all.Gift_Code.value);
	if("<%=regionCode%>"=="11" && document.all.OLD_PROJECT_TYPE.value=="0001" )
	{
		note_info1+="��ӭ���μ�Ԥ���������������Ԥ�滰�ѽ���"+document.all.Consume_Term.value+"���·�����ϣ����ν��ɵ�Ԥ������������ǰ���˲�ת��"+"|";
	}
	else if("<%=regionCode%>"=="13" && document.all.OLD_PROJECT_TYPE.value=="0004" )
	{
		 note_info2+="�˻Ԥ������"+document.all.Consume_Term.value+"���£��ڼ䲻�ܲμ��������Ԥ���˲�ת������תǩ�ʷѡ�"+"|";
	}
	else if("<%=regionCode%>"=="13" && document.all.OLD_PROJECT_TYPE.value=="0005" && document.all.Gift_Code.value =="0001" )
	{
		note_info3+="�˻Ԥ������8���£�ÿ�·���10Ԫ���ڼ䲻�ܲμ��������Ԥ����ڻ�ڼ��������꣬���˲�ת��"+"|";
	}
	else if("<%=regionCode%>"=="13" && document.all.OLD_PROJECT_TYPE.value=="0006" && gift_code>=1 && gift_code <=8 )
	{
		note_info3+="�˻Ԥ������12���£�ÿ�·���10Ԫ���ڼ䲻�ܲμ��������Ԥ����ڻ�ڼ��������꣬���˲�ת��"+"|";
	}
	else if(document.all.OLD_PROJECT_TYPE.value=="0008" && parseInt(document.all.Mark_Subtract.value,10)>=0 )
	{
		note_info4+="��ӭ���μӡ�Ԥ�����񡱻��������Ԥ�滰��"+document.all.Prepay_Fee.value+"Ԫ��������ҵ����Ч������"+document.all.Consume_Term.value+"������������ϣ�"+
		"����δ�������ʣ�໰�ѽ�һ���Կ۳�������Ԥ�滰����("+document.all.Free_Fee.value+")ԪΪ�Ԥ�滰�ѣ�������Լ������������ʹ�á�"+
		"����Ԥ�滰���У�"+document.all.Base_Fee.value+"��ԪΪ����Ԥ�滰�ѣ�ÿ�·���("+document.all.Mon_Base_Fee.value+")Ԫ���赱���������,�統�����Ѳ������("+document.all.Mon_Base_Fee.value+")Ԫ��"+
		"ʣ�ಿ�ֲ����ۻ�������ʹ�ã����ڵ��ں�һ���Կ۳�������Ԥ���ҵ����Ч�������ۼƷ���"+document.all.Consume_Term.value+"���¡�"+
		"��ҵ����ǰ������ȡ������ΥԼ�涨����������Ʒ�谴��Ʒԭ�۲����ֽ𣬲���ʣ��Ԥ����30%��ȡΥԼ��"+
		"���λδ�漰���ʷѣ������е��ƶ��绰�ʷѱ�׼ִ�С���Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�"+"|";
	}
	else if(document.all.OLD_PROJECT_TYPE.value=="0008" && parseInt(document.all.Mark_Subtract.value,10)<0 )
	{
		note_info4+="��ӭ���μӡ�Ԥ�������֡����������Ԥ�滰��"+document.all.Prepay_Fee.value+"Ԫ��������ҵ����Ч������"+document.all.Consume_Term.value+"������������ϣ�����δ�������ʣ�໰�ѽ�һ���Կ۳���"+
		"����Ԥ�滰����("+document.all.Free_Fee.value+")ԪΪ�Ԥ�滰�ѣ�������Լ������������ʹ�á�"+
		"����Ԥ�滰���У�"+document.all.Base_Fee.value+"��ԪΪ����Ԥ�滰�ѣ�ÿ�·���("+document.all.Mon_Base_Fee.value+")Ԫ"+
		"���赱���������,�統�����Ѳ������("+document.all.Mon_Base_Fee.value+")Ԫ��ʣ�ಿ�ֲ����ۻ�������ʹ�ã����ڵ��ں�һ���Կ۳���"+
		"����Ԥ���ҵ����Ч�������ۼƷ���"+document.all.Consume_Term.value+"���¡���ҵ����ǰ������ȡ������ΥԼ�涨�������Ļ����谴ÿ100�ֻ���5Ԫ�ֽ𲹽�������ʣ��Ԥ����30%����ΥԼ��";
		if("<%=point_note%>" !="no")
		{
			retInfo+="<%=point_note%>"+"�����ڴ�֮ǰ�һ����֡�";
		}
		note_info4+="���λδ�漰���ʷѣ������е��ƶ��绰�ʷѱ�׼ִ�С���Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�"+"|";
	}
	else if (document.all.OLD_PROJECT_TYPE.value == "0019" && document.all.Gift_Code.value == "0001")
	{
		note_info4+="��ӭ���μӡ����еش�Ԥ�����񡱻��������Ԥ�滰����300ԪΪ����Ԥ�滰�ѣ�������Ч��"+
				"����50Ԫ/�£��ɳ�ɲ��塢����ѵ�ר������ط��ã�������6���£�"+
				"�統�����Ѳ������50Ԫ��ʣ�ಿ�ֲ����ۻ�������ʹ�ã�"+
				"����δ�������ʣ�໰�ѽ�һ���Կ۳��������Ѵ���50Ԫ/��ʱ����ͻ����в��㵱��Ԥ�档���ɲ�������ͬ��Ԥ��������"+"|";

	}
	// add by dujl at 20090804 start***************************/
	else if (document.all.OLD_PROJECT_TYPE.value == "0020" && document.all.Gift_Code.value == "0002")
	{
		note_info4+="��ӭ���μӡ����еش�2009��Уӭ��Ԥ�����񡱻��������Ԥ�滰����500ԪΪ����Ԥ�滰�ѣ�������Ч��"+
				"����50Ԫ/��,������10���£�"+
				"�統�����Ѳ������50Ԫ���ɳ�ɲ��塢����ѵ�ר������ط��ã���ʣ�ಿ�ֲ����ۻ�������ʹ�ã�"+
				"����δ�������ʣ�໰�ѽ�һ���Կ۳��������Ѵ���50Ԫ/��ʱ����ͻ����в��㵱��Ԥ�档���ɲ�������ͬ��Ԥ��������"+"|";
	}
	else if (document.all.OLD_PROJECT_TYPE.value == "0020" && document.all.Gift_Code.value == "0001")
	{
		note_info4+="��ӭ���μӡ����еش�2009��Уӭ��Ԥ�����񡱻��������Ԥ�滰����800ԪΪ����Ԥ�滰�ѣ�������Ч��"+
				"����50Ԫ/�£��ɳ�ɲ��塢����ѵ�ר������ط��ã�,������16���£�"+
				"�統�����Ѳ������50Ԫ��ʣ�ಿ�ֲ����ۻ�������ʹ�ã�"+
				"����δ�������ʣ�໰�ѽ�һ���Կ۳��������Ѵ���50Ԫ/��ʱ����ͻ����в��㵱��Ԥ�档���ɲ�������ͬ��Ԥ��������"+"|";
	}
	// add by dujl at 20090804  end****************************/
	// add by dujl at 20090410******************************
	else if (document.all.OLD_PROJECT_TYPE.value == "0011" )
	{
		note_info4+="�𾴵Ŀͻ�����ӭ������ǩԼ�������������ɵ�Ԥ��� 120Ԫÿ�·���10Ԫ��"+
					"12�����������꣬ û�����꽫һ���Կ۳��������ǩԼ���޲���12���������� Ԥ�����˻���"+
					"�������Լ�����۳�ʣ��Ԥ����30%ΥԼ����Ʒ����ԭ�۸��ջ��ֽ�"+"|";
	}
	//****** add by fengry at 20090923 start ******/
	else if("<%=regionCode%>" == "07" && document.all.OLD_PROJECT_TYPE.value == "0001")
	{
		note_info4+="��ӭ���μӡ�Ԥ�����񡱻��������Ԥ�滰��"+document.all.Prepay_Fee.value+"Ԫ��������ҵ����Ч������"+document.all.Consume_Term.value+
		"������������ϣ�����δ�������ʣ�໰�ѽ�һ���Կ۳�������Ԥ�滰����"+document.all.Base_Fee.value+"ԪΪ����Ԥ�滰�ѣ�ÿ�·���"+document.all.Mon_Base_Fee.value+
		"Ԫ���赱��������ϣ��統�����Ѳ������"+document.all.Mon_Base_Fee.value+"Ԫ��ʣ�ಿ�ֲ����ۼ�������ʹ�ã����ڵ��ں�һ���Կ۳�������Ԥ���ҵ����Ч�������ۼƷ���"+document.all.Consume_Term.value+
		"���¡���ҵ����ǰ������ȡ������ΥԼ�涨����������Ʒ�谴��Ʒԭ�۲����ֽ𣬲���ʣ��Ԥ����30%��ȡΥԼ��"+
		"�����뱾�λ��ҵ��δ����ǰ�����ٴβ�������Ԥ��������"+
		"���λδ�漰���ʷѣ������е��ƶ��绰�ʷѱ�׼ִ�С���Э����Ч�������������ʷѱ�׼�����������µ��ʷ�����ִ�С�"+"|";
	}
	else if("<%=regionCode%>" == "01" && document.all.OLD_PROJECT_TYPE.value == "0021")
	{
		note_info4+="��ܰ��ʾ��"+"|";
		note_info4+="��ӭ���μ�����Ԥ��������������Ԥ�滰��"+document.all.Prepay_Fee.value+"Ԫ��������ҵ����Ч������"+document.all.Consume_Term.value+
		"������������ϣ�����δ�������ʣ�໰�ѽ�һ���Կ۳�������Ԥ�滰����"+document.all.Base_Fee.value+"ԪΪ����Ԥ�滰�ѣ�ÿ�·���"+document.all.Mon_Base_Fee.value+
		"Ԫ���赱��������ϣ��統�����Ѳ������"+document.all.Mon_Base_Fee.value+"Ԫ��ʣ�ಿ�ֲ����ۻ�������ʹ�ã����ڵ��ں�һ���Կ۳�������Ԥ���ҵ����Ч�������ۼƷ���"+document.all.Consume_Term.value+
		"���¡���ҵ����ǰ������ȡ������ΥԼ�涨����������Ʒ�谴��Ʒԭ�۲����ֽ𣬲���ʣ��Ԥ����30%��ȡΥԼ��"+
		"���λδ�漰���ʷѣ������е��ƶ��绰�ʷѱ�׼ִ�С���Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�"+
		"���Ԥ���˲�ת��Ԥ�滰�����ڹ涨ʱ����������ϣ�ҵ��δ���ڲ����Բμ�������Լ�����Żݻ�������ظ��μӱ����"+"|";
	}
	else if("<%=regionCode%>" == "01" && document.all.OLD_PROJECT_TYPE.value == "0022")
	{
		note_info4+="��ܰ��ʾ��"+"|";
		note_info4+="��ӭ���μ�Ԥ��������������Ԥ�滰��"+document.all.Prepay_Fee.value+"Ԫ��������ҵ����Ч������"+document.all.Consume_Term.value+
		"������������ϣ�����δ�������ʣ�໰�ѽ�һ���Կ۳�������Ԥ�滰����"+document.all.Base_Fee.value+"ԪΪ����Ԥ�滰�ѣ�ÿ�·���"+document.all.Mon_Base_Fee.value+
		"Ԫ���赱��������ϣ��統�����Ѳ������"+document.all.Mon_Base_Fee.value+"Ԫ��ʣ�ಿ�ֲ����ۻ�������ʹ�ã����ڵ��ں�һ���Կ۳�������Ԥ���ҵ����Ч�������ۼƷ���"+document.all.Consume_Term.value+
		"���¡���ҵ����ǰ������ȡ������ΥԼ�涨����������Ʒ�谴��Ʒԭ�۲����ֽ𣬲���ʣ��Ԥ����30%��ȡΥԼ��"+
		"���λδ�漰���ʷѣ������е��ƶ��绰�ʷѱ�׼ִ�С���Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�"+
		"���Ԥ���˲�ת��Ԥ�滰�����ڹ涨ʱ����������ϣ�ҵ��δ���ڲ����Բμ�������Լ�����Żݻ�������ظ��μӱ����"+"|";
	}
	else if("<%=regionCode%>" == "01" && document.all.OLD_PROJECT_TYPE.value == "0025")
	{
		note_info4+="��ܰ��ʾ��"+"|";
		note_info4+="��ӭ���μ�Ԥ��������������Ԥ�滰��"+document.all.Prepay_Fee.value+"Ԫ��������ҵ����Ч������"+document.all.Consume_Term.value+
		"������������ϣ�����δ�������ʣ�໰�ѽ�һ���Կ۳�������Ԥ�滰����"+document.all.Free_Fee.value+"ԪΪ�Ԥ�滰�ѣ�������Լ������������ʹ�á�����Ԥ�滰����"+
		+document.all.Base_Fee.value+"ԪΪ����Ԥ�滰�ѣ�ÿ�·���"+document.all.Mon_Base_Fee.value+
		"Ԫ���赱��������ϣ��統�����Ѳ������"+document.all.Mon_Base_Fee.value+"Ԫ��ʣ�ಿ�ֲ����ۻ�������ʹ�ã����ڵ��ں�һ���Կ۳�������Ԥ���ҵ����Ч�������ۼƷ���"+document.all.Consume_Term.value+
		"���¡���ҵ����ǰ������ȡ������ΥԼ�涨����������Ʒ�谴��Ʒԭ�۲����ֽ𣬲���ʣ��Ԥ����30%��ȡΥԼ��"+
		"���λδ�漰���ʷѣ������е��ƶ��绰�ʷѱ�׼ִ�С���Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�"+
		"���Ԥ���˲�ת��Ԥ�滰�����ڹ涨ʱ����������ϣ�ҵ��δ���ڲ����Բμ�������Լ�����Żݻ�������ظ��μӱ����"+"|";
	}
	//****** add by fengry at 20090923 end ******/
	//****** add by fengry at 20091013 start ******/
	else if(document.all.OLD_PROJECT_TYPE.value == "0027")
	{
		note_info4+="��ӭ���μӡ�Ԥ�����񡱻��������Ԥ�滰��"+document.all.Prepay_Fee.value+"Ԫ��������ҵ����Ч������"+document.all.Consume_Term.value+
		"������������ϣ�����δ�������ʣ�໰�ѽ�һ���Կ۳�������Ԥ�滰����"+
		+document.all.Base_Fee.value+"ԪΪ����Ԥ�滰�ѣ�ÿ�·���"+document.all.Mon_Base_Fee.value+
		"Ԫ���赱��������ϣ��統�����Ѳ������"+document.all.Mon_Base_Fee.value+"Ԫ��ʣ�ಿ�ֲ����ۼ�������ʹ�ã����ڵ��ں�һ���Կ۳�������Ԥ���ҵ����������ۼƷ���"+document.all.Consume_Term.value+
		"���¡���ҵ����ǰ������ȡ����ʣ��Ԥ���һ���Կ۳����ٷ�������ҵ����ǰ������������������ȡ����ҵ��"+
		"�����뱾�λ��ҵ��δ����ǰ�����ٴβ�������Ԥ��������"+
		"���λδ�漰���ʷѣ������е��ƶ��绰�ʷѱ�׼ִ�С���Э����Ч�������������ʷѱ�׼�����������µ��ʷ�����ִ�С�"+"|";
	}
	//****** add by fengry at 20091013 end ******/
	/******* add by ningtn @ 20100422  start ****/
	else if(document.all.OLD_PROJECT_TYPE.value == "aaaa"){
		note_info4 += document.all.New_Mode_Name.value + "|";
	}
	/******* add by ningtn @ 20100422  end   ****/
	else
	{
		note_info1+="��ע������Ԥ��ר�������Ч�����˲�ת"+"|";
	}
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

//-->
</script>

</head>
<body>
<form name="frm" method="post" action="f2289Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
		<input type="hidden" name="openTime" value="<%=open_time%>">

	<div class="title">
		<div id="title_zi">��2010��4��10�տ�ʼ�����ҵ��,���û���Ҫ�콱,�뵽6842�°����Ʒͳһ��������Ϊ�û��콱��
			(����6842��Ȩ�ޣ����빤�Ź���Ա��ϵ��ӡ�)</div>
	</div>
	<div class="title">
		<div id="title_zi">2010��4��10��ǰ�����ҵ��,���û���Ҫ�콱,�뵽2266����Ʒͳһ��������Ϊ�û��콱��</div>
	</div>

	<div class="title">
		<div id="title_zi">ҵ����ϸ</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue">��������</td>
		<td colspan="3">
			<select id=projectType name=projectType onblur="hideMessage();" onChange="chkType()" style="width:300px;" >
		    <%
		    //yuanqs add onblur="hideMessage();" 2010/11/3 9:48:45 
		    	String[] inParas1 = new String[2];
		    	inParas1[0] =
				"select trim(a.project_code),trim(a.project_name) " +
				"  from ssaleproject a, ssaleop b " +
				" where a.project_code = b.project_code " +
				"   and a.region_code in( :region_code, '**') " +
				"   and b.op_code = :op_code " +
				"   and a.project_status = 'Y' " +
				"   and a.start_date <=sysdate and a.end_date >=sysdate " +
				"   and exists (select 1 from sSaleGrade c ,sSaleGradePackage d " +
				"   where c.project_code = a.project_code  and c.grade_status='Y'  and d.status ='Y' " +
				"   and c.project_code = d.project_code and c.grade_code = d.grade_code and d.region_code='"+regionCode+"') order by a.op_time desc ";
				// yuanqs add order by 2010/11/3 9:49:10 
				inParas1[1] = "region_code="+regionCode+",op_code="+opCode;
				//System.out.println("op_code=2289:�������� = "+ inParas1[0] );
				//System.out.println("regionCode="+ regionCode+",op_code="+opCode);
%>
			<wtc:service name="TlsPubSelCrm"  outnum="2" retcode="retCode1" retmsg="regMsg1">
				<wtc:param value="<%=inParas1[0]%>"/>
				<wtc:param value="<%=inParas1[1]%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end"/>
<%

				recordNum = result.length;
				System.out.println("recordNum======="+recordNum);
				for(i=0;i<recordNum;i++)
				{
					out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][0]+"-->"+result[i][1] + "</option>");
				}
		   %>
		   </select>
		</td>
	</tr>
	<tr>
		<td class="blue">�ֻ�����</td>
		<td width="39%">
			<input class="InputGrey" type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly >
		</td>
		<td class="blue">��������</td>
		<td>
			<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">ҵ��Ʒ��</td>
		<td>
			<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
		</td>
		<td class="blue">�ʷ�����</td>
		<td>
			<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" size ="40" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">�ʺ�Ԥ��</td>
		<td>
			<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=prepay_fee%>" readonly>
		</td>
		<td class="blue">��ǰ����</td>
		<td>
			<input name="oMarkPoint" type="text" class="InputGrey" id="oMarkPoint" value="<%=print_note%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">��������</td>
		<td>
			<input class="InputGrey" type="text" name="Gift_Code" id="Gift_Code" readonly>
			<input class="b_text" type="button" name="qryId_No" value="��ѯ" onClick="getInfo_code()" >
				<font color="orange">*</font>
		</td>
		<td class="blue">��������</td>
		<td>
			<input name="Gift_Name" type="text" class="InputGrey" id="Gift_Name" v_type="string" v_must=1 value=""  size="40" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">����Ԥ��</td>
		<td>
			<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly>
		</td>
		<td class="blue">�Ԥ��</td>
		<td>
			<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"   readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">�ۼ�����</td>
		<td>
			<input name="Mark_Subtract" type="text" class="InputGrey" id="Mark_Subtract"   readonly>
		</td>
		<td class="blue">��������</td>
		<td>
			<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"   readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">�µ���</td>
		<td>
			<input name="Mon_Base_Fee" type="text" class="InputGrey" id="Mon_Base_Fee" readonly>
		</td>
		<td class="blue">Ӧ�ս��</td>
		<td >
			<input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee"   readonly>
		</td>
	</tr>
	<!-- ningtn add for pos start @ 20100430 -->
	<TR>
		<TD class="blue">�ɷѷ�ʽ</TD>
		<TD colspan="3" id="td1">
			<select name="payTypeSelect" >
				<option value="0">�ֽ�ɷ�</option>
				<option value="BX">��������POS���ɷ�</option>
				<option value="BY">��������POS���ɷ�</option>
			</select>
		</TD>
		<!--begin huangrong add-->
		<td class="blue" id="td2" style='display:none'>�Ƿ����齱</td>
		<td id="td3" style='display:none'>
			<input type="radio" name="take_prize" value="0">��&nbsp;&nbsp;
			<input type="radio" name="take_prize" value="1">��
		</td>
		<!--end huangrong add-->
	</TR>
	<!-- ningtn add for pos end @ 20100430 -->
	<tr>
		<!-- dujl �޸�class="button" 20090428 -->
		<td class="blue">��    ע</td>
		<td colspan="3" >
			<input name="do_note" type="text" class="button" id="do_note" value="" size="60" maxlength="60" >

		</td>
	</tr>
</table>
<!-- ningtn 2011-7-12 08:33:59 ������ӹ��� -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=loginAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
<table>
	<tr>
		<td colspan="4" align="center" id="foot">
			&nbsp;
			<input name="commit" id="commit" type="button" class="b_foot"   value="ȷ��&��ӡ" onClick="printCommit();">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" value="���" >
			&nbsp;
			<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
			&nbsp;
		</td>
	</tr>
</table>

<div name="licl" id="licl">
			<input type="hidden" name="iOpCode" value="2289">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<input type="hidden" name="i2" value="<%=cust_id%>">
			<input type="hidden" name="i16" value="<%=rate_code%>">
			<input type="hidden" name="ip" value="">
      <input type="hidden" name="flag" value="<%=flag%>"><!--huangrong add -->
      <input type="hidden" name="payFlag" value=" "><!--huangrong add for ���ڹ������ֹ�˾���뿪��Ӫҵ���Զ�����ϵͳ����ʾ -->
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

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">

			<input type="hidden" name="mode_type" value="">
			<input type="hidden" name="New_Mode_Name" value=" ">
			<input type="hidden" name="return_page" value="/npage/s1141/f2289_login.jsp">
			<input type="hidden" name="login_accept" value="<%=printAccept%>">
			<input type="hidden" name="cus_pass" value="<%=cus_pass%>">

			<input type="hidden" name="OLD_PROJECT_TYPE" >
			<!-- ningtn add for pos start @ 20100430 -->		
					<input type="hidden" name="payType"  value=""><!-- �ɷ����� payType=BX �ǽ��� payType=BY �ǹ��� -->			
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
			<!-- ningtn add for pos end @ 20100430 -->
</div>
<!-- yuanqs add 2010/10/29 10:37:01 �ֲ����� begin -->
	<div id="msgDiv">
	    <span></span>
	</div>
<!-- yuanqs add 2010/10/29 10:37:01 �ֲ����� end -->
	<%@ include file="/npage/include/footer.jsp" %>
</form>
<!-- **** ningtn add for pos @ 20100430 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100430 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</body>
<!-- ningtn 2011-7-12 08:35:36 ���ӻ���������Χ -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>
