<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-18
********************/
%>

<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%>
<%
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
  String loginNoPass = (String)session.getAttribute("password");
	//���й���Ȩ�޼���
%>

<%
	String[][] cardTypeData = new String[][]{};
	String[][] vipCodeData = new String[][]{};
	String[][] vipCodeDataPlane = new String[][]{};
	String[][] ownerTypeData = new String[][]{};
	String[][] runTypeData = new String[][]{};

	String totalDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String tmpCurDate = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());

	int isGetDataFlag = 1;	//0:��ȷ,��������. add by yl.
	String errorMsg ="";
	String tmpStr="";


	StringBuffer  insql = new StringBuffer();
	StringBuffer  insqlPlane = new StringBuffer();

	//1.SQL ֤������
	insql.delete(0,insql.length());
	insql.append("select trim(ID_TYPENEW),trim(ID_TYPENEW)||'-->'||TYPE_NAME from oneboss.sOBIdTypeConvert  ");
	insql.append(" order by ID_TYPENEW ");

	//arr = impl.sPubSelect("2",insql.toString());
	String sql1= insql.toString();
%>

    <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql1%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="result_t1" scope="end"/>

<%
	if( result_t1 == null ){
		isGetDataFlag = 2;
	}
	cardTypeData = result_t1;

	//2.SQL
	insql.delete(0,insql.length());
	insql.append("select SRVLEVEL,SRVCODE,ITEMCODE,trim(ITEMNAME) from sRailwayvipSrvCode  ");
	insql.append(" order by SRVLEVEL,SRVCODE,ITEMCODE ");
	String sql2= insql.toString();

%>

	 <wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql2%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

  <%

	if( result_t2 == null ){
		isGetDataFlag = 2;
	}

	vipCodeData = result_t2;

	insqlPlane.delete(0,insqlPlane.length());
	insqlPlane.append("select SRVLEVEL,SRVCODE,ITEMCODE,trim(ITEMNAME) from oneboss.sVipSrvCode ");
	insqlPlane.append(" order by SRVLEVEL,SRVCODE,ITEMCODE ");
	String sqlPlane=insqlPlane.toString();

%>

	 <wtc:pubselect name="sPubSelect" outnum="4" retmsg="msgPlane" retcode="codePlane" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlPlane%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_sqlPlane" scope="end"/>
<%

      if (result_sqlPlane==null){
      	 isGetDataFlag = 2;

      	}
	vipCodeDataPlane = result_sqlPlane;
	//3.SQL �ͻ�����
	insql.delete(0,insql.length());
	insql.append("select trim(OWNER_CODENEW),trim(OWNER_CODENEW)||'-->'||TYPE_NAME from oneboss.sOBOwnerCodeConvert  ");
	insql.append(" order by OWNER_CODENEW ");
	String sql3= insql.toString();
	//arr = impl.sPubSelect("2",insql.toString());
%>

	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql3%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>

<%
	if( result_t3 == null ){
		isGetDataFlag = 4;
	}
	ownerTypeData = result_t3;

	//4.SQL �û�״̬����
	insql.delete(0,insql.length());
	insql.append("select trim(RUN_CODENEW),trim(RUN_CODENEW)||'-->'||TYPE_NAME from oneboss.sOBRunCodeConvert  ");
	insql.append(" order by RUN_CODENEW ");
	//arr = impl.sPubSelect("2",insql.toString());
	String sql4= insql.toString();
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg4" retcode="code4" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql4%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t4" scope="end"/>

<%
	if( result_t4 == null ){
		isGetDataFlag = 4;
	}
	runTypeData = result_t4;

	isGetDataFlag = 0;

	 errorMsg = "ȡ���ݴ���:"+Integer.toString(isGetDataFlag);

%>

