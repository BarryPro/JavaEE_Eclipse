  
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.*"%>
<%@ page import="java.security.*" %>
<%@ page import="javax.crypto.*;" %>
<%@ page import="com.sitech.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
/*
* ����: �����Դ��ѯ
* �汾: 1.0
* ����: 2010-11-2
* ����: lijy
* ��Ȩ: sitech
*/
%>

<%!
 
 //���·���Ϊ���ܷ���
private String encrypt11111(String host){
	if (host==null || "".equals(host)){
		return ""; 
	}
	try{
		Cipher encryptCipher = null;
		String strDefaultKey = "crmuk012";
		//Security.addProvider(new com.sun.crypto.provider.SunJCE());
		Key key = getKey(strDefaultKey.getBytes());

		encryptCipher = Cipher.getInstance("DES");
		encryptCipher.init(Cipher.ENCRYPT_MODE, key);

		return byteArr2HexStr(encryptCipher.doFinal(host.getBytes()));
	}
	catch(Exception e){
		e.printStackTrace();
		return "";
	}
}

private static String byteArr2HexStr(byte[] arrB) throws Exception {
	int iLen = arrB.length;
	//ÿ��byte�������ַ����ܱ�ʾ�������ַ����ĳ��������鳤�ȵ�����
	StringBuffer sb = new StringBuffer(iLen * 2);
	for (int i = 0; i < iLen; i++) {
		int intTmp = arrB[i];
		//�Ѹ���ת��Ϊ����
		while (intTmp < 0) {
			intTmp = intTmp + 256;
		}
		//С��0F������Ҫ��ǰ�油0
		if (intTmp < 16) {
			sb.append("0");
		}
		sb.append(Integer.toString(intTmp, 16));
	}
	return sb.toString();
}

private Key getKey(byte[] arrBTmp) throws Exception {
	//����һ���յ�8λ�ֽ����飨Ĭ��ֵΪ0��
	byte[] arrB = new byte[8];
	//��ԭʼ�ֽ�����ת��Ϊ8λ
	for (int i = 0; i < arrBTmp.length && i < arrB.length; i++) {
		arrB[i] = arrBTmp[i];
	}
	//������Կ
	Key key = new javax.crypto.spec.SecretKeySpec(arrB, "DES");
	return key;
}

%>

<%!
/*2014/12/30 14:27:32 gaopeng ��ͨ�ں���Ŀ �ۺ��ʹ���PBOSS�ӿڹ淶-�� ��smCode������ת������ԭ����kf ke kg��Ϊ���ִ���
	����дһ�������������ض�Ӧ���ַ���
*/
public String retSmCodeNewRule(String smCodeIn){
	String retStr = "";
	/*�ƶ��Խ����ƶ��Խ���& ����(�ƶ��Խ�)*/
	if("kf".equals(smCodeIn)){
		retStr = "1$2$5$6";
	}
	if("ki".equals(smCodeIn)){
		retStr = "1$6";
	}
	/*�ƶ��Ͻ�����ͨЭͬ��*/
	if("kd".equals(smCodeIn)){
		retStr = "2";
	}
	/*ʡ���*/
	if("kg".equals(smCodeIn)){
		retStr = "3";
	}
	/*�����*/
	if("ke".equals(smCodeIn)){
		retStr = "4";
	}
	/*��ͨ����ͨ���У�*/
	if("kh".equals(smCodeIn)){
		retStr = "5";
	}
	return retStr;
}



%>

<%
	System.out.println("==============��Դ��ѯ����=============== ");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
  String opCode = request.getParameter("opCode");
  String smCode = (String)request.getParameter("smCode") == null ? "" : (String)request.getParameter("smCode") ;
  String workNo = (String)session.getAttribute("workNo");
  String nopass = (String) session.getAttribute("password");/*����Ա����*/
  String groupId = (String) session.getAttribute("groupId");//���ش���
  System.out.println("gaopengSeeLog===regionCode========="+regionCode + " opCode=[" + opCode + "] smCode=[" + smCode +"]");
   String strSql = "select region_name from sregioncode where region_code='"+regionCode+"'";
	String regionName="";
	
	String opName="�����Դ��ѯ";
	
	String loginName=workNo;
	 
	 String loginName_jiami = encrypt11111("10086"+loginName);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
	<wtc:sql><%=strSql%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="result" scope="end" />	
<%
if(!retCode2.equals("000000")){
%>
   <script language="javascript">
   	  rdShowMessageDialog("��ѯ�������ƴ���,�������:<%=retCode2%><br>������Ϣ:<%=retMsg2%>");
   	  parent.removeTab('<%=opCode%>');
	</script>
<%	
}else{
	regionName=result[0][0];
}
%>
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�����Դ��ѯ</title>
<style>
	html,
	body
	{
		overflow-x:hidden
	}
</style>
<script language="javascript" type="text/javascript">

var submitFlag=true;
var jituanFlag=true;
var preReturn="0%";
var preReturn="0%";
var queRes="0";
var areaPageCon = 10;
var standAddrCon = 10;
$(function () {
	$("#isse276",window.parent.document).val("0");
	$("#userareaName").val("");
});

