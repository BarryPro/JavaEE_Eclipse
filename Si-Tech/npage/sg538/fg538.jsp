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
	
	String region_flag="hlj";//�����־
	String brandID  = "";
	
	//�ӹ��ﳵҳ�洫��	
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
	 rdShowMessageDialog('���ֻ�����ductmsg��û��cust_id������ϵ����Ա��');
	 window.close();
	<%
	return;
	}
	

	String phoneNo  = activePhone;
	
	String broadPhone  = WtcUtil.repNull(request.getParameter("broadPhone"));
	String prtFlag  = WtcUtil.repNull(request.getParameter("prtFlag"));
	String offerSrvId  = WtcUtil.repNull(request.getParameter("offerSrvId"));
	String custLevelStar  = WtcUtil.repNull(request.getParameter("custLevelStar"));//�ͻ��ȼ�
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
  String custOrderId = WtcUtil.repNull(request.getParameter("custOrderId"));	  //�ͻ�������
  String orderArrayId = WtcUtil.repNull(request.getParameter("orderArrayId"));  //�ͻ���������ID
  String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));    //�ͻ��������
  String servOrderId = WtcUtil.repNull(request.getParameter("servOrderId"));		//���񶩵�ID
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
<!--ȡ�ͻ�������Ϣ-->
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

String custName="";//�ͻ�����
String belongCity="";//��������
String custLevel="";//�ͻ�����
String linkmanName="";//��ϵ������
String bd0002_status="";//����״̬
String nationName = ""; //����
String agent_idType="";//֤������
String agent_idNo="";//֤������
String agent_phone="";//��ϵ�绰
String ba0002_black="";//������
		
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
var offerInfoHash = new Object(); //����Ʒ��Ʒ��Ϣ	
var AttributeHash = new Object(); //������Ϣ
var oldOfferAry = new Array();    //ȡ��������Ʒ
var newOfferAry = new Array();    //������Ʒ��Ϣ
var showPageNum = 1;
var thePageNum = 1; 	            //��ǰҳ��
var currentOfferId = "";	        //����ƷĿ¼��չ��������ƷID
var CanOfferCancel = 0;		        //����Ʒ�Ƿ���˶���ʶ
var CanUndoOpe = 0;				        //�����˶��Ƿ�ɲ�����ʶ
var CanOfferBook = 0;			        //����Ʒ�Ƿ�ɶ�����ʶ
var MainOfferFlag=0;
var thisMonthOfferId = "<%=offerId%>";
var operateFlag = 1;	//ҵ������
var arrClassValue = new Array();
var offerIdArr = new Array();      //����ƷID
var offerNameArr=new Array();     //����Ʒ���ƣ���ӡ�ã�
var offerEffectTime = new Array();
var offerExpireTime = new Array();
var xqdm = "";
var zdxq="";
var vpmnstr1="";
var thisMonthOfferIdArr=new Array();

//��ӡ��ʹ�ñ���
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

    //ֻ׼������������Ʒ
  	$("#qryOfferBtn").unbind();
		$("#qryOfferBtn").bind("click",qryAddOffer);
		//qryMainOfferRoleInfo();
    HoverLi(2,2);
    $("#tb_1").css("display","none");

		qryOfferInst();	//��ѯ�û���ǰ������ϵ
		
	  setOfferType();
	  getCurrentOpeInfo();
	
	$("#showInfoDiv :checkbox").bind("click",showInfo);

	{
		$("#searchOfferConDiv").css("display","");		
	}
	
	//����ǰ������ϵ
	$("#userHadOfferTitDiv").toggle(
	  function(){
	    $("#userHadOfferTab").css("display","none");
	  },
	  function(){
	    $("#userHadOfferTab").css("display","");
	  }
	);
	//���𱾴������еĶ�����Ϣ
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
	//���𱾴������е��˶���Ϣ
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
  	
		if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="����"&&$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(4)").text()=="��Ч"){
  		thisMonthOfferId2 = $("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text();
  	}
	}
opADDanDel();

});	

function ajaxGetMsg1(){ //��ڰ�������ʾ
	//alert("document.all.stPMid_no.value|"+document.all.stPMid_no.value);
	
	var packet = new AJAXPacket("ajaxRetMsgVpmn.jsp","���Ժ�...");
  		packet.data.add("phone_no" ,"<%=phoneNo%>");
  		packet.data.add("opCode" ,"<%=opCode%>");
  		packet.data.add("servId" ,document.all.stPMid_no.value);
			core.ajax.sendPacket(packet,doAjaxGetMsg1);	
}

