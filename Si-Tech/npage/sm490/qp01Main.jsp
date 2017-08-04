<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="ignoreIn.jsp" %>
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
  String noPassWord = (String)session.getAttribute("password");
  String regionCode = orgCode.substring(0,2);
  
  opCode =WtcUtil.repNull(request.getParameter("opCode")); 
  
  String region_flag="hlj";//区域标志
  String brandID  = "";
  String display="display:none";
  
  
  //从购物车页面传入  
  String gCustId = WtcUtil.repNull(request.getParameter("gCustId"));
  String phoneNo  = WtcUtil.repNull(request.getParameter("phoneNo"));
  String broadPhone  = WtcUtil.repNull(request.getParameter("broadPhone"));
  String prtFlag  = WtcUtil.repNull(request.getParameter("prtFlag"));
  String offerSrvId  = WtcUtil.repNull(request.getParameter("offerSrvId"));
  String custLevelStar  = WtcUtil.repNull(request.getParameter("custLevelStar"));//客户等级
  String servId = offerSrvId;
  String getSmCodeSql="select b.band_id from product_offer_instance a,product_offer b where  a.offer_id = b.offer_id  and    b.offer_type = 10 and    sysdate between a.eff_date and a.exp_date and    a.serv_id ="+servId;
  System.out.println("getSmCodeSql|"+getSmCodeSql);
  String smCode="";
  String OPflag =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");//OPflag == "2"时为客服工号进入
  %>
  <%
    /* begin diling update for 关于增加开户界面客户登记信息验证功能的函@2013/9/22 */
    if("1270".equals(opCode)){
      String  inParams [] = new String[2];
      inParams[0] = "select count(*) from dtruenamemsg where true_code='3' and id_no=:id_no";
      inParams[1] = "id_no="+servId;
    %>
    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
      <wtc:param value="<%=inParams[0]%>"/>
      <wtc:param value="<%=inParams[1]%>"/>
    </wtc:service>  
    <wtc:array id="ret_checkRealUser"  scope="end"/>
    <%
      if("000000".equals(retCode1)){
        if(ret_checkRealUser.length>0){
          if(Integer.parseInt(ret_checkRealUser[0][0])>0){ //大于0为非实名制用户
    %>
            <SCRIPT type=text/javascript>
              rdShowMessageDialog("请您先进行真实身份登记，实名登记后方可办理资费变更！",1);
              removeCurrentTab();           
            </SCRIPT>
    <%
          }
        }
      }else{
    %>
            <SCRIPT type=text/javascript>
              rdShowMessageDialog("错误信息：<%=retCode1%><br>错误代码：<%=retMsg1%>",0);
              removeCurrentTab();
            </SCRIPT>
    <%   
      }
    }
    /* end diling update for 关于增加开户界面客户登记信息验证功能的函@2013/9/22 */
    %>
    
    
    <%
    /* begin liangyl add for 关于LTE-FI业务取消时免违约金需求的函@2016/9/7 */
    if("1258".equals(opCode)){
      String  weiyuejin[] = new String[2];
      String count_result = "0";
      weiyuejin[0] = "SELECT count(*) FROM product_offer_instance a,product_offer b,product_offer_attr m WHERE a.offer_id = b.offer_id and b.offer_id = m.offer_id	and m.offer_attr_seq = 70007 and b.offer_type = 10 and a.serv_id =:serv_id and sysdate between a.eff_date and a.exp_date";
      weiyuejin[1] = "serv_id="+servId;
      display="display:none";
      
    %>
    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeW" retmsg="retMsgW" outnum="1"> 
      <wtc:param value="<%=weiyuejin[0]%>"/>
      <wtc:param value="<%=weiyuejin[1]%>"/>
    </wtc:service>  
    <wtc:array id="result_t"  scope="end"/>
    <%
      if("000000".equals(retCodeW)){
        if(result_t.length>0){
          if(Integer.parseInt(result_t[0][0])>0){ //大于0为非实名制用户
    			display="display:display";
          }
        }
      }else{
    %>
            <SCRIPT type=text/javascript>
              rdShowMessageDialog("错误信息：<%=retCodeW%><br>错误代码：<%=retMsgW%>",0);
              removeCurrentTab();
            </SCRIPT>
    <%   
      }
    }
    /* end liangyl add for 关于LTE-FI业务取消时免违约金需求的函@2016/9/7 */
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
  String custOrderId = WtcUtil.repNull(request.getParameter("custOrderId"));    //客户订单号
  String orderArrayId = WtcUtil.repNull(request.getParameter("orderArrayId"));  //客户订单子项ID
  String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));    //客户订单编号
  String servOrderId = WtcUtil.repNull(request.getParameter("servOrderId"));    //服务订单ID
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
String vFeeFlag="";
%>

<%
	if("e301".equals(opCode)){
		//7个标准化入参
		String paraAray[] = new String[8];
		paraAray[0] = "";                                       //流水
		paraAray[1] = "01";                                     //渠道代码
		paraAray[2] = opCode;                                   //操作代码
		paraAray[3] = (String)session.getAttribute("workNo");   //工号
		paraAray[4] = (String)session.getAttribute("password"); //工号密码
		paraAray[5] = phoneNo;                                  //用户号码
		paraAray[6] = "";                                       //用户密码
		paraAray[7] = "";									//备注
	%>
	<wtc:service name="se301Check" outnum="1" retmsg="checkMsg" retcode="checkCode" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />						
		<wtc:param value="<%=paraAray[7]%>" />						
	</wtc:service>
	<wtc:array id="checkResult" scope="end"  />
	<%
		if("000000".equals(checkCode)){
			vFeeFlag= checkResult[0][0];
		}
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
var thePageNum = 1;               //当前页数
var currentOfferId = "";          //销售品目录树展开的销售品ID
var CanOfferCancel = 0;           //销售品是否可退订标识
var CanUndoOpe = 0;               //撤消退订是否可操作标识
var CanOfferBook = 0;             //销售品是否可订购标识
var MainOfferFlag=0;
var thisMonthOfferId = "<%=offerId%>";
var operateFlag = 1;  //业务类型
var arrClassValue = new Array();
var offerIdArr = new Array();      //销售品ID
var offerNameArr=new Array();     //销售品名称（打印用）
var offerEffectTime = new Array();
var offerExpireTime = new Array();
var xqdm = "";
var WYJflag="0";
/*2014/12/03 9:24:16 gaopeng 小区资费无小区属性问题 
	加入小区代码下拉列表展示时，也就是ajax_jdugeAreaHidden.jsp 返回Y时，该资费为小区资费的全局变量，默认不是小区资费
*/
var xqjfFlag = false;
var zdxq="";
var vpmnstr1="";
var checke177flag="yes";
var checke177flag111="yes";
var offerTrafficflag="0"; //0是订购的主资费流量清零，非0为订购的主资费流量不清零----新申请的主资费
var offerdangqianflag="0"; //0是当前的主资费流量清零，非0为当前的主资费流量不清零----当前的的主资费
var thisMonthOfferIdArr=new Array();

$().ready(function(){
  
  $("#addedProdTab").hide(); 
  $("#prodUnbookTab").hide();
  $("#userInfoDiv").hide();   
  $("#userHadDiv").hide();  
  $("#roleInfoP").hide(); 
  $("#slTab").hide(); 
  if("<%=opCode%>"=="1255")
  {
      $("#slTab").show(); 
  }
  $("#qryOfferBtn").bind("click",qryMainOffer);
  <%
   if(resPosc!=null&&resPosc.length>0){
     if(resPosc[0][2].trim().equals("0")){
  %>
     //必须变更基本销售品
     MainOfferFlag=1;
    
  <%
    }else if(resPosc[0][2].trim().equals("1")){
  %>  
    //只准订购附加销售品
    $("#qryOfferBtn").unbind();
    $("#qryOfferBtn").bind("click",qryAddOffer);
    qryMainOfferRoleInfo();
    HoverLi(2,2);
    $("#tb_1").css("display","none");
  <%
    }else{    
  %>
    //不做任何限制
  
  <%    
    }
  }
  %>
  
    //selectBand();//初始化树
    qryOfferInst(); //查询用户当前订购关系
    
    //qryMainOfferRoleInfo(); //查购基本销售品的角色信息
    
    addSmCode();
    setOfferType();
    getCurrentOpeInfo();
  
  $("#showInfoDiv :checkbox").bind("click",showInfo);
  //$("[name='searchType']").bind("click",changeSearch);

  {
    //$("#rootTree").css("display","none"); 
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

  
  <%if(opCode.equals("1270")||opCode.equals("1272")){%>
  myFavorite();
  hotOffer(); 
  $("#show1270").show();    
  <%}else{%>  
  $("#show1270").hide();      
  <%}%>
  
  <%if(opCode.equals("3275")||opCode.equals("3257")||opCode.equals("4208")){%>
    //$("#leftSpan").hide();  
    //$("#right").hide(); 
    
    $('#left').animate({'marginLeft': "-395px"},'slow');  
    $("#right").removeClass();                     
    $("#leftSpan").attr("class","item-50 col-1");  
    //$("#leftSpan").removeClass();
    $('#leftSpan').animate({'marginLeft': "-495px"},'slow');
    $("#rightSpan").removeClass();
    //$("#rightSpan").attr("class","item-99 col-X");
  <%}%> 
  
  <%if(opCode.equals("1270")){%>
    ajaxGetMsg();
  <%}%>
  <%if(opCode.equals("1272") || opCode.equals("m365")){%>
    ajaxGetMsg1();
  <%}%>
  
  
  var countBaseOffer = $("#userHadOfferTab tr").length;
  for(var iw=1;iw<countBaseOffer;iw++){
    
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="基本"&&$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(4)").text()=="有效"){
      thisMonthOfferId2 = $("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text();
    }
  }
<%if(opCode.equals("3250")||opCode.equals("1272")){%> 
if(thisMonthOfferId2!=thisMonthOfferId) 
  thisMonthOfferId = thisMonthOfferId2;
<%}%>

//hejwa 2013年9月23日8:39:38 增加 客服默认不展示客户信息标签
  if("<%=OPflag%>"==2){
      $("#userInfoChkBox").get(0).checked = false;
      $("#userInfoDiv").hide();   
  }

}); 
var print12701255=false;
var retResult112701255="";
var retResult212701255="";
function go_showPrompt(){
	  var packet = new AJAXPacket("ajax_showPrompt.jsp","请稍后...");
	  packet.data.add("iOpCode","<%=opCode%>");
	  packet.data.add("iPhoneNo","<%=phoneNo%>");
	  packet.data.add("iUserPwd","");
	  packet.data.add("iOfferId","");
	  core.ajax.sendPacket(packet,do_showPrompt);
	  packet =null; 
	}
function do_showPrompt(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retCode = packet.data.findValueByName("retCode"); 
	if(retCode =="000000"){
		retResult112701255 = packet.data.findValueByName("retResult1");
		retResult212701255 = packet.data.findValueByName("retResult2");
		if(retResult112701255!=""&&retResult212701255!=""){
			alert("为保障您的权益，您原"+retResult212701255+"主资费包含的彩铃业务将为您免费保留一年，保留期间业务每月费用为"+retResult112701255+"元，系统每月赠送您"+retResult112701255+"元专款，相当于免费使用。该保留的彩铃业务随新主资费生效的日期开始起算，到期后如无变化此优惠将自动顺延一年，如有变化系统将提前1个月短信通知。");
			print12701255=true;
		}
		else{
			print12701255=false;
		}
	}
}

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
    //$("#searchTypeDiv").css("display","");
    //$("#rootTree").css("display","none");
    //$("#searchOfferConDiv").css("display","none");
    //$("#searchOfferConDiv").height(388);
    //$("#mainOfferChoiceDiv").css("display","none");
    $("#qryOfferBtn").unbind();
    $("#qryOfferBtn").bind("click",qryMainOffer);
    $("[name='searchType'][value='0']").attr("checked",true); 
    $("#offerType").parent().show();  
    $("#bindId").parent().show(); 
    $("#custType").parent().show(); 
    $("#roleInfoP").hide();
    operateFlag = 1;
  }else if(n == 2){
    //$("#searchTypeDiv").css("display","");
    //$("#rootTree").css("display","none");
    //$("#searchOfferConDiv").css("display","");
    //$("#searchOfferConDiv").height(388);
    //$("#mainOfferChoiceDiv").css("display","");
    $("#qryOfferBtn").unbind();
    $("#qryOfferBtn").bind("click",qryAddOffer);
    $("#offerListDiv").empty(); //清空可选销售品展示区
    $("#offerType").parent().hide();  //隐藏查询类型
    $("#bindId").parent().hide(); //隐藏业务品牌
    $("#custType").parent().hide(); //隐藏客户类型
    $("#roleInfoP").show();
    operateFlag = 2;
  }else if(n == 3){ 
                    
  }
} 
//主资费变更 销售品分类内容
function setOfferType(){
      var packet = new AJAXPacket("ajax_getOfferType.jsp","请稍后...");
      packet.data.add("opCode" ,"<%=opCode%>");
      packet.data.add("offerId" ,"<%=offerId%>"); 
      packet.data.add("smCode" ,document.all.bindId.value);
      packet.data.add("phoneNo","<%=phoneNo%>");
      core.ajax.sendPacket(packet,dosetOfferType);  
    } 
function  dosetOfferType(packet){

      var retResult = packet.data.findValueByName("retResult"); 
      var selectObj = document.getElementById("offerType");
      selectObj.length=0;
      //selectObj.options.add(new Option("--请选择--",""));
      for(var i=0;i<retResult.length;i++){
        var reg = /\s/g;     
        var ss = retResult[i][0].replace(reg,""); 
          if(ss.length!=0){
            selectObj.options.add(new Option(retResult[i][1],retResult[i][0]));
          }
        }
  
  /*zhangyan add*/
  var bindId = document.getElementById("bindId");

  if ("<%=opCode%>"=="1270")
  {
    if (bindId.value=="21")
    {
      selectObj.value="Yn70";
    }   
  }
}

//------查询用户当前订购关系---------
function qryOfferInst(){
  var packet = new AJAXPacket("qryOfferInst.jsp","请稍后...");
  packet.data.add("servId","<%=servId%>");
  packet.data.add("opCode","<%=opCode%>");
  core.ajax.sendPacketHtml(packet,doQryOfferInst);
  packet =null;
}
function doQryOfferInst(data){
  $("#userHadOfferDiv").html(data);
  $("[name='cancelBtn']").bind("click",cancelOffer);  
}

//-------已有订购关系退订-------------
function cancelOffer(){
  document.all.offerId40CanHv.value ="";
  document.all.offerName40CanHv.value ="";
  document.all.offerEffDateCanHv.value ="";
  
  
  CanOfferCancel = 0;
  var offerId = this.id.split("|")[0];
  var offerInstId = this.id.split("|")[1];  
  var offerName = this.id.split("|")[2];
  var offerEffDateCanHv = this.id.split("|")[3];
  var optype=this.optype;
  var exptime=document.getElementById("exp"+offerId).value;
  var efftime=document.getElementById("eff"+offerId).value;

  /*延期时校验日期*/
  if (optype=="Y")
  {
    var patrn = /^[0-9]*[1-9][0-9]*$/;
    var sInput =document.getElementById("exp"+offerId).value;
    if (sInput.search(patrn) == -1) {
      rdShowMessageDialog("失效时间必须是数字!",0) 
      return false
    }

    if ( exptime<=efftime )
    {
      rdShowMessageDialog("失效时间必须大于生效时间!",0)  
      return false
    }
    
    if ( exptime.length!=8 )
    {
      rdShowMessageDialog("失效日期必须8位,格式YYYYMMDD",0);
      return false;
    }
    if ( (parseInt(exptime.substring(4,6),10)>12 || (parseInt(exptime.substring(4,6),10)<1) ) )
    {
      rdShowMessageDialog("失效时间月份错误",0);
      return false;
    } 

    var yyyy=efftime.substring(0,4);
    var mm=efftime.substring(4,6);
    var dd=efftime.substring(6,8);        
    /*js可延期时间*/
    var y_yyyy ="";
    var y_mm="";
    //var y_dd="";
    
    if ((parseInt(mm,10)+4)>12)
    {
      y_mm=(parseInt(mm,10)+4)-12;
      y_yyyy=parseInt(yyyy,10)+1;
    }
    else
    {
      y_mm=parseInt(mm,10)+4; 
      y_yyyy=parseInt(yyyy,10);
    }
    if (y_mm<10)
    {
      y_mm="0"+y_mm;
    }

    var y_tm=y_yyyy+""+y_mm+"01";
      //alert(y_tm);
    if (exptime>y_tm)
    {
      rdShowMessageDialog("最多延期三个月,到"+y_tm+"日!",0);
      return false;
    }
    
  }
  //alert("offerId|"+offerId);
  document.all.offerId40CanHv.value += offerId+"|";
  document.all.offerName40CanHv.value +=offerName+"|";
  document.all.offerEffDateCanHv.value +=offerEffDateCanHv+"|";
  //alert("document.all.offerId40Hv.value|"+document.all.offerId40Hv.value);
  var packet = new AJAXPacket("cancelOffer.jsp","请稍后...");
  packet.data.add("loginAccept","<%=loginAccept%>");
  packet.data.add("offerId",offerId);
  packet.data.add("offerInstId",offerInstId);
  packet.data.add("servId","<%=servId%>");
  packet.data.add("opCode","<%=opCode%>");
  packet.data.add("optype",optype);
  packet.data.add("exptime",document.getElementById("exp"+offerId).value);
  core.ajax.sendPacket(packet,doCancelOffer);
  packet =null;
}
function doCancelOffer(packet){
  var errorCode = packet.data.findValueByName("errorCode");
  var errorMsg = packet.data.findValueByName("errorMsg");
  var optype = packet.data.findValueByName("optype");
  var offerId = packet.data.findValueByName("offerId");
  if(errorCode == 0){
    //rdShowMessageDialog("退订成功!");
    
    var packet = new AJAXPacket("checke177.jsp","请稍后...");
    packet.data.add("offerid",offerId);
    packet.data.add("optype",optype);
    packet.data.add("opCode","<%=opCode%>");
    packet.data.add("phoneNo","<%=phoneNo%>");
    core.ajax.sendPacket(packet,dochecke177);
    packet =null;
    
    if(checke177flag=="no") {
    return false;
    }
      
    getCurrentOpeInfo();
  }else{
    rdShowMessageDialog(errorMsg);
    return false; 
  }
}

