<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ taglib uri="/WEB-INF/xsl.tld" prefix="xsl" %>
<%@ include file="/npage/common/qcommon/print_include.jsp"%>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>
<%
	long s33 =System.currentTimeMillis();
	String opName=WtcUtil.repNull(request.getParameter("opName"));
	String groupId = (String)session.getAttribute("groupId");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = orgCode.substring(0,2);
	
	opCode =WtcUtil.repNull(request.getParameter("opCode")); 
		activePhone = request.getParameter("activePhone");
	
	String region_flag="hlj";//区域标志
	String brandID  = "";
	
	//从购物车页面传入	
	String gCustId = "";
	
		String sql_select_bill = "select to_char(cust_id)  from dcustmsg where phone_no = :phnoesno";
		String srv_params_bill = "phnoesno=" + activePhone;
%>
	
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  
			retcode="retcodes1" retmsg="retmsgs1" outnum="2">
		<wtc:param value="<%=sql_select_bill%>"/>
		<wtc:param value="<%=srv_params_bill%>"/>
	</wtc:service>
	<wtc:array id="sgetcustidarray" scope="end" />
		
	<%
	if(sgetcustidarray.length>0) {
		gCustId=sgetcustidarray[0][0];
	}
else {
	%>
	 rdShowMessageDialog('此手机号在ductmsg中没有cust_id，请联系管理员！');
	 window.close();
	<%
	return;
	}
	

	String phoneNo  = activePhone;
	
	String broadPhone  = WtcUtil.repNull(request.getParameter("broadPhone"));
	String prtFlag  = WtcUtil.repNull(request.getParameter("prtFlag"));
	String offerSrvId  = WtcUtil.repNull(request.getParameter("offerSrvId"));
	String custLevelStar  = WtcUtil.repNull(request.getParameter("custLevelStar"));//客户等级
	String servId = offerSrvId;
	String getSmCodeSql="select b.band_id from product_offer_instance a,product_offer b where  a.offer_id = b.offer_id  and    b.offer_type = 10 and    sysdate between a.eff_date and a.exp_date and    a.serv_id ="+servId;
	System.out.println("getSmCodeSql|"+getSmCodeSql);
	String smCode="";

	%>
<wtc:pubselect name="sPubSelect"  retcode="retCodeNo" retmsg="retMsgNo" outnum="1">
 <wtc:sql><%=getSmCodeSql%>
 </wtc:sql>
 </wtc:pubselect>
<wtc:array id="retarr" scope="end"/>  
<% 
  if(retarr.length!=0){
  
  	smCode=retarr[0][0];
  }
 	String servBusiId = WtcUtil.repNull(request.getParameter("servBusiId"));	
  String custOrderId = WtcUtil.repNull(request.getParameter("custOrderId"));	  //客户订单号
  String orderArrayId = WtcUtil.repNull(request.getParameter("orderArrayId"));  //客户订单子项ID
  String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));    //客户订单编号
  String servOrderId = WtcUtil.repNull(request.getParameter("servOrderId"));		//服务订单ID
  String offerId = WtcUtil.repNull(request.getParameter("offerId"));
  String offerName = WtcUtil.repNull(request.getParameter("offerName"));    

  
	System.out.println("servBusiId==="+servBusiId);
	System.out.println("servOrderId==="+servOrderId);                   
	System.out.println("custOrderId==="+custOrderId);                   
	System.out.println("orderArrayId==="+orderArrayId);                   
	System.out.println("gCustId==="+gCustId);                   
	System.out.println("prtFlag==="+prtFlag);                   
	System.out.println("offerSrvId==="+offerSrvId);  
	System.out.println("custOrderNo==="+custOrderNo);      
	String getCardCodeSql="select card_code from dbvipadm.dGrpBigUserMsg where id_no ="+servId;
	System.out.println("getCardCodeSql|"+getSmCodeSql);
	String cardCode="";	    
%>
<wtc:pubselect name="sPubSelect"  retcode="retCodeNo" retmsg="retMsgNo" outnum="1">
 <wtc:sql><%=getCardCodeSql%>
 </wtc:sql>
 </wtc:pubselect>
<wtc:array id="retarr" scope="end"/>		
<%
	if(retarr.length!=0){
  		cardCode=retarr[0][0];
	}
String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
String current_time=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
%>
	
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept" />
	
<%
   String sqlstr="SELECT op_code,op_name,op_type,role_limit FROM PRODUCT_OFFER_SCENE_CFG where op_code='"+opCode+"'";
   String param="opCode="+opCode;
%>	
<wtc:service name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retCode="retC1"  retMsg="retM1" outnum="4" >
	<wtc:param value="<%=sqlstr%>"/>
</wtc:service>
<wtc:array id="resPosc" scope="end"/>
	
	
<%
 System.out.println("sqlstr==="+sqlstr);
 String sqlstr2="select count(1) from product_offer_instance a , serv b where a.serv_id = b.serv_id and b.acc_nbr = '"+phoneNo+"' and a.exp_date > sysdate and exists(select 1 from product_offer where a.offer_id = offer_id and offer_attr_type = 'Yn32')";
 System.out.println("sqlstr2==="+sqlstr2);
 int countqry=0;
%>
<wtc:service name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retCode="retC2"  retMsg="retM2" outnum="1" >
	<wtc:param value="<%=sqlstr2%>"/>
</wtc:service>
<wtc:array id="resquery" scope="end"/>
<%
if(resquery!=null&&resquery.length>0)
 {
   System.out.println("retC2==="+retC2);
   System.out.println("resquery[0][0]==="+resquery[0][0]);
   countqry=Integer.parseInt(resquery[0][0]);
 }
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
%>

<html>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/quickSearch.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/mztree/stTree.js"></script>
<script src="sortTable.js" type="text/javascript"></script>
<SCRIPT type=text/javascript>
var retResultStr2 = "";	
var offerInfoHash = new Object(); //销售品产品信息	
var AttributeHash = new Object(); //属性信息
var oldOfferAry = new Array();    //取消的销售品
var newOfferAry = new Array();    //新销售品信息
var showPageNum = 1;
var thePageNum = 1; 	            //当前页数
var currentOfferId = "";	        //销售品目录树展开的销售品ID
var CanOfferCancel = 0;		        //销售品是否可退订标识
var CanUndoOpe = 0;				        //撤消退订是否可操作标识
var CanOfferBook = 0;			        //销售品是否可订购标识
var MainOfferFlag=0;
var thisMonthOfferId = "<%=offerId%>";
var operateFlag = 1;	//业务类型
var arrClassValue = new Array();
var offerIdArr = new Array();      //销售品ID
var offerNameArr=new Array();     //销售品名称（打印用）
var offerEffectTime = new Array();
var offerExpireTime = new Array();
var xqdm = "";
var zdxq="";
var vpmnstr1="";
var thisMonthOfferIdArr=new Array();

//打印所使用变量
var pricesstr    = "";
var zhekosstr = "";

$(document).ready(function(){
	$("#addedProdTab").hide(); 
	$("#prodUnbookTab").hide();
	$("#userInfoDiv").hide();		
	$("#userHadDiv").hide();	
  $("#roleInfoP").hide();	
  $("#slTab").hide();	
	
  $("#qryOfferBtn").bind("click",qryMainOffer);

    //只准订购附加销售品
  	$("#qryOfferBtn").unbind();
		$("#qryOfferBtn").bind("click",qryAddOffer);
		//qryMainOfferRoleInfo();
    HoverLi(2,2);
    $("#tb_1").css("display","none");

		qryOfferInst();	//查询用户当前订购关系
		
	  setOfferType();
	  getCurrentOpeInfo();
	
	$("#showInfoDiv :checkbox").bind("click",showInfo);

	{
		$("#searchOfferConDiv").css("display","");		
	}
	
	//收起当前订购关系
	$("#userHadOfferTitDiv").toggle(
	  function(){
	    $("#userHadOfferTab").css("display","none");
	  },
	  function(){
	    $("#userHadOfferTab").css("display","");
	  }
	);
	//收起本次受理中的订购信息
	$("#addedOfferTitDiv").toggle(
	  function(){
	    $("#addedOfferDiv").css("display","none");
	    $("#offerUnbookDiv").height(355); 
	  },
	  function(){
	  	$("#addedOfferDiv").css("display","");
	  	$("#offerUnbookDiv").height(160); 
	  }
	);
	//收起本次受理中的退订信息
	$("#offerUnbookTitDiv").toggle(
	  function(){
	    $("#offerUnbookDiv").css("display","none");
	    $("#addedOfferDiv").height(355); 
	  },
	  function(){
	  	$("#offerUnbookDiv").css("display","");
	  	$("#addedOfferDiv").height(200); 
	  }
	);
	
	
	
	$("#userInfoChkBox").get(0).checked = true;
	$("#userHadChkBox").get(0).checked = true;
	 
	showInfo();


	var countBaseOffer = $("#userHadOfferTab tr").length;
  for(var iw=1;iw<countBaseOffer;iw++){
  	
		if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="基本"&&$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(4)").text()=="有效"){
  		thisMonthOfferId2 = $("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text();
  	}
	}
opADDanDel();

});	

