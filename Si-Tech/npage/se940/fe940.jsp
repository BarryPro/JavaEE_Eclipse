<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
version v1.0
������: si-tech
ningtn 2012-7-19 14:13:46
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.RoleManage.wrapper.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "e940";
 		String opName = "�����½�����";
 		
 		String regionCode = (String)session.getAttribute("regCode");
 		String accountType = (String)session.getAttribute("accountType");
 		String powerCode2=(String)session.getAttribute("powerCode");
 		String org_codeT = (String)session.getAttribute("orgCode");
 		String dis_codeT = org_codeT.substring(2,4);	
 		String sWorkNo = (String)session.getAttribute("workNo");
 		String dNopass = (String)session.getAttribute("password");
 		
 		comImpl comResult = new comImpl();
 		
 		String sql1 = "SELECT power_code,power_name FROM spowercode where power_code like '01%'";
 //		ArrayList arr = RoleManageWrapper.getPowerCode1(powerCode2);
 		ArrayList arr = comResult.spubqry32("2",sql1);
 		String[][] powerCode =  (String[][])arr.get(0);
 		
 		String sql2 = "SELECT region_code,district_code,district_name,login_district FROM sdiscode WHERE region_code='"+regionCode+"'";
// 		ArrayList disArrInit = RoleManageWrapper.getDisCode(regionCode);
		ArrayList disArrInit = comResult.spubqry32("2",sql2);
		String[][] disCodeInit = (String[][])disArrInit.get(0);
		
		String sql3 = "SELECT login_flag,flag_name,login_name,config_flag FROM slogintype where config_flag = 'Y'";
//		ArrayList typeArr = RoleManageWrapper.getLoginType();
		ArrayList typeArr = comResult.spubqry32("2",sql3);
		String[][] loginTypeStr = (String[][])typeArr.get(0);

		String sql4 = "SELECT power_right,right_name FROM spowervaluecode";
 		
//		ArrayList powerRightArr = RoleManageWrapper.getPowerRight();
		ArrayList powerRightArr = comResult.spubqry32("2",sql4);
		String[][] powerRight = (String[][])powerRightArr.get(0);
		
		String sql5 = "SELECT rpt_right,right_name FROM srptright";
//		ArrayList rptArr = RoleManageWrapper.getRptCode();
		ArrayList rptArr = comResult.spubqry32("2",sql5);
		String[][] rptCode = (String[][])rptArr.get(0);
		
		String cuDate =new SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date()).toString();
		GregorianCalendar currentTime = new GregorianCalendar();
		GregorianCalendar currentTime2 = new GregorianCalendar();
		SimpleDateFormat fmtrq = new SimpleDateFormat("yyyyMMdd HH:mm:ss",Locale.US); 
		currentTime.add(GregorianCalendar.MONTH,1);
		currentTime2.add(GregorianCalendar.MONTH,3);
		String dateString=fmtrq.format(currentTime.getTime());	
		String dateString2=fmtrq.format(currentTime2.getTime());	
%>
<%
	String sqlRegion = "select region_code, trim(region_name), login_region from sRegionCode "; 
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
		<wtc:sql><%=sqlRegion%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="regionCodeResult" scope="end"/>
<%
		String sGrpId =  (String)session.getAttribute("groupId");
		String strSqlAccType = "select account_type, account_name from sAccType where 1 = 1 ";
	
		if((!sGrpId.trim().equals("10014"))&&(!powerCode[0][0].trim().equals("01")))
		{
			strSqlAccType = strSqlAccType + " and account_type != '0'";
		}
		if((!sGrpId.trim().equals("10014"))&&(!accountType.equals("2"))&&(!(sGrpId.trim().equals("340343")&&accountType.equals("0"))))
		{
			strSqlAccType = strSqlAccType + " and account_type != '2'";
		}
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="3">
		<wtc:sql><%=strSqlAccType%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="acctypeArr" scope="end" />
