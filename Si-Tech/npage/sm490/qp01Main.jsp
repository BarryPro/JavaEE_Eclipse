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
  
  String region_flag="hlj";//�����־
  String brandID  = "";
  String display="display:none";
  
  
  //�ӹ��ﳵҳ�洫��  
  String gCustId = WtcUtil.repNull(request.getParameter("gCustId"));
  String phoneNo  = WtcUtil.repNull(request.getParameter("phoneNo"));
  String broadPhone  = WtcUtil.repNull(request.getParameter("broadPhone"));
  String prtFlag  = WtcUtil.repNull(request.getParameter("prtFlag"));
  String offerSrvId  = WtcUtil.repNull(request.getParameter("offerSrvId"));
  String custLevelStar  = WtcUtil.repNull(request.getParameter("custLevelStar"));//�ͻ��ȼ�
  String servId = offerSrvId;
  String getSmCodeSql="select b.band_id from product_offer_instance a,product_offer b where  a.offer_id = b.offer_id  and    b.offer_type = 10 and    sysdate between a.eff_date and a.exp_date and    a.serv_id ="+servId;
  System.out.println("getSmCodeSql|"+getSmCodeSql);
  String smCode="";
  String OPflag =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");//OPflag == "2"ʱΪ�ͷ����Ž���
  %>
  <%
    /* begin diling update for �������ӿ�������ͻ��Ǽ���Ϣ��֤���ܵĺ�@2013/9/22 */
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
          if(Integer.parseInt(ret_checkRealUser[0][0])>0){ //����0Ϊ��ʵ�����û�
    %>
            <SCRIPT type=text/javascript>
              rdShowMessageDialog("�����Ƚ�����ʵ��ݵǼǣ�ʵ���ǼǺ󷽿ɰ����ʷѱ����",1);
              removeCurrentTab();           
            </SCRIPT>
    <%
          }
        }
      }else{
    %>
            <SCRIPT type=text/javascript>
              rdShowMessageDialog("������Ϣ��<%=retCode1%><br>������룺<%=retMsg1%>",0);
              removeCurrentTab();
            </SCRIPT>
    <%   
      }
    }
    /* end diling update for �������ӿ�������ͻ��Ǽ���Ϣ��֤���ܵĺ�@2013/9/22 */
    %>
    
    
    <%
    /* begin liangyl add for ����LTE-FIҵ��ȡ��ʱ��ΥԼ������ĺ�@2016/9/7 */
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
          if(Integer.parseInt(result_t[0][0])>0){ //����0Ϊ��ʵ�����û�
    			display="display:display";
          }
        }
      }else{
    %>
            <SCRIPT type=text/javascript>
              rdShowMessageDialog("������Ϣ��<%=retCodeW%><br>������룺<%=retMsgW%>",0);
              removeCurrentTab();
            </SCRIPT>
    <%   
      }
    }
    /* end liangyl add for ����LTE-FIҵ��ȡ��ʱ��ΥԼ������ĺ�@2016/9/7 */
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
  String custOrderId = WtcUtil.repNull(request.getParameter("custOrderId"));    //�ͻ�������
  String orderArrayId = WtcUtil.repNull(request.getParameter("orderArrayId"));  //�ͻ���������ID
  String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));    //�ͻ��������
  String servOrderId = WtcUtil.repNull(request.getParameter("servOrderId"));    //���񶩵�ID
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
String vFeeFlag="";
%>

<%
	if("e301".equals(opCode)){
		//7����׼�����
		String paraAray[] = new String[8];
		paraAray[0] = "";                                       //��ˮ
		paraAray[1] = "01";                                     //��������
		paraAray[2] = opCode;                                   //��������
		paraAray[3] = (String)session.getAttribute("workNo");   //����
		paraAray[4] = (String)session.getAttribute("password"); //��������
		paraAray[5] = phoneNo;                                  //�û�����
		paraAray[6] = "";                                       //�û�����
		paraAray[7] = "";									//��ע
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
var offerInfoHash = new Object(); //����Ʒ��Ʒ��Ϣ 
var AttributeHash = new Object(); //������Ϣ
var oldOfferAry = new Array();    //ȡ��������Ʒ
var newOfferAry = new Array();    //������Ʒ��Ϣ
var showPageNum = 1;
var thePageNum = 1;               //��ǰҳ��
var currentOfferId = "";          //����ƷĿ¼��չ��������ƷID
var CanOfferCancel = 0;           //����Ʒ�Ƿ���˶���ʶ
var CanUndoOpe = 0;               //�����˶��Ƿ�ɲ�����ʶ
var CanOfferBook = 0;             //����Ʒ�Ƿ�ɶ�����ʶ
var MainOfferFlag=0;
var thisMonthOfferId = "<%=offerId%>";
var operateFlag = 1;  //ҵ������
var arrClassValue = new Array();
var offerIdArr = new Array();      //����ƷID
var offerNameArr=new Array();     //����Ʒ���ƣ���ӡ�ã�
var offerEffectTime = new Array();
var offerExpireTime = new Array();
var xqdm = "";
var WYJflag="0";
/*2014/12/03 9:24:16 gaopeng С���ʷ���С���������� 
	����С�����������б�չʾʱ��Ҳ����ajax_jdugeAreaHidden.jsp ����Yʱ�����ʷ�ΪС���ʷѵ�ȫ�ֱ�����Ĭ�ϲ���С���ʷ�
*/
var xqjfFlag = false;
var zdxq="";
var vpmnstr1="";
var checke177flag="yes";
var checke177flag111="yes";
var offerTrafficflag="0"; //0�Ƕ��������ʷ��������㣬��0Ϊ���������ʷ�����������----����������ʷ�
var offerdangqianflag="0"; //0�ǵ�ǰ�����ʷ��������㣬��0Ϊ��ǰ�����ʷ�����������----��ǰ�ĵ����ʷ�
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
     //��������������Ʒ
     MainOfferFlag=1;
    
  <%
    }else if(resPosc[0][2].trim().equals("1")){
  %>  
    //ֻ׼������������Ʒ
    $("#qryOfferBtn").unbind();
    $("#qryOfferBtn").bind("click",qryAddOffer);
    qryMainOfferRoleInfo();
    HoverLi(2,2);
    $("#tb_1").css("display","none");
  <%
    }else{    
  %>
    //�����κ�����
  
  <%    
    }
  }
  %>
  
    //selectBand();//��ʼ����
    qryOfferInst(); //��ѯ�û���ǰ������ϵ
    
    //qryMainOfferRoleInfo(); //�鹺��������Ʒ�Ľ�ɫ��Ϣ
    
    addSmCode();
    setOfferType();
    getCurrentOpeInfo();
  
  $("#showInfoDiv :checkbox").bind("click",showInfo);
  //$("[name='searchType']").bind("click",changeSearch);

  {
    //$("#rootTree").css("display","none"); 
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
    
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="����"&&$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(4)").text()=="��Ч"){
      thisMonthOfferId2 = $("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text();
    }
  }
<%if(opCode.equals("3250")||opCode.equals("1272")){%> 
if(thisMonthOfferId2!=thisMonthOfferId) 
  thisMonthOfferId = thisMonthOfferId2;
<%}%>

//hejwa 2013��9��23��8:39:38 ���� �ͷ�Ĭ�ϲ�չʾ�ͻ���Ϣ��ǩ
  if("<%=OPflag%>"==2){
      $("#userInfoChkBox").get(0).checked = false;
      $("#userInfoDiv").hide();   
  }

}); 
var print12701255=false;
var retResult112701255="";
var retResult212701255="";
function go_showPrompt(){
	  var packet = new AJAXPacket("ajax_showPrompt.jsp","���Ժ�...");
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
			alert("Ϊ��������Ȩ�棬��ԭ"+retResult212701255+"���ʷѰ����Ĳ���ҵ��Ϊ����ѱ���һ�꣬�����ڼ�ҵ��ÿ�·���Ϊ"+retResult112701255+"Ԫ��ϵͳÿ��������"+retResult112701255+"Ԫר��൱�����ʹ�á��ñ����Ĳ���ҵ���������ʷ���Ч�����ڿ�ʼ���㣬���ں����ޱ仯���Żݽ��Զ�˳��һ�꣬���б仯ϵͳ����ǰ1���¶���֪ͨ��");
			print12701255=true;
		}
		else{
			print12701255=false;
		}
	}
}

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
    $("#offerListDiv").empty(); //��տ�ѡ����Ʒչʾ��
    $("#offerType").parent().hide();  //���ز�ѯ����
    $("#bindId").parent().hide(); //����ҵ��Ʒ��
    $("#custType").parent().hide(); //���ؿͻ�����
    $("#roleInfoP").show();
    operateFlag = 2;
  }else if(n == 3){ 
                    
  }
} 
//���ʷѱ�� ����Ʒ��������
function setOfferType(){
      var packet = new AJAXPacket("ajax_getOfferType.jsp","���Ժ�...");
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
      //selectObj.options.add(new Option("--��ѡ��--",""));
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

//------��ѯ�û���ǰ������ϵ---------
function qryOfferInst(){
  var packet = new AJAXPacket("qryOfferInst.jsp","���Ժ�...");
  packet.data.add("servId","<%=servId%>");
  packet.data.add("opCode","<%=opCode%>");
  core.ajax.sendPacketHtml(packet,doQryOfferInst);
  packet =null;
}
function doQryOfferInst(data){
  $("#userHadOfferDiv").html(data);
  $("[name='cancelBtn']").bind("click",cancelOffer);  
}

//-------���ж�����ϵ�˶�-------------
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

  /*����ʱУ������*/
  if (optype=="Y")
  {
    var patrn = /^[0-9]*[1-9][0-9]*$/;
    var sInput =document.getElementById("exp"+offerId).value;
    if (sInput.search(patrn) == -1) {
      rdShowMessageDialog("ʧЧʱ�����������!",0) 
      return false
    }

    if ( exptime<=efftime )
    {
      rdShowMessageDialog("ʧЧʱ����������Чʱ��!",0)  
      return false
    }
    
    if ( exptime.length!=8 )
    {
      rdShowMessageDialog("ʧЧ���ڱ���8λ,��ʽYYYYMMDD",0);
      return false;
    }
    if ( (parseInt(exptime.substring(4,6),10)>12 || (parseInt(exptime.substring(4,6),10)<1) ) )
    {
      rdShowMessageDialog("ʧЧʱ���·ݴ���",0);
      return false;
    } 

    var yyyy=efftime.substring(0,4);
    var mm=efftime.substring(4,6);
    var dd=efftime.substring(6,8);        
    /*js������ʱ��*/
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
      rdShowMessageDialog("�������������,��"+y_tm+"��!",0);
      return false;
    }
    
  }
  //alert("offerId|"+offerId);
  document.all.offerId40CanHv.value += offerId+"|";
  document.all.offerName40CanHv.value +=offerName+"|";
  document.all.offerEffDateCanHv.value +=offerEffDateCanHv+"|";
  //alert("document.all.offerId40Hv.value|"+document.all.offerId40Hv.value);
  var packet = new AJAXPacket("cancelOffer.jsp","���Ժ�...");
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
    //rdShowMessageDialog("�˶��ɹ�!");
    
    var packet = new AJAXPacket("checke177.jsp","���Ժ�...");
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
	/*2015/04/20 10:37:40 gaopeng ��������ʱ����*/
	
	if(useIntegralFlag == "true"){
		/*div*/
		$("#integralFiledAll").hide();
		/*ѡ��*/
		$("input[name='ifUseIntegral']").attr("checked","");
		/*չʾ������Ϣ*/
		$("#IntegralFiled").hide();
		useIntegralFlag = "false";
	}
	
  var offerId = this.name.split("|")[0];
  var offerInstId = this.name.split("|")[1];  
  
  if(document.all.attrFlagOfferId.value ==offerId){  //ɾ��С�� ��ʼ����־λ hejwa
      document.all.attrFlagHv.value="0";
      document.all.attrFlagOfferId.value = "0";
  }
  
  var packet = new AJAXPacket("undoOrder.jsp","���Ժ�...");
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
//----------��������Ʒ��Ϣ����--------
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
    rdShowMessageDialog("�������ѯ����!");
    return false; 
  }
  */
  var packet = new AJAXPacket("qryMainOffer.jsp","���Ժ�...");
  packet.data.add("servId","<%=offerSrvId%>");
  packet.data.add("offerId",offerId);
  packet.data.add("relMainOfferId",thisMonthOfferId); //thisMonthOfferId��qryOfferInst.jsp������
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
  var roleId = $("#roleId").val();
  var offerId = $("#offerId").val();
  var offerName = $("#offerName").val();
  //alert($("#offerId").get(0));
  
  //if(!validateElement($("#offerId").get(0))){
    //return false; 
  //}
  
  var packet = new AJAXPacket("qryRealOfferId.jsp","���Ժ�...");
  packet.data.add("loginAccept","<%=loginAccept%>");
  packet.data.add("opCode","<%=opCode%>");
  core.ajax.sendPacket(packet,doQryRealOfferId);
  packet =null; 
  
  var relMainOfferId="";
  if(document.all.RealOfferId.value=="0"){
     relMainOfferId= thisMonthOfferId;    //Ĭ��Ϊ���»�������Ʒ
  }else{
     relMainOfferId= document.all.RealOfferId.value;
   }
  
  if($("input[name='mainOfferType']:checked").val() == 1){
    
  }
  
  var packet = new AJAXPacket("qryAddOffer.jsp","���Ժ�...");
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
  packet.data.add("relMainOfferId",thisMonthOfferId); //thisMonthOfferId��qryOfferInst.jsp������
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
     relMainOfferId= thisMonthOfferId;    //Ĭ��Ϊ���»�������Ʒ
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
  
        var countBaseOffer = $("#userHadOfferTab tr").length;
      var thisMonthOfferId2111="";
    for(var iw=1;iw<countBaseOffer;iw++){
    
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="����"&&$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(4)").text()=="��Ч"){
      thisMonthOfferId2111 = $("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text();
    }
    }
  
    var packet = new AJAXPacket("checkeAddAndQuit.jsp","���Ժ�...");
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
	if("<%=opCode%>" == "e092"){
		/*��У���Ƿ����չʾʹ�û�����Ϣ��У��ɹ���� openIntegral() */
		checkShowIntegral(offer_id);
		//diling add for �ж��Ƿ���ʾ�°�С������@2013/3/14
	}
	if("<%=opCode%>"=="1270"||"<%=opCode%>"=="1255"){
		go_showPrompt();
	}
	
	jdugeAreaHidden(offer_id);
  
}
var useIntegralFlag = "false";
/*���Ƿ�ʹ�û���ҳ�淽��*/
function openIntegral(){
	
	var path = "/npage/public/integralOpen.jsp?iOpCode=<%=opCode%>&iOpName=<%=opName%>";
	path += "&loginAccept=<%=loginAccept%>";
	path += "&iChnSource=01";
	path += "&iLoginNo=<%=workNo%>";
	path += "&iLoginPwd=<%=noPassWord%>";
	path += "&iKdNo="+$.trim($("#stPMvPhoneNo").val());
	/*ʹ��showModalDialog���� �����Զ����ж����ֽ�*/
	var returnVal = window.showModalDialog(path,"","dialogWidth=800px;dialogHeight=600px");
	//alert("trueΪ����ʹ�û�����Ϣ---"+returnVal);
	
	var retArray = new Array();
	retArray = returnVal.split("|");
	
	/*ֱ�Ӹ�ֵȫ�ֱ���*/
	useIntegralFlag = retArray[0];
	/*���ʹ�û�����*/
	if(retArray[0] == "true"){
		/*div*/
		$("#integralFiledAll").show();
		/*ѡ��*/
		$("input[name='ifUseIntegral']").attr("checked",true);
		$("input[name='ifUseIntegral']").attr("disabled","disabled");
		/*չʾ������Ϣ*/
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
			/*ѡ��*/
			$("input[name='ifUseIntegral']").attr("checked","");
			/*չʾ������Ϣ*/
			$("#IntegralFiled").hide();
		
	}
	
}