function ajaxGetMsg1(){ //查黑白名单提示
	//alert("document.all.stPMid_no.value|"+document.all.stPMid_no.value);
	
	var packet = new AJAXPacket("ajaxRetMsgVpmn.jsp","请稍后...");
  		packet.data.add("phone_no" ,"<%=phoneNo%>");
  		packet.data.add("opCode" ,"<%=opCode%>");
  		packet.data.add("servId" ,document.all.stPMid_no.value);
			core.ajax.sendPacket(packet,doAjaxGetMsg1);	
}

function doAjaxGetMsg1(packet){
		    vpmnstr1 = packet.data.findValueByName("vpmnstr1");
}				

function ajaxGetMsg(){ //查黑白名单提示
	//alert("document.all.stPMid_no.value|"+document.all.stPMid_no.value);
	
	var packet = new AJAXPacket("ajaxRetMsg.jsp","请稍后...");
  		packet.data.add("phone_no" ,"<%=phoneNo%>");
  		packet.data.add("opCode" ,"<%=opCode%>");
  		packet.data.add("servId" ,document.all.stPMid_no.value);
			core.ajax.sendPacket(packet,doAjaxGetMsg);	
}

function doAjaxGetMsg(packet){
			var liststr = packet.data.findValueByName("liststr"); 
			var vpmnstr = packet.data.findValueByName("vpmnstr");
			vpmnstr1= packet.data.findValueByName("vpmnstr1");
			var vOfferAttrType = packet.data.findValueByName("vOfferAttrType"); 
			var vTwoPhoneFlag = packet.data.findValueByName("vTwoPhoneFlag"); 
			var vHighFlag = packet.data.findValueByName("vHighFlag"); 
			
			//alert("vOfferAttrType|"+vOfferAttrType+"\nvTwoPhoneFlag|"+vTwoPhoneFlag+"\nvHighFlag|"+vHighFlag);
			/*zhangyan 修改 
			if(vOfferAttrType == "Yns0"){
		    rdShowMessageDialog('提示: 请注意,该用户为商务公话用户！');
		  }
		  if(vTwoPhoneFlag == "Y"){
		    rdShowMessageDialog('提示: 请注意,该用户为一卡双号用户！');
		  }
		  if(vHighFlag == "Y"){
		    rdShowMessageDialog('提示: 请注意,该用户为中高端用户！');
		  }
			
			
			if(liststr!="") {
				rdShowMessageDialog(liststr);	
			}*/
}				
//简化get方法
function g(o)
{
	return document.getElementById(o);
}

function HoverLi(n,t){
	document.all.offerId.value="";
	for(var i=1;i<=t;i++)
	{
		g('tb_'+i).className='normaltab';
		g('tb_'+i).checked=false;
	}
	
	g('tb_'+n).className='current';
	g('tb_'+n).checked=true;

	if(n == 1){
		$("#qryOfferBtn").unbind();
		$("#qryOfferBtn").bind("click",qryMainOffer);
		$("[name='searchType'][value='0']").attr("checked",true);	
		$("#offerType").parent().show();	
		$("#bindId").parent().show();	
		$("#custType").parent().show();	
		$("#roleInfoP").hide();
		operateFlag = 1;
	}else if(n == 2){

		$("#qryOfferBtn").unbind();
		$("#qryOfferBtn").bind("click",qryAddOffer);
		$("#offerListDiv").empty();	//清空可选销售品展示区
		$("#offerType").parent().hide();	//隐藏查询类型
		$("#bindId").parent().hide();	//隐藏业务品牌
		$("#custType").parent().hide();	//隐藏客户类型
		$("#roleInfoP").show();
		operateFlag = 2;
	}else	if(n == 3){	
										
	}
}	

function setOfferType(){

			var packet = new AJAXPacket("ajax_getOfferType.jsp","请稍后...");
  		packet.data.add("phoneNo" ,"<%=phoneNo%>");
			packet.data.add("iQryType" ,"0");
			core.ajax.sendPacket(packet,dosetOfferType);	
		}	
function 	dosetOfferType(packet){
			var retCode = packet.data.findValueByName("errorCode"); 
			var retMsg = packet.data.findValueByName("errorMsg"); 
			var retResult = packet.data.findValueByName("retResult"); 

 if(retCode == "000000"){
 			var selectObj = document.getElementById("offerType");
		  selectObj.length=0;
				for(var i=0;i<retResult.length;i++){
				var reg = /\s/g;     
   			var ss = retResult[i][0].replace(reg,""); 
   			//alert(ss.length);
					if(ss.length!=0){
						selectObj.options.add(new Option(retResult[i][1],retResult[i][0]));
					}
				}
	
	/*zhangyan add*/
	var bindId = document.getElementById("bindId");
	}else{
		rdShowMessageDialog(retCode + ":" + retMsg,0);
		return false;
	}



}

//------查询用户当前订购关系---------
function qryOfferInst(){
	var packet = new AJAXPacket("qryOfferInst.jsp","请稍后...");
	packet.data.add("phoneNo","<%=phoneNo%>");
	core.ajax.sendPacketHtml(packet,doQryOfferInst);
	packet =null;
}
function doQryOfferInst(data){
	//$("#userHadOfferDiv").html("");
	$("#userHadOfferDiv").html(data);
	$("[name='cancelBtn']").bind("click",cancelOffer);	
}

//-------已有订购关系退订-------------
function cancelOffer(){

		if(document.getElementsByName("opFlag")[0].checked) {
		return false;
		}
	CanOfferCancel = 0;
	var offerId = this.id.split("|")[0];
	var optypes = this.id.split("|")[1];	

	var packet = new AJAXPacket("cancelOffer.jsp","请稍后...");
	packet.data.add("offerId",offerId);
	packet.data.add("phoneNo","<%=phoneNo%>");
	packet.data.add("optypes",optypes);
	core.ajax.sendPacket(packet,doCancelOffer);
	packet =null;
}
function doCancelOffer(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");
	if(errorCode == 0){
		//rdShowMessageDialog("退订成功!");
		//getCurrentOpeInfo();
		
			var retAry = packet.data.findValueByName("retAry");
		//$("#addedOfferTab tr:gt(1)").remove();
		$("#addedProdTab tr:gt(1)").remove();
		$("#addedProdTab").hide();
		$("#offerUnbookTab tr:gt(1)").remove();
		$("#prodUnbookTab tr:gt(1)").remove();
		$("#prodUnbookTab").hide();
		var unsubscriptArr = new Array();
		//alert(retAry.length)
		$.each(retAry,function(i,n){
			var offer_id = n[1];
				unsubscriptArr.push(offer_id);
			
		});

		$.each(retAry,function(i,n){
			var buttonStr = "";

			var offer_id = n[0];
			var offer_name = n[1];
			var offer_comment = n[2];
			var offer_types = n[3];
			var effTime = n[4];
			var expTime = n[5];
			var isdeleflag = n[6];
			var timeflag = n[7];
			//alert(offer_id+"----"+offer_name+"----"+offer_comment+"----"+offer_types+"----"+effTime+"----"+expTime+"----"+isdeleflag+"----"+timeflag);
			
			var saddflags="true";
			 $("#addedOfferTab tr").each(function(){ 
			var priceTd=$("td:eq(1)",$(this) );//优惠金额 
			if(priceTd.text()==offer_id)  {
			saddflags="false";
			return false;
			}
			});
			
				if(saddflags=="false") {
						return false;
				}

					 //buttonStr+="<div id='basicInfo_"+offer_id+"' name='"+effTime+"|"+expTime+"|"+offerInstId+"' class='but_set'><span>基本信息</span></div>";	

						 document.all.offerId40Hv.value += offer_id+"|";
						 document.all.offerName40Hv.value += offer_name+"|";
						 document.all.offerEffDateCanHv.value+=effTime+"|";
						 document.all.offerTim40Hv.value += effTime+"|";
						 document.all.offerTim40EffHv.value += expTime+"|";
						 					
					document.all.offerIDhitHv.value+=offer_id+"~";
					
					if(isdeleflag=="B") {
					$("#addedOfferTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name='' ><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td title="+offer_comment+">"+offer_id+"</td><td title="+offer_comment+">"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,9)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,9)+"</td><td><img src='/nresources/default/images/task-item-close1.gif' style='cursor:Pointer;' class='del_cls' name='"+offer_id+"' alt='删除选择的销售品' id='del_"+offer_id+"'></td><td style='display:none'><input type='hidden' name='offerIdArrss' value='"+offer_id+"' /><input type='hidden' name='offerNameArrss' value='"+offer_name+"'/><input type='hidden' name='offerEffectTimess' value='"+effTime+"'/><input type='hidden' name='offerExpireTimess' value='"+expTime+"'/><input type='hidden' name='isdeleflagss' value='"+isdeleflag+"'/><input type='hidden' name='timeflagss' value='"+timeflag+"'/><input type='hidden' name='offer_typesss' value='"+offer_types+"'/></td></tr>");
					}else {
					$("#addedOfferTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name='' ><td></td><td title="+offer_comment+">"+offer_id+"</td><td title="+offer_comment+">"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,9)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,9)+"</td><td>&nbsp;</td><td style='display:none'><input type='hidden' name='offerIdArrss' value='"+offer_id+"' /><input type='hidden' name='offerNameArrss' value='"+offer_name+"'/><input type='hidden' name='offerEffectTimess' value='"+effTime+"'/><input type='hidden' name='offerExpireTimess' value='"+expTime+"'/><input type='hidden' name='isdeleflagss' value='"+isdeleflag+"'/><input type='hidden' name='timeflagss' value='"+timeflag+"'/><input type='hidden' name='offer_typesss' value='"+offer_types+"'/></td></tr>");
					}
																																																																																																																																																																			
					
				$("#addedOfferTab .del_cls").bind("click",cancelOrder);	
				$("#tr_"+offer_id+" td:lt(5)").toggle(
				  function (){
				    $(this).parent().next().css("display","");
				  },
				  function (){
				    $(this).parent().next().css("display","none");
				  }
				);
					
			
		
		});
		
		
		
	}else{
		rdShowMessageDialog(errorMsg);
		return false;	
	}
}