function doAjaxGetMsg1(packet){
		    vpmnstr1 = packet.data.findValueByName("vpmnstr1");
}				

function ajaxGetMsg(){ //��ڰ�������ʾ
	//alert("document.all.stPMid_no.value|"+document.all.stPMid_no.value);
	
	var packet = new AJAXPacket("ajaxRetMsg.jsp","���Ժ�...");
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
			/*zhangyan �޸� 
			if(vOfferAttrType == "Yns0"){
		    rdShowMessageDialog('��ʾ: ��ע��,���û�Ϊ���񹫻��û���');
		  }
		  if(vTwoPhoneFlag == "Y"){
		    rdShowMessageDialog('��ʾ: ��ע��,���û�Ϊһ��˫���û���');
		  }
		  if(vHighFlag == "Y"){
		    rdShowMessageDialog('��ʾ: ��ע��,���û�Ϊ�и߶��û���');
		  }
			
			
			if(liststr!="") {
				rdShowMessageDialog(liststr);	
			}*/
}				
//��get����
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
		$("#offerListDiv").empty();	//��տ�ѡ����Ʒչʾ��
		$("#offerType").parent().hide();	//���ز�ѯ����
		$("#bindId").parent().hide();	//����ҵ��Ʒ��
		$("#custType").parent().hide();	//���ؿͻ�����
		$("#roleInfoP").show();
		operateFlag = 2;
	}else	if(n == 3){	
										
	}
}	

function setOfferType(){

			var packet = new AJAXPacket("ajax_getOfferType.jsp","���Ժ�...");
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

//------��ѯ�û���ǰ������ϵ---------
function qryOfferInst(){
	var packet = new AJAXPacket("qryOfferInst.jsp","���Ժ�...");
	packet.data.add("phoneNo","<%=phoneNo%>");
	core.ajax.sendPacketHtml(packet,doQryOfferInst);
	packet =null;
}
function doQryOfferInst(data){
	//$("#userHadOfferDiv").html("");
	$("#userHadOfferDiv").html(data);
	$("[name='cancelBtn']").bind("click",cancelOffer);	
}

//-------���ж�����ϵ�˶�-------------
function cancelOffer(){

		if(document.getElementsByName("opFlag")[0].checked) {
		return false;
		}
	CanOfferCancel = 0;
	var offerId = this.id.split("|")[0];
	var optypes = this.id.split("|")[1];	

	var packet = new AJAXPacket("cancelOffer.jsp","���Ժ�...");
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
		//rdShowMessageDialog("�˶��ɹ�!");
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
			var priceTd=$("td:eq(1)",$(this) );//�Żݽ�� 
			if(priceTd.text()==offer_id)  {
			saddflags="false";
			return false;
			}
			});
			
				if(saddflags=="false") {
						return false;
				}

					 //buttonStr+="<div id='basicInfo_"+offer_id+"' name='"+effTime+"|"+expTime+"|"+offerInstId+"' class='but_set'><span>������Ϣ</span></div>";	

						 document.all.offerId40Hv.value += offer_id+"|";
						 document.all.offerName40Hv.value += offer_name+"|";
						 document.all.offerEffDateCanHv.value+=effTime+"|";
						 document.all.offerTim40Hv.value += effTime+"|";
						 document.all.offerTim40EffHv.value += expTime+"|";
						 					
					document.all.offerIDhitHv.value+=offer_id+"~";
					
					if(isdeleflag=="B") {
					$("#addedOfferTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name='' ><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td title="+offer_comment+">"+offer_id+"</td><td title="+offer_comment+">"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,9)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,9)+"</td><td><img src='/nresources/default/images/task-item-close1.gif' style='cursor:Pointer;' class='del_cls' name='"+offer_id+"' alt='ɾ��ѡ�������Ʒ' id='del_"+offer_id+"'></td><td style='display:none'><input type='hidden' name='offerIdArrss' value='"+offer_id+"' /><input type='hidden' name='offerNameArrss' value='"+offer_name+"'/><input type='hidden' name='offerEffectTimess' value='"+effTime+"'/><input type='hidden' name='offerExpireTimess' value='"+expTime+"'/><input type='hidden' name='isdeleflagss' value='"+isdeleflag+"'/><input type='hidden' name='timeflagss' value='"+timeflag+"'/><input type='hidden' name='offer_typesss' value='"+offer_types+"'/></td></tr>");
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