/*2015/04/22 10:39:17 gaopeng �Ƿ�չʾʹ�û���*/
var ifCheckIntegralFlag = false;
/*У���Ƿ�չʾ �Ƿ�ʹ�û��ָ�ѡ��*/
function checkShowIntegral(offer_id){
		
		var getdataPacket = new AJAXPacket("/npage/public/fCheckShowIntegral.jsp","���ڻ�����ݣ����Ժ�......");
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
				/*�����Ƿ�ʹ�û���ҳ��*/
				openIntegral();
				
			}else{
				ifCheckIntegralFlag = false;
				$("#integralFiledAll").hide();
				$("#ifUseIntegral").attr("checked",false);
			}
			
		}else{
			ifCheckIntegralFlag = false;
			rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
			$("#integralFiledAll").hide();
			$("#ifUseIntegral").attr("checked",false);
			
		}
}

		var globalMarkFlag = false;
		function markIntegral(){
			
			var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
			/*2015/04/22 10:42:04 gaopeng ѡ����ֵ ����Ϊ��*/
			var iPhoneNo = ifUseIntegral == true ? $.trim($("#intePhoneNo").val()):"";
			var iUserPwd = ifUseIntegral == true ? $.trim($("#intePassWord").val()):"";
			var inteUseNum = ifUseIntegral == true ? $.trim($("#inteUseNum").val()):"";
			var iKdNo = $.trim($("#stPMvPhoneNo").val());
			var getdataPacket = new AJAXPacket("/npage/public/fMarkIntegral.jsp","���ڻ�����ݣ����Ժ�......");
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
					rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
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
          var packet = new AJAXPacket("checkeAddAndQuit.jsp","���Ժ�...");
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
              var packet = new AJAXPacket("checkeAddAndQuit.jsp","���Ժ�...");
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

  var packet = new AJAXPacket("ajax_jdugeAreaHidden.jsp","���Ժ�...");
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
  var hiddenFlag =  packet.data.findValueByName("hiddenFlag");//�Ƿ���ʾС�������ʶ
  var offer_id =  packet.data.findValueByName("offerId");//�ʷѴ���

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
    
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="����"&&$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(4)").text()=="��Ч"){
      thisMonthOfferId2111 = $("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text();
    }
    }
  
    var packet = new AJAXPacket("checkeAddAndQuit.jsp","���Ժ�...");
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
		//alert("trueΪ��¼ʹ�û���ֵ"+ifUseIntegral+"---�Ƿ�Ϊkf�����ʷ�--"+ifCheckIntegralFlag);
		/*���Ϊkf�����ʷѣ���¼�����㲻ѡ��ʹ�û���Ҳ��¼��ֻ������¼��*/
		if(ifCheckIntegralFlag){
			markIntegral();
			if(!globalMarkFlag){
		    return false;
			}
		}

    var packet = new AJAXPacket("applyMainOffer.jsp","���Ժ�...");
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