//------------撤销本次退订-------------
function undoCancel(){
	var offerId = this.name.split("|")[0];
	var offerInstId = this.name.split("|")[1];	
	var packet = new AJAXPacket("undoCancel.jsp","请稍后...");
	packet.data.add("loginAccept","<%=loginAccept%>");
	packet.data.add("offerId",offerId);
	packet.data.add("offerInstId",offerInstId);
	packet.data.add("servId","<%=servId%>");
	packet.data.add("phoneNo","<%=phoneNo%>");
	packet.data.add("opCode","<%=opCode%>");
	core.ajax.sendPacket(packet,doUndoCancel);
	packet =null;	
}
function doUndoCancel(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");
	if(errorCode == 0){
		getCurrentOpeInfo();
	}else{
		rdShowMessageDialog(errorMsg);
		return false;	
	}
}

//------------撤销本次订购-------------
function cancelOrder(){
	var offerId = this.name.split("|")[0];
	
			var deltrflag="";
			$("#addedOfferTab tr").each(function(i){ 			
			if(offerId==$(this).find("td:eq(6) input:eq(0)").val()) {
					deltrflag = $(this).find("td:eq(6) input:eq(5)").val();				
			}
			
			});
						$("#addedOfferTab tr").each(function(i){ 			
			
					if(deltrflag == $(this).find("td:eq(6) input:eq(5)").val())	{
						$(this).remove();
					}			
			
			
			});
	
}
function doUndoOrder(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");
	if(errorCode == 0){
		getCurrentOpeInfo();
	}else{
		rdShowMessageDialog(errorMsg);
		return false;	
	}
}
//----------基本销售品信息检索--------
function qryMainOffer(){
	var offerType = $("#offerType").val();
	var offerId = $("#offerId").val();
	var offerName = $("#offerName").val();
	var bindId = $("#bindId").val();

	var custType="";

	var packet = new AJAXPacket("qryMainOffer.jsp","请稍后...");
	packet.data.add("servId","<%=offerSrvId%>");
	packet.data.add("offerId",offerId);
	packet.data.add("relMainOfferId",thisMonthOfferId);	//thisMonthOfferId在qryOfferInst.jsp中生成
	packet.data.add("offerType",offerType);
	packet.data.add("offerName",offerName);
	packet.data.add("bindId",bindId); 
	packet.data.add("custType",custType);
	packet.data.add("opCode","<%=opCode%>");
	core.ajax.sendPacket(packet,doQryMainOffer);
	packet =null;	
}
function doQryMainOffer(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");	
	if(errorCode == 0){
		var retAry = packet.data.findValueByName("retAry");
		initTab(retAry);
	}else{
		rdShowMessageDialog(errorMsg);
		return false;	
	}
}

//----------附加销售品信息检索--------
function qryAddOffer(){
	
	var offerIdsd = $("#offerId").val();	
 	var offerNamesd = $("#offerName").val();
	var offerType = $("#offerType").val();

		var packet = new AJAXPacket("qryAddOffer.jsp","请稍后...");
	packet.data.add("phoneNo" ,"<%=phoneNo%>");
	packet.data.add("offerId" ,offerIdsd);
	packet.data.add("offerName" ,offerNamesd);
	packet.data.add("iQryType","1");
	packet.data.add("offerType",offerType);
	core.ajax.sendPacket(packet,doQryAddOffer);
	packet =null;
	
}
function doQryAddOffer(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");	
	if(errorCode == 0){
		var retAry = packet.data.findValueByName("retAry");
		initTab(retAry);
	}else{
		//rdShowMessageDialog(errorMsg);
		return false;	
	}
}

function doQryRealOfferId(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");	
	if(errorCode == 0){
		document.all.RealOfferId.value = packet.data.findValueByName("RealOfferId");
	}else{
		rdShowMessageDialog(errorMsg);
		return false;	
	}
}

//------------订购销售品-------------

var mf_Flag = "1"; //收藏夹的限制 标志
function qryMainOffer_m(offer_id){
	var offerType = "";
	var offerId = offer_id;
	var offerName = "";
	var bindId = "";
	
	var custType="";
	
	var packet = new AJAXPacket("qryMainOffer_m.jsp","请稍后...");
	packet.data.add("servId","<%=offerSrvId%>");
	packet.data.add("offerId",offerId);
	packet.data.add("relMainOfferId",thisMonthOfferId);	//thisMonthOfferId在qryOfferInst.jsp中生成
	packet.data.add("offerType",offerType);
	packet.data.add("offerName",offerName);
	packet.data.add("bindId",bindId); 
	packet.data.add("custType",custType);
	packet.data.add("opCode","<%=opCode%>");
	core.ajax.sendPacket(packet,doQryMainOfferM);
	packet =null;	
}
function doQryMainOfferM(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");	
	if(errorCode == 0){
		var retAry = packet.data.findValueByName("retAry");
		if(retAry.length==0){
			rdShowMessageDialog("此工号没有操作权限，请重新选择",0);
			mf_Flag = "0";
			return false;	
		}else{
			mf_Flag = "1";	
		}
	}else{
		rdShowMessageDialog(errorMsg);
		return false;	
	}
}

function qryAddOffer_m(offer_id){
	var roleId = "";
	var offerId = offer_id;
	var offerName = "";
 
	var packet = new AJAXPacket("qryRealOfferId.jsp","请稍后...");
	packet.data.add("loginAccept","<%=loginAccept%>");
	packet.data.add("opCode","<%=opCode%>");
	core.ajax.sendPacket(packet,doQryRealOfferId);
	packet =null;	
	
	var relMainOfferId="";
	if(document.all.RealOfferId.value=="0"){
		 relMainOfferId= thisMonthOfferId;		//默认为当月基本销售品
	}else{
	   relMainOfferId= document.all.RealOfferId.value;
   }
	
 
	
	var packet = new AJAXPacket("qryAddOffer_m.jsp","请稍后...");
	packet.data.add("servId","<%=servId%>");
	packet.data.add("relMainOfferId",relMainOfferId);
	packet.data.add("offerId",offerId);
	packet.data.add("roleId",roleId);
	packet.data.add("offerName",offerName);
	packet.data.add("opCode","<%=opCode%>");
	core.ajax.sendPacket(packet,doQryAddOffer_m);
	packet =null;	
}
function doQryAddOffer_m(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");	
	if(errorCode == 0){
		var retAry = packet.data.findValueByName("retAry");
		if(retAry.length==0){
			rdShowMessageDialog("此工号没有操作权限，请重新选择",0);
			mf_Flag = "0";
			return false;	
		}else{
			mf_Flag = "1";
		}
	}else{
		return false;	
	}
}

function addOffer_m(offer_id){
	
	/**新增 点收藏夹的限制*/
	if(operateFlag == 1){
		qryMainOffer_m(offer_id);
	}else{
		qryAddOffer_m(offer_id);
	}
	
	if(mf_Flag == "0"){
		return false;	
	}
	
	var packet = new AJAXPacket("applyMainOffer.jsp","请稍后...");
	packet.data.add("loginAccept","<%=loginAccept%>");
	packet.data.add("offerId",offer_id);
	packet.data.add("servId","<%=servId%>");
	packet.data.add("phoneNo","<%=phoneNo%>");
	packet.data.add("opCode","<%=opCode%>");
	core.ajax.sendPacket(packet,doApplyMainOffer_m);
	packet =null;	
}

function doApplyMainOffer_m(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");
	if(errorCode == 0){
		getCurrentOpeInfo();
	}else{
		rdShowMessageDialog(errorMsg);
		return false;	
	}
}


function addOffer(offer_id){
	//alert("--");
     var packet = new AJAXPacket("applyMainOffer.jsp","请稍后...");
  	packet.data.add("offerId",offer_id);
  	packet.data.add("phoneNo","<%=phoneNo%>");
  	core.ajax.sendPacket(packet,doApplyMainOffer);
  	packet =null;

}

function doApplyMainOffer(packet){

	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");
	var squeryofferId = packet.data.findValueByName("squeryofferId");

	if(errorCode == "000000"){
		getCurrentOpeInfo(squeryofferId);
	}else{
		rdShowMessageDialog(errorMsg);
		return false;	
	}
}