//------------���������˶�-------------
function undoCancel(){
	var offerId = this.name.split("|")[0];
	var offerInstId = this.name.split("|")[1];	
	var packet = new AJAXPacket("undoCancel.jsp","���Ժ�...");
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

//------------�������ζ���-------------
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
//----------��������Ʒ��Ϣ����--------
function qryMainOffer(){
	var offerType = $("#offerType").val();
	var offerId = $("#offerId").val();
	var offerName = $("#offerName").val();
	var bindId = $("#bindId").val();

	var custType="";

	var packet = new AJAXPacket("qryMainOffer.jsp","���Ժ�...");
	packet.data.add("servId","<%=offerSrvId%>");
	packet.data.add("offerId",offerId);
	packet.data.add("relMainOfferId",thisMonthOfferId);	//thisMonthOfferId��qryOfferInst.jsp������
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

//----------��������Ʒ��Ϣ����--------
function qryAddOffer(){
	
	var offerIdsd = $("#offerId").val();	
 	var offerNamesd = $("#offerName").val();
	var offerType = $("#offerType").val();

		var packet = new AJAXPacket("qryAddOffer.jsp","���Ժ�...");
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

//------------��������Ʒ-------------

var mf_Flag = "1"; //�ղؼе����� ��־
function qryMainOffer_m(offer_id){
	var offerType = "";
	var offerId = offer_id;
	var offerName = "";
	var bindId = "";
	
	var custType="";
	
	var packet = new AJAXPacket("qryMainOffer_m.jsp","���Ժ�...");
	packet.data.add("servId","<%=offerSrvId%>");
	packet.data.add("offerId",offerId);
	packet.data.add("relMainOfferId",thisMonthOfferId);	//thisMonthOfferId��qryOfferInst.jsp������
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
			rdShowMessageDialog("�˹���û�в���Ȩ�ޣ�������ѡ��",0);
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
 
	var packet = new AJAXPacket("qryRealOfferId.jsp","���Ժ�...");
	packet.data.add("loginAccept","<%=loginAccept%>");
	packet.data.add("opCode","<%=opCode%>");
	core.ajax.sendPacket(packet,doQryRealOfferId);
	packet =null;	
	
	var relMainOfferId="";
	if(document.all.RealOfferId.value=="0"){
		 relMainOfferId= thisMonthOfferId;		//Ĭ��Ϊ���»�������Ʒ
	}else{
	   relMainOfferId= document.all.RealOfferId.value;
   }
	
 
	
	var packet = new AJAXPacket("qryAddOffer_m.jsp","���Ժ�...");
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
			rdShowMessageDialog("�˹���û�в���Ȩ�ޣ�������ѡ��",0);
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
	
	/**���� ���ղؼе�����*/
	if(operateFlag == 1){
		qryMainOffer_m(offer_id);
	}else{
		qryAddOffer_m(offer_id);
	}
	
	if(mf_Flag == "0"){
		return false;	
	}
	
	var packet = new AJAXPacket("applyMainOffer.jsp","���Ժ�...");
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
     var packet = new AJAXPacket("applyMainOffer.jsp","���Ժ�...");
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



//-------------------��ȡ����/�˶���Ϣ--------------------
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

	var packet = new AJAXPacket("applyMainOffer.jsp","���Ժ�...");
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
			var priceTd=$("td:eq(1)",$(this) );//�Żݽ�� 
			if(priceTd.text()==offer_id)  {
			saddflags="false";
			return false;
			}
			});
			
				if(saddflags=="false") {
						return false;
				}

					 //buttonStr+="<div id='basicInfo_"+offer_id+"' name='"+effTime+"|"+expTime+"|"+offerInstId+"' class='but_set'><span>������Ϣ</span></div>";	

						 document.all.offerId40Hv.value += offer_id+"|";
						 document.all.offerName40Hv.value += offer_name+"|";
						 document.all.offerEffDateCanHv.value+=effTime+"|";
						 document.all.offerTim40Hv.value += effTime+"|";
						 document.all.offerTim40EffHv.value += expTime+"|";
						 
					
					
					document.all.offerIDhitHv.value+=offer_id+"~";
					
					if(isdeleflag=="B") {
					$("#addedOfferTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name='' ><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td title="+offer_comment+">"+offer_id+"</td><td title="+offer_comment+">"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,9)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,9)+"</td><td><img src='/nresources/default/images/task-item-close1.gif' style='cursor:Pointer;' class='del_cls' name='"+offer_id+"' alt='ɾ��ѡ�������Ʒ' id='del_"+offer_id+"'></td><td style='display:none'><input type='hidden' name='offerIdArrss' value='"+offer_id+"' /><input type='hidden' name='offerNameArrss' value='"+offer_name+"'/><input type='hidden' name='offerEffectTimess' value='"+effTime+"'/><input type='hidden' name='offerExpireTimess' value='"+expTime+"'/><input type='hidden' name='isdeleflagss' value='"+isdeleflag+"'/><input type='hidden' name='timeflagss' value='"+timeflag+"'/><input type='hidden' name='offer_typesss' value='"+offer_types+"'/></td></tr>");
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
	  
	  if(v_hiddenFlag=="Y"){ //��ΪYʱ�������°�С������չʾҳ��
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
					rdShowMessageDialog("δ�������ԣ�");	
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
				AttributeHash[queryId]=ret;	//�����ص�Ⱥ����Ϣ��ӦqueryId����
			}	
			else{
				document.all.attrFlagHv.value=offid;
				rdShowMessageDialog("δ�������ԣ�");	
				return false;
			}	
	 
}