//-------------------��ȡ����/�˶���Ϣ--------------------
function getCurrentOpeInfo(){

  var packet = new AJAXPacket("getCurrentOpeInfo.jsp","���Ժ�...");
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
      var offerStatus = n[11];  //����Ʒ״̬ 1�� ���� 2����� 3���˶�
      var offerOrProd = n[13];  //����Ʒ��Ʒ��ʶ 0�� ����Ʒ 1: ��Ʒ
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
      var offerStatus = n[11];  //����Ʒ״̬ 1�� ���� 2����� 3���˶�
      var imageFlag = n[12];
      //alert("imageFlag|"+imageFlag);
      var offerOrProd = n[13];  //����Ʒ��Ʒ��ʶ 0�� ����Ʒ 1: ��Ʒ
      var offerType = n[14];

      if((offerStatus == 1 || offerStatus == 2) && offerOrProd == 0){
           //buttonStr+="<div id='basicInfo_"+offer_id+"' name='"+effTime+"|"+expTime+"|"+offerInstId+"' class='but_set'><span>������Ϣ</span></div>";  
        if(groupTypeId != 0){
          <%
            if(opCode.equals("7977")){
           %> 
             buttonStr+="<input name='"+offer_name+"' type='button' value='Ⱥ��' id='group_"+offer_id+"' _groupId='"+groupTypeId+"' class='but_groups' />"; 
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
        		$("#addedOfferTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name='' ><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,9)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,9)+"</td><td style='display:none;'><img src='/nresources/default/images/task-item-close1.gif' style='cursor:Pointer;' class='del_cls' name='"+offer_id+"|"+offerInstId+"' alt='����ɾ��ѡ�������Ʒ' id='del_"+offer_id+"'></td>");
        	}else{
	          $("#addedOfferTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name='' ><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,9)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,9)+"</td><td><img src='/nresources/default/images/task-item-close1.gif' style='cursor:Pointer;' class='del_cls' name='"+offer_id+"|"+offerInstId+"' alt='ɾ��ѡ�������Ʒ' id='del_"+offer_id+"'></td>");
	        }
          
        }
        else{
        	if(offer_id == "42423"){
        		$("#addedOfferTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name='' ><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,9)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,9)+"</td><td style='display:none;'><img src='/nresources/default/images/task-item-close.gif' style='cursor:Pointer;' class='del_cls' name='"+offer_id+"|"+offerInstId+"' alt='����ɾ��ѡ�������Ʒ' id='del_"+offer_id+"'></td>");
        	}else{
	          $("#addedOfferTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name='' ><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,9)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,9)+"</td><td><img src='/nresources/default/images/task-item-close.gif' style='cursor:Pointer;' class='del_cls' name='"+offer_id+"|"+offerInstId+"' alt='ɾ��ѡ�������Ʒ' id='del_"+offer_id+"'></td>");
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
          
        $("#addedOfferTab .del_cls").bind("click",cancelOrder); //�������ζ���
        $("#addedOfferTab :button[id^='group']").bind('click', showGroup);
        $("#addedOfferTab :button[id^='att']").bind('click', showAttribute);
        $("div[id^='basicInfo_']").bind("click",setBasicInfo);
        }else if((offerStatus == 3 ||offerStatus=="Y" ) && offerOrProd == 0){
        if(imageFlag=="1"||imageFlag=="2"){/*task-item-close1 �Ǻ��*/
          $("#offerUnbookTab").append("<tr id='tr_"+offer_id+"'><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,8)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,8)+"</td><td><img src='/nresources/default/images/task-item-close1.gif' style='cursor:hand' alt='�����˶�' name='"+offer_id+"|"+offerInstId+"' ></td>");

        }
        else{
          $("#offerUnbookTab").append("<tr id='tr_"+offer_id+"'><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,8)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,8)+"</td><td><img src='/nresources/default/images/task-item-close.gif' style='cursor:hand' alt='�����˶�' name='"+offer_id+"|"+offerInstId+"' ></td>");
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
          if(existFlag || rdShowConfirmDialog("�����������ʷ�δ�������ط����Ƿ�ͬʱ�������磿")==1)
          { 
            $("#addedProdTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name=''><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,8)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,8)+"</td><td><img src='/nresources/default/images/task-item-close1.gif' style='cursor:hand' class='del_cls' name='"+offer_id+"|"+offerInstId+"' alt='ɾ��ѡ��Ĳ�Ʒ' id='del_"+offer_id+"'></td>");
          }else{
              var packet = new AJAXPacket("undoOrder.jsp","���Ժ�...");
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
          $("#addedProdTab").append("<tr id='tr_"+offer_id+"' style='cursor:hand' name=''><td><img src='/nresources/default/images/icon_no.gif' style='cursor:hand' name='' alt='' id=''></td><td>"+offer_id+"</td><td>"+offer_name+"</td><td id='effTimeTd_"+offer_id+"'>"+effTime.substring(0,8)+"</td><td id='expTimeTd_"+offer_id+"'>"+expTime.substring(0,8)+"</td><td><img src='/nresources/default/images/task-item-close.gif' style='cursor:hand' class='del_cls' name='"+offer_id+"|"+offerInstId+"' alt='ɾ��ѡ��Ĳ�Ʒ' id='del_"+offer_id+"'></td>");
          }
          
        
        
        $("#addedProdTab").append("<input type='hidden' name='offerZCflag' value='"+n[14]+"' /><input type='hidden' name='offerIdArr' value='"+offer_id+"' /><input type='hidden' name='offerNameArr' value='"+offer_name+"'/><input type='hidden' name='offerEffectTime' value='"+effTime+"'/><input type='hidden' name='offerExpireTime' value='"+expTime+"'/><input type='hidden' name='proOptFlag' value='"+offerStatus+"'/><input type='hidden' name='offerOrProdFlag' value='"+offerOrProd+"'/></tr>");
        $("#addedProdTab .del_cls").bind("click",cancelOrder);  //�������ζ���
      }else if(offerStatus == 3 && offerOrProd == 1){
        $("#prodUnbookTab").show();
        
        
        if(imageFlag=="1"||imageFlag=="2"){
          $("#prodUnbookTab").append("<tr id='tr_"+offer_id+"'><td>"+offer_id+"</td><td>"+offer_name+"</td><td>"+effTime.substring(0,8)+"</td><td>"+expTime.substring(0,8)+"</td><td><img src='/nresources/default/images/task-item-close1.gif' style='cursor:hand' alt='�����˶�' name='"+offer_id+"|"+offerInstId+"' ></td>");
        }
        else{
          $("#prodUnbookTab").append("<tr id='tr_"+offer_id+"'><td>"+offer_id+"</td><td>"+offer_name+"</td><td>"+effTime.substring(0,8)+"</td><td>"+expTime.substring(0,8)+"</td><td><img src='/nresources/default/images/task-item-close.gif' style='cursor:hand' alt='�����˶�' name='"+offer_id+"|"+offerInstId+"' ></td>");
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

/*-------------�ı��ѯ��ʽ:Ŀ¼��/������ѯ--------------
function changeSearch(){
  if(this.value == 0){
    $("#rootTree").css("display",""); 
    $("#searchOfferConDiv").css("display","none");  
  }else{
    $("#rootTree").css("display","none"); 
    $("#searchOfferConDiv").css("display","");  
  } 
}*/

//-------------�趨����Ʒ������Ϣ----------
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
    $("#changePageDiv span:eq(1)").html("��ǰ��1ҳ");
  }else if(page == 'N'){
    showPageNum++;
    if(showPageNum <= thePageNum-1){
      $("#page_"+(showPageNum-1)).css("display","none");
      $("#page_"+showPageNum).css("display","");  
      $("#changePageDiv span:eq(1)").html("��ǰ��"+showPageNum+"ҳ");
    }else{
      showPageNum--;
    } 
  }else if(page == 'P'){
    showPageNum--;
    if(showPageNum >= 1){
      $("#page_"+(showPageNum+1)).css("display","none");
      $("#page_"+showPageNum).css("display","");
      $("#changePageDiv span:eq(1)").html("��ǰ��"+showPageNum+"ҳ"); 
    }else{
      showPageNum++;
    } 
  } else if(page == 'E'){
    $("#page_"+showPageNum).css("display","none");  
    showPageNum = thePageNum-1;
    $("#page_"+showPageNum).css("display","");  
    $("#changePageDiv span:eq(1)").html("��ǰ��"+showPageNum+"ҳ");
  }
    
}

/*
function selectBand(){
  var band_id = "9999";//���ڵ�ID
  var packet = new AJAXPacket("/npage/portal/shoppingCar/ajax_sCatalogItem.jsp","���Ժ�...");
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
    rdShowMessageDialog("û�в�ѯ�������������");
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
      rdShowMessageDialog("sCatalogItemʧ��!����ϵ����Ա!");
    }
  }
}

//������ڵ㴥���¼�
function stGetTreeNode(chId){
  productOfferQryByCat(chId);//��ѯ��������Ʒ��Ϣ(��Ŀ¼)
}

//��ѯ����Ʒ��Ϣ(��Ŀ¼)
function productOfferQryByCat(nodeID)
{
    var channelSegment="";//�������ͱ�ʶ
    var packet = new AJAXPacket("/npage/portal/shoppingCar/ajax_productOfferQryByCat.jsp","���Ժ�...");
    packet.data.add("catalog_item_id" ,nodeID);
    packet.data.add("channelSegment" ,channelSegment);
    core.ajax.sendPacket(packet,doProductOfferQryByCat,true);
    packet =null;
}

//�ص�����
function doProductOfferQryByCat(packet)
{
  var catalog_item_id = packet.data.findValueByName("catalog_item_id"); 
  
  var retCode = packet.data.findValueByName("retCode"); 
  var retMsg = packet.data.findValueByName("retMsg"); 
  var backArrMsg = packet.data.findValueByName("backArrMsg");
  if(backArrMsg==null||backArrMsg==""){
    rdShowMessageDialog("û�в�ѯ�������������");
    $("#img_"+catalog_item_id).attr("src","<%=request.getContextPath()%>/nresources/default/images_sx/mztree//closed.gif");
    $("#ul_"+catalog_item_id).css("display","none");
  }else{
    if(retCode==0){
        $("#rootTree [id*='a_']").css({ "font-size": "", "color": "","font-weight": ""}); 
        $("#img_"+currentOfferId).attr("src","<%=request.getContextPath()%>/nresources/default/images_sx/mztree//closed.gif");  //��ͼ����Ϊ����״̬
        $("#ul_"+currentOfferId).css("display","none"); //�ӽڵ�Ϊ���ɼ�,��Ϊ�Ƿ��ѯҶ�ӵ��ж�����
        initTab(backArrMsg);
        $("#a_"+catalog_item_id).css({ "font-size": "medium", "color": "green","font-weight": "bold"}); 
        currentOfferId = catalog_item_id;
    }
    else{
      rdShowMessageDialog("����Ʒ��ѯʧ��!����ϵ����Ա!");
    }
  }
}

function initTree(){
  $("#rootTree [id*='a_']").css({ "font-size": "", "color": "","font-weight": ""}); 
  $("#img_"+currentOfferId).attr("src","<%=request.getContextPath()%>/nresources/default/images_sx/mztree//closed.gif");  //��ͼ����Ϊ����״̬
  $("#ul_"+currentOfferId).css("display","none"); //�ӽڵ�Ϊ���ɼ�,��Ϊ�Ƿ��ѯҶ�ӵ��ж����� 
  currentOfferId = "";
  $("#offerListDiv table").remove();
  $("#changePageDiv").css("display","none");
  $("#offerCommentsDiv").empty();
  $("#offerSelectedListTab").find("tr:gt(0)").remove(); //ɾ����ѡ�б���������ѡ������Ʒ
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
      //groupHash[offerId]=ret.toString();  //�����ص�Ⱥ����Ϣ��ӦofferId����
      //
      //var offerGroupInfo = "";    //��װ����Ʒ��Ⱥ����Ϣ,��ʽ:offerId,groupinfo1,groupinfo2,~
      //offerGroupInfo += offerId;
      //offerGroupInfo += "|";
      //var temp = ret.toString().split("/");
      //
      //$.each(temp[0].split("$"),function(i,n){
      //  if(typeof(n) != "undefined"){
      //    if(i<6){                      //ǰ6��ΪȺ�������Ϣ,�����Ϊ����������Ϣ
      //      offerGroupInfo += n.split("~")[1];  
      //      offerGroupInfo += "$";  
      //    }
      //    else{
      //      offerGroupInfo += n.substring(2); //ȥ��"s_",id~value
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
      rdShowMessageDialog("δ����Ⱥ�飡");  
      return false;
    }
  }
  else{
    var ret=window.showModalDialog("famChgMain.jsp?custName="+document.all.custName.value+"&phoneNo=<%=phoneNo%>&loginAccept=<%=loginAccept%>&servId=<%=servId%>&opCode=<%=opCode%>&offerId="+offerId+"&offerName="+offerName+"&groupInfo="+groupHash[offerId]+"&groupTypeId="+groupTypeId,"",prop);
    if(typeof(ret) != "undefined"){
      //groupHash[offerId]=ret; //�����ص�Ⱥ����Ϣ�Ծ�offerId����
      //
      //var offerGroupInfo = "";    //��װ����Ʒ��Ⱥ����Ϣ,��ʽ:offerId,groupinfo1,groupinfo2,~
      //offerGroupInfo += offerId;
      //offerGroupInfo += "|";
      //var temp = ret.toString().split("/");
      //$.each(temp[0].split("$"),function(i,n){
      //  if(typeof(n) != "undefined"){
      //    if(i<6){                      //ǰ6��ΪȺ�������Ϣ,�����Ϊ����������Ϣ
      //      offerGroupInfo += n.split("~")[1];  
      //      offerGroupInfo += "$";  
      //    }
      //    else{
      //      offerGroupInfo += n.substring(2); //ȥ��"s_"
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
    if(v_hiddenFlag=="Y"){ //��ΪYʱ�������°�С������չʾҳ��
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
          	/*ΪС���ʷ�ʱ����ֵȫ�ֱ���ΪС���ʷ�true*/
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
						rdShowMessageDialog("��ȡС���ʷѴ���!������ϵϵͳ����Ա",0);
						return false;
					}
				}
        AttributeHash[queryId]=ret; //�����ص�Ⱥ����Ϣ��ӦqueryId����
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
  <%if(opCode.equals("1270")||opCode.equals("1272")){%>
  $("#offerListDiv").append("<table id='offerListTab'><thead><tr style='cursor:hand'><th  onclick=\"sortTable('offerListTab',0,'zh')\">����ƷID</th><th  onclick=\"sortTable('offerListTab',1,'zh')\">����Ʒ����</th><th>����&nbsp;�ղ�&nbsp;����</th></tr></thead></table>");
  <%}else{%>
    $("#offerListDiv").append("<table id='offerListTab'><thead><tr style='cursor:hand'><th  onclick=\"sortTable('offerListTab',0,'zh')\">����ƷID</th><th  onclick=\"sortTable('offerListTab',1,'zh')\">����Ʒ����</th><th>����&nbsp;����</th></tr></thead></table>");
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
      //$("#offerListTab").append("<tr id='coltr_"+offer_id+"'><td>"+offer_id+"</td><td>"+offer_name+"</td><td><img src='/nresources/default/images/ab1.gif' style='cursor:hand' alt='����' id='col_"+offer_id+"' onClick='addOffer("+offer_id+")' />&nbsp;&nbsp;&nbsp;<span><img src='/nresources/default/images/icon_arrow_down.gif' style='cursor:hand' name='' alt='�����ҵ��ղ�' id='col_"+offer_id+"' onClick='addMyCollection(this)'></span><img src='/nresources/default/images/child.gif' style='cursor:hand' name='' alt='�鿴��ϸ��Ϣ' id='detail_"+offer_id+"' onClick='showdesc("+offer_id+",0)'></td></tr>");
      <%if(opCode.equals("1270")||opCode.equals("1272")){%>
        $("#offerListTab").append("<tr><td>"+offer_id+"</td><td  id='coltr_"+offer_id+"'>"+offer_name+"</td><td><img src='/nresources/default/images/ab1.gif' style='cursor:hand' alt='����' id='col_"+offer_id+"' onClick='addOffer("+offer_id+")' />&nbsp;&nbsp;&nbsp;<span><img src='/nresources/default/images/icon_arrow_down.gif' style='cursor:hand' name='' alt='�����ҵ��ղ�' id='col_"+offer_id+"' onClick='addMyCollection(this)'></span><img src='/nresources/default/images/child.gif' style='cursor:hand' name='' alt='�鿴��ϸ��Ϣ' id='detail_"+offer_id+"' onClick='showdesc("+offer_id+",0)'></td></tr>");
      <%}else{%>
        $("#offerListTab").append("<tr><td>"+offer_id+"</td><td  id='coltr_"+offer_id+"'>"+offer_name+"</td><td><img src='/nresources/default/images/ab1.gif' style='cursor:hand' alt='����' id='col_"+offer_id+"' onClick='addOffer("+offer_id+")' />&nbsp;&nbsp;&nbsp;</span><img src='/nresources/default/images/child.gif' style='cursor:hand' name='' alt='�鿴��ϸ��Ϣ' id='detail_"+offer_id+"' onClick='showdesc("+offer_id+",0)'></td></tr>");
      <%}%>
     // getMidPrompt("10442",offer_id,"coltr_"+offer_id);
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

//������Ʒ���뵽�ҵ��ղ� 
function addMyCollection(_this){
  var offerId = _this.id.substring(4);
  var packet = new AJAXPacket("/npage/portal/shoppingCar/addToCollection.jsp","���Ժ�...");
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

//��ѯ�ҵ��ղ�����Ʒ��Ϣ 
function qryMyCollection(){
  var packet = "";
  if(operateFlag == 1){
    packet = new AJAXPacket("qryMainOffer.jsp","���Ժ�...");
  }else{
    packet = new AJAXPacket("qryAddOffer.jsp","���Ժ�...");  
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
      $("#offerListDiv tr span").html("<img src='/nresources/default/images/icon_arrow_up.gif' style='cursor:hand' name='' alt='���ҵ��ղ���ɾ��' onClick='delMyCollection(this)'>");
    }else{
      $("#offerListDiv table").remove();
      rdShowMessageDialog("�ҵ��ղ�Ϊ�գ�");   
    }
  }else{
    rdShowMessageDialog(retMsg);  
  }
}

//������Ʒ���ҵ��ղ���ɾ�� 
function delMyCollection(_this){
  var offerId = $(_this).parents("tr").find("td:first").text();
  $(_this).parents("tr").remove();
  var packet = new AJAXPacket("/npage/portal/shoppingCar/delMyCollection.jsp","���Ժ�...");
  packet.data.add("offerId",offerId);
  core.ajax.sendPacket(packet,doDelMyCollection);
  packet =null;
}
function doDelMyCollection(packet){ 
  var retCode = packet.data.findValueByName("errorCode");
  var retMsg =  packet.data.findValueByName("errorMsg");
  if(retCode == "0"){
    rdShowMessageDialog("�����ҵ��ղ���ɾ����");    
  }else{
    rdShowMessageDialog(retMsg);  
  }
} 


//��ѯ�ȵ�����Ʒ��Ϣ 
function qryHotOffer(){
  var packet = "";
  if(operateFlag == 1){
    packet = new AJAXPacket("qryMainOffer.jsp","���Ժ�...");
  }else{
    packet = new AJAXPacket("qryAddOffer.jsp","���Ժ�...");  
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
      rdShowMessageDialog("δ��ѯ���ȵ�����Ʒ��");
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
   
    var packet = new AJAXPacket("qryProduct.jsp","���Ժ�...");
    packet.data.add("param" ,param);
    core.ajax.sendPacket(packet,cfm);
    packet =null;
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
		document.all.bFMsg.value="У��ɹ�";
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
				  
				  
		  var myPacket = new AJAXPacket("f1272_sWLWOffCheck.jsp","���ڽ����������ʷѻ�������У�飬���Ժ�......");
		  myPacket.data.add("iOfferIdStr",iOfferIdStr);//
		  myPacket.data.add("iOfferStateStr",iOfferStateStr);//
		  myPacket.data.add("iFlagStr",iFlagStr);//
		  myPacket.data.add("opCode","<%=opCode%>");//
		  myPacket.data.add("phoneNo","<%=phoneNo%>");//�ֻ���
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
    	rdShowMessageDialog("������룺"+resultCode+",������Ϣ��"+resultMsg);
    }
}





function cfm(packet){
	

	/*2014/07/17 16:51:53 gaopeng �����������ǰ*/
	var flag= packet.data.findValueByName("flag");
	/*zhangyan add*/
	if("<%=opCode%>" == "e301" )
	{
		
		/*ָ��Ajax����ҳ*/
		var busAJAXpacket = new AJAXPacket("../public/pubBUSAPIAjax.jsp"
			,"���Ժ�...");
		/*��ajaxҳ�洫�ݲ���*/
		busAJAXpacket.data.add("netCode"
			,"<%=broadPhone%>");
		busAJAXpacket.data.add("opCode","<%=opCode%>" );
		/*����ҳ��,��ָ���ص�����*/
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
		  rdShowMessageDialog("ΥԼ��ע����Ϊ��!");
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
      rdShowMessageDialog("δ���κι�ϵ����,��ѡ�񶩹����˶�����Ʒ��");
      return false;
  }else if(MainOfferFlag==1&&g("addedOfferTab").rows.length==2)
  {
    rdShowMessageDialog("<%=opName%>���붩���µĻ�������Ʒ��");
    return false;
  }
  if(document.all.attrFlagHv.value!="0")
  {
    var offid=document.all.attrFlagHv.value;
    
    var packet = new AJAXPacket("qryAttrFlagHvMsg.jsp","���Ժ�..."); 
    packet.data.add("offerId",offid);
    core.ajax.sendPacket(packet,doQryAttrFlagHvMsg);
    packet =null; 
    
    var offMsg=document.all.attrFlagHvMsg.value;
    rdShowMessageDialog("�����ö�������Ʒ["+offid+"]��"+offMsg+"����");
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
    //ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
    /* ningtn ������������ */
  }
  else
  {
    if(newSmCode != oldSmCode)
    {
      if(oldSmCode == "21"){
        if((userCardCode == "01" || userCardCode == "02" || userCardCode == "03")){
          //rdShowMessageDialog("�ò����漰��Ʒ�Ʊ�����������л��֣���Mֵ������Ʒ�Ʊ����ЧʱʧЧ��������ʱ�һ�; ");
          rdShowMessageDialog("��ĿǰΪȫ��ͨVIP��Ա������Ʒ�ƣ�����VIP��Ա�ʸ���ҵ����Ч���Զ�ȡ����");
        }
        /* else{
          rdShowMessageDialog("��ȫ��ͨ�ͻ������ܲ���VIP������");
        } */
      }else{
        //rdShowMessageDialog("�ò����漰��Ʒ�Ʊ�����������л��ֻ�Mֵ����Ʒ�Ʊ����ЧʱʧЧ�����������ʷ���Чǰ��ʱ�һ���");
      }
                if(oldSmCode != "24" && newSmCode=="24" && oldSmCode !="") {//
            checksmz();
            var smzvalues =document.all.smzvalue.value.trim();
            if(smzvalues=="3") {//��ʵ����ȫ��ͨ�����еش��ͻ�ת��Ϊ�����пͻ�
              rdShowMessageDialog("<%=readValue("1270","ps","jf",Readpaths)%>");
            }
          }
    }
  }
  
  }

  document.all.tonote.value="<%=workNo%>Ϊ�ͻ�<%=gCustId%>��<%=opName%>";
  
		//�޸�1272��������������û���sm_code=PB)����ȷ�ϰ�ť�ύǰ����һ������sWLWOffCheck
		// hejwa add 2015-8-6 13:44:00
		// ��̨��Ա liyan
		
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
		  var myPacket = new AJAXPacket("fe092_sWLWOffCheck.jsp","���ڽ����������ʷѻ�������У�飬���Ժ�......");
		  myPacket.data.add("iOfferIdStr",iOfferIdStr);//
		  myPacket.data.add("iOfferStateStr",iOfferStateStr);//
		  myPacket.data.add("iFlagStr",iFlagStr);//
		  myPacket.data.add("opCode","<%=opCode%>");//
		  myPacket.data.add("phoneNo","<%=phoneNo%>");//�ֻ���
		  myPacket.data.add("newofferidss",document.all.offerIdHv.value.trim());//�ֻ���
      core.ajax.sendPacket(myPacket,do_sWLWOffCheck);
      myPacket=null;   
        
	   }
		
		if(!is_sWLWOffCheck){
			return;
		}  
	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	if(rdShowConfirmDialog("��ȷ���Ƿ����<%=opName%>��")==1)
	{
		if ( "1270" =="<%=opCode%>" )
		{
	
			var offerId10 = document.all.offerIdHv.value;
			var offerId40 = document.all.offerId40Hv.value;
			var offerIds = (offerId10+"|"+offerId40).replace(/\|/g,",");
			if ( offerIds.len() >= 5 )
			{
				var myPacket = new AJAXPacket("/npage/s1270/chkWlan.jsp"
					,"���ڲ�ѯ�ͻ��Ƿ��Ѱ���wlan�����Ժ�......");
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
					,"���ڲ�ѯ�ͻ��Ƿ��Ѱ���wlan�����Ժ�......");
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
			/*2013/09/10 17:28:41 gaopeng ���Ӳ�ѯ�������Ż��и߶˿ͻ�120ԪWLAN�������ʷ�ҵ��������ĺ� 
			Ӫҵǰ̨����3250-��ѡ�ʷѰ���ҵ��ʱ������������ʷ�����ΪYnW3ʱҪΪ�û���ͨWLAN���ܣ�
			���ʹ�����������ͨWLAN���ܵĲ��������û�ͳһ�ɷ�֮ǰ
			*/
		  var offerIdNeed = (document.all.offerId40Hv.value).replace(/\|/g,"");
		
		  var myPacket = new AJAXPacket("/npage/s1270/checkAttrTypeAndWlan.jsp","���ڲ�ѯ�ͻ��Ƿ��Ѱ���wlan�����Ժ�......");
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
  /*������ص���000000,����ÿ�ͨwlan���� s9113Cfm*/
  if(retCodeMy == "000000"){
      var myPacket = new AJAXPacket("/npage/s1270/s9113Cfm_Wlan.jsp","����Ϊ�û���ͨWLAN���ܣ����Ժ�......");
      myPacket.data.add("inChnSource","<%=loginAccept%>");//��ˮ
      myPacket.data.add("inLoginNo","<%=workNo%>");//����
      myPacket.data.add("inLoginPwd","<%=noPassWord%>");//��������
      myPacket.data.add("inPhoneNo","<%=phoneNo%>");//�ֻ���
      myPacket.data.add("inUserPwd","");//�û�����
      myPacket.data.add("vOrgCode","<%=orgCode%>");//orgCode
      myPacket.data.add("opCode","<%=opCode%>");//orgCode
      core.ajax.sendPacket(myPacket,s9113CfmRet);
      myPacket=null;
    
  }
  else{
    formConf();
  }
  
}
/*��ͨwlan�ص�����*/
function s9113CfmRet(packet){
  
    var resultCode = packet.data.findValueByName("resultCode");
    var resultMsg =  packet.data.findValueByName("resultMsg");
    
    if(resultCode=="000000"){
      
      formConf();
    }
    else{
      rdShowMessageDialog("������룺"+resultCode+",������Ϣ��"+resultMsg);
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
			
					 if($(this).find("td:eq(1)").html()==undefined || $(this).find("td:eq(1)").html()=="����" || $(this).find("td:eq(1)").html()==null ) {
					 return true;
					 }
					 note1272add1+=$(this).find("td:eq(1)").html()+",";

			});

				$("#addedProdTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(1)").html()==undefined || $(this).find("td:eq(1)").html()=="����" || $(this).find("td:eq(1)").html()==null) {
					 return true;
					 }
					 note1272add2+=$(this).find("td:eq(1)").html()+",";

			});
			
					if(note1272add1!="") {
						note1272result+="[��"+note1272add1+"]"
					}
					if(note1272add2!="") {
						note1272result+="[��"+note1272add2+"]"
					}
					
					
						$("#offerUnbookTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(0)").html()==undefined || $(this).find("td:eq(0)").html()=="����" || $(this).find("td:eq(0)").html()==null || $(this).find("td:eq(0)").html()=="<B>&lt;����Ʒ&gt;</B>") {
					 return true;
					 }
					 note1272del1+=$(this).find("td:eq(0)").html()+",";

			});
			
									$("#prodUnbookTab tr").each(function(i){ 			
			
					 if($(this).find("td:eq(0)").html()==undefined || $(this).find("td:eq(0)").html()=="����" || $(this).find("td:eq(0)").html()==null || $(this).find("td:eq(0)").html()=="<B>&lt;��Ʒ&gt;</B>") {
					 return true;
					 }
					 note1272del2+=$(this).find("td:eq(0)").html()+",";

			});
			
					if(note1272del1!="") {
						note1272result+="[��"+note1272del1+"]"
					}

					if(note1272del2!="") {
						note1272result+="[��"+note1272del2+"]"
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

//��ѡ�ʷѱ�� ����Ʒ��������
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
  var packet = new AJAXPacket("qryMainOfferRoleInfo.jsp","���Ժ�...");
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
      //tempStr += "<option value=''>--��ѡ��--</option>";
      for(var i = 0;i<retAry.length;i++){
        tempStr += "<option value='"+retAry[i][0]+"' >"+ retAry[i][1] + "</option>";
      }
      tempStr += "<select>";
      $("#roleInfoP").append(tempStr);
      $("#roleId").bind("change",qryAddOfferByRole);
    }else{
        var tempStr = "<select id='roleId'>";
        tempStr += "<option value=''>--��ѡ��--</option>";
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
  
  var packet = new AJAXPacket("qryRealOfferId.jsp","���Ժ�...");
  packet.data.add("loginAccept","<%=loginAccept%>");
  packet.data.add("opCode","<%=opCode%>");
  core.ajax.sendPacket(packet,doQryRealOfferId);
  packet =null; 
  
  var relMainOfferId="";
  if(document.all.RealOfferId.value=="0"){
     relMainOfferId= thisMonthOfferId;    //Ĭ��Ϊ���»�������Ʒ
  }else{
     relMainOfferId= document.all.RealOfferId.value;
   }
  
  var packet = new AJAXPacket("qryAddOffer.jsp","���Ժ�...");
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
  /*ningtn huangrong ע�ͣ�����ʵʩȫҵ����ӹ����������󣬸Ĺ��ܲ���Ҫ¼�����֤��Ϣ*/
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
//��ѯ��ӡ����Ҫ������
function queryPrintInfo(){
  var iold_m_code = "<%=offerId%>";       //�����ײʹ���
  var inew_m_code = document.all.offerIdHv.value; //�������ײʹ���
  document.all.newofferId.value=inew_m_code;
  var phone_no = "<%=phoneNo%>";          //�绰����
  var iop_code = "<%=opCode%>";
  var i2 = "<%=gCustId%>";              //cust_id
  var kexuancode = (document.all.offerId40Hv.value).replace(/\|/g,"");
  var cancalcode = (document.all.offerId40CanHv.value).replace(/\|/g,"");
  var packet1 = new AJAXPacket("getPrintInfo_Ajax.jsp","���Ժ�...");
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
//��ӡ��ʹ�ñ���

var goodbz    = "";
var modedxpay = "";
var bdbz      = "";
var bdts      = "";
var note      = "";
var note1     = "";
var expDateOffset = ""; 
var offerAttrType = ""; //offer_attr_type
var matureCode    = ""; //���ں��ʷ�
var mature_Name   = ""; //���ں��ʷ�����
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
       document.all.xq_name.value = packet.data.findValueByName("xq_name"); 
       document.all.dOfferDesc.value = packet.data.findValueByName("dOfferDesc"); 
  }
}
  <%
  long s2a =System.currentTimeMillis();
  %>
  
/* ������ͨ78λTD���������û����Ʒ��Ͷ��Ź��ܵ����� */
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
  System.out.println("mylog  ִ�з��� sDynSqlCfm  ��ʱ�� = ��"+(s3a-s2a)+"��");
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
      <%if("1".equals(vFeeFlag)){%>
	      <tr>
	        <td class=blue>�Ƿ���ȡΥԼ�� </td>
	        <td>
	        	<select id="isWeiyuejin" name="isWeiyuejin">
	        		<option value="0">��</option>
	        		<option value="1">��</option>
	        	</select>
	        </td> 
	        <td class=blue>��ע</td>
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
  
  <div id="userInfoDiv">
    <div class="title"><div id="title_zi">�û�������Ϣ </div></div>
    <%@include file="PMUserBaseInfo.jsp"%>
    <div class="input">
	    <table cellspacing="0" id="integralFiledAll" style="display:none">
	    	<%@include file="/npage/public/integralInfo.jsp"%>
	  	</table>
  	</div>
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
          <div style="overflow-y:hidden;overflow-x:hidden; background-color: #F7F7F7;border-right: 1px solid #95CBDD;border-left: 1px solid #95CBDD;border-bottom: 1px solid #95CBDD;height:388px;FONT-WEIGHT: normal; FONT-SIZE: 13px;" class="list">
      
          <div id="formTab">  
            <ul>
            <li class="current" id="tb_1" onclick="HoverLi(1,2)"><a href="#">��������Ʒ</a></li>  
            <li id="tb_2"><a href="#" onclick="HoverLi(2,2)">��������Ʒ</a> </li>
          </ul>
         </div> 

            <div id="searchOfferConDiv" style="display:none;border-right: 0px solid #95CBDD;border-left: 0px solid #95CBDD;border-bottom: 1px solid #95CBDD;height:388px;PADDING-LEFT: 20px; COLOR: #0256b8;FONT-WEIGHT: normal; FONT-SIZE: 12px;">
              <p> &nbsp;&nbsp;ҵ��Ʒ��:
                <select class="b_text" name="bindId" id="bindId"  onchange="setOfferType()">
                  <option value="" selected>----��ѡ��----</option>
                </select>
              </p>
              <p>����Ʒ����:
                <select class="b_text" name="offerType" id="offerType">
                  <option value="" selected>----��ѡ��----</option>
                </select>
              </p>
              <p>&nbsp;&nbsp;����ƷID��<input type="text"  name="offerId" id="offerId" class="for0_9" ></p>
              <p>&nbsp;&nbsp;&nbsp;&nbsp;�ؼ��֣�<input type="text"  name="offerName" id="offerName" ></p>
              <p id="roleInfoP">����Ʒ���ࣺ</p>
              <p align="center">  
                <input type="button" class="b_text" value="����" id="qryOfferBtn">
                <%if(opCode.equals("1270")||opCode.equals("1272")){%>
                <input type="button" class="b_text" value="�ҵ��ղ�" onclick="qryMyCollection()" />
                <input type="button" class="b_text" value="�ȵ�" onclick="qryHotOffer()" />
                <%}%>
                <input type="button" class="b_text" value="���" onclick="clearInfo()" />&nbsp;&nbsp;&nbsp;
              </p>
            </div>
          </div>
      </div>
      
   <div class="item-col col-2" id="right" >
        <span class="item-col2 col-1" id="leftSpan" style="overflow-y:auto;overflow-x:hidden;background-color:#F7F7F7;height:413px;border-right: 1px solid #95CBDD;border-left: 1px solid #95CBDD;border-bottom: 1px solid #95CBDD;">
          <!--div class="title"><div class="text">��ѯ�б�</div></div-->        
        <div class="title" >
          <div id="title_zi">��ѡ����Ʒչʾ��</div><span style="float:right;padding: 3px 1px 0px 2px;"><img src='/nresources/default/images/arrow_left.gif' style='cursor:hand' name='right' alt='����۵�����Ʒ������' id='LRImg' onClick="toLeft()"></span>
        </div>
          <table  style="FONT-SIZE: 12px;">
              <tr>
                 <td class="blue">
                &nbsp;&nbsp;ƴ����ƴ������ <input type="text" id="searchOfferText" name="searchOfferText" onkeyup="searchOffer()" />
                </td>
              </tr>
          </table>
          
         <div>
            <div  id="offerListDiv">
            </div>
          </div>
        </span>
        
        <span class="item-col3 col-2" id="rightSpan">
          <!--div class="title" id="addedOfferTitDiv"><div class="text">��������������</div></div-->      
      <div class="title" id="addedOfferTitDiv">
        <div id="title_zi" style="cursor:hand">��������������</div>
      </div>
      
<%
if(opCode.equals("1258")){
%>      
      <div id="isCPE" >
      	<b style="font-size: 15px;">�Ƿ���ȡΥԼ��:
	      <select id="weiyuejin" name="weiyuejin" onchange="checkWYJ()">
	      	<option value="0">��</option>
	      	<option value="1">��</option>
	      </select></b>
      </div>
      
<%}%>      
      
        
          <div id="addedOfferDiv" class="list" style="overflow-x:auto;overflow-y:auto;height:200px;width:99%;border-width:1px;border-color:#add3d0;border-style:solid;background-color: #F7F7F7;" >
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
              <table id="addedProdTab">
              <tr>
                <td colspan='6' class="blue"><b><��Ʒ></b></td>
              </tr>
              <tr id="addedProdHeadTr">
                <td class="blue">״̬</td>
                <td class="blue">����</td>
                <td class="blue">����</td>
                <td class="blue">��Чʱ��</td>
                <td class="blue">ʧЧʱ��</td>
                <td class="blue">����</td>
              </tr>
            </table>  
            <table id="slTab">
              <tr>
                <td colspan='6' class="blue"><input type="checkbox" name="slChk" id="slChk" >�Ƿ��������</td>
              </tr>
            </table>  
          </div>
          
      <!--div class="title" id="offerUnbookTitDiv"><div class="text">��������--�˶�</div></div-->
      <div class="title" id="offerUnbookTitDiv">
        <div id="title_zi" style="cursor:hand;">���������˶���</div>
      </div>
          <div class="list" id="offerUnbookDiv" style="overflow-y:auto;overflow-x:auto;height:160px;width:99%;border-width:1px;border-color:#add3d0;border-style:solid;background-color: #F7F7F7;">
            <table id="offerUnbookTab">
                <tr>
                <td colspan='5' class="blue"><b><����Ʒ></b></td>
              </tr>
              <tr>
                <td class="blue">����</td>
                <td class="blue">����</td>
                <td class="blue">��Чʱ��</td>
                <td class="blue">ʧЧʱ��</td>
                <td class="blue">����</td>
              </tr>
            </table>  
             <table id="prodUnbookTab">
              <tr>
                <td colspan='5' class="blue"><b><��Ʒ></b></td>
              </tr>
              <tr>
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
  <input class="b_foot" name=confirm id="confirm" type=button onClick="qryProdAttr()" value="ȷ��" >
  &nbsp; 
  <INPUT class=b_foot onclick="ignoreThis()" type=button value=����> &nbsp;
  <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value="�ر�">
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
<!-- 20131216 2013/12/17 9:51:34 gaopeng ����2013��9�µ�һ��ҵ��֧��ϵͳ�г�רҵ���󣨹������ʷ���������ҵ�����Ż������� ������ ������������ 139����0Ԫ 139����5Ԫ �乾��Ա0Ԫ �乾��Ա5Ԫ -->
<input type="hidden" name="mailzero" id="mailzero"/>
<input type="hidden" name="mailfive" id="mailfive"/>
<input type="hidden" name="miguzero" id="miguzero"/>
<input type="hidden" name="migufive" id="migufive"/>
<!-- 2014/04/04 11:15:23 gaopeng Ʒ��sm_code -->
	<input type="hidden" name="pubSmCode" id="pubSmCode" value="" />
	<!--BUSУ�鷵�ش���-->
<input type="hidden" name="bFCode" value="1">
<input type="hidden" name="bFMsg" value="1">
</DIV>
<%@ include file="/npage/include/footer_new.jsp"%>
</FORM>
</DIV>
</BODY>
<%
	/* ����Ŀ�����ھɰ�ͷ�ϵͳ���������Ҫ���ͷ����Ӫҵ������CRM�ϲ���һ�װ汾�Ľ�������ͺ������󿪷����۹���@2014/7/16 */
	if(!"2".equals(OPflag)){ /*�����������Ϊ�ͷ����ţ��򲻼��ؿؼ�*/
%>
	<%@ include file="/npage/public/hwObject.jsp" %> 
<%}%>
</HTML>
<script>


  
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
  
  <%if(opCode.equals("3257")&&(countqry>0)){%>
  if($("#glbQryMem").get(0).checked == true){     
      var ret=window.showModalDialog("showGlbQryMem.jsp?id_no=<%=stPMid_no%>&phoneNo=<%=phoneNo%>&custName=<%=custName%>&opCode=<%=opCode%>&opName=<%=opName%>","",prop);
      $("#glbQryMem").attr("checked",false);
  }else{
    
  }
  
<%}%>
}
//���Ŀ�����
function printInfo1253()
{
    //�õ���ҵ�񹤵���Ҫ�Ĳ���

    var cust_info="";  //�ͻ���Ϣ
    var opr_info="";   //������Ϣ
    var note_info1=""; //��ע1
    var note_info2=""; //��ע2
    var note_info3=""; //��ע3
    var note_info4=""; //��ע4
    var retInfo = "";  //��ӡ����
    /********������Ϣ��**********/
    //document.all.belongCity.value = document.all.stPMcust_addressHi.value;
    cust_info+="�ͻ������� "+document.all.custName.value+"|";
    cust_info+="�ֻ����룺 "+"<%=phoneNo%>"+"|";
    cust_info+="֤�����룺 "+document.all.agent_idNo.value+"|";
    cust_info+="�ͻ���ַ�� "+document.all.stPMcust_addressHi.value+"|";
      /********������**********/
      opr_info+="�û�Ʒ�ƣ�"+document.all.stPMsm_nameHi.value+"|";
      opr_info+="ҵ�����ͣ����Ŀ�����"+"|";
      if(goodbz=="Y"){
        opr_info+="ҵ����ˮ��"+"<%=loginAccept%>"+"       �������ѽ�"+modedxpay+"Ԫ"+"|";
      }else{
      opr_info+="ҵ����ˮ��"+"<%=loginAccept%>"+"|";
      }
      opr_info+="�ʷѣ����롢���ƣ���"+document.all.offerIdHv.value+" "+document.all.offerNameHv.value+";"+document.all.offerId40Hv.value+" "+document.all.offerName40Hv.value+"|";
      opr_info+="��Чʱ�䣺"+document.all.offerTimeHv.value.substring(0,8)+"|";
      ajaxGetEPf(document.all.offerIdHv.value.trim(),xqdm);
      opr_info+="��|";
      opr_info+="���������ʷ�������"+codeChg(document.all.newZOfferDesc.value)+"|";
     if (document.all.offerId40Hv.value.trim().replace(/\|/g,"").len()== 0) {
			} else {
			opr_info+="��|";
      ajaxGetEPf1(document.all.offerId40Hv.value);
    	opr_info+="�������ѡ�ʷ�������"+retResultStr1+"|";
    	}
      /*******��ע��**********/
    if(bdbz=="Y"){
        opr_info+=bdts+"|";
      }else{
      opr_info+=" "+"|";
    }
    /**********������*********/
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
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")��������ȡ��"+",";
      }else{
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")��������1��ʧЧ"+",";    
      }
    }
    } 
  }
  if(tempNote_info3.len()>0)
  {     
      tempNote_info3+="|"   ;        
      note_info1 += "���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:" + tempNote_info3 + "|";
  }else{
      note_info1+=" "+"|";
      }
      if(goodbz=="Y"){
      note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
    }
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//��������
function printInfo1255()
{
    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    /********������Ϣ��**********/
    
    cust_info+="�ͻ������� "+document.all.custName.value+"|";
    cust_info+="�ֻ����룺 "+"<%=phoneNo%>"+"|";
    cust_info+="֤�����룺 "+document.all.agent_idNo.value+"|";
    cust_info+="�ͻ���ַ�� "+document.all.stPMcust_addressHi.value+"|";

    /********������**********/
    opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "  " + "�û�Ʒ�ƣ�" + document.all.stPMsm_nameHi.value + "|";
    if(goodbz=="Y"){
        opr_info += "����ҵ��:" + "��������" + "  " + "������ˮ: " + "<%=loginAccept%>" + "  �������ѽ�" + modedxpay + "Ԫ" + "|";
    }else{
        opr_info += "����ҵ��:" + "��������" + "  " + "������ˮ: " + "<%=loginAccept%>" + "|";
    }
    opr_info += "�����ʷѣ�" +document.all.offerIdHv.value+" "+document.all.offerNameHv.value + "  " + "��Чʱ�䣺" + document.all.offerTimeHv.value.substring(0,8) + "|";
    ajaxQueryPPf(document.all.offerIdHv.value);
    var sm_code = retResultStr2;
    var bandId = band_id
    opr_info += "�����ʷѶ�ӦƷ�ƣ�" + sm_code + "|";
    
    
    ajaxGetEPf(document.all.offerIdHv.value.trim(),xqdm);
    opr_info += "���ں�ִ���ʷѣ�" + document.all.dOfferId.value+" "+document.all.dOfferName.value + "|";
    if(document.all.dECode.value!="") {
      opr_info+="���ں�������룺"+document.all.dECode.value+"-"+document.all.xq_name.value+"|";
      }
    if(zdxq=="1")
    {
        opr_info+="�û���������Զ���ǩҵ��|"
    }
      note_info2+="���ں�ִ���ʷ�������"+document.all.dOfferDesc.value+"|";
      
    /*******��ע��**********/
    if (bdbz == "Y") {
        note_info1 += bdts + "|";
    } else {

    }
    /**********������*********/
  note_info1+=""+"|";
    note_info1 += "����İ����ʷ�������" + "|";
    note_info1 += note.trim() + "|";
  if(bandId=="24" && bandId=="21")
  {
    note_info2+=" "+"|";
  }
  else
  {
    note_info2+=" "+"|";
    if((document.all.stPMsm_nameHi.value != "") && (sm_code != document.all.stPMsm_nameHi.value)){
      note_info2+="�����ʷ���Ч������Ʒ�ƽ���"+""+"���Ϊ"+sm_code+"���������л��ֻ�Mֵ����Ʒ�Ʊ��ʱʧЧ��������ʱ�һ����֡�"+"|";
    }
    note_info2+=" "+"|";
  }

    
    if (document.all.offerId40Hv.value.trim().replace(/\|/g,"").len()== 0) {

    } else {
      ajaxGetEPf1(document.all.offerId40Hv.value);
        note_info3 += " " + "|";
        note_info3 += "��ѡ�ʷ�������" + "|";
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
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")��������ȡ��"+",";
      }else{
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")��������1��ʧЧ"+",";      
      }
    }
    } 
  }
  
  
  
  if(tempNote_info3.length >0)
  {     
    tempNote_info3+="|"   ;        
      note_info4 += "���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:" + tempNote_info3 + "|";
  }
  if(goodbz=="Y"){
      note_info4 += " " + "|";
      note_info4 += "��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��" + "|";
      if(print12701255){
    	  note_info4 += "Ϊ��������Ȩ�棬��ԭ"+retResult212701255+"���ʷѰ����Ĳ���ҵ��Ϊ����ѱ���һ�꣬�����ڼ�ҵ��ÿ�·���Ϊ"+retResult112701255+"Ԫ��ϵͳÿ��������"+retResult112701255+"Ԫר��൱�����ʹ�á��ñ����Ĳ���ҵ���������ʷ���Ч�����ڿ�ʼ���㣬���ں����ޱ仯���Żݽ��Զ�˳��һ�꣬���б仯ϵͳ����ǰ1���¶���֪ͨ��|";
      }
  }
  else{
	  if(print12701255){
		  note_info4 += "��ע��Ϊ��������Ȩ�棬��ԭ"+retResult212701255+"���ʷѰ����Ĳ���ҵ��Ϊ����ѱ���һ�꣬�����ڼ�ҵ��ÿ�·���Ϊ"+retResult112701255+"Ԫ��ϵͳÿ��������"+retResult112701255+"Ԫר��൱�����ʹ�á��ñ����Ĳ���ҵ���������ʷ���Ч�����ڿ�ʼ���㣬���ں����ޱ仯���Żݽ��Զ�˳��һ�꣬���б仯ϵͳ����ǰ1���¶���֪ͨ��|";
      }
	  
  }
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//����ȡ��
function printInfo1258()
{
    //�õ���ҵ�񹤵���Ҫ�Ĳ���
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
    /********������Ϣ��**********/
  cust_info+="�ͻ������� "+document.all.custName.value+"|";
  cust_info+="�ֻ����룺 "+"<%=phoneNo%>"+"|";
  cust_info+="֤�����룺 "+document.all.agent_idNo.value+"|";
  cust_info+="�ͻ���ַ�� "+document.all.stPMcust_addressHi.value+"|";

    /********������**********/

    opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "  " + "�û�Ʒ�ƣ�" + document.all.stPMsm_nameHi.value + "|";
  if(goodbz=="Y"){
      opr_info += "����ҵ��:" + "����ȡ��" + "  " + "������ˮ: " + "<%=loginAccept%>" + "  �������ѽ�" + modedxpay + "Ԫ" + "|";
  }else{
      opr_info += "����ҵ��:" + "����ȡ��" + "  " + "������ˮ: " + "<%=loginAccept%>" + "|";
  }

var countBaseOffer = $("#userHadOfferTab tr").length;
  for(var iw=1;iw<countBaseOffer;iw++){
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="����"){
      opr_info+="ȡ���İ����ʷѣ�"+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text()+" "+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(1)").text()+"|";
    }
  }
    
    opr_info += "ȡ����ִ���ʷѣ�" + document.all.offerIdHv.value+" "+document.all.offerNameHv.value + "  *" + "��Чʱ�䣺" + document.all.offerTimeHv.value.substring(0,8) + "|";
    
    
    ajaxQueryPPf(document.all.offerIdHv.value);
    var sm_code = retResultStr2;
    var bandId = band_id
    opr_info += "ȡ����ִ���ʷѶ�ӦƷ�ƣ�" + sm_code + "|";
    
    note_info1 += "ȡ����ִ���ʷ�������" + document.all.newZOfferDesc.value+"|";
    note_info1 += note + "|";
    /*******��ע��**********/
    if (bdbz == "Y") {
        note_info1 += bdts + "|";
    }
    /**********������*********/
    if (document.all.offerId40Hv.value.trim().replace(/\|/g,"").len()== 0) {

    } else {
      ajaxGetEPf1(document.all.offerId40Hv.value);
        note_info2 += " " + "|";
        note_info2 += "��ѡ�ʷ�������" + retResultStr1 + "|";
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
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")��������ȡ��"+",";
      }else{
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")��������1��ʧЧ"+",";    
      }
    }
    } 
  }    

  
    if (tempNote_info3.length >0) {
        note_info4 += " " + "|";
        note_info4 += "���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:" + codeChg(tempNote_info3) + "|";
    } else {

    }
  if(goodbz=="Y"){
      note_info4 += " " + "|";
      note_info4 += "��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��" + "|";
  }
  
  if(WYJflag=="0"){
	  note_info4 += "���İ����ʷ�δ���ڣ�ȡ�������ʷ���ΥԼ��Ϊ���ڱ��»��ѳ��ʺ��ҹ�˾����ʣ�����Ԥ����30����ȡΥԼ�𣨾�ȷ���֣��������룩��ʣ���Ԥ���Զ�ת�������ֽ��˻��С�" + "|";
  }
    note_info4 += " " + "|";
    note_info4 += "��ע��" + document.all.tonote.value + "|";
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//���������ϰ��Ŀ�����
function printInfo7977()
{
    //�õ���ҵ�񹤵���Ҫ�Ĳ���

    var cust_info="";  //�ͻ���Ϣ
    var opr_info="";   //������Ϣ
    var note_info1=""; //��ע1
    var note_info2=""; //��ע2
    var note_info3=""; //��ע3
    var note_info4=""; //��ע4
    var retInfo = "";  //��ӡ����
    /********������Ϣ��**********/
    cust_info+="�ͻ������� "+document.all.custName.value+"|";
    cust_info+="�ֻ����룺 "+"<%=phoneNo%>"+"|";
      /********������**********/
      retInfo+=" "+"|";
      opr_info+="�û�Ʒ�ƣ�"+document.all.stPMsm_nameHi.value+"|";
      opr_info+="ҵ�����ͣ����������ϰ��Ŀ�����"+"|";
      if(goodbz=="Y"){
        opr_info+="ҵ����ˮ��"+"<%=loginAccept%>"+"|";
      }else{
        opr_info+="ҵ����ˮ��"+"<%=loginAccept%>"+"|";
      }
      opr_info+="��������ʷѣ����롢���ƣ���"+document.all.offerIdHv.value+" "+document.all.offerNameHv.value+"|";
      opr_info+="��Чʱ�䣺"+"����"+"|";
      /*******��ע��**********/
      if(bdbz=="Y"){
        opr_info+=bdts+"|";
      }else{
      opr_info+=" "+"|";
      }
    /**********������*********/
    note_info1+="��������ʷ�����:"+"|";
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
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")��������ȡ��"+",";
      }else{
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")��������1��ʧЧ"+",";          
      }
    }
    } 
  }    
    if (tempNote_info3.len()>0) {
        note_info2 += " " + "|";
        note_info2 += "���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:" + codeChg(tempNote_info3) + "|";
    }else {

    }      
      note_info3+=" "+"|";
      note_info4+="��ע��"+"|";
      
      if(goodbz=="Y"){
      note_info4+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
    }
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//���������ϰ��Ŀ�ȡ��
function printInfo7978()
{
    var cust_info="";  //�ͻ���Ϣ
    var opr_info="";   //������Ϣ
    var note_info1=""; //��ע1
    var note_info2=""; //��ע2
    var note_info3=""; //��ע3
    var note_info4=""; //��ע4
    var retInfo = "";  //��ӡ����
    /********������Ϣ��**********/
    cust_info+="�ͻ������� "+document.all.custName.value+"|";
    cust_info+="�ֻ����룺 "+"<%=phoneNo%>"+"|";
       /********������**********/
      opr_info+="�û�Ʒ�ƣ�"+document.all.stPMsm_nameHi.value+"|";
      opr_info+="ҵ�����ͣ����������ϰ��Ŀ�ȡ��"+"|";
       if(goodbz=="Y"){
        opr_info+="ҵ����ˮ��"+"<%=loginAccept%>"+"|";
      }else{
       opr_info+="ҵ����ˮ��"+"<%=loginAccept%>"+"|";
      }
    opr_info+="ȡ����ִ�е��ʷѣ����롢���ƣ���"+document.all.offerIdHv.value+" "+document.all.offerNameHv.value+"|";
      opr_info+="��Чʱ�䣺"+"����"+"|";
      
       /*******��ע��**********/
    if(bdbz=="Y"){
        opr_info+=bdts+"|";
      }else{
      opr_info+=" "+"|";
    }
    /**********������*********/
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
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")��������ȡ��"+",";
      }else{
        tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")��������1��ʧЧ"+",";  
      }
    }
    } 
  }    
    if (tempNote_info3.len()>0) {
        note_info1 += " " + "|";
        note_info1 += "���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:" + codeChg(tempNote_info3) + "|";
    }else {

    }          
      
      note_info1+="��ע��"+"|";
      note_info1+="���������ϰ��Ŀ��ʷ�ȡ��ʱ����ת��30��ͨ�󣩣���������Ż�ͬʱȡ����������Ч��"+"|";
      
      if(goodbz=="Y"){
      note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
    }
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
/*********�����ӡ�������õĴ�ӡ����*********/
function printInfo1272()
{
    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    
  cust_info+="�ͻ������� "+document.all.custName.value+"|";
  cust_info+="�ֻ����룺 "+"<%=phoneNo%>"+"|";

  opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "   " + "�û�Ʒ�ƣ�" + document.all.stPMsm_nameHi.value + "|";

  var tempNote_info2 = "���������ѡ�ײͣ�";//�����ʷ� ��
  var tempNote_info3 = "����ȡ����ѡ�ײͣ�";//ȡ���ʷ� ��
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
        var myPacket = new AJAXPacket("qp01MainQryXsp.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
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
    var myPacket = new AJAXPacket("queryEXTStatus.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
	  myPacket.data.add("offer_ids",tempArray1[h].value.trim()); 
	  core.ajax.sendPacket(myPacket,function(packet){
	  	var retCode=packet.data.findValueByName("errCode");
		  var retMsg=packet.data.findValueByName("errMsg");
		  var isextflags=packet.data.findValueByName("isextflags"); //�Ƿ���������Ч���ʷ�5����������
		  var isextstrs=packet.data.findValueByName("isextstrs"); //��������Ч���ʷѵĻ���Ч��ʽչʾ
		  if(retCode == "000000"){
		  	isextflagsss=isextflags;
		  	isextstrssss=isextstrs;
		 	}else{
		 		rdShowMessageDialog("��ѯ�����ʷѵ���Ч��ʽ����",0);
		 	}
	  });
     //alert(isextflagsss);
     //2017-01-10 liangyl ������������°泬�Ϳ���������й����Ͷ���չʾ�����ⷴ��
     
      if(isextflagsss=="5") {
      	tempNote_info2+="("+tempArray1[h].value+"��"+tempArray2[h].value+"��"+isextstrssss+")|";
      //2017-01-10 liangyl ������������°泬�Ϳ���������й����Ͷ���չʾ�����ⷴ��
      	if(retArray.length>0){
      		for(var i=0;i<retArray.length;i++){
      			tempNote_info2+="("+retArray[i][0]+"��"+retArray[i][1]+"��"+isextstrssss+")|";
      			notessss+=retArray[i][2]+"|";
			}
      	}
      	}else {
	        if("<%=current_time%>"==tempArray3[h].value.substring(0,8)){          
	            tempNote_info2+="("+tempArray1[h].value+"��"+tempArray2[h].value+"��24Сʱ����Ч)|";
	          //2017-01-10 liangyl ������������°泬�Ϳ���������й����Ͷ���չʾ�����ⷴ��
	            if(retArray.length>0){
	          		for(var i=0;i<retArray.length;i++){
	          			tempNote_info2+="("+retArray[i][0]+"��"+retArray[i][1]+"��24Сʱ����Ч)|";
	          			notessss+=retArray[i][2]+"|";
	    			}
	          	}
	        }else{
	            tempNote_info2+="("+tempArray1[h].value+"��"+tempArray2[h].value+"��ԤԼ��Ч)|";
	          //2017-01-10 liangyl ������������°泬�Ϳ���������й����Ͷ���չʾ�����ⷴ��
	            if(retArray.length>0){
	          		for(var i=0;i<retArray.length;i++){
	          			tempNote_info2+="("+retArray[i][0]+"��"+retArray[i][1]+"��ԤԼ��Ч)|";
	          			notessss+=retArray[i][2]+"|";
	    			}
	          	}
	        }
        }
      }
      else if(tempArray5[h].value=="3"){
        if("<%=current_time%>"==tempArray4[h].value.substring(0,8)) {  
          tempNote_info3+="("+tempArray1[h].value+"��"+tempArray2[h].value+"��24Сʱ��ʧЧ)|";
        //2017-01-10 liangyl ������������°泬�Ϳ���������й����Ͷ���չʾ�����ⷴ��
          if(retArray.length>0){
	        	for(var i=0;i<retArray.length;i++){
	        		tempNote_info3+="("+retArray[i][0]+"��"+retArray[i][1]+"��24Сʱ��ʧЧ)|";
	  			}
        	}
        }else{
          tempNote_info3+="("+tempArray1[h].value+"��"+tempArray2[h].value+"��ԤԼʧЧ)|";
        //2017-01-10 liangyl ������������°泬�Ϳ���������й����Ͷ���չʾ�����ⷴ��
          if(retArray.length>0){
	        	for(var i=0;i<retArray.length;i++){
	        		tempNote_info3+="("+retArray[i][0]+"��"+retArray[i][1]+"��ԤԼʧЧ)|";
	  			}
      		}
        }
      }
      
    }
  }
  if(tempNote_info2=="")tempNote_info2="��";
  if(tempNote_info3=="")tempNote_info3="��"; 
  tempNote_info2 =  tempNote_info2 + "|";
  tempNote_info3 =  tempNote_info3 +  "|";
    if (tempNote_info2 == "���������ѡ�ײͣ�15ԪIP�Ż����|")
    {
        opr_info += "ҵ������:��ѡ�ײͽ���17951 IP��;�Ż������15������" + "  " + "��ˮ:" + "<%=loginAccept.trim()%>" + "|";
    } else if (tempNote_info3 == "����ȡ����ѡ�ײͣ� 15ԪIP�Ż����|")
    {
        opr_info += "ҵ������:��ѡ�ײͽ���17951 IP��;�Ż������15��ȡ��" + "  " + "��ˮ:" + "<%=loginAccept.trim()%>" + "|";
    } else
    {
        opr_info += "ҵ������:��ѡ�ʷѱ��" + "  " + "��ˮ:" + "<%=loginAccept.trim()%>" + "|";
    }


    if ((tempNote_info2 == "���������ѡ�ײͣ� 15ԪIP�Ż����|") || (tempNote_info3 == "����ȡ����ѡ�ײͣ� 15ԪIP�Ż����|"))
    {
        note_info1 += "IP�����Ż��������ʹ�÷�15Ԫ��������������ܵ�������168����" + "|";
        note_info1 += "��17951���ڳ�;IPͨ���ѣ��������֣�����������ȡ��" + "|";
        note_info1 += "�°��£�16����������û������·�����ȡ7.5Ԫ������84���ӵ�" + "|";
        note_info1 += "17951���ڳ�;IPͨ���ѣ��������֣�����������ȡ��" + "|";
        note_info1 += "��ҵ�������룬������Ч��ȡ����������Ч��" + "|";
        note_info1 += "��Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�" + "|";

    } else {
        opr_info += "" + codeChg(tempNote_info2);//�����ʷ�
        opr_info += "" + codeChg(tempNote_info3);//ȡ���ʷ�
    }
    note_info2 += " " + "|";
    note_info2 += "��ע:" + "" + "|";
  //ningtn add @ ���鳩������;  wanghfa 2011/4/13 update �������鳩��ҵ����ذ�����ʾ��Ϣ������
  if (document.all.offerId40Hv.value.trim().indexOf("33157") != -1) {
    note_info2 += "1�����鳩���¹��ܷѲ��������°��¡��ײͰ���24Сʱ��Ч��" + "|";
//    note_info2 += "2��V���ͻ������������ʷѡ�" + "|";  huangrong update ���ڼ�ͥ����ƻ�ҵ��������޸ĵĺ� 2011-3-16
    note_info2 += "2���������ֻ��������������Ҳ���ȡ���ã�ÿ�½��������һ�α��������" + "|";
    note_info2 += "3������������������������޷�����ͨ���������Żݣ��ƶ���˾���е�������Ρ�" + "|";
    note_info2 += "4���ͻ����ա����Ͷ��Ÿ���������԰������������ʷ���ȡ��" + "|";
    note_info2 += "5���ͻ���ͨ��Ӫҵ����ѯ����������õ������" + "|";
    note_info2 += "6�����ʷ��Żݽ�ֹʱ��Ϊ2012��12��31��24ʱ��" + "|";
    note_info2 += "7���ͻ�������ʱ�԰��������ʷѱ�׼��ȡ��" + "|";
    note_info2 += "8��VPMN���û�����V���ʷѱ�׼��ȡ��" + "|";
    
  }
    //sunzx add @ 20071115
    if (document.all.offerId40Hv.value.trim().replace(/\|/g,"").len()== 0) {

    } else {
      ajaxGetEPf1(document.all.offerId40Hv.value);
        note_info3 += " " + "|";
        note_info3 += "��ѡ�ʷ�������" + retResultStr1 + "|";
        note_info3 += notessss;
    }
          //4G��ĿҪ���޸���� hejwa add 2014��3��6��8:59:57