//-------------------提取订购/退订信息--------------------
function getCurrentOpeInfo(squeryofferId){
	if(squeryofferId!=undefined) {
				var offeridstr2="";
			var statustr2="";
			var typestr2="";
			
				$("#addedOfferTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(6) input:eq(0)").val()==undefined) {
					 return true;
					 }
					 if($(this).find("td:eq(6) input:eq(0)").val()=="") {
					 return true;
					 }
						offeridstr2+=$(this).find("td:eq(6) input:eq(0)").val()+"#"
						statustr2+="N#";		
						typestr2+=$(this).find("td:eq(6) input:eq(6)").val()+"#";
					
			});

	var packet = new AJAXPacket("applyMainOffer.jsp","请稍后...");
	packet.data.add("offerId",squeryofferId);
	packet.data.add("phoneNo","<%=phoneNo%>");
	packet.data.add("offeridstr2",offeridstr2);
	packet.data.add("statustr2",statustr2);
	packet.data.add("typestr2",typestr2);
	core.ajax.sendPacket(packet,doGetCurrentOpeInfo);
	packet =null;		
	}
}

function doGetCurrentOpeInfo(packet){
			 
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");
	//alert(errorCode);	
	if(errorCode == 000000){
		var retAry = packet.data.findValueByName("retAry");
		//$("#addedOfferTab tr:gt(1)").remove();
		$("#addedProdTab tr:gt(1)").remove();
		$("#addedProdTab").hide();
		$("#offerUnbookTab tr:gt(1)").remove();
		$("#prodUnbookTab tr:gt(1)").remove();
		$("#prodUnbookTab").hide();
		var unsubscriptArr = new Array();
		//alert(retAry.length)
		$.each(retAry,function(i,n){
			var offer_id = n[1];
				unsubscriptArr.push(offer_id);
			
		});

		$.each(retAry,function(i,n){
			var buttonStr = "";

			var offer_id = n[0];
			var offer_name = n[1];
			var offer_comment = n[2];
			var offer_types = n[3];
			var effTime = n[4];
			var expTime = n[5];
			var isdeleflag = n[6];
			var timeflag = n[7];
			//alert(offer_id+"----"+offer_name+"----"+offer_comment+"----"+offer_types+"----"+effTime+"----"+expTime+"----"+isdeleflag+"----"+timeflag);
			
			var saddflags="true";
			 $("#addedOfferTab tr").each(function(){ 
			var priceTd=$("td:eq(1)",$(this) );//优惠金额 
			if(priceTd.text()==offer_id)  {
			saddflags="false";
			return false;
			}
			});
			
				if(saddflags=="false") {
						return false;
				}

					 //buttonStr+="<div id='basicInfo_"+offer_id+"' name='"+effTime+"|"+expTime+"|"+offerInstId+"' class='but_set'><span>基本信息</span></div>";	

						 document.all.offerId40Hv.value += offer_id+"|";
						 document.all.offerName40Hv.value += offer_name+"|";
						 document.all.offerEffDateCanHv.value+=effTime+"|";
						 document.all.offerTim40Hv.value += effTime+"|";
						 document.all.offerTim40EffHv.value += expTime+"|";
						 
					
					
					document.all.offerIDhitHv.value+=offer_id+"~";
					
					if(isdeleflag=="B") {
					$("#addedOfferTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name='' ><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td title="+offer_comment+">"+offer_id+"</td><td title="+offer_comment+">"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,9)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,9)+"</td><td><img src='/nresources/default/images/task-item-close1.gif' style='cursor:Pointer;' class='del_cls' name='"+offer_id+"' alt='删除选择的销售品' id='del_"+offer_id+"'></td><td style='display:none'><input type='hidden' name='offerIdArrss' value='"+offer_id+"' /><input type='hidden' name='offerNameArrss' value='"+offer_name+"'/><input type='hidden' name='offerEffectTimess' value='"+effTime+"'/><input type='hidden' name='offerExpireTimess' value='"+expTime+"'/><input type='hidden' name='isdeleflagss' value='"+isdeleflag+"'/><input type='hidden' name='timeflagss' value='"+timeflag+"'/><input type='hidden' name='offer_typesss' value='"+offer_types+"'/></td></tr>");
					}else {
					$("#addedOfferTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name='' ><td></td><td title="+offer_comment+">"+offer_id+"</td><td title="+offer_comment+">"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,9)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,9)+"</td><td>&nbsp;</td><td style='display:none'><input type='hidden' name='offerIdArrss' value='"+offer_id+"' /><input type='hidden' name='offerNameArrss' value='"+offer_name+"'/><input type='hidden' name='offerEffectTimess' value='"+effTime+"'/><input type='hidden' name='offerExpireTimess' value='"+expTime+"'/><input type='hidden' name='isdeleflagss' value='"+isdeleflag+"'/><input type='hidden' name='timeflagss' value='"+timeflag+"'/><input type='hidden' name='offer_typesss' value='"+offer_types+"'/></td></tr>");
					}
																																																																																																																																																																			
					

				$("#addedOfferTab .del_cls").bind("click",cancelOrder);	
				$("#tr_"+offer_id+" td:lt(5)").toggle(
				  function (){
				    $(this).parent().next().css("display","");
				  },
				  function (){
				    $(this).parent().next().css("display","none");
				  }
				);
					
			
		
		});
	}else{
		rdShowMessageDialog(errorMsg);
		return false;	
	}
	if(MainOfferFlag==1){	 
	   qryMainOfferRoleInfo();
  }
}

function findStrInArr(str1,arrObj){
	var reFlag = false;
	$.each(arrObj,function(i,n){
		if(n == str1){
			reFlag = true;
		}
	});
	return reFlag;
}




function showAttribute(){
	var queryType = this.name.substring(0,4);
	var queryId = this.id.substring(4);
	var offerName = this.name.substring(4);
	var effT = this.effT;
	var offerInstId = this._offerInstId;
	var offid=this.offid;
	var h=600;
	var w=800;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; scroll:no; resizable:no;location:no;status:no;help:no";
	  
	  if(v_hiddenFlag=="Y"){ //当为Y时，进入新版小区代码展示页面
	    var ret=window.showModalDialog("showAttrNew.jsp?queryId="+queryId+"&offerInstId="+offerInstId+"&queryType="+queryType+"&loginAccept=<%=loginAccept%>&servId=<%=servId%>&opCode=<%=opCode%>&opName=<%=opName%>&effT="+effT+"&v_code="+v_code+"&v_text="+v_text,window,prop);
	  }else{
	    if("<%=region_flag%>"=="sx"&&queryId=="9001"){
			var ret=window.showModalDialog("/npage/s1104/addGroupInfo.jsp?queryId="+queryId+"$","",prop);
  		}else{
  			var ret=window.showModalDialog("showAttr.jsp?queryId="+queryId+"&offerInstId="+offerInstId+"&queryType="+queryType+"&loginAccept=<%=loginAccept%>&servId=<%=servId%>&opCode=<%=opCode%>&opName=<%=opName%>&effT="+effT+"&v_code="+v_code+"&v_text="+v_text,window,prop);
  		}
	  }
		
		if(typeof(ret) != "undefined"){
				if(ret.split("$")[1].length == 1){
					rdShowMessageDialog("未设置属性！");	
					document.all.attrFlagHv.value=offid;
					return false;
				}
				document.all.attrFlagHv.value="0";
				$(this).attr("class","but_property_on");
				var attrAry = ret.split("$");	
				for(var i=0;i<attrAry.length;i++){
					var attrAry1= attrAry[i].split("~");	
					var attrId = attrAry1[0];
					var attrValue = attrAry1[1];
					if(attrId=="60001")
					{
						xqdm=attrValue.replace("$","").trim();
					}
					if(attrId=="5100")
					{
						zdxq=attrValue.replace("$","").trim();
					}
				}
				AttributeHash[queryId]=ret;	//将返回的群组信息对应queryId放入
			}	
			else{
				document.all.attrFlagHv.value=offid;
				rdShowMessageDialog("未设置属性！");	
				return false;
			}	
	 
}


//生成销售品列表
function initTab(retAry){

	$("#offerListDiv table").remove();

		$("#offerListDiv").append("<table id='offerListTab'><thead><tr style='cursor:hand'><th >销售品ID</th><th >销售品名称</th><th>订购&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;详情<th></tr></thead></table>");

	for(var i=0 ; i<retAry.length; i++){
		var offer_id = retAry[i][0];
		var offer_name = retAry[i][1];
		var offerconent = retAry[i][2];
		
		var offerIds=offer_id+"|";
		var divOfferIds= "coltr_"+offer_id+"|";

		  	$("#offerListTab").append("<tr><td>"+offer_id+"</td><td  id='coltr_"+offer_id+"'>"+offer_name+"</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src='/nresources/default/images/ab1.gif' style='cursor:hand' alt='订购' id='col_"+offer_id+"' onClick='addOffer("+offer_id+")' />&nbsp;&nbsp;&nbsp;</span><img src='/nresources/default/images/child.gif' style='cursor:hand' name='' alt='"+offerconent+"' id='detail_"+offer_id+"' ></td></tr>");
		

	}
	btcGetMidPrompt("10442",offerIds,divOfferIds);
}



//----------------快速检索---------------------------
function searchOffer(){
	var array1 = document.getElementById('searchOfferText').value.split(' ');
	$("#offerListTab tr:gt(0)").find("td:eq(1)").each(function(i,n){
		var array = makePy($(n).text());
		var temp = "";
		for(var j = 0; j < array.length; j ++)
		{
			temp += array[j];
		}
		var flag = false;
		for(var k = 0; k < array1.length; k++)
		{	
			flag = (temp.indexOf(array1[k].toUpperCase()) != -1)? true:false;	
			if(flag == false)
				break;
		}

		if(flag == true){
			$(n).parent().show();
		}else{
			$(n).parent().hide();
		}
	});
}


