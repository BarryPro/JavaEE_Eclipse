<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: gaopeng 2016/6/3 15:55:01 �����������
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String broadPhone = request.getParameter("broadPhone");  //����˺�
		String loginAccept = getMaxAccept();
		String orgCode = (String)session.getAttribute("orgCode");
		
		Calendar today =   Calendar.getInstance();  
    today.add(Calendar.MONTH,1);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");  
    String addOneMonth = sdf.format(today.getTime());
    String addoneMonthDay = addOneMonth+"01";
		
		/*
	  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
		String[] favStr = new String[temfavStr.length];
		boolean operFlag = false;
		for(int i = 0; i < favStr.length; i ++) {
			favStr[i] = temfavStr[i][0].trim();
		}
		if (WtcUtil.haveStr(favStr, "a996")) {
			operFlag = true;
		}
		*/
	String ipAddrM = (String)session.getAttribute("ipAddr");
 		String inst = "ͨ��phoneNo[" + phoneNo + "]��ѯ";
		String gCustId = "";
		String custSql = "";
		String custName = "";
		String  inParamsMail [] = new String[2];
    inParamsMail[0] = "select trim(t.cust_id) from dcustmsg t where phone_no =:phoneNo";
    inParamsMail[1] = "phoneNo="+phoneNo;
		
%>
 <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="1"> 
    <wtc:param value="<%=inParamsMail[0]%>"/>
    <wtc:param value="<%=inParamsMail[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_mail"  scope="end"/>
<%
	if("000000".equals(retCode_mail) && result_mail.length > 0){
		gCustId = result_mail[0][0];
	}else{
		%>
		<script language="javascript">
			rdShowMessageDialog("��ȡ�ͻ���Ϣʧ�ܣ�");
			removeCurrentTab();
		</script>
		<%
	}

String beizhussdese1="����custid=["+gCustId+"]���в�ѯ";
%>  	
	 	
	<wtc:service name="sUserCustInfo" outnum="100" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opCode%>" />	
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=noPass%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrM%>" />
			<wtc:param value="<%=beizhussdese1%>" />
			<wtc:param value="<%=gCustId%>" />
</wtc:service>
<wtc:array id="result_custInfo" scope="end"/>	
	 	

<wtc:service name="s1259Init" routerKey="phone" routerValue="<%=regionCode%>" outnum="42" retmsg="errMsg" retcode="errCode">
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=loginNo%>"/>	
			<wtc:param value="<%=noPass%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=orgCode%>"/>	
			 
</wtc:service>
	<wtc:array id="tempArr" start="0"  length="41" scope="end"/>
<%
String  bp_name="",sm_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",prepay_act_fee="",prepay_year_fee="",begin_time="",end_time="",leave_fee="",before_rate_code="",before_rate_name="",pay_type="",print_note="";
  String passwordFromSer="";
  
  if(tempArr.length > 0 && errCode.equals("000000"))
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
	    prepay_fee = tempArr[0][16];//��Ԥ��
	    cardId_type = tempArr[0][17];//֤������
	    cardId_no = tempArr[0][18];//֤������
	    cust_id = tempArr[0][19];//�ͻ�id
	    cust_belong_code = tempArr[0][20];//�ͻ�����id
	    group_type_code = tempArr[0][21];//���ſͻ�����
	    group_type_name = tempArr[0][22];//���ſͻ���������
	    imain_stream = tempArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	    next_main_stream = tempArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	    prepay_year_fee = tempArr[0][25];//����Ԥ���
	    prepay_act_fee = tempArr[0][26];//ʵ��Ԥ���
	    begin_time = tempArr[0][27];//��ʼʱ��
	    end_time = tempArr[0][28];//����ʱ��
	    before_rate_code = tempArr[0][29];//�������ǰ�ʷѴ���
	    before_rate_name = tempArr[0][30];//�������ǰ�ʷ�����
	    pay_type = tempArr[0][32];//���ѷ�ʽ
	    leave_fee = tempArr[0][33];//ʣ���� ʣ�����ר�� m387ר��
	    print_note = tempArr[0][38];//��������
	    
		}else{
			%>
			
			<script language="javascript">
				rdShowMessageDialog("<%=errMsg%>",0);
				removeCurrentTab();
			</script>
			
			<%
			
		}