<%if( isGetDataFlag != 0 ){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<%=errorMsg%>",0);
	window.close();
	window.opener.focus();
//-->
window.onbeforeunload = function()
{

  clearMem();
}
</script>
<%}%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>"ȫ��ͨVIP���ֲ�" </title>
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
	var dynTbIndex=1;				//���ڶ�̬�����ݵ�����λ��,��ʼֵΪ1.���Ǳ�ͷ

	var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

	var INDEX_VipSrvLevel	= 0;	//���ݵ���SQL����е�λ�ö���ģ�������ͬ�� add by yl.
	var INDEX_VipSrvCode 	= 1;
	var INDEX_VipItemCode 	= 2;
	var INDEX_VipItemName 	= 3;


 	var vipDetailArr = new Array();
 	var vipDetailArrPlane = new Array();
    <% for(int i=0; i<vipCodeData.length; i++){
    %>
    vipDetailArr[<%=i%>] = new Array();
    <%
    	for(int j=0; j<vipCodeData[i].length; j++){
    %>
    		vipDetailArr[<%=i%>][<%=j%>] = "<%=vipCodeData[i][j]%>";
    <%	}
    }
    %>


   <% for(int i=0; i<vipCodeDataPlane.length; i++){
    %>
   		 vipDetailArrPlane[<%=i%>] = new Array();
    <%
    	for(int j=0; j<vipCodeDataPlane[i].length; j++){
    %>
    		vipDetailArrPlane[<%=i%>][<%=j%>] = "<%=vipCodeDataPlane[i][j]%>";
    <%	}
    }
    %>


	onload=function()
	{
		init();
	}

	function fillSelectUseValue_noArr(fillObject,indValue)
	{
			for(var i=0;i<document.all(fillObject).options.length;i++){
				if(document.all(fillObject).options[i].value == indValue){
					document.all(fillObject).options[i].selected = true;
					break;
				}
			}
	}
	function init()
	{
		//��չʾʡ��  /npage/sb878/fb878_inner.jsp
		document.qryOprInfoFrame.location 
			= "/npage/sb878/fb878_inner.jsp"
			+"?opCode="
			+"&phoneNo="
			+"&custPWD="
			+"&cardType="
			+"&cardID="
			+"&IDType=";

		//begin huangrong update
		document.frm.cardType.value="01"
		document.all.tab2_tr4.style.display="block";
		document.all.custInfo1.style.display="block";

		//end huangrong update
		test.style.display="none";

		document.frm.inTime.value = "<%=tmpCurDate%>";
		document.frm.outTime.value = document.frm.inTime.value;

		document.frm.noCheck.disabled=false;
	//	document.frm.next.disabled = true; ����
		document.frm.computeTotal.disabled = true;

		document.frm.servLevel.disabled=false;
		document.frm.servLeve2.disabled=false;
		document.frm.attendant.disabled=false;
		//chg_servLevel(); huangrong update ע��
		//chg_servLevel_plane(); huangrong update ע��

		document.frm.servLevelVal.value="";
		document.frm.attendantVal.value="";
		document.frm.phoneNo1.focus();
		var  typeValue=document.all.opType.value;
		if(typeValue=="02")
		{
			document.all.tab2_tr4.style.display="none";
			document.all.tab2_tr3.style.display="block";
			document.all.custInfo1.style.display="none";
			document.all.custInfo2.style.display="block";
			document.all.bt.disabled=true;
	    }else
		{
			document.all.tab2_tr4.style.display="block";
			document.all.tab2_tr3.style.display="none";

			document.all.custInfo1.style.display="block";
			document.all.custInfo2.style.display="none";
			if(document.frm.IDType1.value=="03")
			{
			  document.all.bt.disabled=false;
			  document.all.cardType.value="00";
			}else
			{
		  	  document.all.bt.disabled=true;
		  	  document.all.cardType.value="01";
			}

		}
	}

	//ȥ��ո�;
	function ltrim(s){
	return s.replace( /^\s*/, "");
	}
	//ȥ�ҿո�;
	function rtrim(s){
	return s.replace( /\s*$/, "");
	}
	//ȥ���ҿո�;
	function trim(s){
	return rtrim(ltrim(s));
	}



	function chg_servLevel()
	{
	  dyn_deleteAll();
	  with(document.frm)
	  {
	  var serv_level= servLevel[servLevel.selectedIndex].value;

			for( var i=0; i<vipDetailArr.length; i++ )
			{
				if( serv_level == vipDetailArr[i][INDEX_VipSrvLevel] )
				{

					queryAddAllRow(vipDetailArr[i][INDEX_VipSrvCode],vipDetailArr[i][INDEX_VipItemCode],vipDetailArr[i][INDEX_VipItemName],"","0.00","0");
				}

			}

	  }
	}

	function chg_servLevel_Plane()
	{


	  dyn_deleteAll();
	  with(document.frm)
	  {
	  var serv_leve_plane= servLeve2[servLeve2.selectedIndex].value;

			for( var i=0; i<vipDetailArrPlane.length; i++ )
			{

				if( serv_leve_plane == vipDetailArrPlane[i][INDEX_VipSrvLevel] )

				{

					queryAddAllRow(vipDetailArrPlane[i][INDEX_VipSrvCode],vipDetailArrPlane[i][INDEX_VipItemCode],vipDetailArrPlane[i][INDEX_VipItemName],"","0.00","0");
				}

			}

	  }

	}

	function queryAddAllRow(svcCodes,svcTwoCodes,svcTwoNames,svcValue,subPrice,subScore)
	{

	var tr1="";
	var i=0;
	var tmp_flag=false;
	var exec_status="";


      tr1=dyntb.insertRow();	//ע��:����ı������������һ��,������ɿ���.yl.
	  tr1.id="tr"+dynTbIndex;

      tr1.insertCell().innerHTML = '<div align="center"><input id=R0    type=checkBox size=4  value=""  ></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R1    type=text size=8  value="'+ svcCodes+'"  readonly Class=InputGrey></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R2    type=text size=8  value="'+ svcTwoCodes+'"  readonly Class=InputGrey></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R3    type=text   value="'+ svcTwoNames+'"  readonly Class=InputGrey></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R4    type=text   value="'+ svcTwoNames+'"  maxlength="200" readonly Class=InputGrey></input><font class="orange">*</font></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R5    type=text align="right" size=9  style="text-align:right" value="'+ subPrice+'"  v_type=cfloat v_maxlength="12.2"  v_name="���" maxlength="9"  readonly Class=InputGrey></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R6    type=text  align="right" size=12 style="text-align:right"  value="'+ subScore+'"  v_type=0_9 v_minlength="1" v_name="�ۺ�Ӧ�ۻ���" maxlength="9" readonly Class=InputGrey></input></div>';

	  dynTbIndex++;

	}

	function dyn_deleteAll()
	{
		//������ӱ��е�����
		for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
		{
	            document.all.dyntb.deleteRow(a+1);
		}

	}

	function call_computeTotal()
	{
	var sum_amount=0;
	var sum_score=0.00;
	var sum_times=0;

	var serValue="";
	var servTypePlane="";

	for(var a=1; a<document.all.R0.length ;a++)//ɾ����tr1��ʼ��Ϊ������
	{
		if(document.all.R0[a].checked){
			if(document.all.R4[a].value.length<=0){
				rdShowMessageDialog("������������ݣ�",0);
				document.all.R4[a].focus();
				return false;
			}
		}

	}
	for(var a=1; a<document.all.R1.length ;a++)//ɾ����tr1��ʼ��Ϊ������
	{

		if(document.all.R0[a].checked){
			if( !forNonNegInt(document.all.R6[a]) ) return false;
			if( (document.all.R6[a].value).trim() == "" ){
				rdShowMessageDialog("�������ۺ�Ӧ�ۻ���!!",0);
				return false;
				}
			if( !forNotNegReal(document.all.R5[a]) ) return false;

			sum_amount += 1*document.all.R5[a].value;
			sum_score += 1*document.all.R6[a].value;
		}
	}
		/*���ݷ��񼶱�������*/

		if(document.all.opType.value=="01"){

		       document.frm.opType1.value="��վ����"
		       document.frm.servLevelVal.value=="5";
		       sum_amount=1;
		       sum_score=200;
		}
		else if(document.all.opType.value=="02"){
		       document.frm.opType1.value="��������"
		     serValue=document.frm.servLeve2.value;

		    document.frm.servLevelVal.value = serValue;


		    if(document.frm.servLevelVal.value=="1"){
			sum_amount=1;
			sum_score=600;

		    }else if(document.frm.servLevelVal.value=="2"){
			sum_amount=50;
			sum_score=1000;
		    }
		    else if(document.frm.servLevelVal.value=="3"){
			sum_amount=75;
			sum_score=600;
		    }
		    else if(document.frm.servLevelVal.value=="4"){
			sum_amount=125;
			sum_score=1000;
		    }
		}


		/*����ʹ����Ѵ��������*/
		if(document.frm.freeTimes.value>=document.frm.attendant.value+1){

			sum_times=parseInt(document.frm.attendant.value)+1;//ȫ��ʹ����Ѵ���

		}
		else{
			sum_times=document.frm.freeTimes.value;//����ʹ����Ѵ���
		}

		if(document.frm.attendantVal.value>0){
			sum_amount=sum_amount*(parseInt(document.frm.attendant.value)+1);
			sum_score=sum_score*(parseInt(document.frm.attendant.value)+1-sum_times);
		}
		else{
			sum_score=sum_score*(parseInt(document.frm.attendant.value)+1-sum_times);
		}

		document.frm.sumAmount.value = sum_amount;
		document.frm.sumScore.value  = sum_score;
		document.frm.sumTimes.value  = sum_times;
		//
		var  typeValue=document.all.opType.value;
		if(typeValue=="02")
		{
			document.frm.confirm.disabled = false;
	  }else
  	{
  		document.frm.next.disabled = false;
  	}
	}

	//---------1------RPC������------------------
	function doProcess(packet){


		//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
		error_code = packet.data.findValueByName("retCode");
		error_msg =  packet.data.findValueByName("retMsg");
		verifyType = packet.data.findValueByName("verifyType");
		var cust_name = packet.data.findValueByName("cust_name");
		var sV_Run_b = packet.data.findValueByName("sV_Run_b");
		var sV_Sm_c = packet.data.findValueByName("sV_Sm_c");
		var Current_d = packet.data.findValueByName("Current_d");
		var remainTimes = packet.data.findValueByName("remainTimes");
		self.status="";

		if(sV_Sm_c=="00"){

			rdShowMessageDialog("�û�����VIP�û������ṩ����",0);
			return false;


			}

		if(verifyType=="phoneno"){
			document.frm.custName.value = cust_name;
			document.frm.custScore.value=Current_d;
			document.frm.custType.value=sV_Sm_c;

			document.frm.freeTimes.value=remainTimes;
			document.all.custStauts.style.display="none";

			document.all.custStauts1.style.display="block";

			document.frm.Stauts2.value = sV_Run_b;
			document.frm.attendantVal.value=document.frm.attendant.value;
			document.frm.computeTotal.disabled = false;
		}

	}

	function call_noCheck()
	{

		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
		checkPwd_Packet.data.add("custType","01");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
		checkPwd_Packet.data.add("phoneNo",document.frm.phoneNo.value);	//�ƶ�����,�ͻ�id,�ʻ�id
		checkPwd_Packet.data.add("custPaswd",document.frm.custPWD.value);//�û�/�ͻ�/�ʻ�����
		checkPwd_Packet.data.add("idType"," ");				//en ����Ϊ���ģ�������� ����Ϊ����
		checkPwd_Packet.data.add("idNum","");					//����
		checkPwd_Packet.data.add("loginNo","<%=loginNo%>");		//����
		core.ajax.sendPacket(checkPwd_Packet,doCheckPwd,true);
		checkPwd_Packet=null;
		
		var sqlBuf="";
		var myPacket = new AJAXPacket("f4400_rpc_query.jsp","������֤�ͻ���ʶ�����Ժ�......");
					//������ݵĺϷ���
		if(!checkElement(document.frm.phoneNo)) return false;
			
		if(document.frm.attendant.value>1)
		{
			rdShowMessageDialog("��Ա�������ܳ���1�ˣ�",0);
			return false;
		}


		if( (document.frm.custPWD.value == "" )
			&& (document.frm.cardID.value == "" ))
		{
			rdShowMessageDialog("��������'�ͻ�����'����'֤������'�е�һ����",0);
			return false;
		}
		
		if( document.frm.custPWD.value != "" )
		{
			if(!checkElement(document.frm.custPWD)) return false;
		}
		if( document.frm.cardID.value != "" )
		{
			if(document.frm.cardType.value=="00")
			{
				if(!checkElement(document.frm.cardID)) return false;
			}
		}
	 	
		myPacket.data.add("beginTime","");
		myPacket.data.add("phone_no",document.frm.phoneNo.value);
		myPacket.data.add("verifyType","phoneno");
		myPacket.data.add("loginNo",document.frm.loginNo.value);
		myPacket.data.add("orgCode",document.frm.orgCode.value);
		myPacket.data.add("opCode","4400");
		myPacket.data.add("totalDate",document.frm.totalDate.value);
		myPacket.data.add("IDType",document.frm.IDType.value);
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
		myPacket.data.add("custPWD",document.frm.custPWD.value);
		myPacket.data.add("cardType",document.frm.cardType.value);
		myPacket.data.add("cardID",document.frm.cardID.value);
		myPacket.data.add("servLevel",document.frm.servLevel.value);
		myPacket.data.add("servLeve2",document.frm.servLeve2.value);
		myPacket.data.add("attendant",document.frm.attendant.value);
		myPacket.data.add("qryType","0");
		myPacket.data.add("endTime","");

		core.ajax.sendPacket(myPacket);
		myPacket = null;
	}

	function isNullMy(obj)
	{
		if( document.all(obj).value == "" )
		{
			document.all(obj).focus();
			return true;
		}
		else{
			return false;
			}
	}

	function doValid()
	{
		with(document.frm)
		{

		}

		return true;
	}

	function judge_valid()
	{
	var flag=0;

		//1.��鵥������
	 	if( !doValid() ) return false;
	 	if(!checkElement(document.frm.phoneNo)) return false;
	 	if( (document.frm.custPWD.value == "" )
	 		&& (document.frm.cardID.value == "" )
	 	  ){
	 	  	rdShowMessageDialog("��������'�ͻ�����'����'֤������'�е�һ����",0);
	 	  	return false;
	 	  }
	 	if( document.frm.custPWD.value != "" ){
	 		if(!checkElement(document.frm.custPWD)) return false;
	 	}
	 	//����֤�������жϣ����Ϊ���֤00������У�飡��2006-10-12.
	 	if( document.frm.cardID.value != "" ){
	 		if(document.frm.cardType.value=="00"){
			document.frm.cardID.v_type="idcard";
			}
			else{
			document.frm.cardID.v_type="";
			}
	 		if(document.frm.cardType.value=="00"){
	 		if(!checkElement(document.frm.cardID)) return false;
	 		}
	 	}
		if(!forDate(document.frm.inTime)) return false;
	 	if(!forDate(document.frm.outTime)) return false;
	    if( document.frm.inTime.value > document.frm.outTime.value ){
	 	  	rdShowMessageDialog("����ʱ�����С���뿪ʱ�䣡",0);
	 	  	return false;
	    }
		return true;
	}

	function reset_globalVar()
	{
	  dynTbIndex=1;
	}

	function resetJsp()
	{
			hiddenTip(document.frm.phoneNo1);
	 with(document.frm)
	 {

		phoneNo.value	= "";
		phoneNo1.value	= "";
		custPWD.value	= "";
		cardID.value	= "";
		airportName.value="";
		airNo.value="";
		sumAmount.value	= "";
		sumScore.value	= "";
		attendant.value="";
		Stauts2.value="";

		custName.value="";
		vipNo.value="";
		custScore.value="";
		freeTimes.value="";
		svcPhNum.value="";
		Answer.value="";
		rejectDesc.value="";
		AnswerDesc.value="";
	 }

		dyn_deleteAll();
		reset_globalVar();

		init();

	}

	function commitJsp()
	{
	    getAfterPrompt();
	    var ind1Str ="";
	    var ind2Str ="";
	    var ind3Str ="";
	    var ind4Str ="";
	    var ind5Str ="";
	    var ind6Str="";

	    var tmpStr="";
	    var isValid=1;
	    var recNum=0;

		if( !judge_valid() )
		{
			return false;
		}


		if(dyntb.rows.length == 2){//������û������
			rdShowMessageDialog("������û������,����������!!",0);
			return false;
		}else{

			for(var a=1; a<document.all.R0.length ;a++)//ɾ����tr1��ʼ��Ϊ������
			{
			  if( document.all.R0[a].checked ==  true )
			  {
				if( !forNonNegInt(document.all.R6[a]) ) return false;
				if( !forNotNegReal(document.all.R5[a]) ) return false;

				ind1Str =ind1Str +document.all.R1[a].value+"|";
				ind2Str =ind2Str +document.all.R2[a].value+"|";
				ind3Str =ind3Str +document.all.R3[a].value+"|";
				ind4Str =ind4Str +document.all.R4[a].value+"|";
				ind5Str =ind5Str +document.all.R5[a].value+"|";
				ind6Str =ind5Str +document.all.R6[a].value+"|";
				recNum++;
			  }
			}

		}

		if( recNum == 0){
			rdShowMessageDialog("����ѡ��һ������!!",0);
			return false;
		}

		document.frm.tmpR1.value = ind1Str;
		document.frm.tmpR2.value = ind2Str;
		document.frm.tmpR3.value = ind3Str;
		document.frm.tmpR4.value = ind4Str;
		document.frm.tmpR5.value = ind5Str;
		document.frm.tmpR6.value = ind6Str;

 		tmpStr = "VIP���ַ���  " + ",�ֻ�����:"+document.all.phoneNo.value+"";


 		document.frm.opCode.value="4400";

		document.frm.opNote.value =  tmpStr;

		document.frm.confirm.disabled = true;

		page = "f4400Cfm.jsp";
		frm.action=page;
		frm.method="post";
	  	frm.submit();
	}