<%
 		String printAccept="";
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		printAccept = seq;
%>
<html>
<head>
	<title>�����½�����</title>
	<script type="text/javascript" src="/npage/public/printExcel.js"></script>
	<script type="text/javascript" src="/npage/public/pubLightBox.js"></script>
	<script language="javascript">
		
		function WorkInfo(){
		}
		WorkInfo.prototype.setWorkName = function(workName){
			this.workName = workName;
		};
		WorkInfo.prototype.getWorkName = function(){
			return this.workName;
		};
		WorkInfo.prototype.setWorkIccid = function(workIccid){
			this.workIccid = workIccid;
		};
		WorkInfo.prototype.getWorkIccid = function(){
			return this.workIccid;
		};
		WorkInfo.prototype.setWorkNo = function(workNo){
			this.workNo = workNo;
		};
		WorkInfo.prototype.getWorkNo = function(){
			return this.workNo;
		};
		WorkInfo.prototype.setWorkPassword = function(workPassword){
			this.workPassword = workPassword;
		};
		WorkInfo.prototype.getWorkPassword = function(){
			return this.workPassword;
		};
		WorkInfo.prototype.setSeqMailCode = function(seqMailCode){
			this.seqMailCode = seqMailCode;
		};
		WorkInfo.prototype.getSeqMailCode = function(){
			return this.seqMailCode;
		};
		
		WorkInfo.prototype.setCreateFlag = function(createFlag){
			this.createFlag = createFlag;
		};
		WorkInfo.prototype.getCreateFlag = function(){
			return this.createFlag;
		};
		WorkInfo.prototype.setCreateNote = function(createNote){
			this.createNote = createNote;
		};
		WorkInfo.prototype.getCreateNote = function(){
			return this.createNote;
		};
		WorkInfo.prototype.setMailCodeAddr = function(mailCodeAddr){
			this.mailCodeAddr = mailCodeAddr;
		};
		WorkInfo.prototype.getMailCodeAddr = function(){
			return this.mailCodeAddr;
		};
		WorkInfo.prototype.setAccountNo = function(accountNo){
			this.accountNo = accountNo;
		};
		WorkInfo.prototype.getAccountNo = function(){
			return this.accountNo;
		};
		WorkInfo.prototype.setAccountType = function(accountType){
			this.accountType = accountType;
		};
		WorkInfo.prototype.getAccountType = function(){
			return this.accountType;
		};
		WorkInfo.prototype.setRegionName = function(regionName){
			this.regionName = regionName;
		};
		WorkInfo.prototype.getRegionName = function(){
			return this.regionName;
		};
		WorkInfo.prototype.setDisName = function(disName){
			this.disName = disName;
		};
		WorkInfo.prototype.getDisName = function(){
			return this.disName;
		};
		WorkInfo.prototype.setTownName = function(townName){
			this.townName = townName;
		};
		WorkInfo.prototype.getTownName = function(){
			return this.townName;
		};
		WorkInfo.prototype.setYloginFlag = function(yloginFlag){
			this.yloginFlag = yloginFlag;
		};
		WorkInfo.prototype.getYloginFlag = function(){
			return this.yloginFlag;
		};
		WorkInfo.prototype.setPowerRight = function(powerRight){
			this.powerRight = powerRight;
		};
		WorkInfo.prototype.getPowerRight = function(){
			return this.powerRight;
		};
		WorkInfo.prototype.setRptRight = function(rptRight){
			this.rptRight = rptRight;
		};
		WorkInfo.prototype.getRptRight = function(){
			return this.rptRight;
		};
		WorkInfo.prototype.setAllowBegin = function(allowBegin){
			this.allowBegin = allowBegin;
		};
		WorkInfo.prototype.getAllowBegin = function(){
			return this.allowBegin;
		};
		WorkInfo.prototype.setAllowEnd = function(allowEnd){
			this.allowEnd = allowEnd;
		};
		WorkInfo.prototype.getAllowEnd = function(){
			return this.allowEnd;
		};
		WorkInfo.prototype.setExpireTime = function(expireTime){
			this.expireTime = expireTime;
		};
		WorkInfo.prototype.getExpireTime = function(){
			return this.expireTime;
		};
		WorkInfo.prototype.setOtherFlag = function(otherFlag){
			this.otherFlag = otherFlag;
		};
		WorkInfo.prototype.getOtherFlag = function(){
			return this.otherFlag;
		};
		
		
		
		function SuccessWorkList(){
			this.length = 0;
			this.workInfos = [];
		}
		SuccessWorkList.prototype.getLength = function(){
			return this.length;
		};
		SuccessWorkList.prototype.getWorkInfo = function(i)
		{ 
			 return this.workInfos[i];
		};
		SuccessWorkList.prototype.addWorkInfo = function(workInfo){
			this.workInfos[this.length++] = workInfo;
		};
		
		function FailWorkList(){
			this.length = 0;
			this.workInfos = [];
		}
		FailWorkList.prototype.getLength = function(){
			return this.length;
		};
		FailWorkList.prototype.getWorkInfo = function(i)
		{ 
			 return this.workInfos[i];
		};
		FailWorkList.prototype.addWorkInfo = function(workInfo){
			this.workInfos[this.length++] = workInfo;
		};
		
		var successWorkList = new SuccessWorkList();
		var failWorkList = new FailWorkList();
		var tempWorkInfo = new WorkInfo();
		
		$(document).ready(function(){
			<%if(!sWorkNo.substring(0,1).equals("8")){%>
			//	ycallTownCode();
			<%}%>
		});
		
		function AccTypeChg(){
			/* 20091230 ���������ɷ����� || document.frm.AccountType.value=="4"*/
			if(document.frm.AccountType.value == "1" || document.frm.AccountType.value == "4")
			{
				var sysdate = "<%=cuDate%>";
				var dateStringtmp1 = "<%=dateString%>"; //add by sungq
				document.frm.yallowBegin.value = sysdate.substring(0,8) + " 08:00:00";
				document.frm.yallowEnd.value = "20500101 18:00:00";
				document.frm.yotherFlag.value = "N";
				document.frm.ypowerRight.disabled = false;
				document.frm.yrptRight.disabled = false;
				document.frm.yloginFlag.disabled = false;
				document.getElementById("tbAccName").style.display = "none";//����ʾ
				document.getElementById("tbRegion1").style.display = "";
				document.getElementById("trPowerCode").style.display = "";
				document.getElementById("tdAccType").style.display = "none";
			//	document.getElementById("tdAccType2").style.display = "none";
				document.getElementById("tdFuncType").style.display = "";
			//	document.getElementById("tdFuncType2").style.display = "";
				document.frm.yexpireTime.value=dateStringtmp1; //add by sungq
			}
			else if(document.frm.AccountType.value == "2")
			{
				//document.frm.yallowBegin.value = "00:00:00";
				//document.frm.yallowEnd.value = "23:59:59";
				var dateStringtmp2 = "<%=dateString2%>";  //add by sungq
				//alert(tmpcurrentTime2);
				document.frm.yotherFlag.disabled = true;
				document.frm.yotherFlag.value = "N";
				document.getElementById("tbAccName").style.display = "";//��ʾ
				document.getElementById("tbRegion1").style.display = "none";
				document.getElementById("trPowerCode").style.display = "";
				document.getElementById("tdFuncType").style.display = "none";
			//	document.getElementById("tdFuncType2").style.display = "none";
				document.getElementById("tdAccType").style.display = "";
			//	document.getElementById("tdAccType2").style.display = "";
				document.frm.submitr.disabled=true;
				document.frm.ypowerRight.disabled = true;
				document.frm.yrptRight.disabled = true;
				document.frm.addButton.disabled = false;
				document.frm.AccountNo.disabled = false;
				document.frm.yloginFlag.disabled = true;
				document.frm.ypowerRight.value = "2";
				document.frm.yrptRight.value = "9";
				document.frm.groupId.value = "";
				document.frm.groupName.value = "";
				document.frm.yloginFlag.value = "2";
				document.frm.AccountNo.value = "";
				document.frm.yexpireTime.value=dateStringtmp2; //add by sungq
			}
			else //if((document.frm.AccountType.value == "0")||(document.frm.AccountType.value == "3"))
			{
				var dateStringtmp3 = "<%=dateString%>";  //add by sungq
				document.getElementById("tbAccName").style.display = "";//��ʾ
				document.getElementById("tbRegion1").style.display = "none";
				document.getElementById("trPowerCode").style.display = "";
				document.getElementById("tdAccType").style.display = "none";
			//	document.getElementById("tdAccType2").style.display = "none";
				document.getElementById("tdFuncType").style.display = "";
			//	document.getElementById("tdFuncType2").style.display = "";
				document.frm.ypowerRight.disabled = false;
				document.frm.yrptRight.disabled = false;
				document.frm.submitr.disabled = true;
				document.frm.AccountNo.disabled = false;
			//	document.frm.FuncNo.disabled = false;
				document.frm.addButton.disabled = false;
			//	document.frm.chkFuncNo.disabled = false;
				document.frm.yotherFlag.disabled = false;
				document.frm.yloginFlag.disabled = false;
				document.frm.groupId.value = "";
				document.frm.groupName.value = "";
				document.frm.AccountNo.value = "";
				document.frm.yexpireTime.value=dateStringtmp3; //add by sungq
			}
		
		}
		function StrAdd(AddType, SrcStr, Value){
				//AddType 0ֵ��1�� 1:ģ��1
				var BaseStr ="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
				var S = "";
				var CurPos = 0, PrePos = 0, SrcLen=0,BaseLen=0, Index=0;
				var isCarry = 0;
			
				SrcLen= SrcStr.length;
				BaseLen=BaseStr.length;
				isCarry = Value % BaseLen;
			
				for(CurPos = SrcLen - 1; CurPos >= 0; CurPos --)
				{
					if (isCarry != 0)
					{
						Index = BaseStr.indexOf(SrcStr.charAt(CurPos)) + isCarry;
						if (Index < -1)
						{
							return "";
						}
						if (Index > BaseLen - 1)
						{
							isCarry = 1;
							S = BaseStr.charAt(Index - BaseLen) + S;
						}
						else
						{
							isCarry = 0;
							S = SrcStr.substring(0, CurPos) + BaseStr.charAt(Index) + S;
							break;
						}
						if (CurPos == 0 && AddType == 0)
							S = BaseStr.charAt(0) + S;
					}
					else
					{
						break;
					}
				}
			
				return S;
			}

		function doProcess(packet){
			var backString = packet.data.findValueByName("backString");
			var flag = packet.data.findValueByName("flag");
			if(flag=="12"){
				var sloginNo = backString;
				if(sloginNo=="")
				{
					document.frm.AccountNo.value="";
					return;
				}
				document.frm.AccountNo.disabled=true;
				document.frm.addButton.disabled = true;
				var SEQ_MailCode = packet.data.findValueByName("SEQ_MailCode");//20100317 add
				tempWorkInfo.setMailCodeAddr(sloginNo+SEQ_MailCode+"@hl.chinamobile.com");
				tempWorkInfo.setSeqMailCode(SEQ_MailCode);
				return;
			}
			if(flag=="10"){
				var maxNo = packet.data.findValueByName("nott");
				var maxLogin = backString;
				tempWorkInfo.setCreateFlag("1");
				if(maxLogin.length!=6)
				{
					tempWorkInfo.setCreateNote("'"+maxLogin+"'���ű���ĳ���ĸ�����ֵ���λ��ϣ���ǰ��λ�������޸ģ�");
					tempWorkInfo.setCreateFlag("0");
					return;
				}
				var SEQ_MailCode = packet.data.findValueByName("SEQ_MailCode");//20100317 add
				var changeNo = maxLogin.substring(4,6);
				if(changeNo=="zz")
				{
					tempWorkInfo.setCreateNote("��Ӫҵ�����������������Զ����ɡ�������ֹ����룡ע�⣺���ų��ȹ�6λ��ǰ4λ����������");
					tempWorkInfo.setCreateFlag("0");
				}
				var remainNo = maxLogin.substring(0,4);
				var newMaxNo = StrAdd(1,maxNo,1);
				maxLogin = StrAdd(1,changeNo,1);
				var newNo = remainNo + maxLogin;
				if(changeNo=="zz")
				{
					
				}
				else
				{
					tempWorkInfo.setWorkNo(newNo);
					tempWorkInfo.setMailCodeAddr(newNo+SEQ_MailCode+"@hl.chinamobile.com");
				}
				document.frm.yorgNo.value=newMaxNo;
				document.frm.submitr.disabled=false;
				tempWorkInfo.setSeqMailCode(SEQ_MailCode);
				return;
			}
			
			var temLength = backString.length+1;
			var arr = new Array(temLength);
			for(var i = 0 ; i < backString.length ; i ++){
				arr[i] = "<OPTION value="+backString[i][0]+" pvalue="+backString[i][2]+">" + backString[i][1] + "</OPTION>";
			}
			
			if(flag=="3"){
				ydisCodeDiv.innerHTML = "<select id=disCode size=1 name=ydisctrictCode onchange=ycallTownCode()>" + arr.join() + "</SELECT>";
				ycallTownCode();
			}
			if(flag=="4"){
				/*ycallTownCode.jsp*/
			  ytownCodeDiv.innerHTML = "<select id=tCode size=1 name=ytownCode onchange=chgTownCode() onmouseover=FixWidth(this)>" + arr.join() + "</SELECT>";
			}
			if(flag=="11"){
				/*getMaxLastOrgNo.jsp*/
				var newMaxNo = StrAdd(1,backString,1);
				document.frm.yorgNo.value=newMaxNo;
				return;
			}
			if(flag=="9"){
				if("000000" == backString[0][0]){
					/*����û���ӳɹ���*/
					successWorkList.addWorkInfo(tempWorkInfo);
				}else{
					/*��ʧ���б������*/
					tempWorkInfo.setCreateNote(backString[1][0]);
					failWorkList.addWorkInfo(tempWorkInfo);
				}
			}
			if(flag == "6"){
				tempWorkInfo.setAccountNo(backString);
				tempWorkInfo.setWorkNo(backString);
				tempWorkInfo.setCreateFlag("1");
			}
		}
		function ycallDisCode(){
			var i = 0;
			var regionCode = 0;
			for(i = 0 ; i < document.frm.yregionCode.length ; i ++){
				if(document.frm.yregionCode.options[i].selected){
					regionCode = document.frm.yregionCode.options[i].value;
				}
			}
			var myPacket = new AJAXPacket("/npage/s8002/ycallDisCode.jsp","���ڲ�ѯ�����Ժ�......");
			myPacket.data.add("region_code",regionCode);
			core.ajax.sendPacket(myPacket);
			myPacket=null;
		}
		function ycallTownCode(){
			var i = 0;
			var regionCode = 0;
			for(i = 0 ; i < document.frm.yregionCode.length ; i ++)
			{
				if(document.frm.yregionCode.options[i].selected)
				{
					regionCode = document.frm.yregionCode.options[i].value;
				}
			}
			var j = 0;
			var disctrictCode = 0;
			for(j = 0 ; j < document.frm.ydisctrictCode.length ; j ++)
			{
				if(document.frm.ydisctrictCode.options[j].selected)
				{
					disctrictCode = document.frm.ydisctrictCode.options[j].value;
				}
			}
			
			var myPacket = new AJAXPacket("/npage/s8002/ycallTownCode.jsp","���ڲ�ѯ�����Ժ�......");
			myPacket.data.add("region_code",regionCode);
			myPacket.data.add("dis_code",disctrictCode);
			core.ajax.sendPacket(myPacket);
			myPacket=null;
		}
		function chgTownCode(){
		}
		
		function queryPowerCode(str){
			var path = "/npage/s8002/roletree.jsp?formFlag="+str+"&CodeType=power_code&NameType=power_name";
			window.open(path,'_blank','height=600,width=300,scrollbars=yes');
		}
		
		function getDptCode(){
			if(document.frm.AccountType.value == "2")
			{
				return;
			}
			var regionCode = document.frm.yregionCode.value;
			var townCode = document.frm.ytownCode.value;
			var typeCode = document.frm.yloginFlag.value;
			if(typeCode=="3")
			{
				townCode="005";
				regionCode="00";
			}
			if(regionCode!="0x")
				window.open("../../../callcenter/ccpage/pub/dptTreeToYY.jsp?regionCode="+regionCode+"&townCode="+townCode,"","height=500,width=500,scrollbars=yes");
		}
		
		function selectNoType(){
			var z = 0 ;
			var cTypeCode = 0 ;
			var cLoginFlager = 0;
			for(z = 0 ; z < document.frm.yloginFlag.length ; z ++)
			{
				if(document.frm.yloginFlag.options[z].selected)
				{
					cTypeCode = document.frm.yloginFlag.options[z].type_value;
					cLoginFlager = document.frm.yloginFlag.options[z].value;
				}
			}
			if(cTypeCode=="k")
			{
				document.all.khide.style.display='';
				document.all.idLoginNo.maxlength=5;
				document.all.yregionCode.disabled=true;
				document.all.ydisctrictCode.disabled=true;
				document.all.ytownCode.disabled=true;
				var myPacket = new AJAXPacket("/npage/s8002/getMaxLastOrgNo.jsp","���ڴ����ͷ���󹤺���Ϣ�����Ժ�......");
				myPacket.data.add("fLoginFlager",cLoginFlager);
				core.ajax.sendPacket(myPacket);
		    		myPacket=null;
			}
			else
			{
				document.all.khide.style.display='none';
				document.all.yregionCode.disabled=false;
				document.all.ydisctrictCode.disabled=false;
				document.all.ytownCode.disabled=false;
				document.all.idLoginNo.maxlength=6;
			}
		}
		function creatLoginNo(){
			var z = 0 ;
			var cTypeCode = 0 ;
			for(z = 0 ; z < document.frm.yloginFlag.length ; z ++)
			{
				if(document.frm.yloginFlag.options[z].selected)
				{
					cTypeCode = document.frm.yloginFlag.options[z].type_value;
				}
			}
			var i = 0;
			var cRegionCode = 0;
			var iRegionCode = 0;
			for(i = 0 ; i < document.frm.yregionCode.length ; i ++)
			{
				if(document.frm.yregionCode.options[i].selected)
				{
					cRegionCode = document.frm.yregionCode.options[i].pvalue;
					iRegionCode = document.frm.yregionCode.options[i].value;
				}
			}
			var j = 0;
			var cDisctrictCode = 0;
			var iDisctrictCode = 0;
			for(j = 0 ; j < document.frm.ydisctrictCode.length ; j ++)
			{
				if(document.frm.ydisctrictCode.options[j].selected)
				{
					cDisctrictCode = document.frm.ydisctrictCode.options[j].pvalue;
					iDisctrictCode = document.frm.ydisctrictCode.options[j].value;
				}
			}
			var k = 0;
			var cTownCode = 0;
			var iTownCode = 0;
			/* for(k = 0 ; k < document.frm.ytownCode.length ; k ++)
			{
				if(document.frm.ytownCode.options[k].selected)
				{
					cTownCode = document.frm.ytownCode.options[k].pvalue;
					iTownCode = document.frm.ytownCode.options[k].value;
				}
			} */
			cTownCode = "a";
			iTownCode ="01";
			
		
			var noList = cRegionCode+cDisctrictCode+cTownCode;
			var iNoList = iRegionCode + iDisctrictCode+iTownCode;
			if(cTypeCode=="k")
			{
				noList="k";
			}
			
			var myPacket = new AJAXPacket("/npage/s8002/creatLoginNo.jsp","�����ύ�����Ժ�......");
			myPacket.data.add("noList",noList);
			myPacket.data.add("iNoList",iNoList);
			core.ajax.sendPacket(myPacket);
			myPacket=null;
		}
		
		function submitt(){
			if($("#workNoList").val() == ""){
				rdShowMessageDialog("���ϴ�BOSS�����ļ���");
				return;
			}
			var formFile=frm.workNoList.value.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=frm.workNoList.value.length;
			formFile=frm.workNoList.value.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("�ϴ��ļ���ʽֻ����txt��������ѡ��BOSS�����ļ���");
				document.frm.workNoList.focus();
				return false;
			}
			
			//*************sunwt modify in 20080125*****************
		  /* 20091230 ���������ɷ����� || document.frm.AccountType.value=="4"*/
			if(document.frm.AccountType.value=="1" || document.frm.AccountType.value=="4")
			{
				if(document.frm.yorgNo.value.length=="0")
				{
					rdShowMessageDialog("�������ţ�");
					return;
				}
			}
			else if(document.frm.AccountType.value=="3" )
			{
				if(document.frm.groupName.value.length==0)
				{
					rdShowMessageDialog("��ѡ����֯�ڵ㣡");
					return;
				}
			}
			else  //.AccountType.value == "2"
			{
				if(document.frm.groupName.value.length==0)
				{
					rdShowMessageDialog("��ѡ����֯�ڵ㣡");
					return;
				}
		
				//document.frm.power_code.value = "019901";
			}
			if($("#oaNumber").val()==""){
				rdShowMessageDialog("������OA��ţ�");
				return false;
			}
			if($("#oaTitle").val()==""){
				rdShowMessageDialog("������OA���⣡");
				return false;
			}
			
			//**************************************
			
			if(document.frm.power_code.value=="")
			{
			  rdShowMessageDialog("��ѡ���ɫ���룡");
				return;
			}
			if(forDate(document.frm.yallowBegin)==false)
			{
				return;
			}
			if(forDate(document.frm.yexpireTime)==false)
			{
				return;
			}
			if(forDate(document.frm.yallowEnd)==false)
			{
				return;
			}
		
			if(document.frm.ydeptCode.value.length=="0")
			{
				document.frm.ydeptCode.value="";
			}
			var radioJ = 0;
			for(radioJ = 0 ; radioJ < document.frm.yvalidFlag.length ; radioJ ++)
			{
				if(document.frm.yvalidFlag[radioJ].checked)
				{
					document.frm.valid_flag.value = document.frm.yvalidFlag[radioJ].value;
				}
			}
			var radioK = 0;
			for(radioK = 0 ; radioK < document.frm.ymaintainFlag.length ; radioK++)
			{
				if(document.frm.ymaintainFlag[radioK].checked)
				{
					document.frm.maintain_flag.value = document.frm.ymaintainFlag[radioK].value;
				}
			}
			var flagI = 0 ;
			for(flagI = 0 ; flagI < document.frm.yloginFlag.length ; flagI ++)
			{
				if(document.frm.yloginFlag.options[flagI].selected)
				{
					document.frm.login_flag.value = document.frm.yloginFlag.options[flagI].value;
				}
			}
		
			var powerRightI = 0 ;
			for(powerRightI = 0 ; powerRightI < document.frm.ypowerRight.length ; powerRightI ++)
			{
				if(document.frm.ypowerRight.options[powerRightI].selected)
				{
					document.frm.power_right.value = document.frm.ypowerRight.options[powerRightI].value;
				}
			}
			var rptRightI = 0 ;
			for(rptRightI = 0 ; rptRightI < document.frm.yrptRight.length ; rptRightI ++)
			{
				if(document.frm.yrptRight.options[rptRightI ].selected)
				{
					document.frm.rpt_right.value = document.frm.yrptRight.options[rptRightI ].value;
				}
			}
			/* 20091230 ���������ɷ����� || document.frm.AccountType.value=="4"*/
			if(document.frm.AccountType.value == "1" || document.frm.AccountType.value == "4")
			{
				var regionCodeI = 0 ;
				for(regionCodeI = 0 ; regionCodeI < document.frm.yregionCode.length ; regionCodeI ++)
				{
					if(document.frm.yregionCode.options[regionCodeI].selected)
					{
						document.frm.region_code.value = document.frm.yregionCode.options[regionCodeI].value;
					}
				}
				var disctrictCodeI = 0 ;
				for(disctrictCodeI = 0 ; disctrictCodeI < document.frm.ydisctrictCode.length ; disctrictCodeI ++)
				{
					if(document.frm.ydisctrictCode.options[disctrictCodeI].selected)
					{
						document.frm.disctrict_code.value = document.frm.ydisctrictCode.options[disctrictCodeI].value;
					}
				}
				var townCodeI = 0 ;
				/* for(townCodeI = 0 ; townCodeI < document.frm.ytownCode.length ; townCodeI ++)
				{
					if(document.frm.ytownCode.options[townCodeI].selected)
					{
						document.frm.town_code.value = document.frm.ytownCode.options[townCodeI].value;
					}
				} */
				
				document.frm.town_code.value = $("select[name=ytownCode]").val();
			}
		
			var reFlagI = 0 ;
			for(reFlagI = 0 ; reFlagI < document.frm.yreFlag.length ; reFlagI ++)
			{
				if(document.frm.yreFlag.options[reFlagI].selected)
				{
					document.frm.re_flag.value = document.frm.yreFlag.options[reFlagI].value;
				}
			}
			var loginStatusI = 0 ;
			for(loginStatusI = 0 ; loginStatusI < document.frm.yloginStatus.length ; loginStatusI ++)
			{
				if(document.frm.yloginStatus.options[loginStatusI].selected)
				{
					document.frm.login_status.value = document.frm.yloginStatus.options[loginStatusI].value;
				}
			}
			var otherFlagI = 0 ;
			for(otherFlagI = 0 ; otherFlagI < document.frm.yotherFlag.length ; otherFlagI ++)
			{
				if(document.frm.yotherFlag.options[otherFlagI].selected)
				{
					document.frm.other_flag.value = document.frm.yotherFlag.options[otherFlagI].value;
				}
			}
			var zz = 0 ;
			var cTypeCode1 = 0 ;
			for(zz = 0 ; zz < document.frm.yloginFlag.length ; zz ++)
			{
				if(document.frm.yloginFlag.options[zz].selected)
				{
					cTypeCode1 = document.frm.yloginFlag.options[zz].type_value;
				}
			}
			var newCreateLoginNo;
		    if(!forDate(document.frm.yallowBegin)){
				rdShowMessageDialog("��ʼʱ���ʽ");
				return false;
			}
			if(!forDate(document.frm.yallowEnd)){
				rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ��");
				return false;
			}
			if(compareDates(document.frm.yallowBegin,document.frm.yallowEnd) != 0){
				rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ��");
				return false;
		    }
			document.frm.submitr.disabled=true;
			/***
				׼����ԭ��8002�½����Ź��ܻ����ϣ���ѭ�������½�
				�½�����list
				successWorkList���ɹ������б�
				failWorkList��ʧ�ܹ����б�
			*/
			
			
			var workList = $("#fileList").val();
			var workArr = workList.split(",");
			var submitFlag = true;
			showLightBox();
			$.each(workArr,function(i,n){
				var workInfoArr = n.split("|");
				var newWorkName = workInfoArr[0];
				var newWorkIccId = workInfoArr[1];
				var newWorkPasswd = workInfoArr[2];
				if(typeof(newWorkName) == "undefined"
					|| typeof(newWorkIccId) == "undefined"
					|| typeof(newWorkPasswd) == "undefined"){
						rdShowMessageDialog("�ϴ��ļ���ʽ���ڲ���ȷ������");
						submitFlag = false;
				}
				if(submitFlag){
					tempWorkInfo = new WorkInfo();
					tempWorkInfo.setWorkName(newWorkName);
					tempWorkInfo.setWorkIccid(newWorkIccId);
					tempWorkInfo.setWorkPassword(newWorkPasswd);
					tempWorkInfo.setAccountType($("select[@name='AccountType'] option[@selected]").text());
					tempWorkInfo.setYloginFlag($("select[@name='yloginFlag'] option[@selected]").text());
					tempWorkInfo.setPowerRight($("select[@name='ypowerRight'] option[@selected]").text());
					tempWorkInfo.setRptRight($("select[@name='yrptRight'] option[@selected]").text());
					tempWorkInfo.setAllowBegin(document.frm.yallowBegin.value);
					tempWorkInfo.setAllowEnd(document.frm.yallowEnd.value);
					tempWorkInfo.setExpireTime(document.frm.yexpireTime.value);
					tempWorkInfo.setOtherFlag(document.frm.other_flag.value);
					if(document.frm.AccountType.value == "1" || document.frm.AccountType.value == "4"){
						creatLoginNo();
						tempWorkInfo.setRegionName($("select[@name='yregionCode'] option[@selected]").text());
						tempWorkInfo.setDisName($("select[@name='ydisctrictCode'] option[@selected]").text());
						tempWorkInfo.setTownName($("select[@name='ytownCode'] option[@selected]").text());
					}else{
						groupIdChanged();
						tempWorkInfo.setRegionName("");
						tempWorkInfo.setDisName("");
						tempWorkInfo.setTownName("");
						checkAccountNo(document.frm.AccountType.value);
					}
					if(tempWorkInfo.getCreateFlag() == "1"){
						/*��ȡ�¹��ųɹ���*/
						if(cTypeCode1=="k"){
							document.frm.org_code.value="0000005"+document.frm.yorgNo.value;
						}
						else{
							document.frm.org_code.value = document.frm.region_code.value+
												document.frm.disctrict_code.value+
						    				document.frm.town_code.value+
						    				("" + tempWorkInfo.getWorkNo()).substring(4,6);
						}
						
						var myPacket = new AJAXPacket("newSubmit.jsp?loginName="+newWorkName+"&remark="+document.frm.yremark.value,"�����ύ�����Ժ�......");
						myPacket.data.add("workNo",document.frm.ywork_no.value);
						myPacket.data.add("nopass",document.frm.nopass.value);
						myPacket.data.add("opCode",document.frm.opCode.value);
						myPacket.data.add("opType",document.frm.op_type.value);
					//	myPacket.data.add("funcNo",document.frm.FuncNo.value);
						/**��仯��*/
						var tempAccountNo = tempWorkInfo.getAccountNo();
						if(typeof(tempAccountNo) == "undefined"){
							tempAccountNo = "";
						}
						myPacket.data.add("AccountNo",tempAccountNo);
					
						myPacket.data.add("groupId",document.frm.groupId.value);
						myPacket.data.add("AccountType",document.frm.AccountType.value);
						/**��仯��*/
						myPacket.data.add("loginNo",tempWorkInfo.getWorkNo());
						/***���֤��*/
						myPacket.data.add("contractPhoneNo",newWorkIccId);
						
						myPacket.data.add("loginFlag",document.frm.login_flag.value);
						/***��������*/
						myPacket.data.add("loginPass",newWorkPasswd);
						myPacket.data.add("powerCode",document.frm.power_code.value);
						myPacket.data.add("powerRight",document.frm.power_right.value);
						myPacket.data.add("rptRight",document.frm.rpt_right.value);
						myPacket.data.add("allowBegin",document.frm.yallowBegin.value);
						myPacket.data.add("allowEnd",document.frm.yallowEnd.value);
						myPacket.data.add("expireTime",document.frm.yexpireTime.value);
						myPacket.data.add("tryTimes",document.frm.ytryTimes.value);
						myPacket.data.add("maintainFlag",document.frm.maintain_flag.value);
						myPacket.data.add("validFlag",document.frm.valid_flag.value);
						myPacket.data.add("orgCode",document.frm.org_code.value);
						myPacket.data.add("deptCode",document.frm.ydeptCode.value);
						myPacket.data.add("lastIpAdd",document.frm.selfIpAddr.value);
						myPacket.data.add("reFlag",document.frm.re_flag.value);
						myPacket.data.add("otherFlag",document.frm.other_flag.value);
						myPacket.data.add("loginStatus",document.frm.login_status.value);
						myPacket.data.add("regionChar",document.frm.yotherFlag.value);
						/**��仯��*/
						myPacket.data.add("SEQ_MailCode",tempWorkInfo.getSeqMailCode());//20100317 add
						myPacket.data.add("reject_flag",document.frm.reject_flag.value);//diling add for ����������è�̳ǽ�פ׼��������֪ͨ@2014/3/10 
						myPacket.data.add("oaNumber",$("#oaNumber").val());//OA���
						myPacket.data.add("oaTitle",$("#oaTitle").val());//OA����
						
						core.ajax.sendPacket(myPacket);
						myPacket=null;
					}else{
						/*��ʧ���б������*/
						failWorkList.addWorkInfo(tempWorkInfo);
					}
				}
			});
			/**
			alert("�ɹ��б�");
			printList(successWorkList);
			alert("ʧ���б�");
			printList(failWorkList);
			***/
			rdShowMessageDialog('������������ɣ����������½��Ĺ�����Ϣ');
			rdShowMessageDialog("���γɹ�"+successWorkList.getLength()+"���������ɹ��б�");
			initTable();
			printTable(printTab);
			rdShowMessageDialog("����ʧ��"+failWorkList.getLength()+"��������ʧ���б�");
			initFailTable();
			printTable(printFailTab);
			hideLightBox();
			window.location.href="/npage/se940/fe940.jsp";
			
			return false;
		}
		function printList(workList){
			alert("������" + workList.getLength());
			for(var i = 0; i < workList.getLength(); i++){
				var workInfo = workList.getWorkInfo(i);
				alert(workInfo.getWorkName() + " , " + workInfo.getWorkIccid() + " : " + workInfo.getCreateNote());
			}
		}
		function uploadWorkNoList(){
			document.frm.target="hidden_frame";
	    document.frm.encoding="multipart/form-data";
	    document.frm.action="fe940_upload.jsp";
	    document.frm.method="post";
	    document.frm.submit();
	    document.frm.submitr.disabled=false;
		}
		function doSetWorkNoList(workList){
			rdShowMessageDialog("�ļ��ϴ��ɹ�","2");
			$("#uploadFile").attr("disabled","disabled");
			$("#workNoList").attr("disabled","disabled");
			$("#fileList").val(workList);
		}
		function select_groupId(){
			if(document.frm.AccountType.value == "2")
			{
				var path = "/npage/public/pubtree/grouptree.jsp?frmName=frm&groupId=groupId&groupName=groupName&serverType=USE&accType=2&selType=C";
			}
			else if(document.frm.AccountType.value == "3")
			{
				var path = "/npage/public/pubtree/grouptree.jsp?frmName=frm&groupId=groupId&groupName=groupName&serverType=USE&accType=3&selType=Z";
			}
			window.open(path,'_blank','height=600,width=300,scrollbars=yes');
		}
		function groupIdChanged(){
			var myPacket = new AJAXPacket("/npage/s8002/getAccountNo.jsp","�����ύ�����Ժ�......");
			myPacket.data.add("accType",document.frm.AccountType.value);
			myPacket.data.add("groupId",document.frm.groupId.value);
		
			core.ajax.sendPacket(myPacket);
			myPacket=null;
		}
		
		function checkAccountNo(opType){
			if(document.frm.AccountType.value.trim()=="2"){//ֻ�пͷ����Ų�У�鹤��ֻ��Ϊ����
						var patrn=/^\d\d\d\d\d\d$/;
						var patrnVal = patrn.test(tempWorkInfo.getAccountNo());
						if(!patrnVal){
								tempWorkInfo.setCreateNote("����Ӧ��Ϊ6λ����!");
								tempWorkInfo.setCreateFlag("0");
								return;
						}
			}
			if(document.frm.groupId.value.length==0)
			{
				tempWorkInfo.setCreateNote("������BOSS�ʺ���Ϣ����Ϊ��!");
				tempWorkInfo.setCreateFlag("0");
				return;
			}
			if(tempWorkInfo.getCreateFlag() == "1"){
				var myPacket = new AJAXPacket("fChkAccNo.jsp?accountNo="+tempWorkInfo.getAccountNo(),"�����ύ�����Ժ�......");
				myPacket.data.add("workNo",document.frm.ywork_no.value);
				myPacket.data.add("nopass",document.frm.nopass.value);
				myPacket.data.add("opCode",document.frm.opCode.value);
				myPacket.data.add("opType",opType);
				myPacket.data.add("groupId",document.frm.groupId.value);
			
				core.ajax.sendPacket(myPacket);
				myPacket=null;
			}
		}
		
		function initTable(){
			var insertStr = "<tr>";
			insertStr += "<td>�˻�����</td>";
			insertStr += "<td>����</td>";
			insertStr += "<td>����</td>";
			insertStr += "<td>Ӫҵ��</td>";
			insertStr += "<td>����</td>";
			insertStr += "<td>��������</td>";
			insertStr += "<td>��������</td>";
			insertStr += "<td>Ȩ��ֵ</td>";
			insertStr += "<td>����Ȩ��</td>";
			insertStr += "<td>��¼����ʱ��</td>";
			insertStr += "<td>��¼����ʱ��</td>";
			insertStr += "<td>���뵽��ʱ��</td>";
			insertStr += "<td>��������ʶ</td>";
			insertStr += "</tr>";
			$("#printTab").append(insertStr);
			for(var i = 0; i < successWorkList.getLength(); i++){
				insertStr = "<tr>";
				insertStr += "<td>"+successWorkList.getWorkInfo(i).getAccountType()+"</td>";
				insertStr += "<td>"+successWorkList.getWorkInfo(i).getRegionName()+"</td>";
				insertStr += "<td>"+successWorkList.getWorkInfo(i).getDisName()+"</td>";
				insertStr += "<td>"+successWorkList.getWorkInfo(i).getTownName()+"</td>";
				insertStr += "<td>"+successWorkList.getWorkInfo(i).getWorkNo()+"</td>";
				insertStr += "<td>"+successWorkList.getWorkInfo(i).getWorkName()+"</td>";
				insertStr += "<td>"+successWorkList.getWorkInfo(i).getYloginFlag()+"</td>";
				insertStr += "<td>"+successWorkList.getWorkInfo(i).getPowerRight()+"</td>";
				insertStr += "<td>"+successWorkList.getWorkInfo(i).getRptRight()+"</td>";
				insertStr += "<td>"+successWorkList.getWorkInfo(i).getAllowBegin()+"</td>";
				insertStr += "<td>"+successWorkList.getWorkInfo(i).getAllowEnd()+"</td>";
				insertStr += "<td>"+successWorkList.getWorkInfo(i).getExpireTime()+"</td>";
				insertStr += "<td>"+successWorkList.getWorkInfo(i).getOtherFlag()+"</td>";
				insertStr += "</tr>";
				$("#printTab").append(insertStr);
			}
		}
		function initFailTable(){
			var insertStr = "<tr>";
			insertStr += "<td>��������</td>";
			insertStr += "<td>���֤��</td>";
			insertStr += "<td>ʧ��ԭ��</td>";
			insertStr += "</tr>";
			$("#printFailTab").append(insertStr);
			for(var i = 0; i < failWorkList.getLength(); i++){
				insertStr = "<tr>";
				insertStr += "<td>"+failWorkList.getWorkInfo(i).getWorkName()+"</td>";
				insertStr += "<td>"+failWorkList.getWorkInfo(i).getWorkIccid()+"</td>";
				insertStr += "<td>"+failWorkList.getWorkInfo(i).getCreateNote()+"</td>";
				insertStr += "</tr>";
				$("#printFailTab").append(insertStr);
			}
		}
