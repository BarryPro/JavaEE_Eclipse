<%
    /********************
     version v2.0
     ������: si-tech
     4228������
     gaopeng 2013/3/14 ������ 9:49:09 ��Ϊ�°����
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%
			String PrintAccept = getMaxAccept();
			String opCode = (String)request.getParameter("opCode");		
			String opName = (String)request.getParameter("opName");
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
	    
	//���й���Ȩ�޼���
%>

<%
	List al = null;

	String[][] cardTypeData = new String[][]{};
	String[][] vipCodeData = new String[][]{};
	String[][] ownerTypeData = new String[][]{};
	String[][] runTypeData = new String[][]{};
	//List ownerTypeData = null;
	//List runTypeData = null;
	
	String totalDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

	String tmpCurDate = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());

	
	int		isGetDataFlag = 1;	//0:��ȷ,��������. add by yl.
	String errorMsg ="";
	String tmpStr="";

	
	StringBuffer  insql = new StringBuffer();
	
dataLabel:
	while(1==1){	
	
	//1.SQL ֤������
	insql.delete(0,insql.length());
	insql.append("select trim(ID_TYPENEW),trim(ID_TYPENEW)||'-->'||TYPE_NAME from oneboss.sOBIdTypeConvert  ");
	insql.append(" order by ID_TYPENEW ");
	String sql = insql.toString();
	
	//al = oneboss.getCommONESQL(regionCode,insql.toString(),2,0);
	%>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
			<wtc:param value="<%=sql%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
	<%
	if( result == null ){
		isGetDataFlag = 2;
		break dataLabel;
	}		
	//cardTypeData = oneboss.ListToStringArray(al);
	cardTypeData =result;
    //MyLog.debugLog("cardTypeData11111111"+cardTypeData);

	//2.SQL 
	insql.delete(0,insql.length());
	insql.append("select SRVLEVEL,SRVCODE,ITEMCODE,trim(ITEMNAME) from oneboss.sVipSrvCode  ");
	insql.append(" order by SRVLEVEL,SRVCODE,ITEMCODE ");
	String sql2 = insql.toString();
	//al = oneboss.getCommONESQL(regionCode,insql.toString(),4,0);
	%>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode2" retmsg="retMsg2">
			<wtc:param value="<%=sql2%>"/>
		</wtc:service>
		<wtc:array id="result2" scope="end"/>
	<%
	if( result2 == null ){
		isGetDataFlag = 2;
		break dataLabel;
	}		
	//vipCodeData = oneboss.ListToStringArray(al);	
	vipCodeData =result2;
	
	//3.SQL �ͻ�����
	insql.delete(0,insql.length());
	insql.append("select trim(OWNER_CODENEW),trim(OWNER_CODENEW)||'-->'||TYPE_NAME from oneboss.sOBOwnerCodeConvert  ");
	insql.append(" order by OWNER_CODENEW ");
	String sql3 = insql.toString();
	//al = SqlQuery.findList(insql.toString());
	%>
	<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode3" retmsg="retMsg3">
			<wtc:param value="<%=sql3%>"/>
		</wtc:service>
		<wtc:array id="result3" scope="end"/>
	<%
	if( result3 == null ){
		isGetDataFlag = 4;
		break dataLabel;
	}		
	//ownerTypeData = al;
	ownerTypeData=result3;
		
	//4.SQL �û�״̬����
	insql.delete(0,insql.length());
	insql.append("select trim(RUN_CODENEW),trim(RUN_CODENEW)||'-->'||TYPE_NAME from oneboss.sOBRunCodeConvert  ");
	insql.append(" order by RUN_CODENEW ");
	String sql4 = insql.toString();
	//al = SqlQuery.findList(insql.toString());
	%>
	<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode4" retmsg="retMsg4">
			<wtc:param value="<%=sql4%>"/>
		</wtc:service>
		<wtc:array id="result4" scope="end"/>
	<%
	if( result4 == null ){
		isGetDataFlag = 4;
		break dataLabel;
	}		
	runTypeData = result4;
	
	isGetDataFlag = 0;
 break;
 }	


	 errorMsg = "ȡ���ݴ���:"+Integer.toString(isGetDataFlag);	    
	 //MyLog.debugLog(errorMsg);
%>

<%if( isGetDataFlag != 0 ){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<%=errorMsg%>");
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
<title>"ȫ��ͨVIP���ֲ�"(���)�������� </title>

<script language="JavaScript">
	function jtrim(Obj){ //ɾ���������˵Ŀո�
			var str = Obj.value;
	����return str.replace(/(^\s*)|(\s*$)/g, "");
���� }
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
	var endcardcode = "";	    
 
 			var vipDetailArr = new Array();
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
  
        
    //core.loadUnit("debug");
	//core.loadUnit("rpccore"); 
	onload=function()
	{	
		
		init();
		//core.rpc.onreceive = doProcess;	
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
		test.style.display="none";

<%
	
		String power_code = (String)session.getAttribute("power_code");
		//String power_code = "system";
		String test_sql="select a.oregtype from DOBTRANSREGMSG a,sobopercode b where a.bipcode=b.oper_code and b.function_code='4228' and b.oper_code='BIP2B005'";
		String oregtype="11";

		if(oregtype!=null&&oregtype.equals("11")){
			if(power_code!=null&&power_code.trim().equals("3")){
%>
				test.style.display="none";
				document.all("test_flag").length=2;
				//document.all("test_flag").options[0].text="��ʽ";
				//document.all("test_flag").options[0].value="0";
				document.all("test_flag").options[1].text="����";
				document.all("test_flag").options[1].value="1";
<%
			}
			else{
%>
				test.style.display="none";
				document.frm.test_flag.length=1;
				document.frm.test_flag.options[0].text="��ʽ";
				document.frm.test_flag.options[0].value="0";
<%			
			
			}
		}
%>	  
		

		document.frm.inTime.value = "<%=tmpCurDate%>";
		document.frm.outTime.value = document.frm.inTime.value;
		
		document.frm.noCheck.disabled=false;
		document.frm.confirm.disabled = true;
		document.frm.computeTotal.disabled = true;
		
		document.frm.servLevel.disabled=false;
		document.frm.attendant.disabled=false;
		chg_servLevel();
		
		document.frm.servLevelVal.value="";
		document.frm.attendantVal.value="";
		document.frm.phoneNo.focus();
		
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

	function queryAddAllRow(svcCodes,svcTwoCodes,svcTwoNames,svcValue,subPrice,subScore)
	{
	var tr1="";
	var i=0;
	var tmp_flag=false;
	var exec_status="";
    tr1=dyntb.insertRow();	//ע��:����ı������������һ��,������ɿ���.yl.
	  tr1.id="tr"+dynTbIndex;

      tr1.insertCell().innerHTML = '<div align="center"><input id=R0    type=checkBox size=4  value=""  ></input></div>';	  	             
      tr1.insertCell().innerHTML = '<div align="center"><input id=R1    type=text size=8  value="'+ svcCodes+'"  readonly></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R2    type=text size=8  value="'+ svcTwoCodes+'"  readonly></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R3    type=text   value="'+ svcTwoNames+'"  readonly></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R4    type=text   value="'+ svcTwoNames+'"  maxlength="200"></input><font color="#FF0000">*</font></div>'; 
      tr1.insertCell().innerHTML = '<div align="center"><input id=R5    type=text align="right" size=9  style="text-align:right" value="'+ subPrice+'"  v_type=cfloat v_maxlength="12.2"  v_name="���" maxlength="9"></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R6    type=text  align="right" size=12 style="text-align:right"  value="'+ subScore+'"  v_type=0_9 v_minlength="1" v_name="�ۺ�Ӧ�ۻ���" maxlength="9"></input></div>';

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
//2013/3/18 ����һ 8:41:52 gaopeng �����Ż�ȫ��ͨVIP���ֲ������ۼ���Ѵ���������
	function call_computeTotal()
	{
	var sum_amount=0; //�����ۿ۽��
	var sum_score=0.00;
	var sum_times=0;

	for(var a=1; a<document.all.R0.length ;a++)//ɾ����tr1��ʼ��Ϊ������
	{
		if(document.all.R0[a].checked){
			if(document.all.R4[a].value.length<=0){
				rdShowMessageDialog("������������ݣ�");
				document.all.R4[a].focus();
				return false;
			}
		}

	}
	
			for(var a=1; a<document.all.R1.length ;a++)//ɾ����tr1��ʼ��Ϊ������
			{
			
				if(document.all.R0[a].checked){
					
					if( !forNonNegInt(document.all.R6[a]) ) return false;
					if( jtrim(document.all.R6[a]) == "" ){
						rdShowMessageDialog("�������ۺ�Ӧ�ۻ���!!");
						return false;
					}				
					if( !forNotNegReal(document.all.R5[a]) ) return false;
					
					sum_amount += 1*document.all.R5[a].value;
					sum_score += 1*document.all.R6[a].value;
				}
			}	
	//alert(document.frm.servLevelVal.value);
		/*���ݷ��񼶱�������*/	
		/*
		if(document.frm.servLevelVal.value=="1"){
			sum_amount=30;
			sum_score=2000;
		}else if(document.frm.servLevelVal.value=="2"){
			sum_amount=45;
			sum_score=3000;
		}
		else if(document.frm.servLevelVal.value=="3"){
			sum_amount=75;
			sum_score=5000;
		}
		else if(document.frm.servLevelVal.value=="4"){
			sum_amount=120;
			sum_score=8000;
		}*/
		if(document.frm.servLevelVal.value=="1"){
			sum_amount=80;
			sum_score=4000;
		}else if(document.frm.servLevelVal.value=="2"){
			sum_amount=150;
			sum_score=8000;
		}
		else if(document.frm.servLevelVal.value=="3"){
			sum_amount=150;
			sum_score=8000;
		}
		//if(endcardcode!="05" && endcardcode!="06" && endcardcode!="07")
		if(endcardcode!="05" && endcardcode!="06")
	{
		/*����ʹ����Ѵ��������*/
		if(parseInt(document.frm.freeTimes.value)>=parseInt(document.frm.attendantVal.value)+1){
			sum_times=parseInt(document.frm.attendantVal.value)+1;//ȫ��ʹ����Ѵ���
		}
		else{
			sum_times=document.frm.freeTimes.value;//����ʹ����Ѵ���
		}
		
		if(parseInt(document.frm.attendantVal.value)>0){
			sum_amount=sum_amount*(parseInt(document.frm.attendantVal.value)+1);
			sum_score=sum_score*(parseInt(document.frm.attendantVal.value)+1-sum_times);
		}
		else{
			sum_score=sum_score*(parseInt(document.frm.attendantVal.value)+1-sum_times);
		}
	}
	//if(endcardcode=="05" || endcardcode=="06" || endcardcode=="07")
	if(endcardcode=="05" || endcardcode=="06")
	{
		sum_times=0;
		sum_amount=0;
		sum_score=0;
	}
		document.frm.sumAmount.value = sum_amount;
		document.frm.sumScore.value  = sum_score;
		document.frm.sumTimes.value  = sum_times;
		
		document.frm.confirm.disabled = false;
	}
			
	//---------1------RPC������------------------
	function doProcess(packet){
		//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
		error_code = packet.data.findValueByName("errorCode");
		//alert(error_code);
		error_msg =  packet.data.findValueByName("errorMsg");
		verifyType = packet.data.findValueByName("verifyType");
		//alert(verifyType);
		//backArrMsg = packet.data.findValueByName("backArrMsg");
		backArrMsg1 = packet.data.findValueByName("backArrMsg");
		endcardcode = packet.data.findValueByName("endcardcode");
		//alert(endcardcode);
		var imsi=packet.data.findValueByName("IMSI");
		var iccid=packet.data.findValueByName("ICCID");
	
		self.status="";

		if(verifyType=="phoneno"){
			if( parseInt(error_code) == 0 || parseInt(error_code) == 2998){ 

			  //if( backArrMsg.length > 0 ){
				//document.frm.tmpBusyAccept.value = backArrMsg[0][0];
			  //}
			  
			  for(var i=0; i<backArrMsg1.length ; i++){
			  	
			  	document.frm.tmpBusyAccept.value = backArrMsg1[i][9];
			
					document.frm.custName.value = backArrMsg1[i][3];//�ͻ�����
					document.frm.custName1.value = backArrMsg1[i][3];
				
					document.frm.vipNo.value = backArrMsg1[i][10];//֤�����ͼ����루��Ӧ��
				
					document.frm.custScore.value = backArrMsg1[i][7];//�ͻ����û������
				//alert(backArrMsg1[i][5]+"�ͻ�����"+backArrMsg1[i][4]+"�û�״̬"+backArrMsg1[i][2]+"�ܷ��ṩ����");
					fillSelectUseValue_noArr("custRank",backArrMsg1[i][5] );//�ͻ�����
					
					fillSelectUseValue_noArr("custStat",backArrMsg1[i][4] );//�û�״̬
					
					document.frm.Answer.value = backArrMsg1[i][2];//?�ܷ��ṩ����
				//document.frm.Answer.value = "00";
				//alert(document.frm.Answer.value+"--aaaa--"+);
				var resultReson = "";
				//alert("�����������������ֵ��"+backArrMsg1[i][2]+"---"+"�ܾ����ɣ�"+backArrMsg1[i][1]);
				if(backArrMsg1[i][1].indexOf("�����ɹ�")!=-1)
				{
					resultReson="��Ȩ�ɹ�!";
				}
				else
					{
						resultReson=backArrMsg1[i][1];
					}
					document.frm.rejectDesc.value = resultReson;//�������ܾ����������
			
					document.frm.svcPhNum.value = backArrMsg1[i][6];//��ͻ�����绰
				//2013/3/26 ���ڶ� 17:19:57 gaopeng �жϿͻ��ǲ������޴�������������޴�������ʾΪ99��
				//if(endcardcode=="05" || endcardcode=="06" || endcardcode=="07")
				if(endcardcode=="05" || endcardcode=="06")
				{
					document.frm.freeTimes.value="99";
				}
				else{
					document.frm.freeTimes.value = backArrMsg1[i][8];//��ʡ�û�����ʣ����Ѵ�������
				}
				document.frm.servLevelVal.value=document.frm.servLevel.value;
				document.frm.attendantVal.value=document.frm.attendant.value;
				document.frm.servLevel.disabled=true;
				document.frm.attendant.disabled=true;  
				document.frm.noCheck.disabled=true;
							  	
			  }
		   	  if(document.frm.Answer.value!="00"){
		   	  	document.frm.AnswerDesc.value="�����������ҵ��";
				rdShowMessageDialog("���񱻾ܾ���ԭ��"+document.frm.rejectDesc.value);
				return false;	
			  }
			  document.frm.AnswerDesc.value="���������ҵ��";
			  document.frm.computeTotal.disabled = false;
			  
			}else{
				rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:["+error_msg+"]");
				return false;
			}
		
		}
						
	}

	function call_noCheck()
	{
		//trim phoneno and cardno
		document.frm.phoneNo.value=trim(document.frm.phoneNo.value) ;
		document.frm.cardID.value=trim(document.frm.cardID.value) ;
		
		//������ݵĺϷ���
	 	if(!checkElement(document.getElementById("phoneNo"))) return false;
	 	
	 	if( (document.frm.custPWD.value == "" )
	 		&& (document.frm.cardID.value == "" )
	 	  ){
	 	  	rdShowMessageDialog("��������'�ͻ�����'����'֤������'�е�һ����");
	 	  	return false;	 	  
	 	  }
	 	
	 	if( document.frm.custPWD.value != "" ){
	 		if(!checkElement(document.getElementById("custPWD"))) return false;
	 	}  
	 	if( document.frm.attendant.value != "" ){
	 		if(!checkElement(document.getElementById("attendant"))) return false;
	 	}  
	 	
	 	if( document.frm.cardID.value != "" ){
	 		if(document.frm.cardType.value=="00"){
	 		if(!checkElement(document.getElementById("cardID"))) return false;
	 		}
	 	} 
		if( document.frm.attendant.value.trim().length==0 ){
			rdShowMessageDialog("��������Ա����!");
			return false;
		}
		var sqlBuf="";
		var myPacket = new AJAXPacket("s4227_rpc_id.jsp","������֤�ͻ���ʶ�����Ժ�......");			
			myPacket.data.add("verifyType","phoneno");
			myPacket.data.add("guid",document.frm.guid.value);
			myPacket.data.add("loginNo",document.frm.loginNo.value);
			myPacket.data.add("orgCode",document.frm.orgCode.value);
			myPacket.data.add("opCode","4227");
			myPacket.data.add("totalDate",document.frm.totalDate.value);
			myPacket.data.add("IDType",document.frm.IDType.value);
			myPacket.data.add("phoneNo",document.frm.phoneNo.value);
			myPacket.data.add("custPWD",document.frm.custPWD.value);
			myPacket.data.add("cardType",document.frm.cardType.value);
			myPacket.data.add("cardID",document.frm.cardID.value);
			myPacket.data.add("servLevel",document.frm.servLevel.value);
			myPacket.data.add("attendant",document.frm.attendant.value);
			myPacket.data.add("qryType","0");//��ѯ����
			myPacket.data.add("beginTime","");//��ѯ��ʼʱ��
			myPacket.data.add("endTime","");//��ѯ����ʱ��
			myPacket.data.add("businessCode","BIP2B005");//
			myPacket.data.add("test_flag",document.frm.test_flag.value);
			myPacket.data.add("PrintAccept","<%=PrintAccept%>");
				
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
	
	function judge_valid()
	{
	var flag=0;
	 	if(!checkElement(document.getElementById("phoneNo"))) return false;
	 	
	 	if( (document.frm.custPWD.value == "" )
	 		&& (document.frm.cardID.value == "" )
	 	  ){
	 	  	rdShowMessageDialog("��������'�ͻ�����'����'֤������'�е�һ����");
	 	  	return false;	 	  
	 	  }
	 	
	 	if( document.frm.custPWD.value != "" ){
	 		if(!checkElement(document.getElementById("custPWD"))) return false;
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
	 		if(!checkElement(document.getElementById("cardID"))) return false;
	 		}
	 	}
	 
		if(!checkElement(document.getElementById("inTime"))) return false;
	
	 	if(!checkElement(document.getElementById("outTime"))) return false;	
	    if( document.frm.inTime.value > document.frm.outTime.value ){
	 	  	rdShowMessageDialog("����ʱ�����С���뿪ʱ�䣡");
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
	 with(document.frm)
	 {

		phoneNo.value	= "";
		custPWD.value	= "";
		cardID.value	= "";
		inTime.value	= "";
		outTime.value	= "";
		sumAmount.value	= "";
		sumScore.value	= "";
		
				                      
		                      
		custName.value="";
		vipNo.value="";
		custScore.value="";
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
		
		if( dyntb.rows.length == 2){//������û������
			rdShowMessageDialog("������û������,����������!!");
			return false;
		}
		
		else
			{
			for(var a=1; a<document.all.R0.length ;a++)//ɾ����tr1��ʼ��Ϊ������
			{
			  if( document.all.R0[a].checked ==  true )
			  {	
			  	//alert(document.all.R6[a]).value);
				if( !forNonNegInt(document.all.R6[a])) return false;
				if( !forNotNegReal(document.all.R5[a])) return false;
				
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
			rdShowMessageDialog("����ѡ��һ������!!");
			return false;		
		}
		
		document.frm.tmpR1.value = ind1Str;
		document.frm.tmpR2.value = ind2Str;
		document.frm.tmpR3.value = ind3Str;
		document.frm.tmpR4.value = ind4Str;
		document.frm.tmpR5.value = ind5Str;
		document.frm.tmpR6.value = ind6Str;
		
 		tmpStr = "��������  " + ",�ֻ�����:"+document.all.phoneNo.value+"";
 		

 		document.frm.opCode.value="4228";	

		document.frm.opNote.value =  tmpStr;

		document.frm.confirm.disabled = true;
	 //׼����ʼ��ӡ��� gaopeng 2013/3/18 ����һ 11:04:03	
 	  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");


	 
		if(typeof(ret)!="undefined")
		  {
		    if((ret=="confirm"))
		    {
		      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
		      {
			   		frmCfm1();
		      }
				}
			if(ret=="continueSub")
			{
		      if(rdShowConfirmDialog('ȷ���ύ��Ϣô��')==1)
		      {
			    	frmCfm1();
		      }
			}
		  }
		else
		  {
		     if(rdShowConfirmDialog('ȷ���ύ��Ϣô��')==1)
		     {
			     frmCfm1();
		     }
		  }	
	}
	function frmCfm1()
  {
  	var page = "s4228Cfm.jsp";
		frm.action=page;
		frm.method="post";
	  frm.submit();	  
  }
	  		
function autoidtify()
{
	document.frm.autoconfirm.disabled=true;
	var h=105;
	var w=260;
	var t=screen.availHeight-h-20;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
	var data1=window.showModalDialog("read_vipinfo.jsp",prop);      
	var svcnum=data1.substr(0,11);
	var cardnum=data1.substr(12,16);
	var cardlvl=data1.substr(29,1);
	var validate=data1.substr(31,4);
	document.all.phoneNo.value=svcnum;
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
}
//-->

/**
�����ӡ
*/
function showPrtDlg(printType,DlgMessage,submitCfm)
			{  //��ʾ��ӡ�Ի���
				var h=180;
				var w=350;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				
				var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
				var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
				var sysAccept ="<%=PrintAccept%>";
				var printStr =  printInfo(printType);
				var mode_code=null;           							//�ʷѴ���
				var fav_code=null;                				 		//�ط�����
				var area_code=null;             				 		//С������
				var opCode=document.frm.opCode.value;                   			 		//��������
				var phoneNo=document.all.phoneNo.value;                  	 		//�ͻ��绰
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";  
				var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
				path+="&mode_code="+mode_code+
					"&fav_code="+fav_code+"&area_code="+area_code+
					"&opCode="+opCode+"&sysAccept="+sysAccept+
					"&phoneNo="+phoneNo+
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
				
				cust_info+="�ֻ����룺"+document.all.phoneNo.value+"|";
				cust_info+="�ͻ�������"+document.all.custName.value+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				opr_info+="ҵ�����ͣ�"+"<%=opName%>"+"|";
			  opr_info+="����ҵ����ˮ��"+"<%=PrintAccept%>"+"|";
			  var arrservL = "";
			  var ifattendant="";
			  //alert(document.all.servLevel.value);
			  switch(document.all.servLevel.value)
			  {
			  	case  "1" :
				  arrservL="���ں���һ������";
				  break;
				  case "2" :
				  arrservL="���ں����������";
				  break;
				  case  "3" :
				  arrservL="���ʺ���һ������";
				  break;
				  /*
				  case "4" : 
				  arrservL="���ʺ����������";
				  break;
			  	*/
			  }
			  switch(document.all.attendant.value!=0)
			  {
			  	case true :
			  	ifattendant="��  ��Ա������"+document.all.attendant.value+" ��";
			  	break;
			  	case false :
			  	ifattendant= "��";
			  	break;
			  }
				opr_info+="���񼶱�"+arrservL+"|";
				opr_info+="�Ƿ���Ա��"+ifattendant+"|";
				opr_info+="�������ƣ�"+document.all.airportName.value+"|";
				opr_info+="����ţ�"+document.all.airNo.value+"|";
				opr_info+="�۳����֣�"+document.all.sumScore.value+"|";
				opr_info+="ʹ����Ѵ�����"+document.all.sumTimes.value+"|";
				
				opr_info+="ҵ������ʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>"+"|";						    
		    note_info1+="��ע���ֻ����룺"+document.all.phoneNo.value+"�������ҵ��|";	   
				retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
			  return retInfo;
			}		


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
		<div id="title_zi">��������</div>
	</div>
	<table cellspacing="0">
		  <tr id="test" style="display:none"> 
        <td class="blue"><div align="right">��ͨ��ʽ��</div></td>
        <td colspan="3">
					<select name="test_flag" id="test_flag">
					</select>
				</td>
		  </tr>
		  
      <tr>
        <td width="20%" class="blue"><div align="right">�������ͣ�</div></td>
        <td width="30%" >
        	<input name="opType" type="text" class="button" id="opType" value="<%=opName%>" disabled>
        </td>
				<td>
					<div align="left"></div><input name="autoconfirm" type="button" class="b_text" value="�Զ���ȡVIP��Ϣ" onClick="autoidtify()">
					<input name="opType1" type="hidden" class="button" id="opType1" value="��ػ�������" > 
        </td>
        <td>&nbsp;</td>
       </tr>
       
       <tr>
         <td class="blue"><div align="right">�ͻ���ʶ���ͣ�</div></td>
         <td>
         	<select name="IDType" id="IDType">
                <option value="01">01--&gt;�ֻ�����</option>
              </select>
         </td>
         <td class="blue"><div align="right">�ͻ���ʶ��</div></td>
         <td>
         	<input name="phoneNo" type="text" class="button" id="phoneNo" index="1" v_must=1 v_type="mobphone" v_minlength=11  v_name="�ֻ�����" value=""> 
          <font color="#FF0000">*</font>
         </td>
       </tr>
       
       <tr> 
         	<td class="blue"><div align="right">�ͻ����룺</div></td>
          <td colspan="3">
          	<input name="custPWD" type="password" class="button" index="2" id="custPWD" maxlength="8" v_must=1 v_type=0_9 v_minlength=1  v_name="�ͻ�����">
            <font color="#FF0000"  >*(�ͻ������֤�������ѡһ)</font>
          </td>
       </tr>
       
       <tr> 
          <td width="20%" class="blue"><div align="right">֤�����ͣ�</div></td>
          <td width="30%">
          	<select name="cardType" id="cardType">
              <option value="00">00--&gt;���֤</option>
              <option value="01">01--&gt;VIP��</option>
              <option value="99">99--&gt;����</option>
            </select>
          </td>
          <td class="blue"><div align="right">֤�����룺</div></td>
          <td>
          	<input name="cardID" type="text" class="button" id="cardID" index="3" maxlength="20" v_must=1 v_type=idcard v_minlength=1  v_name="֤������" value=""> 
            <font color="#FF0000">*</font>              
          </td>
       </tr>
       
       <tr> 
          <td class="blue"><div align="right">���񼶱�</div></td>
          <td>
          	<select name="servLevel" id="servLevel" onChange="chg_servLevel()" style="width:219px">
              <option value="1">1--&gt;���ں���һ������--4000����</option>
              <option value="2">2--&gt;���ں����������--8000����</option>
              <option value="3">3--&gt;���ʺ���һ������--8000����</option>
            </select>
          </td>
          <td class="blue"><div align="right">��Ա������</div></td>
          <td>
          	<input name="attendant" type="text" class="button" id="attendant" index="3" maxlength="2" v_must=1 v_type=0_9 v_minlength=1  v_name="��Ա����" value="0"><font class="orange">(��������)</font>
          	<input name="noCheck" type="button" class="b_text" id="noCheck" index="4" value="��֤" onClick="call_noCheck()"> 
          </td>
       </tr>
       
       <tr> 
          <td class="blue"><div align="right">�ͻ�������</div></td>
          <td><input name="custName" type="text" class="button" id="custName" disabled></td>
          <td class="blue"><div align="right">֤�����ͼ����룺</div></td>
          <td><input name="vipNo" type="text" class="button" id="vipNo" disabled></td>
       </tr>
       
       <tr> 
          <td class="blue"><div align="right">�û�״̬��</div></td>
          <td>
          	<select name="custStat" id="custStat" readonly disabled>
          <%
      	for(int i=0;i<runTypeData.length; i++){
      		//String code[]=(String[])runTypeData.get(i);
				out.println("<option class='button' value='"+runTypeData[i][0]+"'>"+runTypeData[i][1]+"</option>");
						}
	  			%>
            </select>
          </td>
          <td class="blue"><div align="right">�ͻ�����</div></td>
          <td>
          	<select name="custRank" id="custRank" readonly disabled>
          <%
      	for(int i=0;i<ownerTypeData.length; i++){
      		//String code[]=(String[])ownerTypeData.get(i);
				out.println("<option class='button' value='"+ownerTypeData[i][0]+"'>"+ownerTypeData[i][1]+"</option>");
						}
	  			%>
            </select>
          </td>
       </tr>
       
       <tr> 
          <td class="blue"><div align="right">�ͻ����֣�</div></td>
          <td><input name="custScore" type="text" class="button" id="custScore" disabled></td>
          <td class="blue"><div align="right">ʣ����Ѵ�����</div></td>
          <td><input name="freeTimes" type="text" class="button" id="freeTimes" disabled></td>
       </tr>
       
       <tr>
          <td class="blue"><div align="right">��ͻ�����绰��</div></td>
          <td><input name="svcPhNum" type="text" class="button" id="svcPhNum" disabled></td>
          <td class="blue"></td>
          <td></td>
       </tr>
       
       <tr> 
          <td class="blue"><div align="right">�ܷ��ṩ����</div></td>
          <td><input name="Answer" type="hidden" class="button" id="Answer" disabled><input name="AnswerDesc" type="text" class="button" id="AnswerDesc" disabled></td>
          <td class="blue"><div align="right">����ܾ����ɣ�</div></td>
          <td><input name="rejectDesc" type="text" class="button" id="rejectDesc" disabled></td>
       </tr>

					<input name="custName1" type="hidden" class="button" id="custName1" >
					
			 <tr> 
          <td class="blue"><div align="right">�������ƣ�</div></td>
          <td><input name="airportName" type="text" class="button" id="airportName" index="5" maxlength="20" v_type="" v_minlength=14  v_name="��������">
          </td>
          <td class="blue"><div align="right">����ţ�</div></td>
          <td><input name="airNo" type="text" class="button" id="airNo" index="6" maxlength="14" v_type="" v_minlength=14  v_name="�����">
          </td>
       </tr>

       <tr> 
          <td class="blue"><div align="right">����ʱ�䣺</div></td>
          <td><input name="inTime" type="text"  id="inTime" index="5" maxlength="14" v_must=1  v_minlength=14  v_format="yyyyMMddHHmmss">
            <font color="#FF0000">*</font>(��ʽ:YYYYMMDDHHMMSS)</td>
          <td class="blue"><div align="right">�뿪ʱ�䣺</div></td>
          <td><input name="outTime" type="text"  id="outTime" index="6" maxlength="14" v_must=1   v_minlength=14  v_format="yyyyMMddHHmmss">
            <font color="#FF0000">*</font>(��ʽ:YYYYMMDDHHMMSS)</td>
       </tr>
      </table>
       
      <table cellspacing="0" id="dyntb">
                <tr> 
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
          <tr> 
            <td><input name="computeTotal" type="button" class="b_text" value="�����ܶ�" onClick="call_computeTotal()" disabled="true"></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td class="blue"><div align="right">�ܿۻ��֣�</div></td>
            <td><input name="sumScore" type="text" class="button" id="sumScore" readonly></td>
            <td class="blue"><div align="right">ʹ����Ѵ�����</div></td>
            <td><input name="sumTimes" type="text" class="button" id="sumTimes" readonly><input name="sumAmount" type="hidden" class="button" id="sumAmount" readonly></td>
          </tr>
          <tr> 
            <td width="20%" height="32"><div align="right">������ע��</div></td>
            <td height="30" colspan="3"> <input name="opNote" type="text" class="button" id="opNote" size="60" maxlength="60"> 
            </td>
          </tr>
      </table>
      	<table cellspacing="0">
          <tr align="center"> 
            <td colspan="4" align="center" id="footer"> <div align="center"> 
                <input name="confirm" type="button" class="b_foot" value="ȷ��" onClick="commitJsp()">
                &nbsp; 
                <input name="reset" type="button" class="b_foot" value="���" onClick="resetJsp()">
                &nbsp; 
                <input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="����">
                &nbsp; </div></td>
          </tr>
        </table>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  
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
<%@ include file="/npage/include/footer.jsp" %>		
</form>
<!--%@ include file="/page/common/mask_rightkey.jsp" %>-->
</body>
</html>