function nextJsp()
{
		if(!checkElement(document.frm.phoneNo1)) return false;
	if(document.frm.phoneNo1.value == "")
	{
		rdShowMessageDialog("�ֻ����벻��Ϊ�գ������룡",0);
		return false;
	}
	if( (document.frm.custPWD.value == "" )
		&& (document.frm.cardID.value == "" ))
	{
		rdShowMessageDialog("��������'�ͻ�����'����'֤������'�е�һ����",0);
		return false;
	}

	getBelong();
}


function getBelong() {
	var packet = new AJAXPacket("f4400_rpc_getbelong.jsp","������֤�ͻ���ʶ�����Ժ�......");
	packet.data.add("phoneNo",document.frm.phoneNo1.value);
	core.ajax.sendPacket(packet,dobelong,true);
	packet = null;
}

function dobelong(packet){
	var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    if (retCode != "000000") {
    	rdShowMessageDialog("������Ϣ��"+retMsg+"��������룺"+retCode+"��",2);
	}else{
		var result_long = packet.data.findValueByName("result_long");
		if(result_long!="0") {
			var attr_code = packet.data.findValueByName("attr_code");

			if(attr_code=="01" || attr_code=="02" || attr_code=="03" || attr_code=="05" 
				||attr_code=="06" ||attr_code=="07") {
				if(document.frm.custPWD.value != "") {
					var run_code = packet.data.findValueByName("run_code");
    				if(run_code!="A") {
    					rdShowMessageDialog("�ͻ�״̬������,���ܰ����ҵ��");
							return ;
    				}
    				validatePwd();
    				page="/npage/sb878/fb878_inner.jsp?opCode=4400&flag=n&phoneNo="+document.frm.phoneNo1.value+"&IDType="+document.frm.IDType1.value+"&custPWD="+document.frm.custPWD.value+"&cardType="+document.frm.cardType.value+"&cardID="+document.frm.cardID.value;
				}
				//liujian TODO�޸��������ͱ�������ȷ��
				//TODO Ŀǰȱ�ٶ����֤����֤ 
				//TODO ��֤���֤ҲӦ���ж�dcustmsg���е�run_code�ɣ�		
			}else {
	    		rdShowMessageDialog("��VIP�ͻ�,���ܰ����ҵ��");
	    		return;
		    }
		    
		    var run_code = packet.data.findValueByName("run_code");
    		if(run_code!="A") {
    			rdShowMessageDialog("�ͻ�״̬������,���ܰ����ҵ��");
				return ;
    		}
    		page="/npage/sb878/fb878_inner.jsp?opCode=4400&flag=n&phoneNo="+document.frm.phoneNo1.value+"&IDType="+document.frm.IDType1.value+"&custPWD="+document.frm.custPWD.value+"&cardType="+document.frm.cardType.value+"&cardID="+document.frm.cardID.value;
		}else {
			page="/npage/sb878/fb878.jsp?opCode=4400&flag=w&phoneNo="+document.frm.phoneNo1.value+"&IDType="+document.frm.IDType1.value+"&custPWD="+document.frm.custPWD.value+"&cardType="+document.frm.cardType.value+"&cardID="+document.frm.cardID.value;
		}
	}
	frm.action=page;
	frm.method="post";
	frm.submit();
}
//huangrong add ��֤�û����� 2011-4-1
function validatePwd() {
	var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
			checkPwd_Packet.data.add("custType","01");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("phoneNo",document.frm.phoneNo1.value);	//�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd",document.frm.custPWD.value);//�û�/�ͻ�/�ʻ�����
			checkPwd_Packet.data.add("idType"," ");				//en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum","");					//����
			checkPwd_Packet.data.add("loginNo","<%=loginNo%>");		//����
			core.ajax.sendPacket(checkPwd_Packet,doCheckPwd,true);
			checkPwd_Packet=null;
}

