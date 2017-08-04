<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/05/03 liangyl 关于全面恢复省际跨区补卡服务的通知
* 作者: liangyl
* 版权: si-tech
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
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
	    String workNo =(String)session.getAttribute("workNo");
		  String groupId =(String)session.getAttribute("groupId");
		  
		  %>
		  <!-- 判断是否进行身份证校验 -->
		  <wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="sfzretCode" retmsg="sfzretMsg">
			<wtc:param value="select trim(login_no)  from shighlogin where op_code = 'g412'"/>
		</wtc:service>
		<wtc:array id="sfzresult" scope="end"/>
		  <%
		  boolean renzhengShow=false;
		  if("Y".equals(sfzresult[0][0])){
			  renzhengShow=true;
		  }
		  else{
			  renzhengShow=false;
		  }
		  renzhengShow=false;
		  
		 
	//进行工号权限检验

		 String loginAccept = "";
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode"  routerValue="<%=regionCode%>"  id="sLoginAccept" />
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode"  routerValue="<%=regionCode%>"  id="v_printAccept" />
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
<%
		loginAccept = sLoginAccept;

	List al = null;

	String[][] provData = new String[][]{};
	
	String totalDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	
	String monthDate = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
	String dayDate = new java.text.SimpleDateFormat("dd").format(new java.util.Date());
	
	int		isGetDataFlag = 0;	//0:正确,其他错误. add by yl.
	String errorMsg ="";	
	StringBuffer  insql = new StringBuffer();
	
dataLabel:
	while(1==1){	
	
	//1.SQL 证件类型
	insql.delete(0,insql.length());
	insql.append("select substr(node_code,0,3),node_name  from oneboss.sobexchgnode  where node_code<>'0000' order by node_code");
	String sql = insql.toString();
		%>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
			<wtc:param value="<%=sql%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
		<%
				System.out.println("数据条数 ------------------------------>"+result.length);
		if( result == null ){
			isGetDataFlag = 2;
			break dataLabel;
		}		
		provData = result;
		isGetDataFlag = 0;
		break;	

	 }
	 	 errorMsg = "取数据错误:"+Integer.toString(isGetDataFlag);	    
	 System.out.println(errorMsg);
%>

<%if( isGetDataFlag != 0 ){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<%=errorMsg%>");
	window.close();
	rdShowMessageDialog("<%=errorMsg%>");
//-->
</script>
<%}%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>异地写卡申请</title>


