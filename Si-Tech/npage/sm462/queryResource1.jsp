  
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
  String iObjectType = request.getParameter("iObjectType");
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
		
	  if(document.all.kuandaiNum.value==""){
	  	rdShowMessageDialog("������벻��Ϊ�գ�������",2);
	  	document.all.area_name.focus();
	  }else{
	  	removeAreaInfo();
		var myPacket = new AJAXPacket("ajax_getAreaInfo1.jsp", "���ڻ�ȡ�����Ժ�......");
				myPacket.data.add("kuandaiNum", document.all.kuandaiNum.value);
				myPacket.data.add("iObjectType", "<%=iObjectType%>");
				myPacket.data.add("regionName", "<%=regionName%>" );
				/*2014/12/30 14:39:37 ��ͨ�ں���Ŀ gaopeng ��smCode����ת��*/
				myPacket.data.add("smCode", "<%=retSmCodeNewRule(smCode)%>" );
				core.ajax.sendPacket(myPacket,doGetAreaInfo);
				myPacket = null;
			}
}
var returnStr="";
var colFlag="N";
function doGetAreaInfo(packet)
{
	areaStr="";
	var retCode = packet.data.findValueByName("retCode");
  	var retMsg = packet.data.findValueByName("retMessage");
  
	if(retCode=="000000"){	
		var result= packet.data.findValueByName("result");
		var result1= packet.data.findValueByName("result1");
		returnStr=result1;
	   	 var temp1=result.split(",");
	   	 var temp2=temp1[2].split("=");
	     var  retLines=temp2[1].split("#");
	     $("#areaListBody").empty();
	     
	     for(var i=0;i<retLines.length;i++)
	     {
	    	 	colFlag="Y";
	     	   var retLine=retLines[i].split("%");	
	     	  	
	     	  // alert(retLine[0]+"--"+retLine[1]+"--"+retLine[2]+"--"+retLine[3]);
	     		 if(retLine[0]!=""){
   		 	      preReturn="1%";
   		 	      document.getElementById("areaInfo").style.display="";
   		 	      if(retLine[3] == "0"){
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
	                
	                //С����������
	                var propertyUnit = retLine[4];
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
	              	
	                var insertStr = "<tr onclick='returnBak();'>";
	                insertStr += "<td><input type='hidden'  name=productCode"+i+" value="+retLine[0]+">"+retLine[0]+"</td>";
	                insertStr += "<td><input type='hidden'  name=installAddress"+i+" value="+retLine[1]+">"+retLine[1]+"</td>";
	                insertStr += "<td><input type='hidden'  name=propertyUnit"+i+" value="+retLine[2]+">"+retLine[2]+"</td>";
	                insertStr += "<td><input type='hidden'  name=connectType"+i+" value="+retLine[3]+">"+retLine[3]+"</td>";
	                insertStr += "<td><input type='hidden'  name=propertyUnit"+i+" value="+retLine[4]+">"+retLine[4]+"</td>";
	                insertStr += "</tr>";
	                $("#areaListBody").append(insertStr);
	         
	         }else{
	         	rdShowMessageDialog("û�в�ѯ��װ����Ϣ");
	         }
	     }
	}else if(retCode=="202" || retCode=="203"){
		rdShowMessageDialog("�Բ���������Ĳ�ѯ������Χ̫���뾫ȷ�ؼ��ʺ��ѯ");	
		return false;
	}else{   
	   		rdShowMessageDialog(retMsg);
	   		return false;
	}
}

function removeAreaInfo(){
	/*��� ����С����Ϣ*/
	$("#areaListBody").empty();
}

function returnBak(){
	
//	var retInfo1="4%"+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type+"|"+addrCode+"|"+addrContent;
//	var retInfo2="|"+deviceType+"|"+deviceCode+"|"+model+"|"+factory+"|"+ipAddress+"|"+deviceInAddress+"|"+portType+"|"+portCode+"|"+cctId+"|"+partnerCode+"|"+belongCategory+"|"+bearType+"|"+propertyUnit+"|"+distKdCode+"|"+nearInfo;
//	var retInfo=retInfo1+retInfo2;
	opener.returnResBack(returnStr);
	window.close();
}

</SCRIPT>
</head>
<body  style="overflow-y:auto; overflow-x:hidden;">
<form method=post name="pubService">
<%@ include file="/npage/include/header.jsp" %>
<div style="width:100%">
<div class="title" >
 <div id="title_zi">С����ѯ</div>	
</div>
<table>
	<tr>
		<td class="Blue" width="20%">�������</td>
		<td width="25%">
			<input id="kuandaiNum" name="kuandaiNum" style="padding-top:3px;" />
		</td>
		<td>
			<input  type="button" class="b_text" value="��ѯ" onclick="getAreaInfo()" />
		</td>
	</tr>
</table>
</div>

<div style="width:100%">
<div id="areaInfo"  style="display:none">
	<div class="title">
		<div id="title_zi">װ����Ϣ</div>
	</div>
<table  cellSpacing="0" id="areaList">
	<tr>
  	  <th style="display:none;">
	    	&nbsp;
	    </th>
			<th	nowrap>
	    	��Ʒ�ؼ���
	    </th>
	    <th nowrap>
	    	��װ��ַ
	    </th>	
	    <th nowrap>
	    	ռ�ö˿�
	    </th>
		<th>
			���뷽ʽ
		</th>
	    <th nowrap>
	    	��������
	    </th>
	</tr>
	<tbody id="areaListBody">
	</tbody>
</table>
 </div>	
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