function doCheckPwd(packet) {
	var retResult = packet.data.findValueByName("retResult");
	var msg = packet.data.findValueByName("msg");
	if (retResult != "000000") {
		rdShowMessageDialog(msg);
		window.location="f4400.jsp?opCode=4400&opName=����VIP��������";
	}
}



function autoidtify() {
	document.frm.autoconfirm.disabled=true;
	var h=105;
	var w=280;
	var t=screen.availHeight-h-20;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no"
	var data1=window.showModalDialog("read_vipinfo.jsp",prop);
	var svcnum=data1.substr(0,11);
	var cardnum=data1.substr(12,16);
	var cardlvl=data1.substr(29,1);
	var validate=data1.substr(31,4);
	if(document.all.opType.value=="01")
	{
			document.all.phoneNo1.value=svcnum;
	}else
	{
			document.all.phoneNo.value=svcnum;
	}
	document.all.cardType.value="01";
	document.all.custPWD.disabled=true;
	document.all.cardID.value=cardnum;
	if(cardlvl=="1")
	cardlvl="301";
	else if(cardlvl=="2")
	cardlvl="302";
	else if(cardlvl=="3")
	cardlvl="303";
	else
	cardlvl="100";
	fillSelectUseValue_noArr("custRank",cardlvl );
	document.frm.autoconfirm.disabled=false;
	var  typeValue=document.all.opType.value;
	if(typeValue=="01")
	{
		document.frm.next.disabled = false;
  }
}

