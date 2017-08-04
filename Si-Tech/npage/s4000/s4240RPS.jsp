<%
/********************
     version v2.0
     开发商: si-tech
     4240写卡界面，调用写卡组件进行写卡，组件不成功调用s4242Cfm.jsp进行写卡
     gaopeng 20130105 改为新版界面，与产品部qucc合作
     ********************/
%> 
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.ArrayList"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%  
    //测试地址：http://10.110.0.205:32000/writecard/writecard/NewWriteCard.jsp?datatype=1&operid=13821051382&homecity=451&phonenum=13821051382&res_code=10016&data=898600900815F4610118,460004619010118,E19FA7EC4C7E891BE9A8FD6DD5049C89,13821051382,460004619010118,460004619010118,460004619010118,460004619010118

    //测试地址 http://10.110.0.204:10008/page/s4000/s4240RPS.jsp?phone=13821051382&sImsiNo=460004619010118&sSimNo=898600900815F4610118&prov=4510&tmpBusyAccept=123456&simData=898600900815F4610118,460004619010118,E19FA7EC4C7E891BE9A8FD6DD5049C89,13821051382,460004619010118,460004619010118,460004619010118,460004619010118
		String opCode = "g412";
		String opName = "异地单卡写卡";
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
	
		String path=request.getRealPath(""); 
    String op_code=request.getParameter("op_code");
    
    String retCode="";
    String retMessage="";
    String sim_data="";
    String eki_no="";
    String sim_data1="";
    String imsi_no="";
    String new_simdata="";
    
 
    //String sim_type=request.getParameter("sim_type");
String sim_type="10015";//远程写卡默认，值待定
   
    String phone_no=request.getParameter("phone");
		String prov=request.getParameter("prov");
		String sSimNo=request.getParameter("sSimNo");
		String sImsiNo=request.getParameter("sImsiNo");
		String tmpBusyAccept=request.getParameter("tmpBusyAccept");
		String simData=request.getParameter("simData");
		//MyLog.debugLog("sImsiNo11111111111="+sImsiNo);
        //MyLog.debugLog("simData111111111="+simData);
	     simData=simData.replaceAll(" ","+");
		imsi_no=sImsiNo;			  	
		sim_data=simData;
		//MyLog.debugLog("sSimNo2222222="+sSimNo);
		//MyLog.debugLog("sImsiNo22222222="+sImsiNo);
		//MyLog.debugLog("simData3333333333="+simData);
           
   String custPWD=request.getParameter("custPWD");//客户密码
	 String cardID=request.getParameter("cardID"); //证件号码
	 String cardType=request.getParameter("cardType"); //证件类型
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>异地写卡--写卡</title>


