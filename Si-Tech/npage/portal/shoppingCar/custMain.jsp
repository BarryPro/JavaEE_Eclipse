
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		System.out.println("-------hejwacustmain------------1------------->");
    String loginAccept = getMaxAccept();
    String workNo = (String) session.getAttribute("workNo");
    String workName = (String) session.getAttribute("workName");
    String orgCode = (String) session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0, 2);
		String g_CustId = request.getParameter("gCustId");
		String loginNoPass = (String)session.getAttribute("password");
		String homeSData = request.getParameter("homeSData");//家庭传入资费串
		if(homeSData==null||homeSData.toLowerCase().equals("null")) homeSData = "";
    String gCustId = request.getParameter("gCustId");

    
    System.out.println("-------------hejwacustmain--------gCustId---------2-------------"+gCustId);
    String loginType = request.getParameter("loginType");
    String phone_no = request.getParameter("phone_no");
     
     System.out.println("----------hejwacustmain---00--------phone_no---------3-------------"+phone_no);   
    String custOrderId = request.getParameter("custOrderId");
		/* ningtn 铁通宽带账号 */
    String broadPhone = request.getParameter("broadPhone");
    String openFlag = "";
    /* diling 是否为客服工号*/
    String accountType = (String)session.getAttribute("accountType"); 
 
 	/*yanpx添加 是否有1104权限*/
	 	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	 	String[][] temfavStr=(String[][])arrSession.get(1);
	    String[] favStr=new String[temfavStr.length];
	    for(int i=0;i<favStr.length;i++)
	    {
	     favStr[i]=temfavStr[i][1].trim();
	    }
	    boolean pwrf=false;
	    if(WtcUtil.haveStr(favStr,"1104"))
	    {
			  pwrf=true;
			  System.out.println("WtcUtil.haveStr(favStr,1104) = "+WtcUtil.haveStr(favStr,"1104"));
			}
 	/*yanpx end*/   
 	/* ningtn 是否有4977权限 */
	 	boolean pwrf4977=false;
	 	System.out.println(" === fav == temfavStr === " + temfavStr.length);
	  if(WtcUtil.haveStr(favStr,"4977"))
	  {
		  pwrf4977=true;
		  System.out.println("WtcUtil.haveStr(favStr,4977) = "+WtcUtil.haveStr(favStr,"4977"));
		  System.out.println("====fav====== pwrf4977 ========= " + pwrf4977);
		}
		System.out.println("=====fav===== pwrf4977 === 22 ====== " + pwrf4977);
 	/* ningtn 是否有4977权限 end */
 	
 	/* liangyl 是否有m462权限 */
	 	boolean pwrfm462=false; 
	 	System.out.println(" === fav == temfavStr === " + temfavStr.length);
	  if(WtcUtil.haveStr(favStr,"m462"))
	  {
		  pwrfm462=true;
		  System.out.println("WtcUtil.haveStr(favStr,m462) = "+WtcUtil.haveStr(favStr,"m462"));
		  System.out.println("====fav====== pwrfm462 ========= " + pwrfm462);
		}
		System.out.println("=====fav===== pwrfm462 === 22 ====== " + pwrfm462);
 	/* liangyl 是否有m462权限 end */
 		
 		/* begin add 并老户优惠权限 for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/11 */
 		String[][] v_temfavStr = (String[][])session.getAttribute("favInfo");
    String[] v_favStr = new String[v_temfavStr.length];
    boolean oldFav_a971 = false;
    for(int i = 0; i < v_favStr.length; i ++) {
    	v_favStr[i] = v_temfavStr[i][0].trim();
    }
    if (WtcUtil.haveStr(v_favStr, "a971")) {
    	oldFav_a971 = true;
    }
 		/* end add 并老户优惠权限 for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/11 */
    /*  4603 4100 用到 省内跨区开户 需要的参数    */
    String work_flow_no = ""; //4603  工单号 4100 原手机号
		String transJf      = ""; //4603 转移积分 4100 积分
    String transXyd     = ""; //4603 转移信誉度 4100 积分类别
    String level4100     = ""; //4100 客户等级
		/*  4603 需要的参数    */
		
		
    if(loginType.indexOf("open4603")!=-1){      //4603省内跨区开户传入的参数
			openFlag = loginType.split("§")[0];
			work_flow_no = loginType.split("§")[1];
			transJf = loginType.split("§")[2];
			transXyd = loginType.split("§")[3];
			loginType = "";  
		}else if(loginType.indexOf("open4100")!=-1){ //4100 跨区开户要传入的参数
			openFlag = loginType.split("§")[0];
			work_flow_no = loginType.split("§")[1];
			transJf = loginType.split("§")[2];
			transXyd = loginType.split("§")[3];
			level4100 = loginType.split("§")[4];
			loginType = "";  
		}
		
		
		/*
		System.out.println("-------mylog-------------openFlag--------------"+openFlag);
		System.out.println("-------mylog-------------work_flow_no----------"+work_flow_no);
		System.out.println("-------mylog-------------transJf---------------"+transJf);
		System.out.println("-------mylog-------------transXyd--------------"+transXyd);
		System.out.println("-------mylog-------------level4100-------------"+level4100);
		*/
		
    String retCode = "";
    String retMsg = "";
		String paramValue_zhaz="N";
    Map sessionMap = new HashMap();
    session.setAttribute(gCustId, sessionMap);
/*2013/07/04 8:43:08 gaopeng 发现这里写死了*/    
    	String opCode = "1104";
    
		  if(openFlag.equals("open4100")){ 	
		  	opCode = "4100";  
		  }else if(openFlag.equals("open4603")){
		  	opCode = "4603";
		  }
    	
    System.out.println("-------mylog-------------opCode----------"+opCode);
    Map map = (Map)session.getAttribute("contactInfo");
    ContactInfo contactInfo = (ContactInfo) map.get(gCustId);
	  
	 //增加号码密码验证30分中有效的限制，add by liubo
	 String dateStr=new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
    
    
    String Contact_id="";
    if(appCnttFlag!=null&&"Y".equals(appCnttFlag))
    {
	    Contact_id=contactInfo.getContact_id();  
	    System.out.println("Contact_id====="+Contact_id);
	  }
    
    Map InfoMap = (Map)session.getAttribute("contactInfoMap");
    Map relInfoMap = (Map)session.getAttribute("contactInfoRelation");   
    Map timeMap = (Map)session.getAttribute("contactTimeMap");  
%>
<!--取客户基本信息-->
<%
	String bd0002_orgCode = (String)session.getAttribute("orgCode");
	String bd0002_regionCode = bd0002_orgCode.substring(0,2);
%>
<wtc:utype name="sQBasicInfo" id="retBd0002" scope="end"  routerKey="region" routerValue="<%=bd0002_regionCode%>">
     <wtc:uparam value="<%=gCustId%>" type="LONG"/>
</wtc:utype>
<%
String bd0002_retCode =retBd0002.getValue(0);
String bd0002_retMsg  =retBd0002.getValue(1);

String custName="";//客户名称
String belongCity="";//归属市县
String custLevel="";//客户级别
String linkmanName="";//联系人姓名
String bd0002_status="";//稽核状态
String nationName = ""; //民族
String agent_idType="";//证件类型
String agent_idNo="";//证件号码
String agent_phone="";//联系电话
String ba0002_black="";//黑名单
String custLevelStar = "";//星级
String custLevelStartTime = "";
String custLevelEndTime = "";

String ifUnitImpMember = "";
String ifABUnit = "";

String isJTCY="否";

%>
 <wtc:service name="sIsGrpQry" routerKey="region" routerValue="<%=bd0002_orgCode%>" retcode="jtinfo_retcode" retmsg="jtinfo_retMsg" outnum="6"> 
  <wtc:param value=""/>
  <wtc:param value="01"/>
  <wtc:param value="1500"/>
  <wtc:param value="<%=workNo%>"/>
  <wtc:param value="<%=loginNoPass%>"/>
  <wtc:param value="<%=phone_no%>"/>
  <wtc:param value=""/>
  </wtc:service>  
  <wtc:array id="jtinfoArry"  scope="end"/>
  	

<%
if("000000".equals(jtinfo_retcode)) {
  if(jtinfoArry.length>0) {
  		isJTCY=jtinfoArry[0][2];
  		
  		if("1".equals(isJTCY)) {
  			isJTCY="是";
  		}else if("0".equals(isJTCY)) {
  			isJTCY="否";
  		}
  }
}
else if("111111".equals(jtinfo_retcode)){
	%>
    <script language="javascript" type="text/javascript">
      rdShowMessageDialog("<%=jtinfo_retMsg%>",0);
      parent.parent.removeTab("custid"+"<%=gCustId%>");
    </script>
<%
}


		
if(bd0002_retCode.equals("0"))
{
	custName   =retBd0002.getValue("2.0");
	belongCity =retBd0002.getValue("2.1") == null ? "" : retBd0002.getValue("2.1");
	custLevel  =retBd0002.getValue("2.2");
	linkmanName=retBd0002.getValue("2.3");
	bd0002_status=retBd0002.getValue("2.4") == null ? "" : retBd0002.getValue("2.4");
	nationName =retBd0002.getValue("2.5");
	agent_idType =retBd0002.getValue("2.6");
	agent_idNo =retBd0002.getValue("2.7");
	agent_phone =retBd0002.getValue("2.8");
	ba0002_black =retBd0002.getValue("2.9");
	
}
if("1".equals(loginType)){
%>
 <wtc:service name="sGetCustLevel2" routerKey="region" routerValue="<%=bd0002_orgCode%>" retcode="bd0002_regionCode_custLevelStar" retmsg="bd0002_retMsg_custLevelStar" outnum="6"> 
  <wtc:param value="<%=loginAccept%>"/>
  <wtc:param value="01"/>
  <wtc:param value="1500"/>
  <wtc:param value="<%=workNo%>"/>
  <wtc:param value="<%=loginNoPass%>"/>
  <wtc:param value="<%=phone_no%>"/>
  <wtc:param value=""/>
  </wtc:service>  
  <wtc:array id="retbd0002_custLevelStar"  scope="end"/>
  	
<%
  
  if(bd0002_regionCode_custLevelStar.equals("000000") && retbd0002_custLevelStar.length > 0)
  {
  	custLevelStar = retbd0002_custLevelStar[0][1];
  	custLevelStartTime = retbd0002_custLevelStar[0][2];
   	custLevelEndTime = retbd0002_custLevelStar[0][3];
   	ifUnitImpMember = retbd0002_custLevelStar[0][5];
   	ifABUnit = retbd0002_custLevelStar[0][4];
    
  }else{
%>
    <script language="javascript" type="text/javascript">
      rdShowMessageDialog("错误代码：<%=bd0002_regionCode_custLevelStar%><br>错误信息：<%=bd0002_retMsg_custLevelStar%>",0);
    </script>
<%
  }
}
%>
<!--获取客户积分 20160307 liangyl-->
<wtc:service name="sCoventQry" routerKey="region" routerValue="<%=regionCode%>" retcode="coventQryRetCode" retmsg="coventQryRetMsg" outnum="9"> 
  <wtc:param value="<%=loginAccept%>"/>
  <wtc:param value="02"/>
  <wtc:param value=""/>
  <wtc:param value="<%=workNo%>"/>
  <wtc:param value="<%=loginNoPass%>"/>
  <wtc:param value="<%=phone_no%>"/>
  <wtc:param value=""/>
  </wtc:service>  
  <wtc:array id="CoventQryResult"  scope="end"/>
  	<%
  		String integral="0";
  	//	System.out.println("liangyouliang:-----"+coventQryRetCode);
  	//	System.out.println("liangyouliang:------"+CoventQryResult.length);
  //		for(int i=0;i<CoventQryResult[0].length;i++){
  	//		System.out.println("liangyouliang:"+CoventQryResult[0][i]);
  	//	}
  	if(coventQryRetCode.equals("000000") && CoventQryResult.length > 0){
	  	integral = CoventQryResult[0][7];
	  }
  	%>
  	
