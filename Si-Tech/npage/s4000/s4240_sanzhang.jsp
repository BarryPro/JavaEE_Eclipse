<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/05/03 liangyl 关于全面恢复省际跨区补卡服务的通知
* 作者: liangyl
* 版权: si-tech
*/
%>
<%
String hwAccept = request.getParameter("hwAccept")==null ? "1":request.getParameter("hwAccept");
String showBody = request.getParameter("showBody")==null ? "01":request.getParameter("showBody");
String sopcode = request.getParameter("sopcode")==null ? "":request.getParameter("sopcode");
String renzhengShowStr = request.getParameter("renzhengShow")==null ? "":request.getParameter("renzhengShow");
boolean renzhengShow = false;
if("true".equals(renzhengShowStr)){
	renzhengShow = true;
}
else{
	renzhengShow = false;
}

System.out.println("liangyl==== public ==" + hwAccept + "|" + showBody+"| sopcode="+sopcode);
String workNo = (String)session.getAttribute("workNo");
String orgCode = (String)session.getAttribute("orgCode");
String groupId =(String)session.getAttribute("groupId");
String nowDatePub =new SimpleDateFormat("yyyyMMdd").format(new java.util.Date()).toString();
String regionCode = orgCode.substring(0,2);
String reqIdCard = request.getParameter("reqIdCard")==null ? "1":request.getParameter("reqIdCard");
String reqIdName = request.getParameter("reqIdName")==null ? "1":request.getParameter("reqIdName");
String labelName = request.getParameter("labelName");

String idType = request.getParameter("idType")==null ? "":request.getParameter("idType");
String idIccid = request.getParameter("idIccid")==null ? "":request.getParameter("idIccid");
String custName = request.getParameter("custName")==null ? "1":request.getParameter("custName");

System.out.println("liangyl====labelName====="+labelName);
System.out.println("liangyl====idType====="+idType);
System.out.println("liangyl====idIccid====="+idIccid);
System.out.println("liangyl====custName====="+custName);
/* 都展示哪些信息
		01：只展示身份证
		10：只展示附件
		11：身份证与附件都展示
*/
	String iccidInfoStyle = "";
	String accInfoStyle = "";
	if("01".equals(showBody)){
		iccidInfoStyle = "block";
		accInfoStyle = "none";
	}else if("10".equals(showBody)){
		iccidInfoStyle = "none";
		accInfoStyle = "block";
	}else{
		iccidInfoStyle = "block";
		accInfoStyle = "block";
	}

%>
<iframe name="upload_frame_all" id="upload_frame_all" style="display:none"></iframe>
<form method="post" name="frm" id="frm">
<input type="hidden" id="idTypes" name="idTypes" value="0|身份证"/>

