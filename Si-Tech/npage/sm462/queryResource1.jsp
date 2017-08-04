  
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.*"%>
<%@ page import="java.security.*" %>
<%@ page import="javax.crypto.*;" %>
<%@ page import="com.sitech.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
/*
* 功能: 宽带资源查询
* 版本: 1.0
* 日期: 2010-11-2
* 作者: lijy
* 版权: sitech
*/
%>

<%!
 
 //以下方法为加密方法
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
	//每个byte用两个字符才能表示，所以字符串的长度是数组长度的两倍
	StringBuffer sb = new StringBuffer(iLen * 2);
	for (int i = 0; i < iLen; i++) {
		int intTmp = arrB[i];
		//把负数转换为正数
		while (intTmp < 0) {
			intTmp = intTmp + 256;
		}
		//小于0F的数需要在前面补0
		if (intTmp < 16) {
			sb.append("0");
		}
		sb.append(Integer.toString(intTmp, 16));
	}
	return sb.toString();
}

private Key getKey(byte[] arrBTmp) throws Exception {
	//创建一个空的8位字节数组（默认值为0）
	byte[] arrB = new byte[8];
	//将原始字节数组转换为8位
	for (int i = 0; i < arrBTmp.length && i < arrB.length; i++) {
		arrB[i] = arrBTmp[i];
	}
	//生成密钥
	Key key = new javax.crypto.spec.SecretKeySpec(arrB, "DES");
	return key;
}

%>

<%!
/*2014/12/30 14:27:32 gaopeng 铁通融合项目 综合资管与PBOSS接口规范-新 将smCode进行了转换，从原来的kf ke kg变为数字代表
	这里写一个公共方法返回对应的字符串
*/
public String retSmCodeNewRule(String smCodeIn){
	String retStr = "";
	/*移动自建（移动自建）& 三方(移动自建)*/
	if("kf".equals(smCodeIn)){
		retStr = "1$2$5$6";
	}
	if("ki".equals(smCodeIn)){
		retStr = "1$6";
	}
	/*移动合建（铁通协同）*/
	if("kd".equals(smCodeIn)){
		retStr = "2";
	}
	/*省广电*/
	if("kg".equals(smCodeIn)){
		retStr = "3";
	}
	/*哈广电*/
	if("ke".equals(smCodeIn)){
		retStr = "4";
	}
	/*铁通（铁通自有）*/
	if("kh".equals(smCodeIn)){
		retStr = "5";
	}
	return retStr;
}



%>

<%
	System.out.println("==============资源查询界面=============== ");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
  String opCode = request.getParameter("opCode");
  String smCode = (String)request.getParameter("smCode") == null ? "" : (String)request.getParameter("smCode") ;
  String workNo = (String)session.getAttribute("workNo");
  String nopass = (String) session.getAttribute("password");/*操作员密码*/
  String groupId = (String) session.getAttribute("groupId");//区县代码
  String iObjectType = request.getParameter("iObjectType");
  System.out.println("gaopengSeeLog===regionCode========="+regionCode + " opCode=[" + opCode + "] smCode=[" + smCode +"]");
   String strSql = "select region_name from sregioncode where region_code='"+regionCode+"'";
	String regionName="";
	
	String opName="宽带资源查询";
	
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
   	  rdShowMessageDialog("查询地市名称错误,服务代码:<%=retCode2%><br>服务信息:<%=retMsg2%>");
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
<title>宽带资源查询</title>
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
	  	rdShowMessageDialog("宽带号码不能为空，请输入",2);
	  	document.all.area_name.focus();
	  }else{
	  	removeAreaInfo();
		var myPacket = new AJAXPacket("ajax_getAreaInfo1.jsp", "正在获取，请稍候......");
				myPacket.data.add("kuandaiNum", document.all.kuandaiNum.value);
				myPacket.data.add("iObjectType", "<%=iObjectType%>");
				myPacket.data.add("regionName", "<%=regionName%>" );
				/*2014/12/30 14:39:37 铁通融合项目 gaopeng 将smCode进行转义*/
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
   		 	      	showText = "其他";
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
   		 	      	showText = "虚拟资源";
   		 	      	defaultDCode = "1";
   		 	      }else{
   		 	      	showText = "其他";
   		 	      	defaultDCode = "1";
   		 	      }
	                
	                //小区建设性质
	                var propertyUnit = retLine[4];
	                var propertyUnitShowText = "";
	              	if(propertyUnit == "1"){
	              		propertyUnitShowText = "移动自建";
	              	}else if(propertyUnit == "2"){
	              		propertyUnitShowText = "移动合建";
	              	}else if(propertyUnit == "3"){
	              		propertyUnitShowText = "省广电";
	              	}else if(propertyUnit == "4"){
	              		propertyUnitShowText = "哈广电";
	              	}else if(propertyUnit == "5"){
	              		propertyUnitShowText = "铁通";
	              	}else if(propertyUnit == "6"){
	              		propertyUnitShowText = "三方";
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
	         	rdShowMessageDialog("没有查询到装机信息");
	         }
	     }
	}else if(retCode=="202" || retCode=="203"){
		rdShowMessageDialog("对不起，您输入的查询条件范围太大，请精确关键词后查询");	
		return false;
	}else{   
	   		rdShowMessageDialog(retMsg);
	   		return false;
	}
}