function gisMapBtn(){
			if(document.all.area_name.value==""){
		  	rdShowMessageDialog("С�����Ʋ���Ϊ�գ�������");
		  	document.all.area_name.focus();
		  	return false;
	  	}
	  	var area_name = document.all.area_name.value.trim();
			var acName = "GIS��ͼ";
			var iWidth = window.screen.availWidth-100; //�������ڵĿ��;
			var iHeight = window.screen.availHeight-100; //�������ڵĸ߶�;
			var iTop = "70";
			var iLeft ="240";
			var acPath = "";
			var param = "";
			var flag = "5";
			var iLoginNo = "<%=workNo%>";
			acPath = encodeURI("http://10.110.180.71:9801/NcGisCRM.aspx?Kfuser="+iLoginNo+"&Pass=<%=loginName_jiami%>&phonenum=&typecode=2&city="+"<%=regionName%>"+"&addr="+area_name);
			
			//alert(acPath);
			window.open(acPath,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=yes');
			
		}
		
function getAreaInfo()
{
		$("#recordInfos").hide() ;
		$("#userName").val("");
		$("#contractPhone").val("");
		$("#userareaName").val("");
		$("#description").val("");
		$("#userareaName2").val("");
		$("#userareaCode2").val("");
		$("#ownerShipBut").attr("disabled","disabled");
		
		var markDiv=$("#showTab2"); 
		markDiv.empty();
		
	  if(document.all.area_name.value==""){
	  	rdShowMessageDialog("С�����Ʋ���Ϊ�գ�������",2);
	  	document.all.area_name.focus();
	  }else{
	  	removeAreaInfo();
	  	removeStandardAddr();
	  	removeAreaResource();
		var myPacket = new AJAXPacket("ajax_getAreaInfo.jsp", "���ڻ�ȡ�����Ժ�......");
				myPacket.data.add("area_name", document.all.area_name.value);
				myPacket.data.add("regionName", "<%=regionName%>" );
				/*2014/12/30 14:39:37 ��ͨ�ں���Ŀ gaopeng ��smCode����ת��*/
				myPacket.data.add("smCode", "<%=retSmCodeNewRule(smCode)%>" );
				core.ajax.sendPacket(myPacket,doGetAreaInfo);
				myPacket = null;
			}
}
var areaStr="";
var colFlag="N";
function doGetAreaInfo(packet)
{
	areaStr="";
	var retCode = packet.data.findValueByName("retCode");
  	var retMsg = packet.data.findValueByName("retMessage");
  
	if(retCode=="000000"){	
	     var	result= packet.data.findValueByName("result");
	     //alert(result);
	   	 var temp1=result.split(",");
	   	 var temp2=temp1[2].split("=");
	     var  retLines=temp2[1].split("#");
	     $("#areaListBody").empty();
	     
	     for(var i=0;i<retLines.length;i++)
	     {
	    	 	colFlag="Y";
	     	   var retLine=retLines[i].split("%");	
	     	   
	     	  // alert(retLine[0]+"--"+retLine[1]+"--"+retLine[2]+"--"+retLine[3]);
	     		 if(!(retLine[0]=="1") && !(retLine[0]=="2")){
	     		 	      preReturn="1%";
	     		 	      document.getElementById("areaInfo").style.display="";
	     		 	      var showText = "";
	     		 	      var defaultDCode = "";
	     		 	      /*
	     		 	      if(retLine[4] == "0"){
	     		 	      	showText = "��ͨPON";
	     		 	      }else if(retLine[4] == "1"){
	     		 	      	showText = "��ͨAD";
	     		 	      	defaultDCode = "1";
	     		 	      }if(retLine[4] == "2"){
	     		 	      	showText = "���";
	     		 	      	defaultDCode = "1";
	     		 	      }*/
	     		 	      if(retLine[2] == "0"){
	     		 	      	showText = "����";
	     		 	      	defaultDCode = "1";
	     		 	      }else if(retLine[2] == "1"){
	     		 	      	showText = "XDSL";
	     		 	      	defaultDCode = "1";
	     		 	      }else if(retLine[2] == "2"){
	     		 	      	showText = "FTTH";
	     		 	      	defaultDCode = "1";
	     		 	      }else if(retLine[2] == "3"){
	     		 	      	showText = "FTTB";
	     		 	      	defaultDCode = "1";
	     		 	      }else if(retLine[2] == "4"){
	     		 	      	showText = "CABLE";
	     		 	      	defaultDCode = "1";
	     		 	      }else if(retLine[2] == "5"){
	     		 	      	showText = "WBS";
	     		 	      	defaultDCode = "1";
	     		 	      }else if(retLine[2] == "6"){
	     		 	      	showText = "������Դ";
	     		 	      	defaultDCode = "1";
	     		 	      }else{
	     		 	      	showText = "����";
	     		 	      	defaultDCode = "1";
	     		 	      }
	                //$("#areaListBody").append("<tr style='cursor:pointer;' onclick='setRadio("+i+")'><td style=\"display:none;\"><input type=radio style=\"display:none;\" onclick='choseAreaInfo()' id='doType1' name='doType1' RIndex1=" +i+ " value="+ i + "></td><td><input type='hidden'   name=areaName"+i+" value="+retLine[0]+">"+retLine[0]+"</td><td style='display:none'><input type='hidden'   name=areaCode"+i+" value="+retLine[1]+">"+retLine[1]+"</td><td><input type='hidden'  name=areaAddr"+i+" value="+retLine[2]+">"+retLine[2]+"</td><td><input type='hidden'  name=bandWidth"+i+" value="+retLine[3]+">"+retLine[3]+"</td><td><input type='hidden'  name=enterType"+i+" value="+retLine[4]+">"+showText+"</td><td><input type='text' name=dCode"+i+" value='"+defaultDCode+"' /><input type='button' name='search' onclick='getStandardAddr("+i+")' value='��ѯ' class='b_text'/></td></tr>");
	                /*2013/2/27 ������ 13:55:05 gaopeng sGetAreaInfo ���񷵻��ַ���ƴ��  ���� stationCode ���žֱ��� �� partnerCode ����������*/
	                
	                //С������
	                var distKdCode = retLine[5];
	                //С���������
	                var nearInfo = retLine[6];
	                //С����������
	                var propertyUnit = retLine[7];
	                var propertyUnitShowText = "";
	              	if(propertyUnit == "1"){
	              		propertyUnitShowText = "�ƶ��Խ�";
	              	}else if(propertyUnit == "2"){
	              		propertyUnitShowText = "�ƶ��Ͻ�";
	              	}else if(propertyUnit == "3"){
	              		propertyUnitShowText = "ʡ���";
	              	}else if(propertyUnit == "4"){
	              		propertyUnitShowText = "�����";
	              	}else if(propertyUnit == "5"){
	              		propertyUnitShowText = "��ͨ";
	              	}else if(propertyUnit == "6"){
	              		propertyUnitShowText = "����";
	              	}
	              	//20161205 liangyl���� ����=2 ö��ֵ
	                //������� 0����1ũ��2����
	                var belongCategory = retLine[8];
	                var belongCategoryShowText="";
	                if(belongCategory==0){
	                	belongCategoryShowText="����";
	                }
	                else if(belongCategory==1){
	                	belongCategoryShowText="ũ��";
	                }
	                else if(belongCategory==2){
	                	belongCategoryShowText="����";
	                }
	                //���ط�ʽ 0����1����
	                var bearType = retLine[9];
	                var bearTypeShowText = bearType == 0 ? "����" : "����";
	                
	                var insertStr = "";
	                insertStr += "<tr style='cursor:pointer;' onclick='setRadio("+i+")'><input type='hidden'  name=nearInfo"+i+" value="+nearInfo+"><input type='hidden'  name=belongCategory"+i+" value="+belongCategory+">";
	                insertStr += "<td style=\"display:none;\"><input type=radio style=\"display:none;\" onclick='choseAreaInfo()' id='doType1' name='doType1' RIndex1=" +i+ " value="+ i + "></td>";
	                insertStr += "<td style=\"display:none;\"><input type='hidden'   name=areaCode"+i+" value="+retLine[1]+">"+retLine[1]+"</td>";
	                insertStr += "<td><input type='hidden'  name=distKdCode"+i+" value="+distKdCode+">"+distKdCode+"</td>";
	                insertStr += "<td><input type='hidden'  name=areaAddr"+i+" value="+retLine[0]+">"+retLine[0]+"</td>";
	                areaStr+=retLine[0]+",";
	                insertStr += "<td><input type='hidden'  name=enterType"+i+" value="+retLine[2]+">"+showText+"</td>";
	               /*  insertStr += "<td><input type='hidden'  name=nearInfo"+i+" value="+nearInfo+">"+nearInfo+"</td>"; */
	                insertStr += "<td><input type='hidden'  name=propertyUnit"+i+" value="+propertyUnit+">"+propertyUnitShowText+"</td>";
	                /* insertStr += "<td><input type='hidden'  name=belongCategory"+i+" value="+belongCategory+">"+belongCategoryShowText+"</td>"; */
	                insertStr += "<td><input type='hidden'  name=bearType"+i+" value="+bearType+">"+bearTypeShowText+"</td>";
	                insertStr += "<td><input type='text' name='buildNo"+i+"' size='4'/></td>";
	                insertStr += "<td><input type='text' name='unitNo"+i+"' size='4'/></td>";
	                insertStr += "<td>";
	                insertStr += "<input type='hidden' name=dCode"+i+" value='"+defaultDCode+"' /><input type='hidden' name=stationCode"+i+" value='"+retLine[3]+"' /><input type='hidden' name=partnerCode"+i+" value='"+retLine[4]+"' />";
	                insertStr += "<input type='button' name='search' onclick='getStandardAddr("+i+")' value='��ѯ' class='b_text'/>";
	                insertStr += "</td>";
	                insertStr += "</tr>";
	                $("#areaListBody").append(insertStr);
	                
	                /**
	                $("#areaListBody").append("<tr style='cursor:pointer;' onclick='setRadio("+i+")'><td style=\"display:none;\"><input type=radio style=\"display:none;\" onclick='choseAreaInfo()' id='doType1' name='doType1' RIndex1=" +i+ " value="+ i + "></td><td style='display:none'><input type='hidden'   name=areaCode"+i+" value="+retLine[1]+">"+retLine[1]+"</td><td><input type='hidden'  name=areaAddr"+i+" value="+retLine[0]+">"+retLine[0]+"</td><td><input type='hidden'  name=enterType"+i+" value="+retLine[2]+">"+showText+"</td><td><input type='text' name=dCode"+i+" value='"+defaultDCode+"' /><input type='hidden' name=stationCode"+i+" value='"+retLine[3]+"' /><input type='hidden' name=partnerCode"+i+" value='"+retLine[4]+"' /><input type='button' name='search' onclick='getStandardAddr("+i+")' value='��ѯ' class='b_text'/></td></tr>");
	                **/
	         }else{
	         	rdShowMessageDialog("û�в�ѯ����С��");
	         }
	     }
	     areaStr=areaStr.substring(0,areaStr.length-1);
	     //alert(areaStr);
	     splitPage($("#areaInfo"));
	}else if(retCode=="202" || retCode=="203"){
		rdShowMessageDialog("�Բ���������Ĳ�ѯ������Χ̫���뾫ȷ�ؼ��ʺ��ѯ");	
		return false;
	}else{   
	   		rdShowMessageDialog(retMsg);
	   		return false;
	}
}

function splitPage(divObj){
	var nowPage = Number(divObj.find("span[name='nowPage']").html());
	var tbodyObj = $(divObj.find("tbody")[1]);
	var allCon = tbodyObj.find("tr").length;
	var allPage = Math.floor((allCon - 1) / areaPageCon) + 1;
	divObj.find("span[name='allPage']").html(allPage);
	divObj.find("span[name='nowPage']").html(nowPage);
	divObj.find("span[name='allCon']").html(allCon);
	
	var startLine = (nowPage - 1) * areaPageCon;
	var endLine = startLine + areaPageCon - 1;
	tbodyObj.find("tr").show();
	tbodyObj.find("tr:lt("+startLine+")").hide();
	tbodyObj.find("tr:gt("+endLine+")").hide();
}

function goPage(goType,ctrlObj){
	var divObj = $(ctrlObj).parent();
	var nowPage = Number(divObj.find("span[name='nowPage']").html());
	var allPage = Number(divObj.find("span[name='allPage']").html());
	if(goType == 'f'){
		if(nowPage == 1){
			return false;
		}else{
			divObj.find("span[name='nowPage']").html(1);
		}
	}else if(goType == 'e'){
		if(nowPage == allPage){
			return false;
		}else{
			divObj.find("span[name='nowPage']").html(allPage);
		}
	}else if(goType == 'p'){
		if(nowPage == 1){
			return false;
		}else{
			divObj.find("span[name='nowPage']").html(nowPage-1);
		}
	}else if(goType == 'n'){
		if(nowPage == allPage){
			return false;
		}else{
			divObj.find("span[name='nowPage']").html(nowPage+1);
		}
	}
	splitPage(divObj.parent());
}

function setRadio(i){
	
	$("#areaList :input[type='radio']:eq(" + i + ")").attr("checked","checked");
	choseAreaInfo(i);
}
//С����Ϣѡ�� /*2013/2/27 ������ 14:10:46 gaopeng С����Ϣѡ�񣬸�������ֵ���������������� 1�����žֱ��� 2.����������*/
function choseAreaInfo(m)
{
	$("#areaList tr").css("background-color","white");//�������е�ɫ��Ϊ��ɫ
	for(var i=0;i<$("#areaList tr").length-1;i++)
	{ 
		var dCodeNu="dCode"+i;
		//$("#areaList :input[name='dCodeNu']").val("");
		if(m != i){
			document.all(dCodeNu).value="";//��ԭ��¥�ŵ������ÿ�	
		}
		if ($("#areaList :input[type='radio']").attr("name")=="doType1")
		{   
			if($("#areaList :input[type='radio']").get(i).checked==true)
			{ 
				$("#areaList tr:eq('" + (i+1) + "')").css("background-color","#CADFFE");//��ѡ����б�����ɫ
				//�ж��Ƿ�ѡ��
				rIndex = i;
				objCode0 = "areaName" + rIndex ;
				objCode1 = "areaCode" + rIndex ;
				objCode2 = "areaAddr" + rIndex ;
				objCode4 = "bandWidth" + rIndex ;
				/*��������*/
				objCode5 = "enterType" + rIndex ;
				objCode6= "dCode" + rIndex ;	
				/*2013/2/27 ������ 14:14:02 gaopeng  ���žֱ���*/	
				objCode7 ="stationCode" +	rIndex;
				/*2013/2/27 ������ 14:14:02 gaopeng  ����������*/	
				objCode8 ="partnerCode" +	rIndex; 	
				/*2014/04/03 10:59:41 gaopeng �������*/
				objCode9 = "belongCategory" +	rIndex;
				/*2014/04/03 10:59:41 gaopeng ���ط�ʽ*/
				objCode10 = "bearType" +	rIndex;
				objCode11 = "propertyUnit" +	rIndex;/* С���������� */
				objCode12 = "distKdCode" +	rIndex;/* С������ */
				objCode13 = "nearInfo" +	rIndex;/* С��������� */
				

				
				document.all.area_nameh.value="";//С������
				document.all.area_codeh.value=document.all(objCode1).value;//С������
				document.all.areaAddr.value=document.all(objCode2).value;//С����ַ
				document.all.bandWidth.value="";//����
				document.all.enter_type.value=document.all(objCode5).value;//�������� (��������)
				document.all.cctId.value=document.all(objCode7).value;//���žֱ���
				//document.all.cctId.value="80045";//���žֱ���
				document.all.partnerCode.value=document.all(objCode8).value;//����������
				/*2014/04/03 10:59:17 gaopeng �������������� ������� ���ط�ʽ*/
				document.all.belongCategory.value=document.all(objCode9).value;//����������
				document.all.bearType.value=document.all(objCode10).value;//����������
				
				document.all.propertyUnit.value=document.all(objCode11).value;//С����������
				
				document.all.distKdCode.value=document.all(objCode12).value;//С����������
				document.all.nearInfo.value=document.all(objCode13).value;//С����������
				
				
				
				
				//document.all.partnerCode.value="1100000000";//����������
				//document.all.dCode.value=$(bt).parent().parent().find("td:eq(6)").find("input").val();//¥��
				//alert(document.all.area_nameh.value+" "+document.all.area_codeh.value+" "+document.all.areaAddr.value+" "+document.all.bandWidth.value+" "+document.all.enter_type.value);
			}
		}
	}
}
//��ȡ��׼��ַ
/*2013/2/27 ������ 14:19:22 gaopeng sGStandAddr ���񷵻�ƴ�� */
function getStandardAddr(i)
{
	$("#recordInfos").hide() ;
	$("#userName").val("");
	$("#contractPhone").val("");
	$("#userareaName").val("");
	$("#description").val("");
	$("#userareaName2").val("");
	$("#userareaCode2").val("");
	
	var markDiv=$("#showTab2"); 
	markDiv.empty();
		
	setRadio(i);
	$("#areaList :input[type='radio']:eq(" + i + ")").attr("checked","checked");
	var distKdCode;
	var areaAddr;
	var dCode;//¥��
	var connectType;//��������
	var buildNoVal;
	var unitNoVal;
	var propertyUnitVal;//С����������
	/* �Ƿ��������Ʒ����С��������Ҫ���� */
	var conFlag = true;
	$("#areaList :input[type='radio']").each(function(i,n){
		if(this.checked)
		{
			distKdCode=$(n).parent().parent().find("td").find("input[name^='distKdCode']").val();
			$("#userareaCode2").val(distKdCode);
			areaAddr=$(n).parent().parent().find("td").find("input[name^='areaAddr']").val();
			$("#userareaName2").val(areaAddr);
			dCode=$(n).parent().parent().find("td").find("input[name^='dCode']").val();
			$("#ownerShipBut").attr("disabled","");
			
			//enterType
			connectType=$(n).parent().parent().find("td").find("input[name^='enterType']").val();
			
			//¥��  buildNo
			buildNoVal = $(n).parent().parent().find("td").find("input[name^='buildNo']").val();
			//��Ԫ��  unitNo
			unitNoVal = $(n).parent().parent().find("td").find("input[name^='unitNo']").val();
			propertyUnitVal = $(n).parent().parent().find("td").find("input[name^='propertyUnit']").val();
			/**
		//alert("dCode======"+dCode);
			alert("connectType======"+connectType + " smcode " + "<%=smCode%>");
			//alert("buildNoVal= " + buildNoVal + "   unitNoVal= " + unitNoVal);
			**/
			/*** 	0-pon ���ǿ���ͨ�� ��
						1-��ͨad ��ʾ�û�ȥ��ͨӪҵ������ �� 
						������ˣ�֧��ADSL�ˡ�ningtn
						2-��� ���ǿ�����  
			**/
			if("<%=opCode%>" !="e276"&&"<%=opCode%>" !="m462"){
				/*2014/11/19 10:48:52 gaopeng
					�޸�ԭ���߼���ȫ���滻ΪС������������Ʒ�ƽ��жԱȣ���һ������ʾ��Ϣ
				*/
				var ppName = retPPName(propertyUnitVal);
				if($.trim("<%=retSmCodeNewRule(smCode)%>").indexOf($.trim(propertyUnitVal)) == -1){
					rdShowMessageDialog("��ѡ���С��ֻ�ܿ�ͨС����������Ϊ"+ppName);
					conFlag = false;
					window.close();
				}
				/*
				if(connectType == "0" && "<%=smCode%>" != "kd"||&& "<%=smCode%>" != "IM"){
					rdShowMessageDialog("��ѡ���С��ֻ�ܿ���ͨƷ�ƵĿ��");
					conFlag = false;
					window.close();
				}
				*/
				/*else if(connectType == "1" && "<%=smCode%>" != "kf"){
					rdShowMessageDialog("��ѡ���С��ֻ�ܿ��ƶ����");
					conFlag = false;
					window.close();
				}*/
				/*else if(connectType == "2" && "<%=smCode%>" != "ke"){
					rdShowMessageDialog("��ѡ���С��ֻ�ܿ����Ʒ�ƵĿ��");
					conFlag = false;
					window.close();
				*/
				/* 
			   * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
			   * ����ʡ���kg������Ʒ��kh��������kg��ͬ��ֻ����Դ��ѯʱ��������Ϊ��9����
			   */
			   /*
				}else if(connectType == "9" && "<%=smCode%>" != "kh" ){
					rdShowMessageDialog("��ѡ���С��ֻ�ܿ�khƷ�ƵĿ��");
					conFlag = false;
					window.close();
				}
				if(connectType == "1" && "<%=smCode%>" == "kf" ){
					if( propertyUnitVal == "���"){
						rdShowMessageDialog("��ѡ���С��ֻ�ܿ�С����������Ϊ�ǹ��Ʒ�ƵĿ��");
						conFlag = false;
						window.close();
					}
				}
				if(connectType == "1" && "<%=smCode%>" == "kg" ){
					if(propertyUnitVal != "���"){
						rdShowMessageDialog("��ѡ���С��ֻ�ܿ�С����������Ϊ���Ʒ�ƵĿ��");
						conFlag = false;
						window.close();
					}
				}
				*/
				
			}
			
		}
	});
	if(conFlag){
		var AreaCode=document.all.area_codeh.value;
		if(AreaCode=="" ||AreaCode==null )
		{
			rdShowMessageDialog("��û��ѡ��С������ѡ��һ��");
			return false;
		} 
		/* ע�͵���¥��Ϊ��Ҳ���Բ�ѯ
		if(dCode<1 || dCode>100 || dCode==null || dCode=="" )
		{
			 rdShowMessageDialog("����¥�Ų���ȷ������������",1);
				return false;
		}else{*/
			document.all.dCode.value=dCode;
		/*}*/
		
		
		if("<%=opCode%>" =="e276"){	
			//alert("e276��ȡ");
				var myPacketss = new AJAXPacket("ajax_queryofferid.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
				myPacketss.data.add("xiaoqudaima",AreaCode);	
				myPacketss.data.add("offeridss","");	
				myPacketss.data.add("oprtypes","1");
				myPacketss.data.add("statess","B");
				myPacketss.data.add("opflag","1");
				myPacketss.data.add("propertyUnitVal",propertyUnitVal);
				core.ajax.sendPacketHtml(myPacketss,querinfo2,true);
				myPacketss = null;
				
		}

		
		if(document.all.standAddrList.rows.length>1){
				if(rdShowMessageDialog("���Ѿ���ѯ�˱�׼��ַ��ȷ��Ҫɾ�������²�ѯ��")==1)
				{
					removeStandardAddr();
					removeAreaResource();
					$("#standAddrList tr").remove();
					getStandardAddr(i);
			   }
		}else{
			removeStandardAddr();
			removeAreaResource()
		//	alert("����e276��ȡ");
					var myPacket = new AJAXPacket("ajax_getStandardAddr.jsp", "���ڻ�ȡ�����Ժ�......");
					//alert(AreaCode);
					//alert(dCode);
					myPacket.data.add("areaCode", AreaCode);
					myPacket.data.add("dCode", dCode );	  
					myPacket.data.add("buildNo", buildNoVal );
					myPacket.data.add("unitNo", unitNoVal );
					/*2014/11/10 10:00:20 gaopeng ������� �������� �� С����������*/
					//alert("aaaa---connectType="+connectType+",propertyUnitVal="+propertyUnitVal);
					myPacket.data.add("connectType", connectType );
					myPacket.data.add("propertyUnitVal", propertyUnitVal);
					core.ajax.sendPacket(myPacket,doGetStandardAddr);
					myPacket = null;
	  }
	}
}
/*2014/11/19 11:05:06 gaopeng �����Ŀ ����ͨ��С���������� ���ض�Ӧ��Ʒ������*/
function retPPName(propertyUnitVal){
	var ppName = "";
	if(propertyUnitVal == "2"){
		ppName = "��ͨ(Эͬ)Ʒ��(kd)�Ŀ��";
	}
	if(propertyUnitVal == "1"||propertyUnitVal == "6"){
		ppName = "�ƶ�Ʒ��(kf)���";
	}
	if(propertyUnitVal == "3"){
		ppName = "ʡ���Ʒ��(kg)�Ŀ��";
	}
	if(propertyUnitVal == "4"){
		ppName = "�����Ʒ��(ke)�Ŀ��";
	}
	if(propertyUnitVal == "5"){
		ppName = "��ͨ(����)Ʒ��(kh)�Ŀ��";
	}
	return ppName;
	
}
/*��׼��ַ��ѯ ajax�ص�����*/
var areaStr2="";
function doGetStandardAddr(packet)
{
	areaStr2="";
	var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMessage");
  
  /*if(true){*/
	if(retCode=="000000"){	
	     var	result= packet.data.findValueByName("result");
	     
	     //result="fieldChName=��ַȫ��%��ַ����#��ַȫ��%��ַ����#��ַȫ��%��ַ����#��ַȫ��%��ַ����#��ַȫ��%��ַ����,fieldEnName=addressId%addressCode#addressId%addressCode#addressId%addressCode#addressId%addressCode#addressId%addressCode,fieldContent=������/������/�ϸ���/��������/ѧ��·/����65��1��3��Ԫ%T_SPACE_STANDARD_ADDRESS-8aee349d336479490133685be8cb1411%freePortNo%occupyPortNo#������/������/�ϸ���/��������/ѧ��·/����65��1��2��Ԫ%T_SPACE_STANDARD_ADDRESS-8aee349d336479490133685be8411410%freePortNo%occupyPortNo#������/������/�ϸ���/��������/ѧ��·/����65��1��1��Ԫ%T_SPACE_STANDARD_ADDRESS-8aee349d336479490133685be787140f%freePortNo%occupyPortNo#������/������/�ϸ���/��������/ѧ��·/����65��1��5��Ԫ%T_SPACE_STANDARD_ADDRESS-8aee349d336479490133685be9dc1413%freePortNo%occupyPortNo#������/������/�ϸ���/��������/ѧ��·/����65��1��4��Ԫ%T_SPACE_STANDARD_ADDRESS-8aee349d336479490133685be9681412%freePortNo%occupyPortNo";
	   	 var temp1=result.split(",");
	   	 var temp2=temp1[2].split("=");
	     var  retLines=temp2[1].split("#");
	     for(var i=0;i<retLines.length;i++)
	     {
	     	   var temp3=retLines[i].split("%");	
	     		 if(!(temp3[0]=="1") && !(temp3[0]=="2")){
	     		 	      preReturn="2%";
	     		 	      document.getElementById("standAddrInfo").style.display="";
	     		 	      /*2013/2/27 ������ 14:37:13 gaopeng ����Э���������˵���FTTHģʽ���߿��ҵ��֧������ĺ� ������ĵ�ѡ��ť�������� */
	                //$("#standAddrList").append("<tr onclick='choseStanAdd(this)' style='cursor:pointer;'><td><input type=radio onclick='choseRes()' id='doType2' name='doType2' RIndex2=" +i+ "></td><td style=\"display:none;\">"+temp3[1]+"</td><td>"+temp3[0]+"</td></tr>");          
									/*gaopeng �����µ� doGetIdleRes �ص�����ȥ������Ϊ�ڱ�׼��ַ��Ϣλ�ü��뵥ѡ��ť(����ǵ���ҳ�������) */
									if("<%=opCode%>" !="e276"){
										/*�������ǵ��� choseRes()��������4977���������Ĺ��ܷ��ز�����ʵ�����Ǹ��������£���һ������ajaxGetPartnerName.jsp ���غ��������Ƶȣ��ڶ�������ajaxGetCctName.jsp ���ص��ž����� ����������һ��ûɶ�õ����������*/
										//alert(temp3[1]+"--"+temp3[0]+"--"+temp3[2]+"--"+temp3[3]);
										var insertStr = "<tr onclick='choseStanAdd(this)' style='cursor:pointer;'>"
										+"<td style='width:5%'>"
										+"<input type='radio' onclick='choseRes(this)' id='doType2' name='doType2' RIndex2=" +i+ ">"
										+"</td><td style=\"display:none;\">"
										+temp3[1]
										+"</td><td>"
										+temp3[0]
										+"</td>"
										+"<td>"+temp3[2]+"</td>"
										+"<td>"+temp3[3]+"</td>"
										+"</tr>";
										//alert("e276:"+temp3[0]);
										$("#standAddrList").append(insertStr);
										$("#standAddrChoose").show();
									}
									else
									{
										
										var insertStr = "<tr onclick='choseStanAdd2(this)' style='cursor:pointer;'>"
										+"<td style='width:5%'>"
										+"<input type='radio' onclick='choseAddr(this);' id='doType2' name='doType2' RIndex2=" +i+ ">"
										+"</td><td style=\"display:none;\">"
										+temp3[1]
										+"</td><td>"
										+temp3[0]
										+"</td>"
										+"<td>"+temp3[2]+"</td>"
										+"<td>"+temp3[3]+"</td>"
										+"</tr>";
										areaStr2+=temp3[0]+",";
										$("#standAddrList").append(insertStr);          
									}	         
	         }else{
	         	rdShowMessageDialog("û�в�ѯ����С����׼��ַ");
	         }
	     }
	     areaStr2=areaStr2.substring(0,areaStr2.length-1);
	     splitPage($("#standAddrInfo"));
	}else{   
	   		rdShowMessageDialog(retCode+"--"+retMsg);	
	   		return false;
	}

}
//��׼��ַ��ѡ��2013/2/26 ���ڶ� 10:19:50 gaopeng ����Э���������˵���FTTHģʽ���߿��ҵ��֧������ĺ� ��гgetAreaResource ����
function choseStanAdd(sObject)
{
	for(var i=0;i<$("#standAddrList tr").length-1;i++)
	{
		$("#standAddrList tr").css("background-color","white");
	}
	//var e = arguments[0] || window.event;
	//var trCur = e.srcElement.parentNode || e.target.parentNode;	
	/*2013/2/28 ������ 11:11:35 gaopeng FTTH������Ϊ����������ȥ���ˣ�ҳ��ĵ�ѡ��ťҲ���ƣ�����������߼���Ҫ�޸�
		���opcode����e276��ʱ��ȡ�ڶ��͵�����td����������ȡ��һ���ڶ���td����
	*/
	if("<%=opCode%>" !="e276"){
		document.all.addrCode.value=sObject.getElementsByTagName("td")[1].innerHTML;
		document.all.addrContent.value=sObject.getElementsByTagName("td")[2].innerHTML;
	}
	else
	{
		document.all.addrCode.value=sObject.getElementsByTagName("td")[0].innerHTML;
		document.all.addrContent.value=sObject.getElementsByTagName("td")[1].innerHTML;
	}
	
	if(document.getElementById("IdleResource").rows.length>1){	 
			 $("#IdleResource tr:gt(0)").remove(); //ԭ��ѡ��ı�׼��ַ��ɾ��
			 $(sObject).css("background-color","#CADFFE");
		   //alert("chossed standardAddress-------"+document.all.addrCode.value+"  "+document.all.addrContent.value);
			 //getAreaResource(document.all.addrCode.value,document.all.enter_type.value,document.all.bandWidth.value);
	}else{
		   $(sObject).css("background-color","#CADFFE");
		   //alert("chossed standardAddress-------"+document.all.addrCode.value+"  "+document.all.addrContent.value);
			 //getAreaResource(document.all.addrCode.value,document.all.enter_type.value,document.all.bandWidth.value);
  }
	
}

function choseStanAdd2(sObject)
{
	for(var i=0;i<$("#standAddrList tr").length-1;i++)
	{
		$("#standAddrList tr").css("background-color","white");
	}
	//var e = arguments[0] || window.event;
	//var trCur = e.srcElement.parentNode || e.target.parentNode;	
	/*2013/2/28 ������ 11:11:35 gaopeng FTTH������Ϊ����������ȥ���ˣ�ҳ��ĵ�ѡ��ťҲ���ƣ�����������߼���Ҫ�޸�
		���opcode����e276��ʱ��ȡ�ڶ��͵�����td����������ȡ��һ���ڶ���td����
	*/
	
		document.all.addrCode.value=sObject.getElementsByTagName("td")[1].innerHTML;
		document.all.addrContent.value=sObject.getElementsByTagName("td")[2].innerHTML;
	
	
	if(document.getElementById("IdleResource").rows.length>1){	 
			 $("#IdleResource tr:gt(0)").remove(); //ԭ��ѡ��ı�׼��ַ��ɾ��
			 $(sObject).css("background-color","#CADFFE");
		   //alert("chossed standardAddress-------"+document.all.addrCode.value+"  "+document.all.addrContent.value);
			 //getAreaResource(document.all.addrCode.value,document.all.enter_type.value,document.all.bandWidth.value);
	}else{
		   $(sObject).css("background-color","#CADFFE");
		   //alert("chossed standardAddress-------"+document.all.addrCode.value+"  "+document.all.addrContent.value);
			 //getAreaResource(document.all.addrCode.value,document.all.enter_type.value,document.all.bandWidth.value);
  }
	
}
//������Դ�Ĳ�ѯ
function getAreaResource(addrCode,enterType,bandWidth)
{
	bandWidth="100M";
	removeAreaResource();
	var myPacket = new AJAXPacket("ajax_getIdleResource.jsp", "���ڻ�ȡ�����Ժ�......");
				myPacket.data.add("addrCode", addrCode);
				myPacket.data.add("productType", "12" );	 
				myPacket.data.add("enterType", enterType); 
				myPacket.data.add("bandWidth", bandWidth); 
				core.ajax.sendPacket(myPacket,doGetIdleRes);
				myPacket = null;
}
function doGetIdleRes(packet) //����
{
	var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMessage");
   if(retCode != "000000"){
			/* 	ԭ����retcode�ж��Ƿ��޶˿ڣ������ˣ��Ѿ�ɾ��
					�ĳ����Ϊ�վ����޶˿��ˡ�
			 */
			rdShowMessageDialog("������Դ�ӿ�ʧ��,"+retMsg);
			return false;
 	 }else{
 	 		var result=packet.data.findValueByName("result");
 	 		if(result == null || typeof(result) == undefined){
 	 			if(rdShowConfirmDialog("û�в�ѯ�������Դ���Ƿ��������ҵ��?")==1)
	 			{
	 			  		var addrCode=document.all.addrCode.value;//��׼��ַ
							var addrContent=document.all.addrContent.value;//��׼��ַ����
							var area_name=document.all.area_nameh.value;//С������
							var area_code=document.all.area_codeh.value;//С������
							var areaAddr=document.all.areaAddr.value;// 
							var bandWidth=document.all.bandWidth.value;//����
							var enter_type=document.all.enter_type.value;//��������
							var retInfo="3%"+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type+"|"+addrCode+"|"+addrContent;
	 			  		opener.returnResBack(retInfo);
	 			  		window.close();
	 			}
 	 		}
 	 		var temp1=result.split(",");
 	 		var temp2=temp1[2].split("=");
   		var retLines=temp2[1].split("#");
			for(var i=0;i<retLines.length;i++){
			    var retLine=retLines[i].split("%");
			    
			    if(retLine[0] !="1" && retLine[0]!="2" )
			    {	
			    	preReturn="4%";	
			    	document.getElementById("idleResInfo").style.display="";  
			    	//$("#IdleResource").append("<tr style='cursor:pointer;'><td><input type=radio onclick='cfm()' id='doType2' name='doType2' RIndex2=" +i+ "></td><td><input type='hidden'   name=deviceType"+i+" value="+retLine[0]+">"+retLine[0]+"</td><td><input type='hidden'   name=deviceCode"+i+" value="+retLine[1]+">"+retLine[1]+"</td><td><input type='hidden'  name=model"+i+" value="+retLine[2]+">"+retLine[2]+"</td><td><input type='hidden'  name=factory"+i+" value="+retLine[3]+">"+retLine[3]+"</td><td><input type='hidden'  name=ipAddress"+i+" value="+retLine[4]+">"+retLine[4]+"</td><td><input type='hidden'  name=deviceInAddress"+i+" value="+retLine[5]+">"+retLine[5]+"</td><td><input type='hidden'  name=portType"+i+" value="+retLine[7]+">"+retLine[7]+"</td><td><input type='hidden'   name=portCode"+i+" value="+retLine[6]+">"+retLine[6]+"</td><td><input type='hidden' name=cctId"+i+" value="+retLine[8]+">"+retLine[8]+"</td></tr>");
			    	if("<%=opCode%>" !="e276"){
			    		$("#IdleResource").append("<tr style='cursor:pointer;'>"
			    			+"<td><input type=radio onclick='choseRes()' id='doType2' name='doType2' RIndex2=" +i+ "></td>"
			    			+"<td><input type='hidden'   name=deviceType"+i+" value="+retLine[0]+">"+retLine[0]+"</td>"
			    			+"<td style='display:none'><input type='hidden'   name=deviceCode"+i+" value="+retLine[1]+">"+retLine[1]+"</td>"
			    			+"<td><input type='hidden'  name=model"+i+" value="+retLine[2]+">"+retLine[2]+"</td>"
			    			+"<td><input type='hidden'  name=factory"+i+" value="+retLine[3]+">"+retLine[3]+"</td>"
			    			+"<td><input type='hidden'  name=ipAddress"+i+" value="+retLine[4]+">"+retLine[4]+"</td>"
			    			+"<td><input type='hidden'  name=deviceInAddress"+i+" value="+retLine[5]+">"+retLine[5]+"</td>"
			    			+"<td><input type='hidden'  name=portType"+i+" value="+retLine[7]+">"+retLine[7]+"</td>"
			    			+"<td style='display:none'><input type='hidden'   name=portCode"+i+" value="+retLine[6]+">"+retLine[6]+"</td>"
			    			+"<td style='display:none'><input type='hidden'   name=partnerCode"+i+" value="+retLine[6+3]+">"+retLine[6+3]+"</td>"
			    			+"<td style='display:none'><input type='hidden' name=cctId"+i+" value="+retLine[8]+">"+retLine[8]+"</td></tr>");
			      }else{
			      	$("#IdleResource").append("<tr style='cursor:pointer;'>"
			      		+"<td><input type='hidden'   name=deviceType"+i+" value="+retLine[0]+">"
			      			+retLine[0]+"</td>"
			      		+"<td style='display:none'>"
			      			+"<input type='hidden'   name=deviceCode"+i+" value="+retLine[1]+">"+retLine[1]+"</td>"
			      		+"<td><input type='hidden'  name=model"+i+" value="+retLine[2]+">"+retLine[2]+"</td>"
			      		+"<td><input type='hidden'  name=factory"+i+" value="+retLine[3]+">"+retLine[3]+"</td>"
			      		+"<td><input type='hidden'  name=ipAddress"+i+" value="+retLine[4]+">"+retLine[4]+"</td>"
			      		+"<td><input type='hidden'  name=deviceInAddress"+i+" value="+retLine[5]+">"+retLine[5]+"</td>"
			      		+"<td><input type='hidden'  name=portType"+i+" value="+retLine[7]+">"+retLine[7]+"</td>"
			      		+"<td style='display:none'><input type='hidden'   name=portCode"+i+" value="+retLine[6]+">"+retLine[6]+"</td>"
			      		+"<td style='display:none'><input type='hidden' name=cctId"+i+" value="+retLine[8]+">"+retLine[8]+"</td></tr>");  	  
			      }	
			    }
 	    }
		}
}

//������Դ��ѡ��
function choseRes(m)
{
	
	if("<%=opCode%>" !="e276"){
		document.all.addrCode.value=m.parentNode.parentNode.getElementsByTagName("td")[1].innerHTML;
		document.all.addrContent.value=m.parentNode.parentNode.getElementsByTagName("td")[2].innerHTML;
		
	}
	else
	{
		document.all.addrCode.value=m.parentNode.parentNode.getElementsByTagName("td")[0].innerHTML;
		document.all.addrContent.value=m.parentNode.parentNode.getElementsByTagName("td")[1].innerHTML;
	}
	
	if(document.getElementById("IdleResource").rows.length>1){	 
			 $("#IdleResource tr:gt(0)").remove(); //ԭ��ѡ��ı�׼��ַ��ɾ��
			 $(m.parentNode.parentNode).css("background-color","#CADFFE");
	}else{
		   $(m.parentNode.parentNode).css("background-color","#CADFFE");
  }
	var addrCode=document.all.addrCode.value;//��׼��ַ
	var addrContent=document.all.addrContent.value;//��׼��ַ����
	var area_name=document.all.area_nameh.value;//С������
	var area_code=document.all.area_codeh.value;//С������
	var areaAddr=document.all.areaAddr.value;// 
	var bandWidth=document.all.bandWidth.value;//����
	var enter_type=document.all.enter_type.value;//��������
	/*2013/2/27 ������ 15:14:22 gaopeng FTTH����ȥ��IdleResource ����е���ʾ�����������߼���ȥ����ֱ�Ӹ�ֵ��deviceType��portCodeΪ�գ�cctId��partnerCode�ǵ�һ�������ѯ�����ģ�ֱ������������*/
	/*for(var i=0;i<$("#IdleResource tr").length-1;i++)
	{ 
		if ($("#IdleResource :input[type='radio']").attr("name")=="doType2")
		{     
			if($("#IdleResource :input[type='radio']").get(i).checked==true)
			{ 
 				var rIndex = i;
 				objCode0 = "deviceType" + rIndex ;
 				objCode1 = "deviceCode" + rIndex ;
 				objCode2 = "model" + rIndex ;
 				objCode3 = "factory" + rIndex ;
 				objCode4 = "ipAddress" + rIndex ;
 				objCode5 = "deviceInAddress" + rIndex ;
 				objCode6 = "portType" + rIndex ;
 				objCode7 = "portCode" + rIndex ;
 				objCode8 = "cctId" + rIndex ;
 				objCode9 = "partnerCode" + rIndex ;
				var   deviceType=document.all(objCode0).value; 
				var   deviceCode=document.all(objCode1).value;
				var   model=document.all(objCode2).value;
				var   factory=document.all(objCode3).value;
				var   ipAddress=document.all(objCode4).value;
				var   deviceInAddress=document.all(objCode5).value;
				var   portType=document.all(objCode6).value;
				var   portCode=document.all(objCode7).value;
				var   cctId=document.all(objCode8).value;
				var   partnerCode=document.all(objCode9).value;
				
				
				document.all.deviceType.value = deviceType;
				document.all.deviceCode.value = deviceCode;
				document.all.model.value = model;
				document.all.factory.value = factory;
				document.all.ipAddress.value = ipAddress;
				document.all.deviceInAddress.value = deviceInAddress;
				document.all.portType.value = portType;
				document.all.portCode.value = portCode;
				document.all.cctId.value= cctId;
				document.all.partnerCode.value= partnerCode;*/
				var   deviceType=""; 
				var   deviceCode="";
				var   model="";
				var   factory="";
				var   ipAddress="";
				var   deviceInAddress="";
				var   portType="";
				var   portCode="";
				var   cctId=document.all.cctId.value;
				var   partnerCode=document.all.partnerCode.value;
				
				/*2014/04/03 11:12:52 gaopeng ������� ���ط�ʽ*/
				var 	belongCategory = document.all.belongCategory.value;
				var 	bearType = document.all.bearType.value;
				var   propertyUnit = document.all.propertyUnit.value;
				
				/*2014/06/24 14:59:54 gaopeng С���������*/
				var   nearInfo = document.all.nearInfo.value;
				/*2014/06/24 15:00:06 gaopeng С������*/
				var   distKdCode = document.all.distKdCode.value;
				
				/*	2014/06/24 15:05:25 gaopeng ��ӡ С������ С��������� С����������
					alert("nearInfo="+nearInfo+"---"+"distKdCode="+distKdCode+"---propertyUnit="+propertyUnit);
				*/
				document.all.deviceType.value = deviceType;
				document.all.deviceCode.value = deviceCode;
				document.all.model.value = model;
				document.all.factory.value = factory;
				document.all.ipAddress.value = ipAddress;
				document.all.deviceInAddress.value = deviceInAddress;
				document.all.portType.value = portType;
				document.all.portCode.value = portCode;
				//document.all.cctId.value= cctId;
				//document.all.partnerCode.value= partnerCode;
				
				if(/*(typeof(portType) == "undefined" || portType == "")
					&&(typeof(portCode) == "undefined" || portCode == "")
					&& */"<%=smCode%>" == "kd"){
					/* ��ͨ�޶˿���� */
					/*if(rdShowConfirmDialog("����ԴΪ�޶˿�������Ƿ��������ҵ��?")==1)
		 			{*/
		 				var retInfo1="4%"+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type+"|"+addrCode+"|"+addrContent;
						var retInfo2="|"+deviceType+"|"+deviceCode+"|"+model+"|"+factory+"|"+ipAddress+"|"+deviceInAddress+"|"+portType+"|"+portCode+"|"+cctId+"|"+partnerCode+"|"+belongCategory+"|"+bearType+"|"+propertyUnit+"|"+distKdCode+"|"+nearInfo;
						var retInfo=retInfo1+retInfo2;
						opener.returnResBack(retInfo);
						window.close();
		 			/*}*/
				}else if(/*(typeof(portType) == "undefined" || portType == "")
					&&(typeof(portCode) == "undefined" || portCode == "")
					&&*/ "<%=smCode%>" == "ke"){
					/* ����޶˿���� */
	 				var retInfo1="4%"+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type+"|"+addrCode+"|"+addrContent;
					var retInfo2="|"+deviceType+"|"+deviceCode+"|"+model+"|"+factory+"|"+ipAddress+"|"+deviceInAddress+"|"+portType+"|"+portCode+"|"+cctId+"|"+partnerCode+"|"+belongCategory+"|"+bearType+"|"+propertyUnit+"|"+distKdCode+"|"+nearInfo;
					var retInfo=retInfo1+retInfo2;
					opener.returnResBack(retInfo);
					window.close();
				}else{
					var retInfo1="4%"+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type+"|"+addrCode+"|"+addrContent;
					var retInfo2="|"+deviceType+"|"+deviceCode+"|"+model+"|"+factory+"|"+ipAddress+"|"+deviceInAddress+"|"+portType+"|"+portCode+"|"+cctId+"|"+partnerCode+"|"+belongCategory+"|"+bearType+"|"+propertyUnit+"|"+distKdCode+"|"+nearInfo;
					var retInfo=retInfo1+retInfo2;
					opener.returnResBack(retInfo);
					window.close();
				}
			 
			}
/*
		}
	}	
}*/

function choseRes2(m)
{
	
	if(m==undefined||""==m){
		rdShowMessageDialog("��ѡ���ַ!",1);
		return false;
	}
	document.all.addrCode.value=m.parentNode.parentNode.getElementsByTagName("td")[1].innerHTML;
	document.all.addrContent.value=m.parentNode.parentNode.getElementsByTagName("td")[2].innerHTML;
	if(document.getElementById("IdleResource").rows.length>1){	 
			 $("#IdleResource tr:gt(0)").remove(); //ԭ��ѡ��ı�׼��ַ��ɾ��
			 $(m.parentNode.parentNode).css("background-color","#CADFFE");
	}else{
		   $(m.parentNode.parentNode).css("background-color","#CADFFE");
  }
	var addrCode=document.all.addrCode.value;//��׼��ַ
	var addrContent=document.all.addrContent.value;//��׼��ַ����
	var area_name=document.all.area_nameh.value;//С������
	var area_code=document.all.area_codeh.value;//С������
	var areaAddr=document.all.areaAddr.value;// 
	var bandWidth=document.all.bandWidth.value;//����
	var enter_type=document.all.enter_type.value;//��������
	/*2013/2/27 ������ 15:14:22 gaopeng FTTH����ȥ��IdleResource ����е���ʾ�����������߼���ȥ����ֱ�Ӹ�ֵ��deviceType��portCodeΪ�գ�cctId��partnerCode�ǵ�һ�������ѯ�����ģ�ֱ������������*/
	/*for(var i=0;i<$("#IdleResource tr").length-1;i++)
	{ 
		if ($("#IdleResource :input[type='radio']").attr("name")=="doType2")
		{     
			if($("#IdleResource :input[type='radio']").get(i).checked==true)
			{ 
 				var rIndex = i;s4977
 				objCode0 = "deviceType" + rIndex ;
 				objCode1 = "deviceCode" + rIndex ;
 				objCode2 = "model" + rIndex ;
 				objCode3 = "factory" + rIndex ;
 				objCode4 = "ipAddress" + rIndex ;
 				objCode5 = "deviceInAddress" + rIndex ;
 				objCode6 = "portType" + rIndex ;
 				objCode7 = "portCode" + rIndex ;
 				objCode8 = "cctId" + rIndex ;
 				objCode9 = "partnerCode" + rIndex ;
				var   deviceType=document.all(objCode0).value; 
				var   deviceCode=document.all(objCode1).value;
				var   model=document.all(objCode2).value;
				var   factory=document.all(objCode3).value;
				var   ipAddress=document.all(objCode4).value;
				var   deviceInAddress=document.all(objCode5).value;
				var   portType=document.all(objCode6).value;
				var   portCode=document.all(objCode7).value;
				var   cctId=document.all(objCode8).value;
				var   partnerCode=document.all(objCode9).value;
				
				
				document.all.deviceType.value = deviceType;
				document.all.deviceCode.value = deviceCode;
				document.all.model.value = model;
				document.all.factory.value = factory;
				document.all.ipAddress.value = ipAddress;
				document.all.deviceInAddress.value = deviceInAddress;
				document.all.portType.value = portType;
				document.all.portCode.value = portCode;
				document.all.cctId.value= cctId;
				document.all.partnerCode.value= partnerCode;*/
				var   deviceType=""; 
				var   deviceCode="";
				var   model="";
				var   factory="";
				var   ipAddress="";
				var   deviceInAddress="";
				var   portType="";
				var   portCode="";
				var   cctId=document.all.cctId.value;
				var   partnerCode=document.all.partnerCode.value;
				
				/*2014/04/03 11:12:52 gaopeng ������� ���ط�ʽ*/
				var 	belongCategory = document.all.belongCategory.value;
				var 	bearType = document.all.bearType.value;
				var   propertyUnit = document.all.propertyUnit.value;
				
				/*2014/06/24 14:59:54 gaopeng С���������*/
				var   nearInfo = document.all.nearInfo.value;
				/*2014/06/24 15:00:06 gaopeng С������*/
				var   distKdCode = document.all.distKdCode.value;
				
				/*	2014/06/24 15:05:25 gaopeng ��ӡ С������ С��������� С����������
					alert("nearInfo="+nearInfo+"---"+"distKdCode="+distKdCode+"---propertyUnit="+propertyUnit);
				*/
				document.all.deviceType.value = deviceType;
				document.all.deviceCode.value = deviceCode;
				document.all.model.value = model;
				document.all.factory.value = factory;
				document.all.ipAddress.value = ipAddress;
				document.all.deviceInAddress.value = deviceInAddress;
				document.all.portType.value = portType;
				document.all.portCode.value = portCode;
				//document.all.cctId.value= cctId;
				//document.all.partnerCode.value= partnerCode;
				
				if(/*(typeof(portType) == "undefined" || portType == "")
					&&(typeof(portCode) == "undefined" || portCode == "")
					&& */"<%=smCode%>" == "kd"){
					/* ��ͨ�޶˿���� */
					/*if(rdShowConfirmDialog("����ԴΪ�޶˿�������Ƿ��������ҵ��?")==1)
		 			{*/
		 				var retInfo1="4%"+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type+"|"+addrCode+"|"+addrContent;
						var retInfo2="|"+deviceType+"|"+deviceCode+"|"+model+"|"+factory+"|"+ipAddress+"|"+deviceInAddress+"|"+portType+"|"+portCode+"|"+cctId+"|"+partnerCode+"|"+belongCategory+"|"+bearType+"|"+propertyUnit+"|"+distKdCode+"|"+nearInfo;
						var retInfo=retInfo1+retInfo2;
						$("#se276diZhi",window.parent.document).val(retInfo);
						//opener.returnResBack(retInfo);
						//window.close();
		 			/*}*/
				}else if(/*(typeof(portType) == "undefined" || portType == "")
					&&(typeof(portCode) == "undefined" || portCode == "")
					&&*/ "<%=smCode%>" == "ke"){
					/* ����޶˿���� */
	 				var retInfo1="4%"+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type+"|"+addrCode+"|"+addrContent;
					var retInfo2="|"+deviceType+"|"+deviceCode+"|"+model+"|"+factory+"|"+ipAddress+"|"+deviceInAddress+"|"+portType+"|"+portCode+"|"+cctId+"|"+partnerCode+"|"+belongCategory+"|"+bearType+"|"+propertyUnit+"|"+distKdCode+"|"+nearInfo;
					var retInfo=retInfo1+retInfo2;
					$("#se276diZhi",window.parent.document).val(retInfo);
					//opener.returnResBack(retInfo);
					//window.close();
				}else{
					var retInfo1="4%"+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type+"|"+addrCode+"|"+addrContent;
					var retInfo2="|"+deviceType+"|"+deviceCode+"|"+model+"|"+factory+"|"+ipAddress+"|"+deviceInAddress+"|"+portType+"|"+portCode+"|"+cctId+"|"+partnerCode+"|"+belongCategory+"|"+bearType+"|"+propertyUnit+"|"+distKdCode+"|"+nearInfo;
					var retInfo=retInfo1+retInfo2;
					$("#se276diZhi",window.parent.document).val(retInfo);
					//opener.returnResBack(retInfo);
					//window.close();
				}
			 
			}
/*
		}
	}	
}*/
function removeAreaInfo(){
	/*��� ����С����Ϣ*/
	$("#areaListBody").empty();
	$("#areaInfo").hide();
}
function removeStandardAddr(){
	/*��� ���ر�׼��ַ��Ϣ*/
	$("#standAddrList tr").remove();
	$("#standAddrInfo").hide();
}
function removeAreaResource(){
	/*��� ���ؿ�����Դ��Ϣ*/
	$("#IdleResource tr:gt(0)").remove();
	$("#idleResInfo").hide();
}
function closeWin(){
	var retInfo="";
	if(preReturn=="0%" && document.all.area_name.value!=""){
		if(rdShowConfirmDialog("û�в�ѯ�������Դ���Ƿ��˳���ѯ?")==1){
			if(rdShowConfirmDialog("�Ƿ���ṩ�����Ϣ��������Դʱ֪ͨ?")==1){
			//	alert("aaa");
				go_getDisName();
				go_pageAreaName();
				document.getElementById("recordInfos").style.display="";
				
				//document.all.userName.focus();
			}else{
				document.all.userAddr.value=document.all.area_name.value;
				//alert("111111111"+document.all.userAddr.value);
				recordInfo();
			}
		}
	}else if(preReturn=="1%" && queRes=="0"){//��׼��ַ��ѯʧ��
		if(rdShowConfirmDialog("û�в�ѯ�������Դ���Ƿ��˳���ѯ?")==1){
			if(rdShowConfirmDialog("�Ƿ���ṩ�����Ϣ��������Դʱ֪ͨ?")==1){
			//	alert("bbb");
				go_getDisName();
				go_pageAreaName();
				document.getElementById("recordInfos").style.display="";
				//document.all.userName.focus();
			}else{
				document.all.userAddr.value=document.all.area_nameh.value==""?document.all.area_name.value:document.all.area_nameh.value;
					//alert("22222222"+document.all.userAddr.value);
				recordInfo();
			}
		}
		
		/*var area_name=document.all.area_nameh.value;//С������
	  var area_code=document.all.area_codeh.value;//С������
	  var areaAddr=document.all.areaAddr.value;//������������
	  var bandWidth=document.all.bandWidth.value;//����
	  var enter_type=document.all.enter_type.value;//��������
	  retInfo=preReturn+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type;
		opener.returnResBack(retInfo);  */
		
	}else if (preReturn=="2%"  && queRes=="0"){//������Դ��ѯʧ��
		if(rdShowConfirmDialog("û�в�ѯ�������Դ���Ƿ��˳���ѯ?")==1){
			if(rdShowConfirmDialog("�Ƿ���ṩ�����Ϣ��������Դʱ֪ͨ?")==1){
				//alert("ccc");
				go_getDisName();
				go_pageAreaName2();
				document.getElementById("recordInfos").style.display="";
				//document.all.userName.focus();
			}else{
				document.all.userAddr.value=document.all.addrContent.value==""?document.all.area_nameh.value:document.all.addrContent.value;
					//alert("333333"+document.all.userAddr.value);
				recordInfo();
			}
		}
		/*rdShowMessageDialog("û�в�ѯ����Դ",2);
		var area_name=document.all.area_nameh.value;//С������
	  var area_code=document.all.area_codeh.value;//С������
	  var bandWidth=document.all.bandWidth.value;//����
	  var enter_type=document.all.enter_type.value;//��������
	  
	  var addrCode=document.all.addrCode.value;//��׼��ַ
	  var addrContent=document.all.addrContent.value;//��׼��ַ����
	  
	  retInfo=preReturn+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type+"|"+addrCode+"|"+addrContent;
		opener.returnResBack(retInfo); */
		
	}else if (preReturn=="3%"  ){//���豸�޶˿�

	}else if (preReturn=="4%"  ){//���豸�ж˿�
		<%
		if(!opCode.equals("e276")){
		%>
		window.close();
	 <%}else{%>
	 	parent.removeTab("<%=opCode%>");
	<%}%>
	}else{
		<%
		if(!opCode.equals("e276")){
		%>
		window.close();
	 	<%}else{%>
	 	parent.removeTab("<%=opCode%>");
	  <%}%>
	}
}

function closeWin1(){
	var retInfo="";
	if(preReturn=="0%" && document.all.area_name.value!=""){
	//	if(rdShowConfirmDialog("û�в�ѯ�������Դ���Ƿ��˳���ѯ?")==1){
			if(rdShowConfirmDialog("�Ƿ���Ҫ�ֶ�¼��������Ϣ?")==1){
			//	alert("aaa");
				go_getDisName();
				go_pageAreaName();
				document.getElementById("recordInfos").style.display="";
				
				//document.all.userName.focus();
			}else{
				document.all.userAddr.value=document.all.area_name.value;
				//alert("111111111"+document.all.userAddr.value);
				recordInfo();
			}
		//}
	}else if(preReturn=="1%" && queRes=="0"){//��׼��ַ��ѯʧ��
		//if(rdShowConfirmDialog("û�в�ѯ�������Դ���Ƿ��˳���ѯ?")==1){
			if(rdShowConfirmDialog("�Ƿ���Ҫ�ֶ�¼��������Ϣ?")==1){
			//	alert("bbb");
				go_getDisName();
				go_pageAreaName();
				document.getElementById("recordInfos").style.display="";
				//document.all.userName.focus();
			}else{
				document.all.userAddr.value=document.all.area_nameh.value==""?document.all.area_name.value:document.all.area_nameh.value;
					//alert("22222222"+document.all.userAddr.value);
				recordInfo();
			}
		//}
		
		/*var area_name=document.all.area_nameh.value;//С������
	  var area_code=document.all.area_codeh.value;//С������
	  var areaAddr=document.all.areaAddr.value;//������������
	  var bandWidth=document.all.bandWidth.value;//����
	  var enter_type=document.all.enter_type.value;//��������
	  retInfo=preReturn+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type;
		opener.returnResBack(retInfo);  */
		
	}else if (preReturn=="2%"  && queRes=="0"){//������Դ��ѯʧ��
	//	if(rdShowConfirmDialog("û�в�ѯ�������Դ���Ƿ��˳���ѯ?")==1){
			if(rdShowConfirmDialog("�Ƿ���Ҫ�ֶ�¼��������Ϣ?")==1){
				//alert("ccc");
				go_getDisName();
				go_pageAreaName2();
				document.getElementById("recordInfos").style.display="";
				//document.all.userName.focus();
			}else{
				document.all.userAddr.value=document.all.addrContent.value==""?document.all.area_nameh.value:document.all.addrContent.value;
					//alert("333333"+document.all.userAddr.value);
				recordInfo();
			}
	//	}
		/*rdShowMessageDialog("û�в�ѯ����Դ",2);
		var area_name=document.all.area_nameh.value;//С������
	  var area_code=document.all.area_codeh.value;//С������
	  var bandWidth=document.all.bandWidth.value;//����
	  var enter_type=document.all.enter_type.value;//��������
	  
	  var addrCode=document.all.addrCode.value;//��׼��ַ
	  var addrContent=document.all.addrContent.value;//��׼��ַ����
	  
	  retInfo=preReturn+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type+"|"+addrCode+"|"+addrContent;
		opener.returnResBack(retInfo); */
		
	}else if (preReturn=="3%"  ){//���豸�޶˿�

	}else if (preReturn=="4%"  ){//���豸�ж˿�
		<%
		if(!opCode.equals("e276")){
		%>
		window.close();
	 <%}else{%>
	 	parent.removeTab("<%=opCode%>");
	<%}%>
	}else{
		<%
		if(!opCode.equals("e276")){
		%>
		window.close();
	 	<%}else{%>
	 	parent.removeTab("<%=opCode%>");
	  <%}%>
	}
}
//��ȡ����
function go_getDisName(){
	var myPacket = new AJAXPacket("ajax_getDisName.jsp", "���ڲ��룬���Ժ�......");
	myPacket.data.add("LoginAccept", "");
	myPacket.data.add("ChnSource", "" );	 
	myPacket.data.add("OpCode","<%=opCode%>"); 
	myPacket.data.add("LoginNo", "<%=workNo%>"); 
	myPacket.data.add("LoginPwd",  "<%=nopass%>");
	myPacket.data.add("PhoneNo", "" );	 
	myPacket.data.add("UserPwd", "");
	myPacket.data.add("OpNote", "");
	core.ajax.sendPacket(myPacket,do_getDisName);
	myPacket = null;
}
function do_getDisName(packet){
	var disCode = packet.data.findValueByName("disCode");
	var disMsg = packet.data.findValueByName("disMsg");
	if(disCode == "000000"){
		var disName = packet.data.findValueByName("disName");
		var batchdisArray = packet.data.findValueByName("batchdisArray");
		$("#county").empty();
		//$("#county")[0].add(new Option(disName,disName));
		for(var i=0;i<batchdisArray.length;i++){
			$("#county")[0].add(new Option(batchdisArray[i][0],batchdisArray[i][0]));
		}
	}
}
//��ȡҳ��С��
function go_pageAreaName(){
	var areaStrs = areaStr.split(",");
	if(areaStrs==""){
		colFlag="N";
		go_getAreaName();
	}
	else{
		colFlag="Y";
		setareaName(0,1);
		$("#userareaNameSel").empty();
		for(var i=0;i<areaStrs.length;i++){
			$("#userareaNameSel")[0].add(new Option(areaStrs[i],areaStrs[i]));
		}
		$("#userareaName").val($("#userareaNameSel").val());
	}
	
}
function go_pageAreaName2(){
	colFlag="Y";
	var areaStrs = areaStr2.split(",");
	if(areaStrs==""){
		setareaName(1,0);
	}
	else{
		setareaName(0,1);
		$("#userareaNameSel").empty();
		for(var i=0;i<areaStrs.length;i++){
			$("#userareaNameSel")[0].add(new Option(areaStrs[i],areaStrs[i]));
		}
	}
	$("#userareaName").val($("#userareaNameSel").val());
}

//��ȡС��
function go_getAreaName(){
	var myPacket = new AJAXPacket("ajax_getAreaName.jsp", "���ڲ��룬���Ժ�......");
	myPacket.data.add("LoginAccept", "");
	myPacket.data.add("ChnSource", "" );	 
	myPacket.data.add("OpCode","<%=opCode%>"); 
	myPacket.data.add("LoginNo", "<%=workNo%>"); 
	myPacket.data.add("LoginPwd",  "<%=nopass%>");
	myPacket.data.add("PhoneNo", "" );	 
	myPacket.data.add("UserPwd", "");
	myPacket.data.add("OpNote", "");
	myPacket.data.add("AreaName", $("#area_name").val());
	core.ajax.sendPacket(myPacket,do_getAreaName);
	myPacket = null;
}
function do_getAreaName(packet){
	var areaCode = packet.data.findValueByName("areaCode");
	var areaMsg = packet.data.findValueByName("areaMsg");
	if(areaCode == "000000"){
		var areaArray = packet.data.findValueByName("areaArray");
		if(areaArray.length==0){
			setareaName(1,0);
			$("#userareaName").val($("#area_name").val());
		}
		else{
			setareaName(0,1);
			$("#userareaNameSel").empty();
			for(var i=0;i<areaArray.length;i++){
				$("#userareaNameSel")[0].add(new Option(areaArray[i][0],areaArray[i][0]));
			}
			$("#userareaName").val($("#userareaNameSel").val());
		}
	}
}


function setareaName(userAreaNameFlag,userAreaNameSelFlag){
	if(userAreaNameFlag=="1"){
		$("#userareaName").show();
	}
	else{
		$("#userareaName").hide();
	}
	if(userAreaNameSelFlag=="1"){
		$("#userareaNameSel").show();
	}
	else{
		$("#userareaNameSel").hide();
	}
}

function recordInfo(){
	if($("#userName").val()==""){
		rdShowMessageDialog("�û����Ʋ���Ϊ�գ�������",0);
		return false;
	}
	
	if($("#contractPhone").val()==""){
		rdShowMessageDialog("��ϵ�绰����Ϊ�գ�������",0);
		return false;
	}
	if($("#county").val()==""){
		rdShowMessageDialog("���ز���Ϊ�գ�������",0);
		return false;
	}
	if($("#ownerShip").val()==""){
		rdShowMessageDialog("���̹�������Ϊ�գ�������",0);
		return false;
	}
	if($("#userareaName").val()==""){
		rdShowMessageDialog("С�����Ʋ���Ϊ�գ�������",0);
		return false;
	}
	if($("#ageLimit").val()==""){
		rdShowMessageDialog("ǩԼ���޲���Ϊ�գ�������",0);
		return false;
	}
	if($("#description").val()==""){
		rdShowMessageDialog("�ʷѼ۸���Ϊ�գ�������",0);
		return false;
	}
	if($("#expireTime").val()==""){
		rdShowMessageDialog("Ԥ����ʱ�䲻��Ϊ�գ�������",0);
		return false;
	}
	
	
	var myPacket = new AJAXPacket("ajax_recordInfo.jsp", "���ڲ��룬���Ժ�......");
	myPacket.data.add("LoginAccept", "");
	myPacket.data.add("ChnSource", "" );
	myPacket.data.add("OpCode","<%=opCode%>");
	myPacket.data.add("LoginNo", "<%=workNo%>");
	myPacket.data.add("LoginPwd",  "<%=nopass%>");
	myPacket.data.add("PhoneNo", "" );
	myPacket.data.add("UserPwd", "");
	
	myPacket.data.add("userName",$.trim($("#userName").val()));
	myPacket.data.add("contractPhone",$.trim($("#contractPhone").val()));
	myPacket.data.add("county",$.trim($("#county").val()));
	myPacket.data.add("ownerShip",$.trim($("#ownerShip").val()));
	myPacket.data.add("userareaName",$.trim($("#userareaName").val()));
	myPacket.data.add("bundMobile",$.trim($("#bundMobile").val()));
	myPacket.data.add("bandWidth",$.trim($("#bandWidth").val()));
	myPacket.data.add("ageLimit",$.trim($("#ageLimit").val()));
	myPacket.data.add("isIptv",$.trim($("#isIptv").val()));
	myPacket.data.add("description",$.trim($("#description").val()));
	myPacket.data.add("expireTime",$.trim($("#expireTime").val()));
	
	myPacket.data.add("iAreaCode",$.trim($("#userareaCode2").val()));
	myPacket.data.add("iStandAddr",$.trim($("#userareaName2").val()));
	myPacket.data.add("iColFlag",colFlag);
	
	
	core.ajax.sendPacket(myPacket,doRecordInfo);
	myPacket = null;
}
function doRecordInfo(packet)
{
	var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMessage");
  if(retCode != "000000")
  {
  	rdShowMessageDialog("��¼ȱ����Դ��Ϣʧ��,"+retMsg);
  	return false;
  }else{
  	  rdShowMessageDialog("��¼�ɹ�",2);
  		queRes="1";
  		<%
			if(!opCode.equals("e276")){
			%>
			window.close();
		 	<%}else{%>
		 	parent.removeTab("<%=opCode%>");
		  <%}%>
  }

}

	function querinfo2(data){
		//�ҵ���ӱ���div
		var markDiv=$("#showTab2"); 
		markDiv.empty();
		markDiv.append(data);
				
	}
	var diZhi="";
	var ziFei="";
	dizhiFlag=false;
	zifeiFlag=false;
	
	function choseAddr(obj){
		if(obj==undefined||""==obj){
			dizhiFlag=false;
		}
		else{
			dizhiFlag=true;
			diZhi=obj;
			choseRes2(obj);
		}
	}
	function choseZiFei(obj){
		if(obj==undefined||""==obj){
			zifeiFlag=false;
		}
		else{
			zifeiFlag=true;
			ziFei=obj;
			var myPacket = new AJAXPacket("checkProductOffer.jsp", "���ڲ�ѯ�ʷ��Ƿ���ڣ����Ժ�......");
			myPacket.data.add("offer_id", obj);
			core.ajax.sendPacket(myPacket,do_choseZiFei);
			myPacket = null;
		}
	}
	function do_choseZiFei(packet){
		var s_ret_code = packet.data.findValueByName("retCode");
		var s_ret_msg = packet.data.findValueByName("retMsg");
		if(s_ret_code=="000000")
		{
			miguFlag=packet.data.findValueByName("miguFlag");
			if("N"==packet.data.findValueByName("miguFlag")){
				submitFlag=true;
			}
			else{
				submitFlag=false;
			}
		}
		else{
			rdShowMessageDialog(s_ret_msg,1);
			submitFlag=true;
			return false;
		}
		var myPacket = new AJAXPacket("checkJituanOffer.jsp", "���ڲ�ѯ�Ƿ����ʷѣ����Ժ�......");
		myPacket.data.add("offer_id", ziFei);
		core.ajax.sendPacket(myPacket,do_jituanZiFei);
		myPacket = null;
	}
	
	function do_jituanZiFei(packet){
		var s_ret_code = packet.data.findValueByName("retCode");
		var s_ret_msg = packet.data.findValueByName("retMsg");
		if(s_ret_code=="000000")
		{
			miguFlag=packet.data.findValueByName("miguFlag");
			if("Y"==packet.data.findValueByName("miguFlag")){
				jituanFlag=true;
			}
			else{
				jituanFlag=false;
			}
		}
		else{
			rdShowMessageDialog(s_ret_msg,1);
			submitFlag=true;
			return false;
		}
	}
	
	
	function enterAddNewUser(){
		ziFei="";
		diZhi=""		
		if(dizhiFlag){
			choseAddr($("input[type=radio][name=doType2]:checked")[0]);
		}
		if(zifeiFlag){
			choseZiFei($("input[type=radio][name=doZiFei2]:checked").val());
		}
		
		if(ziFei==""){
			rdShowMessageDialog("��С��δͨ��m337���������ʷѣ�����ϵ�����Ա����",1);
			return false;
		};
		if(diZhi==""){
			rdShowMessageDialog("��ѡ���ַ",1);
			return false;
		};
		if(submitFlag){
			rdShowMessageDialog("�����ʷ�δ������4977���棬����ϵ�����ʷѹ���Ա���д���",1);
			return false;
		};
		if(jituanFlag){
			rdShowMessageDialog("���ַ�ʽ������������ſ��(ki)��",1);
			return false;
		};
		$("#se276ziFei",window.parent.document).val(ziFei);
		$("#isse276",window.parent.document).val("1");
		window.parent.L("1","1100","�ͻ�����","sq100/sq100_1.jsp?retforwardflag=1","000");
		
	}
	function enterAddOldUser(){
		ziFei="";
		diZhi=""		
		if(dizhiFlag){
			choseAddr($("input[type=radio][name=doType2]:checked")[0]);
		}
		if(zifeiFlag){
			choseZiFei($("input[type=radio][name=doZiFei2]:checked").val());
		}
		if(ziFei==""){
			rdShowMessageDialog("��С��δͨ��m337���������ʷѣ�����ϵ�����Ա����",1);
			return false;
		};
		if(diZhi==""){
			rdShowMessageDialog("��ѡ���ַ",1);
			return false;
		};
		if(submitFlag){
			rdShowMessageDialog("�����ʷ�δ������4977���棬����ϵ�����ʷѹ���Ա���д���",1);
			return false;
		};
		if(jituanFlag){
			rdShowMessageDialog("���ַ�ʽ������������ſ��(ki)��",1);
			return false;
		};
		var h=450;
		var w=800;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;status:no;help:no";
		var ret=window.showModalDialog("showPhone.jsp?opCode=<%=opCode%>&opName=<%=opName%>&accp="+Math.random(),"",prop);
		$("#iCustName",window.parent.document).val(ret);
		$("#iCustName2",window.parent.document).val(ret);
		$("#iCustName",window.parent.document).val("�������ֻ������ѯ");
		$("#se276ziFei",window.parent.document).val(ziFei);
		if($("#iCustName2",window.parent.document).val()!='') {
			window.parent.addTabBySearchCustName2("1",'button');
		}
		
	}
	function showDiv(divName){
		if($("#"+divName).is(":hidden")){
			$("#"+divName).show();
		}
		else{
			$("#"+divName).hide();
		}
	}
	function blurDiv(divName){
		var activename=document.activeElement.id; // ��ǰ��ȡ����Ķ���
		if(activename==divName){
			
		}
		else{
			showDiv(divName);
		}
	}
	
	function addValue(mainName,divName,mainValue){
		$("#"+mainName).val(mainValue);
		showDiv(divName);
	}
</SCRIPT>
</head>
<body  style="overflow-y:auto; overflow-x:hidden;">
<form method=post name="pubService">	
<%
	if(!opCode.equals("e276")){
%>
<%@ include file="/npage/include/header_pop.jsp" %>
<%}else{%>
<%@ include file="/npage/include/header.jsp" %>
<%}%>
<div style="width:100%">
<div class="title" >
 <div id="title_zi">С����ѯ</div>	
</div>
<table>
	<tr>
		<td class="Blue" width="20%">С������</td>
		<td width="25%">
			<input id="area_name" name="area_name" style="padding-top:3px;" />
		</td>
		<td>
			<input  type="button" class="b_text" value="��ѯ" onclick="getAreaInfo()" />
			&nbsp;&nbsp;
			<input  type="button" class="b_text" value="GIS��ͼ" onclick="gisMapBtn()" />
		</td>
	</tr>
</table>
</div>

<div style="width:100%">
<div id="areaInfo"  style="display:none">
	<div class="title">
		<div id="title_zi">С����Ϣ</div>
	</div>
<table  cellSpacing="0" id="areaList">
	<tr>
  	  <th style="display:none;">
	    	&nbsp;
	    </th>
	    
			<th	nowrap>
	    	С������
	    </th>
	    <th nowrap>
	    	С����ַȫ��
	    </th>	
	    <th nowrap>
	    	��������
	    </th>
		<!-- <th>
			С���������
		</th> -->
		<th>
			С����������
		</th>
		<!-- <th>
			�������
		</th> -->
		<th>
			���ط�ʽ
		</th>
	    <th nowrap>
	    	¥��
	    </th>
	    <th nowrap>
	    	��Ԫ��
	    </th>
	    <th nowrap>
	    	��ѯ
	    </th>
	</tr>
	<tbody id="areaListBody">
	</tbody>
</table>
<div align="center">
		��<span name="nowPage">1</span>/<span name="allPage"></span>ҳ &nbsp;&nbsp;
		��<span name="allCon"></span>�� &nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('f',this)">��ҳ</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('p',this)">��һҳ</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('n',this)">��һҳ</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('e',this)">βҳ</a>]
</div>
 </div>	
</div>


<div style="width:100%">
<div id="standAddrInfo"  style="display:none">
	<div class="title">
		<div id="title_zi">��׼��ַ��Ϣ</div>	  
	</div>
<table cellspacing=0>
		<tr>
			<th id="standAddrChoose">ѡ��</th>
			<th>��׼��ַ��ϸ��Ϣ</th>
			<th>��Ԫ���ö˿���Դ����</th>
			<th>�Ѿ�ռ�ö˿���Դ����</th>
		</tr>
		<tbody id="standAddrList">
		</tbody>
</table>
<div align="center">
		��<span name="nowPage">1</span>/<span name="allPage"></span>ҳ &nbsp;&nbsp;
		��<span name="allCon"></span>�� &nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('f',this)">��ҳ</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('p',this)">��һҳ</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('n',this)">��һҳ</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('e',this)">βҳ</a>]