<script language="JavaScript">
	//定义应用全局的变量
	var SUCC_CODE	= "0";   		  //自己应用程序定义
	var ERROR_CODE  = "1";			//自己应用程序定义
	var YE_SUCC_CODE = "0000";	//根据营业系统定义而修改
    var v_printAccept="<%=v_printAccept%>";

	onload=function()
	{		
		//document.frm.tmpBusyAccept.value='123';
				//document.frm.loginAccept.value='123';
				//document.frm.custName.value='测试1';
				//document.frm.vipNo.value='vip1';
				//document.frm.confirm.disabled = false;
		init();

	}

		
	function init()
	{	  		  
		$("#test").hide();
<%
	
		String power_right = (String)session.getAttribute("power_code");
		String test_sql="select a.oregtype from oneboss.DOBTRANSREGMSG a,oneboss.sobopercode b where a.bipcode=b.oper_code and b.function_code='4240' and b.oper_code='BIP2B006'";
		
%>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
			<wtc:param value="<%=test_sql%>"/>
		</wtc:service>
		<wtc:array id="result11" scope="end"/>
			<%
			System.out.println("gaopenggaopenggaopeng~~~~~~~~~~~~~~~~~~~~~"+result11.length+"----"+result11[0][0]);
		if(result11.length>0){
		   if(result11[0][0].equals("11")) {
		   System.out.println("gaopenggaopenggaopeng~~~~~~~~~~~~~~~~~~~~~"+"--------------zheli");
			if(power_right!=null&&power_right.trim().equals("3")){
%>
				$("#test").hide();
				document.all("test_flag").length=2;
				document.all("test_flag").options[0].text="正式";
				document.all("test_flag").options[0].value="0";
				document.all("test_flag").options[1].text="测试";
				document.all("test_flag").options[1].value="1";
<%
			}
			
			else{
%>
				$("#test").hide();
				//$("#test_flag").append("<option value='0'>正式</option>");
				document.frm.test_flag.length=1;
				document.frm.test_flag.options[0].text="正式";
				document.frm.test_flag.options[0].value="0";
<%			
			
			}
			}
		}
%>	  	
	//	document.frm.confirm.disabled = true;		
		//document.frm.confirm.disabled = false;		
	//	document.frm.phoneNo.focus();		
	}
			
	//---------1------RPC处理函数------------------
	function go_call_noCheck(){
 		var sqlBuf="";
		//检查数据的合法性
	 	
	 	if(!checkElement(document.getElementById("phoneNo"))){ 
	 		return false;
	 	}
	 	
	 	if( (document.frm.custPWD.value == "" )
	 		&& (document.frm.cardID.value == "" )
	 	  ){
	 	  	rdShowMessageDialog("必须输入'客户密码'或者'证件号码'中的一个！");
	 	  	return false;	 	  
	 	  }
	 	
	 	if( document.frm.custPWD.value != "" ){
	 		if(!checkElement(document.getElementById("custPWD"))) return false;
	 	}  
	 	if( document.frm.cardID.value != "" ){
			if(document.frm.cardType.value=="00"){
			document.frm.cardID.v_type="";
			}
			else{
			document.frm.cardID.v_type="";
			}
	 		if(!checkElement(document.getElementById("cardID"))) return false;
	 	} 
		//alert("准备调用ajax方法");
			var myPacket = new AJAXPacket("s4240_rpc_id.jsp","正在确认，请稍候......");
			myPacket.data.add("verifyType","phoneno");
			myPacket.data.add("loginNo",document.all.loginNo.value);
			myPacket.data.add("orgCode",document.all.orgCode.value);
			myPacket.data.add("opCode","4150");
			myPacket.data.add("idType",document.all.IDType.value);
			myPacket.data.add("idValue",document.all.phoneNo.value);
			myPacket.data.add("CCPasswd",document.all.custPWD.value);
			myPacket.data.add("cardType",document.all.cardType.value);
			myPacket.data.add("cardID",document.all.cardID.value);
			myPacket.data.add("typeIDs","0");//查询类型
			core.ajax.sendPacket(myPacket,do_call_noCheck);
			//alert("end");
      myPacket = null;
	}
	//用户状态编码
	var name119s=new Array();
	name119s["00"]="正常";
	name119s["01"]="单向停机";
	name119s["02"]="停机";
	name119s["03"]="预销户";
	name119s["04"]="销户";
	name119s["05"]="过户";
	name119s["06"]="改号";
	name119s["07"]="携号转出";
	name119s["90"]="神州行用户";
	name119s["99"]="此号码不存在";
	//用户星级编码
	var name127s=new Array();
	name127s["00"]="准星";
	name127s["01"]="一星";
	name127s["02"]="二星";
	name127s["03"]="三星";
	name127s["04"]="四星";
	name127s["05"]="五星";
	name127s["06"]="五星金";
	name127s["07"]="五星钻";
	name127s["09"]="未评级";
	
	function do_call_noCheck(packet){
		//使用RPC的时候,以下三个变量作为标准使用.
		var error_code = packet.data.findValueByName("errorCode");
		//alert(error_code);
		var error_msg =  packet.data.findValueByName("errorMsg");
		//alert(error_msg);
		var verifyType = packet.data.findValueByName("verifyType");
		//alert(verifyType);
		if(verifyType=="phoneno"){
			if( error_code=="000000" ){
				var resultmsg1 = packet.data.findValueByName("resultmsg1");
				var resultmsg2 = packet.data.findValueByName("resultmsg2");
				var resultmsg3 = packet.data.findValueByName("resultmsg3");
				var resultmsg4 = packet.data.findValueByName("resultmsg4");
				if(resultmsg1.length>0){
					$("#retrspCode").val(resultmsg1[0][0]);
					$("#retrspDesc").val(resultmsg1[0][1]);
					$("#retSessionID").val(resultmsg1[0][2]);
					$("#retTransIDO").val(resultmsg1[0][3]);
					$("#retTransIDH").val(resultmsg1[0][4]);
					$("#retIDType").val(resultmsg1[0][5]);
					$("#retIDValue").val(resultmsg1[0][6]);
					$("#retoprResult").val(resultmsg1[0][7]);
					$("#retResultDesc").val(resultmsg1[0][8]);
					
					for(var i=0;i<resultmsg2.length;i++){
						if(resultmsg2[i]=="119"){
							$("#retValue"+resultmsg2[i]).val(name119s[resultmsg3[i]]);
						}
						else if(resultmsg2[i]=="127"){
							$("#retValue"+resultmsg2[i]).val(name127s[resultmsg3[i]]);
						}
						else{
							
							$("#retValue"+resultmsg2[i]).val(resultmsg3[i]);
						}
					//	alert(resultmsg2[i]+"--"+resultmsg3[i]);
					}
					$("#yjFee").val(resultmsg4[0][0]);
					$("#ycFee").val(resultmsg4[0][1]);
					$("tr[id='sanzhangTr']").show();
					rdShowMessageDialog("鉴权成功请进行照片操作！",1);
				}
			}else{
				$("tr[id='sanzhangTr']").hide();
				$("#b_write").attr("disabled","disabled");
				rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:["+error_msg+"]");
				return false;
			}	
		}					
	}
	

	function resetJsp()
	{
	 with(document.frm)
	 {

		phoneNo.value	= "";
		custPWD.value	= "";
		cardID.value	= "";
		loginAccept.value= "";

	 }
	 
		init();	
			
	}
			
	function Idcard_realUser(){
		//读取二代身份证
		//document.all.card_flag.value ="2";
		
		var picName = getCuTime1();
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
		var tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//取得系统目录盘符
		var cre_dir = filep1+":\\custID";//创建目录
		//判断文件夹是否存在，不存在则创建目录
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);  
		}
		var picpath_n = cre_dir +"\\"+picName +".jpg";
		
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
				if (result3>0){
					$("#pic_nameT").val(picpath_n);
			  var name = IdrControl1.GetName();
				var code =  IdrControl1.GetCode();
				var sex = IdrControl1.GetSex();
				var bir_day = IdrControl1.GetBirthYear() + "" + IdrControl1.GetBirthMonth() + "" + IdrControl1.GetBirthDay();
				var IDaddress  =  IdrControl1.GetAddress();
				var idValidDate_obj = IdrControl1.GetValid();
				
				document.all.userName.value =name;//姓名
				document.all.cardID.value =code;//身份证号
				document.all.userAddr.value =IDaddress;//身份证地址
				document.all.idSexHT.value =sex;//性别
				document.all.birthDayHT.value =bir_day;//生日
				$("#zhengjianYXQT").val(idValidDate_obj);
				document.all.but_flagT.value="1";
				document.all.up_flagT.value="0";
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
	
	function getCuTime1(){
		 var curr_time = new Date(); 
		 with(curr_time) 
		 { 
		 var strDate = getYear()+"-"; 
		 strDate +=getMonth()+1+"-"; 
		 strDate +=getDate()+""; //取当前日期，后加中文“日”字标识 
		 strDate +=getHours()+"-"; //取当前小时 
		 strDate +=getMinutes()+"-"; //取当前分钟 
		 strDate +=getSeconds(); //取当前秒数 
		 return strDate; //结果输出 
		 } 
		}
	
	function Idcard2(){
		var str="22";
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
			try{
				document.all.pic_nameT.value = "C:\\custID\\cert_head_"+v_printAccept+str+".jpg";
				document.all.but_flagT.value="1";
				document.all.up_flagT.value="0";
			}catch(e){
					
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
				document.all.userName.value =xm;//姓名
				document.all.cardID.value =zjhm;//身份证号
				document.all.userAddr.value =zz;//身份证地址
				document.all.idSexHT.value =xb;//性别
				document.all.birthDayHT.value =cs;//生日
				$("#zhengjianYXQT").val(yxqx)
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
	
	function chcek_picT(){
		var pic_path = document.all.filepT.value;
		var d_num = pic_path.indexOf("\.");
		var file_type = pic_path.substring(d_num+1,pic_path.length);
		//判断是否为jpg类型 //厂家设备生成图片固定为jpg类型
		if(file_type.toUpperCase()!="JPG"){ 
			rdShowMessageDialog("请选择jpg类型图像文件");
			document.all.up_flagT.value=3;
			resetfilpT();
			return ;
		}
		
		var pic_path_flag= document.all.pic_nameT.value; 
		
		if(pic_path_flag==""){
			rdShowMessageDialog("请先扫描或读取证件信息");
			document.all.up_flagT.value=4;
			resetfilpT();
			return;
		}
		else{
			if(pic_path!=pic_path_flag){
				rdShowMessageDialog("请选择最后一次扫描或读取证件而生成的证件图像文件"+pic_path_flag);
				document.all.up_flagT.value=5;
				resetfilpT();
				return;
			}
		}
		document.all.up_flagT.value=1;
	}
	function resetfilpT(){//二代证
		document.getElementById("filepT").outerHTML = document.getElementById("filepT").outerHTML;
	}
	
	var simCardNumber="";
	var simtypess="";
	function readcardss() {
		//document.all.b_write.disabled=false;
  		 simtypess="";
  		 /****新增调大唐功能取SIM卡类型****/
  		 /* 
        * diling update for 修改营业系统访问远程写卡系统的访问地址，由现在的10.110.0.125地址修改成10.110.0.100！@2012/6/4
        */
     //   path ="http://10.110.0.100:33000/OPSWriteCard/writecard/ReadCardInfo.jsp";
  		 path ="http://10.110.26.27:33000/OPSWriteCard/writecard/ReadCardInfo.jsp";
  		 var retInfo1 = window.showModalDialog("<%=request.getContextPath()%>/npage/sg529/Trans.html",path,"","dialogWidth:10;dialogHeight:10;"); 
  		 if(typeof(retInfo1) == "undefined")     
    	 {	
    		 rdShowMessageDialog("读卡类型出错!");

    		return false;   
    	 }
    	var chPos;
    	chPosn = retInfo1.indexOf("&");
    	if(chPosn < 0)
    	{	
    		rdShowMessageDialog("读卡类型出错!");
    		return false ;	
    	} 
    	retInfo1=retInfo1+"&";
    	var retVal=new Array();   
    	for(i=0;i<4;i++)
    	{   	   
    		var chPos = retInfo1.indexOf("&");
        	valueStr = retInfo1.substring(0,chPos);
        	var chPos1 = valueStr.indexOf("=");
        	valueStr1 = valueStr.substring(chPos1+1);
        	retInfo1 = retInfo1.substring(chPos+1);
        	retVal[i]=valueStr1;
    	}
    	
    	if(retVal[0]=="0")
    	{
    		var rescode_str=retVal[2]+"|";
    		var rescode_strstr="";
    		var chPosm = rescode_str.indexOf("|");
    		for(i=0;i<4;i++)
    		{   	   
    			var chPos1 = rescode_str.indexOf("|");
        		valueStr = rescode_str.substring(0,chPos1);
        		rescode_str = rescode_str.substring(chPos1+1);
        		if(i==0 && valueStr=="")
        		{
        			rdShowMessageDialog("读卡类型出错!");
    		 		  return false;
        		}
        		if(valueStr!=""){
        			rescode_strstr=rescode_strstr+"'"+valueStr+"'"+",";
        		}
    		} 
    		rescode_strstr=rescode_strstr.substring(0,rescode_strstr.length-1);
    		if(rescode_strstr=="")
    		{
    			rdShowMessageDialog("读卡类型出错!");

    		 	return false;   
    		}
    		
  		}
  		else{
  			 rdShowMessageDialog("读卡类型出错!");

    		 return false;   
    	}
    	simCardNumber = retVal[1];
    	simtypess=rescode_strstr.substr(1,rescode_strstr.length-2);
    	if($("#simFee").val()==""){
			$("#simFee").val("0");
		}
    	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
    	
    	
    }
function writechg(obj){
	<%if(renzhengShow){%>
		if($("#submitFlagC").val()=="0"){
			rdShowMessageDialog("请先进行人证校验后再进行提交！");
	 	  	return false;
		}
	<%}%>
	readcardss();
	
	
	
}

function go_wrtirCardBefort(){
	var myPacket = new AJAXPacket("s4240_writecardbefore.jsp","正在进行写卡前操作，请稍候......"); 
	myPacket.data.add("loginNo",document.all.loginNo.value);
	myPacket.data.add("orgCode",document.all.orgCode.value);
	myPacket.data.add("idValue",document.all.phoneNo.value);
	myPacket.data.add("seq",document.all.breakSeq.value);
	myPacket.data.add("cardSN",simCardNumber);
	myPacket.data.add("ICCID","");
	myPacket.data.add("name","");
	myPacket.data.add("value","");
	core.ajax.sendPacket(myPacket,do_wrtirCardBefort);
	myPacket = null;
}
var writesimcode = "";
var writesimno = "";
var writecardstatus = "";
var writecardNo = "";
var writecardKi = "";
var writecardOpc = "";

function do_wrtirCardBefort(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg =  packet.data.findValueByName("retMsg");
	if(retCode=="000000"){
		var resultmsg = packet.data.findValueByName("resultmsg");
		$("#brspCode").val(resultmsg[0][0]);//应答代码
		$("#brspDesc").val(resultmsg[0][1]);//应答描述
		$("#bSessionID").val(resultmsg[0][2]);//业务流水
		$("#bTransIDO").val(resultmsg[0][3]);//交易流水
		$("#bTransIDH").val(resultmsg[0][4]);//落地方交易流水号
		$("#bseq").val(resultmsg[0][5]);//本次操作流水号
		$("#bMobileNum").val(resultmsg[0][6]);//手机号码
		$("#boprResult").val(resultmsg[0][7]);//业务请求的结果
		$("#bIMSI").val(resultmsg[0][8]);//IMSI
		$("#bICCID").val(resultmsg[0][9]);//ICCID
		$("#bSMSP").val(resultmsg[0][10]);//SMSP
		$("#bPIN1").val(resultmsg[0][11]);//PIN1
		$("#bPIN2").val(resultmsg[0][12]);//PIN2
		$("#bPUK1").val(resultmsg[0][13]);//PUK1
		$("#bPUK2").val(resultmsg[0][14]);//PUK2
		$("#bHomeProv").val(resultmsg[0][17]);//该号码的归属省省代码  漫游省用于选择K2的公钥，对K和OPc进行加密
		
		var simtypes=simtypess;
		var simnos=document.all.bICCID.value;
		var phonenos=document.all.bMobileNum.value;
		var simimsi=document.all.bIMSI.value;
		var simsmsp=document.all.bSMSP.value;
		
		var simpin1=document.all.bPIN1.value;
		var simpin2=document.all.bPIN2.value;
		var simpuk1=document.all.bPUK1.value;
		var simpuk2=document.all.bPUK2.value;
		var simhomeprov=document.all.bHomeProv.value;
		
	    var path = "s4240_writecard.jsp";
	    path = path + "?regioncode=" + "<%=regionCode%>";
	    path = path + "&sim_type=" +simtypes;
	    path = path + "&sim_no=" +simnos;
	    path = path + "&op_code=" +"<%=opCode%>";
	    path = path + "&phone="+phonenos+"&pageTitle=" + "写卡";
	    path = path + "&deleteShowCardNoFlag=" +"isDelCardNo"; 
	    path = path + "&simCardNumber="+simCardNumber;
	    path = path + "&simimsi="+simimsi;
	    path = path + "&simsmsp="+simsmsp;
	    path = path + "&simpin1="+simpin1;
	    path = path + "&simpin2="+simpin2;
	    path = path + "&simpuk1="+simpuk1;
	    path = path + "&simpuk2="+simpuk2;
	    path = path + "&simhomeprov="+simhomeprov;
	    
	    var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
	    if(typeof(retInfo) == "undefined"){	
	    	rdShowMessageDialog("写卡失败",0);
	    	return false;
	    } 
	    writesimcode=oneTok(oneTok(retInfo,"|",1));
	    writesimno=oneTok(oneTok(retInfo,"|",2));
	    writecardstatus=oneTok(oneTok(retInfo,"|",3));
	    writecardNo=oneTok(oneTok(retInfo,"|",4));
	    writecardKi=oneTok(oneTok(retInfo,"|",5));
	    writecardOpc=oneTok(oneTok(retInfo,"|",6));
	    if(writesimcode=="0"){
			go_wrtirCardAfter();
	    }else{
	      rdShowMessageDialog("写卡失败,0");
	      return false;
	    }
	}
	else{
		rdShowMessageDialog("<br>错误代码:["+retCode+"]</br>错误信息:["+retMsg+"]",0);
		rdShowMessageDialog("写卡失败",0);
		return false;
	}
}

function go_wrtirCardAfter(){
	var myPacket = new AJAXPacket("s4240_writecardafter.jsp","正在进行写卡后操作，请稍候......"); 
	myPacket.data.add("loginNo",document.all.loginNo.value);
	myPacket.data.add("orgCode",document.all.orgCode.value);
	myPacket.data.add("idValue",document.all.phoneNo.value);
	myPacket.data.add("seq",document.all.breakSeq.value);
	myPacket.data.add("myseq","<%=printAccept%>");
	myPacket.data.add("IMSI",document.all.bIMSI.value);
	myPacket.data.add("writeresult",writesimcode);
	myPacket.data.add("encK",writecardKi);
	myPacket.data.add("encOpc",writecardOpc);
	myPacket.data.add("signature","");
	myPacket.data.add("localProvCode","451");
	myPacket.data.add("bHomeProv",document.all.bHomeProv.value);
	myPacket.data.add("serviceFee","0");
	myPacket.data.add("simFee",$("#simFee").val());
	myPacket.data.add("simCardNumber",simCardNumber);
	myPacket.data.add("bICCID",$("#bICCID").val());
	core.ajax.sendPacket(myPacket,do_wrtirCardAfter);
	myPacket = null;
}
function do_wrtirCardAfter(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg =  packet.data.findValueByName("retMsg");
	if(retCode=="000000"){
		rdShowMessageDialog("写卡成功！",1);
		$("#b_write").attr("disabled","disabled");
		g412_show_Bill_Prt();
		return false;
	}
	else{
		rdShowMessageDialog("写卡失败！",0);
		$("#b_write").attr("disabled","");
		rdShowMessageDialog("<br>错误代码:["+retCode+"]</br>错误信息:["+retMsg+"]",0);
		return false;
	}
}

function showPrtDlg(printType,DlgMessage,submitCfm){
	//显示打印对话框
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var printStr = printInfo(printType);
	
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var sysAccept = "<%=printAccept%>";
	/* ningtn */
	var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
	var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
	/* ningtn */
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.all.phoneNo.value+"&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm")&&(submitCfm == "Yes"))
		{
			if(rdShowConfirmDialog('确认电子免填单吗？')==1)
			{
				go_wrtirCardBefort();
			}
		}
		if(ret=="continueSub")
		{
			if(rdShowConfirmDialog('确认要提交<%=opName%>信息吗？')==1)
			{
				go_wrtirCardBefort();
			}
		}
	}
	else{
		if(rdShowConfirmDialog('确认要提交<%=opName%>信息吗？')==1)
		{
			go_wrtirCardBefort();
		}
	}
}