// note_info4+=""+"|";
 //note_info4+="4G��������ʾ��"+"|";
 //note_info4+="1���й��ƶ�4Gҵ����ҪTD-LTE��ʽ�ն�֧�֣�������֧��4G���ܵ�USIM������ͨ4G�����ܣ�"+"|";
 //note_info4+="2���ͻ�����ʱѡ�û����֧��4G����USIM��ʱ����ͬʱ��ͨ4G�����ܣ�"+"|";
 //note_info4+="3��4G���ٽϿ죬����ߵ�λ�ײͿ������ܸ���������Żݣ�"+"|";
 //note_info4+="4��4Gҵ�����4G���������ǵķ�Χ���ṩ���й��ƶ�����������4G����������߷���������"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

/*********�����ӡ�������õĴ�ӡ����*********/
function printInfom365()
{
    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    
  cust_info+="�ͻ������� "+document.all.custName.value+"|";
  cust_info+="�ֻ����룺 "+"<%=phoneNo%>"+"|";

  opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "   " + "�û�Ʒ�ƣ�" + document.all.stPMsm_nameHi.value + "|";

  var tempNote_info2 = "���������ѡ�ײͣ�";//�����ʷ� ��
  var tempNote_info3 = "����ȡ����ѡ�ײͣ�";//ȡ���ʷ� ��
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
    var myPacket = new AJAXPacket("queryEXTStatus.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
	  myPacket.data.add("offer_ids",tempArray1[h].value.trim()); 
	  core.ajax.sendPacket(myPacket,function(packet){
	  	var retCode=packet.data.findValueByName("errCode");
		  var retMsg=packet.data.findValueByName("errMsg");
		  var isextflags=packet.data.findValueByName("isextflags"); //�Ƿ���������Ч���ʷ�5����������
		  var isextstrs=packet.data.findValueByName("isextstrs"); //��������Ч���ʷѵĻ���Ч��ʽչʾ
		  if(retCode == "000000"){
		  	isextflagsss=isextflags;
		  	isextstrssss=isextstrs;
		 	}else{
		 		rdShowMessageDialog("��ѯ�����ʷѵ���Ч��ʽ����",0);
		 	}
	  });
     //alert(isextflagsss); 
      if(isextflagsss=="5") {
      		    tempNote_info2+="("+tempArray1[h].value+"��"+tempArray2[h].value+"��"+isextstrssss+")";
      }else {
	        if("<%=current_time%>"==tempArray3[h].value.substring(0,8)){          
	            tempNote_info2+="("+tempArray1[h].value+"��"+tempArray2[h].value+"��24Сʱ����Ч)";      
	        }else{
	            tempNote_info2+="("+tempArray1[h].value+"��"+tempArray2[h].value+"��ԤԼ��Ч)";     
	        }
        }
      }
      else if(tempArray5[h].value=="3"){
        if("<%=current_time%>"==tempArray4[h].value.substring(0,8)) {  
          tempNote_info3+="("+tempArray1[h].value+"��"+tempArray2[h].value+"��24Сʱ��ʧЧ)";      
        }else{
          tempNote_info3+="("+tempArray1[h].value+"��"+tempArray2[h].value+"��ԤԼʧЧ)";     
        }
      }     
    }
  }
  if(tempNote_info2=="")tempNote_info2="��";
  if(tempNote_info3=="")tempNote_info3="��"; 
  tempNote_info2 =  tempNote_info2 + "|";
  tempNote_info3 =  tempNote_info3 +  "|";

        opr_info += "ҵ������:��ѡ�ʷѱ��" + "  " + "��ˮ:" + "<%=loginAccept.trim()%>" + "|";
        //opr_info += "" + codeChg(tempNote_info2);//�����ʷ�
        //opr_info += "" + codeChg(tempNote_info3);//ȡ���ʷ�
    
    note_info2 += " " + "|";
    note_info2 += "��ע:" + "" + "|";

    //sunzx add @ 20071115
    if (document.all.offerId40Hv.value.trim().replace(/\|/g,"").len()== 0) {

    } else {
      ajaxGetEPf1(document.all.offerId40Hv.value);
        note_info3 += " " + "|";
        //note_info3 += "��ѡ�ʷ�������" + retResultStr1 + "|";
    }
          //4G��ĿҪ���޸���� hejwa add 2014��3��6��8:59:57
 //note_info4+=""+"|";