//��������Ʒ�б�
function initTab(retAry){

	$("#offerListDiv table").remove();

		$("#offerListDiv").append("<table id='offerListTab'><thead><tr style='cursor:hand'><th >����ƷID</th><th >����Ʒ����</th><th>����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����<th></tr></thead></table>");

	for(var i=0 ; i<retAry.length; i++){
		var offer_id = retAry[i][0];
		var offer_name = retAry[i][1];
		var offerconent = retAry[i][2];
		
		var offerIds=offer_id+"|";
		var divOfferIds= "coltr_"+offer_id+"|";

		  	$("#offerListTab").append("<tr><td>"+offer_id+"</td><td  id='coltr_"+offer_id+"'>"+offer_name+"</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src='/nresources/default/images/ab1.gif' style='cursor:hand' alt='����' id='col_"+offer_id+"' onClick='addOffer("+offer_id+")' />&nbsp;&nbsp;&nbsp;</span><img src='/nresources/default/images/child.gif' style='cursor:hand' name='' alt='"+offerconent+"' id='detail_"+offer_id+"' ></td></tr>");
		

	}
	btcGetMidPrompt("10442",offerIds,divOfferIds);
}



//----------------���ټ���---------------------------
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
					rdShowMessageDialog("�����б�Ϊ�գ���ѡ�񶩹������˶�������");
					return false;
			}
			
			document.all.offerstrbuffer.value=offeridstr;
			document.all.statusbuffer.value=statustr;
			document.all.typebuffer.value=typestr;

		var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	if(rdShowConfirmDialog("��ȷ���Ƿ����<%=opName%>��")==1)
	{	
		document.offerChoiceFrm.action="fg538Cfm.jsp";
		document.offerChoiceFrm.submit();
	}
}

   function checksmz()
  {

  var myPacket = new AJAXPacket("/npage/bill/checkSMZ.jsp","���ڲ�ѯ�ͻ��Ƿ���ʵ���ƿͻ������Ժ�......");
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

//---------������������Ʒ������------
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
	/*ningtn huangrong ע�ͣ�����ʵʩȫҵ����ӹ����������󣬸Ĺ��ܲ���Ҫ¼�����֤��Ϣ*/
	//var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
	//var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
	/* ningtn */
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	
	return ret;
}
//��ѯ��ӡ����Ҫ������
function queryPrintInfo(offerid){

							var packet = new AJAXPacket("qryPrice.jsp","���Ժ�...");
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
	var packet = new AJAXPacket("ajaxQueryPPp.jsp","���Ժ�...");
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
		var packet = new AJAXPacket("/npage/s1104/ajaxGetEPf.jsp","���Ժ�...");
		packet.data.add("tempNote_info2v",tempNote_info2v);
		packet.data.add("opCode","<%=opCode%>");
		core.ajax.sendPacket(packet,doAjaxGetEPf11);
		packet = null;
	}  
	
function doAjaxGetEPf11(packet){
		 retResultStr1 = packet.data.findValueByName("retResultStr");
	}