<input type="text" id="pic_nameT" name="pic_nameT" value=""/><!--标识上传文件的名称-->
<input type="hidden" id="up_flagT" name="up_flagT" value="0"/><!--是否上传标志-->
<input type="hidden" id="but_flagT" name="but_flagT" value="0"/><!--按钮点击标志-->
<input type="hidden" id="upbut_flagT" name="upbut_flagT" value="0"/><!--上传按钮点击标志-->
<input type="hidden" id="pic_nameZ" name="pic_nameZ" value=""/>
<input type="hidden" id="up_flagZ" name="up_flagZ" value="0"/><!--是否上传标志-->
<input type="hidden" id="but_flagZ" name="but_flagZ" value="0"/><!--按钮点击标志-->
<input type="hidden" id="upbut_flagZ" name="upbut_flagZ" value="0"/><!--上传按钮点击标志-->
<input type="hidden" id="pic_nameF" name="pic_nameF" value=""/>
<input type="hidden" id="up_flagF" name="up_flagF" value="0"/>
<input type="hidden" id="but_flagF" name="but_flagF" value="0"/>
<input type="hidden" id="upbut_flagF" name="upbut_flagF" value="0"/>
<%if(renzhengShow){%>
<input type="hidden" id="pic_nameC" name="pic_nameC" value=""/>
<input type="hidden" id="up_flagC" name="up_flagC" value="0"/>
<input type="hidden" id="but_flagC" name="but_flagC" value="0"/>
<input type="hidden" id="upbut_flagC" name="upbut_flagC" value="0"/>
<input type="hidden" id="submitFlagC" name = "submitFlagC" value="0"/>
<%}%>
<input type="hidden" id="breakSeq" name = "breakSeq" value=""/>



		<tr id="sanzhangTr">
				<td class="blue" align="left">身份证头像</td>
				<td colspan="3">
					<input type="file" name="filepT" id="filepT" onchange="chcek_picT();" />&nbsp;
					<font color="red">请到"C:\custID"目录下选择图片</font>
					<input type="hidden" id="userName" name="userName" value=""/>
					<input type="hidden" id="userAddr" name="userAddr" value=""/>
					<input type="hidden" id="idSexHT" name="idSexHT" value="1"/>
					<input type="hidden" id="birthDayHT" name="birthDayHT" value="20090625"/>
					<input type="hidden" id="zhengjianYXQT" name="zhengjianYXQT" value="20500101"/>
					 
				</td>
			</tr>
		<tr id="sanzhangTr">
			<td class="blue" align="left">身份证正面</td>
			<td colspan="3">
				<input type="button" id="readByMultisssZ" name="readByMultisssZ" class="b_text"   value="扫描证件正面" onClick="photoCollect33('Z')" >
				<input type="file" name="filepZ" id="filepZ" onchange="chcek_picZ();" />&nbsp;
				<font color="red">请到"C:\bmp"目录下选择图片</font>
			</td>
		</tr>
		<tr id="sanzhangTr">
			<td class="blue" align="left">身份证背面</td>
			<td colspan="3">
				<input type="button" id="readByMultisssF" name="readByMultisssF" class="b_text"   value="扫描证件背面" onClick="photoCollect33('F')" >
				<input type="file" name="filepF" id="filepF" onchange="chcek_picF();" />&nbsp;
				<font color="red">请到"C:\bmp"目录下选择图片</font>
			</td>
		</tr>
		<%if(renzhengShow){%>
		<tr id="sanzhangTr">
			<td class="blue" align="left">手持身份证</td>
			<td colspan="3">
				<input type="button" id="photoCollectC" name="photoCollectC" class="b_text"   value="手持身份证" onClick="photoCollect33('C')" >
				<input type="file" name="filepC" id="filepC" onchange="chcek_picC();" />&nbsp;
			</td>
		</tr>
		<%}%>
		<tr id="sanzhangTr">
			<td class="blue" align="center" colspan="4">
				<input type="button" id="uploadPicBut" name="uploadPicBut"  class="b_text"   value="上传所有图片" onClick="uploadpicAll();">
			</td>
		</tr>
</form>
<script language="JavaScript">
var campicpath_n="";
var campicname="";

function photoCollect33(cardnum){
	/*图片路径*/
	var picpath_n ;
	
	//访问
	window.showModalDialog("http://10.110.0.100:59000/workflow/camera/getCamera.jsp");
	//window.showModalDialog("http://10.110.13.52:8899/debug/crmDemo.html");
	//获取反馈报文解析，自动填入表单
	var authinfo = window.clipboardData.getData("text");
//	authinfo = "20170301202249"+cardnum+".jpg";
	campicname=authinfo;
//	alert("返回文件名--------"+authinfo);
	authinfo = $.trim(authinfo);
	/*增加全路径*/
	authinfo = "C:/bmp/"+authinfo;
	$("#pic_name"+cardnum).val(authinfo);
	campicpath_n=authinfo;
	document.all.but_flagZ.value=1;
	$("#but_flag"+cardnum).val("1");
}