%>		

<%	 	

String custIccid = "";
String custAddr = "";
if(result_custInfo.length>0){
if(result_custInfo[0][0].equals("01")) {
	custAddr = result_custInfo[0][11];
	custIccid = result_custInfo[0][13];
	custName = result_custInfo[0][5];
	}
}
%>

<html>
<head>
	<title><%=opName%></title>
	<style>
		#popupcontent{ 
			position: absolute; 
			visibility: hidden; 
			overflow: hidden; 
			border:1px solid #CCC; 
			background-color:#F9F9F9; 
			border:1px solid #333; 
			padding:5px; 
		} 
	
	</style>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		
		/*2015/04/15 10:40:56 gaopeng ������CRM�����ֻ����ֶһ������Ʒ���ܵ����� �Ƿ�ʹ�û��ֵ���������*/
		function ifUseIntegralBtn(){
			var ifUseIntegral = $("#ifUseIntegral").attr("checked");
			if(ifUseIntegral == true){
				$("#IntegralFiled").show();
				
			}else{
				$("#intePhoneNo").val("");
				$("#intePassWord").val("");
				$("#intePhoneNo").attr("class","");
				$("#intePhoneNo").attr("readonly",false);
				$("#intePassWord").attr("class","");
				$("#intePassWord").attr("readonly",false);
				
				$("#inteCustName").val("");
				$("#inteCustName").attr("class","");
				$("#inteCustName").attr("readonly",false);
				$("#inteNumber").val("0");
				$("#inteNumber").attr("class","");
				$("#inteNumber").attr("readonly",false);
				
				$("#inteUseNum").val("0");
				$("#intePrice").val("0");
				globalIngegralFlag = false;
				$("#IntegralFiled").hide();
			}
		}
		
		/*2015/04/15 10:40:56 gaopeng ������CRM�����ֻ����ֶһ������Ʒ���ܵ����� ��ȡ��ǰ���û��ֵķ���*/
function getIntegral(){
	
	var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
	
	if(ifUseIntegral){
	
		var iPhoneNo = $.trim($("#intePhoneNo").val());
		var iUserPwd = $.trim($("#intePassWord").val());
		
		if(iPhoneNo.length == 0){
			rdShowMessageDialog("�������ֻ����룡",1);
			return false;
		}
		if(iUserPwd.length == 0){
			rdShowMessageDialog("������������룡",1);
			return false;
		}
		
		var getdataPacket = new AJAXPacket("/npage/public/fGetIntegral.jsp","���ڻ�����ݣ����Ժ�......");
		var iLoginAccept = "<%=loginAccept%>";
		var iChnSource = "01";
		var iOpCode = "<%=opCode%>";
		var iLoginNo = "<%=loginNo%>";
		var iLoginPwd = "<%=noPass%>";
		
		
		getdataPacket.data.add("iLoginAccept",iLoginAccept);
		getdataPacket.data.add("iChnSource",iChnSource);
		getdataPacket.data.add("iOpCode",iOpCode);
		getdataPacket.data.add("iLoginNo",iLoginNo);
		getdataPacket.data.add("iLoginPwd",iLoginPwd);
		getdataPacket.data.add("iPhoneNo",iPhoneNo);
		getdataPacket.data.add("iUserPwd",iUserPwd);
		
		core.ajax.sendPacket(getdataPacket,doRetInte);
		getdataPacket = null;
	}
	
}
function doRetInte(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var inteCustName = packet.data.findValueByName("custName");
		var inteNumber = packet.data.findValueByName("integralNum");
		var maxIntegralNum = packet.data.findValueByName("maxIntegralNum");
		
		if(retCode == "000000"){
			rdShowMessageDialog("У��ɹ���",2);
			$("#intePhoneNo").attr("class","InputGrey");
			$("#intePhoneNo").attr("readonly","readonly");
			$("#intePassWord").attr("class","InputGrey");
			$("#intePassWord").attr("readonly","readonly");
			
			$("#inteCustName").val(inteCustName);
			$("#inteCustName").attr("class","InputGrey");
			$("#inteCustName").attr("readonly","readonly");
			$("#inteNumber").val(inteNumber);
			$("#inteNumber").attr("class","InputGrey");
			$("#inteNumber").attr("readonly","readonly");
			$("#maxIntegralNum").val(maxIntegralNum);
			
		}else{
			rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
			
		}
}

