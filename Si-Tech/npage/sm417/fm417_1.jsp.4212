<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2016-10-11 13:58:06------------------
 关于存量年龄超限用户增加经办人信息的需求
 
 
 -------------------------后台人员：xiahk--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
  String groupId    = (String)session.getAttribute("groupId");
	String currentDate = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%> 
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept" /> 
 

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>
var v_printAccept = "<%=printAccept%>";

/*2013/12/16 15:41:14 gaopeng 经办人证件类型下拉表单改变函数*/
function validateGesIdTypes(idtypeVal){
		if(idtypeVal.indexOf("身份证") != -1){
  		document.all.gestoresIccId.v_type = "idcard";
  		if("<%=opCode%>" != "1993"){
  			$("#scan_idCard_two3").css("display","");
  			$("#scan_idCard_two31").css("display","");
	  		$("input[name='gestoresName']").attr("class","InputGrey");
	  		$("input[name='gestoresName']").attr("readonly","readonly");
	  		$("input[name='gestoresAddr']").attr("class","InputGrey");
	  		$("input[name='gestoresAddr']").attr("readonly","readonly");
	  		$("input[name='gestoresIccId']").attr("class","InputGrey");
	  		$("input[name='gestoresIccId']").attr("readonly","readonly");
	  		$("input[name='gestoresName']").val("");
	  		$("input[name='gestoresAddr']").val("");
	  		$("input[name='gestoresIccId']").val("");
  		}
  	}else{
  		document.all.gestoresIccId.v_type = "string";
  		if("<%=opCode%>" != "1993"){
  			$("#scan_idCard_two3").css("display","none");
  			$("#scan_idCard_two31").css("display","none");
	  		$("input[name='gestoresName']").removeAttr("class");
	  		$("input[name='gestoresName']").removeAttr("readonly");
	  		$("input[name='gestoresAddr']").removeAttr("class");
	  		$("input[name='gestoresAddr']").removeAttr("readonly");
	  		$("input[name='gestoresIccId']").removeAttr("class");
	  		$("input[name='gestoresIccId']").removeAttr("readonly");
  		}
  	}
}

/*
	2013/11/18 11:15:44
	gaopeng
	客户地址、证件地址、联系人地址校验方法
	“客户地址”、“证件地址”和“联系人地址”均需“大于等于8个中文汉字”
	（外国公民护照和台湾通行证除外，外国公民护照要求大于2个汉字，台湾通行证要求大于3个汉字）
*/

function checkAddrFunc(obj,objType,ifConnect){
	var nextFlag = true;
	var objName = "";
	var idTypeVal = ""
	if(objType == 0){
		objName = "证件地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "客户地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 2){
		objName = "联系人地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 3){
		objName = "联系人通讯地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 4){
		objName = "经办人联系地址";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 5){
		objName = "责任人联系地址";
		idTypeVal = document.all.responsibleType.value;
	}	
	idTypeVal = $.trim(idTypeVal);
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		
		/*获取证件类型主键 */
		var idTypeText = idTypeVal.split("|")[0];
		
		/*获取含有中文汉字的个数*/
		var m = /^[\u0391-\uFFE5]*$/;
		var chinaLength = 0;
		for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	chinaLength ++;
          }
    }
      
		/*如果既不是外国公民护照 也不是台湾通行证 */
		if(idTypeText != "6" && idTypeText != "5"){
			/*含有至少8个中文汉字*/
			if(chinaLength < 8){
				rdShowMessageDialog(objName+"必须含有至少8个中文汉字！");
				/*赋值为空*/
				obj.value = "";
				
				nextFlag = false;
				return false;
			}
		
	}
	/*外国公民护照 大于2个汉字*/
	if(idTypeText == "6"){
		/*大于2个中文汉字*/
			if(chinaLength <= 2){
				rdShowMessageDialog(objName+"必须含有大于2个中文汉字！");
				
				nextFlag = false;
				return false;
			}
	}
	/*台湾通行证 大于3个汉字*/
	if(idTypeText == "5"){
		/*含有至少3个文汉字*/
			if(chinaLength <= 3){
				rdShowMessageDialog(objName+"必须含有大于3个中文汉字！");
				
				nextFlag = false;
				return false;
			}
	}

	
}
return nextFlag;
}

