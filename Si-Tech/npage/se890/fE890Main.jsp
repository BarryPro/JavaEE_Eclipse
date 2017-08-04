<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.crmpd.core.wtc.*"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
String currentTime =  new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());//当前日期
int currentTime2 =  Integer.parseInt(new java.text.SimpleDateFormat("MM").format(new java.util.Date()))-1;
String currentTime3 =  currentTime2<10?"0"+currentTime2:""+currentTime2;
String currentTime1 =  new java.text.SimpleDateFormat("yyyy").format(new java.util.Date())+currentTime3;//当前日期的上一个月
String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");
String regionCode = (String)session.getAttribute("regCode");
String broadPhone  = WtcUtil.repNull(request.getParameter("broadPhone"));
String phoneNoJv = activePhone;
String querySql1 = "SELECT count(*) FROM dservordermsg where service_no ='"+phoneNoJv+"' and finish_flag <> 'Y' ";
System.out.println("--------mylog-------querySql1---"+querySql1);

/** tianyang add for pos start **/
String workNo = (String)session.getAttribute("workNo");
String orgCode = (String)session.getAttribute("orgCode");
String groupId = (String)session.getAttribute("groupId");
String passwd=(String)session.getAttribute("password");
/** tianyang add for pos end **/
%>
 	 <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=querySql1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>	

<%
	String retSultSum1 = "0";
	if(result_t1.length>0&&result_t1[0][0]!=null){
		retSultSum1 = result_t1[0][0];
	}
	
	if(!retSultSum1.equals("0")){
%>
<SCRIPT type=text/javascript>
	rdShowMessageDialog("该用户下有未竣工的订单，请处理后再冲正",0);
	removeCurrentTab();
</SCRIPT>
<%	
	}
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" 
	routerKey="region" routerValue="<%=regionCode%>"  id="printAccept" />

<wtc:service name="sChildOfferInit" outnum="4"
	routerKey="region" routerValue="<%=regionCode%>" 
	retcode="cldCode" retmsg="cldMsg">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=passwd%>"/>
	<wtc:param value="<%=phoneNoJv%>"/>
	<wtc:param value=""/>
	<wtc:param value="2"/>
</wtc:service>
<wtc:array id="rstProd" scope="end" />

<%
System.out.println("e890~~~~cldCode="+cldCode);
if ( !cldCode.equals("000000") )
{
%>
	<script>
		rdShowMessageDialog("<%=cldCode%>:<%=cldMsg%>");
		removeCurrentTab();
	</script>	
<%
}
else
{
System.out.println("e890~~~~rstProd="+rstProd.length);
}
%>

				

<HEAD><TITLE>订单冲正查询</TITLE>
</HEAD>
<SCRIPT type=text/javascript>

	var _KMap=function(){
	this.init.apply(this,arguments);
	}
	_KMap.prototype={
		init:function(){
			this.map={};
		},
		add:function(key,value){
			if(this.map[key]==null){
				this.map[key]=new Array();
			}
			this.map[key].push(value);
		}

	}
	var printinfo = "";
	var idInfo = new Array();

	function g(objectId)
{
	if (document.getElementById && document.getElementById(objectId))
	{
		return document.getElementById(objectId);
	}
	else if (document.all && document.all[objectId])
	{
		return document.all[objectId];
	}
	else if (document.layers && document.layers[objectId])
	{
		return document.layers[objectId];
	}
	else
	{
		return false;
	}
}

	function doSearch(){
		var idType = g("idType").value.trim(); //查询条件
		var servno = document.all.servno.value.trim(); //条件值
		if(servno == ""){
		    rdShowMessageDialog("条件值不能为空！",0);
		    document.all.servno.focus();
		    return false;
		}
		var searchDate = document.all.searchDate.value; //查询日期
		//$("#searchResult").toggle();
		var packet = new AJAXPacket("fE890Ajax.jsp","请稍后...");
		packet.data.add("idType",idType);
		packet.data.add("servno",servno);
		packet.data.add("selFlag",document.all.idType.value);
		packet.data.add("modeFlag",document.all.modeFlag.value);

		if(idType == '0' || idType == '4'){
				packet.data.add("searchDate",searchDate);
		}

		core.ajax.sendPacketHtml(packet,doSearchData);
		packet = null;
	}

	function doSearchData(data){
		$("#searchResult").html(data);
	}

	function callDetail(){
		window.showModalDialog("callDetail.jsp","","dialogWidth:50;dialogHeight:45;");
	}

	//点击多选框触发事件，查询订单子项ID的绑定关系
	function sBindQuery(obj,lineFlag){
		document.all.lineFlagi.value = lineFlag;

		var orderArrayID = obj.value;
		if(obj.checked == false){
			obj.checked = false;
			var packet = new AJAXPacket("sBindQuery.jsp");
				  packet.data.add("orderArrayID" ,orderArrayID);
				  packet.data.add("retType" ,"sBindQuery1");
				  core.ajax.sendPacket(packet);
				  packet =null;
		}else{
			var packet = new AJAXPacket("sBindQuery.jsp");
				  packet.data.add("orderArrayID" ,orderArrayID);
				  packet.data.add("retType" ,"sBindQuery");
				  core.ajax.sendPacket(packet);
				  packet =null;
		}
	}