var globalMarkFlag = false;
function markIntegral(){
	
		var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
		
		/*2015/04/22 10:42:04 gaopeng ѡ����ֵ ����Ϊ��*/
		var iPhoneNo = ifUseIntegral == true ? $.trim($("#intePhoneNo").val()):"";
		var iUserPwd = ifUseIntegral == true ? $.trim($("#intePassWord").val()):"";
		var inteUseNum = ifUseIntegral == true ? $.trim($("#inteUseNum").val()):"";
		var iKdNo = "<%=phoneNo%>";
		var getdataPacket = new AJAXPacket("/npage/public/fMarkIntegral.jsp","���ڻ�����ݣ����Ժ�......");
		var iLoginAccept = "<%=loginAccept%>";
		
		var iChnSource = "01";
		var iOpCode = "<%=opCode%>";
		var iLoginNo = "<%=loginNo%>";
		var iLoginPwd = "<%=noPass%>";
		var ifUseI = ifUseIntegral == true ? "1":"0";
		
		
		getdataPacket.data.add("iLoginAccept",iLoginAccept);
		getdataPacket.data.add("iChnSource",iChnSource);
		getdataPacket.data.add("iOpCode",iOpCode);
		getdataPacket.data.add("iLoginNo",iLoginNo);
		getdataPacket.data.add("iLoginPwd",iLoginPwd);
		getdataPacket.data.add("iPhoneNo",iPhoneNo);
		getdataPacket.data.add("iUserPwd","");
		getdataPacket.data.add("iKDNo",iKdNo);
		getdataPacket.data.add("inteUseNum",inteUseNum);
		getdataPacket.data.add("ifUseI",ifUseI);
		
		core.ajax.sendPacket(getdataPacket,doRetInteMark);
		getdataPacket = null;
	
	
}
function doRetInteMark(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		
		
		if(retCode == "000000"){
			
			globalMarkFlag = true;
			
		}else{
			rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
			globalMarkFlag = false;
		}
}