function ajaxGetEPf(offerIdv,offerId){
		var packet = new AJAXPacket("ajaxGetEPf.jsp","���Ժ�...");
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
	
/* ������ͨ78λTD���������û����Ʒ��Ͷ��Ź��ܵ����� */
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
  System.out.println("mylog  ִ�з��� sDynSqlCfm  ��ʱ�� = ��"+(s3a-s2a)+"��");
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
	/*zhangyan �޸�*/
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
			var packet = new AJAXPacket("/npage/portal/shoppingCar/ajax_getMfOffer.jsp","���Ժ�...");
			core.ajax.sendPacket(packet,doMyFavorite,true);
			packet =null;	
}

function doMyFavorite(packet){
			var qryRetCode = packet.data.findValueByName("retCode"); 
	    var qryRetMsg = packet.data.findValueByName("retMsg"); 
	    var retResult = packet.data.findValueByName("retResult");
	    var myFavoObj = document.all.myFavoriDiv;
	    var innerHTMLStr = "<table id=\"myFavoriteListT\" cellspacing=0><tr><td class='blue'>����Ʒ����</td><td class='blue'>����Ʒ����</td><td class='blue'>����Ʒ����</td></tr>";
	    for(var i=0;i<=retResult.length-1;i++){
	    	if(retResult[i][2].length>20) retResult[i][2] = retResult[i][2].substring(0,20)+"...";
	    	innerHTMLStr +="<tr onclick=\"addOffer_m('"+retResult[i][0]+"')\" style=\"cursor:pointer\" ><td>"+retResult[i][0]+"</td><td>"+retResult[i][1]+"</td><td>"+retResult[i][2]+"</td></tr>";
	    }
	    innerHTMLStr += "</table>";
	    myFavoObj.innerHTML = innerHTMLStr;
}