function doProcess(packet){
	var retType=packet.data.findValueByName("retType");
	var retCode=packet.data.findValueByName("retCode");
	var retMsg=packet.data.findValueByName("retMsg");
	var orderArrayIDs=packet.data.findValueByName("orderArrayIDs");
	var selObj = document.getElementsByName("custOrderIds");	
	/*tianyang add for pos缴费 start*/
	var verifyType = packet.data.findValueByName("verifyType");
	var sysDate = packet.data.findValueByName("sysDate");
	/*tianyang add for pos缴费 end*/
	if(retType == "sBindQuery"){
		if(retCode == "0"){
			for(var i=0;i<orderArrayIDs.length;i++){
				for(var j=0;j<selObj.length;j++){
					if(orderArrayIDs[i] == selObj[j].value){//如果关联的id和多选框中的id值一样
							selObj[j].checked = true;
					}
				}
			}
		}
	}

	if(retType == "sBindQuery1"){
		if(retCode == "0"){
			for(var i=0;i<orderArrayIDs.length;i++){
				for(var j=0;j<selObj.length;j++){
					if(orderArrayIDs[i] == selObj[j].value){//如果关联的id和多选框中的id值一样
						selObj[j].checked = false;
					}
				}
			}
		}
	}

	if(retType == "StartBackTest"){
			if(parseInt(retCode) != '0'){
				rdShowMessageDialog("["+retCode+":] "+retMsg);
			}else{
				/*** tianyang add for pos start *** boss交易成功 调用银行确认函数 *****/
				if(document.all.payType.value=="BX"){
					BankCtrl.TranOK();
				}
				if(document.all.payType.value=="BY"){
					var IfSuccess = KeeperClient.UpdateICBCControlNum();
				}
				/*** tianyang add for pos end *** boss交易成功 调用银行确认函数 *****/
				rdShowMessageDialog("订单冲正成功！",2);
				location = location; //冲正成功后刷新页面取得新流水
			}
	}
	if(retType == "queryPrt"){
 		document.all.retResult.value=packet.data.findValueByName("retResultStr");
 		document.all.retNowOfferId.value=packet.data.findValueByName("retNowOfferId");
 		document.all.retRevsOfferId.value=packet.data.findValueByName("retRevsOfferId");
 		document.all.retPPV1.value=packet.data.findValueByName("retPPV1");
 		$("#broadReturnStr").val(packet.data.findValueByName("broadReturnStr"));
	}	
	/*tianyang add for pos缴费 start*/
	if(verifyType=="getSysDate"){
		document.all.Request_time.value = sysDate;
		return false;
	}
	/*tianyang add for pos缴费 end*/
}