//查询客户基础信息
function go_queryCustName(){
    var packet = new AJAXPacket("fm417_ajax_queryCustInfo.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo",$("#phoneNo").val());//
    core.ajax.sendPacket(packet,do_queryCustName);
    packet =null;
}
//查询客户基础信息回调
function do_queryCustName(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息
    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//操作成功
    	
    	var oCustOprFlag = packet.data.findValueByName("oCustOprFlag");
    	var oCustName    = packet.data.findValueByName("oCustName");
    	
    	var oOprName     = packet.data.findValueByName("oOprName");
    	var oOprIdType   = packet.data.findValueByName("oOprIdType");
    	var oOprIdIccid  = packet.data.findValueByName("oOprIdIccid");
    	var oOprAddr     = packet.data.findValueByName("oOprAddr");
    	
    	var vIdType      = packet.data.findValueByName("vIdType");
    	var vIdIccid     = packet.data.findValueByName("vIdIccid");
    	var vIdTypeName  = packet.data.findValueByName("vIdTypeName");
    	var vCustId      = packet.data.findValueByName("vCustId");
    	
    	$("#custName").text(oCustName);
    	$("#id_type").text(vIdType);
    	$("#id_iccid").text(vIdIccid);
    	$("#id_typeName").text(vIdTypeName);
    	document.all.custId.value = vCustId;
    	
    	
    	if(oCustOprFlag!="0"){
    		
    		if(oOprIdType=="0"){
    			validateGesIdTypes("0|身份证");
    		}else{
    			validateGesIdTypes("");
    		}
    		    		
    		$("#gestoresIdType").find("option").each(function(){
    			var t_val = $(this).val();
    			if(t_val.indexOf(oOprIdType)!=-1){
    				$(this).attr("selected","true");
    			}
    		});
    		
    		
    		document.all.gestoresIccId.value=oOprIdIccid;
    		document.all.gestoresName.value=oOprName;
    		document.all.gestoresAddr.value=oOprAddr;

    	}else{
    		//默认身份证
    		$("#gestoresIdType").val("0|身份证");
    		validateGesIdTypes("0|身份证");
    	}
    	
    	if(vIdType=="0"||vIdType=="2"){//身份证 或户口簿
    		if(vIdIccid.length>14){
    			var cust_b_date = vIdIccid.substring(6,14);
    			cust_b_date = cust_b_date.substring(0,6);
    			
					
					//判断是否小于10岁大于120岁(精确到月)
					var cm_month = cm_month_2(cust_b_date,"<%=currentDate%>");
					
					//alert("月份差cm_month=["+cm_month+"]");
					
					if(cm_month>10*12&&cm_month<120*12){
						rdShowMessageDialog("只允许小于10岁或大于120岁进行办理");
						reSetThis();
					}
					
					    		
    		}else{
    			rdShowMessageDialog("获取身份证位数错误["+vIdIccid+"]");
    			reSetThis();
    		}
    		
    		
    		  	/*经办人姓名*/
				  	document.all.gestoresName.v_must = "1";
				  	/*经办人地址*/
				  	document.all.gestoresAddr.v_must = "1";
				  	/*经办人证件号码*/
				  	document.all.gestoresIccId.v_must = "1";
    		  	$("#gestoresInfo1").show();
  					$("#gestoresInfo2").show();
  					

    	}else{
    		rdShowMessageDialog("非身份证或户口簿不允许办理");
    		reSetThis();
    	}
    	
    }
}


/*
 * 计算日期相差的月份数
 * 入参 be_date 较早的时间 YYYYMM
 *      cu_date 较晚的时间，一般为当前时间 YYYYMM
 * be_date 必须小于cu_date 其他情况无校验
 */
function cm_month_2(be_date,cu_date){
	
	var cm_month_result = 0;
	
	var be_in_date = be_date;
	var cu_in_date = cu_date;
	
	var be_year_date  = be_in_date.substring(0,4);
	var be_month_date = be_in_date.substring(4,6);
	
	while(be_in_date!=cu_in_date){
			var tempMonth = Number(be_month_date);
			tempMonth = tempMonth + 1;
			
			if(tempMonth<10){
					be_month_date = "0" + tempMonth;
			}else if(tempMonth>12){
					be_month_date = "01";
					be_year_date = Number(be_year_date) + 1;
			}else{
					be_month_date = "" + tempMonth;
			}
			
			be_in_date = be_year_date + be_month_date;
			cm_month_result ++ ;
	}
	return cm_month_result;
}