function chcek_picZ(){
	var pic_path = document.all.filepZ.value;
	var d_num = pic_path.indexOf("\.");
	var file_type = pic_path.substring(d_num+1,pic_path.length);
	//判断是否为jpg类型 //厂家设备生成图片固定为jpg类型
	if(file_type.toUpperCase()!="JPG"){ 
		rdShowMessageDialog("请选择jpg类型图像文件");
		document.all.up_flagZ.value=3;
		resetfilpZ();
		return ;
	}
	
	var pic_path_flag= document.all.pic_nameZ.value.replace("\\","/");
	
	if(pic_path_flag==""){
		rdShowMessageDialog("请先扫描或读取证件信息");
		document.all.up_flagZ.value=4;
		resetfilpZ();
		return;
	}
	else{
		if(pic_path.replace(/\\/g,"")!=pic_path_flag.replace(/\//g,"")){
			rdShowMessageDialog("请选择最后一次扫描或读取证件而生成的证件图像文件"+pic_path_flag);
			document.all.up_flagZ.value=5;
			resetfilpZ();
			return;
		}
	}
	document.all.up_flagZ.value=1;
}
function resetfilpZ(){//二代证
	document.getElementById("filepZ").outerHTML = document.getElementById("filepZ").outerHTML;
}

function chcek_picF(){
	var pic_path = document.all.filepF.value;
	var d_num = pic_path.indexOf("\.");
	var file_type = pic_path.substring(d_num+1,pic_path.length);
	//判断是否为jpg类型 //厂家设备生成图片固定为jpg类型
	if(file_type.toUpperCase()!="JPG"){ 
		rdShowMessageDialog("请选择jpg类型图像文件");
		document.all.up_flagF.value=3;
		resetfilpF();
		return ;
	}
	
	var pic_path_flag= document.all.pic_nameF.value;
	
	if(pic_path_flag==""){
		rdShowMessageDialog("请先扫描或读取证件信息");
		document.all.up_flagF.value=4;
		resetfilpF();
		return;
	}
	else{
		if(pic_path.replace(/\\/g,"")!=pic_path_flag.replace(/\//g,"")){
			rdShowMessageDialog("请选择最后一次扫描或读取证件而生成的证件图像文件"+pic_path_flag);
			document.all.up_flagF.value=5;
			resetfilpF();
			return;
		}
	}
	document.all.but_flagF.value=1;
	document.all.up_flagF.value=1;
}
function resetfilpF(){//二代证
	document.getElementById("filepF").outerHTML = document.getElementById("filepF").outerHTML;
}

function chcek_picC(){
	var pic_path = document.all.filepC.value;
	var d_num = pic_path.indexOf("\.");
	var file_type = pic_path.substring(d_num+1,pic_path.length);
	//判断是否为jpg类型 //厂家设备生成图片固定为jpg类型
	if(file_type.toUpperCase()!="JPG"){ 
		rdShowMessageDialog("请选择jpg类型图像文件");
		document.all.up_flagC.value=3;
		resetfilpC();
		return ;
	}
	
	var pic_path_flag= document.all.pic_nameC.value;
	
	if(pic_path_flag==""){
		rdShowMessageDialog("请先扫描或读取证件信息");
		document.all.up_flagC.value=4;
		resetfilpC();
		return;
	}
	else{
		if(pic_path.replace(/\\/g,"")!=pic_path_flag.replace(/\//g,"")){
			rdShowMessageDialog("请选择最后一次扫描或读取证件而生成的证件图像文件"+pic_path_flag);
			document.all.up_flagC.value=5;
			resetfilpC();
			return;
		}
	}
	document.all.but_flagC.value=1;
	document.all.up_flagC.value=1;
}
function resetfilpC(){//二代证
	document.getElementById("filepC").outerHTML = document.getElementById("filepC").outerHTML;
}

function uploadpicAll(){//二代证
	
	if(document.all.phoneNo.value==""){
		rdShowMessageDialog("请输入手机号码",0);
		return;
	}
	<%if(renzhengShow){%>
		if(document.all.but_flagC.value=="0"){
			rdShowMessageDialog("请先扫描或读取图片",0);
			return;
		}
	<%}%>
	if(document.all.but_flagZ.value=="0"||document.all.but_flagF.value=="0"||document.all.but_flagT.value=="0"){
		rdShowMessageDialog("请先扫描或读取图片",0);
		return;
	}
	<%if(renzhengShow){%>
		if(document.all.filepC.value==""){
			rdShowMessageDialog("请选择要上传的图片",0);
			return;
		}
	<%}%>
	if(document.all.filepZ.value==""||document.all.filepF.value==""||document.all.filepT.value==""){
		rdShowMessageDialog("请选择要上传的图片",0);
		return;
	}
	
	
	document.frm.target="upload_frame_all"; 
	document.frm.encoding="multipart/form-data";
	var actionstr ="s4240_sanzhang_uppic.jsp?regionCode="+document.all.regionCode.value+
								"&phoneNo="+document.all.phoneNo.value+
								"&filep_T="+document.all.filepT.value+
								"&filep_Z="+document.all.filepZ.value+
								"&filep_F="+document.all.filepF.value+
								<%if(renzhengShow){%>
									"&filep_C="+document.all.filepC.value+
								<%}%>
								"&idIccid="+document.all.cardID.value+
								"&workno=<%=workNo%>"+
								"&opCode=g412"+
								"&idType="+document.all.idTypes.value+
								"&labelName=<%=labelName%>"+
								"&isCheckIdCard=<%=renzhengShow?"1":"0"%>"+
								"&checkPage=1";
	document.frm.action = actionstr; 
	
	document.frm.submit();
	resetfilpZ();
	resetfilpF();
	resetfilpT();
	<%if(renzhengShow){%>
		resetfilpC();
	<%}%>
	document.frm.encoding="application/x-www-form-urlencoded";
	document.all.uploadPicBut.disabled=true;
}

</script>

<script type='text/javascript'>
	/*2014/12/01 14:33:13 gaopeng 加入loadXML方法*/
    loadXML = function(xmlString){
        var xmlDoc=null;
        //判断浏览器的类型
        //支持IE浏览器 
        if(!window.DOMParser && window.ActiveXObject){   //window.DOMParser 判断是否是非ie浏览器
            var xmlDomVersions = ['MSXML.2.DOMDocument.6.0','MSXML.2.DOMDocument.3.0','Microsoft.XMLDOM'];
            for(var i=0;i<xmlDomVersions.length;i++){
                try{
                    xmlDoc = new ActiveXObject(xmlDomVersions[i]);
                    xmlDoc.async = false;
                    xmlDoc.loadXML(xmlString); //loadXML方法载入xml字符串
                    break;
                }catch(e){
                }
            }
        }
        //支持Mozilla浏览器
        else if(window.DOMParser && document.implementation && document.implementation.createDocument){
            try{
                /* DOMParser 对象解析 XML 文本并返回一个 XML Document 对象。
                 * 要使用 DOMParser，使用不带参数的构造函数来实例化它，然后调用其 parseFromString() 方法
                 * parseFromString(text, contentType) 参数text:要解析的 XML 标记 参数contentType文本的内容类型
                 * 可能是 "text/xml" 、"application/xml" 或 "application/xhtml+xml" 中的一个。注意，不支持 "text/html"。
                 */
                domParser = new  DOMParser();
                xmlDoc = domParser.parseFromString(xmlString, 'text/xml');
            }catch(e){
            }
        }
        else{
            return null;
        }

        return xmlDoc;
    }
</script>


<script language=javascript>
	//判断设备类型
	var fso = new ActiveXObject("Scripting.FileSystemObject");
	if(!fso.FileExists("C:/WINDOWS/system32/CMCC_IDCard.dll")){
		//document.getElementById('bReadByCardReader').disabled = false;
		//document.getElementById('trCardReader').style.display='none';
		//document.getElementById('PROMPTMSG').innerHTML = "设备状态";
	}
	if(!fso.FileExists("C:/WINDOWS/system32/MutiIdCard.dll")){ 
		//document.getElementById('readByMultisss1').disabled = false;
	//	document.getElementById('readByMultisss1').disabled = true;
	//	document.getElementById('readByMultisss2').disabled = true;
	//	document.getElementById('readByMultisss1s').disabled = true;
	//	document.getElementById('readByMultisss2s').disabled = true;		
		//document.getElementById('readByMultisss1').style.display='none';
		//document.getElementById('PROMPTMSG').innerHTML = "设备状态";
	}
</script>