function currentSel(selObj){

	var n = 0;
	for(var j=0;j<selObj.length;j++){
		if(selObj[j].checked == true){
			n++;
		}
	}
	return n;
}
function showPrtDlg(printType,DlgMessage,submitCfm,printInfoStr)
  {  //显示打印对话框
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
		var billType="1";                                          //  票价类型：1电子免填单、2发票、3收据
		var sysAccept="<%=printAccept%>";                            // 流水号
		//var printStr=printInfo(printType,printInfoStr);          //调用printinfo()返回的打印内容
		var printStr = "";
	
			printStr=printInfo(printType,printInfoStr);

		var mode_code=null;                                        //资费代码
		var fav_code=null;                                         //特服代码
		var area_code=null;                                        //小区代码
		var opCode2Hv     = document.getElementById("opCode2Hv"+document.all.lineFlagi.value).value;
		var opCode=opCode2Hv;
		var hiddenStrv    = document.getElementById("hiddenStrv"+document.all.lineFlagi.value).value;
		var hiddenStrvArr = hiddenStrv.split("|");
		var phoneNo=hiddenStrvArr[4];                 //客户电话
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

		var ret=window.showModalDialog(path,printStr,prop);

		return ret;
  }


  function printInfo(printType,printInfoStr)
  {  	

		var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//得到执行时间

		var cust_info=""; //客户信息
		var opr_info=""; //操作信息
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
		var retInfo = "";  //打印内容

		var hiddenStrv    = document.getElementById("hiddenStrv"+document.all.lineFlagi.value).value;
		var hiddenStrvArr = hiddenStrv.split("|");

		var opCode1Hv     = document.getElementById("opCode1Hv"+document.all.lineFlagi.value).value;
		var opName1Hv     = document.getElementById("opName1Hv"+document.all.lineFlagi.value).value;
		var opCode2Hv     = document.getElementById("opCode2Hv"+document.all.lineFlagi.value).value;
		var opName2Hv     = document.getElementById("opName2Hv"+document.all.lineFlagi.value).value;
		
		var loginAcceptHv = document.getElementById("loginAcceptHv"+document.all.lineFlagi.value).value;
		var custAddJv = document.getElementById("custAdd"+document.all.lineFlagi.value).value;

		<%
		String currTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date());
		%>

		//ajaxQueryPrt(hiddenStrvArr[4],hiddenStrvArr[2],opCode1Hv,opCode2Hv,loginAcceptHv);
	
		cust_info+="手机号码：	"+hiddenStrvArr[4]+"|";
		cust_info+="客户姓名：	"+hiddenStrvArr[6]+"|";
		
		opr_info+="  办理业务："+opName2Hv+ "|";
		opr_info+="用户品牌："+document.all.retPPV1.value+ "|";
		
		opr_info+="操作流水：<%=printAccept%>"
			+"     业务操作时间：<%=currTime.substring(0,10)%>"+ "|";
		opr_info+="家长号码："+document.all.pPhone.value+"      家长姓名："+document.all.pName.value+ "|";
		

		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
  }

function printInfoe093(printType,printInfoStr){
	var retInfo = "";
	
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";  
	var opCode1Hv     = document.getElementById("opCode1Hv"+document.all.lineFlagi.value).value;
	var opName1Hv     = document.getElementById("opName1Hv"+document.all.lineFlagi.value).value;
	var opCode2Hv     = document.getElementById("opCode2Hv"+document.all.lineFlagi.value).value;
	var opName2Hv     = document.getElementById("opName2Hv"+document.all.lineFlagi.value).value;
	var loginAcceptHv = document.getElementById("loginAcceptHv"+document.all.lineFlagi.value).value;
	var hiddenStrv    = document.getElementById("hiddenStrv"+document.all.lineFlagi.value).value;
	var hiddenStrvArr = hiddenStrv.split("|");

	//ajaxQueryPrt(hiddenStrvArr[4],hiddenStrvArr[2],opCode1Hv,opCode2Hv,loginAcceptHv);
	cust_info += "宽带帐号：" + "<%=broadPhone%>" + "|";
	cust_info += "客户姓名：" + hiddenStrvArr[6] + "|";
	if("<%=opCode%>" == "e093"){
		opr_info += "业务办理名称：主资费冲正" ;
	}else if("<%=opCode%>" == "e094"){
		opr_info += "业务办理名称：主资费预约取消" ;
	}
	opr_info += "     操作流水:" + "<%=printAccept%>" + "|";
	opr_info += $("#broadReturnStr").val();
	if("<%=opCode%>" == "e093"){
		opr_info += "   原资费恢复时间：24小时内生效" + "|";
	}
	
  if("<%=opCode%>" == "e094"){
		note_info1 += "备注：用户办理主资费预约取消后，预约的主资费将不会生效，当前主资费继续执行。" + "|" ;
	}
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}
  function ajaxQueryPrt(phoneNo,serOId,opCode1,opCode2,loginAccept){
  		var packet1 = new AJAXPacket("ajaxQueryPrt.jsp","请稍后...");
  			packet1.data.add("retType" ,"queryPrt");
				packet1.data.add("phoneNo",phoneNo);
				packet1.data.add("serOId",serOId);
				packet1.data.add("opCode1",opCode1);
				packet1.data.add("opCode2",opCode2);
				document.all.opcodeCfm.value  = opCode2;
				packet1.data.add("loginAccept",loginAccept);
				core.ajax.sendPacket(packet1);
				packet1 =null;
  	}

  //提交处理
  function printCommit(subButton){
  	
  	getAfterPrompt();
	controlButt(subButton);//延时控制按钮的可用性
	//校验
	setOpNote();//为备注赋值
    //提交表单
    frmCfm();
	return true;
  }