function readInfo() {
	if(document.frm.phoneNo1.value == "")
	{
		rdShowMessageDialog("�ֻ����벻��Ϊ�գ������룡",0);
	  return false;
	}
	if(document.frm.custPWD.value == "")
	{
		rdShowMessageDialog("�û����벻��Ϊ�գ������룡",0);
	  return false;
	}
	//validatePwd(doCheckPwd2);
	validateCust();


}

function validateCust() {
	var packet = new AJAXPacket("f4400_rpc_getInfo.jsp","������֤�ͻ���ʶ�����Ժ�......");
  	packet.data.add("phoneNo",document.frm.phoneNo1.value);
  	core.ajax.sendPacket(packet,doInfo,true);
  	packet = null;
}

function doInfo(packet){
	var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    if (retCode != "000000") {
    	rdShowMessageDialog("������Ϣ��"+retMsg+"��������룺"+retCode+"��",2);
	}else{
	    var cust_type = packet.data.findValueByName("cust_type");
	    if(cust_type=="inner_vip") {
			validatePwd();
			var id_iccid = packet.data.findValueByName("id_iccid");
			var id_address = packet.data.findValueByName("id_address");
			var card_name = packet.data.findValueByName("card_name");
			var card_no = packet.data.findValueByName("card_no");
			rdShowMessageDialog("���֤�ţ�"+id_iccid+"<br>�����ַ��"+id_address+"<br>VIP����"+card_name+"<br>VIP���ţ�"+card_no);
	    }else if(cust_type=="out"){
    		rdShowMessageDialog("���û��Ǳ�ʡ�û������ܲ�ѯ��Ϣ��");
    	}else{
    		rdShowMessageDialog("���û�Ϊʡ�ڷ�VIP�û������ܲ�ѯ��Ϣ��");
    	}
    }
}

 function changeBusyType(){
 var tmpbusi_code = "";
 }

   function typeChange()
      {
  	      var  typeValue=document.all.opType.value;
  	      if(typeValue=="02"){

  	 //begin huangrong add
  	document.all.typeChange3.style.display="block";
		document.all.serverClass.style.display="block";
		document.all.userClass.style.display="block";
		document.all.userInfo1.style.display="block";
		document.all.userInfo2.style.display="block";
		document.all.userInfo3.style.display="block";
		document.all.tab1.style.display="block";
		document.all.tab2_tr0.style.display="block";
		document.all.tab2_tr1.style.display="block";
		document.all.tab2_tr2.style.display="block";
		document.all.tab2_tr4.style.display="none";
		document.all.tab2_tr3.style.display="block";

		document.frm.cardType.disabled = false;
		document.frm.cardType.value = "00";
		document.frm.confirm.disabled = true;
		document.all.custInfo1.style.display="none";
		document.all.custInfo2.style.display="block";

		document.all.bt.disabled=true;
  	 //end huangrong add

  	 	document.all.typeChange1.style.display="none";
  	 	document.all.typeChange2.style.display="block";
  	 	document.all.typeChange3.style.display="none";
  	 	document.all.planeType.style.display="block";



  	        chg_servLevel_Plane();


  	 	}
  	      else if(typeValue=="01"){

  	        window.location.reload();

  	      	}

  	}