function printInfo(printType){
 var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";

	cust_info+="手机号码："+document.all.phoneNo.value+"|";
	cust_info+="客户姓名："+document.all.retValue101.value+"|";

	opr_info+="办理业务:异地单卡写卡"+"|";
	opr_info+="号码归属地:"+document.all.retValue126.value+"|";
	opr_info+="操作流水：<%=printAccept%>|";
//	opr_info+="原SIM卡号："+""+"  原SIM卡类型："+""+"|";
	opr_info+="新SIM卡号："+simCardNumber+"  新SIM卡类型："+simtypess+"|";

	note_info1="备注："+"|";
	var retValue127 = $("#retValue127").val();
	if(retValue127="准星"||retValue127=="一星"||retValue127=="二星"||retValue127=="未评级"){
		note_info1+="尊敬的先生/女士，欢迎您办理跨区补卡服务，您的手机SIM卡已于<%=monthDate%>月<%=dayDate%>日在中国移动黑龙江公司重新激活。请拨打您手机归属省的10086予以确认 。|";
	}
	else if(retValue127="三星"||retValue127=="四星"||retValue127=="五星"||retValue127=="五星金"||retValue127=="五星钻"){
		note_info1+="尊敬的先生/女士，欢迎您办理跨区补卡服务，您的手机SIM卡已于<%=monthDate%>月<%=dayDate%>日在中国移动黑龙江公司重新激活，您现在的星级是"+retValue127+"级。请拨打您手机归属省的10086予以确认 。|";
	}
	
	
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
   return retInfo;
}