var retSultSum = "0";
var retSultCode = "";
var retSultMsg  = "";

	function getAfterPrompt1()
	{
		var opCode2Hv     = document.getElementById("opCode2Hv"+document.all.lineFlagi.value).value;
		var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","请稍后...");
		packet.data.add("opCode" ,opCode2Hv);
	  core.ajax.sendPacket(packet,doGetAfterPrompt,false);//同步
		packet =null;
	}

	function doGetAfterPrompt(packet)
	{
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    if(retCode=="000000"){
    	promtFrame(retMsg);
    }
	}

function qryContent(){
	  if(document.all.lineFlagi.value==""){
	  	rdShowMessageDialog("请选择要冲正的订单");
	  	   return false;
	  	  
	  }
	  var loginAcceptHv = document.getElementById("loginAcceptHv"+document.all.lineFlagi.value).value;

	document.all.e890loginAccept.value=loginAcceptHv;
	
	   var opcode1=document.getElementById("opCode2Hv"+document.all.lineFlagi.value).value;
	   var phoneNo=$("#searchResult tr:eq(1)").find("td:eq(5)").html();
     
	  if(opcode1=="127a"||opcode1=="1257"){
 
		var packet = new AJAXPacket("qryContent.jsp");
		packet.data.add("opCode" ,opcode1);
		packet.data.add("phoneNo" ,phoneNo);
		core.ajax.sendPacket(packet,doSubmit);
		packet=null;
	}else{

				  doSubmit();
		}

}

function doSubmit(packet){
	var pPacket = new AJAXPacket("../public/pubGetUserBaseInfo.jsp"
		,"请稍后...");
	/*给ajax页面传递参数*/
	pPacket.data.add("phoneNo",document.all.pPhone.value );
	pPacket.data.add("opCode","<%=opCode%>" );
	
	/*调用页面,并指定回调方法*/
	core.ajax.sendPacket(pPacket,getPInfo,false);	
	
	var printInfoStr="";
	var opcode2=document.getElementById("opCode2Hv"+document.all.lineFlagi.value).value;
	if(opcode2=="127a"||opcode2=="1257"){
			printInfoStr=packet.data.findValueByName("printInfo");
	}

	getAfterPrompt1();

	var selObj = document.getElementsByName("custOrderIds");
	var checkNo = currentSel(selObj);
	if(checkNo == 0){
		rdShowMessageDialog("请选择订单子项信息!",0);
		return;
	}
	var map=new _KMap();
	var tab=g("dataTable");
	for(var i=0;(i+1)<tab.rows.length;i++){
		var key=tab.rows[i+1].cells[1].innerText;
		var value=tab.rows[i+1].cells[3].innerText;
		if(selObj[i].checked == true){
			map.add(key,value);
		}
	}
	var result="";
	for(var e in map.map){
		var result2="";//服务订单，e是客户订单
		for(var i=0;i<map.map[e].length;i++){
			result2+=map.map[e][i]+"~";
		}
		result2=result2.substring(0,result2.length-1);//去掉~
		result+=e+"@"+result2+"|";
	}

ajaxCheckf();
 if(retSultSum=="0"){
	rdShowMessageDialog(retSultCode+":"+retSultMsg);
	return false;
 }
 if(retSultCode!="0"){
	rdShowMessageDialog(retSultCode+":"+retSultMsg);
	return false;
	}
	   
			/*查家长用户信息*/
			var pPacket = new AJAXPacket("../public/pubGetUserBaseInfo.jsp"
				,"请稍后...");
			/*给ajax页面传递参数*/
			pPacket.data.add("phoneNo",document.all.pPhone.value );
			pPacket.data.add("opCode","<%=opCode%>" );
			
			/*调用页面,并指定回调方法*/
			core.ajax.sendPacket(pPacket,getPInfo,false);
			pPacket=null;			   
	   
	   
	   var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes",printInfoStr);

    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
	      frmCfm(result);
	  }
	  if(ret=="continueSub")
	  {
	      frmCfm(result);
	  }
    }
    else
    {
	     frmCfm(result);
    }
}