// note_info4+="4G��������ʾ��"+"|";
// note_info4+="1���й��ƶ�4Gҵ����ҪTD-LTE��ʽ�ն�֧�֣�������֧��4G���ܵ�USIM������ͨ4G�����ܣ�"+"|";
// note_info4+="2���ͻ�����ʱѡ�û����֧��4G����USIM��ʱ����ͬʱ��ͨ4G�����ܣ�"+"|";
// note_info4+="3��4G���ٽϿ죬����ߵ�λ�ײͿ������ܸ���������Żݣ�"+"|";
// note_info4+="4��4Gҵ�����4G���������ǵķ�Χ���ṩ���й��ƶ�����������4G����������߷���������"+"|";
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
  cust_info+="�ͻ������� "+document.all.custName.value+"|";
  cust_info+="�ֻ����룺 "+"<%=phoneNo%>"+"|";
  cust_info+="֤�����룺 "+document.all.agent_idNo.value+"|";
  cust_info+="�ͻ���ַ�� "+document.all.stPMcust_addressHi.value+"|";
  
  opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm  :ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"�û�Ʒ��: "+document.all.stPMsm_nameHi.value+ "|";

  opr_info+="����ҵ�񣺿�ѡ�����ײ�����"+"  ������ˮ��"+"<%=loginAccept%>"+"|";
  opr_info+="����Ŀ�ѡ�����ʷѣ�"+(document.all.offerId40Hv.value).replace(/\|/g,"")+"--"+(document.all.offerName40Hv.value).replace(/\|/g,"")+"|";
  opr_info+="ҵ����Чʱ�䣺"+(document.all.offerTim40Hv.value).replace(/\|/g,"").substring(0,8)+"|";
  
  //note_info1+="��ѡ�����ʷ�������"+note+"|";
        ajaxGetEPf1(document.all.offerId40Hv.value);
        note_info3 += " " + "|";
        note_info3 += "��ѡ�ʷ�������" + "|";
        note_info3 += retResultStr1 + "|";
  note_info2+=" "+"|";
  if (offerAttrType == "YnL1")
  {
    note_info2+="��ע:"+"|";
    
    if (expDateOffset.indexOf("12")!=-1)
     note_info2+="1���������Ѱ������30Ԫ/�꣬��ʱ����24Сʱ����Ч����ʱȡ����24Сʱ����Ч��"+"|";
    else if (expDateOffset.indexOf("3")!=-1)
      note_info2+="1���������Ѱ�������9Ԫ/������ʱ����24Сʱ����Ч����ʱȡ����24Сʱ����Ч��"+"|";
      
    note_info2+="2�������������Ѱ��ꡢ����ҵ���൱�����ò��ɼ���ת��13800XYZ309���ֻ��ն˲���ȡ�����������ò��ɼ���ת����������,���ɼ���ת��13800XYZ309�Ĺ��ܽ�ʧЧ��"+"|";
    note_info2+="3���˶��������Ѱ���������ҵ�񣬰������˲�ת��"+"|";
    note_info2+="4���˶�������Ӫҵǰ̨����"+"|";
  } 
  else{
    note_info2+="��ע:"+"��ѡ�����ײ����룬�ײʹ��룺"+(document.all.offerId40Hv.value).replace(/\|/g,"")+"|";
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
   
  cust_info+="�ͻ������� "+document.all.custName.value+"|";
  cust_info+="�ֻ����룺 "+"<%=phoneNo%>"+"|";
  cust_info+="֤�����룺 "+document.all.agent_idNo.value+"|";
  cust_info+="�ͻ���ַ�� "+document.all.stPMcust_addressHi.value+"|";
  
  opr_info+="�û�Ʒ�ƣ�"+document.all.stPMsm_nameHi.value+"    ����ҵ�񣺿�ѡ�����ײ�ȡ��"+"|";
    opr_info+="������ˮ��"+"<%=loginAccept%>"+"|";
    opr_info+="ȡ���Ŀ�ѡ�����ʷѣ�"+document.all.offerName40CanHv.value.replace(/\|/g,"")+"--"+document.all.offerId40CanHv.value.replace(/\|/g,"")+"|";
  opr_info+="ҵ����Чʱ�䣺����"+"|";
  
  note_info1+="��ע��"+"|";
  
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 

    return retInfo;
}
//���Ŀ�ȡ��
function printInfo1254()
{
    //�õ���ҵ�񹤵���Ҫ�Ĳ���

    var time="";

    var cust_info="";  //�ͻ���Ϣ
    var opr_info="";   //������Ϣ
    var note_info1=""; //��ע1
    var note_info2=""; //��ע2
    var note_info3=""; //��ע3
    var note_info4=""; //��ע4
    var retInfo = "";  //��ӡ����
    /********������Ϣ��**********/
    cust_info+="�ͻ������� "+document.all.custName.value+"|";
    cust_info+="�ֻ����룺 "+"<%=phoneNo%>"+"|";
    cust_info+="֤�����룺 "+document.all.agent_idNo.value+"|";
    cust_info+="�ͻ���ַ�� "+document.all.stPMcust_addressHi.value+"|";
       /********������**********/
      opr_info+="�û�Ʒ�ƣ�"+document.all.stPMsm_nameHi.value+"|";
      opr_info+="ҵ�����ͣ����Ŀ�ȡ��"+"|";
       if(goodbz=="Y"){
          opr_info+="ҵ����ˮ��"+"<%=loginAccept%>"+"       �������ѽ�"+modedxpay+"Ԫ"+"|";
       }else{
       opr_info+="ҵ����ˮ��"+"<%=loginAccept%>"+"|";
       }
     
     var tempV1 =  document.all.offerIdHv.value.split("|");
     var tempV2 =  document.all.offerNameHv.value.split("|");
     var tempV3 =  document.all.offerTimeHv.value.split("|");

     var tempV4="";
     var tempV5="";
     
     for(var iw =0;iw<tempV1.length;iw++){
        if(tempV1[iw]!=""){
          tempV4+="("+tempV1[iw]+"��"+tempV2[iw]+")";
          tempV5+=tempV3[iw].substring(0,8)+" ";
        }
      }
      
     opr_info+="�ʷѣ����롢���ƣ���"+tempV4+";��"+document.all.offerId40Hv.value+" "+document.all.offerName40Hv.value+"��|";
     opr_info+="��Чʱ�䣺"+tempV5+"|";
     opr_info+="��|";
     ajaxGetEPf(document.all.offerIdHv.value.trim(),xqdm);
     opr_info+="���������ʷ�������"+codeChg(document.all.newZOfferDesc.value)+"||";
     if (document.all.offerId40Hv.value.trim().replace(/\|/g,"").len()== 0) {
			} else {
			opr_info+="��|";
      ajaxGetEPf1(document.all.offerId40Hv.value);
    	opr_info+="�������ѡ�ʷ�������"+retResultStr1+"|";
    	}
       /*******��ע��**********/
      if(bdbz=="Y"){
        opr_info+=bdts+"|";
      }else{
      opr_info+=" "+"|";
      }
    /**********������*********/
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
          tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")��������ȡ��"+",";
        }else{
          tempNote_info3+=tempArray1[h].value+"("+tempArray2[h].value+")��������1��ʧЧ"+",";      
        }
      }
    } 
  }
   
  if (tempNote_info3.length >0) {
  note_info1 += " " + "|";
  note_info1 += "���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:" + codeChg(tempNote_info3) + "|";
  }else {
  
  }          
      if(goodbz=="Y"){
      note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
    }
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
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
/*gaopeng 20131216 2013/12/16 20:17:06 ����2013��9�µ�һ��ҵ��֧��ϵͳ�г�רҵ���󣨹������ʷ���������ҵ�����Ż������󣩻ص����� start*/
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
		rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,0) 
    return false;
	}

}
/*gaopeng 20131216 2013/12/16 20:17:06 ����2013��9�µ�һ��ҵ��֧��ϵͳ�г�רҵ���󣨹������ʷ���������ҵ�����Ż������󣩻ص����� start*/
function offerMigu(){
	
	/*gaopeng 20131216 2013/12/16 20:17:06 ����2013��9�µ�һ��ҵ��֧��ϵͳ�г�רҵ���󣨹������ʷ���������ҵ�����Ż������� start*/
		/*���������Ĳ�ѯҳ��,���ص�ǰ�����ʷ���Ϣ������������*/
			var myPacket = new AJAXPacket("/npage/s1270/offerMigu139.jsp","���ڲ�ѯ��֤�����Ϣ�����Ժ�......");
			  
			  myPacket.data.add("loginAccept","<%=loginAccept%>");
			  core.ajax.sendPacket(myPacket,retOfferMigu139);
			  myPacket=null;
	/*gaopeng 20131216 2013/12/16 20:17:06 ����2013��9�µ�һ��ҵ��֧��ϵͳ�г�רҵ���󣨹������ʷ���������ҵ�����Ż������� end*/
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

//���ʷѱ��
function printInfo1270()
{
	
	offerMigu();
      //-----------start--------------wanghyd 20111216 ����ȫ��ͨȫ��ͳһ�ʷ�ҵ���������������ĺ�
  var iOldOfferId ="";
  var countBaseOfferss = $("#userHadOfferTab tr").length;
  for(var iw=1;iw<countBaseOfferss;iw++){
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="����"){
   iOldOfferId = $("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text();
   }
  }
  var iNewOfferId =document.all.offerIdHv.value.trim();
  check1270PrInfo(iOldOfferId,iNewOfferId);
  //---------------------------------------------------end---------------
  var infos1270s = document.all.info1270ss.value;
  //alert(infos1270s);
  //�õ���ҵ�񹤵���Ҫ�Ĳ���
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";

  var exeDate = "";//�õ�ִ��ʱ��
  var smCode = "<%=WtcUtil.repNull(request.getParameter("s_city"))%>";
  var region_code = "<%=WtcUtil.repNull(request.getParameter("belong_code"))%>"; //��������
  var old_smCode = "<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>";
  var retInfo = "";
    ajaxQueryPPf(document.all.offerIdHv.value);
    var sm_code = retResultStr2;
  /********������Ϣ��**********/
  cust_info+="�ͻ������� "+document.all.custName.value+"|";
  cust_info+="�ֻ����룺 "+"<%=phoneNo%>"+"|";
  cust_info+="֤�����룺 "+document.all.agent_idNo.value+"|";
  cust_info+="�ͻ���ַ�� "+document.all.stPMcust_addressHi.value+"|";

    /********������**********/
    opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"�û�Ʒ��: "+document.all.stPMsm_nameHi.value+ "|";
    if(goodbz=="Y"){
      opr_info+="����ҵ��:���ʷѱ��"+"  "+"������ˮ: "+"<%=loginAccept%>" +"    �������ѽ�"+modedxpay+"Ԫ"+"|";
    }else{
      opr_info+="����ҵ��:���ʷѱ��"+"  "+"������ˮ: "+"<%=loginAccept%>" +"|";
    }
    
   // opr_info+="��ǰ���ʷѣ�"  +"|";
  var countBaseOffer = $("#userHadOfferTab tr").length;
  for(var iw=1;iw<countBaseOffer;iw++){
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="����"){
      opr_info+="��ǰ���ʷѣ�"+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text()+" "+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(1)").text()+"|";
    }
  }
  
    opr_info+="���������ʷѣ�"+document.all.offerIdHv.value.trim()+" "+document.all.offerNameHv.value.trim()+"      "+"���ʷ���Чʱ�䣺"+document.all.offerTimeHv.value.substring(0,8)+"|";
    
    ajaxGetEPf(document.all.offerIdHv.value.trim(),xqdm);
    
    opr_info+="���������ʷѶ������ۣ�"+ document.all.newZOfferECode.value+"-"+document.all.xq_name.value+"*"+"���ʷѶ�ӦƷ�ƣ�"+ sm_code+"|" ;
    //opr_info+=" ���������ʷ�������"+document.all.newZOfferDesc.value+"|";      
    
    if(document.all.dOfferId.value!=""||document.all.dOfferName.value!==""){
      opr_info+="���ں�ִ���ʷѣ�"+document.all.dOfferId.value.trim()+" "+document.all.dOfferName.value.trim()+"|";
      }
 
    if(document.all.dECode.value!="") {
      opr_info+="���ں�������룺"+document.all.dECode.value+"-"+document.all.xq_name.value+"|";
      }
 
    if(document.all.dOfferDesc.value!="") {
      opr_info+="���ں��ʷ�������"+codeChg(document.all.dOfferDesc.value.trim())+"|";
      }
          
          
  var tempNote_info2 = "���������ѡ�ײͣ�";//�����ʷ� ��
  var tempNote_info3 = "����ȡ����ѡ�ײͣ�";//ȡ���ʷ� ��
  
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
            tempNote_info2+="("+tempArray1[h].value+"��"+tempArray2[h].value+"��24Сʱ����Ч)";      
            
        }else{
            tempNote_info2+="("+tempArray1[h].value+"��"+tempArray2[h].value+"��ԤԼ��Ч)";   
            
        }
        
        emergencyKxOfferContent+="("+tempArray1[h].value+"��"+tempArray2[h].value+")";   
      }
      else if(tempArray5[h].value=="3"){
        if("<%=current_time%>"==tempArray4[h].value.substring(0,8)) {  
          tempNote_info3+="("+tempArray1[h].value+"��"+tempArray2[h].value+"��24Сʱ��ʧЧ)";  
          tempNote_info4+=tempArray1[h].value+"("+tempArray2[h].value+")��������ȡ��"+",";    
        }else{
          tempNote_info3+="("+tempArray1[h].value+"��"+tempArray2[h].value+"��ԤԼʧЧ)";     
          tempNote_info4+=tempArray1[h].value+"("+tempArray2[h].value+")��������1��ʧЧ"+",";
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

    /*******��ע��**********/
    if(bdbz=="Y"){
        note_info1+=bdts+"|";
      }
    /**********������*********/
  if(document.all.stPMsm_nameHi.value !=sm_code && !(document.all.stPMsm_nameHi.value=="������" && document.all.stPMsm_nameHi.value=="ȫ��ͨ"))
  note_info1+="���ʷ���Ч������Ʒ�ƽ���"+ document.all.stPMsm_nameHi.value+"���Ϊ"+ sm_code+"��"+"|";
  note_info1+="."+"|";
    note_info1+="���������ʷ�����:"+"|";
    note_info1+=codeChg(document.all.newZOfferDesc.value)+"|";
    if(document.all.offerId40Hv.value.trim().replace(/\|/g,"").len()== 0) {
  }else{
    ajaxGetEPf1(document.all.offerId40Hv.value);
      note_info3+="."+"| ";
      note_info3+="��ѡ�ʷ�������"+"|";
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
        note_info4+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+tempNote_info4+"|";
      }else{

      }
    
   	  ajaxQueryOfferTraffic(document.all.offerIdHv.value.trim());//����������ʷ�
		    
    	var dqzzfmc="";
      var countBaseOffer11111 = $("#userHadOfferTab tr").length;
      for(var iw=1;iw<countBaseOffer11111;iw++){
       if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="����"){
      dqzzfmc=$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(1)").text();
      ajaxQueryOfferTraffic22($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text().trim());//��ǰ�����ʷ�
      }
     }
     
  	if(offerTrafficflag!="0" && offerdangqianflag!="0") {//ԭ���ʷѺ������ʷѶ��������������ʷ�
     note_info1+="�������ʷѱ��������"+dqzzfmc+"�ײͣ�ԭ�ײͣ���ʣ���������ٽ�ת�����£�����"+document.all.offerNameHv.value.trim()+"�ײͣ����ײͣ�����Ч���粻�������ʷѱ����������Я��ת������Ϊ���ײ��ڵ�ʣ�����������ת������ʹ�á�"+"|";
    }
    if(offerTrafficflag=="0" && offerdangqianflag!="0") {//ԭ���ʷ��������������ʷѣ������ʷ������������ʷ�
     note_info1+="�������ʷѱ��������"+dqzzfmc+"�ײͣ�ԭ�ײͣ���ʣ���������ٽ�ת�����¡�"+"|";
    } 
    if(offerTrafficflag!="0" && offerdangqianflag=="0") {//ԭ���ʷ������������ʷѣ������ʷ��������������ʷ�
     note_info1+="�������ʷѱ��������"+document.all.offerNameHv.value.trim()+"�ײͣ����ײͣ�����Ч���粻�������ʷѱ����������Я��ת������Ϊ���ײ��ڵ�ʣ�����������ת������ʹ�á�"+"|";
    }    
       
  if(goodbz=="Y"){
      note_info4+=" ."+"|";
      note_info4+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
      if(print12701255){
    	  note_info4 += "Ϊ��������Ȩ�棬��ԭ"+retResult212701255+"���ʷѰ����Ĳ���ҵ��Ϊ����ѱ���һ�꣬�����ڼ�ҵ��ÿ�·���Ϊ"+retResult112701255+"Ԫ��ϵͳÿ��������"+retResult112701255+"Ԫר��൱�����ʹ�á��ñ����Ĳ���ҵ���������ʷ���Ч�����ڿ�ʼ���㣬���ں����ޱ仯���Żݽ��Զ�˳��һ�꣬���б仯ϵͳ����ǰ1���¶���֪ͨ��|";
      }
  }
  else{
	  if(print12701255){
	  	note_info4 += "��ע��Ϊ��������Ȩ�棬��ԭ"+retResult212701255+"���ʷѰ����Ĳ���ҵ��Ϊ����ѱ���һ�꣬�����ڼ�ҵ��ÿ�·���Ϊ"+retResult112701255+"Ԫ��ϵͳÿ��������"+retResult112701255+"Ԫר��൱�����ʹ�á��ñ����Ĳ���ҵ���������ʷ���Ч�����ڿ�ʼ���㣬���ں����ޱ仯���Żݽ��Զ�˳��һ�꣬���б仯ϵͳ����ǰ1���¶���֪ͨ��|";
	  }
	}
  
  note_info4+=" ."+"|";
  /*2013/12/17 10:08:50 20131216 gaopeng ����2013��9�µ�һ��ҵ��֧��ϵͳ�г�רҵ���󣨹������ʷ���������ҵ�����Ż������� ��ʼ���������жϴ�ӡ�����Ӳ��� start*/  
  var mailzero = $("#mailzero").val();
  var mailfive = $("#mailfive").val();
  var miguzero = $("#miguzero").val();
  var migufive = $("#migufive").val();
  /*139 0Ԫ*/
  if(mailzero == "Y"){
  	note_info4+="����������ʷѰ���5Ԫ139����ҵ�����ʷѱ�����Զ��˶���ҵ�����豣��ҵ���������ʷѱ������KTYX5��10086��ͨ���ʷ�5Ԫ/�£����ʷѰ�����5Ԫ139����ҵ�������ʷ���Ч�ڼ䲻�ɱ����ȡ����"+"|";
  	note_info4+=" ."+"|";
  }
  /*139 5Ԫ*/
  if(mailfive == "Y"){
  	note_info4+="����������ʷѰ���5Ԫ139����ҵ�����ʷѱ�����Զ��˶���ҵ�����豣��ҵ���������ʷѱ������KTYX5��10086��ͨ���ʷ�5Ԫ/�¡�"+"|";
  	note_info4+=" ."+"|";
  }
  /*�乾0Ԫ*/
  if(miguzero == "Y"){
  	note_info4+="����������ʷѰ����乾�ؼ���Աҵ�����ʷѱ�����Զ��˶���ҵ�����豣��ҵ���������ʷѱ������KTTJ��10086��ͨ���ʷ�6Ԫ/�¡�"+"|";
  	note_info4+=" ."+"|";
  }
  /*�乾5Ԫ*/
  if(migufive == "Y"){
  	note_info4+="����������ʷѰ����乾�ؼ���Աҵ�����ʷѱ�����Զ��˶���ҵ�����豣��ҵ���������ʷѱ������KTTJ��10086��ͨ���ʷ�6Ԫ/�¡�"+"|";
  	note_info4+=" ."+"|";
  }
/*2013/12/17 10:08:50 20131216 gaopeng ����2013��9�µ�һ��ҵ��֧��ϵͳ�г�רҵ���󣨹������ʷ���������ҵ�����Ż������� ��ʼ���������жϴ�ӡ�����Ӳ��� end*/    
 
  note_info4+="��ע:"+codeChg(document.all.tonote.value)+"|";
 //2010-9-16 wanghfa��� ������������ start
  if (parseInt(document.all.offerIdHv.value.trim()) <= 33230 && parseInt(document.all.offerIdHv.value.trim()) >= 33205) { //����
  //if (parseInt(document.all.offerIdHv.value.trim()) == 19919 || parseInt(document.all.offerIdHv.value.trim()) == 19628) {//CRMYY����
    note_info4 += "1��ͬ�������ײͽ������ñ������º��롢�ǳ������ײͽ�������ʡ�����º��롣|";
    note_info4 += "2�����º������ѡ��ͬһ���ײͲ�������ͨ���Żݡ����º���֮һ����״̬�쳣��ȡ����������ϵ���ײͣ������º���󶨹�ϵ�Զ������|";
    note_info4 += "3�����������������ʷ�������һ������Ƿ�ѣ���Ӱ����һ����������ͨ����|";
    note_info4 += "4�����ڿͻ����ú���򲦴�ʽ�������޷������Żݣ��ƶ���˾���е�������Ρ�|";
  }
  //2010-9-16 wanghfa��� ������������ end
  /* ningtn ���������������������ӡ */
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
            if(smzvalues=="3") {//��ʵ����ȫ��ͨ�����еش��ͻ�ת��Ϊ�����пͻ�
                note_info4+="<%=readValue("1270","ps","jf",Readpaths)%>"+"|";
            }

    if(infos1270s=="1") {
  var countBaseOfferssd = $("#userHadOfferTab tr").length;
  for(var iw=1;iw<countBaseOfferssd;iw++){
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="����"){
    	/*2014/06/23 15:23:35 gaopeng R_CMI_HLJ_xueyz_2014_1644797@���������޸Ĺ�����ʾ����ʾ �ɵ��������ʾ*/
    	/*note_info4+="������"+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(1)").text()+"�ײͻ�����139����5Ԫ�潫�����ʷ���Ч֮����ʼ�շѣ�ÿ���շ�5Ԫ��"+"|";*/
    }
  }

  }
        //4G��ĿҪ���޸���� hejwa add 2014��3��6��8:59:57