//打印发票
function g412_show_Bill_Prt(){
		var  billArgsObj = new Object();
		var public_opCode = "<%=opCode%>";
		$(billArgsObj).attr("10001","<%=loginNo%>");     //工号
		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10005",document.all.retValue101.value);   //客户名称
		$(billArgsObj).attr("10006","异地单卡写卡费用");    //业务类别
		
		$(billArgsObj).attr("10008",document.all.phoneNo.value);    //用户号码
		$(billArgsObj).attr("10015", $("#simFee").val());   //本次发票金额
		$(billArgsObj).attr("10016", $("#simFee").val());   //大写金额合计
		$(billArgsObj).attr("10017","*");        //本次缴费：现金
		/*10028 10029 不打印*/
		$(billArgsObj).attr("10028","");//参与的营销活动名称：
		$(billArgsObj).attr("10029","");//营销代码	
		$(billArgsObj).attr("10030","<%=printAccept%>");   //流水号：--业务流水
		$(billArgsObj).attr("10036","g412");   //操作代码
			/**/
			/*型号不打*/
		$(billArgsObj).attr("10061","");	       //型号
		$(billArgsObj).attr("10062","");	//税率
		$(billArgsObj).attr("10063","");	//税额	   
	    $(billArgsObj).attr("10071","6");	//
 		$(billArgsObj).attr("10076", $("#simFee").val());
			
		$(billArgsObj).attr("10083", "身份证"); //证件类型
		$(billArgsObj).attr("10084", document.all.cardID.value); //证件号码
		$(billArgsObj).attr("10086", "尊敬的客户，如您办理业务退订、取消等中止业务使用的操作时，请携带本收据、有效身份证件、办理业务时所得魔百和终端到移动指定自有营业厅办理押金退还手续。"); //备注
		$(billArgsObj).attr("10065", ""); //宽带账号
		$(billArgsObj).attr("10087", ""); //imei号码
 			 

		$(billArgsObj).attr("10041", "");           //品名规格
		$(billArgsObj).attr("10042","张");                   //单位
		$(billArgsObj).attr("10043","1");	                   //数量
		$(billArgsObj).attr("10044",$("#simFee").val());	                //单价
			
			 			
		$(billArgsObj).attr("10085", "zsj"); //宽带费用收取方式 只弹出打印收据的框
		$(billArgsObj).attr("10072","1"); //1--正常发票  2--冲正类发票  2--退费类发票

		$(billArgsObj).attr("10088",public_opCode); //收据模块
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？";
					//发票项目修改为新路径
		//$(billArgsObj).attr("11213","REC");  //新版发票新增票据标志位，默认空位发票 REC == 只有 打印纸质收据
		var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "确实要进行发票打印吗？";
		var loginAccept = "<%=loginAccept%>";
		var path = path +"&loginAccept="+loginAccept+"&opCode="+public_opCode+"&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop);
		parent.removeTab("g412");
}
</script>