function getPInfo(packet)
{
	var pName=packet.data.findValueByName("stPMcust_name");
	document.all.pName.value=pName;
}
function ajaxCheckf(){

	  var hiddenStrv    = document.getElementById("hiddenStrv"+document.all.lineFlagi.value).value;
		var hiddenStrvArr = hiddenStrv.split("|");
		var phoneNo=hiddenStrvArr[4];
		var loginAcceptHv = document.getElementById("loginAcceptHv"+document.all.lineFlagi.value).value;



		var packet = new AJAXPacket("ajaxCheckP.jsp");
		packet.data.add("opCode" ,document.getElementById("opCode2Hv"+document.all.lineFlagi.value).value);
		packet.data.add("phoneNo" ,phoneNo);
		packet.data.add("servId" ,document.getElementById("servId_"+document.all.lineFlagi.value).value);
		packet.data.add("loginAcceptHv" ,loginAcceptHv);
		core.ajax.sendPacket(packet,doAjaxCheckf);
	}

function doAjaxCheckf(packet){
		retSultSum=packet.data.findValueByName("retSultSum");
		retSultCode=packet.data.findValueByName("retCode");
		retSultMsg =packet.data.findValueByName("retMsg");
	}

function frmCfm(result){	
		if (rdShowConfirmDialog("确认要提交本次操作吗？") == 1){
					/*** tianyang add for pos start***/
					document.all.payType.value = document.getElementById("payTypeHv"+document.all.lineFlagi.value).value.trim();/*缴费类型*/
					
					if(document.all.payType.value=="BX")
					{
							var transerial    = "000000000000";  	                     //交易唯一号
							var trantype      = "01";                                  //交易类型
							var bMoney        = document.getElementById("returnMoneyHv"+document.all.lineFlagi.value).value;/*金额*/
							if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
							var tranoper      = "<%=workNo%>";                         //交易操作员
							var orgid         = "<%=groupId%>";                        //营业员归属机构
							var trannum       = "<%=activePhone%>";                    //电话号码
							getSysDate();       							/*取boss系统时间*/
							var respstamp     = document.all.Request_time.value;       //提交时间
							var transerialold = document.getElementById("RrnHv"+document.all.lineFlagi.value).value;/*参考号*/
							var org_code      = "<%=orgCode%>";                        //营业员归属
							CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
							if(ccbTran=="succ") posSubmitForm(result);
					}
					else if(document.all.payType.value=="BY")
					{
							var transType     = "04";
							var bMoney        = document.getElementById("returnMoneyHv"+document.all.lineFlagi.value).value;/*金额*/
							if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
							var response_time = document.getElementById("Response_timeHv"+document.all.lineFlagi.value).value;/*银行侧开户时间*/
							response_time     = response_time.substr(0,8);
							var rrn           = document.getElementById("RrnHv"+document.all.lineFlagi.value).value;;/*参考号*/
							var instNum       = "";
							var terminalId    = document.getElementById("TerminalIdHv"+document.all.lineFlagi.value).value;;/*终端号*/
							getSysDate();       	 /*取boss系统时间*/
							var request_time  = document.all.Request_time.value;
							var workno        = "<%=workNo%>";
							var orgCode       = "<%=orgCode%>";
							var groupId       = "<%=groupId%>";
							var phoneNo       = "<%=activePhone%>";
							var toBeUpdate    = "";
							ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);
							if(icbcTran=="succ") posSubmitForm(result);
					}
					/*** tianyang add for pos end***/
					else
					{
							posSubmitForm(result);
					}
		}
	}
function showValue(){
	document.frm1102.servno.value = ""; 	//add by wangxing@20090817,清空条件值
	var showFlag = g("idType").value;
	if(showFlag == '0' || showFlag == '4'){
		$("#theValue").show();
	}else{
		$("#theValue").hide();
	}
}

