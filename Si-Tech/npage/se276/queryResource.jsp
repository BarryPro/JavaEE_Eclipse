  
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
$(function () {
	$("#isse276",window.parent.document).val("0");
	$("#userareaName").val("");
});

function gisMapBtn(){
			if(document.all.area_name.value==""){
		  	rdShowMessageDialog("小区名称不能为空，请输入");
		  	document.all.area_name.focus();
		  	return false;
	  	}
	  	var area_name = document.all.area_name.value.trim();
			var acName = "GIS地图";
			var iWidth = window.screen.availWidth-100; //弹出窗口的宽度;
			var iHeight = window.screen.availHeight-100; //弹出窗口的高度;
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
	  	rdShowMessageDialog("小区名称不能为空，请输入",2);
	  	document.all.area_name.focus();
	  }else{
	  	removeAreaInfo();
	  	removeStandardAddr();
	  	removeAreaResource();
		var myPacket = new AJAXPacket("ajax_getAreaInfo.jsp", "正在获取，请稍候......");
				myPacket.data.add("area_name", document.all.area_name.value);
				myPacket.data.add("regionName", "<%=regionName%>" );
				/*2014/12/30 14:39:37 铁通融合项目 gaopeng 将smCode进行转义*/
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
	     		 	      	showText = "铁通PON";
	     		 	      }else if(retLine[4] == "1"){
	     		 	      	showText = "铁通AD";
	     		 	      	defaultDCode = "1";
	     		 	      }if(retLine[4] == "2"){
	     		 	      	showText = "广电";
	     		 	      	defaultDCode = "1";
	     		 	      }*/
	     		 	      if(retLine[2] == "0"){
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
	                //$("#areaListBody").append("<tr style='cursor:pointer;' onclick='setRadio("+i+")'><td style=\"display:none;\"><input type=radio style=\"display:none;\" onclick='choseAreaInfo()' id='doType1' name='doType1' RIndex1=" +i+ " value="+ i + "></td><td><input type='hidden'   name=areaName"+i+" value="+retLine[0]+">"+retLine[0]+"</td><td style='display:none'><input type='hidden'   name=areaCode"+i+" value="+retLine[1]+">"+retLine[1]+"</td><td><input type='hidden'  name=areaAddr"+i+" value="+retLine[2]+">"+retLine[2]+"</td><td><input type='hidden'  name=bandWidth"+i+" value="+retLine[3]+">"+retLine[3]+"</td><td><input type='hidden'  name=enterType"+i+" value="+retLine[4]+">"+showText+"</td><td><input type='text' name=dCode"+i+" value='"+defaultDCode+"' /><input type='button' name='search' onclick='getStandardAddr("+i+")' value='查询' class='b_text'/></td></tr>");
	                /*2013/2/27 星期三 13:55:05 gaopeng sGetAreaInfo 服务返回字符串拼接  加入 stationCode 电信局编码 和 partnerCode 合作方编码*/
	                
	                //小区编码
	                var distKdCode = retLine[5];
	                //小区接入情况
	                var nearInfo = retLine[6];
	                //小区建设性质
	                var propertyUnit = retLine[7];
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
	              	//20161205 liangyl增加 乡镇=2 枚举值
	                //归属类别 0城市1农村2乡镇
	                var belongCategory = retLine[8];
	                var belongCategoryShowText="";
	                if(belongCategory==0){
	                	belongCategoryShowText="城市";
	                }
	                else if(belongCategory==1){
	                	belongCategoryShowText="农村";
	                }
	                else if(belongCategory==2){
	                	belongCategoryShowText="乡镇";
	                }
	                //承载方式 0有线1无线
	                var bearType = retLine[9];
	                var bearTypeShowText = bearType == 0 ? "有线" : "无线";
	                
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
	                insertStr += "<input type='button' name='search' onclick='getStandardAddr("+i+")' value='查询' class='b_text'/>";
	                insertStr += "</td>";
	                insertStr += "</tr>";
	                $("#areaListBody").append(insertStr);
	                
	                /**
	                $("#areaListBody").append("<tr style='cursor:pointer;' onclick='setRadio("+i+")'><td style=\"display:none;\"><input type=radio style=\"display:none;\" onclick='choseAreaInfo()' id='doType1' name='doType1' RIndex1=" +i+ " value="+ i + "></td><td style='display:none'><input type='hidden'   name=areaCode"+i+" value="+retLine[1]+">"+retLine[1]+"</td><td><input type='hidden'  name=areaAddr"+i+" value="+retLine[0]+">"+retLine[0]+"</td><td><input type='hidden'  name=enterType"+i+" value="+retLine[2]+">"+showText+"</td><td><input type='text' name=dCode"+i+" value='"+defaultDCode+"' /><input type='hidden' name=stationCode"+i+" value='"+retLine[3]+"' /><input type='hidden' name=partnerCode"+i+" value='"+retLine[4]+"' /><input type='button' name='search' onclick='getStandardAddr("+i+")' value='查询' class='b_text'/></td></tr>");
	                **/
	         }else{
	         	rdShowMessageDialog("没有查询到该小区");
	         }
	     }
	     areaStr=areaStr.substring(0,areaStr.length-1);
	     //alert(areaStr);
	     splitPage($("#areaInfo"));
	}else if(retCode=="202" || retCode=="203"){
		rdShowMessageDialog("对不起，您输入的查询条件范围太大，请精确关键词后查询");	
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
//小区信息选择 /*2013/2/27 星期三 14:10:46 gaopeng 小区信息选择，给隐藏域赋值，增加两个隐藏域 1：电信局编码 2.合作方编码*/
function choseAreaInfo(m)
{
	$("#areaList tr").css("background-color","white");//将所有行底色置为白色
	for(var i=0;i<$("#areaList tr").length-1;i++)
	{ 
		var dCodeNu="dCode"+i;
		//$("#areaList :input[name='dCodeNu']").val("");
		if(m != i){
			document.all(dCodeNu).value="";//将原先楼号的输入置空	
		}
		if ($("#areaList :input[type='radio']").attr("name")=="doType1")
		{   
			if($("#areaList :input[type='radio']").get(i).checked==true)
			{ 
				$("#areaList tr:eq('" + (i+1) + "')").css("background-color","#CADFFE");//将选择的行背景变色
				//判断是否被选中
				rIndex = i;
				objCode0 = "areaName" + rIndex ;
				objCode1 = "areaCode" + rIndex ;
				objCode2 = "areaAddr" + rIndex ;
				objCode4 = "bandWidth" + rIndex ;
				/*接入类型*/
				objCode5 = "enterType" + rIndex ;
				objCode6= "dCode" + rIndex ;	
				/*2013/2/27 星期三 14:14:02 gaopeng  电信局编码*/	
				objCode7 ="stationCode" +	rIndex;
				/*2013/2/27 星期三 14:14:02 gaopeng  合作方编码*/	
				objCode8 ="partnerCode" +	rIndex; 	
				/*2014/04/03 10:59:41 gaopeng 归属类别*/
				objCode9 = "belongCategory" +	rIndex;
				/*2014/04/03 10:59:41 gaopeng 承载方式*/
				objCode10 = "bearType" +	rIndex;
				objCode11 = "propertyUnit" +	rIndex;/* 小区建设性质 */
				objCode12 = "distKdCode" +	rIndex;/* 小区编码 */
				objCode13 = "nearInfo" +	rIndex;/* 小区接入情况 */
				

				
				document.all.area_nameh.value="";//小区名称
				document.all.area_codeh.value=document.all(objCode1).value;//小区代码
				document.all.areaAddr.value=document.all(objCode2).value;//小区地址
				document.all.bandWidth.value="";//带宽
				document.all.enter_type.value=document.all(objCode5).value;//入网类型 (接入类型)
				document.all.cctId.value=document.all(objCode7).value;//电信局编码
				//document.all.cctId.value="80045";//电信局编码
				document.all.partnerCode.value=document.all(objCode8).value;//合作方编码
				/*2014/04/03 10:59:17 gaopeng 增加两个隐藏域 归属类别 承载方式*/
				document.all.belongCategory.value=document.all(objCode9).value;//合作方编码
				document.all.bearType.value=document.all(objCode10).value;//合作方编码
				
				document.all.propertyUnit.value=document.all(objCode11).value;//小区建设性质
				
				document.all.distKdCode.value=document.all(objCode12).value;//小区建设性质
				document.all.nearInfo.value=document.all(objCode13).value;//小区建设性质
				
				
				
				
				//document.all.partnerCode.value="1100000000";//合作方编码
				//document.all.dCode.value=$(bt).parent().parent().find("td:eq(6)").find("input").val();//楼号
				//alert(document.all.area_nameh.value+" "+document.all.area_codeh.value+" "+document.all.areaAddr.value+" "+document.all.bandWidth.value+" "+document.all.enter_type.value);
			}
		}
	}
}
//获取标准地址
/*2013/2/27 星期三 14:19:22 gaopeng sGStandAddr 服务返回拼接 */
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
	var dCode;//楼号
	var connectType;//接入类型
	var buildNoVal;
	var unitNoVal;
	var propertyUnitVal;//小区建设性质
	/* 是否继续办理，品牌与小区不符合要跳出 */
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
			
			//楼号  buildNo
			buildNoVal = $(n).parent().parent().find("td").find("input[name^='buildNo']").val();
			//单元号  unitNo
			unitNoVal = $(n).parent().parent().find("td").find("input[name^='unitNo']").val();
			propertyUnitVal = $(n).parent().parent().find("td").find("input[name^='propertyUnit']").val();
			/**
		//alert("dCode======"+dCode);
			alert("connectType======"+connectType + " smcode " + "<%=smCode%>");
			//alert("buildNoVal= " + buildNoVal + "   unitNoVal= " + unitNoVal);
			**/
			/*** 	0-pon 咱们开铁通的 ；
						1-铁通ad 提示用户去铁通营业厅开户 ； 
						这里改了，支持ADSL了。ningtn
						2-广电 咱们开广电的  
			**/
			if("<%=opCode%>" !="e276"&&"<%=opCode%>" !="m462"){
				/*2014/11/19 10:48:52 gaopeng
					修改原有逻辑，全部替换为小区建设性质与品牌进行对比，不一致则提示信息
				*/
				var ppName = retPPName(propertyUnitVal);
				if($.trim("<%=retSmCodeNewRule(smCode)%>").indexOf($.trim(propertyUnitVal)) == -1){
					rdShowMessageDialog("您选择的小区只能开通小区建设性质为"+ppName);
					conFlag = false;
					window.close();
				}
				/*
				if(connectType == "0" && "<%=smCode%>" != "kd"||&& "<%=smCode%>" != "IM"){
					rdShowMessageDialog("您选择的小区只能开铁通品牌的宽带");
					conFlag = false;
					window.close();
				}
				*/
				/*else if(connectType == "1" && "<%=smCode%>" != "kf"){
					rdShowMessageDialog("您选择的小区只能开移动宽带");
					conFlag = false;
					window.close();
				}*/
				/*else if(connectType == "2" && "<%=smCode%>" != "ke"){
					rdShowMessageDialog("您选择的小区只能开广电品牌的宽带");
					conFlag = false;
					window.close();
				*/
				/* 
			   * 关于协助开发省广电合作宽带话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
			   * 新增省广电kg，备用品牌kh，规则与kg相同，只是资源查询时接入类型为“9”。
			   */
			   /*
				}else if(connectType == "9" && "<%=smCode%>" != "kh" ){
					rdShowMessageDialog("您选择的小区只能开kh品牌的宽带");
					conFlag = false;
					window.close();
				}
				if(connectType == "1" && "<%=smCode%>" == "kf" ){
					if( propertyUnitVal == "广电"){
						rdShowMessageDialog("您选择的小区只能开小区建设性质为非广电品牌的宽带");
						conFlag = false;
						window.close();
					}
				}
				if(connectType == "1" && "<%=smCode%>" == "kg" ){
					if(propertyUnitVal != "广电"){
						rdShowMessageDialog("您选择的小区只能开小区建设性质为广电品牌的宽带");
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
			rdShowMessageDialog("你没有选择小区！请选择一项");
			return false;
		} 
		/* 注释掉，楼号为空也可以查询
		if(dCode<1 || dCode>100 || dCode==null || dCode=="" )
		{
			 rdShowMessageDialog("输入楼号不正确，请重新输入",1);
				return false;
		}else{*/
			document.all.dCode.value=dCode;
		/*}*/
		
		
		if("<%=opCode%>" =="e276"){	
			//alert("e276获取");
				var myPacketss = new AJAXPacket("ajax_queryofferid.jsp","正在查询信息，请稍候......");
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
				if(rdShowMessageDialog("你已经查询了标准地址，确定要删除且重新查询吗？")==1)
				{
					removeStandardAddr();
					removeAreaResource();
					$("#standAddrList tr").remove();
					getStandardAddr(i);
			   }
		}else{
			removeStandardAddr();
			removeAreaResource()
		//	alert("不是e276获取");
					var myPacket = new AJAXPacket("ajax_getStandardAddr.jsp", "正在获取，请稍候......");
					//alert(AreaCode);
					//alert(dCode);
					myPacket.data.add("areaCode", AreaCode);
					myPacket.data.add("dCode", dCode );	  
					myPacket.data.add("buildNo", buildNoVal );
					myPacket.data.add("unitNo", unitNoVal );
					/*2014/11/10 10:00:20 gaopeng 增加入参 接入类型 和 小区建设性质*/
					//alert("aaaa---connectType="+connectType+",propertyUnitVal="+propertyUnitVal);
					myPacket.data.add("connectType", connectType );
					myPacket.data.add("propertyUnitVal", propertyUnitVal);
					core.ajax.sendPacket(myPacket,doGetStandardAddr);
					myPacket = null;
	  }
	}
}
/*2014/11/19 11:05:06 gaopeng 宽带项目 增加通过小区建设性质 返回对应的品牌名称*/
function retPPName(propertyUnitVal){
	var ppName = "";
	if(propertyUnitVal == "2"){
		ppName = "铁通(协同)品牌(kd)的宽带";
	}
	if(propertyUnitVal == "1"||propertyUnitVal == "6"){
		ppName = "移动品牌(kf)宽带";
	}
	if(propertyUnitVal == "3"){
		ppName = "省广电品牌(kg)的宽带";
	}
	if(propertyUnitVal == "4"){
		ppName = "哈广电品牌(ke)的宽带";
	}
	if(propertyUnitVal == "5"){
		ppName = "铁通(自有)品牌(kh)的宽带";
	}
	return ppName;
	
}
/*标准地址查询 ajax回调函数*/
var areaStr2="";
function doGetStandardAddr(packet)
{
	areaStr2="";
	var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMessage");
  
  /*if(true){*/
	if(retCode=="000000"){	
	     var	result= packet.data.findValueByName("result");
	     
	     //result="fieldChName=地址全称%地址编码#地址全称%地址编码#地址全称%地址编码#地址全称%地址编码#地址全称%地址编码,fieldEnName=addressId%addressCode#addressId%addressCode#addressId%addressCode#addressId%addressCode#addressId%addressCode,fieldContent=黑龙江/哈尔滨/南岗区/测试社区/学府路/测试65号1栋3单元%T_SPACE_STANDARD_ADDRESS-8aee349d336479490133685be8cb1411%freePortNo%occupyPortNo#黑龙江/哈尔滨/南岗区/测试社区/学府路/测试65号1栋2单元%T_SPACE_STANDARD_ADDRESS-8aee349d336479490133685be8411410%freePortNo%occupyPortNo#黑龙江/哈尔滨/南岗区/测试社区/学府路/测试65号1栋1单元%T_SPACE_STANDARD_ADDRESS-8aee349d336479490133685be787140f%freePortNo%occupyPortNo#黑龙江/哈尔滨/南岗区/测试社区/学府路/测试65号1栋5单元%T_SPACE_STANDARD_ADDRESS-8aee349d336479490133685be9dc1413%freePortNo%occupyPortNo#黑龙江/哈尔滨/南岗区/测试社区/学府路/测试65号1栋4单元%T_SPACE_STANDARD_ADDRESS-8aee349d336479490133685be9681412%freePortNo%occupyPortNo";
	   	 var temp1=result.split(",");
	   	 var temp2=temp1[2].split("=");
	     var  retLines=temp2[1].split("#");
	     for(var i=0;i<retLines.length;i++)
	     {
	     	   var temp3=retLines[i].split("%");	
	     		 if(!(temp3[0]=="1") && !(temp3[0]=="2")){
	     		 	      preReturn="2%";
	     		 	      document.getElementById("standAddrInfo").style.display="";
	     		 	      /*2013/2/27 星期三 14:37:13 gaopeng 关于协助开发光纤到户FTTH模式有线宽带业务支撑需求的函 把下面的单选按钮放在这里 */
	                //$("#standAddrList").append("<tr onclick='choseStanAdd(this)' style='cursor:pointer;'><td><input type=radio onclick='choseRes()' id='doType2' name='doType2' RIndex2=" +i+ "></td><td style=\"display:none;\">"+temp3[1]+"</td><td>"+temp3[0]+"</td></tr>");          
									/*gaopeng 将以下的 doGetIdleRes 回调方法去掉，改为在标准地址信息位置加入单选按钮(如果是弹出页面进来的) */
									if("<%=opCode%>" !="e276"){
										/*这货这回是调用 choseRes()，用来给4977或者其他的功能返回参数，实际上是干了三件事，第一：调用ajaxGetPartnerName.jsp 返回合作方名称等；第二：调用ajaxGetCctName.jsp 返回电信局名称 第三：返回一堆没啥用的隐藏域参数*/
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
	         	rdShowMessageDialog("没有查询到该小区标准地址");
	         }
	     }
	     areaStr2=areaStr2.substring(0,areaStr2.length-1);
	     splitPage($("#standAddrInfo"));
	}else{   
	   		rdShowMessageDialog(retCode+"--"+retMsg);	
	   		return false;
	}

}
//标准地址的选择2013/2/26 星期二 10:19:50 gaopeng 关于协助开发光纤到户FTTH模式有线宽带业务支撑需求的函 和谐getAreaResource 方法
function choseStanAdd(sObject)
{
	for(var i=0;i<$("#standAddrList tr").length-1;i++)
	{
		$("#standAddrList tr").css("background-color","white");
	}
	//var e = arguments[0] || window.event;
	//var trCur = e.srcElement.parentNode || e.target.parentNode;	
	/*2013/2/28 星期四 11:11:35 gaopeng FTTH需求，因为第三个服务去掉了，页面的单选按钮也上移，所以这里的逻辑需要修改
		如果opcode不是e276的时候，取第二和第三个td参数，否则，取第一个第二个td参数
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
			 $("#IdleResource tr:gt(0)").remove(); //原先选择的标准地址的删除
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
	/*2013/2/28 星期四 11:11:35 gaopeng FTTH需求，因为第三个服务去掉了，页面的单选按钮也上移，所以这里的逻辑需要修改
		如果opcode不是e276的时候，取第二和第三个td参数，否则，取第一个第二个td参数
	*/
	
		document.all.addrCode.value=sObject.getElementsByTagName("td")[1].innerHTML;
		document.all.addrContent.value=sObject.getElementsByTagName("td")[2].innerHTML;
	
	
	if(document.getElementById("IdleResource").rows.length>1){	 
			 $("#IdleResource tr:gt(0)").remove(); //原先选择的标准地址的删除
			 $(sObject).css("background-color","#CADFFE");
		   //alert("chossed standardAddress-------"+document.all.addrCode.value+"  "+document.all.addrContent.value);
			 //getAreaResource(document.all.addrCode.value,document.all.enter_type.value,document.all.bandWidth.value);
	}else{
		   $(sObject).css("background-color","#CADFFE");
		   //alert("chossed standardAddress-------"+document.all.addrCode.value+"  "+document.all.addrContent.value);
			 //getAreaResource(document.all.addrCode.value,document.all.enter_type.value,document.all.bandWidth.value);
  }
	
}
//空闲资源的查询
function getAreaResource(addrCode,enterType,bandWidth)
{
	bandWidth="100M";
	removeAreaResource();
	var myPacket = new AJAXPacket("ajax_getIdleResource.jsp", "正在获取，请稍候......");
				myPacket.data.add("addrCode", addrCode);
				myPacket.data.add("productType", "12" );	 
				myPacket.data.add("enterType", enterType); 
				myPacket.data.add("bandWidth", bandWidth); 
				core.ajax.sendPacket(myPacket,doGetIdleRes);
				myPacket = null;
}
function doGetIdleRes(packet) //无用
{
	var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMessage");
   if(retCode != "000000"){
			/* 	原来用retcode判断是否无端口，不用了，已经删除
					改成如果为空就是无端口了。
			 */
			rdShowMessageDialog("调用资源接口失败,"+retMsg);
			return false;
 	 }else{
 	 		var result=packet.data.findValueByName("result");
 	 		if(result == null || typeof(result) == undefined){
 	 			if(rdShowConfirmDialog("没有查询到相关资源，是否继续办理业务?")==1)
	 			{
	 			  		var addrCode=document.all.addrCode.value;//标准地址
							var addrContent=document.all.addrContent.value;//标准地址内容
							var area_name=document.all.area_nameh.value;//小区名称
							var area_code=document.all.area_codeh.value;//小区代码
							var areaAddr=document.all.areaAddr.value;// 
							var bandWidth=document.all.bandWidth.value;//带宽
							var enter_type=document.all.enter_type.value;//入网类型
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

//空闲资源的选择
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
			 $("#IdleResource tr:gt(0)").remove(); //原先选择的标准地址的删除
			 $(m.parentNode.parentNode).css("background-color","#CADFFE");
	}else{
		   $(m.parentNode.parentNode).css("background-color","#CADFFE");
  }
	var addrCode=document.all.addrCode.value;//标准地址
	var addrContent=document.all.addrContent.value;//标准地址内容
	var area_name=document.all.area_nameh.value;//小区名称
	var area_code=document.all.area_codeh.value;//小区代码
	var areaAddr=document.all.areaAddr.value;// 
	var bandWidth=document.all.bandWidth.value;//带宽
	var enter_type=document.all.enter_type.value;//入网类型
	/*2013/2/27 星期三 15:14:22 gaopeng FTTH需求，去掉IdleResource 这个列的显示，所以它的逻辑都去掉，直接赋值从deviceType到portCode为空，cctId和partnerCode是第一个服务查询出来的，直接在隐藏域中*/
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
				
				/*2014/04/03 11:12:52 gaopeng 归属类别 承载方式*/
				var 	belongCategory = document.all.belongCategory.value;
				var 	bearType = document.all.bearType.value;
				var   propertyUnit = document.all.propertyUnit.value;
				
				/*2014/06/24 14:59:54 gaopeng 小区接入情况*/
				var   nearInfo = document.all.nearInfo.value;
				/*2014/06/24 15:00:06 gaopeng 小区编码*/
				var   distKdCode = document.all.distKdCode.value;
				
				/*	2014/06/24 15:05:25 gaopeng 打印 小区编码 小区接入情况 小区建设性质
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
					/* 铁通无端口情况 */
					/*if(rdShowConfirmDialog("此资源为无端口情况，是否继续办理业务?")==1)
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
					/* 广电无端口情况 */
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
		rdShowMessageDialog("请选择地址!",1);
		return false;
	}
	document.all.addrCode.value=m.parentNode.parentNode.getElementsByTagName("td")[1].innerHTML;
	document.all.addrContent.value=m.parentNode.parentNode.getElementsByTagName("td")[2].innerHTML;
	if(document.getElementById("IdleResource").rows.length>1){	 
			 $("#IdleResource tr:gt(0)").remove(); //原先选择的标准地址的删除
			 $(m.parentNode.parentNode).css("background-color","#CADFFE");
	}else{
		   $(m.parentNode.parentNode).css("background-color","#CADFFE");
  }
	var addrCode=document.all.addrCode.value;//标准地址
	var addrContent=document.all.addrContent.value;//标准地址内容
	var area_name=document.all.area_nameh.value;//小区名称
	var area_code=document.all.area_codeh.value;//小区代码
	var areaAddr=document.all.areaAddr.value;// 
	var bandWidth=document.all.bandWidth.value;//带宽
	var enter_type=document.all.enter_type.value;//入网类型
	/*2013/2/27 星期三 15:14:22 gaopeng FTTH需求，去掉IdleResource 这个列的显示，所以它的逻辑都去掉，直接赋值从deviceType到portCode为空，cctId和partnerCode是第一个服务查询出来的，直接在隐藏域中*/
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
				
				/*2014/04/03 11:12:52 gaopeng 归属类别 承载方式*/
				var 	belongCategory = document.all.belongCategory.value;
				var 	bearType = document.all.bearType.value;
				var   propertyUnit = document.all.propertyUnit.value;
				
				/*2014/06/24 14:59:54 gaopeng 小区接入情况*/
				var   nearInfo = document.all.nearInfo.value;
				/*2014/06/24 15:00:06 gaopeng 小区编码*/
				var   distKdCode = document.all.distKdCode.value;
				
				/*	2014/06/24 15:05:25 gaopeng 打印 小区编码 小区接入情况 小区建设性质
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
					/* 铁通无端口情况 */
					/*if(rdShowConfirmDialog("此资源为无端口情况，是否继续办理业务?")==1)
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
					/* 广电无端口情况 */
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
	/*清除 隐藏小区信息*/
	$("#areaListBody").empty();
	$("#areaInfo").hide();
}
function removeStandardAddr(){
	/*清除 隐藏标准地址信息*/
	$("#standAddrList tr").remove();
	$("#standAddrInfo").hide();
}
function removeAreaResource(){
	/*清除 隐藏空闲资源信息*/
	$("#IdleResource tr:gt(0)").remove();
	$("#idleResInfo").hide();
}
function closeWin(){
	var retInfo="";
	if(preReturn=="0%" && document.all.area_name.value!=""){
		if(rdShowConfirmDialog("没有查询到相关资源，是否退出查询?")==1){
			if(rdShowConfirmDialog("是否可提供相关信息，待有资源时通知?")==1){
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
	}else if(preReturn=="1%" && queRes=="0"){//标准地址查询失败
		if(rdShowConfirmDialog("没有查询到相关资源，是否退出查询?")==1){
			if(rdShowConfirmDialog("是否可提供相关信息，待有资源时通知?")==1){
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
		
		/*var area_name=document.all.area_nameh.value;//小区名称
	  var area_code=document.all.area_codeh.value;//小区代码
	  var areaAddr=document.all.areaAddr.value;//所属市县名称
	  var bandWidth=document.all.bandWidth.value;//带宽
	  var enter_type=document.all.enter_type.value;//入网类型
	  retInfo=preReturn+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type;
		opener.returnResBack(retInfo);  */
		
	}else if (preReturn=="2%"  && queRes=="0"){//空闲资源查询失败
		if(rdShowConfirmDialog("没有查询到相关资源，是否退出查询?")==1){
			if(rdShowConfirmDialog("是否可提供相关信息，待有资源时通知?")==1){
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
		/*rdShowMessageDialog("没有查询到资源",2);
		var area_name=document.all.area_nameh.value;//小区名称
	  var area_code=document.all.area_codeh.value;//小区代码
	  var bandWidth=document.all.bandWidth.value;//带宽
	  var enter_type=document.all.enter_type.value;//入网类型
	  
	  var addrCode=document.all.addrCode.value;//标准地址
	  var addrContent=document.all.addrContent.value;//标准地址内容
	  
	  retInfo=preReturn+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type+"|"+addrCode+"|"+addrContent;
		opener.returnResBack(retInfo); */
		
	}else if (preReturn=="3%"  ){//有设备无端口

	}else if (preReturn=="4%"  ){//有设备有端口
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
	//	if(rdShowConfirmDialog("没有查询到相关资源，是否退出查询?")==1){
			if(rdShowConfirmDialog("是否需要手动录入友商信息?")==1){
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
	}else if(preReturn=="1%" && queRes=="0"){//标准地址查询失败
		//if(rdShowConfirmDialog("没有查询到相关资源，是否退出查询?")==1){
			if(rdShowConfirmDialog("是否需要手动录入友商信息?")==1){
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
		
		/*var area_name=document.all.area_nameh.value;//小区名称
	  var area_code=document.all.area_codeh.value;//小区代码
	  var areaAddr=document.all.areaAddr.value;//所属市县名称
	  var bandWidth=document.all.bandWidth.value;//带宽
	  var enter_type=document.all.enter_type.value;//入网类型
	  retInfo=preReturn+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type;
		opener.returnResBack(retInfo);  */
		
	}else if (preReturn=="2%"  && queRes=="0"){//空闲资源查询失败
	//	if(rdShowConfirmDialog("没有查询到相关资源，是否退出查询?")==1){
			if(rdShowConfirmDialog("是否需要手动录入友商信息?")==1){
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
		/*rdShowMessageDialog("没有查询到资源",2);
		var area_name=document.all.area_nameh.value;//小区名称
	  var area_code=document.all.area_codeh.value;//小区代码
	  var bandWidth=document.all.bandWidth.value;//带宽
	  var enter_type=document.all.enter_type.value;//入网类型
	  
	  var addrCode=document.all.addrCode.value;//标准地址
	  var addrContent=document.all.addrContent.value;//标准地址内容
	  
	  retInfo=preReturn+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type+"|"+addrCode+"|"+addrContent;
		opener.returnResBack(retInfo); */
		
	}else if (preReturn=="3%"  ){//有设备无端口

	}else if (preReturn=="4%"  ){//有设备有端口
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
//获取区县
function go_getDisName(){
	var myPacket = new AJAXPacket("ajax_getDisName.jsp", "正在插入，请稍候......");
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
//获取页面小区
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

//获取小区
function go_getAreaName(){
	var myPacket = new AJAXPacket("ajax_getAreaName.jsp", "正在插入，请稍候......");
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
		rdShowMessageDialog("用户名称不能为空，请输入",0);
		return false;
	}
	
	if($("#contractPhone").val()==""){
		rdShowMessageDialog("联系电话不能为空，请输入",0);
		return false;
	}
	if($("#county").val()==""){
		rdShowMessageDialog("区县不能为空，请输入",0);
		return false;
	}
	if($("#ownerShip").val()==""){
		rdShowMessageDialog("友商归属不能为空，请输入",0);
		return false;
	}
	if($("#userareaName").val()==""){
		rdShowMessageDialog("小区名称不能为空，请输入",0);
		return false;
	}
	if($("#ageLimit").val()==""){
		rdShowMessageDialog("签约年限不能为空，请输入",0);
		return false;
	}
	if($("#description").val()==""){
		rdShowMessageDialog("资费价格不能为空，请输入",0);
		return false;
	}
	if($("#expireTime").val()==""){
		rdShowMessageDialog("预到期时间不能为空，请输入",0);
		return false;
	}
	
	
	var myPacket = new AJAXPacket("ajax_recordInfo.jsp", "正在插入，请稍候......");
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
  	rdShowMessageDialog("记录缺少资源信息失败,"+retMsg);
  	return false;
  }else{
  	  rdShowMessageDialog("记录成功",2);
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
		//找到添加表格的div
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
			var myPacket = new AJAXPacket("checkProductOffer.jsp", "正在查询资费是否存在，请稍候......");
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
		var myPacket = new AJAXPacket("checkJituanOffer.jsp", "正在查询是否集团资费，请稍候......");
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
			rdShowMessageDialog("此小区未通过m337界面配置资费，请联系相关人员配置",1);
			return false;
		};
		if(diZhi==""){
			rdShowMessageDialog("请选择地址",1);
			return false;
		};
		if(submitFlag){
			rdShowMessageDialog("此主资费未发布到4977界面，请联系地市资费管理员进行处理",1);
			return false;
		};
		if(jituanFlag){
			rdShowMessageDialog("此种方式不允许办理“集团宽带(ki)”",1);
			return false;
		};
		$("#se276ziFei",window.parent.document).val(ziFei);
		$("#isse276",window.parent.document).val("1");
		window.parent.L("1","1100","客户开户","sq100/sq100_1.jsp?retforwardflag=1","000");
		
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
			rdShowMessageDialog("此小区未通过m337界面配置资费，请联系相关人员配置",1);
			return false;
		};
		if(diZhi==""){
			rdShowMessageDialog("请选择地址",1);
			return false;
		};
		if(submitFlag){
			rdShowMessageDialog("此主资费未发布到4977界面，请联系地市资费管理员进行处理",1);
			return false;
		};
		if(jituanFlag){
			rdShowMessageDialog("此种方式不允许办理“集团宽带(ki)”",1);
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
		$("#iCustName",window.parent.document).val("请输入手机号码查询");
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
		var activename=document.activeElement.id; // 当前获取焦点的对象
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
 <div id="title_zi">小区查询</div>	
</div>
<table>
	<tr>
		<td class="Blue" width="20%">小区名称</td>
		<td width="25%">
			<input id="area_name" name="area_name" style="padding-top:3px;" />
		</td>
		<td>
			<input  type="button" class="b_text" value="查询" onclick="getAreaInfo()" />
			&nbsp;&nbsp;
			<input  type="button" class="b_text" value="GIS地图" onclick="gisMapBtn()" />
		</td>
	</tr>
</table>
</div>

<div style="width:100%">
<div id="areaInfo"  style="display:none">
	<div class="title">
		<div id="title_zi">小区信息</div>
	</div>
<table  cellSpacing="0" id="areaList">
	<tr>
  	  <th style="display:none;">
	    	&nbsp;
	    </th>
	    
			<th	nowrap>
	    	小区编码
	    </th>
	    <th nowrap>
	    	小区地址全称
	    </th>	
	    <th nowrap>
	    	接入类型
	    </th>
		<!-- <th>
			小区接入情况
		</th> -->
		<th>
			小区建设性质
		</th>
		<!-- <th>
			归属类别
		</th> -->
		<th>
			承载方式
		</th>
	    <th nowrap>
	    	楼号
	    </th>
	    <th nowrap>
	    	单元号
	    </th>
	    <th nowrap>
	    	查询
	    </th>
	</tr>
	<tbody id="areaListBody">
	</tbody>
</table>
<div align="center">
		第<span name="nowPage">1</span>/<span name="allPage"></span>页 &nbsp;&nbsp;
		共<span name="allCon"></span>条 &nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('f',this)">首页</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('p',this)">上一页</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('n',this)">下一页</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('e',this)">尾页</a>]
</div>
 </div>	
</div>


<div style="width:100%">
<div id="standAddrInfo"  style="display:none">
	<div class="title">
		<div id="title_zi">标准地址信息</div>	  
	</div>
<table cellspacing=0>
		<tr>
			<th id="standAddrChoose">选择</th>
			<th>标准地址详细信息</th>
			<th>单元可用端口资源总数</th>
			<th>已经占用端口资源总数</th>
		</tr>
		<tbody id="standAddrList">
		</tbody>
</table>
<div align="center">
		第<span name="nowPage">1</span>/<span name="allPage"></span>页 &nbsp;&nbsp;
		共<span name="allCon"></span>条 &nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('f',this)">首页</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('p',this)">上一页</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('n',this)">下一页</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('e',this)">尾页</a>]
</div>
</div>
</div>
<br>
<div id="showTab2" style="width:100%"></div>


<div style="width:100%">
<div id="idleResInfo"  style="display:none">
	<div class="title">
		<div id="title_zi">空闲资源列表</div>
	</div>
	<table id="IdleResource" cellspacing=0>
	<tr>
		<%if(!opCode.equals("e276")){%>
   	  	<th nowrap>
 	    	&nbsp;
    	</th>
    	<%}%>
  	    <th  nowrap>
  	    	设备类型
  	    </th>
  	    <!--<th nowrap>
  	    	设备编码
  	    </th>	-->
  	    <th nowrap>
  	    	型号
  	    </td>	
  	    <th nowrap>
  	    	厂家
  	    </th>	
  	    <th nowrap>
  	    	IP地址
  	    </th>
  	    <th nowrap>
  	    	设备安装地址
  	    </th>	
  	     <th nowrap>
  	    	端口类型
  	    </th>
  	    <!--<th nowrap>
  	    	端口编号
  	    </th>
  	    <th nowrap>
  	    电信局编码
  	    </th>-->
    </tr>			
</table>
</div>
</div>
<!-- 2017-01-18 liangyl  -->
<div  class="title" id="recordInfos" style="display: none"><!--资源不足，用户信息记录模块-->
 <div id="title_zi">用户信息记录</div>	  

	<table cellspacing="0" >  
	   <tr>
	      <td class="Blue">用户名称</td>
	      <td > 
		       <input type="text" id="userName" name="userName">
		       <font color="orange">*</font>
	      </td>
	      <td class="Blue">联系电话</td>
	      <td> 
		       <input type="text" id="contractPhone" name="contractPhone">
		       <font color="orange">*</font>
	      </td>
	      <td class="Blue">区县</td>
	      <td>
	      	<select id="county" name="county">
	      		<option></option>
	      	</select>
	      	<font color="orange">*</font>
	      </td>
	   </tr>
	   <tr>
	   		<td class="Blue">友商归属</td>
	      	<td>
	      		<div><input type="text" id="ownerShip" name="ownerShip" style="position:relative;" maxlength="20" value="联通" onclick="showDiv('ownerShipDiv')" onblur="blurDiv('ownerShipDiv')"><font color="orange">*</font></div>
			    <div id="ownerShipDiv" style="position:absolute;z-index:1;display: none;background: white;width: 130;">
				    <ul style="overflow: auto;">
				    	<li onclick="addValue('ownerShip','ownerShipDiv','联通');">联通</li>
				    	<li onclick="addValue('ownerShip','ownerShipDiv','电信');">电信</li>
				    	<li onclick="addValue('ownerShip','ownerShipDiv','广电');">广电</li>
				    	<li onclick="addValue('ownerShip','ownerShipDiv','长城');">长城</li>
				    	<li onclick="addValue('ownerShip','ownerShipDiv','农垦');">农垦</li>
				    	<li onclick="addValue('ownerShip','ownerShipDiv','油田');">油田</li>
				    </ul>
			    </div>
	      	</td>
	      	<td class="Blue">小区名称</td>
	      	<td>
	      		<input type="text" id="userareaName"  name="userareaName" maxlength="50">
	      		<select id="userareaNameSel" onchange="$('#userareaName').val(this.value)" style="width: 400px">
		      	</select>
		      	<font color="orange">*</font>
	      	</td>
	   		<td class="Blue">是否捆绑手机</td>
	      	<td> 
		      <select id="bundMobile" name="bundMobile">
		      	<option value="是" selected="selected">是</option>
		      	<option value="否">否</option>
		      </select>
	      	</td>
	   </tr>
	   <tr>
	   		<td class="Blue">带宽</td>
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
	      	<td class="Blue">签约年限</td>
	      	<td>
	      		<div><input type="text" id="ageLimit" name="ageLimit" style="position:relative;" maxlength="20" value="6个月" onclick="showDiv('ageLimitDiv')" onblur="blurDiv('ageLimitDiv')"><font color="orange">*</font></div>
			    <div id="ageLimitDiv" style="position:absolute;z-index:1;display: none;background: white;width: 130;">
				    <ul>
				    	<li onclick="addValue('ageLimit','ageLimitDiv','6个月');">6个月</li>
				    	<li onclick="addValue('ageLimit','ageLimitDiv','1年');">1年</li>
				    	<li onclick="addValue('ageLimit','ageLimitDiv','2年');">2年</li>
				    </ul>
			    </div>
			    
	      	</td>
	   		
		      <td class="Blue">是否有网络电视</td>
	      	<td>
	      		<select id="isIptv" name="isIptv">
			      	<option value="是">是</option>
			      	<option value="否" selected="selected">否</option>
			      </select>
	      	</td>
	   </tr>
	   <tr>
	   		<td class="Blue">资费价格</td>
		      <td > 
			       <input type="text" id="description" name="description" maxlength="20">
			       <font color="orange">*</font>
		      </td>
	      	<td class="Blue">预到期时间</td>
	      	<td>
	      		<div><input type="text" id="expireTime" name="expireTime" style="position:relative;" maxlength="40" value="3个月以内" onclick="showDiv('expireTimeDiv')" onblur="blurDiv('expireTimeDiv')"><font color="orange">*</font></div>
			    <div id="expireTimeDiv" style="position:absolute;z-index:1;display: none;background: white;width: 130;">
				    <ul>
				    	<li onclick="addValue('expireTime','expireTimeDiv','3个月以内');">3个月以内</li>
				    	<li onclick="addValue('expireTime','expireTimeDiv','3-6个月');">3-6个月</li>
				    	<li onclick="addValue('expireTime','expireTimeDiv','6个月以上');">6个月以上</li>
				    </ul>
			    </div>
			    
	      	</td>
	   		<td colspan="2">
	   			 <input  onClick="recordInfo()" type=button class="b_text" value="保存" >
	   		</td>
	   </tr>
	</table>
	<input type="hidden" id="userareaName2" name="userareaName2">
	<input type="hidden" id="userareaCode2" name="userareaCode2">
</div>
					   <div id="footer" >
					   <%if(opCode.equals("e276")){%>
					   	<input class="b_foot"  onClick="enterAddOldUser()" style="cursor:hand" type=button value="已有客户宽带入网">&nbsp;
					   	<input class="b_foot"  onClick="enterAddNewUser()" style="cursor:hand" type=button value="新建客户宽带入网">&nbsp;
					   	<font class="red">此种方式不支持宽带开户与营销案一起办理</font>&nbsp;
					   	<%}%>
					   	<input class="b_foot" id="ownerShipBut" disabled="disabled"  onClick="closeWin1()" style="cursor:hand" type=button value="友商信息录入">&nbsp;
			      		<input class="b_foot"  onClick="closeWin()" style="cursor:hand" type=button value="关闭">&nbsp;
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