function typeChange4(bing)
{
	var shu=bing.value;
	if(shu=="01" || shu=="02")
	{
		document.all.cardType.value="01";
		document.all.bt.disabled=true;
	}else
	{
		document.all.cardType.value="00";
		if(document.all.opType.value=="01")
		{
			document.all.bt.disabled=false;
		}else
		{
			document.all.bt.disabled=true;
		}
	}
}

//-->
</script>
</head>

<body>
<form name="frm" method="post" action="" onKeyUp="chgFocus(frm)" onMouseDown="hideEvent()" onKeyDown="hideEvent()">
	<%@ include file="/npage/include/header.jsp" %>



<OBJECT id=oReq
	  classid="clsid:345C275C-0505-4244-AAB1-85D1F54DAD5A"
	  codebase="/ocx/ER_READER.inf"
	  width=0
	  height=0
	  align=center
	  hspace=0
	  vspace=0
>
</OBJECT>
 	<div class="title">
		<div id="title_zi">ȫ��ͨVIP�򳵷���</div>
	</div>
        <table cellspacing="0" >

		  	 <tr  id="test" style="display:none">
            <td  class="blue"><div align="right">��ͨ��ʽ</div></td>
            <td colspan="3">
							<select name="test_flag" id="test_flag">
							</select>
						</td>
		 			</tr>

          <tr>
            <td width="20%"  class="blue"><div align="right">��������</div></td>
            <td width="30%" >
            <select name="opType" id="opType" onchange=typeChange() style="width:180px;">
                   <option value="01" checked>01--&gt;��վ����</option>
		              <!-- <option value="02">02--&gt;��������</option> --><!-- liujian -->
            </select>
						<td> <div align="left"></div><input name="autoconfirm" type="button"  class="b_text" value="�Զ���ȡVIP��Ϣ" onClick="autoidtify()"></td>
						<input name="opType1" type="hidden"  id="opType1" value=" " >
            </td>
            <td>&nbsp; </td>
          </tr>