function qryProdAttr(){

			var offeridstr="";
			var statustr="";
			var typestr="";

						$("#addedOfferTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(6) input:eq(0)").val()==undefined) {
					 return true;
					 }
						offeridstr+=$(this).find("td:eq(6) input:eq(0)").val()+"#"
							if (document.getElementsByName("opFlag")[0].checked) {
						statustr+="N#";	
						}else {
						statustr+="Y#";	
						}	
						typestr+=$(this).find("td:eq(6) input:eq(6)").val()+"#";
					
			});
			
			if(offeridstr=="") {
					rdShowMessageDialog("受理列表为空，请选择订购或者退订操作！");
					return false;
			}
			
			document.all.offerstrbuffer.value=offeridstr;
			document.all.statusbuffer.value=statustr;
			document.all.typebuffer.value=typestr;

		var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
	if(rdShowConfirmDialog("请确认是否进行<%=opName%>？")==1)
	{	
		document.offerChoiceFrm.action="fg538Cfm.jsp";
		document.offerChoiceFrm.submit();
	}
}

   function checksmz()
  {

  var myPacket = new AJAXPacket("/npage/bill/checkSMZ.jsp","正在查询客户是否是实名制客户，请稍候......");
	myPacket.data.add("PhoneNo","<%=phoneNo%>");
	core.ajax.sendPacket(myPacket,checkSMZValue);
	myPacket=null;
  }
  function checkSMZValue(packet) {
      document.all.smzvalue.value="";
			var smzvalue = packet.data.findValueByName("smzvalue");
      document.all.smzvalue.value=smzvalue;
}



function clearInfo(){
	$("#offerListDiv table").remove();
	$("#offerId").val("");	
	$("#offerName").val("");	
}

//---------向左收起销售品检索区------
function toLeft(){
	if($("#LRImg").attr("name") == "left"){
		$('#left').animate({'marginLeft': "-395px"},'slow');
		$("#LRImg").attr({src:"/nresources/default/images/arrow_left.gif",name:"right"});
		$("#right").removeClass();
		$("#leftSpan").attr("class","item-50 col-1");
	}else{
		$('#left').animate({'marginLeft': "0px"},'slow',function(){$("#right").addClass("item-col col-2");$("#leftSpan").attr("class","item-col2 col-1");});
		$("#LRImg").attr({src:"/nresources/default/images/arrow_right.gif",name:"left"});
	}	
}


var retResultStr = "";
var descResultStr = "";
var retResultStr1 = "";
function showPrtDlg(printType,DlgMessage,submitCfm)
{  
	pricesstr="";
	zhekosstr="";
	
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var sysAccept = "<%=loginAccept%>";
	var phone_no = "<%=phoneNo%>";
	var offerIDhitJv =  document.all.offerIDhitHv.value;
	if(offerIDhitJv.indexOf("~")!=-1) offerIDhitJv = offerIDhitJv.substring(0,offerIDhitJv.length-1);
	var mode_code =offerIDhitJv;
	var fav_code = null;
	var area_code = null;
	var printStr = printInfo(printType);
	/*ningtn huangrong 注释：关于实施全业务电子工单化的需求，改功能不需要录入身份证信息*/
	//var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
	//var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
	/* ningtn */
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	
	return ret;
}
//查询打印所需要的数据
function queryPrintInfo(offerid){

							var packet = new AJAXPacket("qryPrice.jsp","请稍后...");
							packet.data.add("offerId",offerid);
							packet.data.add("phoneNo","<%=phoneNo%>");
							core.ajax.sendPacket(packet,doQueryPrintInfo);
							packet =null;

		
}


function doQueryPrintInfo(packet){
	
	var errorCode = packet.data.findValueByName("errCode");
	var errorMsg  = packet.data.findValueByName("errMsg");	
	pricesstr  = packet.data.findValueByName("price");
	zhekosstr = packet.data.findValueByName("zheko");

	
}
function printInfo()
{	
    var retInfo = "";
		retInfo = printInfo1270();
    return retInfo;
}

function ajaxQueryPPf(offerIdVt){
	var packet = new AJAXPacket("ajaxQueryPPp.jsp","请稍后...");
			packet.data.add("offerIdVt",offerIdVt);
			packet.data.add("opCodev","<%=opCode%>");
			core.ajax.sendPacket(packet,doAjaxQueryPPf);
			packet = null;
	}
var band_id = "";
function doAjaxQueryPPf(packet){
	document.all.smCodeHv.value = packet.data.findValueByName("retResultStr");
	retResultStr2 = packet.data.findValueByName("retResultStr");
	band_id       = packet.data.findValueByName("band_id");
	}	
	
function ajaxGetEPf1(tempNote_info2v){
		var packet = new AJAXPacket("/npage/s1104/ajaxGetEPf.jsp","请稍后...");
		packet.data.add("tempNote_info2v",tempNote_info2v);
		packet.data.add("opCode","<%=opCode%>");
		core.ajax.sendPacket(packet,doAjaxGetEPf11);
		packet = null;
	}  
	
function doAjaxGetEPf11(packet){
		 retResultStr1 = packet.data.findValueByName("retResultStr");
	}


function ajaxGetEPf(offerIdv,offerId){
		var packet = new AJAXPacket("ajaxGetEPf.jsp","请稍后...");
		packet.data.add("offerIdv",offerIdv);
		packet.data.add("opCode","<%=opCode%>");
		packet.data.add("xqJf",offerId);
		core.ajax.sendPacket(packet,doAjaxGetEPf1);
		packet = null;
	}  
	
function doAjaxGetEPf1(packet){
	var  resultFlag= packet.data.findValueByName("resultFlag");
	if(resultFlag!="none"){
			 retResultStr = packet.data.findValueByName("retResultStr");
			 descResultStr = packet.data.findValueByName("descResultStr"); 
			 document.all.newZOfferECode.value = packet.data.findValueByName("newZOfferECode");
			 document.all.newZOfferDesc.value = packet.data.findValueByName("newZOfferDesc"); 
			 document.all.dOfferId.value = packet.data.findValueByName("dOfferId"); 
			 document.all.dOfferName.value = packet.data.findValueByName("dOfferName"); 
			 document.all.dECode.value = packet.data.findValueByName("dECode"); 
			 document.all.dOfferDesc.value = packet.data.findValueByName("dOfferDesc"); 
	}
}
	<%
	long s2a =System.currentTimeMillis();
	%>
	
/* 关于铁通78位TD无线座机用户限制发送短信功能的需求 */
<%
	String tdSql = "SELECT msg.class_code FROM dchngroupmsg msg WHERE msg.GROUP_ID = '" + groupId + "'";
	String inputParam = "214";
%>
 		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msgtd" retcode="codetd" 
 		 routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=tdSql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="tdresult" scope="end"/>
<%
	if(codetd.equals("000000")){
		if(tdresult != null && tdresult.length > 0){
			if(tdresult[0][0].equals("200") ){
				inputParam = "225";
			}
		}
	}
	if("e092".equals(opCode) || "e301".equals(opCode)){
		inputParam = "227";
	}
	System.out.println("zhangyan==== qp01Main.jsp ===inputParam " + inputParam);
%>
	
	<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
	  <wtc:param value="<%=inputParam%>"/>
	</wtc:service>
	<wtc:array id="result_t1" scope="end"/>
	<%
	long s3a =System.currentTimeMillis();
  System.out.println("mylog  执行服务 sDynSqlCfm  的时间 = 【"+(s3a-s2a)+"】");
	%>
function 	addSmCode(){
	var selectObj = document.getElementById("bindId");
	selectObj.length=0;
	
	<%
	  for(int iii=0;iii<result_t1.length;iii++){
	  		String temp1 = result_t1[iii][0];
	  		String temp2 = result_t1[iii][1];
	  		if(smCode.equals(temp1)){
	  			;
	  		}
	%>
		selectObj.options.add(new Option("<%=temp1%>--><%=temp2%>","<%=temp1%>"));
	<%			
		}
	%>	
<%
	/*zhangyan 修改*/
	if(opCode.equals("1253"))
	{
	%>	
		selectObj.value="24";
	<%
	}
	else if ( opCode.equals("1270") )
	{
	%>	
		selectObj.value="21";
	<%	
	}
	else
	{
	%>
		selectObj.value="<%=smCode%>";
	<%
	}
	%>
}	

function myFavorite(){
			var packet = new AJAXPacket("/npage/portal/shoppingCar/ajax_getMfOffer.jsp","请稍后...");
			core.ajax.sendPacket(packet,doMyFavorite,true);
			packet =null;	
}

function doMyFavorite(packet){
			var qryRetCode = packet.data.findValueByName("retCode"); 
	    var qryRetMsg = packet.data.findValueByName("retMsg"); 
	    var retResult = packet.data.findValueByName("retResult");
	    var myFavoObj = document.all.myFavoriDiv;
	    var innerHTMLStr = "<table id=\"myFavoriteListT\" cellspacing=0><tr><td class='blue'>销售品代码</td><td class='blue'>销售品名称</td><td class='blue'>销售品描述</td></tr>";
	    for(var i=0;i<=retResult.length-1;i++){
	    	if(retResult[i][2].length>20) retResult[i][2] = retResult[i][2].substring(0,20)+"...";
	    	innerHTMLStr +="<tr onclick=\"addOffer_m('"+retResult[i][0]+"')\" style=\"cursor:pointer\" ><td>"+retResult[i][0]+"</td><td>"+retResult[i][1]+"</td><td>"+retResult[i][2]+"</td></tr>";
	    }
	    innerHTMLStr += "</table>";
	    myFavoObj.innerHTML = innerHTMLStr;
}