<!--取客户产品信息-->
<wtc:utype name="sCustOffer" id="retConsOffer" scope="end" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:uparam value="<%=gCustId%>" type="LONG"/>
    <%
     if(loginType.equals("1") || "8".equals(loginType)){
    %>  
      <wtc:uparam value="<%=phone_no%>" type="STRING"/>
    <%
    }else{
    %>
     <wtc:uparam value="0" type="STRING"/>
    <%
    }
    %>
</wtc:utype>
<%
		/* ningtn 关于开发多渠道协同营销功能需求的函 */
		
		
		/**
		*   hejwa add 2015-10-26 13:36:31
		*  关于优化多项宽带业务的需求
		* 4、修改“宽带包年取消(e301)”功能，如果宽带账号竣工超过2个自然月，则点击“宽带包年取消”时增加提示信息为：
    * “宽带包年取消时将收取剩余预存的30%违约金”。例如10月20日竣工，那么12月1日0时之后就算超过2个自然月。
    * 说明：现在系统中竣工2个自然月内不收取违约金，2个自然月之后就收取违约金了。
		*
		*/
		String e301_spCar_check     	= "0";
		String e301_spCar_check_sql 	= " select months_between(trunc(sysdate, 'MM'), trunc(a.bill_date, 'MM')) as result "+
																		"	  from dcustmsg a "+
																		"	 where a.phone_no = :phone_no ";
		String e301_spCar_check_param = "phone_no="+phone_no;
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=e301_spCar_check_sql%>" />
		<wtc:param value="<%=e301_spCar_check_param%>" />
	</wtc:service>
	<wtc:array id="result_e301_spCar_check" scope="end"   />

<%
	if(result_e301_spCar_check.length>0){
		System.out.println("-----------hejwa-------result_e301_spCar_check[0][0]------------------->"+result_e301_spCar_check[0][0]);
		e301_spCar_check = result_e301_spCar_check[0][0];
	}
	
	System.out.println("-----------hejwa-------e301_spCar_check------------------->"+e301_spCar_check);
%>





<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
<title>购物车</title>
<!-- <link href="<%=request.getContextPath()%>/nresources/default/css_sx/FormText.css" rel="stylesheet"type="text/css"> -->
<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/products.css" rel="stylesheet"type="text/css">
<link href="/nresources/<%=cssPath%>/css/portal.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="/njs/si/validate_class.js"></script>
<script language="javascript" type="text/javascript" src="/njs/extend/mztree/stTree.js"></script>
<style type="text/css">
        .pop-box {   
            z-index: 9999; /*这个数值要足够大，才能够显示在最上层*/  
            margin-bottom: 3px;   
            display: none;   
            position: absolute;   
            background: #99FFFF;   
            border:solid 1px #6e8bde;   
        }   
          
        .pop-box h4 {   
            color: #99FFFF;   
            cursor:default;   
            height: 18px;   
            font-size: 14px;   
            font-weight:bold;   
            text-align: left;   
            padding-left: 8px;   
            padding-top: 4px;   
            padding-bottom: 2px;   
            background: url("../images/header_bg.gif") repeat-x 0 0;   
        }   
          
        .pop-box-body {   
            clear: both;   
            margin: 4px;   
            padding: 2px;   
        } 
        
        
        .mask {   
            color:#C7EDCC;
            background-color:#DDDDDD;
            position:absolute;
            top:0px;
            left:0px;
            filter: Alpha(Opacity=60);
        } 
    </style>
<script language="javascript" type="text/javascript">
	var homeSData = "<%=homeSData%>";
	
$(document).ready(function(){
	if(homeSData!=""&&parent.orderFlag.value!="1"){//家庭或组合销售品 传入串，直接去生成订单和订单子项
		custOrderCHome(homeSData);
	}
 
	if("1"==$("#isse276",window.parent.parent.document).val()){
		funCheck4977();
	}
 
});

function showsm468Init_val(m468Init_val){
	
	if(""!=m468Init_val){
		rdShowMessageDialog(m468Init_val);
	}
}

function show_sVolteQry_val(msg,flag_m286){
	
	if(""!=msg){
		var path = "show_sVolteQr_msg.jsp?msg="+msg+"&flag_m286="+flag_m286;
		var h=298;
   	var w=550;
   	var t=screen.availHeight/2-h/2;
   	var l=screen.availWidth/2-w/2;

		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;  overflow-y:hidden; overflow-x:hidden;  toolbar:no; menubar:no; scrollbars:no; resizable:no;location:no;status:no;help:no";
		var ret=window.showModalDialog(path,"",prop);

		if(typeof(ret)!="undefined"){
			if("Y"==ret){
				show_sVolteQry_val_ret();
			}
		}

	}
 
}

function show_sVolteQry_val_ret(){
		parent.parent.openPage("2","m286","volte开户","sm286/fm286Main.jsp","1");
}

/*
 * hejwa add 2014年2月12日 黑龙江移动营销业务资源管理系统 v3.0.0_促销品管理项目
 * 只能在二级tab中使用，使用方法：
 *		parent.document.getElementById("user_index").contentWindow.goTo_car_Func("g794","e280","&ACT_CLASS=64");
 * 先调用点击手机号函数，在判断是否已经有定单，有的话删除，添加g794之后调用下一步函数
 * newOpcode = 要跳转到购物车功能的opcode
 * oldOpcode = 要关闭的opcode，也是跳转过来的opcode
 * goCarParamf = 新增到跳转下一页面的参数，不同业务传递过来的根据需要不同，类似于 "&a=1" 或 "&a=1&b=2"
 */

var goCarParam = ""; 
function goTo_car_Func(newOpcode,oldOpcode,goCarParamf){
	goCarParam = goCarParamf
	//alert("goTo_car_Func-->\nnewOpcode=["+newOpcode+"]\noldOpcode=["+oldOpcode+"]");
	//先清空购物车
	clearCar();
	//找到手机号的行，点击他调用点击手机号码函数
	var prodListObj = document.getElementById("prodList_0");
	if(prodListObj!=null&&typeof(prodListObj)!="undefined"){
		prodListObj.click();
	}else{
		rdShowMessageDialog("无客户产品订购信息",0);
		return;
	}
	//判断有没有newOpcode(g794)权限，调用点击newOpcode(g794)函数
	if(isContainMFunc(newOpcode)){
		document.getElementById("a_"+newOpcode).click();
		//若newOpcode(g794)已经被打开，先关闭否则参数传不进去（传参数需要修改goNext方法中拼路径串）
		var newOpcodeTabObj = parent.document.getElementById(newOpcode);
		if(newOpcodeTabObj!=null&&typeof(newOpcodeTabObj)!="undefined"){
			//存在即关闭
			parent.removeTab(newOpcode);
		}
		//下一步可能已经被置灰，恢复回来才可以调用click方法
		document.getElementById("nextBtn").disabled = false;
		//点击下一步
		document.getElementById("nextBtn").click();
		//关掉原页面
		try{
			parent.removeTab(oldOpcode);
		}catch(e){
		}
	}else{
		rdShowMessageDialog("无"+newOpcode+"模块权限",0);
		return;
	}
}

/**
	hejwa add 2014年2月12日11:24:20
	判断客户服务树中是否包含某opcode对应功能
*/
function isContainMFunc(opCode){
	var retVal = false;
	$("#rootTree1 li").each(function(){
		var liId = $(this).attr("id");
		var opCodeLi = liId.substring(3,7);//id的格式固定为 li_1104，所以3-7位取opcode为1104
		if(opCodeLi==opCode){
			retVal = true;
			return false; //结束each循环
		}
	});
	//alert("retVal=["+retVal+"]");
	return retVal;
}


	function getMarketMsg(){
			var h=450;
			var w=600;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop = "height="+h+"; width="+w+";top="+t+";left="+l+";toolbar=no; menubar=no; scrollbars=yes; resizable=no;location=no;status=no";
			var pageName="getMarket.jsp?phoneNo=<%=phone_no%>";
			var ret = window.open(pageName,'',prop);
	}
	function openSale(url){
		parent.parent.L("4","e177","营销执行",url,"0");
	}
//取向该客户推荐的业务信息
function ini(phone_no) 
  {     	
		var packet = new AJAXPacket("getOper.jsp");
    packet.data.add("phone_no", phone_no);
    core.ajax.sendPacketHtml(packet, doGetOper, true);
    packet = null;	
  }	

function doGetOper(data)
{
    var insertOper=document.getElementById("insertOper");
    insertOper.innerHTML=data;
}
	