</head>
		<form method="post" name="frm" id="frm">
		<input type="hidden" id="retrspCode" name="retrspCode" value=""/><!-- 应答代码 -->
		<input type="hidden" id="retrspDesc" name="retrspDesc" value=""/><!-- 应答描述 -->
		<input type="hidden" id="retSessionID" name="retSessionID" value=""/><!-- 业务流水 -->
		<input type="hidden" id="retTransIDO" name="retTransIDO" value=""/><!-- 交易流水 -->
		<input type="hidden" id="retTransIDH" name="retTransIDH" value=""/><!-- 落地方交易流水号 -->
		<input type="hidden" id="retIDType" name="retIDType" value=""/><!-- 标识类型 -->
		<input type="hidden" id="retIDValue" name="retIDValue" value=""/><!-- 标识号码 -->
		<input type="hidden" id="retoprResult" name="retoprResult" value=""/><!-- 业务请求的结果 -->
		<input type="hidden" id="retResultDesc" name="retResultDesc" value=""/><!-- 错误描述 -->
		<input type="hidden" id="retValue100" name="retValue100" value=""/><!-- 客户标志 -->
		<input type="hidden" id="retValue103" name="retValue103" value=""/><!-- 证件类型 -->
		<input type="hidden" id="retValue104" name="retValue104" value=""/><!-- 证件号码 -->
		<br/>
		<input type="hidden" id="brspCode" name="brspCode" value=""/><!-- 应答代码 -->
		<input type="hidden" id="brspDesc" name="brspDesc" value=""/><!-- 应答描述 -->
		<input type="hidden" id="bSessionID" name="bSessionID" value=""/><!-- 业务流水 -->
		<input type="hidden" id="bTransIDO" name="bTransIDO" value=""/><!-- 交易流水 -->
		<input type="hidden" id="bTransIDH" name="bTransIDH" value=""/><!-- 落地方交易流水号 -->
		<input type="hidden" id="bseq" name="bseq" value=""/><!-- 本次操作流水号 -->
		<input type="hidden" id="bMobileNum" name="bMobileNum" value=""/><!-- 手机号码 -->
		<input type="hidden" id="boprResult" name="boprResult" value=""/><!-- 业务请求的结果 -->
		<input type="hidden" id="bIMSI" name="bIMSI" value=""/><!-- IMSI -->
		<input type="hidden" id="bICCID" name="bICCID" value=""/><!-- ICCID -->
		<input type="hidden" id="bSMSP" name="bSMSP" value=""/><!-- SMSP -->
		<input type="hidden" id="bPIN1" name="bPIN1" value=""/><!-- PIN1 -->
		<input type="hidden" id="bPIN2" name="bPIN2" value=""/><!-- PIN2 -->
		<input type="hidden" id="bPUK1" name="bPUK1" value=""/><!-- bPUK1 -->
		<input type="hidden" id="bPUK2" name="bPUK2" value=""/><!-- bPUK2 -->
		<input type="hidden" id="bHomeProv" name="bHomeProv" value=""/><!-- 该号码的归属省省代码  漫游省用于选择K2的公钥，对K和OPc进行加密 -->
		
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">异地写卡申请
					</div>
			</div>

	<table cellspacing="0">

		<tr id="test">
			<td class="blue">开通方式</td>
			<td colspan="3"><select name="test_flag" id="test_flag">
			</select></td>
		</tr>
		<tr>
			<td class="blue">客户标识类型</td>
			<td><select name="IDType" id="IDType">
					<option value="01">01--&gt;手机号码</option>
			</select></td>
			<td class="blue">客户标识</td>
			<td>
				<input id="phoneNo" name="phoneNo" type="text" class="button" index="1" maxlength="11" v_must=1 v_type="mobphone" v_minlength=11 v_name="手机号码" value=""/>
				<font class='orange'>*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">客户密码</td>
			<td colspan='3'>
				<input name="custPWD" type="password" class="button" index="2" id="custPWD" maxlength="8" v_must=1 v_type=0_9 v_minlength=1 v_name="客户密码"/>
				<font class='orange'>*(客户密码和证件号码二选一)</font>
			</td>
		</tr>
		<tr>
			<td class="blue">证件类型</td>
			<td>
				<select name="cardType" id="cardType">
					<option value="00">00--&gt;身份证</option>
					<!--  <option value="01">01--&gt;VIP卡</option>
                <option value="02">02--&gt;护照</option>
                <option value="04">04--&gt;军官证</option>
                <option value="05">05--&gt;武装警察身份证</option>
                <option value="99">99--&gt;其它</option> -->
				</select>
			</td>
			<td class="blue">证件号码</td>
			<td>
				<input name="cardID" type="text" class="button" id="cardID" maxlength="20" v_must=1 v_type=0_9 v_minlength=1 v_name="证件号码" value=""/>
				<font class="orange">*</font>
				<input type="button" id="dukaBut1" class="b_text" value="读卡" onclick="Idcard_realUser()" /> <input type="button" id="dukaBut2" class="b_text" value="读卡(2代)" onclick="Idcard2()" />
				<input name="noCheck" type="button" class="b_text" id="noCheck" value="验证" onclick="go_call_noCheck()" />
			</td>
		</tr>
		<tr>
			<td class="blue">客户姓名</td>
			<td>
				<input type="text" id="retValue101" name="retValue101" readonly="readonly" />
			</td>
			<td class="blue">客户积分</td>
			<td>
				<input type="text" id="retValue114" name="retValue114" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="blue">入网时间</td>
			<td>
				<input type="text" id="retValue118" name="retValue118" readonly="readonly" />
			</td>
			<td class="blue">用户状态</td>
			<td>
				<input type="text" id="retValue119" name="retValue119" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="blue">PUK码</td>
			<td>
				<input type="text" id="retValue122" name="retValue122" readonly="readonly" />
			</td>
			<td class="blue">信用度</td>
			<td>
				<input type="text" id="retValue123" name="retValue123" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="blue">归属地名称</td>
			<td>
				<input type="text" id="retValue126" name="retValue126" readonly="readonly" />
			</td>
			<td class="blue">用户星级</td>
			<td>
				<input type="text" id="retValue127" name="retValue127" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="blue">客户俱乐部</td>
			<td>
				<input type="text" id="retValue128" name="retValue128" readonly="readonly" />
			</td>
			<td class="blue">客户品牌</td>
			<td>
				<input type="text" id="retValue129" name="retValue129" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="blue">增值业务开放情况</td>
			<td>
				<input type="text" id="retValue124" name="retValue124" readonly="readonly" />
			</td>
			<td class="blue"></td>
			<td>
			</td>
		</tr>
		<tr>
			<td class="blue">帐户应缴金额(元)</td>
			<td>
				<input type="text" id="yjFee" name="yjFee" value="" readonly="readonly"/>
			</td>
			<td class="blue">帐户预存余额(元)</td>
			<td>
				<input type="text" id="ycFee" name="ycFee" value="" readonly="readonly"/>
			</td>
		</tr>
		<jsp:include page="s4240_sanzhang.jsp">
			<jsp:param name="hwAccept" value="<%=sLoginAccept%>" />
			<jsp:param name="showBody" value="01" />
			<jsp:param name="sopcode" value="<%=opCode%>" />
			<jsp:param name="renzhengShow" value="<%=renzhengShow%>" />
			<jsp:param name="labelName" value="submitFlagC" />
		</jsp:include>
		<tr>
			<td class="blue" width="15%">sim卡号</td>
			<td colspan="3">
				sim卡卡费(单位/元):<input type="text" id="simFee" name="simFee" value="" maxlength="5" />
			</td>
		</tr>
		<tr>
			<td colspan="4" id="footer" class="blue" align='center'>
				<input class="b_text" type="button" id="b_write" name="b_write" value="确认" onmouseup="writechg(this)" onkeyup="if(event.keyCode==13)writechg()" disabled="disabled" /> &nbsp;
				<!-- <input class="b_foot" name="reset" type="button" value="清除" onclick="reset()"/> -->
			</td>
		</tr>
	</table>
<script language="JavaScript">
$("tr[id='sanzhangTr']").hide();
</script>
	<input type="hidden" name="guid" id="guid" value="<%=loginNo%>"/>
	<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>"/>
	<input type="hidden" name="loginNoPass" id="loginNoPass" value="<%=loginNoPass%>"/>
	<input type="hidden" name="loginName" id="loginName" value=""/>
	<input type="hidden" name="opCode" id="opCode" value=""/>
	<input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>"/>
	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>"/>
	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>"/>
	<input type="hidden" name="totalDate" id="totalDate" value="<%=totalDate%>"/>                                                     
	<input type="hidden" name="tmpBusyAccept" id="tmpBusyAccept" value=""/>
	<input type="hidden" name="tmpSendAccept" id="tmpSendAccept" value=""/> 	
	<input type="hidden" name="tmpBackAccept" id="tmpBackAccept" value=""/>	
	<input type="hidden" name="opType" class="button" id="opType" value="异地写卡申请"/>
	<%@ include file="/npage/include/footer.jsp" %>		
</form>
</body>
<object id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"/> 
<%@ include file="/npage/sq100/interface_provider.jsp" %>
</html>