function hotOffer(){
		var packet = new AJAXPacket("/npage/portal/shoppingCar/ajax_getHotOffer.jsp","请稍后...");
		packet.data.add("groupId" ,"<%=groupId%>");
		core.ajax.sendPacket(packet,doHotOffer,true);
		packet =null;
}		

function doHotOffer(packet){
	var qryRetCode = packet.data.findValueByName("retCode"); 
	var qryRetMsg = packet.data.findValueByName("retMsg"); 
	var retResult = packet.data.findValueByName("retResult");
	var innerHTMLStr = "<table id=\"queryhotOfferList\" cellspacing=0>"+
										"<tr>"+
											"<td class='blue'>销售品代码</td>"+
											"<td class='blue'>销售品名称</td>"+
											"<td class='blue'>销售品描述</td>"+
										"</tr>";
								
			var hotOfferObj = document.all.hotOfferDiv;
	    for(var i=0;i<=retResult.length-1;i++){
	    	if(retResult[i][2].length>21) retResult[i][2] = retResult[i][2].substring(0,20)+"...";
	    	innerHTMLStr +="<tr onclick=\"addOffer_m('"+retResult[i][0]+"')\" style=\"cursor:pointer\" ><td>"+retResult[i][0]+"</td><td>"+retResult[i][1]+"</td><td>"+retResult[i][2]+"</td></tr>";
	    }
	    innerHTMLStr += "</table>";
	    hotOfferObj.innerHTML = innerHTMLStr;
	    
}	

</SCRIPT>	
<style>
#rootTree{
	display:block;
	background-color: #FFFFFF;
	height:360px;
	FONT-WEIGHT: normal; 
	FONT-SIZE: 12px;
}
</style>	
<body>
<div id="operation">
<FORM name="offerChoiceFrm" action="" method=post>
<%@ include file="/npage/include/header.jsp" %>	
<div id="operation_table">	
	<!--div class="title"><div  class="text" >客户基本信息</div></div-->
 <div class="title">
  	<div id="title_zi">客户基本信息 </div>
  </div>
	<div id="custInfo">
		<div class="input">
   	<table cellspacing="0">
   		<tr>
   			<td class=blue>客户名称 </td>
   			<td>
   				<span style="cursor:pointer;color:#ff9900" onclick="window.showModalDialog('/npage/common/qcommon/bd_0001.jsp?gCustId=<%=gCustId%>&opName=客户详细信息','dialogHeight=700px','dialogWidth=650px','help=no','status=no')"><%=custName%></span>
   				<input type="hidden" name="custNameforsQ046" value="<%=custName%>">
   				<%
   				if(ba0002_black.equals("N"))
   				{
   					//out.println("(非黑名单)");
   				}else
   				{
   					out.println("(黑名单)");
				%>
					<script>
						rdShowMessageDialog("该客户属于黑名单客户");
					</script>
				<%
   				}
   				%>
   			</td>
   			<td  class=blue>民族</td>
   			<td><%=nationName%></td> 
   			<td  class=blue>联系人 </td>
   			<td><%=linkmanName%></td>
   		</tr>
   	  <tr>
   			<td  class=blue>客户级别 </td>
   			<td ><%=custLevel%></td> 
   	  	<td  class=blue>稽核状态</td>
   			<td><%=bd0002_status%></td>   
   	    <td  class=blue>归属渠道 </td>
   			<td><%=belongCity%></td>
   	  </tr>
   	  <%
   	    if(!"".equals(custLevelStar)){
   	  %>
   	      <tr>
   			    <td  class=blue>客户等级 </td>
   			    <td ><%=custLevelStar%></td> 
   	      </tr>
   	  <%
   	    }
   	  %>
   	  	<input type="hidden" name="idType_0002" value="<%=agent_idType%>"/>
   	  </tr>
	</table>
</div>
	</div>
	
	<div id="showInfoDiv">
		<div class="input">
				<table id="rentMac">
					<tr>
						<td class="blue">可定制信息：
						<input type="checkbox" name="" id="userInfoChkBox" value="0">用户基本信息 
						&nbsp;&nbsp;&nbsp;&nbsp;	
						<input type="checkbox" name="" id="userHadChkBox" value="1">销售品订购信息
						<%
						  if(opCode.equals("3257")&&(countqry>0)){
						%>
						  <input type="checkbox" name="" id="glbQryMem" value="2">全球通温馨家庭查询
						<%
						  }
						%>
					</tr>
				</table>	
		</div>
	</div>
	<div class="title">
  	<div id="title_zi">操作类型 </div>
  </div>
	<div id="custInfo">
		<div class="input">
   	<table cellspacing="0">
   		<tr>
   			<td >
   				<input type="radio" name="opFlag" value="0" onclick="opADDanDel()" checked>订购 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="opFlag" value="1" onclick="opADDanDel()" >退订
 
   				</td>
   			   				
   	  </tr>
	</table>
</div>
	</div>
	
	<div id="userInfoDiv">
		<div class="title"><div id="title_zi">用户基本信息 </div></div>
	 	<%@include file="PMUserBaseInfo.jsp"%>
	</div>
	
	<!--div class="title" id="userHadOfferTitDiv"><div class="text">当前订购关系</div></div-->
<div id="userHadDiv">
	<div class="title" id="userHadOfferTitDiv">
	  	<div id="title_zi" style="cursor:hand;">销售品订购信息</div>
	</div>	
		<div class="list" id="userHadOfferDiv">
		</div>		
</div>	
	
	
<div style="width:100%" id="show1270" style="display:none">
	<div style="">
		<div style="width:100%">
			<div class="product_chooseR" id="myFavoriteList" style="height:130px;float:left;width:50%; overflow-y:auto; overflow-x:hidden;">
				<div class="title"><div id="title_zi">我收藏的销售品列表</div></div>
						<div class="list" style="">
							<div id="myFavoriDiv"></div>
					  </div>
			 </div>
			<div class="product_chooseR" id="hotOfferQueryList" style="float:right;width:49%;">
				<div class="title"><div id="title_zi">热点销售品列表</div></div>
			
						<div class="list" style="height:130px; overflow-y:auto; overflow-x:hidden;">
							<div id="hotOfferDiv"></div>
					</div>
			</div>	
			
		</div>
	</div>
</div>	
	
	
	
	
	
	
	
<div id="items"> 
	
			<div class="item-row col-1" id="left">
				<div class="title" >
				  	  <div id="title_zi">销售品检索区</div><span style="float:right;padding: 3px 1px 0px 2px;"><img src='/nresources/default/images/arrow_right.gif' style='cursor:hand' name='left' alt='点击折叠销售品检索区' id='LRImg' onClick="toLeft()"></span>
				</div>				   
				  <div style="overflow-y:hidden;overflow-x:hidden; background-color: #F7F7F7;border-right: 1px solid #95CBDD;border-left: 1px solid #95CBDD;border-bottom: 1px solid #95CBDD;height:300px;FONT-WEIGHT: normal; FONT-SIZE: 13px;" class="list">
			
					<div id="formTab">	
						<ul>
						<li class="current" id="tb_1" onclick="HoverLi(1,2)"><a href="#">基本销售品</a></li>  
						<li id="tb_2"><a href="#" onclick="HoverLi(2,2)">附加销售品</a> </li>
					</ul>
				 </div>	

						<div id="searchOfferConDiv" style="display:none;border-right: 0px solid #95CBDD;border-left: 0px solid #95CBDD;border-bottom: 1px solid #95CBDD;height:300px;PADDING-LEFT: 20px; COLOR: #0256b8;FONT-WEIGHT: normal; FONT-SIZE: 12px;">
							<p> &nbsp;&nbsp;业务品牌:
								<select class="b_text" name="bindId" id="bindId"  onchange="setOfferType()">
									<option value="" selected>----请选择----</option>
								</select>
							</p>

							<p>&nbsp;&nbsp;销售品ID：<input type="text"  name="offerId" id="offerId" class="for0_9" ></p>
							<p>&nbsp;&nbsp;&nbsp;&nbsp;关键字：<input type="text"  name="offerName" id="offerName" ></p>
							<p id="roleInfoP">销售品分类：
																<select class="b_text" name="offerType" id="offerType">
									<option value="" selected>----请选择----</option>
								</select>
								</p>
							<p align="center">	
								<input type="button" class="b_text" value="检索" id="qryOfferBtn">

								<input type="button" class="b_text" value="清除" onclick="clearInfo()" />&nbsp;&nbsp;&nbsp;
							</p>
						</div>
					</div>
			</div>
			
	 <div class="item-col col-2" id="right" >
				<span class="item-col2 col-1" id="leftSpan" style="overflow-y:auto;overflow-x:hidden;background-color:#F7F7F7;height:327px;border-right: 1px solid #95CBDD;border-left: 1px solid #95CBDD;border-bottom: 1px solid #95CBDD;">
					<!--div class="title"><div class="text">查询列表</div></div-->				
				<div class="title" >
			  	<div id="title_zi">可选销售品展示区</div><span style="float:right;padding: 3px 1px 0px 2px;"><img src='/nresources/default/images/arrow_left.gif' style='cursor:hand' name='right' alt='点击折叠销售品检索区' id='LRImg' onClick="toLeft()"></span>
			  </div>

					
				 <div>
						<div  id="offerListDiv">
						</div>
					</div>
				</span>
				
		    <span class="item-col3 col-2" id="rightSpan">
					<!--div class="title" id="addedOfferTitDiv"><div class="text">本次受理【订购】</div></div-->			
			<div class="title" id="addedOfferTitDiv">
		  	<div id="title_zi" style="cursor:hand;"> <span class="addedOfferTitDivaaa">本次受理【订购】</span></div>
		  </div>
		  
		  
		  
		  
		  
				
					<div id="addedOfferDiv" class="list" style="overflow-x:auto;overflow-y:auto;height:300px;width:99%;border-width:1px;border-color:#add3d0;border-style:solid;background-color: #F7F7F7;" >
						<table id="addedOfferTab">
								<tr>
								<td colspan='6' class="blue"><b><销售品></b></td>
							</tr>
							<tr id="addedOfferHeadTr">
								<td class="blue">状态</td>
								<td class="blue">代码</td>
								<td class="blue">名称</td>
								<td class="blue">生效时间</td>
								<td class="blue">失效时间</td>
								<td class="blue">操作</td>
							</tr>
						</table>	
							
					</div>
					

					
				</span>
				
		</div>			
	</div><!--end items-->