var globalIngegralFlag = false;
/*�������� У������Ļ���ֵ ������100�ı��� 100���ֵֿ�1��Ǯ*/
function checkIngegralNum(){
	var integralNumObj = $("#inteUseNum")[0];
	if(!checkElement(integralNumObj)){
		return false;
	}
	var integralNum = $.trim(integralNumObj.value);
	if(integralNum.length == 0){
		rdShowMessageDialog("������Ļ���ֵ��",1);
		integralNumObj.value = "";
		
		return false;
	}
	if((Number(integralNum) % 100) != 0){
		rdShowMessageDialog("����Ļ���ֵ������100�ı�����",1);
		integralNumObj.value = "";
		
		return false;
	}
	/*�ֿ۵Ľ��*/
	var integralMoney = Number(Number(integralNum) / 100);
	var maxIntegralNum = Number($.trim($("#maxIntegralNum").val()));
	if(integralMoney > maxIntegralNum){
		rdShowMessageDialog("�ֿ۽��ܳ�������",1);
		integralNumObj.value = "";
		
		return false;
	}
	$("#intePrice").val(integralMoney);
	$("#intePrice").attr("class","InputGrey");
	$("#intePrice").attr("readonly","readonly");
	globalIngegralFlag = true;
	
}

	function doCommit(){
		if("<%=sm_code%>" == "kf"){
			var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
			if(ifUseIntegral){
				if(!globalIngegralFlag){
					 rdShowMessageDialog("����У��������룬������ֿۻ��֣�",0);
			     return false;
				}
			}
		}
			
			var prepay_fee = "<%=prepay_fee%>";
			var sybnzk = "<%=leave_fee%>";
			
			var newFeeCode = $.trim($("#new_rate_code").val());
			if(newFeeCode.length == 0){
				rdShowMessageDialog("��ѡ�����ײͣ�",0);
			  return false;
			}
			var year_fee = $("#year_fee").val();
			var intePrice = $("#intePrice").val();
			var resultNum = Number(prepay_fee)+Number(sybnzk)+Number(intePrice)-Number(year_fee);
			if(resultNum<0){
				rdShowMessageDialog("����Ԥ����㣬���������ҵ��!",0);
			  return false;
			}
			
			var  ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
		    
		     if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
            		nextStep();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
								nextStep();
          }
        }
      }else{
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
								nextStep();
        }
      }
			
			
		
			
	
		
	}
	function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				rdShowMessageDialog("�����ɹ�",2);
				removeCurrentTab();
			}else{
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				removeCurrentTab();
			}
	}
	
	function nextStep(){
		
		var prepay_fee = "<%=prepay_fee%>";
			var sybnzk = "<%=leave_fee%>";
			
			var newFeeCode = $.trim($("#new_rate_code").val());
			
			var year_fee = $("#year_fee").val();
			var intePrice = $("#intePrice").val();
			var resultNum = Number(prepay_fee)+Number(sybnzk)+Number(intePrice)-Number(year_fee);
			
			
		var phoneNo = "";
			var startCardNo = $.trim($("#startCardNo").val());
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm387/fm387Cfm.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = "<%=phoneNo%>";
			var iUserPwd = "";
			
			var oldFeeCode = "<%=rate_code%>";
			
			var jfdkFlag = $("#ifUseIntegral").attr("checked")==true?"1":"0";
			var jfdkPhone = $.trim($("#intePhoneNo").val());
			var jdfkNum = $.trim($("#inteUseNum").val());
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			
			getdataPacket.data.add("oldFeeCode",oldFeeCode);
			getdataPacket.data.add("newFeeCode",newFeeCode);
			getdataPacket.data.add("jfdkFlag",jfdkFlag);
			getdataPacket.data.add("jfdkPhone",jfdkPhone);
			getdataPacket.data.add("jdfkNum",jdfkNum);
			
			
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
		
	}
	
	/**��ѯ���ײ�**/
function getNewRateCode()
{ 

	//���ù���js�õ����ײʹ���
  var pageTitle = "�ʷѴ����ѯ";


   var fieldName = "�ʷѴ���|�ʷ�����|��С���|��������|���ѷ�ʽ|�ʷ�����|����С��|";
  var sqlStr = "";
  
  //alert("sqlStr|"+sqlStr);

  var selType = "S";    //'S'��ѡ��'M'��ѡ
  var retQuence = "7|0|1|2|3|4|5|6|";
  
  var retToField = "new_rate_code|new_rate_name|year_fee|year_month|pay_type|flag_code_1|xiaoquCode|";

  if(!(PubSimpSele(pageTitle,fieldName,sqlStr,selType,retQuence,retToField))) return false;
}

function PubSimpSele(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/se974/fPubSimpSer_e974.jsp?offerId=<%=rate_code%>&newOfferId="+document.all.new_rate_code.value;
    path = path + "&sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType + "&opCode=<%=opCode%>";  
    retInfo = window.showModalDialog(path,"","dialogWidth:60");
    if(retInfo ==undefined)      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
    	
        obj = retToField.substring(0,chPos_field);
        //alert(obj);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	return true;
}
function changeRateCode()
{
    document.frm.flag_code.value="";
	document.frm.flag_code_name.value="";
	document.frm.rate_code.value="";
}

var baseText = null; 

function showPopup(w,h){ 
	var popUp = document.getElementById("popupcontent"); 
	popUp.style.top = "100px"; 
	popUp.style.left = "100px"; 
	popUp.style.width = w + "px"; 
	popUp.style.height = h + "px"; 
	if (baseText == null) baseText = popUp.innerHTML; 
	popUp.innerHTML = baseText + "<div id=\"statusbar\"><button onclick=\"hidePopup(); \">Close window<button></div>"; 
	var sbar = document.getElementById("statusbar"); 
	sbar.style.marginTop = (parseInt(h)-40) + "px"; 
	popUp.style.visibility = "visible"; 
} 