function hotOffer(){
		var packet = new AJAXPacket("/npage/portal/shoppingCar/ajax_getHotOffer.jsp","���Ժ�...");
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
											"<td class='blue'>����Ʒ����</td>"+
											"<td class='blue'>����Ʒ����</td>"+
											"<td class='blue'>����Ʒ����</td>"+
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
	<!--div class="title"><div  class="text" >�ͻ�������Ϣ</div></div-->
 <div class="title">
  	<div id="title_zi">�ͻ�������Ϣ </div>
  </div>
	<div id="custInfo">
		<div class="input">
   	<table cellspacing="0">
   		<tr>
   			<td class=blue>�ͻ����� </td>
   			<td>
   				<span style="cursor:pointer;color:#ff9900" onclick="window.showModalDialog('/npage/common/qcommon/bd_0001.jsp?gCustId=<%=gCustId%>&opName=�ͻ���ϸ��Ϣ','dialogHeight=700px','dialogWidth=650px','help=no','status=no')"><%=custName%></span>
   				<input type="hidden" name="custNameforsQ046" value="<%=custName%>">
   				<%
   				if(ba0002_black.equals("N"))
   				{
   					//out.println("(�Ǻ�����)");
   				}else
   				{
   					out.println("(������)");
				%>
					<script>
						rdShowMessageDialog("�ÿͻ����ں������ͻ�");
					</script>
				<%
   				}
   				%>
   			</td>
   			<td  class=blue>����</td>
   			<td><%=nationName%></td> 
   			<td  class=blue>��ϵ�� </td>
   			<td><%=linkmanName%></td>
   		</tr>
   	  <tr>
   			<td  class=blue>�ͻ����� </td>
   			<td ><%=custLevel%></td> 
   	  	<td  class=blue>����״̬</td>
   			<td><%=bd0002_status%></td>   
   	    <td  class=blue>�������� </td>
   			<td><%=belongCity%></td>
   	  </tr>
   	  <%
   	    if(!"".equals(custLevelStar)){
   	  %>
   	      <tr>
   			    <td  class=blue>�ͻ��ȼ� </td>
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
						<td class="blue">�ɶ�����Ϣ��
						<input type="checkbox" name="" id="userInfoChkBox" value="0">�û�������Ϣ 
						&nbsp;&nbsp;&nbsp;&nbsp;	
						<input type="checkbox" name="" id="userHadChkBox" value="1">����Ʒ������Ϣ
						<%
						  if(opCode.equals("3257")&&(countqry>0)){
						%>
						  <input type="checkbox" name="" id="glbQryMem" value="2">ȫ��ͨ��ܰ��ͥ��ѯ
						<%
						  }
						%>
					</tr>
				</table>	
		</div>
	</div>
	<div class="title">
  	<div id="title_zi">�������� </div>
  </div>
	<div id="custInfo">
		<div class="input">
   	<table cellspacing="0">
   		<tr>
   			<td >
   				<input type="radio" name="opFlag" value="0" onclick="opADDanDel()" checked>���� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="opFlag" value="1" onclick="opADDanDel()" >�˶�
 
   				</td>
   			   				
   	  </tr>
	</table>
</div>
	</div>
	
	<div id="userInfoDiv">
		<div class="title"><div id="title_zi">�û�������Ϣ </div></div>
	 	<%@include file="PMUserBaseInfo.jsp"%>
	</div>
	
	<!--div class="title" id="userHadOfferTitDiv"><div class="text">��ǰ������ϵ</div></div-->
<div id="userHadDiv">
	<div class="title" id="userHadOfferTitDiv">
	  	<div id="title_zi" style="cursor:hand;">����Ʒ������Ϣ</div>
	</div>	
		<div class="list" id="userHadOfferDiv">
		</div>		
</div>	
	
	
<div style="width:100%" id="show1270" style="display:none">
	<div style="">
		<div style="width:100%">
			<div class="product_chooseR" id="myFavoriteList" style="height:130px;float:left;width:50%; overflow-y:auto; overflow-x:hidden;">
				<div class="title"><div id="title_zi">���ղص�����Ʒ�б�</div></div>
						<div class="list" style="">
							<div id="myFavoriDiv"></div>
					  </div>
			 </div>
			<div class="product_chooseR" id="hotOfferQueryList" style="float:right;width:49%;">
				<div class="title"><div id="title_zi">�ȵ�����Ʒ�б�</div></div>
			
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
				  	  <div id="title_zi">����Ʒ������</div><span style="float:right;padding: 3px 1px 0px 2px;"><img src='/nresources/default/images/arrow_right.gif' style='cursor:hand' name='left' alt='����۵�����Ʒ������' id='LRImg' onClick="toLeft()"></span>
				</div>				   
				  <div style="overflow-y:hidden;overflow-x:hidden; background-color: #F7F7F7;border-right: 1px solid #95CBDD;border-left: 1px solid #95CBDD;border-bottom: 1px solid #95CBDD;height:300px;FONT-WEIGHT: normal; FONT-SIZE: 13px;" class="list">
			
					<div id="formTab">	
						<ul>
						<li class="current" id="tb_1" onclick="HoverLi(1,2)"><a href="#">��������Ʒ</a></li>  
						<li id="tb_2"><a href="#" onclick="HoverLi(2,2)">��������Ʒ</a> </li>
					</ul>
				 </div>	

						<div id="searchOfferConDiv" style="display:none;border-right: 0px solid #95CBDD;border-left: 0px solid #95CBDD;border-bottom: 1px solid #95CBDD;height:300px;PADDING-LEFT: 20px; COLOR: #0256b8;FONT-WEIGHT: normal; FONT-SIZE: 12px;">
							<p> &nbsp;&nbsp;ҵ��Ʒ��:
								<select class="b_text" name="bindId" id="bindId"  onchange="setOfferType()">
									<option value="" selected>----��ѡ��----</option>
								</select>
							</p>

							<p>&nbsp;&nbsp;����ƷID��<input type="text"  name="offerId" id="offerId" class="for0_9" ></p>
							<p>&nbsp;&nbsp;&nbsp;&nbsp;�ؼ��֣�<input type="text"  name="offerName" id="offerName" ></p>
							<p id="roleInfoP">����Ʒ���ࣺ
																<select class="b_text" name="offerType" id="offerType">
									<option value="" selected>----��ѡ��----</option>
								</select>
								</p>
							<p align="center">	
								<input type="button" class="b_text" value="����" id="qryOfferBtn">

								<input type="button" class="b_text" value="���" onclick="clearInfo()" />&nbsp;&nbsp;&nbsp;
							</p>
						</div>
					</div>
			</div>
			
	 <div class="item-col col-2" id="right" >
				<span class="item-col2 col-1" id="leftSpan" style="overflow-y:auto;overflow-x:hidden;background-color:#F7F7F7;height:327px;border-right: 1px solid #95CBDD;border-left: 1px solid #95CBDD;border-bottom: 1px solid #95CBDD;">
					<!--div class="title"><div class="text">��ѯ�б�</div></div-->				
				<div class="title" >
			  	<div id="title_zi">��ѡ����Ʒչʾ��</div><span style="float:right;padding: 3px 1px 0px 2px;"><img src='/nresources/default/images/arrow_left.gif' style='cursor:hand' name='right' alt='����۵�����Ʒ������' id='LRImg' onClick="toLeft()"></span>
			  </div>

					
				 <div>
						<div  id="offerListDiv">
						</div>
					</div>
				</span>
				
		    <span class="item-col3 col-2" id="rightSpan">
					<!--div class="title" id="addedOfferTitDiv"><div class="text">��������������</div></div-->			
			<div class="title" id="addedOfferTitDiv">
		  	<div id="title_zi" style="cursor:hand;"> <span class="addedOfferTitDivaaa">��������������</span></div>
		  </div>
		  
		  
		  
		  
		  
				
					<div id="addedOfferDiv" class="list" style="overflow-x:auto;overflow-y:auto;height:300px;width:99%;border-width:1px;border-color:#add3d0;border-style:solid;background-color: #F7F7F7;" >
						<table id="addedOfferTab">
								<tr>
								<td colspan='6' class="blue"><b><����Ʒ></b></td>
							</tr>
							<tr id="addedOfferHeadTr">
								<td class="blue">״̬</td>
								<td class="blue">����</td>
								<td class="blue">����</td>
								<td class="blue">��Чʱ��</td>
								<td class="blue">ʧЧʱ��</td>
								<td class="blue">����</td>
							</tr>
						</table>	
							
					</div>
					

					
				</span>
				
		</div>			
	</div><!--end items-->

</div>
<!--huangrong ע�ͣ�����ʵʩȫҵ����ӹ����������󣬸Ĺ��ܲ���Ҫ¼�����֤��Ϣ 2011-8-4
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=loginAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>-->
<div id="operation_button">
	<div id="footer">
	<input class="b_foot" name=confirm id="confirm" type=button onClick="qryProdAttr()" value="ȷ��" >
	<input class="b_foot" name=back onClick="removeCurrentTab()" type=button value="�ر�">
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
                 var myvalue = '��������������';
                 $(this).html(myvalue);
             });

					$("#userHadOfferTab tr").each(function(i){ 			
							if( $(this).find("td:eq(7) input:eq(0)").val()=="�˶�")	{
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
                 var myvalue = '���������˶���';
                 $(this).html(myvalue);
             });

				 			$("#userHadOfferTab tr").each(function(i){ 		
				 				//alert($(this).find("td:eq(7) input:eq(0)").val());	
							if( $(this).find("td:eq(7) input:eq(0)").val()=="�˶�")	{
						$(this).attr("disabled",false)
					}	});
			}
	}
	
	
	