<SCRIPT type=text/javascript>

  
  var openurl="";

	function jtrim(str)
	{ //删除左右两端的空格
　　return str.replace(/(^\s*)|(\s*$)/g, "");
  }
  
  function doProcess(packet)
 {
 	var errCode=packet.data.findValueByName("retCode");
	var errMsg=packet.data.findValueByName("retMessage");
	var retType=packet.data.findValueByName("retType");
 	
	if(retType=="getwritename"){
		//alert("开始获取卡组件名称getWritename");
		if(errCode!="000000")
		{
		//alert(errCode+"结束获取卡组件名称getWritename:"+errMsg);
		openurl="s4242Cfm.jsp?phone=<%=phone_no%>&IMSI=<%=sImsiNo%>&Result=11&ICCID=<%=sSimNo%>&tmpBusyAccept=<%=tmpBusyAccept%>&multflag=0&prov_code="+document.all.prov_code.value+"&custPWD=<%=custPWD%>&cardID=<%=cardID%>&cardType=<%=cardType%>";
		location.href=openurl;
		//return false;
		}
		  var write_name = packet.data.findValueByName("write_name");   
		  var ver=packet.data.findValueByName("ver");  
		  var s2=packet.data.findValueByName("s2");  
		  var pass=packet.data.findValueByName("pass");
		  var simsimdata=packet.data.findValueByName("simsimdata");  
		  //alert("simsimdata="+simsimdata);
		  // alert("simsimdata3333333333333333333333333333="+simsimdata);
		  document.all.simdata.value=simsimdata;
		 
		 //取回组件名称
		writecardocx.SetWriteCardDllPath("");
		var dllpath=writecardocx.GetWriteCardDllPath()+"\\";//这有个问题取的是哪个组件的位置
		var dllver= writecardocx.GetDllVersion(write_name);
		
		if(dllver=="" ||dllver!=ver){
			writecardocx.SetWriteCardDllPath("");
			if(s2=="no"){
				alert("写卡dll不存在");
				openurl="s4242Cfm.jsp?phone=<%=phone_no%>&IMSI=<%=sImsiNo%>&Result=11&ICCID=<%=sSimNo%>&tmpBusyAccept=<%=tmpBusyAccept%>&multflag=0&prov_code="+document.all.prov_code.value+"&custPWD=<%=custPWD%>&cardID=<%=cardID%>&cardType=<%=cardType%>";
				location.href=openurl;
				return false;
			}
			var savebz=writecardocx.SaveFile(write_name,s2);//savefile问题
			
			//alert ("savebz="+savebz);
			if (savebz!=0){
				alert("保存写卡组件失败");
				document.all.writecardbz.value="1";
				openurl="s4242Cfm.jsp?phone=<%=phone_no%>&IMSI=<%=sImsiNo%>&Result=11&ICCID=<%=sSimNo%>&tmpBusyAccept=<%=tmpBusyAccept%>&multflag=0&prov_code="+document.all.prov_code.value+"&custPWD=<%=custPWD%>&cardID=<%=cardID%>&cardType=<%=cardType%>";
				location.href=openurl;
				return false;
			}
		}

		var dllmy=writecardocx.VerifyWriteCardDll(write_name+".dll",pass);//还有个密码
		
		//alert("dllmy="+dllmy);
		//dllmy=0;
		if(dllmy==0){
		        
			var ss="";
			if(document.all.sim_type.value=="10006"){ss="2";}else{ss="1";}			
			
			/*
			document.all.simdata.value= substr(document.all.simdata.value, 1, 70)+"+"+substr(document.all.simdata.value, 71, document.all.simdata.length);
			
			document.all.simdata.value= document.all.simdata.value.substring(0,70)+"+"+document.all.simdata.value.substring(71,document.all.simdata.value.length);
			*/
			//document.all.simdata.value= document.all.simdata.value.substring(0,70)+"+"+document.all.simdata.value.substring(71,document.all.simdata.value.length);

			//alert("document.all.simdata.value111111="+document.all.simdata.value);
			//modified by ludl for test writecard 
			
			/*add by baidq*/
			var cjbz=",,,,,,,";
			if(jtrim(document.all.prov_code.value)!="5"){
				var car_no=jtrim(document.all.card_no.value).substring(6,8);
				cjbz=car_no+",,";
			}else{
				cjbz=",,";
			}
			//var writebz=0;//模拟测试
			var writebz=writecardocx.WriteCard(write_name,pass,ss,document.all.simdata.value,cjbz,"2000");
			//alert("writebz="+writebz);
			//writebz=0;//模拟测试
			if(writebz!=0){				
		    alert("写卡失败，请重写,错误代码"+writebz);
		    document.all.writecardbz.value="1";
		    return false;
				 
			}else{
				var imsino=writecardocx.GetSIMIMSI();
				//imsino="460004619010118";//模拟测试
				if(imsino=="<%=imsi_no%>"){
					alert("写卡成功,开始修改卡状态");
					document.all.writecardbz.value="2";
					savedata();					
				}else{
					alert("写卡失败，此卡已坏，不能再用");
					document.all.writecardbz.value="1";
					openurl="s4242Cfm.jsp?phone=<%=phone_no%>&IMSI=<%=sImsiNo%>&Result=11&ICCID=<%=sSimNo%>&tmpBusyAccept=<%=tmpBusyAccept%>&multflag=0&prov_code="+document.all.prov_code.value+"&custPWD=<%=custPWD%>&cardID=<%=cardID%>&cardType=<%=cardType%>";
					location.href=openurl;
					return false;
				}
			}
		}else{
			document.all.writecardbz.value="1";
			alert("写卡组件密码验证失败");
			openurl="s4242Cfm.jsp?phone=<%=phone_no%>&IMSI=<%=sImsiNo%>&Result=11&ICCID=<%=sSimNo%>&tmpBusyAccept=<%=tmpBusyAccept%>&multflag=0&prov_code="+document.all.prov_code.value+"&custPWD=<%=custPWD%>&cardID=<%=cardID%>&cardType=<%=cardType%>";
			location.href=openurl;
			return false;
		}
	}
	
	if(retType=="updatedata"){
		//alert(errCode);
		if(errCode!="000000")
		{
		 //alert(errCode+":"+errMsg);
		 document.all.writecardbz.value="3";		
		}
		else{
		 document.all.writecardbz.value="0";
	  }
	  openurl="s4242Cfm.jsp?phone=<%=phone_no%>&IMSI=<%=sImsiNo%>&Result=00&ICCID=<%=sSimNo%>&tmpBusyAccept=<%=tmpBusyAccept%>&multflag=0&prov_code="+document.all.prov_code.value+"&custPWD=<%=custPWD%>&cardID=<%=cardID%>&cardType=<%=cardType%>";
		location.href=openurl;
		//alert("turnToDepend");
		//turnToDepend();
	}
 }