</div>
</div>
</div>
<br>
<div id="showTab2" style="width:100%"></div>


<div style="width:100%">
<div id="idleResInfo"  style="display:none">
	<div class="title">
		<div id="title_zi">������Դ�б�</div>
	</div>
	<table id="IdleResource" cellspacing=0>
	<tr>
		<%if(!opCode.equals("e276")){%>
   	  	<th nowrap>
 	    	&nbsp;
    	</th>
    	<%}%>
  	    <th  nowrap>
  	    	�豸����
  	    </th>
  	    <!--<th nowrap>
  	    	�豸����
  	    </th>	-->
  	    <th nowrap>
  	    	�ͺ�
  	    </td>	
  	    <th nowrap>
  	    	����
  	    </th>	
  	    <th nowrap>
  	    	IP��ַ
  	    </th>
  	    <th nowrap>
  	    	�豸��װ��ַ
  	    </th>	
  	     <th nowrap>
  	    	�˿�����
  	    </th>
  	    <!--<th nowrap>
  	    	�˿ڱ��
  	    </th>
  	    <th nowrap>
  	    ���žֱ���
  	    </th>-->
    </tr>			
</table>
</div>
</div>
<!-- 2017-01-18 liangyl  -->
<div  class="title" id="recordInfos" style="display: none"><!--��Դ���㣬�û���Ϣ��¼ģ��-->
 <div id="title_zi">�û���Ϣ��¼</div>	  

	<table cellspacing="0" >  
	   <tr>
	      <td class="Blue">�û�����</td>
	      <td > 
		       <input type="text" id="userName" name="userName">
		       <font color="orange">*</font>
	      </td>
	      <td class="Blue">��ϵ�绰</td>
	      <td> 
		       <input type="text" id="contractPhone" name="contractPhone">
		       <font color="orange">*</font>
	      </td>
	      <td class="Blue">����</td>
	      <td>
	      	<select id="county" name="county">
	      		<option></option>
	      	</select>
	      	<font color="orange">*</font>
	      </td>
	   </tr>
	   <tr>
	   		<td class="Blue">���̹���</td>
	      	<td>
	      		<div><input type="text" id="ownerShip" name="ownerShip" style="position:relative;" maxlength="20" value="��ͨ" onclick="showDiv('ownerShipDiv')" onblur="blurDiv('ownerShipDiv')"><font color="orange">*</font></div>
			    <div id="ownerShipDiv" style="position:absolute;z-index:1;display: none;background: white;width: 130;">
				    <ul style="overflow: auto;">
				    	<li onclick="addValue('ownerShip','ownerShipDiv','��ͨ');">��ͨ</li>
				    	<li onclick="addValue('ownerShip','ownerShipDiv','����');">����</li>
				    	<li onclick="addValue('ownerShip','ownerShipDiv','���');">���</li>
				    	<li onclick="addValue('ownerShip','ownerShipDiv','����');">����</li>
				    	<li onclick="addValue('ownerShip','ownerShipDiv','ũ��');">ũ��</li>
				    	<li onclick="addValue('ownerShip','ownerShipDiv','����');">����</li>
				    </ul>
			    </div>
	      	</td>
	      	<td class="Blue">С������</td>
	      	<td>
	      		<input type="text" id="userareaName"  name="userareaName" maxlength="50">
	      		<select id="userareaNameSel" onchange="$('#userareaName').val(this.value)" style="width: 400px">
		      	</select>
		      	<font color="orange">*</font>
	      	</td>
	   		<td class="Blue">�Ƿ������ֻ�</td>
	      	<td> 
		      <select id="bundMobile" name="bundMobile">
		      	<option value="��" selected="selected">��</option>
		      	<option value="��">��</option>
		      </select>
	      	</td>
	   </tr>
	   <tr>
	   		<td class="Blue">����</td>
	      	<td>
	      		<div><input type="text" id="bandWidth" name="bandWidth" style="position:relative;" maxlength="20" value="20M" onclick="showDiv('bandWidthDiv')" onblur="blurDiv('bandWidthDiv')"></div>
			    <div id="bandWidthDiv" style="position:absolute;z-index:1;display: none;background: white;width: 130;">
				    <ul>
				    	<li onclick="addValue('bandWidth','bandWidthDiv','20M');">20M</li>
				    	<li onclick="addValue('bandWidth','bandWidthDiv','50M');">50M</li>
				    	<li onclick="addValue('bandWidth','bandWidthDiv','100M');">100M</li>
				    </ul>
			    </div>
	      	</td>
	      	<td class="Blue">ǩԼ����</td>
	      	<td>
	      		<div><input type="text" id="ageLimit" name="ageLimit" style="position:relative;" maxlength="20" value="6����" onclick="showDiv('ageLimitDiv')" onblur="blurDiv('ageLimitDiv')"><font color="orange">*</font></div>
			    <div id="ageLimitDiv" style="position:absolute;z-index:1;display: none;background: white;width: 130;">
				    <ul>
				    	<li onclick="addValue('ageLimit','ageLimitDiv','6����');">6����</li>
				    	<li onclick="addValue('ageLimit','ageLimitDiv','1��');">1��</li>
				    	<li onclick="addValue('ageLimit','ageLimitDiv','2��');">2��</li>
				    </ul>
			    </div>
			    
	      	</td>
	   		
		      <td class="Blue">�Ƿ����������</td>
	      	<td>
	      		<select id="isIptv" name="isIptv">
			      	<option value="��">��</option>
			      	<option value="��" selected="selected">��</option>
			      </select>
	      	</td>
	   </tr>
	   <tr>
	   		<td class="Blue">�ʷѼ۸�</td>
		      <td > 
			       <input type="text" id="description" name="description" maxlength="20">
			       <font color="orange">*</font>
		      </td>
	      	<td class="Blue">Ԥ����ʱ��</td>
	      	<td>
	      		<div><input type="text" id="expireTime" name="expireTime" style="position:relative;" maxlength="40" value="3��������" onclick="showDiv('expireTimeDiv')" onblur="blurDiv('expireTimeDiv')"><font color="orange">*</font></div>
			    <div id="expireTimeDiv" style="position:absolute;z-index:1;display: none;background: white;width: 130;">
				    <ul>
				    	<li onclick="addValue('expireTime','expireTimeDiv','3��������');">3��������</li>
				    	<li onclick="addValue('expireTime','expireTimeDiv','3-6����');">3-6����</li>
				    	<li onclick="addValue('expireTime','expireTimeDiv','6��������');">6��������</li>
				    </ul>
			    </div>
			    
	      	</td>
	   		<td colspan="2">
	   			 <input  onClick="recordInfo()" type=button class="b_text" value="����" >
	   		</td>
	   </tr>
	</table>
	<input type="hidden" id="userareaName2" name="userareaName2">
	<input type="hidden" id="userareaCode2" name="userareaCode2">