// note_info4+=""+"|";
// note_info4+="4G��������ʾ��"+"|";
// note_info4+="1���й��ƶ�4Gҵ����ҪTD-LTE��ʽ�ն�֧�֣�������֧��4G���ܵ�USIM������ͨ4G�����ܣ�"+"|";
// note_info4+="2���ͻ�����ʱѡ�û����֧��4G����USIM��ʱ����ͬʱ��ͨ4G�����ܣ�"+"|";
// note_info4+="3��4G���ٽϿ죬����ߵ�λ�ײͿ������ܸ���������Żݣ�"+"|";
// note_info4+="4��4Gҵ�����4G���������ǵķ�Χ���ṩ���й��ƶ�����������4G����������߷���������"+"|";
  /* ningtn ���������������������ӡ */
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}


function ajaxQueryOfferTraffic(offerids) {
		var funtionnames_Packet = new AJAXPacket("/npage/s1104/queryOfferTraffic.jsp","���ڲ�ѯ�����Ժ�......");
		funtionnames_Packet.data.add("offerId",offerids);
		core.ajax.sendPacket(funtionnames_Packet,doreturnFunctions);
		funtionnames_Packet=null;
}

  function doreturnFunctions(packet) {
    var queryCount = packet.data.findValueByName("queryCount");
		offerTrafficflag=queryCount;
  }