function removeAreaInfo(){
	/*清除 隐藏小区信息*/
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
 <div id="title_zi">小区查询</div>	
</div>
<table>
	<tr>
		<td class="Blue" width="20%">宽带号码</td>
		<td width="25%">
			<input id="kuandaiNum" name="kuandaiNum" style="padding-top:3px;" />
		</td>
		<td>
			<input  type="button" class="b_text" value="查询" onclick="getAreaInfo()" />
		</td>
	</tr>
</table>
</div>

<div style="width:100%">
<div id="areaInfo"  style="display:none">
	<div class="title">
		<div id="title_zi">装机信息</div>
	</div>
<table  cellSpacing="0" id="areaList">
	<tr>
  	  <th style="display:none;">
	    	&nbsp;
	    </th>
			<th	nowrap>
	    	产品关键字
	    </th>
	    <th nowrap>
	    	安装地址
	    </th>	
	    <th nowrap>
	    	占用端口
	    </th>
		<th>
			接入方式
		</th>
	    <th nowrap>
	    	建设性质
	    </th>
	</tr>
	<tbody id="areaListBody">
	</tbody>
</table>
 </div>	
</div>
<input type="hidden" name="area_nameh" value=""><!--小区名称-->
<input type="hidden" name="area_codeh" value=""><!--小区代码-->
<input type="hidden" name="areaAddr" value=""><!--所属市县名称-->
<input type="hidden" name="bandWidth" value=""><!--带宽-->
<input type="hidden" name="enter_type" value=""><!--入网类型-->
<input type="hidden" name="dCode" value=""><!--楼号-->
<input type="hidden" name="addrCode" value=""><!--标准地址-->
<input type="hidden" name="addrContent" value=""><!--标准地址内容-->

<input type="hidden" name="deviceType" value=""><!--设备类型-->
<input type="hidden" name="deviceCode" value=""><!--设备编码-->
<input type="hidden" name="model" value=""><!--型号-->
<input type="hidden" name="factory" value=""><!--厂家-->
<input type="hidden" name="ipAddress" value=""><!--ip地址-->
<input type="hidden" name="deviceInAddress" value=""><!--设备安装地址-->
<input type="hidden" name="portType" value=""><!--端口类型-->
<input type="hidden" name="portCode" value=""><!--端口编号-->
<input type="hidden" name="cctId" value=""><!--电信局编码-->
<input type="hidden" name="partnerCode" value=""><!--合作方编码-->
<input type="hidden" name="belongCategory" value=""><!--归属类别 2014/04/03 11:10:26 gaopeng-->
<input type="hidden" name="bearType" value=""><!--承载方式 2014/04/03 11:10:28 gaopeng-->
<input type="hidden" name="propertyUnit" value=""><!--小区建设性质 2014/5/29 15:27:10-->
<input type="hidden" name="distKdCode" value=""><!--小区编码 2014/5/29 15:27:10-->
<input type="hidden" name="nearInfo" value=""><!--小区接入情况 2014/5/29 15:27:10-->
<%@ include file="/npage/include/footer_pop.jsp" %>  
</form>
</body>
</html>