function ignoreThis(){
	
	if(rdShowConfirmDialog("��ȷ���Ƿ�ȡ����ҵ�� ȷ�Ϻ�ҵ�񽫱�ɾ��")==1){
		var packet1 = new AJAXPacket("ignoreThis.jsp","���Ժ�...");
				packet1.data.add("sOrderArrayId","<%=orderArrayId%>");
				core.ajax.sendPacket(packet1,doIgnoreThis);
				packet1 =null;
			}
	}
	
	function doIgnoreThis(packet){
		var errorCode = packet.data.findValueByName("retrunCode");
		var returnMsg = packet.data.findValueByName("returnMsg");
		if(errorCode == "0"){
				rdShowMessageDialog("���Գɹ�",2);
				goNext("<%=custOrderId%>","<%=custOrderNo%>","<%=prtFlag%>");
			}else{
				rdShowMessageDialog("����ʧ��:"+returnMsg,0);
				}
		}
		
//0:��ѯ����Ʒ����   
//1:��ѯ����Ʒ�Ľ�ɫ 
//99:��ѯȫ����Ϣ    
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
	var packet = new AJAXPacket("ajaxCk1270PrInfo.jsp","���Ժ�...");
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
//���ʷѱ��
function printInfo1270()
{
//Math.round
  //�õ���ҵ�񹤵���Ҫ�Ĳ���
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";

	var retInfo = "";

	/********������Ϣ��**********/
	cust_info+="�ͻ�������	"+document.all.custName.value+"|";
	cust_info+="�ֻ����룺	"+"<%=phoneNo%>"+"|";

    /********������**********/
    opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"�û�Ʒ��: "+document.all.stPMsm_nameHi.value+ "|";
    if (document.getElementsByName("opFlag")[0].checked) { 	
  	opr_info+="����ҵ��:��������ҵ����ʷѱ��"+"  "+"������ˮ: "+"<%=loginAccept%>" +"|";
  	opr_info+="�������ͣ�����" +"|";
		opr_info+="ҵ�����ͣ�" +"|";
			
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
						//opr_info+="����ҵ��"+$(this).find("td:eq(6) input:eq(1)").val()+"�������룬��";
						stringbufferss+=""+$(this).find("td:eq(6) input:eq(1)").val()+"�������룬��";
						deasdf=0;
						}
					
						if(packetmsg==$(this).find("td:eq(6) input:eq(5)").val()) {
						if($(this).find("td:eq(6) input:eq(4)").val()=="C") {
						//opr_info+=$(this).find("td:eq(6) input:eq(1)").val()+"ҵ��";
						stringbufferss+=$(this).find("td:eq(6) input:eq(1)").val()+"ҵ��";
						deasdf++;
						}
						}
						if(sm[sdeasd-1]==deasdf) {
					//stringbufferss+="ԭ��"+Math.round(pricesstr)+"Ԫ/�¡��ּ�"+Math.round((pricesstr*zhekosstr))+"Ԫ/�£���ʡ"+Math.round((pricesstr-(pricesstr*zhekosstr)))+"Ԫ/�¡�|";
					stringbufferss+="ԭ��"+Number(pricesstr).toFixed(2)+"Ԫ/�¡��ּ�"+Number(pricesstr*zhekosstr).toFixed(2)+"Ԫ/�£���ʡ"+Number(pricesstr-(pricesstr*zhekosstr)).toFixed(2)+"Ԫ/�¡�|";
						//opr_info+="ԭ��"+pricesstr+"Ԫ/�¡��ּ�"+(pricesstr*zhekosstr)+"Ԫ/�£���ʡ"+(pricesstr-(pricesstr*zhekosstr))+"Ԫ/�¡�";
	
						}
						
					
			});
		 	//alert(stringbufferss);
		 	opr_info+=stringbufferss;
  	note_info1+="��ע:��������ҵ����ͻ��������ɹ����ܵ����˶����ڵ���ҵ�񣬿���������Ӫҵ�������˶�����ѯ10086"+"|";
  	}else{
  	opr_info+="�������ͣ��˶�" +"|";
		opr_info+="ҵ�����ͣ�" +"|";
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
						//opr_info+="����ҵ��"+$(this).find("td:eq(6) input:eq(1)").val()+"�����˶�����";
						stringbufferss+=""+$(this).find("td:eq(6) input:eq(1)").val()+"�����˶�����";
						deasdf=0;
						}
					
						if(packetmsg==$(this).find("td:eq(6) input:eq(5)").val()) {
						if($(this).find("td:eq(6) input:eq(4)").val()=="C") {
						//opr_info+=$(this).find("td:eq(6) input:eq(1)").val()+"ҵ��";
						stringbufferss+=$(this).find("td:eq(6) input:eq(1)").val()+"ҵ��";
						deasdf++;
						}
						}
						if(sm[sdeasd-1]==deasdf) {
						//stringbufferss+="ԭ��"+Math.round(pricesstr)+"Ԫ/�¡��ּ�"+Math.round((pricesstr*zhekosstr))+"Ԫ/�£���ʡ"+Math.round((pricesstr-(pricesstr*zhekosstr)))+"Ԫ/�¡�|";
						stringbufferss+="ԭ��"+Number(pricesstr).toFixed(2)+"Ԫ/�¡��ּ�"+Number(pricesstr*zhekosstr).toFixed(2)+"Ԫ/�£���ʡ"+Number(pricesstr-(pricesstr*zhekosstr)).toFixed(2)+"Ԫ/�¡�|";
						//opr_info+="ԭ��"+pricesstr+"Ԫ/�¡��ּ�"+(pricesstr*zhekosstr)+"Ԫ/�£���ʡ"+(pricesstr-(pricesstr*zhekosstr))+"Ԫ/�¡�";
	
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
System.out.println("mylog  ҳ�� ִ��  ��ʱ�� = ��"+(s34-s33)+"��");
%>