function ajaxQueryOfferTraffic22(offerids) {
		var funtionnames_Packet = new AJAXPacket("/npage/s1104/queryOfferTraffic.jsp","���ڲ�ѯ�����Ժ�......");
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
  //�õ���ҵ�񹤵���Ҫ�Ĳ���
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";

  cust_info+="�ͻ������� "+document.all.custName.value+"|";
  cust_info+="�ֻ����룺 "+"<%=phoneNo%>"+"|";
  cust_info+="��ʼʱ�䣺    "+document.all.offerEffDateCanHv.value.replace(/\|/g,"")+"|";
 
  opr_info+="ҵ������:         ȫ��ͨ��ܰ��ͥȡ��"+"|";
  opr_info+="ȡ������:         "+"<%=phoneNo%>"+"|";
  opr_info+="��ˮ:             "+"<%=loginAccept%>"+"|";
  
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
  cust_info+="�ͻ������� "+document.all.custName.value+"|";
  cust_info+="�ֻ����룺 "+"<%=phoneNo%>"+"|";
  
  opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"�û�Ʒ��: "+document.all.stPMsm_nameHi.value+ "|";
  
  opr_info+="����ҵ�����ζ����ʷ�����"+"  ������ˮ��"+"<%=loginAccept%>"+"|";
  opr_info+="�����ʷѣ�"+(document.all.offerId40Hv.value).replace(/\|/g,"")+"--"+(document.all.offerName40Hv.value).replace(/\|/g,"")+"|";
  if ( (offerAttrType =="YnDz" ) &&"<%=current_time%>">document.all.offerTimeHv.value.substring(0,8))
  {
    opr_info+="���ʷ�����1����Ч��"+document.all.offerExpTime.value+"ʧЧ��ԭ������һ���ײ�����1��ʧЧ"+"|";
  }
  else if ( (offerAttrType =="YnDy" ) &&"<%=current_time%>"==document.all.offerTimeHv.value.substring(0,8))
  {
    opr_info+="���ʷ�24Сʱ֮����Ч��         ʧЧʱ�䣺"+document.all.offerExpTime.value+" "+"0ʱ"+"|";
  }
  else if ( (offerAttrType =="YnDy" ) &&"<%=current_time%>">document.all.offerTimeHv.value.substring(0,8))
  {
    opr_info+="���ʷ�����1����Ч��"+document.all.offerExpTime.value+"ʧЧ,ԭ������һ���ײ�����1��ʧЧ "+"|";
  }   
  else
  {
    opr_info+="ҵ����Чʱ�䣺24Сʱ֮��         ʧЧʱ�䣺"+document.all.offerTim40EffHv.value.substring(0,8)+" "+"0ʱ"+"|";
  }
  note_info1+="�ʷ�������"+note+"|";
  note_info1+="          �ʷ�ʧЧ���Ż��Զ�ȡ����"+"|";
  note_info1+="˵��:��������V���ڲ�ͨ�����ʷѰ�����V���ʷѱ�׼��ȡ��"+"|";
  note_info2+="��ע:"+"���ζ����ʷ����룬�ײʹ��룺"+document.all.offerId40Hv.value+"|";
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
  
  cust_info+="�ͻ������� "+document.all.custName.value+"|";
  cust_info+="�ֻ����룺 "+"<%=phoneNo%>"+"|";
  cust_info+="֤�����룺 "+document.all.agent_idNo.value+"|";
  cust_info+="�ͻ���ַ�� "+codeChg(document.all.stPMcust_addressHi.value)+" "+"|";
  
  opr_info+="�û�Ʒ�ƣ�"+document.all.stPMsm_nameHi.value+"    ����ҵ�����ζ����ʷ�ȡ��"+"|";
    opr_info+="������ˮ��"+"<%=loginAccept%>"+"|";
    opr_info+="ȡ���ʷѣ�"+document.all.offerName40CanHv.value.replace(/\|/g,"")+"--"+document.all.offerId40CanHv.value.replace(/\|/g,"")+"|";
    if (offerAttrType=="YnDy"||offerAttrType=="YnDz")
    {
      opr_info+="ȡ�����������ʷѺ�ԤԼδ��Ч�ʷѣ�24Сʱ֮����Ч��ȡ����ǰ�����ʷѣ�������Ч"+"|";
    }
    else
    {
      opr_info+="ҵ����Чʱ�䣺24Сʱ֮��"+"|";
    }
    note_info1 = note_info1 + ""+"|";
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}

