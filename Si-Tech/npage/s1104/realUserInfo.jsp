<TR id="realUserInfo1"> 
  <TD class="blue" > 
    <div align="left">实际使用人姓名</div>
  </TD>
  <TD> 
    <input name="realUserName" id="realUserName" value="" v_type="string"  maxlength="60" size=20 index="19" v_maxlength=60 class="InputGrey" readonly />
  	<font class="orange">*</font>
  </TD>
  <TD class="blue" > 
    <div align="left">实际使用人联系地址</div>
  </TD>
  <TD> 
    <input name="realUserAddr" id="realUserAddr"  v_type="addrs"  size=30 index="21" class="InputGrey" readonly />
    <font class="orange">*</font>
  </TD>
</TR>
 <tr id="realUserInfo2" > 
  
  <td class="blue" > 
    <div align="left">实际使用人证件号码</div>
  </td>
  <td> 
    <input name="realUserIccId"  id="realUserIccId"  value=""  v_minlength=4 v_maxlength=20 v_type="string"  maxlength="18"    value="" class="InputGrey" readonly />
  	<font class="orange">*</font>
  </td>
  <td class="blue" > 
    <div align="left">实际使用人证件类型</div>
  </td>
  <td> 
    <select name="realUserIdType" id="realUserIdType" onchange="valiRealUserIdTypes(this.value)">
    	<option value="0" selected>身份证</option>
    	<!-- <option value="1">军官证</option> -->
    	<option value="2">户口簿</option>
    	<option value="3">港澳通行证</option>
    	<!-- <option value="4">警官证</option> -->
    	<option value="5">台湾通行证</option>
    	<option value="6">外国公民护照</option>
    	<option value="D">军人身份证</option>
    </select>
    &nbsp;&nbsp;
    <input type="button" name="scan_idCard_two2" id="scan_idCard_two2" class="b_text"   value="读卡" onClick="Idcard_realUser('real')" />
    <input type="button" name="scan_idCard_two22" id="scan_idCard_two22" class="b_text"   value="读卡(2代)" onClick="Idcard2('22')" />
  </td>
</tr>
<script type="text/javascript" language="JavaScript">
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
		var picpath_n = cre_dir +"\\"+picName+"_"+ document.all.gCustId.value +".jpg";
		
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
		
				if(flag == "real"){ //实际使用人
					document.all.realUserName.value =name;//姓名
					document.all.realUserIccId.value =code;//身份证号
					//document.all.realUserAddr.value =IDaddress;//身份证地址
				}
				subStrAddrLength(flag,IDaddress);//校验身份证地址，如果超过60个字符，则自动截取前30个字
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
	
	function getCuTime(){
	 var curr_time = new Date(); 
	 with(curr_time) 
	 { 
	 var strDate = getYear()+"-"; 
	 strDate +=getMonth()+1+"-"; 
	 strDate +=getDate()+" "; //取当前日期，后加中文“日”字标识 
	 strDate +=getHours()+"-"; //取当前小时 
	 strDate +=getMinutes()+"-"; //取当前分钟 
	 strDate +=getSeconds(); //取当前秒数 
	 return strDate; //结果输出 
	 } 
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
				
				if(str == "22"){ //实际使用人 22
					document.all.realUserName.value =xm;//姓名
					document.all.realUserIccId.value =zjhm;//身份证号
					//document.all.realUserAddr.value =zz;//身份证地址
				}
				subStrAddrLength(str,zz);//校验身份证地址，如果超过60个字符，则自动截取前30个字

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
/* begin update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
function subStrAddrLength(str,idAddr){
	var packet = new AJAXPacket("/npage/sq100/fq100_ajax_subStrAddrLength.jsp","正在获得数据，请稍候......");
	packet.data.add("str",str);
	packet.data.add("idAddr",idAddr);
	core.ajax.sendPacket(packet,doSubStrAddrLength);
	packet = null;
}

function doSubStrAddrLength(packet){
	var str = packet.data.findValueByName("str");
	var idAddr = packet.data.findValueByName("idAddr");
	if(str == "22"){ //实际使用人 22
		document.all.realUserAddr.value =idAddr;//身份证地址
	}else if(str == "real"){ //实际使用人 旧版
		document.all.realUserAddr.value =idAddr;//身份证地址
	}
}
/* end update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
</script>