function dochecke177(packet){
  var errorCode = packet.data.findValueByName("errorCode");
  var errormsg = packet.data.findValueByName("errorMsg");
  if(errorCode =="000000"){
  checke177flag="yes";    
  var returncode = packet.data.findValueByName("returncode");
  var returnmsg11 = packet.data.findValueByName("returnmsg");
  if(returncode=="000000") {
  }else {
  rdShowMessageDialog(returnmsg11);
  }
  }else{
    rdShowMessageDialog(errormsg);
    checke177flag="no";
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
	/*2015/04/20 10:37:40 gaopeng 撤销订购时处理*/
	
	if(useIntegralFlag == "true"){
		/*div*/
		$("#integralFiledAll").hide();
		/*选择*/
		$("input[name='ifUseIntegral']").attr("checked","");
		/*展示积分信息*/
		$("#IntegralFiled").hide();
		useIntegralFlag = "false";
	}
	
  var offerId = this.name.split("|")[0];
  var offerInstId = this.name.split("|")[1];  
  
  if(document.all.attrFlagOfferId.value ==offerId){  //删掉小区 初始化标志位 hejwa
      document.all.attrFlagHv.value="0";
      document.all.attrFlagOfferId.value = "0";
  }
  
  var packet = new AJAXPacket("undoOrder.jsp","请稍后...");
  packet.data.add("loginAccept","<%=loginAccept%>");
  packet.data.add("offerId",offerId);
  packet.data.add("offerInstId",offerInstId);
  packet.data.add("servId","<%=servId%>");
  packet.data.add("phoneNo","<%=phoneNo%>");
  packet.data.add("opCode","<%=opCode%>");
  core.ajax.sendPacket(packet,doUndoOrder);
  packet =null; 
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
  
  //alert(bindId);
  //var custType = $("#custType").val();
  var custType="";
  //alert($("#offerId").get(0));
  
  //if(!validateElement($("#offerId").get(0))){
    //return false; 
  //}
  /*
  if(offerType == "" && offerId == "" && offerName== ""){
    rdShowMessageDialog("请输入查询条件!");
    return false; 
  }
  */
  var packet = new AJAXPacket("qryMainOffer.jsp","请稍后...");
  packet.data.add("servId","<%=offerSrvId%>");
  packet.data.add("offerId",offerId);
  packet.data.add("relMainOfferId",thisMonthOfferId); //thisMonthOfferId在qryOfferInst.jsp中生成
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
  var roleId = $("#roleId").val();
  var offerId = $("#offerId").val();
  var offerName = $("#offerName").val();
  //alert($("#offerId").get(0));
  
  //if(!validateElement($("#offerId").get(0))){
    //return false; 
  //}
  
  var packet = new AJAXPacket("qryRealOfferId.jsp","请稍后...");
  packet.data.add("loginAccept","<%=loginAccept%>");
  packet.data.add("opCode","<%=opCode%>");
  core.ajax.sendPacket(packet,doQryRealOfferId);
  packet =null; 
  
  var relMainOfferId="";
  if(document.all.RealOfferId.value=="0"){
     relMainOfferId= thisMonthOfferId;    //默认为当月基本销售品
  }else{
     relMainOfferId= document.all.RealOfferId.value;
   }
  
  if($("input[name='mainOfferType']:checked").val() == 1){
    
  }
  
  var packet = new AJAXPacket("qryAddOffer.jsp","请稍后...");
  packet.data.add("servId","<%=servId%>");
  packet.data.add("relMainOfferId",relMainOfferId);
  packet.data.add("offerId",offerId);
  packet.data.add("roleId",roleId);
  packet.data.add("offerName",offerName);
  packet.data.add("opCode","<%=opCode%>");
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
  packet.data.add("relMainOfferId",thisMonthOfferId); //thisMonthOfferId在qryOfferInst.jsp中生成
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
     relMainOfferId= thisMonthOfferId;    //默认为当月基本销售品
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
  
        var countBaseOffer = $("#userHadOfferTab tr").length;
      var thisMonthOfferId2111="";
    for(var iw=1;iw<countBaseOffer;iw++){
    
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="基本"&&$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(4)").text()=="有效"){
      thisMonthOfferId2111 = $("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text();
    }
    }
  
    var packet = new AJAXPacket("checkeAddAndQuit.jsp","请稍后...");
    packet.data.add("offerid",thisMonthOfferId2111);
    packet.data.add("optype","3");
    packet.data.add("opCode","<%=opCode%>");
    packet.data.add("phoneNo","<%=phoneNo%>");
    packet.data.add("offerIddinggou",offer_id);
    core.ajax.sendPacket(packet,dochecke17722);
    packet =null;
    
    if(checke177flag=="no") {
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
	if("<%=opCode%>" == "e092"){
		/*先校验是否可以展示使用积分信息，校验成功则打开 openIntegral() */
		checkShowIntegral(offer_id);
		//diling add for 判断是否显示新版小区代码@2013/3/14
	}
	if("<%=opCode%>"=="1270"||"<%=opCode%>"=="1255"){
		go_showPrompt();
	}
	
	jdugeAreaHidden(offer_id);
  
}
var useIntegralFlag = "false";
/*打开是否使用积分页面方法*/
function openIntegral(){
	
	var path = "/npage/public/integralOpen.jsp?iOpCode=<%=opCode%>&iOpName=<%=opName%>";
	path += "&loginAccept=<%=loginAccept%>";
	path += "&iChnSource=01";
	path += "&iLoginNo=<%=workNo%>";
	path += "&iLoginPwd=<%=noPassWord%>";
	path += "&iKdNo="+$.trim($("#stPMvPhoneNo").val());
	/*使用showModalDialog方法 可以自动进行动作分解*/
	var returnVal = window.showModalDialog(path,"","dialogWidth=800px;dialogHeight=600px");
	//alert("true为返回使用积分信息---"+returnVal);
	
	var retArray = new Array();
	retArray = returnVal.split("|");
	
	/*直接赋值全局变量*/
	useIntegralFlag = retArray[0];
	/*如果使用积分了*/
	if(retArray[0] == "true"){
		/*div*/
		$("#integralFiledAll").show();
		/*选择*/
		$("input[name='ifUseIntegral']").attr("checked",true);
		$("input[name='ifUseIntegral']").attr("disabled","disabled");
		/*展示积分信息*/
		$("#IntegralFiled").show();
		
		var intePhoneNo = retArray[1];
		var intePassWord = retArray[2];
		var inteCustName = retArray[3];
		var inteNumber = retArray[4];
		var inteUseNum = retArray[5];
		var intePrice = retArray[6];
		
		$("#intePhoneNo").val(intePhoneNo);
		$("#intePassWord").val(intePassWord);
		$("#inteCustName").val(inteCustName);
		$("#inteNumber").val(inteNumber);
		$("#inteUseNum").val(inteUseNum);
		$("#intePrice").val(intePrice);
		
		$("#intePhoneNo").attr("class","InputGrey");
		$("#intePhoneNo").attr("readonly","readonly");
		$("#intePassWord").attr("class","InputGrey");
		$("#intePassWord").attr("readonly","readonly");
		$("#inteCustName").attr("class","InputGrey");
		$("#inteCustName").attr("readonly","readonly");
		$("#inteNumber").attr("class","InputGrey");
		$("#inteNumber").attr("readonly","readonly");
		$("#inteUseNum").attr("class","InputGrey");
		$("#inteUseNum").attr("readonly","readonly");
		$("#intePrice").attr("class","InputGrey");
		$("#intePrice").attr("readonly","readonly");
		$("#inteValide").attr("disabled","disabled");
		
		
	}else{
			/*div*/
			$("#integralFiledAll").hide();
			/*选择*/
			$("input[name='ifUseIntegral']").attr("checked","");
			/*展示积分信息*/
			$("#IntegralFiled").hide();
		
	}
	
}

/*2015/04/22 10:39:17 gaopeng 是否展示使用积分*/
var ifCheckIntegralFlag = false;
/*校验是否展示 是否使用积分复选框*/
function checkShowIntegral(offer_id){
		
		var getdataPacket = new AJAXPacket("/npage/public/fCheckShowIntegral.jsp","正在获得数据，请稍候......");
		getdataPacket.data.add("offer_id",offer_id);
		core.ajax.sendPacket(getdataPacket,doRetInteCheck);
		getdataPacket = null;
}
function doRetInteCheck(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var ifShowIntegFlag = packet.data.findValueByName("ifShowIntegFlag");
		
		if(retCode == "000000"){
			if(ifShowIntegFlag == "yes"){
				ifCheckIntegralFlag = true;
				/*弹出是否使用积分页面*/
				openIntegral();
				
			}else{
				ifCheckIntegralFlag = false;
				$("#integralFiledAll").hide();
				$("#ifUseIntegral").attr("checked",false);
			}
			
		}else{
			ifCheckIntegralFlag = false;
			rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
			$("#integralFiledAll").hide();
			$("#ifUseIntegral").attr("checked",false);
			
		}
}

		var globalMarkFlag = false;
		function markIntegral(){
			
			var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
			/*2015/04/22 10:42:04 gaopeng 选中则赋值 否则为空*/
			var iPhoneNo = ifUseIntegral == true ? $.trim($("#intePhoneNo").val()):"";
			var iUserPwd = ifUseIntegral == true ? $.trim($("#intePassWord").val()):"";
			var inteUseNum = ifUseIntegral == true ? $.trim($("#inteUseNum").val()):"";
			var iKdNo = $.trim($("#stPMvPhoneNo").val());
			var getdataPacket = new AJAXPacket("/npage/public/fMarkIntegral.jsp","正在获得数据，请稍候......");
			var iLoginAccept = "<%=loginAccept%>";
			
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=workNo%>";
			var iLoginPwd = "<%=noPassWord%>";
			var ifUseI = ifUseIntegral == true ? "1":"0";
			//alert(ifUseI);
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd","");
			getdataPacket.data.add("iKDNo",iKdNo);
			getdataPacket.data.add("inteUseNum",inteUseNum);
			getdataPacket.data.add("ifUseI",ifUseI);
			
			
			core.ajax.sendPacket(getdataPacket,doRetInteMark);
			getdataPacket = null;
			
			
		}
		function doRetInteMark(packet){
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");
				
				
				if(retCode == "000000"){
					
					globalMarkFlag = true;
					
				}else{
					rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
					globalMarkFlag = false;
				}
		}
		




function doApplyMainOffer(packet){
	
  var errorCode = packet.data.findValueByName("errorCode");
  var errorMsg = packet.data.findValueByName("errorMsg");
  if(errorCode == 0){
    getCurrentOpeInfo();
  }else{
    rdShowMessageDialog(errorMsg);
    return false; 
  }
}

function dochecke17722(packet){

  var errorCode = packet.data.findValueByName("errorCode");
  var errormsg = packet.data.findValueByName("errorMsg");
  if(errorCode =="000000"){
      checke177flag="yes";  
      checke177flag111="yes";
      var result = packet.data.findValueByName("result");
      if (result.length < 0){
          return;
      }
      
      
      for (var i = 0; i < result.length; i ++){
          returncode = result[i][0];
          returnmsg11 = result[i][1];
          
          if(returncode=="000000") {
          var offerid = packet.data.findValueByName("offerIddinggou");
          var packet = new AJAXPacket("checkeAddAndQuit.jsp","请稍后...");
            packet.data.add("offerid",offerid);
            packet.data.add("optype","1");
            packet.data.add("opCode","<%=opCode%>");
            packet.data.add("phoneNo","<%=phoneNo%>");
            core.ajax.sendPacket(packet,dochecke1772233);
            packet =null;
          
          }else {
              //zhouby
              rdShowMessageDialog(returnmsg11);
              //checke177flag="no";
                var offerid = packet.data.findValueByName("offerIddinggou");
              var packet = new AJAXPacket("checkeAddAndQuit.jsp","请稍后...");
            packet.data.add("offerid",offerid);
            packet.data.add("optype","1");
            packet.data.add("opCode","<%=opCode%>");
            packet.data.add("phoneNo","<%=phoneNo%>");
            core.ajax.sendPacket(packet,dochecke1772233);
            packet =null;
          }
      }
      
  }else{
    rdShowMessageDialog(errormsg);
    checke177flag="no";
    checke177flag111="no";
    return false;
  }
}

function dochecke1772233(packet){

  var errorCode = packet.data.findValueByName("errorCode");
  var errormsg = packet.data.findValueByName("errorMsg");

  if(errorCode =="000000"){
      checke177flag="yes";  
      checke177flag111="yes"; 
      var result = packet.data.findValueByName("result");
      if (result.length < 0){
          return;
      }
      for (var i = 0; i < result.length; i ++){
          returncode = result[i][0];
          returnmsg11 = result[i][1];
          if(returncode=="000000") {
      
          }else {
              //zhouby
              rdShowMessageDialog(returnmsg11);
              //checke177flag="no";
          }
      }
  }else{
    rdShowMessageDialog(errormsg);
    checke177flag="no";
    checke177flag111="no";
    return false;
  }
}

function jdugeAreaHidden(offer_id){

  var packet = new AJAXPacket("ajax_jdugeAreaHidden.jsp","请稍后...");
  packet.data.add("offerId",offer_id);
  packet.data.add("phoneNo","<%=phoneNo%>");
  packet.data.add("opCode","<%=opCode%>");
  core.ajax.sendPacket(packet,doJdugeAreaHidden);
  packet =null; 
} 

var v_hiddenFlag = "";
var v_code = new Array();
var v_text = new Array();
function doJdugeAreaHidden(packet){

  var retCode = packet.data.findValueByName("retCode");
  var retMsg =  packet.data.findValueByName("retMsg");
  var code =  packet.data.findValueByName("code");
  var text =  packet.data.findValueByName("text");
  var hiddenFlag =  packet.data.findValueByName("hiddenFlag");//是否显示小区代码标识
  var offer_id =  packet.data.findValueByName("offerId");//资费代码

  if(retCode == "000000"){
    v_hiddenFlag = hiddenFlag;
    if(code.length>0&&text.length>0){
      for(var i=0;i<code.length;i++){
        v_code[i] = code[i];
        v_text[i] = text[i];
        
      }
    }
    
   

        var countBaseOffer = $("#userHadOfferTab tr").length;

      var thisMonthOfferId2111="";
    for(var iw=1;iw<countBaseOffer;iw++){
    
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="基本"&&$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(4)").text()=="有效"){
      thisMonthOfferId2111 = $("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text();
    }
    }
  
    var packet = new AJAXPacket("checkeAddAndQuit.jsp","请稍后...");
    packet.data.add("offerid",thisMonthOfferId2111);
    packet.data.add("optype","3");
    packet.data.add("opCode","<%=opCode%>");
    packet.data.add("phoneNo","<%=phoneNo%>");
    packet.data.add("offerIddinggou",offer_id);
    core.ajax.sendPacket(packet,dochecke17722);
    packet =null;
    
    if(checke177flag=="no") {
    return false;
    }
    
    //$("input[name='ifUseIntegral']").attr("disabled","");
		var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
		//alert("true为记录使用积分值"+ifUseIntegral+"---是否为kf包年资费--"+ifCheckIntegralFlag);
		/*如果为kf包年资费，记录，就算不选中使用积分也记录，只不过记录空*/
		if(ifCheckIntegralFlag){
			markIntegral();
			if(!globalMarkFlag){
		    return false;
			}
		}

    var packet = new AJAXPacket("applyMainOffer.jsp","请稍后...");
    packet.data.add("loginAccept","<%=loginAccept%>");
    packet.data.add("offerId",offer_id);
    packet.data.add("servId","<%=servId%>");
    packet.data.add("phoneNo","<%=phoneNo%>");
    packet.data.add("opCode","<%=opCode%>");
    core.ajax.sendPacket(packet,doApplyMainOffer);
    
    packet =null; 
  }else{
    rdShowMessageDialog(retCode + ":" + retMsg,0);
    return false;
  }
}

//-------------------提取订购/退订信息--------------------
function getCurrentOpeInfo(){

  var packet = new AJAXPacket("getCurrentOpeInfo.jsp","请稍后...");
  packet.data.add("loginAccept","<%=loginAccept%>");
  packet.data.add("servId","<%=servId%>");
  core.ajax.sendPacket(packet,doGetCurrentOpeInfo);
  packet =null;   
}

function doGetCurrentOpeInfo(packet){

  for(var i=0;i<document.all.proOptFlag.length&&(typeof(document.all.proOptFlag.length)!="undefined");i++){
  
        document.all.offerIdArr[i].value = "";        
        document.all.offerNameArr[i].value = "";
        document.all.offerEffectTime[i].value = "";
        document.all.offerExpireTime[i].value = "";
        document.all.proOptFlag[i].value = "";
        document.all.offerZCflag[i].value = "";
        
  }
  
      document.all.offerIdHv.value = "";
      document.all.offerNameHv.value = "";
      document.all.offerTimeHv.value = "";
      document.all.offerId40Hv.value = "|";
      document.all.offerIDhitHv.value ="";
      document.all.offerId40Hv.value  = "";
      document.all.offerName40Hv.value = "";
      document.all.offerTim40EffHv.value  = "";
      document.all.offerName_alert.value = "";
 
             
  var errorCode = packet.data.findValueByName("errorCode");
  var errorMsg = packet.data.findValueByName("errorMsg");
  if(errorCode == 0){
    var retAry = packet.data.findValueByName("retAry");
    $("#addedOfferTab tr:gt(1)").remove();
    $("#addedProdTab tr:gt(1)").remove();
    $("#addedProdTab").hide();
    $("#offerUnbookTab tr:gt(1)").remove();
    $("#prodUnbookTab tr:gt(1)").remove();
    $("#prodUnbookTab").hide();
    var unsubscriptArr = new Array();
    $.each(retAry,function(i,n){
      var offer_id = n[3];
      var offerStatus = n[11];  //销售品状态 1： 订购 2：变更 3：退订
      var offerOrProd = n[13];  //销售品产品标识 0： 销售品 1: 产品
      if(offerStatus == "3" && offerOrProd == "1"){
        unsubscriptArr.push(offer_id);
      }
    });
  
    $.each(retAry,function(i,n){
      var buttonStr = "";
      var offerInstId = n[2];
      var offer_id = n[3];
      var offer_name = n[4];
      
      var effTime = n[5];
      var expTime = n[6];
      
      var attrFlag = n[7];
      
      var groupTypeId = n[8];
      var offerStatus = n[11];  //销售品状态 1： 订购 2：变更 3：退订
      var imageFlag = n[12];
      //alert("imageFlag|"+imageFlag);
      var offerOrProd = n[13];  //销售品产品标识 0： 销售品 1: 产品
      var offerType = n[14];

      if((offerStatus == 1 || offerStatus == 2) && offerOrProd == 0){
           //buttonStr+="<div id='basicInfo_"+offer_id+"' name='"+effTime+"|"+expTime+"|"+offerInstId+"' class='but_set'><span>基本信息</span></div>";  
        if(groupTypeId != 0){
          <%
            if(opCode.equals("7977")){
           %> 
             buttonStr+="<input name='"+offer_name+"' type='button' value='群组' id='group_"+offer_id+"' _groupId='"+groupTypeId+"' class='but_groups' />"; 
           <%
            }
           %>
        }
        
      if(attrFlag != "N"){
          if(document.all.attrFlagHv.value=="0"&&document.all.attrFlagOfferId.value==offer_id){
            buttonStr+="<input  type='button' name='offe_"+offer_name+"'  value='"+attrFlag+"' _offerInstId='"+offerInstId+"' effT='"+effTime+"'  id='att_"+offer_id+"' offid='"+offer_id+"' class='but_property_on' />";
          }else{
            buttonStr+="<input  type='button' name='offe_"+offer_name+"'  value='"+attrFlag+"' _offerInstId='"+offerInstId+"' effT='"+effTime+"' id='att_"+offer_id+"' offid='"+offer_id+"' class='but_property' />";
            
            document.all.attrFlagHv.value=offer_id;
            document.all.attrFlagOfferId.value = offer_id;
          }
        }
        
        if(n[14]=="10"){
            document.all.offerIdHv.value = offer_id;
            document.all.offerNameHv.value = offer_name;
            document.all.offerTimeHv.value = effTime;
            document.all.offerExpTime.value = expTime;
          }
          
        if(n[14]=="40"){
             document.all.offerId40Hv.value += offer_id+"|";
             document.all.offerName40Hv.value += offer_name+"|";
             document.all.offerEffDateCanHv.value+=effTime+"|";
             document.all.offerTim40Hv.value += effTime+"|";
             document.all.offerTim40EffHv.value += expTime+"|";
             
        } 
          
          document.all.offerIDhitHv.value+=offer_id+"~";

        if(imageFlag=="1"||imageFlag=="2"){
        	if(offer_id == "42423"){
        		$("#addedOfferTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name='' ><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,9)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,9)+"</td><td style='display:none;'><img src='/nresources/default/images/task-item-close1.gif' style='cursor:Pointer;' class='del_cls' name='"+offer_id+"|"+offerInstId+"' alt='不许删除选择的销售品' id='del_"+offer_id+"'></td>");
        	}else{
	          $("#addedOfferTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name='' ><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,9)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,9)+"</td><td><img src='/nresources/default/images/task-item-close1.gif' style='cursor:Pointer;' class='del_cls' name='"+offer_id+"|"+offerInstId+"' alt='删除选择的销售品' id='del_"+offer_id+"'></td>");
	        }
          
        }
        else{
        	if(offer_id == "42423"){
        		$("#addedOfferTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name='' ><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,9)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,9)+"</td><td style='display:none;'><img src='/nresources/default/images/task-item-close.gif' style='cursor:Pointer;' class='del_cls' name='"+offer_id+"|"+offerInstId+"' alt='不许删除选择的销售品' id='del_"+offer_id+"'></td>");
        	}else{
	          $("#addedOfferTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name='' ><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,9)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,9)+"</td><td><img src='/nresources/default/images/task-item-close.gif' style='cursor:Pointer;' class='del_cls' name='"+offer_id+"|"+offerInstId+"' alt='删除选择的销售品' id='del_"+offer_id+"'></td>");
	        }
        }
          
        $("#addedOfferTab").append("<input type='hidden' name='offerZCflag' value='"+n[14]+"' /><input type='hidden' name='offerIdArr' value='"+offer_id+"' /><input type='hidden' name='offerNameArr' value='"+offer_name+"'/><input type='hidden' name='offerEffectTime' value='"+effTime+"'/><input type='hidden' name='offerExpireTime' value='"+expTime+"'/><input type='hidden' name='proOptFlag' value='"+offerStatus+"'/><input type='hidden' name='offerOrProdFlag' value='"+offerOrProd+"'/></tr>");
        $("#addedOfferTab").append("<tr class='setInfoTr_"+offer_id+"' ><td colspan='6'>"+buttonStr+"</td></tr>");
        
        $("#tr_"+offer_id+" td:lt(5)").toggle(
          function (){
            $(this).parent().next().css("display","");
          },
          function (){
            $(this).parent().next().css("display","none");
          }
        );
          
        $("#addedOfferTab .del_cls").bind("click",cancelOrder); //撤销本次订购
        $("#addedOfferTab :button[id^='group']").bind('click', showGroup);
        $("#addedOfferTab :button[id^='att']").bind('click', showAttribute);
        $("div[id^='basicInfo_']").bind("click",setBasicInfo);
        }else if((offerStatus == 3 ||offerStatus=="Y" ) && offerOrProd == 0){
        if(imageFlag=="1"||imageFlag=="2"){/*task-item-close1 是红×*/
          $("#offerUnbookTab").append("<tr id='tr_"+offer_id+"'><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,8)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,8)+"</td><td><img src='/nresources/default/images/task-item-close1.gif' style='cursor:hand' alt='撤消退订' name='"+offer_id+"|"+offerInstId+"' ></td>");

        }
        else{
          $("#offerUnbookTab").append("<tr id='tr_"+offer_id+"'><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,8)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,8)+"</td><td><img src='/nresources/default/images/task-item-close.gif' style='cursor:hand' alt='撤消退订' name='"+offer_id+"|"+offerInstId+"' ></td>");
            if ( "40"==offerType )
            {
              document.all.offerName_alert.value += offer_name+",";         
            }	
          }
          
        
        $("#offerUnbookTab").append("<input type='hidden' name='offerZCflag' value='"+n[14]+"' /><input type='hidden' name='offerIdArr' value='"+offer_id+"' /><input type='hidden' name='offerNameArr' value='"+offer_name+"'/><input type='hidden' name='offerEffectTime' value='"+effTime+"'/><input type='hidden' name='offerExpireTime' value='"+expTime+"'/><input type='hidden' name='proOptFlag' value='"+offerStatus+"'/><input type='hidden' name='offerOrProdFlag' value='"+offerOrProd+"'/></tr>");
        $("#offerUnbookTab img").bind("click",undoCancel);  
      }else if((offerStatus == 1 || offerStatus == 2) && offerOrProd == 1){
        $("#addedProdTab").show();
        if(imageFlag=="1"||imageFlag=="2"){
          var existFlag = false;
          if(findStrInArr(offer_id,unsubscriptArr)){
            existFlag = true;
          }
          if(existFlag || rdShowConfirmDialog("您订购的主资费未绑定来电特服，是否同时订购来电？")==1)
          { 
            $("#addedProdTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name=''><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,8)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,8)+"</td><td><img src='/nresources/default/images/task-item-close1.gif' style='cursor:hand' class='del_cls' name='"+offer_id+"|"+offerInstId+"' alt='删除选择的产品' id='del_"+offer_id+"'></td>");
          }else{
              var packet = new AJAXPacket("undoOrder.jsp","请稍后...");
              packet.data.add("loginAccept","<%=loginAccept%>");
              packet.data.add("offerId",offer_id);
              packet.data.add("offerInstId",offerInstId);
              packet.data.add("servId","<%=servId%>");
              packet.data.add("phoneNo","<%=phoneNo%>");
              packet.data.add("opCode","<%=opCode%>");
              core.ajax.sendPacket(packet,doUndoOrder);
              packet =null;
          }
        }
        else{
          $("#addedProdTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name=''><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,8)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,8)+"</td><td><img src='/nresources/default/images/task-item-close.gif' style='cursor:hand' class='del_cls' name='"+offer_id+"|"+offerInstId+"' alt='删除选择的产品' id='del_"+offer_id+"'></td>");
          }
          
        
        
        $("#addedProdTab").append("<input type='hidden' name='offerZCflag' value='"+n[14]+"' /><input type='hidden' name='offerIdArr' value='"+offer_id+"' /><input type='hidden' name='offerNameArr' value='"+offer_name+"'/><input type='hidden' name='offerEffectTime' value='"+effTime+"'/><input type='hidden' name='offerExpireTime' value='"+expTime+"'/><input type='hidden' name='proOptFlag' value='"+offerStatus+"'/><input type='hidden' name='offerOrProdFlag' value='"+offerOrProd+"'/></tr>");
        $("#addedProdTab .del_cls").bind("click",cancelOrder);  //撤销本次订购
      }else if(offerStatus == 3 && offerOrProd == 1){
        $("#prodUnbookTab").show();
        
        
        if(imageFlag=="1"||imageFlag=="2"){
          $("#prodUnbookTab").append("<tr id='tr_"+offer_id+"'><td>"+offer_id+"</td><td>"+offer_name+"</td><td>"+effTime.substring(0,8)+"</td><td>"+expTime.substring(0,8)+"</td><td><img src='/nresources/default/images/task-item-close1.gif' style='cursor:hand' alt='撤消退订' name='"+offer_id+"|"+offerInstId+"' ></td>");
        }
        else{
          $("#prodUnbookTab").append("<tr id='tr_"+offer_id+"'><td>"+offer_id+"</td><td>"+offer_name+"</td><td>"+effTime.substring(0,8)+"</td><td>"+expTime.substring(0,8)+"</td><td><img src='/nresources/default/images/task-item-close.gif' style='cursor:hand' alt='撤消退订' name='"+offer_id+"|"+offerInstId+"' ></td>");
          }
        $("#prodUnbookTab").append("<input type='hidden' name='offerZCflag' value='"+n[14]+"' /><input type='hidden' name='offerIdArr' value='"+offer_id+"' /><input type='hidden' name='offerNameArr' value='"+offer_name+"'/><input type='hidden' name='offerEffectTime' value='"+effTime+"'/><input type='hidden' name='offerExpireTime' value='"+expTime+"'/><input type='hidden' name='proOptFlag' value='"+offerStatus+"'/><input type='hidden' name='offerOrProdFlag' value='"+offerOrProd+"'/></tr>");
        $("#prodUnbookTab img").bind("click",undoCancel);
      }   
      
      //getMidPrompt("10442",offer_id,"tr_"+offer_id);  
    
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

/*-------------改变查询方式:目录树/条件查询--------------
function changeSearch(){
  if(this.value == 0){
    $("#rootTree").css("display",""); 
    $("#searchOfferConDiv").css("display","none");  
  }else{
    $("#rootTree").css("display","none"); 
    $("#searchOfferConDiv").css("display","");  
  } 
}*/

//-------------设定销售品基本信息----------
function setBasicInfo(){
  var offerId = this.id.substring(10);
  var effTime = this.name.split("|")[0].substring(0,8); 
  var expTime = this.name.split("|")[1].substring(0,8);
  var offerInstId = this.name.split("|")[2];
    
  if($(this).attr("class") == "but_set"){
    var h=200;
    var w=800;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; scroll:no;resizable:no;location:no;status:no;help:no";
    var ret=window.showModalDialog("offerBasicInfo.jsp?&effTime="+effTime+"&expTime="+expTime+"&offerId="+offerId+"&offerInstId="+offerInstId+"&servId=<%=servId%>&phoneNo=<%=phoneNo%>&loginAccept=<%=loginAccept%>","",prop);
    if(typeof(ret) != "undefined" && ret != ""){    
      $("#effTimeTd_"+offerId).html(ret.split("|")[0]);
      $("#expTimeTd_"+offerId).html(ret.split("|")[1]);
      $(this).attr("class","but_set_on");
    } 
  }
  else{

  } 
}

function changePage(page){
  if(page == '1'){
    $("#page_"+showPageNum).css("display","none");  
    showPageNum = 1;
    $("#page_"+showPageNum).css("display","");  
    $("#changePageDiv span:eq(1)").html("当前第1页");
  }else if(page == 'N'){
    showPageNum++;
    if(showPageNum <= thePageNum-1){
      $("#page_"+(showPageNum-1)).css("display","none");
      $("#page_"+showPageNum).css("display","");  
      $("#changePageDiv span:eq(1)").html("当前第"+showPageNum+"页");
    }else{
      showPageNum--;
    } 
  }else if(page == 'P'){
    showPageNum--;
    if(showPageNum >= 1){
      $("#page_"+(showPageNum+1)).css("display","none");
      $("#page_"+showPageNum).css("display","");
      $("#changePageDiv span:eq(1)").html("当前第"+showPageNum+"页"); 
    }else{
      showPageNum++;
    } 
  } else if(page == 'E'){
    $("#page_"+showPageNum).css("display","none");  
    showPageNum = thePageNum-1;
    $("#page_"+showPageNum).css("display","");  
    $("#changePageDiv span:eq(1)").html("当前第"+showPageNum+"页");
  }
    
}

/*
function selectBand(){
  var band_id = "9999";//根节点ID
  var packet = new AJAXPacket("/npage/portal/shoppingCar/ajax_sCatalogItem.jsp","请稍后...");
  packet.data.add("band_id" ,band_id);
  packet.data.add("goodKind","");
  core.ajax.sendPacket(packet,doSCatalogItem);
  packet =null;
}

function doSCatalogItem(packet){
  var retCode = packet.data.findValueByName("retCode"); 
  var retMsg = packet.data.findValueByName("retMsg"); 
  var backArrMsg = packet.data.findValueByName("backArrMsg");
  
  var good = "";
  if(backArrMsg==null||backArrMsg==""){
    rdShowMessageDialog("没有查询到您所需的数据");
  }else{
    if(retCode==0)
    {
      document.getElementById("rootTree").innerHTML="";
      if(good=="130"){
        tree1 = new stdTree("tree","rootTree");
        tree1.imgSrc="<%=request.getContextPath()%>/nresources/default/images/mztree/"
        with(tree1)
        {
          for(var i=0 ; i<backArrMsg.length; i++)
          { 
            var parentID = backArrMsg[i][3]==0?"000":backArrMsg[i][3]
              eval("N[\""+backArrMsg[i][0]+"\"]=\""+backArrMsg[i][0]+";"+backArrMsg[i][1]+";"+parentID+";1\"");   
          }
        }
        tree1.writeTree();
        tree1=null;
      }else{
          tree1 = new stdTree("tree","rootTree");
          tree1.imgSrc="<%=request.getContextPath()%>/nresources/default/images/mztree/"
          with(tree1)
          {
            for(var i=0 ; i<backArrMsg.length; i++)
            { 
              var parentID = backArrMsg[i][3]==0?"000":backArrMsg[i][3];
              
                eval("N[\""+backArrMsg[i][0]+"\"]=\""+backArrMsg[i][0]+";"+backArrMsg[i][1]+";"+parentID+";1\"");   

            }
          }
          tree1.writeTree();
          $("#rootTree img:first").click();
          tree1=null;
      }
    }
    else
    {
      rdShowMessageDialog("sCatalogItem失败!请联系管理员!");
    }
  }
}

//点击树节点触发事件
function stGetTreeNode(chId){
  productOfferQryByCat(chId);//查询附加销售品信息(按目录)
}

//查询销售品信息(按目录)
function productOfferQryByCat(nodeID)
{
    var channelSegment="";//渠道类型标识
    var packet = new AJAXPacket("/npage/portal/shoppingCar/ajax_productOfferQryByCat.jsp","请稍后...");
    packet.data.add("catalog_item_id" ,nodeID);
    packet.data.add("channelSegment" ,channelSegment);
    core.ajax.sendPacket(packet,doProductOfferQryByCat,true);
    packet =null;
}

//回调方法
function doProductOfferQryByCat(packet)
{
  var catalog_item_id = packet.data.findValueByName("catalog_item_id"); 
  
  var retCode = packet.data.findValueByName("retCode"); 
  var retMsg = packet.data.findValueByName("retMsg"); 
  var backArrMsg = packet.data.findValueByName("backArrMsg");
  if(backArrMsg==null||backArrMsg==""){
    rdShowMessageDialog("没有查询到您所需的数据");
    $("#img_"+catalog_item_id).attr("src","<%=request.getContextPath()%>/nresources/default/images_sx/mztree//closed.gif");
    $("#ul_"+catalog_item_id).css("display","none");
  }else{
    if(retCode==0){
        $("#rootTree [id*='a_']").css({ "font-size": "", "color": "","font-weight": ""}); 
        $("#img_"+currentOfferId).attr("src","<%=request.getContextPath()%>/nresources/default/images_sx/mztree//closed.gif");  //将图标置为收起状态
        $("#ul_"+currentOfferId).css("display","none"); //子节点为不可见,它为是否查询叶子的判断条件
        initTab(backArrMsg);
        $("#a_"+catalog_item_id).css({ "font-size": "medium", "color": "green","font-weight": "bold"}); 
        currentOfferId = catalog_item_id;
    }
    else{
      rdShowMessageDialog("销售品查询失败!请联系管理员!");
    }
  }
}

function initTree(){
  $("#rootTree [id*='a_']").css({ "font-size": "", "color": "","font-weight": ""}); 
  $("#img_"+currentOfferId).attr("src","<%=request.getContextPath()%>/nresources/default/images_sx/mztree//closed.gif");  //将图标置为收起状态
  $("#ul_"+currentOfferId).css("display","none"); //子节点为不可见,它为是否查询叶子的判断条件 
  currentOfferId = "";
  $("#offerListDiv table").remove();
  $("#changePageDiv").css("display","none");
  $("#offerCommentsDiv").empty();
  $("#offerSelectedListTab").find("tr:gt(0)").remove(); //删除已选列表中其他已选的销售品
}
*/

function showGroup(){
  var offerId = this.id.substring(6);
  var offerName = this.name;
  var groupTypeId = this._groupId;
  var effTime = $("#effTimeTd_"+offerId ).text(); 
  var expTime =$("#expTimeTd_"+offerId).text(); 

  var curDate = new Date().getTime();
  var h=600;   
  var w=800;
  var t=screen.availHeight/2-h/2;
  var l=screen.availWidth/2-w/2;
  var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
  if($(this).attr("class") == "but_groups"){
  var ret=window.showModalDialog("famChgMain.jsp?custName="+document.all.custName.value+"&phoneNo=<%=phoneNo%>&loginAccept=<%=loginAccept%>&servId=<%=servId%>&opCode=<%=opCode%>&offerId="+offerId+"&offerName="+offerName+"&groupTypeId="+groupTypeId+"&brandID="+"<%=brandID%>"+"&curTime="+curDate+"&effTime="+effTime+"&expTime="+expTime,"",prop);
    if(typeof(ret) != "undefined"){
      //$(this).attr("class","but_groups_on");
      //groupHash[offerId]=ret.toString();  //将返回的群组信息对应offerId放入
      //
      //var offerGroupInfo = "";    //组装销售品的群组信息,格式:offerId,groupinfo1,groupinfo2,~
      //offerGroupInfo += offerId;
      //offerGroupInfo += "|";
      //var temp = ret.toString().split("/");
      //
      //$.each(temp[0].split("$"),function(i,n){
      //  if(typeof(n) != "undefined"){
      //    if(i<6){                      //前6个为群组基本信息,后面的为它的属性信息
      //      offerGroupInfo += n.split("~")[1];  
      //      offerGroupInfo += "$";  
      //    }
      //    else{
      //      offerGroupInfo += n.substring(2); //去除"s_",id~value
      //      offerGroupInfo += "$";
      //    }
      //  } 
      //});
      //offerGroupInfo += "/";  
      //
      //offerGroupInfo+=temp[1];
      //offerGroupHash[offerId] = offerGroupInfo;
    } 
    else{
      rdShowMessageDialog("未设置群组！");  
      return false;
    }
  }
  else{
    var ret=window.showModalDialog("famChgMain.jsp?custName="+document.all.custName.value+"&phoneNo=<%=phoneNo%>&loginAccept=<%=loginAccept%>&servId=<%=servId%>&opCode=<%=opCode%>&offerId="+offerId+"&offerName="+offerName+"&groupInfo="+groupHash[offerId]+"&groupTypeId="+groupTypeId,"",prop);
    if(typeof(ret) != "undefined"){
      //groupHash[offerId]=ret; //将返回的群组信息对就offerId放入
      //
      //var offerGroupInfo = "";    //组装销售品的群组信息,格式:offerId,groupinfo1,groupinfo2,~
      //offerGroupInfo += offerId;
      //offerGroupInfo += "|";
      //var temp = ret.toString().split("/");
      //$.each(temp[0].split("$"),function(i,n){
      //  if(typeof(n) != "undefined"){
      //    if(i<6){                      //前6个为群组基本信息,后面的为它的属性信息
      //      offerGroupInfo += n.split("~")[1];  
      //      offerGroupInfo += "$";  
      //    }
      //    else{
      //      offerGroupInfo += n.substring(2); //去除"s_"
      //      offerGroupInfo += "$";
      //    }
      //  } 
      //});
      //offerGroupInfo += "/";  
      //
      //offerGroupInfo+=temp[1];
      //offerGroupHash[offerId] = offerGroupInfo;
    }
  } 
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
	  var obj = new Object();
	  obj.code = v_code;
	  obj.text = v_text;
    if(v_hiddenFlag=="Y"){ //当为Y时，进入新版小区代码展示页面
      var ret=window.showModalDialog("showAttrNew.jsp?queryId="+queryId+"&offerInstId="+offerInstId+"&queryType="+queryType+"&loginAccept=<%=loginAccept%>&servId=<%=servId%>&opCode=<%=opCode%>&opName=<%=opName%>&effT="+effT+"&offerId="+offid+"&phoneNo=<%=phoneNo%>",obj,prop);
    }else{
      if("<%=region_flag%>"=="sx"&&queryId=="9001"){
      var ret=window.showModalDialog("/npage/s1104/addGroupInfo.jsp?queryId="+queryId+"$","",prop);
      }else{
        var ret=window.showModalDialog("showAttr.jsp?queryId="+queryId+"&offerInstId="+offerInstId+"&queryType="+queryType+"&loginAccept=<%=loginAccept%>&servId=<%=servId%>&opCode=<%=opCode%>&opName=<%=opName%>&effT="+effT,obj,prop);
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
          	/*为小区资费时，赋值全局变量为小区资费true*/
						xqjfFlag = true;
            xqdm=attrValue.replace("$","").trim();
          }
          if(attrId=="5100")
          {
            zdxq=attrValue.replace("$","").trim();
          }
        }
        if(xqjfFlag == true){
					if(xqdm.length == 0){
						rdShowMessageDialog("获取小区资费错误!，请联系系统管理员",0);
						return false;
					}
				}
        AttributeHash[queryId]=ret; //将返回的群组信息对应queryId放入
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
  <%if(opCode.equals("1270")||opCode.equals("1272")){%>
  $("#offerListDiv").append("<table id='offerListTab'><thead><tr style='cursor:hand'><th  onclick=\"sortTable('offerListTab',0,'zh')\">销售品ID</th><th  onclick=\"sortTable('offerListTab',1,'zh')\">销售品名称</th><th>订购&nbsp;收藏&nbsp;详情</th></tr></thead></table>");
  <%}else{%>
    $("#offerListDiv").append("<table id='offerListTab'><thead><tr style='cursor:hand'><th  onclick=\"sortTable('offerListTab',0,'zh')\">销售品ID</th><th  onclick=\"sortTable('offerListTab',1,'zh')\">销售品名称</th><th>订购&nbsp;详情</th></tr></thead></table>");
  <%}%>
  for(var i=0 ; i<retAry.length; i++){
    var offer_id = retAry[i][0];
    var offer_name = retAry[i][1];
    var attrFlag = retAry[i][6];
    
    var offerIds=offer_id+"|";
    var divOfferIds= "coltr_"+offer_id+"|";
    /*
    var effDate = retAry[i][2];
    var expDate = retAry[i][3];
    var offerType = retAry[i][4];
    var offerCataType = retAry[i][5];
    var attrFlag = retAry[i][6];
    var groupTypeId = retAry[i][7];
    var retVal = offer_id+"|"+offer_name+"|"+effDate+"|"+expDate+"|"+offerType+"|"+groupTypeId+"|"+attrFlag;
    */
      //$("#offerListTab").append("<tr id='coltr_"+offer_id+"'><td>"+offer_id+"</td><td>"+offer_name+"</td><td><img src='/nresources/default/images/ab1.gif' style='cursor:hand' alt='订购' id='col_"+offer_id+"' onClick='addOffer("+offer_id+")' />&nbsp;&nbsp;&nbsp;<span><img src='/nresources/default/images/icon_arrow_down.gif' style='cursor:hand' name='' alt='加入我的收藏' id='col_"+offer_id+"' onClick='addMyCollection(this)'></span><img src='/nresources/default/images/child.gif' style='cursor:hand' name='' alt='查看详细信息' id='detail_"+offer_id+"' onClick='showdesc("+offer_id+",0)'></td></tr>");
      <%if(opCode.equals("1270")||opCode.equals("1272")){%>
        $("#offerListTab").append("<tr><td>"+offer_id+"</td><td  id='coltr_"+offer_id+"'>"+offer_name+"</td><td><img src='/nresources/default/images/ab1.gif' style='cursor:hand' alt='订购' id='col_"+offer_id+"' onClick='addOffer("+offer_id+")' />&nbsp;&nbsp;&nbsp;<span><img src='/nresources/default/images/icon_arrow_down.gif' style='cursor:hand' name='' alt='加入我的收藏' id='col_"+offer_id+"' onClick='addMyCollection(this)'></span><img src='/nresources/default/images/child.gif' style='cursor:hand' name='' alt='查看详细信息' id='detail_"+offer_id+"' onClick='showdesc("+offer_id+",0)'></td></tr>");
      <%}else{%>
        $("#offerListTab").append("<tr><td>"+offer_id+"</td><td  id='coltr_"+offer_id+"'>"+offer_name+"</td><td><img src='/nresources/default/images/ab1.gif' style='cursor:hand' alt='订购' id='col_"+offer_id+"' onClick='addOffer("+offer_id+")' />&nbsp;&nbsp;&nbsp;</span><img src='/nresources/default/images/child.gif' style='cursor:hand' name='' alt='查看详细信息' id='detail_"+offer_id+"' onClick='showdesc("+offer_id+",0)'></td></tr>");
      <%}%>
     // getMidPrompt("10442",offer_id,"coltr_"+offer_id);
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

//将销售品加入到我的收藏 
function addMyCollection(_this){
  var offerId = _this.id.substring(4);
  var packet = new AJAXPacket("/npage/portal/shoppingCar/addToCollection.jsp","请稍后...");
  packet.data.add("offerId",offerId);
  core.ajax.sendPacket(packet,doAddMyCollection);
  packet =null;
}
function doAddMyCollection(packet){ 
  var retCode = packet.data.findValueByName("errorCode");
  var retMsg =  packet.data.findValueByName("errorMsg");
  if(retCode == "0"){
    var showMsg =  packet.data.findValueByName("showMsg");
    rdShowMessageDialog(showMsg);   
  }else{
    rdShowMessageDialog(retMsg);  
  }
}

//查询我的收藏销售品信息 
function qryMyCollection(){
  var packet = "";
  if(operateFlag == 1){
    packet = new AJAXPacket("qryMainOffer.jsp","请稍后...");
  }else{
    packet = new AJAXPacket("qryAddOffer.jsp","请稍后...");  
  } 
  packet.data.add("servId","<%=servId%>");
  packet.data.add("relMainOfferId",thisMonthOfferId); 
  packet.data.add("loginCollect","LOGINCOLLECT");
  packet.data.add("opCode","<%=opCode%>");
  core.ajax.sendPacket(packet,doQryMyCollection);
  packet =null; 
}
function doQryMyCollection(packet){ 
  var retCode = packet.data.findValueByName("errorCode");
  var retMsg =  packet.data.findValueByName("errorMsg");
  if(retCode == 0){
    var retAry =  packet.data.findValueByName("retAry");
    if(retAry.length > 0){
      initTab(retAry);
      $("#offerListDiv tr span").html("<img src='/nresources/default/images/icon_arrow_up.gif' style='cursor:hand' name='' alt='从我的收藏中删除' onClick='delMyCollection(this)'>");
    }else{
      $("#offerListDiv table").remove();
      rdShowMessageDialog("我的收藏为空！");   
    }
  }else{
    rdShowMessageDialog(retMsg);  
  }
}

//将销售品从我的收藏中删除 
function delMyCollection(_this){
  var offerId = $(_this).parents("tr").find("td:first").text();
  $(_this).parents("tr").remove();
  var packet = new AJAXPacket("/npage/portal/shoppingCar/delMyCollection.jsp","请稍后...");
  packet.data.add("offerId",offerId);
  core.ajax.sendPacket(packet,doDelMyCollection);
  packet =null;
}
function doDelMyCollection(packet){ 
  var retCode = packet.data.findValueByName("errorCode");
  var retMsg =  packet.data.findValueByName("errorMsg");
  if(retCode == "0"){
    rdShowMessageDialog("已在我的收藏中删除！");    
  }else{
    rdShowMessageDialog(retMsg);  
  }
} 


//查询热点销售品信息 
function qryHotOffer(){
  var packet = "";
  if(operateFlag == 1){
    packet = new AJAXPacket("qryMainOffer.jsp","请稍后...");
  }else{
    packet = new AJAXPacket("qryAddOffer.jsp","请稍后...");  
  } 
  packet.data.add("servId","<%=servId%>");
  packet.data.add("relMainOfferId",thisMonthOfferId);
  packet.data.add("hotOffer","HOTOFFER");
  packet.data.add("opCode","<%=opCode%>");
  core.ajax.sendPacket(packet,doQryHotOffer);
  packet =null; 
}
function doQryHotOffer(packet){ 
  var retCode = packet.data.findValueByName("errorCode");
  var retMsg =  packet.data.findValueByName("errorMsg");
  if(retCode == 0){
    var retAry =  packet.data.findValueByName("retAry");
    if(retAry.length > 0){
      initTab(retAry);
    }else{
      $("#offerListDiv table").remove();
      rdShowMessageDialog("未查询到热点销售品！");
    }
  }else{
    rdShowMessageDialog(retMsg);  
  }
}

function qryProdAttr(){
   var param="";
   
    $("#addedOfferTab tr:gt(1)").each(
    function(){
      var vv=$(this).find("td:eq(1)").html();
      if(vv!=null){
       param+=vv+",";
       }
    }
  );
   
    var packet = new AJAXPacket("qryProduct.jsp","请稍后...");
    packet.data.add("param" ,param);
    core.ajax.sendPacket(packet,cfm);
    packet =null;
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
function setBusInfo(packet)
{
	var	retCode	=packet.data.findValueByName("retCode"); 	
	var	retMsg	=packet.data.findValueByName("retMsg"); 	

	if (!( retCode=="000000" ) )
	{
		document.all.bFCode.value=retCode;
		document.all.bFMsg.value=retMsg;
	}
	else
	{
		document.all.bFCode.value="000000";
		document.all.bFMsg.value="校验成功";
	}
}



var is_sWLWOffCheck = true;

function go_sWLWOffCheck(){
	
					var iOfferIdStr    = "";
					var iOfferStateStr = "";
					var iFlagStr       = "";
					
				  var tempArray1 = document.all.offerIdArr;
				  var tempArray2 = document.all.offerNameArr;
				  var tempArray3 = document.all.offerEffectTime;
				  var tempArray4 = document.all.offerExpireTime;
				  var tempArray5 = document.all.proOptFlag;
				  var tempArray6 = document.all.offerZCflag;
				  
				  for(var h=0;h<tempArray5.length;h++){
				    if(tempArray6[h].value!="40"&&(typeof(tempArray6[h])!="undefined")){
				      ;
				    }else {
				    	
				    	iOfferIdStr += tempArray1[h].value+"#";
				    	
				    	if(tempArray5[h].value=="1"){
				    		iOfferStateStr += "N"+"#";
				    		
				        if("<%=current_time%>"==tempArray3[h].value.substring(0,8)){       
				        	iFlagStr += "0"+"#";   
				        }else{
				        	iFlagStr += "2"+"#";
				        }
				        
				      }
				      else if(tempArray5[h].value=="3"){
				      	iOfferStateStr += "Y"+"#";
				      	
				        if("<%=current_time%>"==tempArray4[h].value.substring(0,8)) {  
				          iFlagStr += "0"+"#";   
				        }else{
				          iFlagStr += "2"+"#";
				        }
				      }  
				      
				    }
				  }
				  
				  
		  var myPacket = new AJAXPacket("f1272_sWLWOffCheck.jsp","正在进行物联网资费互斥依赖校验，请稍候......");
		  myPacket.data.add("iOfferIdStr",iOfferIdStr);//
		  myPacket.data.add("iOfferStateStr",iOfferStateStr);//
		  myPacket.data.add("iFlagStr",iFlagStr);//
		  myPacket.data.add("opCode","<%=opCode%>");//
		  myPacket.data.add("phoneNo","<%=phoneNo%>");//手机号
      core.ajax.sendPacket(myPacket,do_sWLWOffCheck);
      myPacket=null;
}

function do_sWLWOffCheck(packet){
	  var resultCode = packet.data.findValueByName("retCode");
    var resultMsg =  packet.data.findValueByName("retMsg");
    if("000000"==resultCode){
    	is_sWLWOffCheck = true;
    }else{
    	is_sWLWOffCheck = false;
    	rdShowMessageDialog("错误代码："+resultCode+",错误信息："+resultMsg);
    }
}





function cfm(packet){
	

	/*2014/07/17 16:51:53 gaopeng 把这个参数提前*/
	var flag= packet.data.findValueByName("flag");
	/*zhangyan add*/
	if("<%=opCode%>" == "e301" )
	{
		
		/*指定Ajax调用页*/
		var busAJAXpacket = new AJAXPacket("../public/pubBUSAPIAjax.jsp"
			,"请稍后...");
		/*给ajax页面传递参数*/
		busAJAXpacket.data.add("netCode"
			,"<%=broadPhone%>");
		busAJAXpacket.data.add("opCode","<%=opCode%>" );
		/*调用页面,并指定回调方法*/
		core.ajax.sendPacket(busAJAXpacket,setBusInfo,false);
		busAJAXpacket=null;		
	}
		if("<%=opCode%>" == "e301")
	{
		if (!(  document.all.bFCode.value=="000000") )
		{
			rdShowMessageDialog(document.all.bFMsg.value , 0);
			return false;
		}
	}		
  
  var returnVal = "";
  var alert_offer_name=document.all.offerName_alert.value ;

  if (""!=alert_offer_name  )
  {
    if ("1"!=   window.showModalDialog("/npage/s1270/confirm.jsp?offerName_alert="
      +alert_offer_name+"&rnd="
      +Math.random(),"" , "status=no;center=yes;help=no;dialogWidth=440px;dialogHeight=320px;scroll=yes;resize=no"))
    {
      return false; 
    }
  }
  var subFlag=false;
  if(typeof($("#isWeiyuejin").val())!="undefined"){
	  if($("#weiyuejinNote").val().trim()==""){
		  rdShowMessageDialog("违约金备注不能为空!");
		  subFlag=true;
	  }
	  else{
		  subFlag=false;
	  }
  }
  if(subFlag){
	  return false;
  }
  
  if(g("addedOfferTab").rows.length==2&&g("offerUnbookTab").rows.length==2)
  {
      rdShowMessageDialog("未做任何关系调整,请选择订购或退订销售品！");
      return false;
  }else if(MainOfferFlag==1&&g("addedOfferTab").rows.length==2)
  {
    rdShowMessageDialog("<%=opName%>必须订购新的基本销售品！");
    return false;
  }
  if(document.all.attrFlagHv.value!="0")
  {
    var offid=document.all.attrFlagHv.value;
    
    var packet = new AJAXPacket("qryAttrFlagHvMsg.jsp","请稍后..."); 
    packet.data.add("offerId",offid);
    core.ajax.sendPacket(packet,doQryAttrFlagHvMsg);
    packet =null; 
    
    var offMsg=document.all.attrFlagHvMsg.value;
    rdShowMessageDialog("请设置订购销售品["+offid+"]的"+offMsg+"属性");
    return false;
  }
  
  $("#offerSelectedListTab tr:gt(0)").each(function(i,n){
     returnVal = returnVal+n.name+"|";
  });
  
  //window.returnValue = returnVal;
  //window.close();
  getAfterPrompt(); 
  if($("#slChk").get(0).checked)
  {
      document.all.chkFlag.value="1";
  }

  if(flag=="1"){
  var newSmCode = document.all.bindId[document.all.bindId.selectedIndex].value.substring(0,2);
  var oldSmCode='<%=smCode%>';
  var userCardCode = '<%=cardCode%>';
  
  if(oldSmCode == "24")
  {
    //薛英哲 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@关于积分清零条件调整的需求 zn->gn 积分不清零
    /* ningtn 积分清零需求 */
  }
  else
  {
    if(newSmCode != oldSmCode)
    {
      if(oldSmCode == "21"){
        if((userCardCode == "01" || userCardCode == "02" || userCardCode == "03")){
          //rdShowMessageDialog("该操作涉及到品牌变更，您的现有积分（或M值）将于品牌变更生效时失效，请您及时兑换; ");
          rdShowMessageDialog("您目前为全球通VIP会员，如变更品牌，您的VIP会员资格将于业务生效后自动取消。");
        }
        /* else{
          rdShowMessageDialog("非全球通客户将不能参与VIP评定。");
        } */
      }else{
        //rdShowMessageDialog("该操作涉及到品牌变更，您的现有积分或M值将于品牌变更生效时失效，请您在新资费生效前及时兑换。");
      }
                if(oldSmCode != "24" && newSmCode=="24" && oldSmCode !="") {//
            checksmz();
            var smzvalues =document.all.smzvalue.value.trim();
            if(smzvalues=="3") {//非实名制全球通、动感地带客户转移为神州行客户
              rdShowMessageDialog("<%=readValue("1270","ps","jf",Readpaths)%>");
            }
          }
    }
  }
  
  }

  document.all.tonote.value="<%=workNo%>为客户<%=gCustId%>做<%=opName%>";
  
		//修改1272，如果是物联网用户（sm_code=PB)，在确认按钮提交前调用一个服务sWLWOffCheck
		// hejwa add 2015-8-6 13:44:00
		// 后台人员 liyan
		
		if("1272"=="<%=opCode%>"&&$("#stPMsm_code").val()=="PB"){
			go_sWLWOffCheck();
		}
		getPubSmCode("<%=broadPhone%>");
		var pubSmCodess = $("#pubSmCode").val();	
		//alert(pubSmCodess);	
		
		if("e092"=="<%=opCode%>" && pubSmCodess=="ki"){			
					var iOfferIdStr    = "";
					var iOfferStateStr = "";
					var iFlagStr       = "";
					
				  var tempArray1 = document.all.offerIdArr;
				  var tempArray2 = document.all.offerNameArr;
				  var tempArray3 = document.all.offerEffectTime;
				  var tempArray4 = document.all.offerExpireTime;
				  var tempArray5 = document.all.proOptFlag;
				  var tempArray6 = document.all.offerZCflag;
				  
				  for(var h=0;h<tempArray5.length;h++){
				    if(tempArray6[h].value!="40"&&(typeof(tempArray6[h])!="undefined")){
				    
				      
				    }else {
				    	
 				    	if(tempArray1[h].value.length==4 || tempArray1[h].value.trim().length==0) {
				    	 continue;
				    	}
				    	//alert(tempArray1[h].value);
				    	iOfferIdStr += tempArray1[h].value+"#";
				    	
				    	if(tempArray5[h].value=="1"){
				    		iOfferStateStr += "N"+"#";
				    		
				        if("<%=current_time%>"==tempArray3[h].value.substring(0,8)){       
				        	iFlagStr += "0"+"#";   
				        }else{
				        	iFlagStr += "2"+"#";
				        }
				        
				      }
				      else if(tempArray5[h].value=="3"){
				      	iOfferStateStr += "Y"+"#";
				      	
				        if("<%=current_time%>"==tempArray4[h].value.substring(0,8)) {  
				          iFlagStr += "0"+"#";   
				        }else{
				          iFlagStr += "2"+"#";
				        }
				      } 
				      
				    }
				  }
				  //alert(iOfferIdStr);
		  var myPacket = new AJAXPacket("fe092_sWLWOffCheck.jsp","正在进行物联网资费互斥依赖校验，请稍候......");
		  myPacket.data.add("iOfferIdStr",iOfferIdStr);//
		  myPacket.data.add("iOfferStateStr",iOfferStateStr);//
		  myPacket.data.add("iFlagStr",iFlagStr);//
		  myPacket.data.add("opCode","<%=opCode%>");//
		  myPacket.data.add("phoneNo","<%=phoneNo%>");//手机号
		  myPacket.data.add("newofferidss",document.all.offerIdHv.value.trim());//手机号
      core.ajax.sendPacket(myPacket,do_sWLWOffCheck);
      myPacket=null;   
        
	   }
		
		if(!is_sWLWOffCheck){
			return;
		}  
	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
	if(rdShowConfirmDialog("请确认是否进行<%=opName%>？")==1)
	{
		if ( "1270" =="<%=opCode%>" )
		{
	
			var offerId10 = document.all.offerIdHv.value;
			var offerId40 = document.all.offerId40Hv.value;
			var offerIds = (offerId10+"|"+offerId40).replace(/\|/g,",");
			if ( offerIds.len() >= 5 )
			{
				var myPacket = new AJAXPacket("/npage/s1270/chkWlan.jsp"
					,"正在查询客户是否已办理wlan，请稍候......");
				myPacket.data.add("offerId",offerIds);
				myPacket.data.add("serId",document.all.stPMid_no.value);
				core.ajax.sendPacket(myPacket,checkAttrTypeAndWlanRet);
				myPacket=null;			
			}
			else
			{
			    formConf();	
			}
		}
		else if ( "1272" =="<%=opCode%>" )
		{
			var offerId10 = document.all.offerIdHv.value;
			var offerId40 = document.all.offerId40Hv.value;
			var offerIds = (offerId10+"|"+offerId40).replace(/\|/g,",");

			if ( offerIds.len() >= 5 )
			{
				var myPacket = new AJAXPacket("/npage/s1270/chkWlan.jsp"
					,"正在查询客户是否已办理wlan，请稍候......");
				myPacket.data.add("offerId",offerIds);
				myPacket.data.add("serId",document.all.stPMid_no.value);
				core.ajax.sendPacket(myPacket,checkAttrTypeAndWlanRet);
				myPacket=null;		
			}
			else
			{
				formConf();
			}
		}
		else 
		{
			/*2013/09/10 17:28:41 gaopeng 增加查询，关于优化中高端客户120元WLAN包半年资费业务功能需求的函 
			营业前台办理3250-可选资费包年业务时，当所办理的资费类型为YnW3时要为用户开通WLAN功能，
			经和崔琦商量将开通WLAN功能的操作放在用户统一缴费之前
			*/
		  var offerIdNeed = (document.all.offerId40Hv.value).replace(/\|/g,"");
		
		  var myPacket = new AJAXPacket("/npage/s1270/checkAttrTypeAndWlan.jsp","正在查询客户是否已办理wlan，请稍候......");
		  myPacket.data.add("offerId",offerIdNeed);
		  myPacket.data.add("serId",document.all.stPMid_no.value);
		  core.ajax.sendPacket(myPacket,checkAttrTypeAndWlanRet);
		  myPacket=null;
		}
	
	
	} 
}





function checkAttrTypeAndWlanRet(packet){
  var retCodeMy = packet.data.findValueByName("retCodeMy");
  var retMsgMy =  packet.data.findValueByName("retMsgMy");
  /*如果返回的是000000,则调用开通wlan服务 s9113Cfm*/
  if(retCodeMy == "000000"){
      var myPacket = new AJAXPacket("/npage/s1270/s9113Cfm_Wlan.jsp","正在为用户开通WLAN功能，请稍候......");
      myPacket.data.add("inChnSource","<%=loginAccept%>");//流水
      myPacket.data.add("inLoginNo","<%=workNo%>");//工号
      myPacket.data.add("inLoginPwd","<%=noPassWord%>");//工号密码
      myPacket.data.add("inPhoneNo","<%=phoneNo%>");//手机号
      myPacket.data.add("inUserPwd","");//用户密码
      myPacket.data.add("vOrgCode","<%=orgCode%>");//orgCode
      myPacket.data.add("opCode","<%=opCode%>");//orgCode
      core.ajax.sendPacket(myPacket,s9113CfmRet);
      myPacket=null;
    
  }
  else{
    formConf();
  }
  
}
/*开通wlan回调函数*/
function s9113CfmRet(packet){
  
    var resultCode = packet.data.findValueByName("resultCode");
    var resultMsg =  packet.data.findValueByName("resultMsg");
    
    if(resultCode=="000000"){
      
      formConf();
    }
    else{
      rdShowMessageDialog("错误代码："+resultCode+",错误信息："+resultMsg);
      return false;
    }
  
}


function formConf(){
				
				
				

				
				
				var note1272result="<%=opName%>";
				var note1272add1="";
				var note1272add2="";
				var note1272del1="";
				var note1272del2="";
					$("#addedOfferTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(1)").html()==undefined || $(this).find("td:eq(1)").html()=="代码" || $(this).find("td:eq(1)").html()==null ) {
					 return true;
					 }
					 note1272add1+=$(this).find("td:eq(1)").html()+",";

			});

				$("#addedProdTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(1)").html()==undefined || $(this).find("td:eq(1)").html()=="代码" || $(this).find("td:eq(1)").html()==null) {
					 return true;
					 }
					 note1272add2+=$(this).find("td:eq(1)").html()+",";

			});
			
					if(note1272add1!="") {
						note1272result+="[订"+note1272add1+"]"
					}
					if(note1272add2!="") {
						note1272result+="[订"+note1272add2+"]"
					}
					
					
						$("#offerUnbookTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(0)").html()==undefined || $(this).find("td:eq(0)").html()=="代码" || $(this).find("td:eq(0)").html()==null || $(this).find("td:eq(0)").html()=="<B>&lt;销售品&gt;</B>") {
					 return true;
					 }
					 note1272del1+=$(this).find("td:eq(0)").html()+",";

			});
			
									$("#prodUnbookTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(0)").html()==undefined || $(this).find("td:eq(0)").html()=="代码" || $(this).find("td:eq(0)").html()==null || $(this).find("td:eq(0)").html()=="<B>&lt;产品&gt;</B>") {
					 return true;
					 }
					 note1272del2+=$(this).find("td:eq(0)").html()+",";

			});
			
					if(note1272del1!="") {
						note1272result+="[退"+note1272del1+"]"
					}

					if(note1272del2!="") {
						note1272result+="[退"+note1272del2+"]"
					}
					$("#note1272result").val(note1272result);
	document.offerChoiceFrm.action="qp01Cfm.jsp";
	document.offerChoiceFrm.submit();
	
}


function doQryAttrFlagHvMsg(packet){
  var retCode = packet.data.findValueByName("errorCode");
  var retMsg =  packet.data.findValueByName("errorMsg");
  if(retCode == 0){
    var retinfo =  packet.data.findValueByName("retinfo");
    document.all.attrFlagHvMsg.value=retinfo;
  }else{
    
  }
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

//可选资费变更 销售品分类内容
function qryMainOfferRoleInfo(){
var dgMoffer='';
var filFlag='Y';
if(MainOfferFlag==1){  
  try{
        dgMoffer = $("#addedOfferTab tr:eq(2)").find("td:eq(1)").html();
        filFlag ='N';
      }catch(e){  
      
    }
} 
  var packet = new AJAXPacket("qryMainOfferRoleInfo.jsp","请稍后...");
  packet.data.add("opCode","<%=opCode%>");
  packet.data.add("filFlag",filFlag);
  packet.data.add("phoneNo","<%=phoneNo%>");
  packet.data.add("smCode","<%=smCode%>");
  if(MainOfferFlag==1){   
    packet.data.add("dgMoffer",dgMoffer);
  }else{
    packet.data.add("dgMoffer",thisMonthOfferId); 
  }
  core.ajax.sendPacket(packet,doQryMainOfferRoleInfo);
  packet =null;
}

function doQryMainOfferRoleInfo(packet){
  var errorCode = packet.data.findValueByName("errorCode");
  var errorMsg = packet.data.findValueByName("errorMsg");
  if(errorCode == 0){
    var retAry = packet.data.findValueByName("retAry");
    $("#roleInfoP select ").remove();
    if(retAry.length > 0){
      var tempStr = "<select id='roleId'>";
      //tempStr += "<option value=''>--请选择--</option>";
      for(var i = 0;i<retAry.length;i++){
        tempStr += "<option value='"+retAry[i][0]+"' >"+ retAry[i][1] + "</option>";
      }
      tempStr += "<select>";
      $("#roleInfoP").append(tempStr);
      $("#roleId").bind("change",qryAddOfferByRole);
    }else{
        var tempStr = "<select id='roleId'>";
        tempStr += "<option value=''>--请选择--</option>";
        tempStr += "<select>";
        $("#roleInfoP").append(tempStr);
        $("#roleId").bind("change",qryAddOfferByRole);
    }
  }else{
    rdShowMessageDialog(errorMsg);
    return false; 
  }
}

function qryAddOfferByRole(){
  var offerId = $("#offerId").val();
  var offerName = $("#offerName").val();
  var roleId = $("#roleId").val();
  
  //if(!validateElement($("#offerId").get(0))){
    //return false; 
  //} 
  
  var packet = new AJAXPacket("qryRealOfferId.jsp","请稍后...");
  packet.data.add("loginAccept","<%=loginAccept%>");
  packet.data.add("opCode","<%=opCode%>");
  core.ajax.sendPacket(packet,doQryRealOfferId);
  packet =null; 
  
  var relMainOfferId="";
  if(document.all.RealOfferId.value=="0"){
     relMainOfferId= thisMonthOfferId;    //默认为当月基本销售品
  }else{
     relMainOfferId= document.all.RealOfferId.value;
   }
  
  var packet = new AJAXPacket("qryAddOffer.jsp","请稍后...");
  packet.data.add("servId","<%=servId%>");
  packet.data.add("relMainOfferId",relMainOfferId);
  packet.data.add("offerId",offerId);
  packet.data.add("offerName",offerName);
  packet.data.add("roleId",roleId);
  packet.data.add("opCode","<%=opCode%>");
  core.ajax.sendPacket(packet,doQryAddOfferByRole);
  packet =null;     
}

function doQryAddOfferByRole(packet){
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

var retResultStr = "";
var descResultStr = "";
var retResultStr1 = "";
function showPrtDlg(printType,DlgMessage,submitCfm)
{   
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
  var iccidInfoStr = "";
  var accInfoStr = "";
  if ( $("#opCode").val()=="1272" || $("#opCode").val()=="1255")
  {
    iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();  
    accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" 
      +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();   
  }

  /* ningtn */
  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage
    +"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
  var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
  var ret=window.showModalDialog(path,printStr,prop);
  
  return ret;
}
//查询打印所需要的数据
function queryPrintInfo(){
  var iold_m_code = "<%=offerId%>";       //现有套餐代码
  var inew_m_code = document.all.offerIdHv.value; //新申请套餐代码
  document.all.newofferId.value=inew_m_code;
  var phone_no = "<%=phoneNo%>";          //电话号码
  var iop_code = "<%=opCode%>";
  var i2 = "<%=gCustId%>";              //cust_id
  var kexuancode = (document.all.offerId40Hv.value).replace(/\|/g,"");
  var cancalcode = (document.all.offerId40CanHv.value).replace(/\|/g,"");
  var packet1 = new AJAXPacket("getPrintInfo_Ajax.jsp","请稍后...");
  packet1.data.add("inew_m_code",inew_m_code);
  packet1.data.add("iold_m_code",iold_m_code);
  packet1.data.add("phone_no",phone_no);
  packet1.data.add("iop_code",iop_code);
  packet1.data.add("i2",i2);
  packet1.data.add("kexuancode",kexuancode);
  packet1.data.add("cancalcode",cancalcode);
  core.ajax.sendPacket(packet1,doQueryPrintInfo);
  packet =null;     
}
//打印所使用变量

var goodbz    = "";
var modedxpay = "";
var bdbz      = "";
var bdts      = "";
var note      = "";
var note1     = "";
var expDateOffset = ""; 
var offerAttrType = ""; //offer_attr_type
var matureCode    = ""; //到期后资费
var mature_Name   = ""; //到期后资费名称
function doQueryPrintInfo(packet){
  
  var errorCode = packet.data.findValueByName("errCode");
  var errorMsg  = packet.data.findValueByName("errMsg");  
  goodbz    = packet.data.findValueByName("goodbz");
  modedxpay = packet.data.findValueByName("modedxpay");
  bdbz      = packet.data.findValueByName("bdbz");
  bdts      = packet.data.findValueByName("bdts");
  note      = packet.data.findValueByName("note");
  note1     = packet.data.findValueByName("note1");
  
  exeDate   = packet.data.findValueByName("exeDate");
  offerAttrType     = packet.data.findValueByName("offerAttrType");
  expDateOffset   = packet.data.findValueByName("expDateOffset"); 
  matureCode     = packet.data.findValueByName("matureCode");
  mature_Name   = packet.data.findValueByName("mature_Name"); 
}
function printInfo()
{ 
  queryPrintInfo();
    var retInfo = "";
  <%if(opCode.equals("1253")){%>
    retInfo = printInfo1253();
  <%}else if(opCode.equals("1255")){%>
    retInfo = printInfo1255();
  <%}else if(opCode.equals("1258")){%>
    retInfo = printInfo1258();
  <%}else if(opCode.equals("7977")){%>
    retInfo = printInfo7977();
  <%}else if(opCode.equals("7978")){%>
    retInfo = printInfo7978();
  <%}else if(opCode.equals("1272")){%>
    retInfo = printInfo1272();
  <%}else if(opCode.equals("3250")){%>
    retInfo = printInfo3250();
  <%}else if(opCode.equals("3275")){%>
    retInfo = printInfo3275();
  <%}else if(opCode.equals("4208")){%>
    retInfo = printInfo4208();
  <%}else if(opCode.equals("4205")){%>
    retInfo = printInfo4205();
  <%}else if(opCode.equals("3257")){%>
    retInfo = printInfo3257();
  <%}else if(opCode.equals("1254")){%>
    retInfo = printInfo1254();
  <%}else if(opCode.equals("1270")){%>
    retInfo = printInfo1270();
  <%}else if(opCode.equals("e092")){%>
    retInfo = printInfoe092();
  <%}else if(opCode.equals("e301")){%>
    retInfo = printInfoe301();
  <%}else if(opCode.equals("m365")){%>
  	retInfo = printInfom365();
  <%}%>
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
       document.all.xq_name.value = packet.data.findValueByName("xq_name"); 
       document.all.dOfferDesc.value = packet.data.findValueByName("dOfferDesc"); 
  }
}
  <%
  long s2a =System.currentTimeMillis();
  %>
  
/* 关于铁通78位TD无线座机用户限制发送短信功能的需求 */
<%
  String tdSql = "SELECT msg.class_code FROM dchngroupmsg msg WHERE msg.GROUP_ID = '" + groupId + "'";
  String inputParam = "232";
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
        inputParam = "232";
      }
    }
  }
  if("e092".equals(opCode) || "e301".equals(opCode)){
    inputParam = "232";
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
function  addSmCode(){
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

function checkWYJ(){
	WYJflag=$("#weiyuejin").val();
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
      <%if("1".equals(vFeeFlag)){%>
	      <tr>
	        <td class=blue>是否收取违约金 </td>
	        <td>
	        	<select id="isWeiyuejin" name="isWeiyuejin">
	        		<option value="0">是</option>
	        		<option value="1">否</option>
	        	</select>
	        </td> 
	        <td class=blue>备注</td>
	        <td colspan="3">
	        	<input type="text" id="weiyuejinNote" name="weiyuejinNote" maxlength="100" size="70"/>
	        	<span id="weiyuejinNoteSpan" style="color: red">*</span>
	        </td>
	      </tr>
      <%}%>
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
  
  <div id="userInfoDiv">
    <div class="title"><div id="title_zi">用户基本信息 </div></div>
    <%@include file="PMUserBaseInfo.jsp"%>
    <div class="input">
	    <table cellspacing="0" id="integralFiledAll" style="display:none">
	    	<%@include file="/npage/public/integralInfo.jsp"%>
	  	</table>
  	</div>
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
          <div style="overflow-y:hidden;overflow-x:hidden; background-color: #F7F7F7;border-right: 1px solid #95CBDD;border-left: 1px solid #95CBDD;border-bottom: 1px solid #95CBDD;height:388px;FONT-WEIGHT: normal; FONT-SIZE: 13px;" class="list">
      
          <div id="formTab">  
            <ul>
            <li class="current" id="tb_1" onclick="HoverLi(1,2)"><a href="#">基本销售品</a></li>  
            <li id="tb_2"><a href="#" onclick="HoverLi(2,2)">附加销售品</a> </li>
          </ul>
         </div> 

            <div id="searchOfferConDiv" style="display:none;border-right: 0px solid #95CBDD;border-left: 0px solid #95CBDD;border-bottom: 1px solid #95CBDD;height:388px;PADDING-LEFT: 20px; COLOR: #0256b8;FONT-WEIGHT: normal; FONT-SIZE: 12px;">
              <p> &nbsp;&nbsp;业务品牌:
                <select class="b_text" name="bindId" id="bindId"  onchange="setOfferType()">
                  <option value="" selected>----请选择----</option>
                </select>
              </p>
              <p>销售品分类:
                <select class="b_text" name="offerType" id="offerType">
                  <option value="" selected>----请选择----</option>
                </select>
              </p>
              <p>&nbsp;&nbsp;销售品ID：<input type="text"  name="offerId" id="offerId" class="for0_9" ></p>
              <p>&nbsp;&nbsp;&nbsp;&nbsp;关键字：<input type="text"  name="offerName" id="offerName" ></p>
              <p id="roleInfoP">销售品分类：</p>
              <p align="center">  
                <input type="button" class="b_text" value="检索" id="qryOfferBtn">
                <%if(opCode.equals("1270")||opCode.equals("1272")){%>
                <input type="button" class="b_text" value="我的收藏" onclick="qryMyCollection()" />
                <input type="button" class="b_text" value="热点" onclick="qryHotOffer()" />
                <%}%>
                <input type="button" class="b_text" value="清除" onclick="clearInfo()" />&nbsp;&nbsp;&nbsp;
              </p>
            </div>
          </div>
      </div>
      
   <div class="item-col col-2" id="right" >
        <span class="item-col2 col-1" id="leftSpan" style="overflow-y:auto;overflow-x:hidden;background-color:#F7F7F7;height:413px;border-right: 1px solid #95CBDD;border-left: 1px solid #95CBDD;border-bottom: 1px solid #95CBDD;">
          <!--div class="title"><div class="text">查询列表</div></div-->        
        <div class="title" >
          <div id="title_zi">可选销售品展示区</div><span style="float:right;padding: 3px 1px 0px 2px;"><img src='/nresources/default/images/arrow_left.gif' style='cursor:hand' name='right' alt='点击折叠销售品检索区' id='LRImg' onClick="toLeft()"></span>
        </div>
          <table  style="FONT-SIZE: 12px;">
              <tr>
                 <td class="blue">
                &nbsp;&nbsp;拼音简拼检索： <input type="text" id="searchOfferText" name="searchOfferText" onkeyup="searchOffer()" />
                </td>
              </tr>
          </table>
          
         <div>
            <div  id="offerListDiv">
            </div>
          </div>
        </span>
        
        <span class="item-col3 col-2" id="rightSpan">
          <!--div class="title" id="addedOfferTitDiv"><div class="text">本次受理【订购】</div></div-->      
      <div class="title" id="addedOfferTitDiv">
        <div id="title_zi" style="cursor:hand">本次受理【订购】</div>
      </div>
      
<%
if(opCode.equals("1258")){
%>      
      <div id="isCPE" >
      	<b style="font-size: 15px;">是否收取违约金:
	      <select id="weiyuejin" name="weiyuejin" onchange="checkWYJ()">
	      	<option value="0">是</option>
	      	<option value="1">否</option>
	      </select></b>
      </div>
      
<%}%>      
      
        
          <div id="addedOfferDiv" class="list" style="overflow-x:auto;overflow-y:auto;height:200px;width:99%;border-width:1px;border-color:#add3d0;border-style:solid;background-color: #F7F7F7;" >
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
              <table id="addedProdTab">
              <tr>
                <td colspan='6' class="blue"><b><产品></b></td>
              </tr>
              <tr id="addedProdHeadTr">
                <td class="blue">状态</td>
                <td class="blue">代码</td>
                <td class="blue">名称</td>
                <td class="blue">生效时间</td>
                <td class="blue">失效时间</td>
                <td class="blue">操作</td>
              </tr>
            </table>  
            <table id="slTab">
              <tr>
                <td colspan='6' class="blue"><input type="checkbox" name="slChk" id="slChk" >是否参与赠礼</td>
              </tr>
            </table>  
          </div>
          
      <!--div class="title" id="offerUnbookTitDiv"><div class="text">本次受理--退订</div></div-->
      <div class="title" id="offerUnbookTitDiv">
        <div id="title_zi" style="cursor:hand;">本次受理【退订】</div>
      </div>
          <div class="list" id="offerUnbookDiv" style="overflow-y:auto;overflow-x:auto;height:160px;width:99%;border-width:1px;border-color:#add3d0;border-style:solid;background-color: #F7F7F7;">
            <table id="offerUnbookTab">
                <tr>
                <td colspan='5' class="blue"><b><销售品></b></td>
              </tr>
              <tr>
                <td class="blue">代码</td>
                <td class="blue">名称</td>
                <td class="blue">生效时间</td>
                <td class="blue">失效时间</td>
                <td class="blue">操作</td>
              </tr>
            </table>  
             <table id="prodUnbookTab">
              <tr>
                <td colspan='5' class="blue"><b><产品></b></td>
              </tr>
              <tr>
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
<%
if ( opCode.equals("1272")||opCode.equals("1255") )
{
%>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
  <jsp:param name="hwAccept" value="<%=loginAccept%>"  />
  <jsp:param name="showBody" value="01"  />
</jsp:include>
<%
}
%>

<div id="operation_button">
  <div id="footer">
  <input class="b_foot" name=confirm id="confirm" type=button onClick="qryProdAttr()" value="确定" >
  &nbsp; 
  <INPUT class=b_foot onclick="ignoreThis()" type=button value=忽略> &nbsp;
  <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value="关闭">
</div>
</div>
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
<input type="hidden" name="xq_name"/>
                         
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
<input type="hidden" name="note1272result" id="note1272result"/>
<!-- 20131216 2013/12/17 9:51:34 gaopeng 关于2013年9月第一批业务支撑系统市场专业需求（关于主资费捆绑数据业务功能优化的需求） 隐藏域 放入四种数据 139邮箱0元 139邮箱5元 咪咕会员0元 咪咕会员5元 -->
<input type="hidden" name="mailzero" id="mailzero"/>
<input type="hidden" name="mailfive" id="mailfive"/>
<input type="hidden" name="miguzero" id="miguzero"/>
<input type="hidden" name="migufive" id="migufive"/>
<!-- 2014/04/04 11:15:23 gaopeng 品牌sm_code -->
	<input type="hidden" name="pubSmCode" id="pubSmCode" value="" />
	<!--BUS校验返回代码-->
<input type="hidden" name="bFCode" value="1">
<input type="hidden" name="bFMsg" value="1">
</DIV>
<%@ include file="/npage/include/footer_new.jsp"%>
</FORM>
</DIV>
</BODY>
<%
	/* 【项目】关于旧版客服系统割接下线需要将客服域的营业代码与CRM合并成一套版本的解决方案和后续需求开发讨论规则@2014/7/16 */
	if(!"2".equals(OPflag)){ /*如果工号类型为客服工号，则不加载控件*/
%>
	<%@ include file="/npage/public/hwObject.jsp" %> 
<%}%>
</HTML>
<script>


  
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
  
  <%if(opCode.equals("3257")&&(countqry>0)){%>
  if($("#glbQryMem").get(0).checked == true){     
      var ret=window.showModalDialog("showGlbQryMem.jsp?id_no=<%=stPMid_no%>&phoneNo=<%=phoneNo%>&custName=<%=custName%>&opCode=<%=opCode%>&opName=<%=opName%>","",prop);
      $("#glbQryMem").attr("checked",false);
  }else{
    
  }
  
<%}%>
}
//爱心卡申请
function printInfo1253()
{
    //得到该业务工单需要的参数

    var cust_info="";  //客户信息
    var opr_info="";   //操作信息
    var note_info1=""; //备注1
    var note_info2=""; //备注2
    var note_info3=""; //备注3
    var note_info4=""; //备注4
    var retInfo = "";  //打印内容
    /********基本信息类**********/
    //document.all.belongCity.value = document.all.stPMcust_addressHi.value;
    cust_info+="客户姓名： "+document.all.custName.value+"|";
    cust_info+="手机号码： "+"<%=phoneNo%>"+"|";
    cust_info+="证件号码： "+document.all.agent_idNo.value+"|";
    cust_info+="客户地址： "+document.all.stPMcust_addressHi.value+"|";
      /********受理类**********/
      opr_info+="用户品牌："+document.all.stPMsm_nameHi.value+"|";
      opr_info+="业务类型：爱心卡申请"+"|";
      if(goodbz=="Y"){
        opr_info+="业务流水："+"<%=loginAccept%>"+"       底线消费金额："+modedxpay+"元"+"|";
      }else{
      opr_info+="业务流水："+"<%=loginAccept%>"+"|";
      }
      opr_info+="资费（代码、名称）："+document.all.offerIdHv.value+" "+document.all.offerNameHv.value+";"+document.all.offerId40Hv.value+" "+document.all.offerName40Hv.value+"|";
      opr_info+="生效时间："+document.all.offerTimeHv.value.substring(0,8)+"|";
      ajaxGetEPf(document.all.offerIdHv.value.trim(),xqdm);
      opr_info+="　|";
      opr_info+="新申请主资费描述："+codeChg(document.all.newZOfferDesc.value)+"|";
     if (document.all.offerId40Hv.value.trim().replace(/\|/g,"").len()== 0) {
			} else {
			opr_info+="　|";
      ajaxGetEPf1(document.all.offerId40Hv.value);
    	opr_info+="新申请可选资费描述："+retResultStr1+"|";
    	}
      /*******备注类**********/
    if(bdbz=="Y"){
        opr_info+=bdts+"|";
      }else{
      opr_info+=" "+"|";
    }
    /**********描述类*********/
  var tempNote_info3 = "";
  var tempArray1 = document.all.offerIdArr;
  var tempArray2 = document.all.offerNameArr;
  var tempArray3 = document.all.offerEffectTime;
  var tempArray4 = document.all.offerExpireTime;
  var tempArray5 = document.all.proOptFlag;
  var tempArray6 = document.all.offerZCflag;    
  for(var h=0;h<tempArray5.length;h++){
    if(tempArray6[h].value!="40"&&(typeof(tempArray6[h])!="undefined")){
      ;
    }else{
    if(tempArray5[h].value=="3"){
      if("<%=current_time%>"==tempArray4[h].value.substring(0,8)) {  
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")将被立即取消"+",";
      }else{
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")将于下月1日失效"+",";    
      }
    }
    } 
  }
  if(tempNote_info3.len()>0)
  {     
      tempNote_info3+="|"   ;        
      note_info1 += "新资费生效时将被取消的可选资费:" + tempNote_info3 + "|";
  }else{
      note_info1+=" "+"|";
      }
      if(goodbz=="Y"){
      note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
    }
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//包年申请
function printInfo1255()
{
    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    /********基本信息类**********/
    
    cust_info+="客户姓名： "+document.all.custName.value+"|";
    cust_info+="手机号码： "+"<%=phoneNo%>"+"|";
    cust_info+="证件号码： "+document.all.agent_idNo.value+"|";
    cust_info+="客户地址： "+document.all.stPMcust_addressHi.value+"|";

    /********受理类**********/
    opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "  " + "用户品牌：" + document.all.stPMsm_nameHi.value + "|";
    if(goodbz=="Y"){
        opr_info += "办理业务:" + "包年申请" + "  " + "操作流水: " + "<%=loginAccept%>" + "  底线消费金额：" + modedxpay + "元" + "|";
    }else{
        opr_info += "办理业务:" + "包年申请" + "  " + "操作流水: " + "<%=loginAccept%>" + "|";
    }
    opr_info += "包年资费：" +document.all.offerIdHv.value+" "+document.all.offerNameHv.value + "  " + "生效时间：" + document.all.offerTimeHv.value.substring(0,8) + "|";
    ajaxQueryPPf(document.all.offerIdHv.value);
    var sm_code = retResultStr2;
    var bandId = band_id
    opr_info += "包年资费对应品牌：" + sm_code + "|";
    
    
    ajaxGetEPf(document.all.offerIdHv.value.trim(),xqdm);
    opr_info += "到期后执行资费：" + document.all.dOfferId.value+" "+document.all.dOfferName.value + "|";
    if(document.all.dECode.value!="") {
      opr_info+="到期后二批代码："+document.all.dECode.value+"-"+document.all.xq_name.value+"|";
      }
    if(zdxq=="1")
    {
        opr_info+="用户办理包年自动续签业务|"
    }
      note_info2+="到期后执行资费描述："+document.all.dOfferDesc.value+"|";
      
    /*******备注类**********/
    if (bdbz == "Y") {
        note_info1 += bdts + "|";
    } else {

    }
    /**********描述类*********/
  note_info1+=""+"|";
    note_info1 += "申请的包年资费描述：" + "|";
    note_info1 += note.trim() + "|";
  if(bandId=="24" && bandId=="21")
  {
    note_info2+=" "+"|";
  }
  else
  {
    note_info2+=" "+"|";
    if((document.all.stPMsm_nameHi.value != "") && (sm_code != document.all.stPMsm_nameHi.value)){
      note_info2+="包年资费生效后，您的品牌将由"+""+"变更为"+sm_code+"，您的现有积分或M值将于品牌变更时失效，请您及时兑换积分。"+"|";
    }
    note_info2+=" "+"|";
  }

    
    if (document.all.offerId40Hv.value.trim().replace(/\|/g,"").len()== 0) {

    } else {
      ajaxGetEPf1(document.all.offerId40Hv.value);
        note_info3 += " " + "|";
        note_info3 += "可选资费描述：" + "|";
        note_info3 += retResultStr1 + "|";
    }
    note_info4 += " " + "|";
    var tempNote_info3 = "";
  var tempArray1 = document.all.offerIdArr;
  var tempArray2 = document.all.offerNameArr;
  var tempArray3 = document.all.offerEffectTime;
  var tempArray4 = document.all.offerExpireTime;
  var tempArray5 = document.all.proOptFlag;
  var tempArray6 = document.all.offerZCflag;    
  
  for(var h=0;h<tempArray5.length;h++){
    if(tempArray6[h].value!="40"&&(typeof(tempArray6[h])!="undefined")){
      ;
    }else{
    if(tempArray5[h].value=="3"){
      if("<%=current_time%>"==tempArray4[h].value.substring(0,8)) {  
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")将被立即取消"+",";
      }else{
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")将于下月1日失效"+",";      
      }
    }
    } 
  }
  
  
  
  if(tempNote_info3.length >0)
  {     
    tempNote_info3+="|"   ;        
      note_info4 += "新资费生效时将被取消的可选资费:" + tempNote_info3 + "|";
  }
  if(goodbz=="Y"){
      note_info4 += " " + "|";
      note_info4 += "备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。" + "|";
      if(print12701255){
    	  note_info4 += "为保障您的权益，您原"+retResult212701255+"主资费包含的彩铃业务将为您免费保留一年，保留期间业务每月费用为"+retResult112701255+"元，系统每月赠送您"+retResult112701255+"元专款，相当于免费使用。该保留的彩铃业务随新主资费生效的日期开始起算，到期后如无变化此优惠将自动顺延一年，如有变化系统将提前1个月短信通知。|";
      }
  }
  else{
	  if(print12701255){
		  note_info4 += "备注：为保障您的权益，您原"+retResult212701255+"主资费包含的彩铃业务将为您免费保留一年，保留期间业务每月费用为"+retResult112701255+"元，系统每月赠送您"+retResult112701255+"元专款，相当于免费使用。该保留的彩铃业务随新主资费生效的日期开始起算，到期后如无变化此优惠将自动顺延一年，如有变化系统将提前1个月短信通知。|";
      }
	  
  }
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//包年取消
function printInfo1258()
{
    //得到该业务工单需要的参数
    var exeDate = '<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';
    var smName = "";


    var retInfo = "";
    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    /********基本信息类**********/
  cust_info+="客户姓名： "+document.all.custName.value+"|";
  cust_info+="手机号码： "+"<%=phoneNo%>"+"|";
  cust_info+="证件号码： "+document.all.agent_idNo.value+"|";
  cust_info+="客户地址： "+document.all.stPMcust_addressHi.value+"|";

    /********受理类**********/

    opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "  " + "用户品牌：" + document.all.stPMsm_nameHi.value + "|";
  if(goodbz=="Y"){
      opr_info += "办理业务:" + "包年取消" + "  " + "操作流水: " + "<%=loginAccept%>" + "  底线消费金额：" + modedxpay + "元" + "|";
  }else{
      opr_info += "办理业务:" + "包年取消" + "  " + "操作流水: " + "<%=loginAccept%>" + "|";
  }

var countBaseOffer = $("#userHadOfferTab tr").length;
  for(var iw=1;iw<countBaseOffer;iw++){
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="基本"){
      opr_info+="取消的包年资费："+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text()+" "+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(1)").text()+"|";
    }
  }
    
    opr_info += "取消后执行资费：" + document.all.offerIdHv.value+" "+document.all.offerNameHv.value + "  *" + "生效时间：" + document.all.offerTimeHv.value.substring(0,8) + "|";
    
    
    ajaxQueryPPf(document.all.offerIdHv.value);
    var sm_code = retResultStr2;
    var bandId = band_id
    opr_info += "取消后执行资费对应品牌：" + sm_code + "|";
    
    note_info1 += "取消后执行资费描述：" + document.all.newZOfferDesc.value+"|";
    note_info1 += note + "|";
    /*******备注类**********/
    if (bdbz == "Y") {
        note_info1 += bdts + "|";
    }
    /**********描述类*********/
    if (document.all.offerId40Hv.value.trim().replace(/\|/g,"").len()== 0) {

    } else {
      ajaxGetEPf1(document.all.offerId40Hv.value);
        note_info2 += " " + "|";
        note_info2 += "可选资费描述：" + retResultStr1 + "|";
    }
    note_info3 += " " + "|";
    var tempNote_info3 = "";
  var tempArray1 = document.all.offerIdArr;
  var tempArray2 = document.all.offerNameArr;
  var tempArray3 = document.all.offerEffectTime;
  var tempArray4 = document.all.offerExpireTime;
  var tempArray5 = document.all.proOptFlag;
  var tempArray6 = document.all.offerZCflag;    
  
  for(var h=0;h<tempArray5.length;h++){
    if(tempArray6[h].value!="40"&&(typeof(tempArray6[h])!="undefined")){
      ;
    }else{
    if(tempArray5[h].value=="3"){
      if("<%=current_time%>"==tempArray4[h].value.substring(0,8)) {  
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")将被立即取消"+",";
      }else{
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")将于下月1日失效"+",";    
      }
    }
    } 
  }    

  
    if (tempNote_info3.length >0) {
        note_info4 += " " + "|";
        note_info4 += "新资费生效时将被取消的可选资费:" + codeChg(tempNote_info3) + "|";
    } else {

    }
  if(goodbz=="Y"){
      note_info4 += " " + "|";
      note_info4 += "备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。" + "|";
  }
  
  if(WYJflag=="0"){
	  note_info4 += "您的包年资费未到期，取消包年资费属违约行为，在本月话费出帐后，我公司将按剩余包年预存款的30％收取违约金（精确到分，四舍五入），剩余的预存款将自动转到您的现金账户中。" + "|";
  }
    note_info4 += " " + "|";
    note_info4 += "备注：" + document.all.tonote.value + "|";
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//神州行助老爱心卡申请
function printInfo7977()
{
    //得到该业务工单需要的参数

    var cust_info="";  //客户信息
    var opr_info="";   //操作信息
    var note_info1=""; //备注1
    var note_info2=""; //备注2
    var note_info3=""; //备注3
    var note_info4=""; //备注4
    var retInfo = "";  //打印内容
    /********基本信息类**********/
    cust_info+="客户姓名： "+document.all.custName.value+"|";
    cust_info+="手机号码： "+"<%=phoneNo%>"+"|";
      /********受理类**********/
      retInfo+=" "+"|";
      opr_info+="用户品牌："+document.all.stPMsm_nameHi.value+"|";
      opr_info+="业务类型：神州行助老爱心卡申请"+"|";
      if(goodbz=="Y"){
        opr_info+="业务流水："+"<%=loginAccept%>"+"|";
      }else{
        opr_info+="业务流水："+"<%=loginAccept%>"+"|";
      }
      opr_info+="新申请的资费（代码、名称）："+document.all.offerIdHv.value+" "+document.all.offerNameHv.value+"|";
      opr_info+="生效时间："+"当天"+"|";
      /*******备注类**********/
      if(bdbz=="Y"){
        opr_info+=bdts+"|";
      }else{
      opr_info+=" "+"|";
      }
    /**********描述类*********/
    note_info1+="新申请的资费描述:"+"|";
      note_info1+=codeChg(note.trim())+"|";
      
    var tempNote_info3 = "";
  var tempArray1 = document.all.offerIdArr;
  var tempArray2 = document.all.offerNameArr;
  var tempArray3 = document.all.offerEffectTime;
  var tempArray4 = document.all.offerExpireTime;
  var tempArray5 = document.all.proOptFlag;
  var tempArray6 = document.all.offerZCflag;    
  for(var h=0;h<tempArray5.length;h++){
    if(tempArray6[h].value!="40"&&(typeof(tempArray6[h])!="undefined")){
      ;
    }else{
    if(tempArray5[h].value=="3"){
      if("<%=current_time%>"==tempArray4[h].value.substring(0,8)) {  
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")将被立即取消"+",";
      }else{
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")将于下月1日失效"+",";          
      }
    }
    } 
  }    
    if (tempNote_info3.len()>0) {
        note_info2 += " " + "|";
        note_info2 += "新资费生效时将被取消的可选资费:" + codeChg(tempNote_info3) + "|";
    }else {

    }      
      note_info3+=" "+"|";
      note_info4+="备注："+"|";
      
      if(goodbz=="Y"){
      note_info4+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
    }
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//神州行助老爱心卡取消
function printInfo7978()
{
    var cust_info="";  //客户信息
    var opr_info="";   //操作信息
    var note_info1=""; //备注1
    var note_info2=""; //备注2
    var note_info3=""; //备注3
    var note_info4=""; //备注4
    var retInfo = "";  //打印内容
    /********基本信息类**********/
    cust_info+="客户姓名： "+document.all.custName.value+"|";
    cust_info+="手机号码： "+"<%=phoneNo%>"+"|";
       /********受理类**********/
      opr_info+="用户品牌："+document.all.stPMsm_nameHi.value+"|";
      opr_info+="业务类型：神州行助老爱心卡取消"+"|";
       if(goodbz=="Y"){
        opr_info+="业务流水："+"<%=loginAccept%>"+"|";
      }else{
       opr_info+="业务流水："+"<%=loginAccept%>"+"|";
      }
    opr_info+="取消后执行的资费（代码、名称）："+document.all.offerIdHv.value+" "+document.all.offerNameHv.value+"|";
      opr_info+="生效时间："+"当天"+"|";
      
       /*******备注类**********/
    if(bdbz=="Y"){
        opr_info+=bdts+"|";
      }else{
      opr_info+=" "+"|";
    }
    /**********描述类*********/
    var tempNote_info3 = "";
  var tempArray1 = document.all.offerIdArr;
  var tempArray2 = document.all.offerNameArr;
  var tempArray3 = document.all.offerEffectTime;
  var tempArray4 = document.all.offerExpireTime;
  var tempArray5 = document.all.proOptFlag;
  var tempArray6 = document.all.offerZCflag;    
  for(var h=0;h<tempArray5.length;h++){
    if(tempArray6[h].value!="40"&&(typeof(tempArray6[h])!="undefined")){
      ;
    }else{
    if(tempArray5[h].value=="3"){
      if("<%=current_time%>"==tempArray4[h].value.substring(0,8)) {  
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")将被立即取消"+",";
      }else{
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")将于下月1日失效"+",";  
      }
    }
    } 
  }    
    if (tempNote_info3.len()>0) {
        note_info1 += " " + "|";
        note_info1 += "新资费生效时将被取消的可选资费:" + codeChg(tempNote_info3) + "|";
    }else {

    }          
      
      note_info1+="备注："+"|";
      note_info1+="神州行助老爱心卡资费取消时（即转入30普通后），亲情号码优惠同时取消，立即生效；"+"|";
      
      if(goodbz=="Y"){
      note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
    }
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
/*********免填单打印函数调用的打印函数*********/
function printInfo1272()
{
    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    
  cust_info+="客户姓名： "+document.all.custName.value+"|";
  cust_info+="手机号码： "+"<%=phoneNo%>"+"|";

  opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "   " + "用户品牌：" + document.all.stPMsm_nameHi.value + "|";

  var tempNote_info2 = "本次申请可选套餐：";//申请资费 串
  var tempNote_info3 = "本次取消可选套餐：";//取消资费 串
  var tempArray1 = document.all.offerIdArr;
  var tempArray2 = document.all.offerNameArr;
  var tempArray3 = document.all.offerEffectTime;
  var tempArray4 = document.all.offerExpireTime;
  var tempArray5 = document.all.proOptFlag;
  var tempArray6 = document.all.offerZCflag;
  
  var aaa = "";
  var notessss="";
  for(var h=0;h<tempArray5.length;h++){
    if(tempArray6[h].value!="40"&&(typeof(tempArray6[h])!="undefined")){
      ;
    }else {
    	var retArray=new Array();
        var myPacket = new AJAXPacket("qp01MainQryXsp.jsp","正在查询信息，请稍候......");
        myPacket.data.add("offerId",tempArray1[h].value.trim()); 
   	  	core.ajax.sendPacket(myPacket,function(packet){
   	  	var retCodeXsp=packet.data.findValueByName("retCodeXsp");
   		  var retMsgXsp=packet.data.findValueByName("retMsgXsp");
   		  if(retCodeXsp == "000000"){
   			  retArray = packet.data.findValueByName("retArray");
   		 	}
   	  });
    	
      if(tempArray5[h].value=="1"){
      
    var isextflagsss="";
    var isextstrssss="";
    var myPacket = new AJAXPacket("queryEXTStatus.jsp","正在查询信息，请稍候......");
	  myPacket.data.add("offer_ids",tempArray1[h].value.trim()); 
	  core.ajax.sendPacket(myPacket,function(packet){
	  	var retCode=packet.data.findValueByName("errCode");
		  var retMsg=packet.data.findValueByName("errMsg");
		  var isextflags=packet.data.findValueByName("isextflags"); //是否是周六生效的资费5是其他不是
		  var isextstrs=packet.data.findValueByName("isextstrs"); //是周六生效的资费的话生效方式展示
		  if(retCode == "000000"){
		  	isextflagsss=isextflags;
		  	isextstrssss=isextstrs;
		 	}else{
		 		rdShowMessageDialog("查询订购资费的生效方式出错",0);
		 	}
	  });
     //alert(isextflagsss);
     //2017-01-10 liangyl 齐齐哈尔关于新版超和卡办理过程中工单和短信展示的问题反馈
     
      if(isextflagsss=="5") {
      	tempNote_info2+="("+tempArray1[h].value+"、"+tempArray2[h].value+"、"+isextstrssss+")|";
      //2017-01-10 liangyl 齐齐哈尔关于新版超和卡办理过程中工单和短信展示的问题反馈
      	if(retArray.length>0){
      		for(var i=0;i<retArray.length;i++){
      			tempNote_info2+="("+retArray[i][0]+"、"+retArray[i][1]+"、"+isextstrssss+")|";
      			notessss+=retArray[i][2]+"|";
			}
      	}
      	}else {
	        if("<%=current_time%>"==tempArray3[h].value.substring(0,8)){          
	            tempNote_info2+="("+tempArray1[h].value+"、"+tempArray2[h].value+"、24小时内生效)|";
	          //2017-01-10 liangyl 齐齐哈尔关于新版超和卡办理过程中工单和短信展示的问题反馈
	            if(retArray.length>0){
	          		for(var i=0;i<retArray.length;i++){
	          			tempNote_info2+="("+retArray[i][0]+"、"+retArray[i][1]+"、24小时内生效)|";
	          			notessss+=retArray[i][2]+"|";
	    			}
	          	}
	        }else{
	            tempNote_info2+="("+tempArray1[h].value+"、"+tempArray2[h].value+"、预约生效)|";
	          //2017-01-10 liangyl 齐齐哈尔关于新版超和卡办理过程中工单和短信展示的问题反馈
	            if(retArray.length>0){
	          		for(var i=0;i<retArray.length;i++){
	          			tempNote_info2+="("+retArray[i][0]+"、"+retArray[i][1]+"、预约生效)|";
	          			notessss+=retArray[i][2]+"|";
	    			}
	          	}
	        }
        }
      }
      else if(tempArray5[h].value=="3"){
        if("<%=current_time%>"==tempArray4[h].value.substring(0,8)) {  
          tempNote_info3+="("+tempArray1[h].value+"、"+tempArray2[h].value+"、24小时内失效)|";
        //2017-01-10 liangyl 齐齐哈尔关于新版超和卡办理过程中工单和短信展示的问题反馈
          if(retArray.length>0){
	        	for(var i=0;i<retArray.length;i++){
	        		tempNote_info3+="("+retArray[i][0]+"、"+retArray[i][1]+"、24小时内失效)|";
	  			}
        	}
        }else{
          tempNote_info3+="("+tempArray1[h].value+"、"+tempArray2[h].value+"、预约失效)|";
        //2017-01-10 liangyl 齐齐哈尔关于新版超和卡办理过程中工单和短信展示的问题反馈
          if(retArray.length>0){
	        	for(var i=0;i<retArray.length;i++){
	        		tempNote_info3+="("+retArray[i][0]+"、"+retArray[i][1]+"、预约失效)|";
	  			}
      		}
        }
      }
      
    }
  }
  if(tempNote_info2=="")tempNote_info2="无";
  if(tempNote_info3=="")tempNote_info3="无"; 
  tempNote_info2 =  tempNote_info2 + "|";
  tempNote_info3 =  tempNote_info3 +  "|";
    if (tempNote_info2 == "本次申请可选套餐：15元IP优惠礼包|")
    {
        opr_info += "业务类型:可选套餐节日17951 IP长途优惠礼包（15）申请" + "  " + "流水:" + "<%=loginAccept.trim()%>" + "|";
    } else if (tempNote_info3 == "本次取消可选套餐： 15元IP优惠礼包|")
    {
        opr_info += "业务类型:可选套餐节日17951 IP长途优惠礼包（15）取消" + "  " + "流水:" + "<%=loginAccept.trim()%>" + "|";
    } else
    {
        opr_info += "业务类型:可选资费变更" + "  " + "流水:" + "<%=loginAccept.trim()%>" + "|";
    }


    if ((tempNote_info2 == "本次申请可选套餐： 15元IP优惠礼包|") || (tempNote_info3 == "本次取消可选套餐： 15元IP优惠礼包|"))
    {
        note_info1 += "IP节日优惠礼包包月使用费15元，订购后可以享受当月赠送168分钟" + "|";
        note_info1 += "的17951国内长途IP通话费，超过部分，费用正常收取。" + "|";
        note_info1 += "下半月（16日起）申请的用户，包月费用收取7.5元，赠送84分钟的" + "|";
        note_info1 += "17951国内长途IP通话费，超过部分，费用正常收取。" + "|";
        note_info1 += "该业务当日申请，次日生效；取消，下月生效。" + "|";
        note_info1 += "在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。" + "|";

    } else {
        opr_info += "" + codeChg(tempNote_info2);//申请资费
        opr_info += "" + codeChg(tempNote_info3);//取消资费
    }
    note_info2 += " " + "|";
    note_info2 += "备注:" + "" + "|";
  //ningtn add @ 亲情畅聊需求;  wanghfa 2011/4/13 update 关于亲情畅聊业务相关办理提示信息的需求
  if (document.all.offerId40Hv.value.trim().indexOf("33157") != -1) {
    note_info2 += "1、亲情畅聊月功能费不区分上下半月。套餐办理24小时生效。" + "|";
//    note_info2 += "2、V网客户不允许办理此资费。" + "|";  huangrong update 关于家庭服务计划业务办理功能修改的函 2011-3-16
    note_info2 += "2、亲情号码只能新增、变更，且不收取费用；每月仅允许进行一次变更操作。" + "|";
    note_info2 += "3、由于亲情号码设置有误导致无法正常通话或享受优惠，移动公司不承担相关责任。" + "|";
    note_info2 += "4、客户接收、发送短信给亲情号码仍按照正常短信资费收取。" + "|";
    note_info2 += "5、客户可通过营业厅查询亲情号码设置的情况。" + "|";
    note_info2 += "6、此资费优惠截止时限为2012年12月31日24时。" + "|";
    note_info2 += "7、客户在漫游时仍按照漫游资费标准收取。" + "|";
    note_info2 += "8、VPMN网用户按照V网资费标准收取。" + "|";
    
  }
    //sunzx add @ 20071115
    if (document.all.offerId40Hv.value.trim().replace(/\|/g,"").len()== 0) {

    } else {
      ajaxGetEPf1(document.all.offerId40Hv.value);
        note_info3 += " " + "|";
        note_info3 += "可选资费描述：" + retResultStr1 + "|";
        note_info3 += notessss;
    }
          //4G项目要求修改免填单 hejwa add 2014年3月6日8:59:57
// note_info4+=""+"|";
 //note_info4+="4G试商用提示："+"|";
 //note_info4+="1、中国移动4G业务需要TD-LTE制式终端支持，并更换支持4G功能的USIM卡、开通4G服务功能；"+"|";
 //note_info4+="2、客户入网时选用或更换支持4G功能USIM卡时，将同时开通4G服务功能；"+"|";
 //note_info4+="3、4G网速较快，办理高档位套餐可以享受更多的流量优惠；"+"|";
 //note_info4+="4、4G业务仅在4G网络所覆盖的范围内提供，中国移动将不断扩大4G覆盖区域、提高服务质量。"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

/*********免填单打印函数调用的打印函数*********/
function printInfom365()
{
    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    
  cust_info+="客户姓名： "+document.all.custName.value+"|";
  cust_info+="手机号码： "+"<%=phoneNo%>"+"|";

  opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "   " + "用户品牌：" + document.all.stPMsm_nameHi.value + "|";

  var tempNote_info2 = "本次申请可选套餐：";//申请资费 串
  var tempNote_info3 = "本次取消可选套餐：";//取消资费 串
  var tempArray1 = document.all.offerIdArr;
  var tempArray2 = document.all.offerNameArr;
  var tempArray3 = document.all.offerEffectTime;
  var tempArray4 = document.all.offerExpireTime;
  var tempArray5 = document.all.proOptFlag;
  var tempArray6 = document.all.offerZCflag;
  
  var aaa = "";
  for(var h=0;h<tempArray5.length;h++){
    if(tempArray6[h].value!="40"&&(typeof(tempArray6[h])!="undefined")){
      
    }else {
      if(tempArray5[h].value=="1"){
      
    var isextflagsss="";
    var isextstrssss="";
    var myPacket = new AJAXPacket("queryEXTStatus.jsp","正在查询信息，请稍候......");
	  myPacket.data.add("offer_ids",tempArray1[h].value.trim()); 
	  core.ajax.sendPacket(myPacket,function(packet){
	  	var retCode=packet.data.findValueByName("errCode");
		  var retMsg=packet.data.findValueByName("errMsg");
		  var isextflags=packet.data.findValueByName("isextflags"); //是否是周六生效的资费5是其他不是
		  var isextstrs=packet.data.findValueByName("isextstrs"); //是周六生效的资费的话生效方式展示
		  if(retCode == "000000"){
		  	isextflagsss=isextflags;
		  	isextstrssss=isextstrs;
		 	}else{
		 		rdShowMessageDialog("查询订购资费的生效方式出错",0);
		 	}
	  });
     //alert(isextflagsss); 
      if(isextflagsss=="5") {
      		    tempNote_info2+="("+tempArray1[h].value+"、"+tempArray2[h].value+"、"+isextstrssss+")";
      }else {
	        if("<%=current_time%>"==tempArray3[h].value.substring(0,8)){          
	            tempNote_info2+="("+tempArray1[h].value+"、"+tempArray2[h].value+"、24小时内生效)";      
	        }else{
	            tempNote_info2+="("+tempArray1[h].value+"、"+tempArray2[h].value+"、预约生效)";     
	        }
        }
      }
      else if(tempArray5[h].value=="3"){
        if("<%=current_time%>"==tempArray4[h].value.substring(0,8)) {  
          tempNote_info3+="("+tempArray1[h].value+"、"+tempArray2[h].value+"、24小时内失效)";      
        }else{
          tempNote_info3+="("+tempArray1[h].value+"、"+tempArray2[h].value+"、预约失效)";     
        }
      }     
    }
  }
  if(tempNote_info2=="")tempNote_info2="无";
  if(tempNote_info3=="")tempNote_info3="无"; 
  tempNote_info2 =  tempNote_info2 + "|";
  tempNote_info3 =  tempNote_info3 +  "|";

        opr_info += "业务类型:可选资费变更" + "  " + "流水:" + "<%=loginAccept.trim()%>" + "|";
        //opr_info += "" + codeChg(tempNote_info2);//申请资费
        //opr_info += "" + codeChg(tempNote_info3);//取消资费
    
    note_info2 += " " + "|";
    note_info2 += "备注:" + "" + "|";

    //sunzx add @ 20071115
    if (document.all.offerId40Hv.value.trim().replace(/\|/g,"").len()== 0) {

    } else {
      ajaxGetEPf1(document.all.offerId40Hv.value);
        note_info3 += " " + "|";
        //note_info3 += "可选资费描述：" + retResultStr1 + "|";
    }
          //4G项目要求修改免填单 hejwa add 2014年3月6日8:59:57
 //note_info4+=""+"|";
// note_info4+="4G试商用提示："+"|";
// note_info4+="1、中国移动4G业务需要TD-LTE制式终端支持，并更换支持4G功能的USIM卡、开通4G服务功能；"+"|";
// note_info4+="2、客户入网时选用或更换支持4G功能USIM卡时，将同时开通4G服务功能；"+"|";
// note_info4+="3、4G网速较快，办理高档位套餐可以享受更多的流量优惠；"+"|";
// note_info4+="4、4G业务仅在4G网络所覆盖的范围内提供，中国移动将不断扩大4G覆盖区域、提高服务质量。"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

function printInfo3250()
{
  
  var retInfo = "";
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";
  cust_info+="客户姓名： "+document.all.custName.value+"|";
  cust_info+="手机号码： "+"<%=phoneNo%>"+"|";
  cust_info+="证件号码： "+document.all.agent_idNo.value+"|";
  cust_info+="客户地址： "+document.all.stPMcust_addressHi.value+"|";
  
  opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm  :ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌: "+document.all.stPMsm_nameHi.value+ "|";

  opr_info+="办理业务：可选包年套餐申请"+"  操作流水："+"<%=loginAccept%>"+"|";
  opr_info+="申请的可选包年资费："+(document.all.offerId40Hv.value).replace(/\|/g,"")+"--"+(document.all.offerName40Hv.value).replace(/\|/g,"")+"|";
  opr_info+="业务生效时间："+(document.all.offerTim40Hv.value).replace(/\|/g,"").substring(0,8)+"|";
  
  //note_info1+="可选包年资费描述："+note+"|";
        ajaxGetEPf1(document.all.offerId40Hv.value);
        note_info3 += " " + "|";
        note_info3 += "可选资费描述：" + "|";
        note_info3 += retResultStr1 + "|";
  note_info2+=" "+"|";
  if (offerAttrType == "YnL1")
  {
    note_info2+="备注:"+"|";
    
    if (expDateOffset.indexOf("12")!=-1)
     note_info2+="1、来电提醒包年费用30元/年，当时办理，24小时内生效；当时取消，24小时内生效；"+"|";
    else if (expDateOffset.indexOf("3")!=-1)
      note_info2+="1、来电提醒包季费用9元/季，当时办理，24小时内生效；当时取消，24小时内生效；"+"|";
      
    note_info2+="2、办理来电提醒包年、包季业务相当于设置不可及呼转到13800XYZ309。手机终端操作取消或重新设置不可及呼转到其它号码,不可及呼转到13800XYZ309的功能将失效；"+"|";
    note_info2+="3、退订来电提醒包、包季年业务，包年余额不退不转；"+"|";
    note_info2+="4、退订渠道：营业前台办理。"+"|";
  } 
  else{
    note_info2+="备注:"+"可选包年套餐申请，套餐代码："+(document.all.offerId40Hv.value).replace(/\|/g,"")+"|";
  } 
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo = retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo; 
} 
function printInfo3275()
{

    var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";
    var retInfo = "";
   //document.all.belongCity.value = document.all.stPMcust_addressHi.value;
   
  cust_info+="客户姓名： "+document.all.custName.value+"|";
  cust_info+="手机号码： "+"<%=phoneNo%>"+"|";
  cust_info+="证件号码： "+document.all.agent_idNo.value+"|";
  cust_info+="客户地址： "+document.all.stPMcust_addressHi.value+"|";
  
  opr_info+="用户品牌："+document.all.stPMsm_nameHi.value+"    办理业务：可选包年套餐取消"+"|";
    opr_info+="操作流水："+"<%=loginAccept%>"+"|";
    opr_info+="取消的可选包年资费："+document.all.offerName40CanHv.value.replace(/\|/g,"")+"--"+document.all.offerId40CanHv.value.replace(/\|/g,"")+"|";
  opr_info+="业务生效时间：当日"+"|";
  
  note_info1+="备注："+"|";
  
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 

    return retInfo;
}
//爱心卡取消
function printInfo1254()
{
    //得到该业务工单需要的参数

    var time="";

    var cust_info="";  //客户信息
    var opr_info="";   //操作信息
    var note_info1=""; //备注1
    var note_info2=""; //备注2
    var note_info3=""; //备注3
    var note_info4=""; //备注4
    var retInfo = "";  //打印内容
    /********基本信息类**********/
    cust_info+="客户姓名： "+document.all.custName.value+"|";
    cust_info+="手机号码： "+"<%=phoneNo%>"+"|";
    cust_info+="证件号码： "+document.all.agent_idNo.value+"|";
    cust_info+="客户地址： "+document.all.stPMcust_addressHi.value+"|";
       /********受理类**********/
      opr_info+="用户品牌："+document.all.stPMsm_nameHi.value+"|";
      opr_info+="业务类型：爱心卡取消"+"|";
       if(goodbz=="Y"){
          opr_info+="业务流水："+"<%=loginAccept%>"+"       底线消费金额："+modedxpay+"元"+"|";
       }else{
       opr_info+="业务流水："+"<%=loginAccept%>"+"|";
       }
     
     var tempV1 =  document.all.offerIdHv.value.split("|");
     var tempV2 =  document.all.offerNameHv.value.split("|");
     var tempV3 =  document.all.offerTimeHv.value.split("|");

     var tempV4="";
     var tempV5="";
     
     for(var iw =0;iw<tempV1.length;iw++){
        if(tempV1[iw]!=""){
          tempV4+="("+tempV1[iw]+"、"+tempV2[iw]+")";
          tempV5+=tempV3[iw].substring(0,8)+" ";
        }
      }
      
     opr_info+="资费（代码、名称）："+tempV4+";（"+document.all.offerId40Hv.value+" "+document.all.offerName40Hv.value+"）|";
     opr_info+="生效时间："+tempV5+"|";
     opr_info+="　|";
     ajaxGetEPf(document.all.offerIdHv.value.trim(),xqdm);
     opr_info+="新申请主资费描述："+codeChg(document.all.newZOfferDesc.value)+"||";
     if (document.all.offerId40Hv.value.trim().replace(/\|/g,"").len()== 0) {
			} else {
			opr_info+="　|";
      ajaxGetEPf1(document.all.offerId40Hv.value);
    	opr_info+="新申请可选资费描述："+retResultStr1+"|";
    	}
       /*******备注类**********/
      if(bdbz=="Y"){
        opr_info+=bdts+"|";
      }else{
      opr_info+=" "+"|";
      }
    /**********描述类*********/
  var tempNote_info3 = "";
  var tempArray1 = document.all.offerIdArr;
  var tempArray2 = document.all.offerNameArr;
  var tempArray3 = document.all.offerEffectTime;
  var tempArray4 = document.all.offerExpireTime;
  var tempArray5 = document.all.proOptFlag;
  var tempArray6 = document.all.offerZCflag;   
  
   
  for(var h=0;h<tempArray5.length;h++){
    if(tempArray6[h].value!="40"&&(typeof(tempArray6[h])!="undefined")){
      ;
    }else{
      if(tempArray5[h].value=="3"){
        if("<%=current_time%>"==tempArray4[h].value.substring(0,8)) {  
          tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")将被立即取消"+",";
        }else{
          tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")将于下月1日失效"+",";      
        }
      }
    } 
  }
   
  if (tempNote_info3.length >0) {
  note_info1 += " " + "|";
  note_info1 += "新资费生效时将被取消的可选资费:" + codeChg(tempNote_info3) + "|";
  }else {
  
  }          
      if(goodbz=="Y"){
      note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
    }
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
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
/*gaopeng 20131216 2013/12/16 20:17:06 关于2013年9月第一批业务支撑系统市场专业需求（关于主资费捆绑数据业务功能优化的需求）回调函数 start*/
function retOfferMigu139(packet){
	
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var mailzero = packet.data.findValueByName("mailzero");
	var mailfive = packet.data.findValueByName("mailfive");
	var miguzero = packet.data.findValueByName("miguzero");
	var migufive = packet.data.findValueByName("migufive");
	//alert(mailzero+"-"+mailfive+"-"+miguzero+"-"+migufive);
	if(retCode == "000000"){
		$("#mailzero").val(mailzero);
		$("#mailfive").val(mailfive);
		$("#miguzero").val(miguzero);
		$("#migufive").val(migufive);
	}else{
		rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,0) 
    return false;
	}

}
/*gaopeng 20131216 2013/12/16 20:17:06 关于2013年9月第一批业务支撑系统市场专业需求（关于主资费捆绑数据业务功能优化的需求）回调函数 start*/
function offerMigu(){
	
	/*gaopeng 20131216 2013/12/16 20:17:06 关于2013年9月第一批业务支撑系统市场专业需求（关于主资费捆绑数据业务功能优化的需求） start*/
		/*调用新增的查询页面,返回当前的主资费信息，放入隐藏域*/
			var myPacket = new AJAXPacket("/npage/s1270/offerMigu139.jsp","正在查询验证免填单信息，请稍候......");
			  
			  myPacket.data.add("loginAccept","<%=loginAccept%>");
			  core.ajax.sendPacket(myPacket,retOfferMigu139);
			  myPacket=null;
	/*gaopeng 20131216 2013/12/16 20:17:06 关于2013年9月第一批业务支撑系统市场专业需求（关于主资费捆绑数据业务功能优化的需求） end*/
}

var jmz = {};
jmz.getlength = function(str){
	var reallength = 0,len = str.length,charcode=-1;
	for(var i=0;i<len;i++){
		charcode = str.charCodeAt(i);
		if(charcode>=0 && charcode<=128){
			reallength += 1;
		}else{
			reallength += 2;
		}
	}
	return reallength;
}

//主资费变更
function printInfo1270()
{
	
	offerMigu();
      //-----------start--------------wanghyd 20111216 关于全球通全网统一资费业务变更规则调整需求的函
  var iOldOfferId ="";
  var countBaseOfferss = $("#userHadOfferTab tr").length;
  for(var iw=1;iw<countBaseOfferss;iw++){
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="基本"){
   iOldOfferId = $("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text();
   }
  }
  var iNewOfferId =document.all.offerIdHv.value.trim();
  check1270PrInfo(iOldOfferId,iNewOfferId);
  //---------------------------------------------------end---------------
  var infos1270s = document.all.info1270ss.value;
  //alert(infos1270s);
  //得到该业务工单需要的参数
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";

  var exeDate = "";//得到执行时间
  var smCode = "<%=WtcUtil.repNull(request.getParameter("s_city"))%>";
  var region_code = "<%=WtcUtil.repNull(request.getParameter("belong_code"))%>"; //地区代码
  var old_smCode = "<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>";
  var retInfo = "";
    ajaxQueryPPf(document.all.offerIdHv.value);
    var sm_code = retResultStr2;
  /********基本信息类**********/
  cust_info+="客户姓名： "+document.all.custName.value+"|";
  cust_info+="手机号码： "+"<%=phoneNo%>"+"|";
  cust_info+="证件号码： "+document.all.agent_idNo.value+"|";
  cust_info+="客户地址： "+document.all.stPMcust_addressHi.value+"|";

    /********受理类**********/
    opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌: "+document.all.stPMsm_nameHi.value+ "|";
    if(goodbz=="Y"){
      opr_info+="办理业务:主资费变更"+"  "+"操作流水: "+"<%=loginAccept%>" +"    底线消费金额："+modedxpay+"元"+"|";
    }else{
      opr_info+="办理业务:主资费变更"+"  "+"操作流水: "+"<%=loginAccept%>" +"|";
    }
    
   // opr_info+="当前主资费："  +"|";
  var countBaseOffer = $("#userHadOfferTab tr").length;
  for(var iw=1;iw<countBaseOffer;iw++){
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="基本"){
      opr_info+="当前主资费："+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text()+" "+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(1)").text()+"|";
    }
  }
  
    opr_info+="新申请主资费："+document.all.offerIdHv.value.trim()+" "+document.all.offerNameHv.value.trim()+"      "+"新资费生效时间："+document.all.offerTimeHv.value.substring(0,8)+"|";
    
    ajaxGetEPf(document.all.offerIdHv.value.trim(),xqdm);
    
    opr_info+="新申请主资费二次批价："+ document.all.newZOfferECode.value+"-"+document.all.xq_name.value+"*"+"新资费对应品牌："+ sm_code+"|" ;
    //opr_info+=" 新申请主资费描述："+document.all.newZOfferDesc.value+"|";      
    
    if(document.all.dOfferId.value!=""||document.all.dOfferName.value!==""){
      opr_info+="到期后执行资费："+document.all.dOfferId.value.trim()+" "+document.all.dOfferName.value.trim()+"|";
      }
 
    if(document.all.dECode.value!="") {
      opr_info+="到期后二批代码："+document.all.dECode.value+"-"+document.all.xq_name.value+"|";
      }
 
    if(document.all.dOfferDesc.value!="") {
      opr_info+="到期后资费描述："+codeChg(document.all.dOfferDesc.value.trim())+"|";
      }
          
          
  var tempNote_info2 = "本次申请可选套餐：";//申请资费 串
  var tempNote_info3 = "本次取消可选套餐：";//取消资费 串
  
  var tempNote_info4 = "";
  var emergencyKxOfferContent = "";
  
  var tempArray1 = document.all.offerIdArr;
  var tempArray2 = document.all.offerNameArr;
  var tempArray3 = document.all.offerEffectTime;
  var tempArray4 = document.all.offerExpireTime;
  var tempArray5 = document.all.proOptFlag;
  var tempArray6 = document.all.offerZCflag;
  
  for(var h=0;h<tempArray5.length;h++){
    if(tempArray6[h].value!="40"&&(typeof(tempArray6[h])!="undefined")){
      ;
    }else {
      if(tempArray5[h].value=="1"){
        if("<%=current_time%>"==tempArray3[h].value.substring(0,8)){          
            tempNote_info2+="("+tempArray1[h].value+"、"+tempArray2[h].value+"、24小时内生效)";      
            
        }else{
            tempNote_info2+="("+tempArray1[h].value+"、"+tempArray2[h].value+"、预约生效)";   
            
        }
        
        emergencyKxOfferContent+="("+tempArray1[h].value+"、"+tempArray2[h].value+")";   
      }
      else if(tempArray5[h].value=="3"){
        if("<%=current_time%>"==tempArray4[h].value.substring(0,8)) {  
          tempNote_info3+="("+tempArray1[h].value+"、"+tempArray2[h].value+"、24小时内失效)";  
          tempNote_info4+=tempArray1[h].value+"("+tempArray2[h].value+")将被立即取消"+",";    
        }else{
          tempNote_info3+="("+tempArray1[h].value+"、"+tempArray2[h].value+"、预约失效)";     
          tempNote_info4+=tempArray1[h].value+"("+tempArray2[h].value+")将于下月1日失效"+",";
        }
      }     
    }
  }    
  
    if( tempNote_info2 != "" )
    {
      opr_info+=codeChg(tempNote_info2) + "|";
    }
    if(tempNote_info3  != "" )
    {
      opr_info+=codeChg(tempNote_info3) + "|";
    }

    /*******备注类**********/
    if(bdbz=="Y"){
        note_info1+=bdts+"|";
      }
    /**********描述类*********/
  if(document.all.stPMsm_nameHi.value !=sm_code && !(document.all.stPMsm_nameHi.value=="神州行" && document.all.stPMsm_nameHi.value=="全球通"))
  note_info1+="本资费生效后，您的品牌将由"+ document.all.stPMsm_nameHi.value+"变更为"+ sm_code+"；"+"|";
  note_info1+="."+"|";
    note_info1+="新申请主资费描述:"+"|";
    note_info1+=codeChg(document.all.newZOfferDesc.value)+"|";
    if(document.all.offerId40Hv.value.trim().replace(/\|/g,"").len()== 0) {
  }else{
    ajaxGetEPf1(document.all.offerId40Hv.value);
      note_info3+="."+"| ";
      note_info3+="可选资费描述："+"|";
      //alert(retResultStr1.length);
      //alert(emergencyKxOfferContent);
      if(jmz.getlength(retResultStr1) > 1024){
				note_info3+= emergencyKxOfferContent +"|";
			}else{
				note_info3+= retResultStr1 +"|";
			}
    }
    if(tempNote_info4.len()>0) {
        note_info4+=" ."+"|";
        note_info4+="新资费生效时将被取消的可选资费:"+tempNote_info4+"|";
      }else{

      }
    
   	  ajaxQueryOfferTraffic(document.all.offerIdHv.value.trim());//新申请的主资费
		    
    	var dqzzfmc="";
      var countBaseOffer11111 = $("#userHadOfferTab tr").length;
      for(var iw=1;iw<countBaseOffer11111;iw++){
       if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="基本"){
      dqzzfmc=$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(1)").text();
      ajaxQueryOfferTraffic22($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text().trim());//当前的主资费
      }
     }
     
  	if(offerTrafficflag!="0" && offerdangqianflag!="0") {//原主资费和新主资费都是流量不清零资费
     note_info1+="办理主资费变更后，您的"+dqzzfmc+"套餐（原套餐）的剩余流量不再结转至次月；您的"+document.all.offerNameHv.value.trim()+"套餐（新套餐）从生效起，如不发生主资费变更、销户和携号转网等行为，套餐内的剩余流量将会结转至次月使用。"+"|";
    }
    if(offerTrafficflag=="0" && offerdangqianflag!="0") {//原主资费是流量不清零资费，新主资费是流量清零资费
     note_info1+="办理主资费变更后，您的"+dqzzfmc+"套餐（原套餐）的剩余流量不再结转至次月。"+"|";
    } 
    if(offerTrafficflag!="0" && offerdangqianflag=="0") {//原主资费是流量清零资费，新主资费是流量不清零资费
     note_info1+="办理主资费变更后，您的"+document.all.offerNameHv.value.trim()+"套餐（新套餐）从生效起，如不发生主资费变更、销户和携号转网等行为，套餐内的剩余流量将会结转至次月使用。"+"|";
    }    
       
  if(goodbz=="Y"){
      note_info4+=" ."+"|";
      note_info4+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
      if(print12701255){
    	  note_info4 += "为保障您的权益，您原"+retResult212701255+"主资费包含的彩铃业务将为您免费保留一年，保留期间业务每月费用为"+retResult112701255+"元，系统每月赠送您"+retResult112701255+"元专款，相当于免费使用。该保留的彩铃业务随新主资费生效的日期开始起算，到期后如无变化此优惠将自动顺延一年，如有变化系统将提前1个月短信通知。|";
      }
  }
  else{
	  if(print12701255){
	  	note_info4 += "备注：为保障您的权益，您原"+retResult212701255+"主资费包含的彩铃业务将为您免费保留一年，保留期间业务每月费用为"+retResult112701255+"元，系统每月赠送您"+retResult112701255+"元专款，相当于免费使用。该保留的彩铃业务随新主资费生效的日期开始起算，到期后如无变化此优惠将自动顺延一年，如有变化系统将提前1个月短信通知。|";
	  }
	}
  
  note_info4+=" ."+"|";
  /*2013/12/17 10:08:50 20131216 gaopeng 关于2013年9月第一批业务支撑系统市场专业需求（关于主资费捆绑数据业务功能优化的需求） 开始根据数据判断打印免填单添加部分 start*/  
  var mailzero = $("#mailzero").val();
  var mailfive = $("#mailfive").val();
  var miguzero = $("#miguzero").val();
  var migufive = $("#migufive").val();
  /*139 0元*/
  if(mailzero == "Y"){
  	note_info4+="您办理的主资费包含5元139邮箱业务，主资费变更将自动退订该业务，如需保留业务请在主资费变更后发送KTYX5到10086开通，资费5元/月，主资费包含的5元139邮箱业务在主资费生效期间不可变更或取消。"+"|";
  	note_info4+=" ."+"|";
  }
  /*139 5元*/
  if(mailfive == "Y"){
  	note_info4+="您办理的主资费包含5元139邮箱业务，主资费变更将自动退订该业务，如需保留业务请在主资费变更后发送KTYX5到10086开通，资费5元/月。"+"|";
  	note_info4+=" ."+"|";
  }
  /*咪咕0元*/
  if(miguzero == "Y"){
  	note_info4+="您办理的主资费包含咪咕特级会员业务，主资费变更将自动退订该业务，如需保留业务请在主资费变更后发送KTTJ到10086开通，资费6元/月。"+"|";
  	note_info4+=" ."+"|";
  }
  /*咪咕5元*/
  if(migufive == "Y"){
  	note_info4+="您办理的主资费包含咪咕特级会员业务，主资费变更将自动退订该业务，如需保留业务请在主资费变更后发送KTTJ到10086开通，资费6元/月。"+"|";
  	note_info4+=" ."+"|";
  }
/*2013/12/17 10:08:50 20131216 gaopeng 关于2013年9月第一批业务支撑系统市场专业需求（关于主资费捆绑数据业务功能优化的需求） 开始根据数据判断打印免填单添加部分 end*/    
 
  note_info4+="备注:"+codeChg(document.all.tonote.value)+"|";
 //2010-9-16 wanghfa添加 二人世界需求 start
  if (parseInt(document.all.offerIdHv.value.trim()) <= 33230 && parseInt(document.all.offerIdHv.value.trim()) >= 33205) { //生产
  //if (parseInt(document.all.offerIdHv.value.trim()) == 19919 || parseInt(document.all.offerIdHv.value.trim()) == 19628) {//CRMYY环境
    note_info4 += "1、同城热恋套餐仅限设置本地情侣号码、非常号码套餐仅限设置省内情侣号码。|";
    note_info4 += "2、情侣号码必须选择同一款套餐才能享受通话优惠。情侣号码之一号码状态异常或取消二人世界系列套餐，则情侣号码绑定关系自动解除。|";
    note_info4 += "3、若两个号码办理合帐分享，其中一个号码欠费，将影响另一个号码正常通话。|";
    note_info4 += "4、由于客户设置号码或拨打方式有误导致无法享受优惠，移动公司不承担相关责任。|";
  }
  //2010-9-16 wanghfa添加 二人世界需求 end
  /* ningtn 积分清零需求，增加免填单打印 */
  var newSmCode = document.all.bindId[document.all.bindId.selectedIndex].value.substring(0,2);
  var oldSmCode='<%=smCode%>';
  var userCardCode = '<%=cardCode%>';
  if(oldSmCode == "24")
  {
  }
  else
  {
    if(newSmCode != oldSmCode)
    {
      
    }
  }
                      var smzvalues =document.all.smzvalue.value.trim();
            if(smzvalues=="3") {//非实名制全球通、动感地带客户转移为神州行客户
                note_info4+="<%=readValue("1270","ps","jf",Readpaths)%>"+"|";
            }

    if(infos1270s=="1") {
  var countBaseOfferssd = $("#userHadOfferTab tr").length;
  for(var iw=1;iw<countBaseOfferssd;iw++){
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="基本"){
    	/*2014/06/23 15:23:35 gaopeng R_CMI_HLJ_xueyz_2014_1644797@关于申请修改工单提示的请示 干掉下面的提示*/
    	/*note_info4+="您办理"+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(1)").text()+"套餐获赠的139邮箱5元版将于新资费生效之日起开始收费，每月收费5元。"+"|";*/
    }
  }

  }
        //4G项目要求修改免填单 hejwa add 2014年3月6日8:59:57
// note_info4+=""+"|";
// note_info4+="4G试商用提示："+"|";
// note_info4+="1、中国移动4G业务需要TD-LTE制式终端支持，并更换支持4G功能的USIM卡、开通4G服务功能；"+"|";
// note_info4+="2、客户入网时选用或更换支持4G功能USIM卡时，将同时开通4G服务功能；"+"|";
// note_info4+="3、4G网速较快，办理高档位套餐可以享受更多的流量优惠；"+"|";
// note_info4+="4、4G业务仅在4G网络所覆盖的范围内提供，中国移动将不断扩大4G覆盖区域、提高服务质量。"+"|";
  /* ningtn 积分清零需求，增加免填单打印 */
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}


function ajaxQueryOfferTraffic(offerids) {
		var funtionnames_Packet = new AJAXPacket("/npage/s1104/queryOfferTraffic.jsp","正在查询，请稍后......");
		funtionnames_Packet.data.add("offerId",offerids);
		core.ajax.sendPacket(funtionnames_Packet,doreturnFunctions);
		funtionnames_Packet=null;
}

  function doreturnFunctions(packet) {
    var queryCount = packet.data.findValueByName("queryCount");
		offerTrafficflag=queryCount;
  }

function ajaxQueryOfferTraffic22(offerids) {
		var funtionnames_Packet = new AJAXPacket("/npage/s1104/queryOfferTraffic.jsp","正在查询，请稍后......");
		funtionnames_Packet.data.add("offerId",offerids);
		core.ajax.sendPacket(funtionnames_Packet,doreturnFunctions22);
		funtionnames_Packet=null;
}

  function doreturnFunctions22(packet) {
    var queryCount = packet.data.findValueByName("queryCount");
		offerdangqianflag=queryCount;
  }

function printInfo3257()
{
  //得到该业务工单需要的参数
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";

  cust_info+="客户姓名： "+document.all.custName.value+"|";
  cust_info+="手机号码： "+"<%=phoneNo%>"+"|";
  cust_info+="开始时间：    "+document.all.offerEffDateCanHv.value.replace(/\|/g,"")+"|";
 
  opr_info+="业务类型:         全球通温馨家庭取消"+"|";
  opr_info+="取消号码:         "+"<%=phoneNo%>"+"|";
  opr_info+="流水:             "+"<%=loginAccept%>"+"|";
  
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}
function printInfo4205()
{

  var retInfo = "";
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";
  cust_info+="客户姓名： "+document.all.custName.value+"|";
  cust_info+="手机号码： "+"<%=phoneNo%>"+"|";
  
  opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌: "+document.all.stPMsm_nameHi.value+ "|";
  
  opr_info+="办理业务：漫游定向资费申请"+"  操作流水："+"<%=loginAccept%>"+"|";
  opr_info+="申请资费："+(document.all.offerId40Hv.value).replace(/\|/g,"")+"--"+(document.all.offerName40Hv.value).replace(/\|/g,"")+"|";
  if ( (offerAttrType =="YnDz" ) &&"<%=current_time%>">document.all.offerTimeHv.value.substring(0,8))
  {
    opr_info+="该资费下月1日生效，"+document.all.offerExpTime.value+"失效，原有两城一家套餐下月1日失效"+"|";
  }
  else if ( (offerAttrType =="YnDy" ) &&"<%=current_time%>"==document.all.offerTimeHv.value.substring(0,8))
  {
    opr_info+="该资费24小时之内生效，         失效时间："+document.all.offerExpTime.value+" "+"0时"+"|";
  }
  else if ( (offerAttrType =="YnDy" ) &&"<%=current_time%>">document.all.offerTimeHv.value.substring(0,8))
  {
    opr_info+="该资费下月1日生效，"+document.all.offerExpTime.value+"失效,原有两城一家套餐下月1日失效 "+"|";
  }   
  else
  {
    opr_info+="业务生效时间：24小时之内         失效时间："+document.all.offerTim40EffHv.value.substring(0,8)+" "+"0时"+"|";
  }
  note_info1+="资费描述："+note+"|";
  note_info1+="          资费失效后优惠自动取消。"+"|";
  note_info1+="说明:发生集团V网内部通话，资费按集团V网资费标准收取。"+"|";
  note_info2+="备注:"+"漫游定向资费申请，套餐代码："+document.all.offerId40Hv.value+"|";
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}
function printInfo4208()
{

  var retInfo = "";
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";
  
  cust_info+="客户姓名： "+document.all.custName.value+"|";
  cust_info+="手机号码： "+"<%=phoneNo%>"+"|";
  cust_info+="证件号码： "+document.all.agent_idNo.value+"|";
  cust_info+="客户地址： "+codeChg(document.all.stPMcust_addressHi.value)+" "+"|";
  
  opr_info+="用户品牌："+document.all.stPMsm_nameHi.value+"    办理业务：漫游定向资费取消"+"|";
    opr_info+="操作流水："+"<%=loginAccept%>"+"|";
    opr_info+="取消资费："+document.all.offerName40CanHv.value.replace(/\|/g,"")+"--"+document.all.offerId40CanHv.value.replace(/\|/g,"")+"|";
    if (offerAttrType=="YnDy"||offerAttrType=="YnDz")
    {
      opr_info+="取消当日申请资费和预约未生效资费，24小时之内生效；取消当前在用资费，下月生效"+"|";
    }
    else
    {
      opr_info+="业务生效时间：24小时之内"+"|";
    }
    note_info1 = note_info1 + ""+"|";
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}

/*2014/04/04 11:02:20 gaopeng 调用公共查询返回品牌sm_code*/
	function getPubSmCode(kdNo){
			var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("phoneNo","");
			getdataPacket.data.add("kdNo",kdNo);
			core.ajax.sendPacket(getdataPacket,doPubSmCodeBack);
			getdataPacket = null;
	}
	function doPubSmCodeBack(packet){
		retCode = packet.data.findValueByName("retcode");
		retMsg = packet.data.findValueByName("retmsg");
		smCode = packet.data.findValueByName("smCode");
		if(retCode == "000000"){
			$("#pubSmCode").val(smCode);
		}
	}
	
function printInfoe092(){
	getPubSmCode("<%=broadPhone%>");
	var pubSmCode = $("#pubSmCode").val();
	
  var retInfo = "";
  
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";  
  
  cust_info += "宽带帐号：" + "<%=broadPhone%>" + "|";
  cust_info += "客户姓名：" + document.all.custName.value + "|";
  opr_info += "业务办理名称：主资费变更" + "     操作流水:" + "<%=loginAccept%>" + "|";
  var countBaseOffer = $("#userHadOfferTab tr").length;
  for(var iw=1;iw<countBaseOffer;iw++){
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="基本"){
      opr_info+="当前主资费："+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text()+" "+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(1)").text()+"|";
    }
  }
  opr_info+="新申请主资费："+document.all.offerIdHv.value.trim()+" "+document.all.offerNameHv.value.trim()+"      "+"新资费生效时间："+document.all.offerTimeHv.value.substring(0,8)+"|";
  
  ajaxGetEPf(document.all.offerIdHv.value.trim(),xqdm);
  note_info1+="新申请主资费描述:"+"|";
  note_info1+=codeChg(document.all.newZOfferDesc.value)+"|";
  if(pubSmCode == "kf" || pubSmCode == "ki"){
  		
			note_info1 += "备注："+"|";
			note_info1 += "1、当联系电话变动时，请及时与移动公司联系，以便于有新活动或服务到期时及时收到通知。"+"|";
			note_info1 += "2、如需帮助，请拨打服务热线：10086。"+"|";
	}
  
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}
function printInfoe301(){
  var retInfo = "";
  
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";  
  
  cust_info += "宽带帐号：" + "<%=broadPhone%>" + "|";
  cust_info += "客户姓名：" + document.all.custName.value + "|";
  opr_info += "业务办理名称：包年取消" + "  办理方式：凭密码办理    操作流水:" + "<%=loginAccept%>" + "|";
  var countBaseOffer = $("#userHadOfferTab tr").length;
  for(var iw=1;iw<countBaseOffer;iw++){
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="基本"){
      opr_info+="取消的包年资费："+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text()+" "+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(1)").text()+"|";
    }
  }
    
  opr_info += "取消后执行资费：" + document.all.offerIdHv.value+" "+document.all.offerNameHv.value + "  *" + "生效时间：" + document.all.offerTimeHv.value.substring(0,8) + "|";
  
  ajaxQueryPPf(document.all.offerIdHv.value);
  note_info1 += "备注：包时取消后将无法恢复包年。包年取消时将按包年剩余话费的30%收取违约金。" + "|";
  note_info1 += "取消后执行资费描述：" + document.all.newZOfferDesc.value + "|";
  note_info1 += note + "|";
  /*******备注类**********/
  if (bdbz == "Y") {
      note_info1 += bdts + "|";
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