function getwritename(){

	//alert("in getwritename");
		
  	var getAccountId_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s4000/fgetwritename_1104.jsp","正在获得写卡组件，请稍候......");
		/*fgetwritename_1104.jsp?retType=getwritename&region_code=01&sim_type=10001&prov_code=100&card_type=01&card_no=0806000100000028&sim_data=460001764118519,898600910106F8814809,DD1922A72B2F0AA609144417576C78F2,+8613800100500,1234,2345,96764029,03713975*/
    getAccountId_Packet.data.add("retType","getwritename");
		getAccountId_Packet.data.add("region_code","<%=regionCode%>");
		getAccountId_Packet.data.add("sim_type",jtrim(document.all.sim_type.value));
		getAccountId_Packet.data.add("prov_code",jtrim(document.all.prov_code.value));
		getAccountId_Packet.data.add("card_type",jtrim(document.all.card_type.value));
		getAccountId_Packet.data.add("card_no",jtrim(document.all.card_no.value));
		getAccountId_Packet.data.add("sim_data","<%=sim_data%>");
		
		//alert("sim_data111111111111:"+jtrim(document.all.card_no.value));
		core.ajax.sendPacket(getAccountId_Packet);
    getAccountId_Packet = null; 	
  	

}
function getFlagresume(){
	
		
  		 var getFlagresume_Packet = new AJAXPacket("<%=request.getContextPath()%>/page/s4000/fgetFlagresume.jsp","正在获得写卡组件，请稍候......");
    		getFlagresume_Packet.data.add("retType","fgetFlagresume");
		getFlagresume_Packet.data.add("region_code","<%=regionCode%>");
		
		getFlagresume_Packet.data.add("prov_code",(document.all.prov_code.value).trim());
	
		getFlagresume_Packet.data.add("card_no",(document.all.card_no.value).trim());

		core.ajax.sendPacket(getFlagresume_Packet);
    getFlagresume_Packet = null; 	
  	

}