</div>
					   <div id="footer" >
					   <%if(opCode.equals("e276")){%>
					   	<input class="b_foot"  onClick="enterAddOldUser()" style="cursor:hand" type=button value="���пͻ��������">&nbsp;
					   	<input class="b_foot"  onClick="enterAddNewUser()" style="cursor:hand" type=button value="�½��ͻ��������">&nbsp;
					   	<font class="red">���ַ�ʽ��֧�ֿ��������Ӫ����һ�����</font>&nbsp;
					   	<%}%>
					   	<input class="b_foot" id="ownerShipBut" disabled="disabled"  onClick="closeWin1()" style="cursor:hand" type=button value="������Ϣ¼��">&nbsp;
			      		<input class="b_foot"  onClick="closeWin()" style="cursor:hand" type=button value="�ر�">&nbsp;
						</div>
<input type="hidden" name="area_nameh" value=""><!--С������-->
<input type="hidden" name="area_codeh" value=""><!--С������-->
<input type="hidden" name="areaAddr" value=""><!--������������-->
<input type="hidden" name="bandWidth" value=""><!--����-->
<input type="hidden" name="enter_type" value=""><!--��������-->
<input type="hidden" name="dCode" value=""><!--¥��-->
<input type="hidden" name="addrCode" value=""><!--��׼��ַ-->
<input type="hidden" name="addrContent" value=""><!--��׼��ַ����-->