function go_Cfm(){
					/*经办人姓名*/
					if(!checkCustNameFunc16New(document.all.gestoresName,1,1)){
						return ;
					}
					/*经办人联系地址*/
					if(!checkAddrFunc(document.all.gestoresAddr,4,1)){
						return ;
					}
					/*经办人证件号码*/
					if(!checkIccIdFunc16New(document.all.gestoresIccId,1,1)){
						return ;
					}
				/*经办人姓名*/
					if(!checkElement(document.all.gestoresName)){
						return ;
					}
					/*经办人联系地址*/
					if(!checkElement(document.all.gestoresAddr)){
						return ;
					}
					/*经办人证件号码*/
					if(!checkElement(document.all.gestoresIccId)){
						return ;
					}
		
    var packet = new AJAXPacket("fm417_Cfm.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo",$("#phoneNo").val());//
        
        packet.data.add("id_type",$("#id_type").text());//
        packet.data.add("id_iccid",$("#id_iccid").text());//
    		
        packet.data.add("gestoresIdType",document.all.gestoresIdType.value);//
        packet.data.add("gestoresIccId",document.all.gestoresIccId.value);//
        packet.data.add("gestoresName",document.all.gestoresName.value);//
        packet.data.add("gestoresAddr",document.all.gestoresAddr.value);//
        
    core.ajax.sendPacket(packet,do_Cfm);
    packet =null;
	
}

function do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息
    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg,0);
	    return;
    }else{//操作成功
    	rdShowMessageDialog("操作成功",2);
    	reSetThis();
    }
}