function turnToDepend1(){//写卡 		
		//alert("开始写卡");
		var ocxver=writecardocx.GetVersion();
		//alert("写卡组件版本号:"+ocxver);
		var isgoodcard=writecardocx.IsCardExist();
		//alert("是否好卡："+isgoodcard);
		if(isgoodcard==0){
			var card_bz=writecardocx.GetSIMICCID();
			
			
			var card_no=writecardocx.GetICCSerial();//取空卡序列号
			
			//card_no='0806000100000028';//模拟空卡号
			if(card_no==""){
				alert("空卡状态错误！");
				
				document.all.writecardbz.value="1";
				return false;
		  }
		  // add by lvdl for sim reused begin
		  else 
			{
		  // add by lvdl for sim reused end
			document.all.card_no.value=card_no;
			var prov_code=card_no.substring(8,9);
			//alert("prov_code厂商标志位"+prov_code);
			var card_type=card_no.substring(6,8);
			document.all.prov_code.value=prov_code;
			document.all.card_type.value=card_type;
			
			var sim_type="100"+card_type;
			document.all.sim_type.value=sim_type;

			//alert("sim_type1="+sim_type);
			//alert("card_bz="+card_bz);
	
			/* 注销这段代码
			if(document.all.sim_type.value!="10006"){
				if(card_bz.substring(0,4)=="8986"){
					alert("请插入空卡");
					document.all.writecardbz.value="1";
					return false;
				}
			}
			*/
			//alert("开始获取写卡组件名称");
			var writeResult="00"; //写卡成功标志（包括写卡成功，更新卡状态失败的情况）
			  writecard();
			}
			
		}else{
			alert("请插入卡!");
			document.all.writecardbz.value="1";
			return false;
		}
}
function writecard()
{
	//alert("ccccccccccc");
	var simdata="<%=sim_data%>";
	//alert(simdata);
	var simsim1=simdata.substring(0,12);
	//alert(simsim1);
	//alert(simdata.length);
	var simsim3=simdata.substring(13,simdata.length);
	//alert("cccccccc="+simsim3);
	//alert("dddd="+document.all.prov_code.value);
	if(document.all.card_no.value=="" || document.all.card_no.value=="FFFFFFFFFFFFFFFF")
	{
		document.all.simdata.value=simdata;
	}else
	{
		//alert("fffffffffff");
		document.all.simdata.value=simsim1+document.all.prov_code.value+simsim3;
		//alert("gggggggggg");
	}
	//alert(document.all.simdata.value);
    var sim_type_new =document.all.sim_type.value;

   //alert("sim_type3=="+sim_type_new);

		path = "http://10.110.0.100:33000/writecard/writecard/NewWriteCard.jsp"
	//path = "http://10.110.0.205:32000/writecard/writecard/NewWriteCard.jsp"
    path = path + "?datatype=1&operid=<%=phone_no%>&homecity=<%=prov%>";
    path = path + "&phonenum=<%=phone_no%>" + "&res_code="+sim_type_new ;
	
    path = path + "&data="+document.all.simdata.value;
	//alert("path =   ---"+path);
    var retInfo = window.showModalDialog("Trans.html",path,"","dialogWidth:50;dialogHeight:40;");

	if(typeof(retInfo) == "undefined")     
    {	
    	//alert(1);
    	rdShowMessageDialog("写卡出错!");
    	return false; 
    	/*
    		以下为gaopeng增加，用来测试
    	
    	//var openurl="s4242Cfm.jsp?phone=<%=phone_no%>&IMSI=<%=sImsiNo%>&Result=00&ICCID=<%=sSimNo%>&tmpBusyAccept=<%=tmpBusyAccept%>&multflag=0&prov_code="+document.all.prov_code.value+"&custPWD=<%=custPWD%>&cardID=<%=cardID%>&cardType=<%=cardType%>";
   		//alert(openurl);
   		//window.location.href=openurl;
   		*/ 
   }
    var chPos;
    chPos = retInfo.indexOf("&");
    if(chPos < 0)
    {	
    	rdShowMessageDialog("写卡出错!");
    	//alert("2");
    	return false ;	
    	/*
    		以下为gaopeng增加，用来测试
    	
    	var openurl="s4242Cfm.jsp?phone=<%=phone_no%>&IMSI=<%=sImsiNo%>&Result=00&ICCID=<%=sSimNo%>&tmpBusyAccept=<%=tmpBusyAccept%>&multflag=0&prov_code="+document.all.prov_code.value+"&custPWD=<%=custPWD%>&cardID=<%=cardID%>&cardType=<%=cardType%>";
   		alert(openurl);
   		window.location.href=openurl;
   		*/
    	
    	}
    //alert( retInfo.substring(0,chPos));
    retInfo=retInfo+"&";


    var retVal=new Array();   
    for(i=0;i<12;i++)
    {   	   
    	
    	var chPos = retInfo.indexOf("&");
        valueStr = retInfo.substring(0,chPos);
        var chPos1 = valueStr.indexOf("=");
        valueStr1 = valueStr.substring(chPos1+1);
        retInfo = retInfo.substring(chPos+1);
        retVal[i]=valueStr1;
        //alert("retVal["+i+"]="+retVal[i]);
    } 
		

    //return;

    if(retVal[0]!="0")
    {
			

		rdShowMessageDialog("写卡失败，错误代码"+retVal[0]+"请重写");
		document.all.writecardbz.value="1";
		return false;
				 
	}else
	{
		var imsino=writecardocx.GetSIMIMSI();
		document.all.sim_no.value=retVal[5];
		//alert("document.all.sim_no.value="+document.all.sim_no.value);
		/*alert("imsino="+imsino);
		imsino="<%=imsi_no%>"*/
		if(imsino=="<%=imsi_no%>")
		{
			rdShowMessageDialog("写卡成功,开始修改卡状态");
			document.all.writecardbz.value="2";
			savedata();
					
		}else
		{
			rdShowMessageDialog("写卡失败，此卡已坏，不能再用");
			document.all.writecardbz.value="1";
			return false;
		}
			
	}
}
function resultReply(writeResult){
			
		var openurl="s4242Cfm.jsp?phone=<%=phone_no%>&IMSI=<%=sImsiNo%>&Result="+writeResult+"&ICCID=<%=sSimNo%>&tmpBusyAccept=<%=tmpBusyAccept%>&multflag=0&custPWD=<%=custPWD%>&cardID=<%=cardID%>&cardType=<%=cardType%>";
		//alert(openurl);
		//location.href=openurl;
}
function savedata(){
	/*alert("savedata");
	alert("<%=request.getContextPath()%>/page/s4000/fsavecard_1104.jsp");*/
	var getjysim_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s4000/fsavecard_1104.jsp","正在修改空卡状态，请稍候......");
  getjysim_Packet.data.add("retType","updatedata");
	getjysim_Packet.data.add("region_code","<%=regionCode%>");
	getjysim_Packet.data.add("phone_no",jtrim(document.all.phone_no.value));
	getjysim_Packet.data.add("sim_no",jtrim(document.all.sim_no.value));
	getjysim_Packet.data.add("card_no",jtrim(document.all.card_no.value));
	getjysim_Packet.data.add("op_code","<%=op_code%>");
	/*alert(document.all.card_no.value);*/
		core.ajax.sendPacket(getjysim_Packet);
    getjysim_Packet = null; 		
}
	