/*2014/04/04 11:02:20 gaopeng ���ù�����ѯ����Ʒ��sm_code*/
	function getPubSmCode(kdNo){
			var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","���ڻ�����ݣ����Ժ�......");
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
  
  cust_info += "����ʺţ�" + "<%=broadPhone%>" + "|";
  cust_info += "�ͻ�������" + document.all.custName.value + "|";
  opr_info += "ҵ��������ƣ����ʷѱ��" + "     ������ˮ:" + "<%=loginAccept%>" + "|";
  var countBaseOffer = $("#userHadOfferTab tr").length;
  for(var iw=1;iw<countBaseOffer;iw++){
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="����"){
      opr_info+="��ǰ���ʷѣ�"+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text()+" "+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(1)").text()+"|";
    }
  }
  opr_info+="���������ʷѣ�"+document.all.offerIdHv.value.trim()+" "+document.all.offerNameHv.value.trim()+"      "+"���ʷ���Чʱ�䣺"+document.all.offerTimeHv.value.substring(0,8)+"|";
  
  ajaxGetEPf(document.all.offerIdHv.value.trim(),xqdm);
  note_info1+="���������ʷ�����:"+"|";
  note_info1+=codeChg(document.all.newZOfferDesc.value)+"|";
  if(pubSmCode == "kf" || pubSmCode == "ki"){
  		
			note_info1 += "��ע��"+"|";
			note_info1 += "1������ϵ�绰�䶯ʱ���뼰ʱ���ƶ���˾��ϵ���Ա������»�������ʱ��ʱ�յ�֪ͨ��"+"|";
			note_info1 += "2������������벦��������ߣ�10086��"+"|";
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
  
  cust_info += "����ʺţ�" + "<%=broadPhone%>" + "|";
  cust_info += "�ͻ�������" + document.all.custName.value + "|";
  opr_info += "ҵ��������ƣ�����ȡ��" + "  ����ʽ��ƾ�������    ������ˮ:" + "<%=loginAccept%>" + "|";
  var countBaseOffer = $("#userHadOfferTab tr").length;
  for(var iw=1;iw<countBaseOffer;iw++){
    if($("#userHadOfferTab tr:eq("+iw+")").find("td:eq(3)").text()=="����"){
      opr_info+="ȡ���İ����ʷѣ�"+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(0)").text()+" "+$("#userHadOfferTab tr:eq("+iw+")").find("td:eq(1)").text()+"|";
    }
  }
    
  opr_info += "ȡ����ִ���ʷѣ�" + document.all.offerIdHv.value+" "+document.all.offerNameHv.value + "  *" + "��Чʱ�䣺" + document.all.offerTimeHv.value.substring(0,8) + "|";
  
  ajaxQueryPPf(document.all.offerIdHv.value);
  note_info1 += "��ע����ʱȡ�����޷��ָ����ꡣ����ȡ��ʱ��������ʣ�໰�ѵ�30%��ȡΥԼ��" + "|";
  note_info1 += "ȡ����ִ���ʷ�������" + document.all.newZOfferDesc.value + "|";
  note_info1 += note + "|";
  /*******��ע��**********/
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
System.out.println("mylog  ҳ�� ִ��  ��ʱ�� = ��"+(s34-s33)+"��");
%>