/***********************************************/
/***********************************************/
		
function FixWidth(selectObj)
{

	if (navigator.userAgent.toLowerCase().indexOf("firefox") > 0) {
		return;
	}

	var newSelectObj = document.createElement("select");
	newSelectObj = selectObj.cloneNode(true);
	newSelectObj.selectedIndex = selectObj.selectedIndex;
	newSelectObj.id="newSelectObj";
  
	var e = selectObj;
	var absTop = e.offsetTop;
	var absLeft = e.offsetLeft;
	while(e = e.offsetParent)
	{
	    absTop += e.offsetTop;
	    absLeft += e.offsetLeft;
	}
	with (newSelectObj.style)
	{
	    position = "absolute";
	    top = absTop + "px";
	    left = absLeft + "px";
	    width = "auto";
	}
   
	var rollback = function(){ RollbackWidth(selectObj, newSelectObj); };
	if(window.addEventListener)
	{
	    newSelectObj.addEventListener("blur", rollback, false);
	    newSelectObj.addEventListener("change", rollback, false);
	}
	else
	{
	    newSelectObj.attachEvent("onblur", rollback);
	    newSelectObj.attachEvent("onchange", rollback);
	}
	
	selectObj.style.visibility = "hidden";
	document.body.appendChild(newSelectObj);
	
	var newDiv = document.createElement("div");
	with (newDiv.style)
	{
	    position = "absolute";
	    top = (absTop-10) + "px";
	    left = (absLeft-10) + "px";
	    width = newSelectObj.offsetWidth+20;
	    height= newSelectObj.offsetHeight+20;;
	    background = "transparent";
	    //background = "green";
	}
	document.body.appendChild(newDiv);
	newSelectObj.focus();
	var enterSel="false";
	var enter = function(){enterSel=enterSelect();};
	newSelectObj.onmouseover = enter;
	
	var leavDiv="false";
	var leave = function(){leavDiv=leaveNewDiv(selectObj, newSelectObj,newDiv,enterSel);};
	newDiv.onmouseleave = leave;
}