<input type="hidden" name="deviceType" value=""><!--�豸����-->
<input type="hidden" name="deviceCode" value=""><!--�豸����-->
<input type="hidden" name="model" value=""><!--�ͺ�-->
<input type="hidden" name="factory" value=""><!--����-->
<input type="hidden" name="ipAddress" value=""><!--ip��ַ-->
<input type="hidden" name="deviceInAddress" value=""><!--�豸��װ��ַ-->
<input type="hidden" name="portType" value=""><!--�˿�����-->
<input type="hidden" name="portCode" value=""><!--�˿ڱ��-->
<input type="hidden" name="cctId" value=""><!--���žֱ���-->
<input type="hidden" name="partnerCode" value=""><!--����������-->
<input type="hidden" name="belongCategory" value=""><!--������� 2014/04/03 11:10:26 gaopeng-->
<input type="hidden" name="bearType" value=""><!--���ط�ʽ 2014/04/03 11:10:28 gaopeng-->
<input type="hidden" name="propertyUnit" value=""><!--С���������� 2014/5/29 15:27:10-->
<input type="hidden" name="distKdCode" value=""><!--С������ 2014/5/29 15:27:10-->
<input type="hidden" name="nearInfo" value=""><!--С��������� 2014/5/29 15:27:10-->
<%@ include file="/npage/include/footer_pop.jsp" %>  
</form>
</body>
</html>