<!--begin huangrong add ʡ��-->
          <tr id="custInfo1">
            <td  class="blue"><div align="right">�ͻ���ʶ����</div></td>
            <td><select name="IDType1" id="IDType1" onchange=typeChange4(this) style="width:180px;">
                <option value="01">01--&gt;���ӿ���֤</option>
                <option value="02">02--&gt;�ֻ�����+vipʵ�忨����֤</option>
                <option value="03"  selected >03--&gt;�ֻ�����+���֤������֤</option>
              </select></td>
            <td  class="blue"><div align="right">�ֻ�����</div></td>
            <td><input name="phoneNo1" type="text"  id="phoneNo1" index="1" v_must=1 v_type="mobphone" v_minlength=11  v_name="�ֻ�����" onblur = "checkElement(this)" >
              <font class="orange">*</font></td>
          </tr>
<!--end huangrong add-->

          <tr id="custInfo2" style="display:none">
            <td  class="blue"><div align="right">�ͻ���ʶ����</div></td>
            <td><select name="IDType" id="IDType">
                <option value="01">01--&gt;�ֻ�����</option>
              </select></td>
            <td  class="blue"><div align="right">�ͻ���ʶ</div></td>
            <td><input name="phoneNo" type="text"  id="phoneNo" index="1" v_must=1 v_type="mobphone" v_minlength=11  v_name="�ֻ�����">
              <font class="orange">*</font></td>
          </tr>

          <tr>
            <td  class="blue"><div align="right">�ͻ�����</div></td>
            <td><input name="custPWD" type="password"  index="2" id="custPWD" maxlength="6" v_type=0_9 v_name="�ͻ�����" onblur = "checkElement(this)" >
            <font class="orange">*(�ͻ������֤�������ѡһ)</font></td>
<!--begin huangrong add 2011-3-31-->
            <td  class="blue"><div align="left"></div><input name="bt" type="button"  class="b_text"  id="bt" value="��ȡ�û���Ϣ" onClick="readInfo()" disabled></td>
            <td>&nbsp; </td>
          </tr>