function showBaseInfo(hiddenStrv,opCode1Hv,opCode2Hv,loginAcceptHv){

	var tempArray = hiddenStrv.split("|");
	var phoneNo = tempArray[4];
	var paramValue = "phoneNo="+phoneNo+"&serVId="+tempArray[2]+"&opCode1Hv="+opCode1Hv+"&opCode2Hv="+opCode2Hv+"&loginAcceptHv="+loginAcceptHv + "&opCode=<%=opCode%>";
	var pageName = "showBaseInfoj.jsp?"+paramValue;
	//var resultList = window.open(pageName, "", "dialogWidth=940px;dialogHeight=940px;center=yes;status=yes");
	window.open(pageName,"newwindow","height=450, width=830,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
}

function showPrtDlgbill(printType,DlgMessage,submitCfm)
{
	ajaxGetBilPrt();
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	
	var path = "/npage/innet/pubBillPrintCfm.jsp?dlgMsg=" + DlgMessage;
	var loginAccept = "<%=printAccept%>";
	var path = path + "&printInfo="+printinfo+"&submitCfm=submitCfm";
	var path = path + "&infoStr="+printinfo+"&loginAccept="+loginAccept+"&opCode=1121&submitCfm=submitCfm";
	var ret=window.showModalDialog(path, "", prop);
}

function ajaxGetBilPrt(){

	var phoneNoHv = document.getElementById("phoneNoHv"+document.all.lineFlagi.value).value;
	var opCode1Hv = document.getElementById("opCode1Hv"+document.all.lineFlagi.value).value;
	var opCode2Hv = document.getElementById("opCode2Hv"+document.all.lineFlagi.value).value;
	var loginAcceptHv = document.getElementById("loginAcceptHv"+document.all.lineFlagi.value).value;
	var serVIdHv = document.getElementById("hiddenStrv"+document.all.lineFlagi.value).value.split("|")[2];
	/**冲正金额 tianyang add for pos**/
	var returnMoneyHv = document.getElementById("returnMoneyHv"+document.all.lineFlagi.value).value;
		  var packet = new AJAXPacket("ajaxGetBillPrt.jsp");
		  		packet.data.add("phoneNo" ,phoneNoHv);
		  		packet.data.add("serVId" ,serVIdHv);
		  		packet.data.add("opCode1Hv" ,opCode1Hv);
		  		packet.data.add("opCode2Hv" ,opCode2Hv);
		  		/* liujian 安全加固修改 2012-4-6 8:59:56 begin */
		  		packet.data.add("opCode" ,'<%=opCode%>');
		  		/* liujian 安全加固修改 2012-4-6 8:59:56 end */
		  		packet.data.add("loginAcceptHv" ,loginAcceptHv);
		  		packet.data.add("openrandom" ,"<%=printAccept%>");
		  		/**冲正金额 tianyang add for pos**/
		  		packet.data.add("payType" ,document.all.payType.value);		  		
			  	packet.data.add("returnMoneyHv" ,returnMoneyHv);
				  core.ajax.sendPacket(packet,doAjaxGetBilPrt);
				  packet =null;
}

function doAjaxGetBilPrt(packet){
		printinfo = packet.data.findValueByName("retInfo");
		/********tianyang add at 20090928 for POS缴费需求****start*****/
    if(document.all.payType.value=="BX" || document.all.payType.value=="BY"){
			printinfo = printinfo + document.all.MerchantNameChs.value + "|";	     	
			printinfo = printinfo + document.all.CardNoPingBi.value + "|";
			printinfo = printinfo + document.all.MerchantId.value + "|";
			printinfo = printinfo + document.all.BatchNo.value + "|";
			printinfo = printinfo + document.all.IssCode.value + "|";
			printinfo = printinfo + document.all.TerminalId.value + "|";
			printinfo = printinfo + document.all.AuthNo.value + "|";
			printinfo = printinfo + document.all.Response_time.value + "|";
			printinfo = printinfo + document.all.Rrn.value + "|";
			printinfo = printinfo + document.all.TraceNo.value + "|";
			printinfo = printinfo + document.all.AcqCode.value + "|";
			printinfo = printinfo + "|";
    }
    /********tianyang add at 20090928 for POS缴费需求****end*******/
}
function pageSubmit( )
{
	frm1102.action="f127a_2.jsp";
	frm1102.submit();
}
function pageSubmit_1()
{
	if (document.frm1102.opCode.value=="3264" && document.frm1102.backaccept.value.length==0)
	{
		rdShowMessageDialog("请输入业务流水！");
	  	return false;
	}
	if (rdShowConfirmDialog("确认要提交本次操作吗？") == 1){

		frm1102.action="f1257.jsp";
		frm1102.submit();
	}
}

/*tianyang add POS缴费 start*/
function getSysDate()
{
	var myPacket = new AJAXPacket("../s1300/s1300_getSysDate.jsp","正在获得系统时间，请稍候......");
	myPacket.data.add("verifyType","getSysDate");
	core.ajax.sendPacket(myPacket);
	myPacket = null;

}
function padLeft(str, pad, count)
{
		while(str.length<count)
		str=pad+str;
		return str;
}
function getCardNoPingBi(cardno)
{
		var cardnopingbi = cardno.substr(0,6);
		for(i=0;i<cardno.length-10;i++)
		{
			cardnopingbi=cardnopingbi+"*";
		}
		cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
		return cardnopingbi;
}
/* POS缴费中 页面提交  start*/
function posSubmitForm(result){
		if("<%=opCode%>"=="1121"){
			showPrtDlgbill("Bill","确实要进行发票打印吗？","Yes");
		}

		var packet = new AJAXPacket("fE890Cfm.jsp");		
		packet.data.add("result" ,result);
	  packet.data.add("retType" ,"StartBackTest");
	  packet.data.add("srvno",document.frm1102.servno.value.trim());
	  packet.data.add("opCode","<%=opCode%>");
	  packet.data.add("opNameCfm",document.getElementById("opName2Hv"+document.all.lineFlagi.value).value);
	  packet.data.add("opCodeCfm",document.all.opcodeCfm.value);
	  packet.data.add("loginAccept",document.all.loginAccept.value);
	  packet.data.add("e890loginAccept",document.all.e890loginAccept.value);
	  
	  /** pos机新增参数 start **/
		packet.data.add("payType" ,document.all.payType.value);/** 缴费类型 payType=BX 是建行 payType=BY 是工行 **/
		packet.data.add("MerchantNameChs" ,document.all.MerchantNameChs.value);
		packet.data.add("MerchantId" ,document.all.MerchantId.value);
		packet.data.add("TerminalId" ,document.all.TerminalId.value);
		packet.data.add("IssCode" ,document.all.IssCode.value);
		packet.data.add("AcqCode" ,document.all.AcqCode.value);
		packet.data.add("CardNo" ,document.all.CardNo.value);
		packet.data.add("BatchNo" ,document.all.BatchNo.value);
		packet.data.add("Response_time" ,document.all.Response_time.value);
		packet.data.add("Rrn" ,document.all.Rrn.value);
		packet.data.add("AuthNo" ,document.all.AuthNo.value);
		packet.data.add("TraceNo" ,document.all.TraceNo.value);
		packet.data.add("Request_time" ,document.all.Request_time.value);
		packet.data.add("CardNoPingBi" ,document.all.CardNoPingBi.value);
		packet.data.add("ExpDate" ,document.all.ExpDate.value);
		packet.data.add("Remak" ,document.all.Remak.value);
		packet.data.add("TC" ,document.all.TC.value);
		/** pos机新增参数 end */
	  core.ajax.sendPacket(packet);
	  packet =null;
}
/*tianyang add POS缴费 end*/

</SCRIPT>
<body>
<FORM method=post name="frm1102">
	<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">查询条件</div>
</div>

<input type="hidden" id="lineFlagi" name="lineFlagi">
<input type="hidden" id="retResult" name="retResult">
<input type="hidden" id="retRevsOfferId" name="retRevsOfferId">
<input type="hidden" id="retNowOfferId" name="retNowOfferId">
<input type="hidden" id="retPPV1" name="retPPV1">
<input type="hidden" id="billPath" name="billPath">
<input type="hidden" id="opcodeCfm" name="opcodeCfm">
<input type="hidden" id="loginAccept" name="loginAccept"  value="<%=printAccept%>">
<input type="hidden" id="e890loginAccept" name="e890loginAccept"  value="">
<!--家长号码-->
<input type="hidden" id="pPhone" name="pPhone"  value="<%=rstProd[0][0]%>">
<input type="hidden" id="pName" name="pName"  value="">


<!-- tianyang add at 20100201 for POS缴费需求*****start*****-->			
<input type="hidden" name="payType"  value=""><!-- 缴费类型 payType=BX 是建行 payType=BY 是工行 -->			
<input type="hidden" name="MerchantNameChs"  value=""><!-- 从此开始以下为银行参数 -->
<input type="hidden" name="MerchantId"  value="">
<input type="hidden" name="TerminalId"  value="">
<input type="hidden" name="IssCode"  value="">
<input type="hidden" name="AcqCode"  value="">
<input type="hidden" name="CardNo"  value="">
<input type="hidden" name="BatchNo"  value="">
<input type="hidden" name="Response_time"  value="">
<input type="hidden" name="Rrn"  value="">
<input type="hidden" name="AuthNo"  value="">
<input type="hidden" name="TraceNo"  value="">
<input type="hidden" name="Request_time"  value="">
<input type="hidden" name="CardNoPingBi"  value="">
<input type="hidden" name="ExpDate"  value="">
<input type="hidden" name="Remak"  value="">
<input type="hidden" name="TC"  value="">
<!-- tianyang add at 20100201 for POS缴费需求*****end*******-->



          <table cellspacing=0>
                <TR>
                	<td class='blue' nowrap>查询条件</Td>
                  <TD>
                  	<select name="idType" id="idType" onchange="showValue()">
                  		<option value="0">服务号码</option>
                  	</select>
                  </TD>
	                	 <td class='blue' nowrap>条件值</Td>
	                  <TD>
	                    <input type="text" name="servno" class="InputGrey" onchange="" value="<%=activePhone%>" readOnly/>
	                    &nbsp;<font class='orange'>*</font>
	                  </TD>
                </TR>
                <tr id="theValue">
                	<td class='blue' nowrap>业务受理月份</Td>
                  <TD  >
                    <select name="searchDate" id="searchDate" onchange="">
                  		<option value="<%=currentTime%>"><%=currentTime%></option>
                  		<option value="<%=currentTime1%>"><%=currentTime1%></option>
                  	</select>
                  </TD>
                  <td class='blue' nowrap>冲正模块</Td>
                  <TD  >
                    <input type="text" name="modeFlag" id="modeFlag"  value="<%=opCode%>" readOnly class="InputGrey">
                  </TD>
                </tr>
           </table>
		<% if (opCode.equals("3264")  || opCode.equals("1257") || opCode.equals("127a")  ){%>
        <div class="title" style="display:none">
		<div id="title_zi">冲正2010-01-01 至 2010-01-08 间办理的业务</div>
		</div>
			   <table cellspacing=0 style="display:none">
			 <% if (opCode.equals("3264")){%>
              		<tr id="theValue" >
                  <TD  class='blue' nowrap>业务流水 </TD>
                  <td colspan=3><input class="" name="backaccept" value="" >
                  	<input class="b_foot" onclick="pageSubmit_1()" type=button value="冲正确认"/>
				  </td>
                  </tr>
                  <%}%>
                <% if (opCode.equals("127a")){%>
                   <tr id="theValue" >
                  <TD  colspan="4">
                    <input class="b_foot" onclick="pageSubmit()"  type=button value="查询"/>
                  </TD>
                  </tr>
                  <%}%>

                 <% if (opCode.equals("1257")){%>
                   <tr id="theValue" >
                  <TD  colspan="4" >
                    <input class="b_foot" onclick="pageSubmit_1()"  type=button value="冲正确认"/>
                  </TD>
                  </tr>
                  <%}%>
              </table>
				<input type="hidden" name="opCode" value="<%=opCode%>">
				<input type="hidden" name="opName" value="<%=opName%>">
		<%}%>
      	<div id="searchResult"></div>
   <div id="Operation_Table">
         <div id="footer">
              <input class="b_foot" onclick="doSearch()"  type=button value="查询"/>
              <input class="b_foot" id="confirm" onclick="qryContent()"  type=button value="确认&打印"/>
              <input class="b_foot" name="quit"  onclick="removeCurrentTab()"  type=button value="退出"/>
		  	</div>
<input type="hidden" name="broadReturnStr" id="broadReturnStr" value="">
  <!------------------------>

<%@ include file="/npage/include/footer.jsp" %>
</form>
</div>

<!-- **** tianyang add for pos ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/sq046/posCCB.jsp" %>
<!-- **** tianyang add for pos ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/sq046/posICBC.jsp" %>

</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>