</div>
<!--huangrong 注释：关于实施全业务电子工单化的需求，改功能不需要录入身份证信息 2011-8-4
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=loginAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>-->
<div id="operation_button">
	<div id="footer">
	<input class="b_foot" name=confirm id="confirm" type=button onClick="qryProdAttr()" value="确定" >
	<input class="b_foot" name=back onClick="removeCurrentTab()" type=button value="关闭">
</div>
</div>

<input type="hidden" name="offerstrbuffer" value=""/>
<input type="hidden" name="statusbuffer" value=""/>
<input type="hidden" name="typebuffer" value=""/>









<input type="hidden" name="chkFlag" value="0"/>
<input type="hidden" name="opCode" value="<%=opCode%>"/>
<input type="hidden" name="opName" value="<%=opName%>"/>
<input type="hidden" name="servBusId" value="" />
<input type="hidden" name="retMsg" value="" />
<input type="hidden" name="servId" value="<%=servId%>" />
<input type="hidden" name="loginAccept" value="<%=loginAccept%>" /> 
<input type="hidden" name="prtFlag" value="<%=prtFlag%>"/>
<input type="hidden" name="custOrderId" value="<%=custOrderId%>"/>
<input type="hidden" name="orderArrayId" value="<%=orderArrayId%>"/>
<input type="hidden" name="servOrderId" value="<%=servOrderId%>"/>
<input type="hidden" name="custOrderNo" value="<%=custOrderNo%>"/>
<input type="hidden" name="servBusiId" value="<%=servBusiId%>"/>
<input type="hidden" name="gCustId" value="<%=gCustId%>"/>
<input type="hidden" name="phoneNo" value="<%=phoneNo%>"/>
<input type="hidden" name="offerSrvId" value="<%=offerSrvId%>"/>

<input type="hidden" name="custName" value="<%=custName%>"/>
<input type="hidden" name="agent_idNo" value="<%=agent_idNo%>"/>
<input type="hidden" name="belongCity" value="<%=belongCity%>"/>

<input type="hidden" name="oldofferId" value="<%=offerId%>"/>
<input type="hidden" name="newofferId" value=""/>

<input type="hidden" name="offerIdArr"/>
<input type="hidden" name="offerNameArr"/>
<input type="hidden" name="offerEffectTime"/>
<input type="hidden" name="offerExpireTime"/>
<input type="hidden" name="proOptFlag"/>
<input type="hidden" name="smCodeHv"/>


                         
<input type="hidden" name="newZOfferECode"/>
<input type="hidden" name="newZOfferDesc"/>                         
<input type="hidden" name="dOfferId"/>
<input type="hidden" name="dOfferName"/>
<input type="hidden" name="dECode"/>
<input type="hidden" name="dOfferDesc"/>
                         
<input type="hidden" name="tonote"/>
<input type="hidden" name="attrFlagHv" value="0"/>
<input type="hidden" name="attrFlagOfferId" value="0"/>

<input type="hidden" name="attrFlagHvMsg" value=""/>
<input type="hidden" name="offerIdHv" value=""/>
<input type="hidden" name="offerId40Hv" value=""/>
<input type="hidden" name="offerName40Hv" value=""/>
<input type="hidden" name="offerTim40Hv" value=""/>
<input type="hidden" name="offerTim40EffHv" value=""/>

<input type="hidden" name="offerId40CanHv" value=""/>
<input type="hidden" name="offerName40CanHv" value=""/>
<input type="hidden" name="offerEffDateCanHv" value=""/>
<input type="hidden" name="offerNameHv" value=""/>
<input type="hidden" name="offerTimeHv" value=""/>
<input type="hidden" name="offerIDhitHv" value=""/>
<input type="hidden" name="offerZCflag" value=""/>
<input type="hidden" name="offerExpTime" value=""/>
<input type="hidden" name="offerName_alert" value=""/>
<input type="hidden" name="RealOfferId" value="0"/>

<input type="hidden" name="info1270ss" />
<input type="hidden" name="smzvalue" >
</DIV>
<%@ include file="/npage/include/footer_new.jsp"%>
</FORM>
</DIV>
</BODY>
<%@ include file="/npage/public/hwObject.jsp" %> 
</HTML>
<script>
	
	function opADDanDel() {
			var opadddel = $("#opadddel").val();
			if (document.getElementsByName("opFlag")[0].checked) {
			
			$("#addedOfferTab tr").each(function(){ 
				
					if( $(this).find("td:eq(6) input:eq(5)").val()!=undefined)	 {
						$(this).remove();
						}	
			
			});
					 $("#left").css("display","block");
					$("#leftSpan").css("display","block");
					$("#rightSpan").attr("class","item-col3 col-2");
					$("#leftSpan").attr("class","item-col2 col-1");					
					$("#right").attr("class","item-col col-2");
										   $('.addedOfferTitDivaaa').each(function () {
                 var myvalue = '本次受理【订购】';
                 $(this).html(myvalue);
             });

					$("#userHadOfferTab tr").each(function(i){ 			
							if( $(this).find("td:eq(7) input:eq(0)").val()=="退订")	{
						$(this).attr("disabled",true);
					}	});
					
				
	
					
			}else {

			$("#addedOfferTab tr").each(function(){ 
				
					if( $(this).find("td:eq(6) input:eq(5)").val()!=undefined)	 {
						$(this).remove();
						}	
			
			});
					$("#left").css("display","none");
				  $("#leftSpan").css("display","none");
				  
					$("#rightSpan").removeClass();
					$("#leftSpan").removeClass();
					$("#right").removeClass();
					
					   $('.addedOfferTitDivaaa').each(function () {
                 var myvalue = '本次受理【退订】';
                 $(this).html(myvalue);
             });

				 			$("#userHadOfferTab tr").each(function(i){ 		
				 				//alert($(this).find("td:eq(7) input:eq(0)").val());	
							if( $(this).find("td:eq(7) input:eq(0)").val()=="退订")	{
						$(this).attr("disabled",false)
					}	});
			}
	}
	
	
	
function ignoreThis(){
	
	if(rdShowConfirmDialog("请确认是否取消该业务？ 确认后，业务将被删除")==1){
		var packet1 = new AJAXPacket("ignoreThis.jsp","请稍后...");
				packet1.data.add("sOrderArrayId","<%=orderArrayId%>");
				core.ajax.sendPacket(packet1,doIgnoreThis);
				packet1 =null;
			}
	}
	
	function doIgnoreThis(packet){
		var errorCode = packet.data.findValueByName("retrunCode");
		var returnMsg = packet.data.findValueByName("returnMsg");
		if(errorCode == "0"){
				rdShowMessageDialog("忽略成功",2);
				goNext("<%=custOrderId%>","<%=custOrderNo%>","<%=prtFlag%>");
			}else{
				rdShowMessageDialog("忽略失败:"+returnMsg,0);
				}
		}
		
//0:查询销售品描述   
//1:查询销售品的角色 
//99:查询全部信息    
function showdesc(offid,offidInt)
{	
	var h=380;
	var w=480; 
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; scroll:no; resizable:no;location:no;status:no;help:no";
	
	var ret=window.showModalDialog("showDesc.jsp?offidInt="+offidInt+"&offid="+offid+"&msType=0&id_no=<%=stPMid_no%>&opCode=<%=opCode%>&opName=<%=opName%>","",prop);
}

function showInfo(){
	if($("#userInfoChkBox").get(0).checked == true){
		$("#userInfoDiv").show();	
	}else{
		$("#userInfoDiv").hide();		
	}	
	
	if($("#userHadChkBox").get(0).checked == true){
		$("#userHadDiv").show();	
	}else{
		$("#userHadDiv").hide();		
	}
	
	var h=380;
	var w=480; 
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; scroll:no; resizable:no;location:no;status:no;help:no";	
	

}






	