function reSetThis(){
	location = location;
}




  
  function Idcard_realUser(flag){
		//读取二代身份证
		//document.all.card_flag.value ="2";
		
		var picName = getCuTime();
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
		var tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//取得系统目录盘符
		var cre_dir = filep1+":\\custID";//创建目录
		//判断文件夹是否存在，不存在则创建目录
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);  
		}
		var picpath_n = cre_dir +"\\"+picName+"_"+ document.all.custId.value +".jpg";
		
		var result;
		var result2;
		var result3;
	
		result=IdrControl1.InitComm("1001");
		if (result==1)
		{
			result2=IdrControl1.Authenticate();
			if ( result2>0)
			{              
				result3=IdrControl1.ReadBaseMsgP(picpath_n); 
				if (result3>0)           
				{     
			  var name = IdrControl1.GetName();
				var code =  IdrControl1.GetCode();
				var sex = IdrControl1.GetSex();
				var bir_day = IdrControl1.GetBirthYear() + "" + IdrControl1.GetBirthMonth() + "" + IdrControl1.GetBirthDay();
				var IDaddress  =  IdrControl1.GetAddress();
				var idValidDate_obj = IdrControl1.GetValid();
		
				if(flag == "manage"){ //经办人
					document.all.gestoresName.value =name;//姓名
					document.all.gestoresIccId.value =code;//身份证号
					document.all.gestoresAddr.value =IDaddress;//身份证地址
				}
				
				if(flag == "zerenren"){  //责任人
					document.all.responsibleName.value =name;//姓名
					document.all.responsibleIccId.value =code;//身份证号
					document.all.gestoresAddr.value =IDaddress;//身份证地址
				}				
				
				//subStrAddrLength(flag,IDaddress);//校验身份证地址，如果超过60个字符，则自动截取前30个字
				}
				else
				{
					rdShowMessageDialog(result3); 
					IdrControl1.CloseComm();
				}
			}
			else
			{
				IdrControl1.CloseComm();
				rdShowMessageDialog("请重新将卡片放到读卡器上");
			}
		}
		else
		{
			IdrControl1.CloseComm();
			rdShowMessageDialog("端口初始化不成功",0);
		}
		IdrControl1.CloseComm();
	}
	
	function Idcard2(str){
			//扫描二代身份证
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
		tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//取得系统目录盘符
		var cre_dir = filep1+":\\custID";//创建目录
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
	var ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1000);
	if(ret_open!=0){
		ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1001);
	}	
	var cardType ="11";
	if(ret_open==0){
		//alert(v_printAccept+"--"+str);
			//多功能设备RFID读取
			var ret_getImageMsg=CardReader_CMCC.MutiIdCardGetImageMsg(cardType,"c:\\custID\\cert_head_"+v_printAccept+str+".jpg");
			if(str=="1"){
				try{
					document.all.pic_name.value = "C:\\custID\\cert_head_"+v_printAccept+str+".jpg";
					document.all.but_flag.value="1";
					document.all.card_flag.value ="2";
				}catch(e){
						
				}
			}
			//alert(ret_getImageMsg);
			//ret_getImageMsg = "0";
			if(ret_getImageMsg==0){
				//二代证正反面合成
				var xm =CardReader_CMCC.MutiIdCardName;					
				var xb =CardReader_CMCC.MutiIdCardSex;
				var mz =CardReader_CMCC.MutiIdCardPeople;
				var cs =CardReader_CMCC.MutiIdCardBirthday;
				var yx =CardReader_CMCC.MutiIdCardSigndate+"-"+CardReader_CMCC.MutiIdCardValidterm;
				var yxqx = CardReader_CMCC.MutiIdCardValidterm;//证件有效期
				var zz =CardReader_CMCC.MutiIdCardAddress; //住址
				var qfjg =CardReader_CMCC.MutiIdCardOrgans; //签发机关
				var zjhm =CardReader_CMCC.MutiIdCardNumber; //证件号码
				var base64 =CardReader_CMCC.MutiIdCardPhoto;
				var v_validDates = "";
				if(yxqx.indexOf("\.") != -1){
					yxqx = yxqx.split(".");
					if(yxqx.length >= 3){
						v_validDates = yxqx[0]+yxqx[1]+yxqx[2]; 
					}else{
						v_validDates = "21000101";
					}
				}else{
					v_validDates = "21000101";
				}
				
				if(str == "31"){ //经办人
					document.all.gestoresName.value =xm;//姓名
					document.all.gestoresIccId.value =zjhm;//身份证号
					document.all.gestoresAddr.value =zz;//身份证地址
				}else if(str == "57"){ //责任人
					document.all.responsibleName.value =xm;//姓名
					document.all.responsibleIccId.value =zjhm;//身份证号
					document.all.gestoresAddr.value =zz;//身份证地址
				}
				
				//subStrAddrLength(str,zz);//校验身份证地址，如果超过60个字符，则自动截取前30个字

			}else{
					rdShowMessageDialog("获取信息失败");
					return ;
			}
	}else{
					rdShowMessageDialog("打开设备失败");
					return ;
	}
	//关闭设备
	var ret_close=CardReader_CMCC.MutiIdCardCloseDevice();
	if(ret_close!=0){
		rdShowMessageDialog("关闭设备失败");
		return ;
	}
	
}



</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">手机号码</td>
		  <td width="35%">
			    <input type="text"  name="phoneNo" id="phoneNo"  maxlength="11" value="" />
			    <input type="button" class="b_text" value="查询" onclick="go_queryCustName()" />
		  </td>
		  <td class="blue"  width="15%">客户姓名</td>
		  <td>
			    <span id="custName"></span>
		  </td>
	</tr>
	
	<tr>
	    <td class="blue" width="15%">证件类型</td>
		  <td width="35%">
		  	<span id="id_type" style="display:none"></span>
		  	<span id="id_typeName"></span>
		  </td>
		  <td class="blue"  width="15%">证件号码</td>
		  <td>
			    <span id="id_iccid"></span>
		  </td>
	</tr>
	<%@ include file="/npage/sq100/gestoresInfo.jsp" %>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定" onclick="go_Cfm()"            />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>
<input type="hidden" name="custId" value="0">
<%@ include file="/npage/include/public_smz_check.jsp" %>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
<%@ include file="/npage/sq100/interface_provider.jsp" %>
<OBJECT id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"></OBJECT>
</HTML>