<!--end huangrong add 2011-3-31-->
          <tr>
            <td class="blue"><div align="right">֤������</div></td>
            <td ><select name="cardType" id="cardType" style="width:180px;" disabled>
                <option value="00">00--&gt;���֤</option>
                <option value="01">01--&gt;VIP��</option>
              </select></td>
            <td   class="blue"><div align="right">֤������</div></td>
            <td><input name="cardID" type="text"  id="cardID" index="3" maxlength="20" v_must=1 v_type=idcard v_minlength=1  v_name="֤������">
              <font class="orange">*</font>
            </td>
          </tr>
          <tr id="serverClass" style="display:none">
            <td><div align="right"  class="blue">���񼶱�</div></td>
            <td id="typeChange1" style=""><select name="servLevel" id="servLevel" onChange="chg_servLevel()">
                <option value="1">1--&gt;��վһ���������</option>
                </select></td>
            <td id="typeChange2" style="display:none"><select name="servLeve2" id="servLeve2" onChange="chg_servLevel_Plane()">
                <option value="1">1--&gt;���ں���һ������</option>
                <option value="2">2--&gt;���ں����������</option>
                <option value="3">3--&gt;���ʺ���һ������</option>
                <option value="4">4--&gt;���ʺ����������</option>
                </select></td>
            <td    class="blue"><div align="right">��Ա����</div></td>
            <td><input name="attendant" type="text"  id="attendant" index="3" maxlength="2" v_must=1 v_type=0_9 v_minlength=1  v_name="��Ա����" value="0"> <font class="orange">(������,�������)</font>
            	<input name="noCheck" type="button"  class="b_text"   id="noCheck" index="4" value="��֤" onClick="call_noCheck()"> </td>
          </tr>

           <tr id="userClass" style="display:none">
            <td  class="blue"><div align="right">�û�����</div></td>
            <td colspan="3"><input name="custType" type="text"  id="custType" readonly Class="InputGrey">
            </td>
          </tr>


          <tr id="userInfo1" style="display:none">
            <td   class="blue"><div align="right">�ͻ�����</div></td>
            <td><input name="custName" type="text"  id="custName"  readonly Class="InputGrey"></td>

            <td   class="blue"><div align="right">�û�״̬</div></td>
            <td colspan="3" id="custStauts" style=""><select name="custStat" id="custStat">
                <%
        	for(int i=0;i<runTypeData.length; i++){

				out.println("<option  value='"+runTypeData[i][0]+"'>"+runTypeData[i][1]+"</option>");
			}
		  %>
              </select></td>
           <td colspan="3"id="custStauts1" style="display:none"><input name="Stauts2" type="text"  id="Stauts2"  readonly Class="InputGrey"></td>
          </tr>


          <tr id="userInfo2" style="display:none">
            <td   class="blue"><div align="right">�ͻ�����</div></td>
            <td><input name="custScore" type="text"  id="custScore"  readonly Class="InputGrey"></td>
            <td   class="blue"><div align="right">ʣ����Ѵ���</div></td>
            <td><input name="freeTimes" type="text"  id="freeTimes"  readonly Class="InputGrey"></td>
          </tr>
	       	<input name="custName1" type="hidden"  id="custName1" >

          <tr id="userInfo3" style="display:none">
            <td  class="blue"><div align="right">����ʱ��</div></td>
            <td><input name="inTime" type="text"  id="inTime" index="5" maxlength="14" v_must=1  v_minlength=14  v_format="yyyyMMddHHmmss">
              <font class="orange">*</font>(��ʽ:YYYYMMDDHHMMSS)</td>
            <td  class="blue"><div align="right">�뿪ʱ��</div></td>
            <td><input name="outTime" type="text"  id="outTime" index="6" maxlength="14" v_must=1   v_minlength=14  v_format="yyyyMMddHHmmss">
              <font class="orange">*</font>(��ʽ:YYYYMMDDHHMMSS)</td>
          </tr>

          <tr id="typeChange3" style="display:none">
				     <td   class="blue"><div align="right">ҵ���������</div></td>
             <td colspan="3"> <select name="busytype"     onChange="changeBusyType()">
                                  <option  value="00">vip��վ����</option>
				                    	</select>
          </tr>

          <tr id="planeType" style="display:none">
            <td   class="blue"><div align="right">��������</div></td>
            <td><input name="airportName" type="text"  id="airportName"></td>
            <td   class="blue"><div align="right">�����</div></td>
            <td><input name="airNo" type="text"  id="airNo"></td>
          </tr>
     </table>

		 <table  cellspacing="0"   id="dyntb">
                <tr id="tab1" style="display:none">
                  <th><div align="center"> ѡ��</div></th>
                  <th><div align="center"> һ������</div></th>
                  <th><div align="center"> ��������</div></th>
                  <th><div align="center"> ������������</div></th>
                  <th><div align="center"> ��������</div></th>
                  <th><div align="center"> ���</div></th>
                  <th><div align="center"> �ۺ�Ӧ�ۻ���</div></th>
                </tr>
                <tr id="tr0" style="display:none">
                  <td><div align="center">
                      <input type="checkBox" id="R0" value="">
                    </div></td>
                  <td><div align="center">
                      <input type="text" id="R1" value="">
                    </div></td>
                  <td><div align="center">
                      <input type="text" id="R2" value="">
                    </div></td>
                  <td><div align="center">
                      <input type="text" id="R3" value="">
                    </div></td>
                  <td><div align="center">
                      <input type="text" id="R4" value="">
                    </div></td>
                  <td><div align="center">
                      <input type="text" id="R5" value="">
                    </div></td>
                  <td><div align="center">
                      <input type="text" id="R6" value="">
                    </div></td>
                </tr>
       </table>
       <table cellspacing="0">

          <tr id="tab2_tr0" style="display:none">
            <td><input name="computeTotal" type="button"  class="b_text"   value="�����ܶ�" onClick="call_computeTotal()" disabled="true"></td>
            <td >&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>

          <tr id="tab2_tr1" style="display:none">
            <td   class="blue"><div align="right">�ܿۻ���</div></td>
            <td><input  name="sumScore" type="text"  id="sumScore" readonly Class="InputGrey"></td>
            <td  class="blue"><div  align="right">ʹ����Ѵ���</div></td>
            <td><input name="sumTimes" type="text"  id="sumTimes" readonly Class="InputGrey"><input name="sumAmount" type="hidden"  id="sumAmount" readonly Class="InputGrey"></td>
          </tr>

          <tr id="tab2_tr2" style="display:none">
            <td  height="32"  class="blue"><div align="right">������ע</div></td>
            <td height="32" colspan="3"> <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" readOnly class="InputGrey">
            </td>
          </tr>

          <tr id="tab2_tr3" style="display:none">
            <td colspan="4" id="footer"> <div align="center">
                <input name="confirm" type="button" class="b_foot" value="ȷ��" onClick="commitJsp()">
                &nbsp;
                <input name="reset" type="button"  class="b_foot"  value="���" onClick="resetJsp()">
                &nbsp;
                <input name="back" onClick="removeCurrentTab()" class="b_foot"  type="button"  value="�ر�">
                &nbsp; </div></td>
          </tr>

          <!--begin huangrong add -->
          <tr id="tab2_tr4">
            <td colspan="4" id="footer"> <div align="center">
                <input name="next" type="button" class="b_foot" value="��һ��" onClick="nextJsp()">
                &nbsp;
                <input name="reset" type="button"  class="b_foot"  value="���" onClick="resetJsp()">
                &nbsp;
                <input name="back" onClick="removeCurrentTab()" class="b_foot"  type="button"  value="�ر�">
                &nbsp; </div></td>
          </tr>
          
          <!--end huangrong add -->

        </table>

	<input type="hidden" name="guid" id="guid" value="<%=loginNo%>">
	<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
	<input type="hidden" name="loginNoPass" id="loginNoPass" value="<%=loginNoPass%>">

	<input type="hidden" name="loginName" id="loginName" value="">
	<input type="hidden" name="opCode" id="opCode" value="">
	<input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">

	<input type="hidden" name="totalDate" id="totalDate" value="<%=totalDate%>">
	<input type="hidden" name="tmpBusyAccept" id="tmpBusyAccept" value="">
	<input type="hidden" name="tmpSendAccept" id="tmpSendAccept" value="">
	<input type="hidden" name="tmpBackAccept" id="tmpBackAccept" value="">

	<input type="hidden" name="tmpR1" id="tmpR1" value="">
	<input type="hidden" name="tmpR2" id="tmpR2" value="">
	<input type="hidden" name="tmpR3" id="tmpR3" value="">
	<input type="hidden" name="tmpR4" id="tmpR4" value="">
	<input type="hidden" name="tmpR5" id="tmpR5" value="">
	<input type="hidden" name="tmpR6" id="tmpR6" value="">

	<input type="hidden" name="servLevelVal" id="servLevelVal" value="">
	<input type="hidden" name="attendantVal" id="attendantVal" value="">
</form>


<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>