function turnToDepend()
{
	var retCode_Now=jtrim(document.all.writecardbz.value);
	//alert("sss="+document.all.simdata.value);
	var returnsim=document.all.simdata.value.substring(0,20);
	//alert("returnsim="+returnsim);
	
	var retCode = retCode_Now; 
	//var retName = retName_Now + retName_After + retName_AddNo;
	if(retCode =="1")
	{	
		rdShowMessageDialog("写卡失败！",0);
		return false;
	}
	if(retCode =="3")
	{	
		rdShowMessageDialog("写卡成功,修改卡状态失败！",0);
		return false;
	}
	var retInfo = retCode+"|"+returnsim+"|";
	//alert(retInfo);
	window.returnValue= retInfo;  
	//alert(写卡成功);
  
}
//-----------------------------------------------
function goBack(){
  window.location.href="s4240.jsp?opCode=g412&opName=异地单卡写卡&crmActiveOpCode=g412";
}

</SCRIPT>


</head>
<body >
<FORM method=post name="getsimno">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">异地写卡-写卡</div>
			</div>	
      <table cellspacing="0">       	      
          <tr > 
            <td class="blue">sim卡号码</td>
            <td ><input type="text" name="sim_no" readonly value="<%=sSimNo%>"></td>
            <td class="blue">服务号码</td>
            <td ><input type="text" name="phone_no" readonly value="<%=phone_no%>"></td>            
          </tr>
          <tr colspan="4" class="blue" align='center' id="footer"> 
            <td colspan="4"> 
                <input class="b_foot" name=commit onClick="turnToDepend1()" style="cursor:hand" type=button value=写卡>&nbsp;
                <input class="b_foot" name=back onClick="goBack()" style="cursor:hand" type=button value=返回>&nbsp;</td>
          </tr>
          <input type="hidden" name="sim_type" readonly value="<%=sim_type%>">
             <input type="hidden" name="prov_code" >
             <input type="hidden" name="returnsim" >
             <input type="hidden" name="simdata" >
             <input type="hidden" name="card_no" >
             <input type="hidden" name="writecardbz" value="1" >
             <input type="hidden" name="card_type">
             <input type="hidden" name="s2">
        </table>

  


  <input type="hidden" name="modeCode" >
  <input type="hidden" name="modeName" >
	<%@ include file="/npage/include/footer.jsp" %>
</form>
<OBJECT
ID= "writecardocx"
CLASSID="clsid:930C8A98-EC73-4C37-9E20-9F4E0A5F93C4"
CODEBASE="/ocx/hljqqx.cab#version=1,0,0,1"
WIDTH = 0
HEIGHT = 0
ALIGN = center
HSPACE = 0
VSPACE = 0>
</OBJECT>
</body>
</html>