function check1270PrInfo(iOldOfferId,iNewOfferId) {
	var packet = new AJAXPacket("ajaxCk1270PrInfo.jsp","请稍后...");
  		packet.data.add("iOldOfferId" ,iOldOfferId);
  		packet.data.add("iNewOfferId" ,iNewOfferId);
  		packet.data.add("phone" ,"<%=phoneNo%>");
			core.ajax.sendPacket(packet,dochk1270proif);	
}
function dochk1270proif(packet) {
      document.all.info1270ss.value="";
			var retcode = packet.data.findValueByName("retcode");
      var retmsg = packet.data.findValueByName("retmsg");
      var infos1270 = packet.data.findValueByName("infos");
      document.all.info1270ss.value=infos1270;
}
//主资费变更
function printInfo1270()
{
//Math.round
  //得到该业务工单需要的参数
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";

	var retInfo = "";

	/********基本信息类**********/
	cust_info+="客户姓名：	"+document.all.custName.value+"|";
	cust_info+="手机号码：	"+"<%=phoneNo%>"+"|";

    /********受理类**********/
    opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌: "+document.all.stPMsm_nameHi.value+ "|";
    if (document.getElementsByName("opFlag")[0].checked) { 	
  	opr_info+="办理业务:自有数据业务包资费变更"+"  "+"操作流水: "+"<%=loginAccept%>" +"|";
  	opr_info+="操作类型：申请" +"|";
		opr_info+="业务类型：" +"|";
			
						var packetmsg="";
						var packetmsg2="";
						var sssd=0;
						var sssdstr="";
						var bflag=0;
						var snes=0;
					$("#addedOfferTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(6) input:eq(0)").val()==undefined) {
					 return true;
					 }
					if($(this).find("td:eq(6) input:eq(0)").val()=="") {
					 return true;
					 }						

						if($(this).find("td:eq(6) input:eq(4)").val()=="B") {
							bflag++;
						}
					snes=i
			});
				//alert(snes+"==snes");
						var bfalg2=0;
			
						$("#addedOfferTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(6) input:eq(0)").val()==undefined) {
					 return true;
					 }
					if($(this).find("td:eq(6) input:eq(0)").val()=="") {
					 return true;
					 }
						
						
						if($(this).find("td:eq(6) input:eq(4)").val()=="B") {
						
						bfalg2++;
						//alert("---");
						if(packetmsg=="") {
						}else {
						//alert(sssdstr);
						sssdstr+=sssd+"|";
						}
						packetmsg=$(this).find("td:eq(6) input:eq(5)").val();
						sssd=0;
						}
						if(packetmsg==$(this).find("td:eq(6) input:eq(5)").val()) {
						if($(this).find("td:eq(6) input:eq(4)").val()=="C") {
						
						sssd++;
						//alert(sssd);
						}
						}
						
						if(snes==i) {
						//if(bfalg2==bflag) {
						 sssdstr+=sssd+"|";
						//}				
						}		
			
			});
			var stringbufferss="";
			 var sm= new Array();
			 	sm =sssdstr.split("|");
					//alert(sssdstr);
					var sdeasd=0;
					var deasdf=0;
							$("#addedOfferTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(6) input:eq(0)").val()==undefined) {
					 return true;
					 }
					if($(this).find("td:eq(6) input:eq(0)").val()=="") {
					 return true;
					 }
						
						
						if($(this).find("td:eq(6) input:eq(4)").val()=="B") {
						queryPrintInfo($(this).find("td:eq(6) input:eq(0)").val());
						sdeasd++;
						packetmsg=$(this).find("td:eq(6) input:eq(5)").val();
						//opr_info+="|";
						//opr_info+="数据业务"+$(this).find("td:eq(6) input:eq(1)").val()+"功能申请，含";
						stringbufferss+=""+$(this).find("td:eq(6) input:eq(1)").val()+"功能申请，含";
						deasdf=0;
						}
					
						if(packetmsg==$(this).find("td:eq(6) input:eq(5)").val()) {
						if($(this).find("td:eq(6) input:eq(4)").val()=="C") {
						//opr_info+=$(this).find("td:eq(6) input:eq(1)").val()+"业务，";
						stringbufferss+=$(this).find("td:eq(6) input:eq(1)").val()+"业务，";
						deasdf++;
						}
						}
						if(sm[sdeasd-1]==deasdf) {
					//stringbufferss+="原价"+Math.round(pricesstr)+"元/月、现价"+Math.round((pricesstr*zhekosstr))+"元/月，立省"+Math.round((pricesstr-(pricesstr*zhekosstr)))+"元/月。|";
					stringbufferss+="原价"+Number(pricesstr).toFixed(2)+"元/月、现价"+Number(pricesstr*zhekosstr).toFixed(2)+"元/月，立省"+Number(pricesstr-(pricesstr*zhekosstr)).toFixed(2)+"元/月。|";
						//opr_info+="原价"+pricesstr+"元/月、现价"+(pricesstr*zhekosstr)+"元/月，立省"+(pricesstr-(pricesstr*zhekosstr))+"元/月。";
	
						}
						
					
			});
		 	//alert(stringbufferss);
		 	opr_info+=stringbufferss;
  	note_info1+="备注:订购数据业务包客户，订购成功后不能单独退订包内单个业务，可以您可在营业厅进行退订。详询10086"+"|";
  	}else{
  	opr_info+="操作类型：退订" +"|";
		opr_info+="业务类型：" +"|";
  			var packetmsg="";
						var packetmsg2="";
						var sssd=0;
						var sssdstr="";
						var bflag=0;
						var snes=0;
					$("#addedOfferTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(6) input:eq(0)").val()==undefined) {
					 return true;
					 }
					if($(this).find("td:eq(6) input:eq(0)").val()=="") {
					 return true;
					 }						

						if($(this).find("td:eq(6) input:eq(4)").val()=="B") {
							bflag++;
						}
					snes=i
			});
				//alert(snes+"==snes");
						var bfalg2=0;
			
						$("#addedOfferTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(6) input:eq(0)").val()==undefined) {
					 return true;
					 }
					if($(this).find("td:eq(6) input:eq(0)").val()=="") {
					 return true;
					 }
						
						//queryPrintInfo($(this).find("td:eq(6) input:eq(0)").val());
						if($(this).find("td:eq(6) input:eq(4)").val()=="B") {
						bfalg2++;
						//alert("---");
						if(packetmsg=="") {
						}else {
						//alert(sssdstr);
						sssdstr+=sssd+"|";
						}
						packetmsg=$(this).find("td:eq(6) input:eq(5)").val();
						sssd=0;
						}
						if(packetmsg==$(this).find("td:eq(6) input:eq(5)").val()) {
						if($(this).find("td:eq(6) input:eq(4)").val()=="C") {
						
						sssd++;
						//alert(sssd);
						}
						}
						
						if(snes==i) {
						//if(bfalg2==bflag) {
						 sssdstr+=sssd+"|";
						//}				
						}		
			
			});
			var stringbufferss="";
			 var sm= new Array();
			 	sm =sssdstr.split("|");
					//alert(sssdstr);
					var sdeasd=0;
					var deasdf=0;
							$("#addedOfferTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(6) input:eq(0)").val()==undefined) {
					 return true;
					 }
					if($(this).find("td:eq(6) input:eq(0)").val()=="") {
					 return true;
					 }
						
						//queryPrintInfo($(this).find("td:eq(6) input:eq(0)").val());
						if($(this).find("td:eq(6) input:eq(4)").val()=="B") {
						queryPrintInfo($(this).find("td:eq(6) input:eq(0)").val());
						sdeasd++;
						packetmsg=$(this).find("td:eq(6) input:eq(5)").val();
						//opr_info+="|";
						//opr_info+="数据业务"+$(this).find("td:eq(6) input:eq(1)").val()+"功能退订，含";
						stringbufferss+=""+$(this).find("td:eq(6) input:eq(1)").val()+"功能退订，含";
						deasdf=0;
						}
					
						if(packetmsg==$(this).find("td:eq(6) input:eq(5)").val()) {
						if($(this).find("td:eq(6) input:eq(4)").val()=="C") {
						//opr_info+=$(this).find("td:eq(6) input:eq(1)").val()+"业务，";
						stringbufferss+=$(this).find("td:eq(6) input:eq(1)").val()+"业务，";
						deasdf++;
						}
						}
						if(sm[sdeasd-1]==deasdf) {
						//stringbufferss+="原价"+Math.round(pricesstr)+"元/月、现价"+Math.round((pricesstr*zhekosstr))+"元/月，立省"+Math.round((pricesstr-(pricesstr*zhekosstr)))+"元/月。|";
						stringbufferss+="原价"+Number(pricesstr).toFixed(2)+"元/月、现价"+Number(pricesstr*zhekosstr).toFixed(2)+"元/月，立省"+Number(pricesstr-(pricesstr*zhekosstr)).toFixed(2)+"元/月。|";
						//opr_info+="原价"+pricesstr+"元/月、现价"+(pricesstr*zhekosstr)+"元/月，立省"+(pricesstr-(pricesstr*zhekosstr))+"元/月。";
	
						}
						
					
			});
		 	//alert(stringbufferss);
		 	opr_info+=stringbufferss;
  	
  	}

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}


</script>

<%
long s34 =System.currentTimeMillis();
System.out.println("mylog  页面 执行  的时间 = 【"+(s34-s33)+"】");
%>