function hidePopup(){ 
var popUp = document.getElementById("popupcontent"); 
popUp.style.visibility = "hidden"; 
} 


function showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի��� 
      var h=180;
      var w=350;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;		   	   
      var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
      var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
      var sysAccept ="<%=loginAccept%>";             	//��ˮ��
        var printStr = printInfo(printType);
      
	 		                      //����printinfo()���صĴ�ӡ����
      var mode_code=null;           							  //�ʷѴ���
      var fav_code=null;                				 		//�ط�����
      var area_code=null;             				 		  //С������
      var opCode="<%=opCode%>" ;                   			 	//��������
      var phoneNo="<%=activePhone%>";                  //�ͻ��绰
      
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
      path+="&mode_code="+mode_code+
      	"&fav_code="+fav_code+"&area_code="+area_code+
      	"&opCode=<%=opCode%>&sysAccept="+sysAccept+
      	"&phoneNo="+phoneNo+
      	"&submitCfm="+submitCfm+"&pType="+
      	pType+"&billType="+billType+ "&printInfo=" + printStr;
      var ret=window.showModalDialog(path,printStr,prop);
      return ret;
    }				
			
    function printInfo(printType){
			
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
			cust_info += "����ʺţ�<%=broadPhone%> |";
			cust_info += "�ͻ�������<%=custName%>|";
			
      opr_info += "����ҵ��   "+"<%=opName%>" +"|";
      opr_info += "������ˮ��   "+"<%=loginAccept%>"+"|";
      
      opr_info +="��ǰ���ʷѣ�<%=rate_code%>-><%=rate_name%>|";
      opr_info +="���������ʷѣ�"+$("#new_rate_code").val()+"->"+$("#new_rate_name").val()+"|";
      opr_info +="���ʷ���Чʱ�䣺<%=addoneMonthDay%>|";
      opr_info +="���������ʷ�������"+document.all.flag_code_1.value+"|";
      /*
      note_info1 += "��ע��|";
      note_info1 += "1��	�°����ʷѴ�����Ч��������ִ��ԭ�ʷѱ�׼��|";
      note_info1 += "2��	��ͻ�ʣ������С�����ʷѼ۸��貹����ۡ�|";
      note_info1 += "3��	��ͻ�ʣ������������ʷѼ۸񣬿۳����ʷѼۿ�����Ǯ��ɷ��ֽ�|";
      note_info1 += "4��	����������벦��������ߣ�10086��|";
 			*/
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    } 





	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
		<table>
	    <tr>
	  		<td width="20%" class="blue">����˺�</td>
	  		<td width="80%" colspan="3">
	  			<input type="text" id="kdNo" name="kdNo" value="<%=broadPhone%>" class="InputGrey" readonly/>&nbsp;&nbsp;
	  		</td>
	    </tr>
	     <tr>
	  		<td width="20%" class="blue">����Ԥ��</td>
	  		<td width="30%" >
	  			<input type="text" id="kyyc" name="kyyc" value="<%=prepay_fee%>" class="InputGrey" readonly/>&nbsp;&nbsp;
	  		</td>
	  		<td width="20%" class="blue">ʣ�����ר��</td>
	  		<td width="30%" >
	  			<input type="text" id="sybnzk" name="sybnzk" value="<%=leave_fee%>" class="InputGrey" readonly/>&nbsp;&nbsp;
	  		</td>
	    </tr>
	    <tr>
	  		<td width="20%" class="blue">��ǰ���ʷѱ���</td>
	  		<td width="30%" >
	  			<input type="text" id="feeCodeNow" name="feeCodeNow" value="<%=rate_code%>" class="InputGrey" readonly/>&nbsp;&nbsp;
	  		</td>
	  		<td width="20%" class="blue">��ǰ���ʷ�����</td>
	  		<td width="30%" >
	  			<input type="text" size="33" id="feeNameNow" name="feeNameNow" value="<%=rate_name%>" class="InputGrey" readonly/>&nbsp;&nbsp;
	  		</td>
	    </tr>
			<tr> 
				<td class="blue">���ײʹ���</td>
				<td colspan="3" id="ipTd">
					<input type="text" class="button" name="new_rate_code" id="new_rate_code" onChange="changeRateCode()" size="8" maxlength="8" v_must=1 v_name="���ײʹ���" >
					<input type="text" class="button" name="new_rate_name" id="new_rate_name" size="33"  v_name="���ײ�����">
					<font class="orange">*</font>
					&nbsp;&nbsp;
					<input name="newRateCodeQuery" type="button" class="b_text"  style="cursor:hand" onClick="getNewRateCode();" value=��ѯ>
				</td>
			</tr>
			<tr>
		    <td class="blue">��������</td>
        <td>
			  	<input name="year_month" type="text" class="InputGrey" id="year_month"  readonly>
				</td>
        <td class="blue">������</td>
        <td>
			  	<input name="year_fee" type="text" class="InputGrey" id="year_fee"  readonly>
					<input type="hidden" name="pay_type">
					<input type="hidden" name="flag_code_1">
					<input type="hidden" name="xiaoquCode" value="">
				</td>
      </tr>
      <%if("kf".equals(sm_code)){%>	
			<tr>
				<td class="blue">�Ƿ�ʹ�û���</td>
				<td colspan="3">
					<input type="checkbox" name="ifUseIntegral" id="ifUseIntegral" value="" onclick="ifUseIntegralBtn();"/>
				</td>	
			</tr>
			<%}%>
			<tbody id="IntegralFiled" style="display:none">
			<tr>
				<td  class="blue">�ֻ�����</td>
				<td ><input type="text" name="intePhoneNo" id="intePhoneNo" value=""/><font class="orange">*</font></td>	
				<td  class="blue">��������</td>
				<td >
					<input type="password" name="intePassWord" id="intePassWord" value=""/><font class="orange">*</font>
					<input type="button" class="b_text" name="inteValide" id="inteValide" value="У��" onclick="getIntegral();"/>
				</td>
			</tr>
			<tr>
				<td  class="blue">�ͻ�����</td>
				<td ><input type="text" name="inteCustName" id="inteCustName" value="" class="InputGrey" readonly/></td>	
				<td class="blue">��ǰ���û���</td>
				<td><input type="text" name="inteNumber" id="inteNumber" value="0" class="InputGrey" readonly/></td>	
			</tr>
			<tr>
				<td class="blue">����ֵ</td>
				<td><input type="text" name="inteUseNum" id="inteUseNum" v_type="0_9" onblur="checkIngegralNum();" value="0"/><font class="orange">*</font></td>
				<td class="blue">�ֿ۽��</td>
				<td><input type="text" name="intePrice" id="intePrice" value="0" class="InputGrey" readonly/></td>
				<!--������ �洢���ֿ۽�� -->
				<input type="hidden" name="maxIntegralNum" id="maxIntegralNum" value="" />
			</tr>
			</tbody>
	  </table>
	 </div>
 	 
	 
	 <div>
	 	<div id="popupcontent"></div>
	 	
	 <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" id="configBtn" name="configBtn"  type="button" value="ȷ��&��ӡ"   onclick="doCommit();">&nbsp;&nbsp;
				<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="����"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
			
			<!--<input class="b_foot" name="close"  onClick="showPopup('800','600')" type=button value=���Ե�����>-->
			</td>
		</tr>
		
		</table>
		
	
	</div>
	<input type="hidden" name="iLoginAcceptnew" id="iLoginAcceptnew" />
	<input type="hidden" name="oCustName" id="oCustName" value=""/>
	<input type="hidden" name="oIccidNo" id="oIccidNo" value=""/>
	<input type="hidden" name="oCustId" id="oCustId" value=""/>
	 

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</script>
</body>


</html>