function RollbackWidth(selectObj, newSelectObj)
{
    selectObj.selectedIndex = newSelectObj.selectedIndex;
    selectObj.style.visibility = "visible";
    if(document.getElementById("newSelectObj") != null){
       document.body.removeChild(newSelectObj);
    }
}

function removeNewDiv(newDiv)
{
	document.body.removeChild(newDiv);
}

function enterSelect(){
	return "true";
}

function leaveNewDiv(selectObj, newSelectObj,newDiv,enterSel){
	if(enterSel == "true" ){
		RollbackWidth(selectObj, newSelectObj);
		removeNewDiv(newDiv);
	}
}
		
	</script>
</head>
<body>
<form action="" method="post" name="frm">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�����½�����</div>
	</div>
	
		<TABLE cellspacing="0">
			<tbody>
				<tr >
					<td width="18%" nowrap class="blue"> &nbsp;�ʻ�����</td>
					<td colspan="3" nowrap>
						<select id=idAccType size=1 name=AccountType onchange="AccTypeChg()">
							<% for(int i = 0; i < acctypeArr.length; i++) {
							%>
								<option value="<%=acctypeArr[i][0]%>" <%if(acctypeArr[i][0].equals("1")){%> selected <%}%>> <%=acctypeArr[i][1]%> </option>
							<%
							}%>
						</select>
					</td>
					
				</tr>
			</tbody>
		</table>
		
		<table id="tbAccName" style="display:none"  cellSpacing=0>
			<tbody>
				<tr>
					<td width="18%" class="blue"> &nbsp;��֯�ṹ</td>
					<td width="32%">
						<input type="hidden" name="groupId" value="">
						<input type="text"  name="groupName"  v_must="1" v_type="string" value="" maxlength="60" readonly class="InputGrey">&nbsp;
						<input name="addButton" type="button" class="b_text" value="ѡ��" onClick="select_groupId()">
					</td>
					<td width="18%" nowrap id=tdAccType style="display:none" class="blue">&nbsp;�ͷ���BOSS�ʺ�</td>
					<td width="18%" nowrap id=tdFuncType class="blue">&nbsp;������BOSS�ʺ�</td>	
					<td width="32%" size=12 nowrap>
						<input type="hidden"  size=20 name=AccountNo value="" maxlength=6>
					</td>	
				</tr>
			</tbody>
		</table>
		
		<table id="tbRegion1" style="display" cellSpacing=0>
				<tr  type=hidden>
					<td width="18%" nowrap class="blue">&nbsp;�� &nbsp;&nbsp;&nbsp;��</td>
					<td width="32%" >
						<select id=part13 size=1 name=yregionCode onchange="ycallDisCode()"  >
							<%for(int i = 0 ; i < regionCodeResult.length; i ++){%>
								<option value="<%=regionCodeResult[i][0]%>" pvalue="<%=regionCodeResult[i][2]%>"
									<%if(regionCode.trim().equals(regionCodeResult[i][0])){%> selected <%}%>>
									<%=regionCodeResult[i][1]%>
								 </option>
							<%}%>
						</select>
					</td>
					<td width="18%" nowrap class="blue"> &nbsp;�� &nbsp;&nbsp;&nbsp;��</td>
					<td width="32%" >
						<div id=ydisCodeDiv >
							<select id=disCode size=1 name=ydisctrictCode onchange="ycallTownCode()" >
								<%-- <%for(int i = 0 ; i < disCodeInit.length ; i ++)
								{%>
									<option value="<%=disCodeInit[i][1]%>" pvalue="<%=disCodeInit[i][3]%>"
										<% if(dis_codeT.trim().equals(disCodeInit[i][1])){%> selected <%}%>>
										<%=disCodeInit[i][2]%>
									</option>
								<%}%> --%>
								<option value="02" pvalue="b">���� </option>
									<option value="03" pvalue="c">����</option>
							</select>
						</div>
					</td>
				</tr>
				<tr >
					<td width="18%" nowrap class="blue">&nbsp;Ӫ&nbsp;ҵ&nbsp;��</td>
					<td colspan="3">
						<div id=ytownCodeDiv>
						</div>
					</td>
				</tr>
		</table>
		
		<!------------------------------------------------------------------->
		<table id=tbs9  cellspacing=0>
			<tr>
				<td width="18%" class="blue">&nbsp;��������</td>
				<td>
					<select id=part3 size=1 name=yloginFlag  onchange="selectNoType()">
						<%-- <%for(int i = 0 ; i < loginTypeStr.length ; i ++){%>
							<option value="<%=loginTypeStr[i][0]%>" type_value="<%=loginTypeStr[i][2]%>">
								<%=loginTypeStr[i][1]%>
							</option>
						<%}%> --%>
						<option value="2" type_value="UnKnown">����ǩ��</option>
							<option value="3" type_value="UnKnown">����ƽ��</option>
					</select>
				</td>
			</tr>
		</TABLE>
		<table id="tbRegion2" cellSpacing=0>
				<tr>
					<td width="18%" nowrap class="blue">OA���</td>
					<td width="32%" >
						<input type="text" id="oaNumber" name="oaNumber" maxlength="30"/><font color="orange">*</font>
					</td>
					<td width="18%" nowrap class="blue">OA����</td>
					<td width="32%" >
						<input type="text" id="oaTitle" name="oaTitle" maxlength="30"/><font color="orange">*</font>
					</td>
				</tr>
		</table>
		<table>
			<tr>
				<td width="18%" class="blue">
					�������ŵ���
				</td>
				<td>
					<input type="file" name="workNoList" id="workNoList" class="button"
					style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
					&nbsp;&nbsp;
					<input type="button" name="uploadFile" id="uploadFile"
					class="b_text" value="�ϴ�" onclick="uploadWorkNoList()"/>
				</td>
			</tr>
			<tr>
				<td class="blue">
					�ļ���ʽ˵��
				</td>
        <td> 
            &nbsp;&nbsp; �ϴ��ļ��ı���ʽΪ����������|���֤��|�������롱��ʾ�����£�<br>
            <font class='orange'>
            	����|230102198001010001|abc123<br/>
            	����|230102198001010002|abc123<br/>
            	����|230102198001010003|abc123<br/>
            	����|230102198001010004|abc123
            </font>
            <b>
            <br>&nbsp;&nbsp; ע����ʽ�е�ÿһ�����������ڿո�,��ÿһ�������"|"�����ߣ�Ϊ�����������˼��ûس����С�ÿ�����50����
            </b> 
        </td>
	    </tr>
		</table>
		<div id=mainTable>			
			<TABLE cellSpacing=0>
				<TBODY>
					<tr  id="trPowerCode" style="display">
						<td width="18%" class="blue">&nbsp;��ɫ����</td>
						<td width="32%">
							<input type=text  v_type="string"  v_must=1  name=power_code  maxlength=10 size="10" readonly class="InputGrey">
							<input type=text  name=power_name size=24 maxlength=10 readonly class="InputGrey">
						</td>
						<td width="18%" >
							<input  type="button" name="query_powercode" class="b_text"onclick="queryPowerCode('frm')" value="ѡ��">
						</td>
						<td width="32%" > </td>
					</tr>
					<tr  style="display">
						<td width="18%" class="blue">&nbsp;Ȩ��ֵ</td>
						<td width="32%" >
							<select id=part7 size=1 name=ypowerRight  >
								<%
								for(int i = 0 ; i<powerRight.length; i ++)
								{ %>
									<option value="<%=powerRight[i][0]%>" > <%=powerRight[i][0]+"->"+powerRight[i][1]%> </option>
								<%
								}
								%>
							</select>
						</td>
						<td  width="18%" class="blue">����Ȩ��</td>
						<td width=32%">
							<select id=part8 size=1 name=yrptRight  >
							<%for(int i = 0 ; i < rptCode.length; i ++){%>
								<option value="<%=rptCode[i][0]%>" ><%=rptCode[i][1]%></option>
							<%}%>
							</select>
						</td>
					</tr>
				</TBODY>
			</TABLE>
			
			<TABLE   cellSpacing=0>
					<TBODY>
						<tr >
							<td width="18%" class="blue">&nbsp;��½����ʱ��</td>
							<td width="32%" >
								<input   id=part9  type=text size=20 name=yallowBegin value="<%=cuDate%>" v_format="yyyyMMdd HH:mm:ss"  onblur="forDate(this)">
								<input   id=part20 type=hidden size=2 name=allowBeginMonth>
								<input 1 id=part21 type=hidden size=2 name=allowBeginDate>
								<input 1 id=part22 type=hidden size=2 name=allowBeginHour>
								<input 1 id=part23 type=hidden size=2 name=allowBeginMinute>
								<input 1 id=part24 type=hidden size=2 name=allowBeginSecond>
							</td>
							<td width="18%"  class="blue">��½�������ʱ��&nbsp; </td>
							<td width="32%">
								<input  id=part10 type=text size=20 name=yallowEnd value="20500101 18:00:00"  v_format="yyyyMMdd HH:mm:ss" onblur="forDate(this)">
								<input 1 id=part25 type=hidden size=2 name=allowEndMonth>
								<input 1 id=part26 type=hidden size=2 name=allowEndDate>
								<input 1 id=part27 type=hidden size=2 name=allowEndHour>
								<input 1 id=part28 type=hidden size=2 name=allowEndMinute>
								<input 1 id=part29 type=hidden size=2 name=allowEndSecond>
							</td>
						</tr>
					</TBODY>
			</TABLE>
			
			<TABLE  cellSpacing=0>
				<TBODY>
					<tr >
						<td width="18%" class="blue">&nbsp;���뵽��ʱ��</td>
						<td width="32%" >
							<input  id=part11 type=text size=20 name=yexpireTime value="<%=dateString%>" readonly class="InputGrey" v_format="yyyyMMdd HH:mm:ss">
							<input 1 id=part30 type=hidden size=2 name=expireTimeMonth>
							<input 1 id=part31 type=hidden size=2 name=expireTimeDate>
							<input 1 id=part32 type=hidden size=2 name=expireTimeHour>
							<input 1 id=part33 type=hidden size=2 name=expireTimeMinute>
							<input 1 id=part34 type=hidden size=2 name=expireTimeSecond>
						</td>
						<td width="18%"  class="blue">��ǰ��½����</td>
						<td width="32%">
							<input  id=part12 type=text size=20 name=ytryTimes readOnly class="InputGrey" value="">
						</td>
					</tr>
				</TBODY>
			</TABLE>
		
			<TABLE cellSpacing=0>
				<TBODY>
					<tr>
						<td width="18%" class="blue">&nbsp;������Ч��־</td>
						<td width="16%" >
							<input id=radio1 type=radio name=yvalidFlag value=1  checked >��Ч
						</td>
						<td width="16%" >
							<input id=radio1 type=radio  name=yvalidFlag value=0 > &nbsp; ��Ч
						</td>
	 					<td width="18%" class="blue">ϵͳά����־&nbsp; </td>
	 					<td width="16%">
	 						<input id=radio type=radio name=ymaintainFlag value=1> &nbsp; ά������
						</td>
	 					<td width="16%">
	 						<input id=radio type=radio name=ymaintainFlag value=0  checked > &nbsp; ��ά������
						</td>
					</tr>
				</TBODY>
			</TABLE>
			
			<TABLE  cellSpacing=0>
				<TBODY>
					<tr>
						<td width="18%" class="blue">&nbsp;������������</td>
						<td>
							<input  id=part15 type=text size=20 name=ydeptName value=""  maxlength=5 title="�����ı���ѡ�񹤵���������" onclick="getDptCode()" readonly class="InputGrey">
							<input type=hidden name=ydeptCode value="">
						</td>			
					</tr>
				</TBODY>
			</TABLE>
		
			<TABLE  cellSpacing=0>
				<TBODY>
					<tr >
						<td width="18%" class="blue">&nbsp;�ϴε�½IP��ַ</td>
						<td width="32%">
							<input  id=part16 type=text size=16 name=ylastIpAdd value="0.0.0.0">
						</td>
						<td width="18%" class="blue">��������־</td>
						<td width="32%">
							<select name=yotherFlag id=part35>
							    	<option value="N" >������</option>
							    	<option value="Y" >����</option>
							</select>
						</td>
					</tr>
				</TBODY>
			</TABLE>
		
			<TABLE  cellSpacing=0>
				<TBODY>
					<tr>
						<td width="18%" class="blue">&nbsp;�ظ���½��־</td>
						<td width="32%" >
							<select name=yreFlag id=part17  >
								<option value="1" >������</option>
								<option value="0" >����</option>
							</select>
						</td>
						<td width="18%">&nbsp;</td>
						<td width="32%">
							<select name=yloginStatus id=part18  style="display:none'">
								<option value="1" >ǩ��</option>
								<option value="2" >ǩ��</option>
							</select>
						</td>
					</tr>
				</TBODY>
			</TABLE>
			
			<TABLE  cellSpacing=0>
				<TBODY>
					<tr>
						<td width="18%" class="blue">&nbsp;���Ų�����ʵ�ձ������޳�</td>
						<td colspan="3" >
							<select name="reject_flag" id="part36"  >
								<option value="0" >��</option>
								<option value="1" >��</option>
							</select>
						</td>
					</tr>
				</TBODY>
			</TABLE>
		
		
			<table  cellspacing="0" >				
				<tr>
					<td  width="18%" class="blue">&nbsp;��ע</td>
					<td>
						<input  id=part19 type=text size=88 name=yremark value="" readOnly class="InputGrey">
					</td>
				</tr>
			</table>
		
			<TABLE  cellSpacing=0>
				<TBODY>
					<TR>
						<TD id="footer">
							<input  name=submitr  class="b_foot" type=button value="ȷ��" onclick="submitt()" id=Button1>&nbsp;&nbsp;
							<input  name=back1  class="b_foot" type=button value=�ر� id=Button2 onclick="removeCurrentTab()">
						</TD>
					</TR>
				</TBODY>
			</TABLE>			
	<div>
		<table id="printTab" name="printTab" style="display:none;">
		</table>
		<table id="printFailTab" name="printFailTab" style="display:none;">
		</table>
	</div>
	<!-- ���ر����֣�Ϊ��һҳ�洫���� -->
	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" id="opName" value="<%=opName%>" />
	<input  id=part14  type=hidden size=10 name=yorgNo value="00"  >
	<input type=hidden name=op_type value="0">
	<input type=hidden name=ywork_no value="<%=sWorkNo%>">
	<input type=hidden name=nopass value="<%=dNopass%>">
	<input type=hidden name=login_flag value="">
	<input type=hidden name=power_right value="">
	<input type=hidden name=rpt_right value="">
	<input type=hidden name=valid_flag value="">
	<input type=hidden name=maintain_flag value="">
	<input type=hidden name=orgCode value="">
	<input type=hidden name=region_code value="">
	<input type=hidden name=disctrict_code value="">
	<input type=hidden name=town_code value="">
	<input type=hidden name=org_code value="">
	<input type=hidden name=re_flag value="">
	<input type=hidden name=other_flag value="">
	<input type=hidden name=login_status value="">
	<input type=hidden name=inValidLoginNo value="">
	<input type=hidden name=selfIpAddr value="<%=request.getRemoteAddr()%>">
	<input type=hidden name=SEQ_MailCode value="">
	<input type=hidden name="printAccept" value="<%=printAccept%>">
	<input type="hidden" name="fileList" id="fileList" />
	<input type="hidden" name="ajaxCreateWorkFlag" id="ajaxCreateWorkFlag" value="1" />
	<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
<script>

/************sunwt add for popedom end *************/
<%
if(accountType.equals("2"))
{
%>
	document.frm.AccountType.disabled = true;
	document.frm.AccountType.value = "2";
	AccTypeChg();

	//document.getElementById("tabhead4").style.display = "none";
<%
}
%>
</script>