var initOpCode = "1104"	;
<%if(openFlag.equals("open4100")){%>
	initOpCode = "4100";
<%}else if(openFlag.equals("open4603")){%>
	initOpCode = "4603";
<%}%>
/*2013/07/04 8:50:50 gaopeng 执行下一步*/
function goNext(custOrderId,custOrderNo,prtFlag)
{
	var packet = new AJAXPacket("/npage/portal/shoppingCar/sShowMainPlan.jsp");
	packet.data.add("custOrderId" ,custOrderId);
	packet.data.add("custOrderNo" ,custOrderNo);
	packet.data.add("prtFlag" ,prtFlag);
	core.ajax.sendPacket(packet,doNext);
	packet =null;
}
/*2013/07/04 8:51:13 gaopeng 执行下一步回调函数*/
function doNext(packet)
{
    var retCode = packet.data.findValueByName("retCode"); 
	  var retMsg = packet.data.findValueByName("retMsg"); 
	  if(retCode=="0")
	  {
	  	var sData = packet.data.findValueByName("sData"); 
	  	parent.parent.$("#carNavigate").html(sData);
	  	var custOrderId = packet.data.findValueByName("custOrderId"); 
	  	var custOrderNo = packet.data.findValueByName("custOrderNo"); 
	  	var orderArrayId = packet.data.findValueByName("orderArrayId"); 
	  	var servOrderId = packet.data.findValueByName("servOrderId"); 
	  	var status = packet.data.findValueByName("status"); 
	  	var funciton_code = packet.data.findValueByName("funciton_code"); 
	  	var funciton_add = packet.data.findValueByName("funciton_add"); 
	  	var funciton_name = packet.data.findValueByName("funciton_name"); 
	  	var pageUrl = packet.data.findValueByName("pageUrl"); 
	  	var offerSrvId = packet.data.findValueByName("offerSrvId"); 
	  	var num = packet.data.findValueByName("num"); 
	  	var offerId = packet.data.findValueByName("offerId"); 
	  	var offerName = packet.data.findValueByName("offerName"); 
	  	var phoneNo = packet.data.findValueByName("phoneNo"); 
	  	var sitechPhoneNo = packet.data.findValueByName("sitechPhoneNo"); 
	  	var prtFlag = packet.data.findValueByName("prtFlag"); 
	  	var servBusiId = packet.data.findValueByName("servBusiId"); 
	  	var validVal = packet.data.findValueByName("validVal"); 
	  	var openWay = packet.data.findValueByName("openWay"); 
	  	var is0flag = packet.data.findValueByName("is0flag");
	  	var gundongyueFlag = packet.data.findValueByName("gundongyueFlag");
	  	//alert(is0flag);
	  	/*如果是0元包年资费 那么必须和g794营销执行一起办理否则提示错误*/
	  	if(is0flag == "yes"){
	  		var sData2 = getTableData("shoppingCarList", 2, 3);
	  		if(sData2.indexOf("4977") != -1){
	  			if(sData2.indexOf("g794") < 0){
		  			rdShowMessageDialog("办理宽带开户时，不允许单独办理0元宽带包年主资费,请与g794营销执行一同办理！",0);
		  			return false;
	  			}
	  		}
	  		
	  	}
	  	var gundongyueData = getTableData("shoppingCarList", 2, 3);
	  	if(gundongyueFlag=="1"&&gundongyueData.indexOf("g794")>0){
	  		rdShowMessageDialog("不允许滚动月包年资费(包括0元滚动月包年)与营销案(g794)一起办理!",0);
  			return false;
	  	}
	  	
	  	var closeId=orderArrayId+servOrderId;
	  	//alert(funciton_code+"---functionCode?");
	  	if("<%=paramValue_zhaz%>" == "Y"){
		  	parent.parent.checkHasBill(funciton_code);
		  	if(parent.parent.hasBill == "N"){
			   		rdShowMessageDialog("您昨天未进行轧帐,不能进行业务操作!",0);
			   		//parent.parent.addTab(true,"r615","营业员操作统计报表","../rpt_new/f1615.jsp");
			   		return false;
			   }
			   if(parent.parent.todayHasBill == "Y"){
			   		rdShowMessageDialog("您今天已经轧帐完成,不能进行业务操作!",0);
			   		return false;
			   }
	  	}
	  	if(closeId=="")
	  	{
	  		closeId= funciton_code;
	  	}
	  	/*2013/07/03 17:09:32 gaopeng 这个就是点击下一步的按钮的方法*/
	  	var path=   pageUrl+"?gCustId=<%=g_CustId%>"
	  							+"&opCode="+funciton_code
	  						  +"&opName="+funciton_name
	  							+"&offerSrvId="+offerSrvId
	  							+"&num="+num
	  							+"&offerId="+offerId
	  							+"&offerName="+offerName
	  							+"&phoneNo="+phoneNo
	  							+"&sitechPhoneNo="+sitechPhoneNo
	  							+"&orderArrayId="+orderArrayId
	  							+"&custOrderId="+custOrderId
	  							+"&custOrderNo="+custOrderNo
	  							+"&servOrderId="+servOrderId
	  							+"&closeId="+funciton_code
	  							+"&servBusiId="+servBusiId
	  							+"&prtFlag="+prtFlag
	  							+"&work_flow_no=<%=work_flow_no%>"
	  							+"&transJf=<%=transJf%>"
	  							+"&transXyd=<%=transXyd%>"
	  							+"&level4100=<%=level4100%>"
	  							+"&opcodeadd="+funciton_add
	  							+goCarParam;//动态参数 hejwa add 2014年2月18日16:51:26
  	  	if(funciton_code=="1270"){
  	  	  var path = path + "&custLevelStar=<%=custLevelStar%>";
  	  	}
					if(initOpCode=="4100"||initOpCode=="4603"){
						 openWay = "2";                           //查询类是一级table 购物车要求为二级table
					}
				  parent.parent.L(openWay,funciton_code,funciton_name,path,validVal);
	 			
	  }else
	  {
	  		  rdShowMessageDialog("操作导航失败!");
	  }
}
//右侧 客户服务 1104
function funCheck()
{ 
	
		if ($("#nextBtn")[0].custOrder != "")//如果是断点恢复的，清表
    {
        clearCar();
        $("#nextBtn")[0].custOrder = "";
    }
		initOpCode = "1104";   
		//判断是否可以进行"并老户"业务
		var v_chkOldUserFlag = chkOldUserBusiness(initOpCode);
		if(!v_chkOldUserFlag){
			return false;
		}
    var pageName = "qryProductOfferComplex.jsp?opCode="+initOpCode;
    //var resultList = window.showModalDialog(pageName, window, "dialogWidth=840px;dialogHeight=600px;center=yes;status=yes");
   	window.open(pageName,'销售品选择','width=840px,height=600px,left=100,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
}
function funCheck4977(){
    if ($("#nextBtn")[0].custOrder != "")//如果是断点恢复的，清表
    {
        clearCar();
        $("#nextBtn")[0].custOrder = "";
    }
    initOpCode = "4977";
    var pageName = "qryProductOfferComplex.jsp?opCode="+initOpCode+"&phoneNo=<%=activePhone%>";
    
    if("1"==$("#isse276",window.parent.parent.document).val()){
    	window.open(pageName,'销售品选择','width=1px,height=1px,left=9999,top=9999,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}
    else{
    	window.open(pageName,'销售品选择','width=840px,height=600px,left=100,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
    }
}
function funCheckm462(){
    if ($("#nextBtn")[0].custOrder != "")//如果是断点恢复的，清表
    {
        clearCar();
        $("#nextBtn")[0].custOrder = "";
    }
    initOpCode = "m462";
    var pageName = "qryProductOfferComplex.jsp?opCode="+initOpCode+"&phoneNo=<%=activePhone%>&time=<%=new Date()%>";
    window.open(pageName,'销售品选择','width=840px,height=600px,left=100,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
}

function chkOldUserBusiness(initOpCode){
	var v_chkOldUserFlag = true;
	//判断这个客户是否是新开户的客户
	var isExitCustFlag = "N";
	var userIdType = "";
	var myPacket = new AJAXPacket("ajax_isExitForCust.jsp","正在查询信息，请稍候......");
  myPacket.data.add("g_CustId","<%=g_CustId%>"); 
  myPacket.data.add("opCode",initOpCode);
  core.ajax.sendPacket(myPacket,function(packet){
  	var retCode=packet.data.findValueByName("retCode");
	  var retMsg=packet.data.findValueByName("retMsg");
	  var v_isExitCustFlag=packet.data.findValueByName("isExitCustFlag"); //当前客户下，用户是否存在
	  var v_userIdType=packet.data.findValueByName("userIdType"); //当前客户下，身份证类型
	  if(retCode == "000000"){
	  	isExitCustFlag = v_isExitCustFlag;
	  	userIdType = v_userIdType;
	 	}else{
	 		rdShowMessageDialog("查询此客户是否存在用户信息失败！错误代码:<%=retCode%><br>错误信息:<%=retMsg%>！",0);
	 		v_chkOldUserFlag = false;
			return  false;
	 	}
  });
  myPacket = null;
	if(isExitCustFlag == "Y"){//说明客户已存在用户
		//1-判断此用户当前证件类型，是否是身份证
		if(userIdType == "0" || userIdType == "00"){ //身份证:如果是身份证开户的，就不允许进行1104普通开户、4977 宽带开户
			//rdShowMessageDialog("当前用户证件类型为身份证，不允许办理“并老客户”业务！请新建客户！",1);
			//return  false;
		}else{ //2-判断是否有优惠权限
			var oldFav_a971 = <%=oldFav_a971%>;
			if(!oldFav_a971){ //无权限，则不允许办理
				rdShowMessageDialog("工号没有并老客户权限，不允许办理“并老客户”业务！请新建客户！",1);
				return  false;
			}else{//有权限，则可以进行并老户1104
				return true;
			}
		}
	}
	return v_chkOldUserFlag;
}  

function funCheckd535()
{
	  if ($("#nextBtn")[0].custOrder != "")//如果是断点恢复的，清表
    {
        clearCar();
        $("#nextBtn")[0].custOrder = "";
    }
    initOpCode = "d535";
    var pageName = "qryProductOfferComplex.jsp?opCode="+initOpCode;
   	window.open(pageName,'销售品选择','width=840px,height=600px,left=100,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
}

function resultProcess(resultList,retOpCode){	 
    if (resultList != null)
    {
        var result1 = resultList.split("|");
        for (var n = 0; n < result1.length; n++)
        {
            var result2 = result1[n].split(",");
            var tabID = "shoppingCarList";
            var tabRowNum = document.getElementById(tabID).rows.length;
            var phoneNo = "";
            var idNo = ""; 										//用户ID
            var opcode ;
            var offerId = result2[0];					//销售品标识
            var offerName = result2[1];				//销售品名称
            var offerType = result2[7];	      //销售品类型 30组合 10单个
            var servBusiId = result2[9];
            var offerInfoCode = result2[10];
            var offerInfoValue = result2[11];
            //alert("result2[0]|"+result2[0]+"\n"+"result2[1]|"+result2[1]+"\n"+"result2[2]|"+result2[2]+"\n"+"result2[3]|"+result2[3]+"\n"+"result2[4]|"+result2[4]+"\n"+"result2[5]|"+result2[5]+"\n"+"result2[6]|"+result2[6]+"\n"+"result2[7]|"+result2[7]+"\n"+"result2[8]|"+result2[8]+"\n"+"result2[9]|"+result2[9]+"\n"+"result2[10]|"+result2[10]+"\n"+"result2[11]|"+result2[11]);
            if (offerType == "30")//组合
            {
                opcode = "q002";
            } else//单一
            {
            	if(typeof(retOpCode) != "undefined"
            			&& retOpCode != "undefined"
            			&& retOpCode != "1104"){
            				opcode = retOpCode;
            	}else{
                opcode = initOpCode;
              }
            }
            var dealNum = "<input type='text' style='border:1px solid #666' onKeyUp=chkInt(this) onafterpaste=chkInt(this)  value='1' size='3'>&nbsp;";
            var delBut = "<input  type='button' value='删除' class='b_text'   class='butDel' onclick='delTr()' id=''><span style='display:none'>N|" + idNo + "|" + offerId + "|" + opcode + "|" + servBusiId + "|" + offerInfoCode + "|" + offerInfoValue + "</span>&nbsp;";
            //alert("phoneNo|"+phoneNo+"\n"+"offerName|"+offerName+"\n"+"dealNum|"+dealNum+"\n"+"delBut|"+delBut);
            var arrTdCon = new Array(phoneNo, offerName, dealNum, delBut);
            
            
             if($("#shoppingCarList tr").length >1){
					    if(rdShowConfirmDialog("您已经选择了一个销售品，要替换已有的销售品么？") == 1){
					    		$("#shoppingCarList tr").eq(1).remove();
					    		addTr(tabID, "1", arrTdCon, "1");
					    	} 
					    }else{
					    	addTr(tabID, tabRowNum, arrTdCon, "1");
					    } 
            
         }
    }
}


function doGetProdSrv(data)
{
    if (data.trim() == "")
    {
      rdShowMessageDialog("没有产品信息");
    } else {
       eval(data);
    }
}

//客户服务树
function drawCustServiceTree(phoneNo, idNo, prodId, offerId, brandId, flag, allSize,CustId)
{	
    for(var i=0;i<allSize;i++){
        if(flag == i){
            $("#prodList_"+i).addClass("orange");
        }else{
            $("#prodList_"+i).removeClass("orange");
        }
    }
    var packet = new AJAXPacket("getProdSrv.jsp");
    packet.data.add("prodId", prodId);
    packet.data.add("phoneNo", phoneNo);
    packet.data.add("idNo", idNo);
    packet.data.add("offerId", offerId);
    packet.data.add("brandId", brandId);
    packet.data.add("CustId", CustId);
    core.ajax.sendPacketHtml(packet, doGetProdSrv); //hejwa 修改,之前为异步有点问题，修改为默认同步，若在增加参数为false
    packet = null;
    if('<%=loginType%>' != 1)
    {
    	ini(phoneNo);
    }
}

function chkInt(obj)
{
   obj.value = obj.value.replace(/\D/g, '')
}

function LK(opcode, functionName, phoneNo, idNo, servBusiId, offerId, brandId){
		
		
    if ($("#nextBtn")[0].custOrder != "")//如果是断点恢复的，清表
    {
        clearCar();
        $("#nextBtn")[0].custOrder = "";
    }

    //判断是否互斥
    var sData = getTableData("shoppingCarList", 2, 3);
    var packet = new AJAXPacket("chkProdSrvRel.jsp");
    packet.data.add("opcode", opcode);
    packet.data.add("functionName", functionName);
    packet.data.add("phoneNo", phoneNo);
    packet.data.add("idNo", idNo);
    packet.data.add("servBusiId", servBusiId);
    packet.data.add("sData", sData);
    packet.data.add("offerId", offerId);
    packet.data.add("brandId", brandId);
    packet.data.add("custId", '<%=gCustId%>');
    core.ajax.sendPacket(packet, doChkProdSrvRel);
    packet = null;
    
    
    
    if(opcode=="e301"&&"<%=e301_spCar_check%>"!="1"&&"<%=e301_spCar_check%>"!="0"){
    	rdShowMessageDialog("宽带包年取消时将收取剩余预存的30%违约金");
    }

}

//判断是否互斥回调
function doChkProdSrvRel(packet)
{
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    var checkflag = packet.data.findValueByName("checkflag"); //认证标识
    var custAuthIdType = packet.data.findValueByName("CustIdType"); //认证类型
    var phoneNo = packet.data.findValueByName("phoneNo");
    var opcode = packet.data.findValueByName("opcode");
    var functionName = packet.data.findValueByName("functionName");
    var brandId = packet.data.findValueByName("brandId");
    var idNo = packet.data.findValueByName("idNo");
    var servBusiId = packet.data.findValueByName("servBusiId");
    var offerId = packet.data.findValueByName("offerId");
    var tabID = "shoppingCarList";
    var tabRowNum = document.getElementById(tabID).rows.length;

    if (retCode == "0")
    {
        var sizeFlag = packet.data.findValueByName("sizeFlag");

        if (parseInt(sizeFlag) > 0)
        {
            var prompt = packet.data.findValueByName("prompt");
            return false;
        } else {

           /* if (checkflag != "1")//需要验证
            {
                var custAuthId = "";
                if (custAuthIdType == "0")//客户
                {
                    custAuthId = "<%=gCustId%>";
                } else if (custAuthIdType == "1")//服务号码
                {
                    custAuthId = phoneNo;
                }
                var str = "?brandId=" + brandId
                        + "&gCustId=<%=gCustId%>"
                        + "&custAuthId=" + custAuthId
                        + "&idNo=" + idNo
                        + "&offerId=" + offerId
                        + "&opCode=" + opcode
                        + "&opName=权限认证"
                        + "&servBusiId=" + servBusiId
                        + "&phoneNo=" + phoneNo
                        + "&functionName=" + functionName;

                var path = "sCustAuthQry.jsp" + str;
                openDivWin(path, '权限认证', '500', '300');

            } else {//不需要验证 */
              insertCar(idNo, offerId, opcode, servBusiId, phoneNo, functionName);
            //}
        }
    } else if (retCode == "2")
    {
        rdShowMessageDialog("session失效");
    } else
    {
        rdShowMessageDialog("[" + retCode + "]" + retMsg);
    }
}

function insertCar(idNo, offerId, opcode, servBusiId, phoneNo, functionName)
{
	  var packet = new AJAXPacket("checkOpCode.jsp");
	  		packet.data.add("idNo", idNo);
	  		packet.data.add("offerId", offerId);
        packet.data.add("opcode", opcode);
        packet.data.add("servBusiId", servBusiId);
        packet.data.add("phoneNo", phoneNo);
        packet.data.add("functionName", functionName);
        core.ajax.sendPacket(packet, doCheckOpCode);
        packet = null;
}

function doCheckOpCode(packet){
	var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
  
	if(retCode=="0"){
			var idNo = packet.data.findValueByName("idNo");
		  var offerId = packet.data.findValueByName("offerId");
		  var opcode = packet.data.findValueByName("opcode");
		  var servBusiId = packet.data.findValueByName("servBusiId");
		  var phoneNo = packet.data.findValueByName("phoneNo");
		  var functionName = packet.data.findValueByName("functionName");
		  
			var tabID = "shoppingCarList";
	    var tabRowNum = document.getElementById(tabID).rows.length;
	    var offerInfoCode = "";
	    var offerInfoValue = "";
	    var dealNum = "<input type='text' style='border:1px solid #FFF' name=test onKeyUp=chkInt(this) onafterpaste=chkInt(this) readonly value='1' size='3'>&nbsp;";
	    var delBut = "<input  type='button' value='删除' class='b_text' onclick='delTr()' id=''><span style='display:none'>Y|" + idNo + "|" + offerId + "|" + opcode + "|" + servBusiId + "|" + offerInfoCode + "|" + offerInfoValue + "</span>&nbsp;";
	    var arrTdCon = new Array(phoneNo, functionName, dealNum, delBut);
	    addTr(tabID, tabRowNum, arrTdCon, 0|1);
		  
		}else{
			rdShowMessageDialog(retCode+":"+retMsg);
		}	
}
function custOrderCHome(sDataHome){
	var packet = new AJAXPacket("/npage/portal/shoppingCar/sCustOrderC.jsp");
        packet.data.add("sData", sDataHome);
        packet.data.add("optorMsg", sDataHome);
        packet.data.add("custId", "<%=gCustId%>");
        packet.data.add("prtFlagValue", 'N');
        core.ajax.sendPacket(packet, doCustOrderC);
        packet = null;
}	
function custOrderC()
{
		
		
    var sData = getTableData("shoppingCarList", 2, 3);
    var optorMsg = getOptorMsg();
     if (!checksubmit(frm)) return false;
		//经办人信息未展开，则系统校验框架不起作用，需要手工校验。
    var agent_name = document.all.agent_name.value; 									//经办人名称
    var agent_idNo = document.all.agent_idNo.value; 									//证件号码
    var phone1 = document.all.agent_phone.value;
    var phone2 = document.all.ContactMobile.value;
    if (sData == "")
    {
        rdShowMessageDialog("请选择客户服务");
        return false;
    }
    var prtFlag = document.all.prtFlag;
    var prtFlagValue = "";
    if (prtFlag[0].checked)
    {
        prtFlagValue = "Y";
    } else
    {
        prtFlagValue = "N";
    }
    if ($("#nextBtn")[0].custOrder == "")//创建流程
    {
    	//alert(660);
        var packet = new AJAXPacket("sCustOrderC.jsp");
        packet.data.add("sData", sData);
        packet.data.add("optorMsg", optorMsg);
        packet.data.add("custId", "<%=gCustId%>");
        packet.data.add("prtFlagValue", prtFlagValue);
        core.ajax.sendPacket(packet, doCustOrderC);
        packet = null;
    } else//旧订单，直接next
    {
    		//alert(670);
        var custOrderId = $("#nextBtn")[0].custOrder;
        var custOrderNo = $("#nextBtn")[0].custOrder;
        goNext(custOrderId, custOrderNo, prtFlagValue);
        detBut();
    }
}

function getOptorMsg() {
    var agent_name = document.all.agent_name.value; 									//经办人名称
    var agent_idType = document.all.agent_idType.value; 							//证件类型
    var agent_idNo = document.all.agent_idNo.value; 									//证件号码
    var agent_phone = document.all.agent_phone.value == "" ? " " : document.all.agent_phone.value;						  //联系电话
    var ContactMobile = document.all.ContactMobile.value == "" ? " " : document.all.ContactMobile.value;				//手机
    var zipcode = document.all.zipcode.value == "" ? " " : document.all.zipcode.value;													//邮政编码
    var ContactUserAddr = document.all.ContactUserAddr.value == "" ? " " : document.all.ContactUserAddr.value;	//地址
    var ContactEmailAddress = document.all.ContactEmailAddress.value == "" ? " " : document.all.ContactEmailAddress.value;	//邮箱
    var optorData = agent_name + "," + agent_idType + "," + agent_idNo + "," + agent_phone + "," + ContactMobile + "," + zipcode + "," + ContactUserAddr + "," + ContactEmailAddress;
    return optorData;
}
/*2013/07/04 8:49:56 gaopeng 下一步创建流程回调函数*/
function doCustOrderC(packet)
{
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    if (retCode == "0")
    {
	    	if(homeSData!=""){
	    		// 为标志赋值 创建订单成功 失败的情况可通过查看订单处恢复
	    		parent.orderFlag.value = "1";
	    	}
        var prtFlag = "";
        if (document.all.prtFlag[0].checked)
        {
            prtFlag = "Y";
        } else
        {
            prtFlag = "N";
        }
        var custOrderId = packet.data.findValueByName("custOrderId");
        var custOrderNo = packet.data.findValueByName("custOrderNo");
        
        goNext(custOrderId, custOrderNo, prtFlag);
        detBut();

    } else
    {
        rdShowMessageDialog("创建客户订单失败!请联系系统管理员!");
    }
}

function detBut()
{
    $(".butDel").remove(); //del butDel button
    $("#nextBtn")[0].disabled = true;
    $("#rootTree1").html("");
}
function getCustMore(obj)
{
    if (obj.flag == "1")
    {
        var oDiv = "<div class=blue><span style=font-size:10pt>正在查询……</span></div>";
        $(".moreCust").html(oDiv);
        var packet = new AJAXPacket("getCustMore.jsp");
        packet.data.add("custId", "<%=gCustId%>");
        core.ajax.sendPacketHtml(packet, doGetCustMore, true);
        packet = null;
        obj.flag = "2";
    } else
    {
        obj.src = "/nresources/default/images/icon_look1.gif";
        $(".moreCust").html("");
        obj.flag = "1";
    }
}

function doGetCustMore(data)
{
    $(".moreCust").html(data);
    $("#custMoreImg")[0].src = "/nresources/default/images/icon_look2.gif";
}

//生成产品订购树
window.onload = function() {
    <%
      if("1".equals(loginType)&&!"".equals(custLevelStar)){
    %>
        $("#custLevelStarTr1").css("display","");
        $("#custLevelStarTr2").css("display","");
        //$("#custLevelStarTr3").css("display","");
    <%
      }
    %>
    if('<%=loginType%>' == 1){
        parent.parent.dnyCreatDiv("<%=g_CustId%>","<%=phone_no%>","<%=broadPhone%>");
        parent.parent.activateTab("custid"+"<%=g_CustId%>");
        ini('<%=phone_no%>');
    }else if('<%=loginType%>' == 8){
    		/* 选择使用铁通宽带进入，与原有使用手机号码方式一样 */
    		parent.parent.dnyCreatDiv("<%=g_CustId%>","<%=phone_no%>","<%=broadPhone%>");
        parent.parent.activateTab("custid"+"<%=g_CustId%>");
        ini('<%=phone_no%>');
    }else if('<%=loginType%>' == 10){
    		/* 家庭入网，与原有使用手机号码方式一样 */
    		parent.parent.dnyCreatDiv("<%=g_CustId%>","<%=phone_no%>","<%=broadPhone%>");
        parent.parent.activateTab("custid"+"<%=g_CustId%>");
        ini('<%=phone_no%>');
    }else{
        parent.parent.dnyCreatDiv("<%=g_CustId%>","index");
        parent.parent.activateTab("custid"+"<%=g_CustId%>");
    }
    var pwrf = "<%=pwrf%>";
    if(pwrf == "true"){
	    treeCS = new stdTree("treeCS", "rootTree1");
	    treeCS.imgSrc = "<%=request.getContextPath()%>/nresources/default/images/mztree/"
	    with (treeCS)
	    {
	         
	         if('<%=loginType%>' == 10){
         		N["g629"] = "g629"+";"+"g629"+"-家庭开户;000;0;funCreFamily()";/*hejwa 增加 家庭开户业务 2013年4月11日13:12:22 */
	         }else{
	         	N[initOpCode] = initOpCode+";"+initOpCode+"-普通开户;000;0;funCheck()";
	         }
	         /****N["4977"] = "4977"+";"+"4977"+"-宽带入网;000;0;funCheck4977()";
	          先把IMS固话入网的入口封住
	         N["d535"] = "d535"+";"+"d535"+"-IMS固话入网;000;0;funCheckd535()";
	         ****/
	    }
	    treeCS.writeTree();
	    treeCS = null;
	}
	var pwrf4977 = "<%=pwrf4977%>";
	    if(pwrf4977 == "true"){
	    treeCS = new stdTree("treeCS", "rootTree1");
	    treeCS.imgSrc = "<%=request.getContextPath()%>/nresources/default/images/mztree/"
	    with (treeCS)
	    {		
	    		if('<%=loginType%>' != 10){
	         N["4977"] = "4977"+";"+"4977"+"-宽带入网;000;0;funCheck4977()";
	        }
	         /**** 先把IMS固话入网的入口封住
	         N["d535"] = "d535"+";"+"d535"+"-IMS固话入网;000;0;funCheckd535()";
	         ****/
	    }
	    treeCS.writeTree();
	    treeCS = null;
	}
    var pwrm462 = "<%=pwrfm462%>";
    if(pwrm462 == "true"){
	    treeCS = new stdTree("treeCS", "rootTree1");
	    treeCS.imgSrc = "<%=request.getContextPath()%>/nresources/default/images/mztree/"
	    with (treeCS)
	    {		
	    		if('<%=loginType%>' != 10){
	         N["m462"] = "m462"+";"+"m462"+"-IMS固话开户;000;0;funCheckm462()";
	        }
	         /**** 先把IMS固话入网的入口封住
	         N["d535"] = "d535"+";"+"d535"+"-IMS固话入网;000;0;funCheckd535()";
	         ****/
	    }
	    treeCS.writeTree();
	    treeCS = null;
	}
    <%
    if(!custOrderId.equals("null"))
    {
  	%>
			getCarFirst("<%=custOrderId%>","<%=workNo%>");	//2011/8/19 wanghfa修改
  	<%
    }
    %>
    
    
    $('img.closeEl').bind('click', toggleContent);

    $('img.hideEl').bind('click', hideContent);
    
    
    $("#maingetAlert").attr("src","custMaingetAlert.jsp?phone_no=<%=phone_no%>&accountType=<%=accountType%>");
}
var custmsgFlag = "";
function ajaxGetDcustMsgByCustId(){
	var packet = new AJAXPacket("ajaxGetDcustMsgByCustId.jsp");
	    packet.data.add("g_CustId", "<%=g_CustId%>");
	    core.ajax.sendPacket(packet, doGetDcustMsgByCustId);
	    packet = null;
	return custmsgFlag ;
}
function doGetDcustMsgByCustId(packet){
	custmsgFlag = packet.data.findValueByName("custmsgFlag");
}

var g629_CT_HOMECUST_INFO_flag = "0";
function ajax_CT_HOMECUST_INFO(){
	var packet = new AJAXPacket("ajax_CT_HOMECUST_INFO.jsp");
	    packet.data.add("g_CustId", "<%=g_CustId%>");
	    core.ajax.sendPacket(packet, do_CT_HOMECUST_INFO);
	    packet = null;
	return g629_CT_HOMECUST_INFO_flag ;
}
function do_CT_HOMECUST_INFO(packet){
	g629_CT_HOMECUST_INFO_flag = packet.data.findValueByName("g629_CT_HOMECUST_INFO_flag");
}

function funCreFamily(){
		if(ajaxGetDcustMsgByCustId()!=""){
			rdShowMessageDialog("此家庭客户已有家庭用户，不能再进行家庭用户开户");
			return;
		}
		
		
		if(ajax_CT_HOMECUST_INFO()!="0"&&ajax_CT_HOMECUST_INFO()!="1"){
			rdShowMessageDialog("一个手机号码只能办理一个家庭用户开户号码");
			return;
		}
		
		
    if ($("#nextBtn")[0].custOrder != "")//如果是断点恢复的，清表
    {
        clearCar();
        $("#nextBtn")[0].custOrder = "";
    }
    initOpCode = "g629";
    var pageName = "qryProductOfferComplex_family.jsp?opCode="+initOpCode;
   	window.open(pageName,'销售品选择','width=840px,height=600px,left=100,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
}
function getCarFirst(custOrderId,oldWorkNo)	//2011/8/19 wanghfa修改
{
	if(oldWorkNo!="<%=workNo%>")
	{
		rdShowMessageDialog("此订单只能由"+oldWorkNo+"受理");		
		return false;
	}
    $("#nextBtn")[0].custOrder = custOrderId;//置位
    clearCar();//清空

    var packet = new AJAXPacket("getCar.jsp");
    packet.data.add("custOrderId", custOrderId);
    core.ajax.sendPacketHtml(packet, doGetCar, true);
    packet = null;
}

//2011/6/21 wanghfa修改对工号的判断
var aCustOrderId = "";
function getCar(custOrderId,oldWorkNo) {
	aCustOrderId = custOrderId;
  var packet = new AJAXPacket("ajax_checkWorkNo.jsp");
  packet.data.add("workNo", "<%=workNo%>");
  packet.data.add("oldWorkNo", oldWorkNo);
  packet.data.add("phoneNo", "<%=phone_no%>");
  
  core.ajax.sendPacketHtml(packet, doCheckWorkNo, true);
  packet = null;
}

function doCheckWorkNo(data) {
	var retResult = data.trim();
	
	if (parseInt(retResult) == 0) {
		rdShowMessageDialog("此订单不能由<%=workNo%>受理，工号归属级别过低，或归属地不同。", 1);
		return false;
	}
	
    $("#nextBtn")[0].custOrder = aCustOrderId;//置位
    clearCar();//清空

    var packet = new AJAXPacket("getCar.jsp");
    packet.data.add("custOrderId", aCustOrderId);
    core.ajax.sendPacketHtml(packet, doGetCar, true);
    packet = null;
}

function doGetCar(data)
{
    eval(data);
}

function clearCar()
{
    var otable = document.getElementById("shoppingCarList");
    var tabRowNum = otable.rows.length;
    var i = parseInt(tabRowNum) - 1;
    for (; i > 0; i--)
    {
        otable.deleteRow(i);
    }
}

function clearPage()
{
	  try{
			parent.delOtherTab("child_index");
		}catch(e){}
    parent.parent.$("#carNavigate").html("");
    window.location.reload();
}

var optorFlag = true;
function showOptor() {
    if (optorFlag) {
        document.getElementById("optor").style.display = "";
        document.all.agent_idType.value = document.all.idType_0002.value;
        optorFlag = false;
    } else {
        document.getElementById("optor").style.display = "none";
        optorFlag = true;
    }
}


function showDetailCar(orderId,serNo){
		var path = "showDetailCar.jsp?orderId="+orderId+"&serNo="+serNo;
    retInfo = window.showModalDialog(path,"","dialogWidth:60");
	}
	
function delTrOver()
{
	var e = arguments[0] || window.event;
	var cur = e.srcElement || e.target;
	var curTr=cur.parentNode.parentNode
	var curTable=cur.parentNode;
	while(curTable&&curTable.tagName!="TABLE")
	{
		curTable=curTable.parentNode;
	}
	var tabTds=curTr.getElementsByTagName("td");
	var arrTd=new Array();
	for(var i=0; i<tabTds.length;i++)
	{
		var curTd=tabTds[i].innerHTML
		arrTd.push(curTd);
	}
	curTable.getElementsByTagName('tbody')[0].removeChild(curTr);	
	
	var custArrOrderId=curTr.getElementsByTagName("input")[2].value;	
	var packet = new AJAXPacket("ajax_delTr.jsp");
  packet.data.add("custArrOrderId", custArrOrderId);
  core.ajax.sendPacket(packet, delTrProcess,true);
  packet = null;	
		
	return arrTd;
}	
	
function delTrProcess(packet){
	  var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    if (retCode != "0")
    {
    	alert(retMsg);
	  }else{
	  	rdShowMessageDialog("删除订单子项成功。");	
	  	clearPage();  	
	  }
}	
//推荐业务信息
function nominateOper(phone_no,iCust_Type,vAction_Code,iCust_Type_code)
{
	if('<%=loginType%>' != 1)
	{
			var shopping_phoneno=document.getElementById("shopping_phoneno");
			shopping_phoneno.value=phone_no;
	}
	var packet = new AJAXPacket("ajax_addOper.jsp");
	packet.data.add("phone_no", phone_no);
  packet.data.add("iCust_Type", iCust_Type);
  packet.data.add("vAction_Code", vAction_Code);
  packet.data.add("iCust_Type_code", iCust_Type_code);
  core.ajax.sendPacket(packet, addOperProcess);
  packet = null;	
}

function addOperProcess(packet){
	  var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    if (retCode != "000000")
    {
    	alert(retMsg);
	  }else{
	  	rdShowMessageDialog("推荐业务成功。");	
	    if('<%=loginType%>' == 1)
	    {
  			ini('<%=phone_no%>');
  	  }
  	  else
			{
				var shopping_phoneno=document.getElementById("shopping_phoneno");
				phone_no=shopping_phoneno.value;
				ini(phone_no);
  	 	}
	  }
}	


 function popupDiv(div_id) { 
 				  
        var div_obj = $("#"+div_id);  
        var windowWidth = document.body.clientWidth;       
        var windowHeight = document.body.clientHeight;  
        var popupHeight = div_obj.height();       
        var popupWidth = div_obj.width();    
        //添加并显示遮罩层   
        $("<div id='mask'></div>").addClass("mask")   
                                  .width(windowWidth + document.body.scrollWidth)   
                                  .height(windowHeight + document.body.scrollHeight)   
                                  .click(function() {})   
                                  .appendTo("body")   
                                  .fadeIn(200);   
        div_obj.css({"position": "absolute"})   
               .animate({left: windowWidth/2-popupWidth/2,    
                         top: 80, opacity: "show" }, "slow");   
                        
    }   
      
    function hideDiv(div_id) {   
        $("#mask").remove();   
        $("#" + div_id).animate({left: 0, top: 0, opacity: "hide" }, "slow");   
    }  
    
     function iFrameHeight() {

        var ifm= document.getElementById("iframepage");

        var subWeb = document.frames ? document.frames["iframepage"].document :ifm.contentDocument;

            if(ifm != null && subWeb != null) {

            ifm.height = subWeb.body.scrollHeight;

            }

    }


 
</script>
</head>

<body>
<form method="post" name="frm">
	<input type="hidden" id="shopping_phoneno"/>
  <div id="Operation_Table">
		<div class="title">
		   <div id="title_zi">基本信息&&<a href="#" onclick="showOptor()">经办人信息</a></div>
		  <!--div id="title_zi"><img src="/nresources/default/images_sx/form_th_icon1.gif"/>客户信息</div-->

		</div>
    <div class="but_look">
        <img id="custMoreImg" src="/nresources/default/images/icon_look1.gif" flag="1" onclick="getCustMore(this)"/>
    </div>
            <div class="input">
             	<table cellspacing="0">
             		
             		<!-- hejwa 2015-6-1 14:55:38 -->
             		<!-- 关于部分BOSS界面添加客户是否为4G卡展现内容的函 -->
             		<!-- 由于之前的custLevelStarTr custLevelStarTr2 custLevelStarTr3逻辑一样，所以合成3列的行 -->
<%
	/**
	 * 查询手机号是否为4G卡用户
	 */
	 
	 String is_4G_sql       = "select to_char(count(*))  as is_4G_card   from dcustmsg a where a.phone_no =:phone_no   and a.service_type = '70' ";
	 String is_4G_sql_param = "phone_no="+phone_no;
	 
%>             		
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=is_4G_sql%>" />
		<wtc:param value="<%=is_4G_sql_param%>" />
	</wtc:service>
	<wtc:array id="result_is4G" scope="end"/>
		
<%

	
	String phone_no_is4G = "";
	if(result_is4G.length>0){
		if("0".equals(result_is4G[0][0])){//没查到非4G卡
			phone_no_is4G = "否";
		}else{
			phone_no_is4G = "是";
		}
	}
	
%>		

             		<tr>
             			<td  class=blue>民族</td>
             			<td><%=nationName%></td> 
             			<td  class=blue>归属渠道</td>
             			<td>
             			    <%=belongCity%>
             				<input type="hidden" name="custNameforsQ046" value="<%=custName%>">
             				<%
             				if(ba0002_black.equals("N"))
             				{
             				}else
             				{
          				%>
          					<script>
          						rdShowMessageDialog("该客户属于黑名单客户");
          					</script>
          				<%
             				}
             				%>
             			</td>
             		
             			<td  class=blue>客户级别 </td>
             			<td ><%=custLevel%></td> 
             			
             		</tr>
             	  
             	  <tr id="custLevelStarTr1" style="display:none">
             			<td  class=blue>客户等级 </td>
             			<td ><%=custLevelStar%></td> 
             			<td  class="blue">星级开始时间 </td>
             			<td ><%=custLevelStartTime%></td> 
             			<td  class="blue">星级结束时间 </td>
             			<td ><%=custLevelEndTime%></td> 
             	  </tr>
             	  <tr id="custLevelStarTr2" style="display:none">
             			<td  class="blue">是否集团重要成员 </td>
             			<td ><%if("1".equals(ifUnitImpMember)){out.print("是");}else{out.print("否");}%></td> 
             			<td  class="blue">是否AB类集团 </td>
             			<td ><%if("1".equals(ifABUnit)){out.print("是");}else{out.print("否");}%></td> 
             			<% //System.out.println("liangyouliang:-"+"");
             			
             			int retSize = retConsOffer.getUtype("2").getSize();
             			
             		//	System.out.println("liangyouliang:-"+"retSize=="+retSize);
             			String retrunCode=String.valueOf(retConsOffer.getValue(0));		
             			if("0".equals(retrunCode) && retSize>0){
             				String retConsOfferSmName = WtcUtil.repNull(retConsOffer.getValue("2.0.14"));
             			%>
	             			<td class="blue"><%if("动感地带".equals(retConsOfferSmName)||"神州行".equals(retConsOfferSmName)||"全球通".equals(retConsOfferSmName)){
	             				%>可兑换积分数<%
	             			}%></td>
	             			<td><%if("动感地带".equals(retConsOfferSmName)||"神州行".equals(retConsOfferSmName)||"全球通".equals(retConsOfferSmName)){
	             				%><%=integral%><%
	             			}%>&nbsp;</td>
             			<%}else{%>
             				<td class="blue"></td>
	             			<td></td>
             			<%}%>
             			
             	  </tr>
             	  <tr>
             	  	<td  class="blue">稽核状态</td>
             			<td><%=bd0002_status%></td>   
             			<td class="blue">是否是4G卡客户</td>
             			<td><%=phone_no_is4G%></td>
             			<td class="blue">是否集团成员</td>
             			<td><%=isJTCY%></td>
             	  </tr>
             	  <tr>
             	  	<input type="hidden" name="idType_0002" value="<%=agent_idType%>"/>
             	  </tr>
          	</table>
          </div>
            <div id="items" class="moreCust"></div>

            <div id="optor" style="display:none">

						<div class="title">
							<div id="title_zi">经办人</div>
						</div>

                    <table cellspacing=0>
                        <tr>
                            <td class="blue">经办人名称</td>
                            <td>
                                <input type="text" name="agent_name" class="required" value=""/>
                                <input type="hidden" name="agent_name_hide" class="required" value="<%=linkmanName%>"/>
                            </td>
                            <script>
                            	if(document.all.agent_name.value==""){
                            			//document.all.agent_name.value = "<%=custName%>";
                            	}
                            </script>
                            <td class="blue">证件类型</td>
                            <td>
                                <select name="agent_idType" class="required" onChange="change_idType(this,document.getElementById('agent_idNo'),document.getElementById('agent_len_text'))">
                                  <wtc:pubselect name="sPubSelect" outnum="3" retcode="ret" retmsg="retm" routerKey="region" routerValue="<%=regionCode%>">
                                      <wtc:sql>select trim(ID_TYPE),ID_NAME,ID_LENGTH from sIdType order by id_type</wtc:sql>
                                  </wtc:pubselect>
                                  <wtc:iter id="rowsjingban" indexId="i">
                                        <%if (rowsjingban[0].equals("2")) {%>
                                        <option selected="selected"
                                                value=<%=rowsjingban[0]%> v_ID_length=<%=rowsjingban[2]%>><%=rowsjingban[1]%>
                                        </option>
                                        <%} else {%>
                                        <option value=<%=rowsjingban[0]%> v_ID_length=<%=rowsjingban[2]%>><%=rowsjingban[1]%>
                                        </option>
                                        <%}%>
                                  </wtc:iter>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="blue">证件号码</td>
                            <td>
                                <input type="text" name="agent_idNo" class="required idCard" v_minlength="18" v_maxlength="18"
                                       maxLength="18" id="agent_idNo" value=""/>
                                <input type="hidden" name="agent_idNo_hide" id="agent_idNo_hide" value="<%=agent_idNo%>"/>
                                <input type="text" name="agent_len_text" id="agent_len_text" value=""
                                       style="background:none;border:none" readonly>
                            </td>

                            <td class="blue">联系电话</td>
                            <td>
                                <input type="text" name="agent_phone" class="andCellphone" value="<%=agent_phone%>"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="blue">手机</td>
                            <td>
                                <input type="text" name="ContactMobile" class="andCellphone"/>
                            </td>
                            <td class="blue">邮政编码</td>
                            <td>
                                <input type="text" name="zipcode" id="zipcode" class=""/>
                            </td>
                        </tr>
                        <tr>
                            <td class="blue">地址</td>
                            <td>
                                <input type="text" name="ContactUserAddr" class=""/>
                            </td>
                            <td class="blue">邮箱</td>
                            <td>
                                <input type="text" name="ContactEmailAddress" class=""/>
                            </td>
                        </tr>
                    </table>
            </div>


            <!--div id="oper_title"><img src="/nresources/default/images_sx/form_th_icon1.gif"/>产品订购信息</div-->

            <div id="items">
                <div class="item-col col-1">
                    <div class="title">
                    	<div id="title_zi">产品订购信息</div>
                    </div>

                    <div class="list" style="height:100px; overflow-y:auto; overflow-x:hidden;_width:100%;">
                        <table cellspacing="0" id="customerInfo">
                            <tr>
                            	<th>业务号码</th>
                                <th>主产品名称</th>
                                <th>基本销售品名称</th>
                                <th>销售品品牌名称</th>
                                <th>状态</th>
                            </tr>
                            <%
                                retCode = retConsOffer.getValue(0);
                                if (retCode.equals("0")) {
                                    int xsize = retConsOffer.getSize("2");
                                    String[] phoneArr=new String[xsize];
                                    System.out.println("custMain.jsp 客户号码数量  xsize==="+xsize);
                                    for (int i = 0; i < xsize; i++) {
	                                    String phoneNO = retConsOffer.getValue("2." + i + ".21");
	                                    String offerName = retConsOffer.getValue("2." + i + ".8");
	                                    String offerNameShow = offerName;
	                                    
	                                    if(InfoMap.get(phoneNO)==null){
			                                    ContactInfo cInfo = new ContactInfo();
																			    cInfo.setPhoneno(phoneNO);
																			    if(appCnttFlag!=null&&"Y".equals(appCnttFlag))
                                          {
																			    	cInfo.setContact_id(Contact_id);																			    
																			    }
																			    InfoMap.put(phoneNO, cInfo);
																			    timeMap.put(phoneNO,dateStr);
			                                    phoneArr[i]=phoneNO;
	                                    }
	                                    
	                                    if(offerName.length()>10)
	                                    {
	                                    	 offerNameShow = offerName.substring(0,10)+"...";
	                                    }
	                                    if(loginType.equals("1")&&phoneNO.equals(phone_no))
	                                    {
	                                    
	                                    System.out.println("------------gaopengSeeLog---mylog----------------------1");
	                                    	 %>
							                            <tr id='prodList_<%=i%>'  style="cursor:pointer" onclick="drawCustServiceTree('<%=retConsOffer.getValue("2."+i+".21")%>','<%=retConsOffer.getValue("2."+i+".0")%>','<%=retConsOffer.getValue("2."+i+".1")%>','<%=retConsOffer.getValue("2."+i+".6")%>','<%=retConsOffer.getValue("2."+i+".13")%>','<%=i%>','<%=xsize%>','<%=g_CustId%>');reloadPhoneNo('<%=retConsOffer.getValue("2."+i+".21")%>');">
							                            	<td><%=retConsOffer.getValue("2." + i + ".21")%>&nbsp; </td>
							                                <td ><%=retConsOffer.getValue("2." + i + ".2")%> &nbsp;</td>
							                                <td nowrap title="<%=offerName%>"><%=offerNameShow%> &nbsp;</td>
							                                <td><%=retConsOffer.getValue("2." + i + ".14")%> &nbsp;</td>
							                                <td nowrap ><%=retConsOffer.getValue("2." + i + ".22")%>&nbsp;&nbsp;&nbsp;&nbsp;</td>
							                            </tr>
							                            <%
							                         break;
	                                    }
                                    }
                                    relInfoMap.put(gCustId,phoneArr);  
                                    
			                             for (int i = 0; i < xsize; i++) {
			                             		String phoneNO = retConsOffer.getValue("2." + i + ".21");
			                             		String offerName = retConsOffer.getValue("2." + i + ".8");
	                                    String offerNameShow = offerName;
	                                    if(offerName.length()>10)
	                                    {
	                                    	 offerNameShow = offerName.substring(0,10)+"...";
	                                    }
	                                    if((loginType.equals("1")&&!phoneNO.equals(phone_no))||!loginType.equals("1"))
	                                    {
	                                    System.out.println("-------------gaopengSeeLog--mylog----------------------2");
			                            %>
			                            <tr id='prodList_<%=i%>' style="cursor:pointer" onclick="drawCustServiceTree('<%=retConsOffer.getValue("2."+i+".21")%>','<%=retConsOffer.getValue("2."+i+".0")%>','<%=retConsOffer.getValue("2."+i+".1")%>','<%=retConsOffer.getValue("2."+i+".6")%>','<%=retConsOffer.getValue("2."+i+".13")%>','<%=i%>','<%=xsize%>','<%=g_CustId%>');reloadPhoneNo('<%=retConsOffer.getValue("2."+i+".21")%>');">
			                            		<td><%=retConsOffer.getValue("2." + i + ".21")%>&nbsp;</td>
			                                <td   style="display:none"><%=retConsOffer.getValue("2." + i + ".1")%> &nbsp;</td>
			                                <td><%=retConsOffer.getValue("2." + i + ".2")%> &nbsp;</td>
			                               
			                                <td><%=retConsOffer.getValue("2." + i + ".14")%> &nbsp;</td>
			                                <td nowrap ><%=retConsOffer.getValue("2." + i + ".22")%>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			                            </tr>
			                            <%
			                            		}
			                              }
                                }
                              else{
                              	
                              	 %>
                              	 <script language="javascript" type="text/javascript">
                              	  rdShowMessageDialog("取客户信息失败！");
                              	 </script>
                              	<%
                              	}
                              	
                              	                                 
										     System.out.println(map); 	
										     System.out.println(InfoMap); 	
										     System.out.println(relInfoMap); 	 	
                            %>
                        </table>
                    </div>

                    <div class="title">
                    	<div id="title_zi">购物车</div>
                    </div>

                    <div class="list">
                        <table cellspacing="0" id="shoppingCarList" style="border-collapse:collapse">
                            <tr>
                                <th>业务号码</th>
                                <th>产品名称</th>
                                <th>受理数量</th>
                                <th>操作</th>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="item-row col-2" style="width:26%;height:100%;overflow-y:no;overflow-x:no;">
                    <div class="title">
                    	<div id="title_zi">客户服务</div>
                    </div>
                    <div id="rootTree1"></div>
                </div>
            </div>
        </div>
        <div id='pop-div' style="overflow-y:auto; overflow-x:auto; width:600px; height:500px;" class="pop-box">  
				    <iframe id="iframepage" style="width:100%;height:100%;"  align="center"  style="overflow-y:auto; overflow-x:auto;" id="win" name="win" frameborder="0" scrolling="no" src="/npage/portal/shoppingCar/getMarket.jsp?phoneNo=<%=phone_no%>" onload="this.height=0;var fdh=(this.Document?this.Document.body.scrollHeight:this.contentDocument.body.offsetHeight);this.height=(fdh>400?fdh:400)"></iframe>
				</div>
				<!--<input type=button id=btnTest  value='test' onclick="popupDiv('pop-div');"/>-->
				</div>
				<div id="insertOper">
				</div>
					
        <div id="footer" style="width: 98%;margin-left: 10px;">
            <div class="font12" style="width:40%;float:left;">
                <div style="display:none">
                <input type="radio" name="prtFlag" id="prtFlag" value="Y" checked="checked"/>合打
                <input type="radio" name="prtFlag" id="prtFlag" value="N"/>分打
              </div>
            </div>
            <div style="float:left;text-align:left;">
                <input type="button" class="b_foot" value="下一步" id="nextBtn" custOrder="" onclick="custOrderC()"/>
                <input type="button" class="b_foot" value="重置" id="nextBtn" custOrder="" onclick="clearPage();"/>
            </div>
        </div>
        <input type="hidden" name="blindAddCombo" id="blindAddCombo" value=""/>
        <input type="hidden" id="phone_no_source" name="phone_no_source" value="<%=activePhone%>" />
        <%@ include file="/npage/include/footer_simple.jsp" %>
    </form>
    
<div id="page-warp">
    <div id="more-info-items">
    	<div class="item">
	        <div class="item-col col-1">
	            <div class="item">
	            	<div class="caption">
	            		<div class="text">特服开通</div>
	            		<div class="option">
	                        <div class="sub">
	                            <DIV class="li"><img id="div1_switch" class="closeEl" src="/nresources/<%=cssPath%>/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
	                            <DIV><img class="hideEl" src="/nresources/<%=cssPath%>/images/cha.gif"   style='cursor:hand' width="15" height="15"></DIV>
	                        </div>
	            		</div>
	            	</div>
	            	<div class="content">
	            	    <DIV class="itemContent" id="mydiv1">
	            			<DIV id="wait1"><img src="/nresources/<%=cssPath%>/images/blue-loading.gif"  width="32" height="32"></DIV>
	            		</DIV>
	            	</div>
	            </div>
	        </div>
	        <div class="item-col col-2">
	            <div class="item">
	            	<div class="caption">
	            		<div class="text">资源占用</div>
	            		<div class="option">
	                        <div class="sub">
	                            <DIV class="li"><img id="div2_switch" class="closeEl" src="/nresources/<%=cssPath%>/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
	                            <DIV><img class="hideEl" src="/nresources/<%=cssPath%>/images/cha.gif"   style='cursor:hand' width="15" height="15"></DIV>
	                        </div>
	            		</div>
	            	</div>
	            	<div class="content">
	            	    <DIV class="itemContent" id="mydiv2">
	            			<DIV id="wait2"><img src="/nresources/<%=cssPath%>/images/blue-loading.gif"  width="32" height="32"></DIV>
	            		</DIV>
	            	</div>
	            </div>
	        </div>
		</div>
    	<div class="item">		
		    <div class="item-col col-1">
		        <div class="item">
		        	<div class="caption">
		        		<div class="text">可选资费信息</div>
		        		<div class="option">
		                    <div class="sub">
		                        <DIV class="li"><img id="div3_switch" class="closeEl" src="/nresources/<%=cssPath%>/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
		                        <DIV><img class="hideEl" src="/nresources/<%=cssPath%>/images/cha.gif"   style='cursor:hand' width="15" height="15"></DIV>
		                    </div>
		        		</div>
		        	</div>
		        	<div class="content">
		        	    <DIV class="itemContent" id="mydiv3">
		        			<DIV id="wait3"><img src="/nresources/<%=cssPath%>/images/blue-loading.gif"  width="32" height="32"></DIV>
		        		</DIV>
		        	</div>
		        </div>
		    </div>
		    
		    	        <div class="item-col col-2">
	            <div class="item">
	            	<div class="caption">
	            		<div class="text">用户属性</div>
	            		<div class="option">
	                        <div class="sub">
	                            <DIV class="li"><img id="div4_switch" class="closeEl" src="/nresources/<%=cssPath%>/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
	                            <DIV><img class="hideEl" src="/nresources/<%=cssPath%>/images/cha.gif"   style='cursor:hand' width="15" height="15"></DIV>
	                        </div>
	            		</div>
	            	</div>
	            	<div class="content">
	            	    <DIV class="itemContent" id="mydiv4">
	            			<DIV id="wait5"><img src="/nresources/<%=cssPath%>/images/blue-loading.gif"  width="32" height="32"></DIV>
	            		</DIV>
	            	</div>
	            </div>
	        </div> 
		 </div>


	<div class="item">		
		    <div class="item-col col-1">
		        <div class="item">
		        	<div class="caption">
		        		<div class="text">实名状态</div>
		        		<div class="option">
		                    <div class="sub">
		                        <DIV class="li"><img id="div5_switch" class="closeEl" src="/nresources/<%=cssPath%>/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
		                        <DIV><img class="hideEl" src="/nresources/<%=cssPath%>/images/cha.gif"   style='cursor:hand' width="15" height="15"></DIV>
		                    </div>
		        		</div>
		        	</div>
		        	<div class="content">
		        	    <DIV class="itemContent" id="mydiv6">
		        			<DIV id="wait6"><img src="/nresources/<%=cssPath%>/images/blue-loading.gif"  width="32" height="32"></DIV>
		        		</DIV>
		        	</div>
		        </div>
		    </div>
    
		    	        <div class="item-col col-2">
	            <div class="item">
	            	<div class="caption">
	            		<div class="text">集团信息</div>
	            		<div class="option">
	                        <div class="sub">
	                            <DIV class="li"><img id="div6_switch" class="closeEl" src="/nresources/<%=cssPath%>/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
	                            <DIV><img class="hideEl" src="/nresources/<%=cssPath%>/images/cha.gif"   style='cursor:hand' width="15" height="15"></DIV>
	                        </div>
	            		</div>
	            	</div>
	            	<div class="content">
	            	    <DIV class="itemContent" id="mydiv7">
	            			<DIV id="wait7"><img src="/nresources/<%=cssPath%>/images/blue-loading.gif"  width="32" height="32"></DIV>
	            		</DIV>
	            	</div>
	            </div>
	        </div> 
		 </div>

<%
System.out.println("----------hejwa1---11--------phone_no----------------------"+phone_no);
%>		 
    <iframe id="maingetAlert" src="" style="display: none"></iframe>
    
</div>

<script>
    var _jspPage = {
	"div1_switch":["mydiv1","fserviceMsg.jsp?activePhone="+$("#phone_no_source").val(),"f"]
	,"div2_switch":["mydiv2","fsource_sel.jsp?activePhone="+$("#phone_no_source").val(),"f"]
	,"div3_switch":["mydiv3","fserviceMsg1.jsp?activePhone="+$("#phone_no_source").val(),"f"]
		,"div4_switch":["mydiv4","fserviceMsg2.jsp?activePhone="+$("#phone_no_source").val(),"f"]
		,"div5_switch":["mydiv6","fserviceMsg4.jsp?activePhone="+$("#phone_no_source").val(),"f"]
		,"div6_switch":["mydiv7","fserviceMsg6.jsp?activePhone="+$("#phone_no_source").val(),"f"]
	};
	
	var toggleContent = function(e)
    {
    	var targetContent = $('DIV.itemContent', this.parentNode.parentNode.parentNode.parentNode.parentNode);
    	if (targetContent.css('display') == 'none') {
    		targetContent.slideDown(300);
    		$(this).attr({ src: "../../../nresources/<%=cssPath%>/images/jian.gif"}); 
    		//调用服务
    		try{
    			var tmp = $(this).attr('id');
    			var tmp2 = eval("_jspPage."+tmp);
    			//alert(tmp2[2]);
    			if(tmp2[2]=="f"&&tmp2[1]!=''&&tmp2[1]!=undefined)
    			{
    				$("#"+tmp2[0]).load(tmp2[1]);
    				tmp2[2]="t";
    			}
    		}catch(e)
    		{
    		}
    		
    	} else {
    		targetContent.slideUp(300);
    		$(this).attr({ src: "../../../nresources/<%=cssPath%>/images/jia.gif"}); 
    	}
    	return false;
    };
	
	var hideContent = function(e)
    {
    	var targetContent = $(this.parentNode.parentNode.parentNode.parentNode.parentNode);
    	targetContent.hide();
    	
    	var div_id = $(this.parentNode.parentNode.parentNode.parentNode.parentNode).attr('id');
    	
    	if(div_id=="div1_show")
    	{
    		$("#div1").attr({checked:false});
    	}
    	else if(div_id=="div2_show")
    	{
    		$("#div2").attr({checked:false});
    	}else if(div_id=="div3_show")
    	{
    		$("#div3").attr({checked:false});
    	}
    	
    		
    };
	
	function reloadPhoneNo(phone_no){
	    var vPhoneNo = phone_no;
	    $("#phone_no_source").val(vPhoneNo);
	    $("#mydiv1").slideUp(300);
	    $("#mydiv2").slideUp(300);
	    $("#mydiv3").slideUp(300);
	    $("#mydiv4").slideUp(300);
	    $("#mydiv6").slideUp(300);
	    $("#mydiv7").slideUp(300);
        $('img.closeEl').attr({ src: "../../../nresources/<%=cssPath%>/images/jia.gif"}); 
    		
	    _jspPage = {
        	"div1_switch":["mydiv1","fserviceMsg.jsp?activePhone="+$("#phone_no_source").val(),"f"]
        	,"div2_switch":["mydiv2","fsource_sel.jsp?activePhone="+$("#phone_no_source").val(),"f"]
        	,"div3_switch":["mydiv3","fserviceMsg1.jsp?activePhone="+$("#phone_no_source").val(),"f"]
        	,"div4_switch":["mydiv4","fserviceMsg2.jsp?activePhone="+$("#phone_no_source").val(),"f"]
        	,"div5_switch":["mydiv6","fserviceMsg4.jsp?activePhone="+$("#phone_no_source").val(),"f"]
        	,"div6_switch":["mydiv7","fserviceMsg6.jsp?activePhone="+$("#phone_no_source").val(),"f"]
    	};
	}
</script>
</body>
</html>
