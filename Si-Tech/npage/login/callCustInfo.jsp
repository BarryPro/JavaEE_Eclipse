<%
/********************
 version v2.0
 开发商 si-tech
 create hejwa@2009-4-20
 update hejwa@2010-11-30 将sPubUserMsg 和其他sql等查询更改为sPubUserMsgKF服务查询
 update tangsong@2010-12-28 代码排版及页面样式改造
********************/
%>
<%
    String opCode              = request.getParameter("opCode");
    String opName              = request.getParameter("opName");
    String g_sFestivalDate     = (String)session.getAttribute("g_sFestivalDate");
    String g_sFestivalGreeting = (String)session.getAttribute("g_sFestivalGreeting");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_callCustInfo_style.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient170"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.regex.*"%>
<%@ page import="java.lang.String"%>
<style type="text/css">
<!--
.redcolor {
	color: #F00;
}
-->
</style>
<head>
<title>客户信息</title>
<%
	System.out.println("------------callCustInfo.jsp-------------");
	String custIdArr = request.getParameter("custIdArr");
	String custNameArr = request.getParameter("custNameArr");
	String loginType = request.getParameter("loginType");
	String phone_no = request.getParameter("phone_no").trim();
	String iCustType = request.getParameter("iCustType");
	String regionCode = (String)session.getAttribute("regCode");
	String contactId = request.getParameter("contactId");
	String callSkill = request.getParameter("callSkill");
	String kfcaller = request.getParameter("kfcaller");//主叫
	String enterTypeAll = request.getParameter("enterTypeAll");//用于判断是否系统自动刷新用户信息页
	String checkPwdOth = request.getParameter("checkPwdOth");//用于判断是否他机密码验证后刷新用户信息页
	String gdSql = "select count(*) from t_sce_arpu120 where TELNO='"+phone_no+"'";
	String nBflag = ""; //一类吉祥号，二类吉祥号 update by songjia 20110601;
	/**入参变量*/
	String iLoginAccept ="0";    //操作流水
	String iChnSource ="1"; 	   //渠道标识
	String iOpCode  ="5556"; 	   //操作代码
	String iLoginNo =(String)session.getAttribute("workNo"); //操作工号
	String iLoginPwd =(String)session.getAttribute("password"); //工号密码
	String iPhoneNo =phone_no;    //手机号码
	String iUserPwd ="";    //用户密码

  //中高端用户标识 Add by tangxlc 2011-11-16  START 
  StringBuffer sqlBuf = new StringBuffer();
	sqlBuf.append("select t.phone_no "); 
	sqlBuf.append("  from dbcalladm.dcallmidhighcustphone t ");
	sqlBuf.append(" where t.phone_no = :phone_no " );
 	String sqlParams = "phone_no=" + phone_no ;	
 	String strMidHighFlag = new String();
%>
	  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		    <wtc:param value="<%=sqlBuf.toString()%>"/> 
		    <wtc:param value="<%=sqlParams%>"/> 
		</wtc:service>
		<wtc:array id="resultArr" scope="end"/>
<%
  if( resultArr.length == 0 )
  {
      strMidHighFlag = "否";
  }
  else
  {
      strMidHighFlag = "是";
  } 
  //中高端用户标识 END
  
	String specialUsercontent="";
 	List queryList =(List)KFEjbClient170.queryForList("findByPhone",phone_no);
	if (queryList != null) {                    
		for (int i = 0; i < queryList.size(); i++) {   
			Map map = (Map)queryList.get(i);       
      		specialUsercontent= map.get("CONTENT").toString(); 
		}
	}
	//add wanghong 增加聊天骚扰，不良骚扰
	String tablename = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	HashMap hashMap = new HashMap();
	  hashMap.put("tablename",tablename);
	  hashMap.put("PHONE_NO",phone_no);
  String talkUserNum="0";
  String BLUserNum="0";
 	List talkUserList =(List)KFEjbClient170.queryForList("findtalkusernum",hashMap);
	if (talkUserList != null) {                    
		for (int i = 0; i < talkUserList.size(); i++) {   
			Map map = (Map)talkUserList.get(i);       
      		String userType= map.get("USERTYPE").toString(); 
      		if("1".equals(userType)){
      		   BLUserNum=map.get("TOTALNUM").toString();
      		}else if("0".equals(userType)){
      			 talkUserNum=map.get("TOTALNUM").toString();
      			}
		}
	}
	if (g_sFestivalGreeting != null && !g_sFestivalGreeting.equals("")) {
		g_sFestivalGreeting = "&nbsp;" + g_sFestivalGreeting;
	}
	if (specialUsercontent != null && !specialUsercontent.equals("")) {
		g_sFestivalGreeting = "&nbsp;" + g_sFestivalGreeting;
	}
	/**出参变量*/

	String sRetCode =""; //返回代码
	String sRetMsg  =""; //返回描述
	String custId_g =""; //id_no
	String contract_no =""; //contract_no
	String sm_code  =""; //品牌代码
	String sm_name  =""; //品牌名称
	String open_time =""; //开户时间
	String belong_code =""; //地市代码
	String belong_name =""; //地市名称
	String limit_owe =""; //limit_owe
	String credit_value =""; //credit_value
	String originalCondition = "";  //原状态
	String vRunCodeOldName =""; //原状态名称
	String nowCondition = "";  //现状态
	String vRunCodeNewName =""; //原状态名称
	String updStaDate = "";  //状态修改时间
	String cust_name =""; //客户姓名
	String owner_grade =""; //用户级别
	String grade_name =""; //级别名称
	String id_type  =""; //证件类型
	String type_name =""; //证件名称
	String id_iccid =""; //证件号码
	String contact_phone =""; //contact_phone
	String pay_code =""; //pay_code
	String pay_name =""; //pay_name
	String sim_no =""; //SIM卡号
	String mode_code =""; //资费
	String mode_note =""; //资费描述
	String gdFlag =""; //高端标志
	String jxFlag =""; //吉祥号码标志
	String bigCustomerSymbol = "";  //大客户标志
	String showInfo = "";
	String isUpdateFee="";//是否办理过户或改资费的活动提示
	
	String ispmsuser="";//是否是电话经理用户
	String isrealName="";//是否是实名状态

	String clsName  = "orange";
	String clsName1 = "orange";
	String showJxStr = "";
	String showGdStr = "";
	String retCodeMs = "";
	String retMsgMs = "";
	String userMsgMs[][] =new String[][]{};
  String isChnInfoFlag="";//社会渠道标识
	try{
%>
	<wtc:service name="sPubUserMsgKF" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="33">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
		</wtc:service>
	<wtc:array id="userMsg" scope="end"/>
<%
  for(int i=0;i<userMsg.length;i++){
    for(int j=0;j<userMsg[i].length;j++){
        System.out.println("----------------------------sPubUserMsgKF-------------userMsg["+i+"]["+j+"]="+userMsg[i][j]);
    }
  }
  System.out.println("----------------------------sPubUserMsgKF-------------retCode="+retCode);
  System.out.println("----------------------------sPubUserMsgKF-------------retMsg="+retMsg);
	retCodeMs = retCode;
	retMsgMs = retMsg;
	userMsgMs = userMsg;
}catch(Exception ex){
%>
<script type="text/javascript">
	rdShowMessageDialog("调用服务sPubUserMsgKF出错",0);
	parent.parent.removeTab("5556");
</script>
<%}%>

<%
/*
	if(code.equals("000000")&&result_gd.length>0){
		gdFlag = result_gd[0][0];
	}
	*/

	if(retCodeMs.equals("000000")){
		custId_g =userMsgMs[0][0] ; //id_no
		contract_no =userMsgMs[0][1] ; //contract_no
		sm_code  =userMsgMs[0][2] ; //品牌代码
		sm_name  =userMsgMs[0][3] ; //品牌名称
		open_time =userMsgMs[0][4] ; //开户时间
		belong_code =userMsgMs[0][5] ; //地市代码
		belong_name =userMsgMs[0][6] ; //地市名称
		limit_owe =userMsgMs[0][7] ; //limit_owe
		credit_value =userMsgMs[0][8] ; //credit_value
		originalCondition =userMsgMs[0][9] ; //原状态
		vRunCodeOldName =userMsgMs[0][10]; //原状态名称
		nowCondition =userMsgMs[0][11]; //现状态
		vRunCodeNewName =userMsgMs[0][12]; //现状态名称
		
		updStaDate =userMsgMs[0][13]; //状态修改时间
		cust_name =userMsgMs[0][14]; //客户姓名
		owner_grade =userMsgMs[0][15]; //用户级别
		grade_name =userMsgMs[0][16]; //级别名称
		id_type  =userMsgMs[0][17]; //证件类型
		type_name =userMsgMs[0][18]; //证件名称
		id_iccid =userMsgMs[0][19]; //证件号码
		contact_phone =userMsgMs[0][20]; //contact_phone
		pay_code =userMsgMs[0][21]; //pay_code
		pay_name =userMsgMs[0][22]; //pay_name
		sim_no =userMsgMs[0][23]; //SIM卡号
		mode_code =userMsgMs[0][24]; //资费
		mode_note =userMsgMs[0][25]; //资费描述
		jxFlag =userMsgMs[0][26]; //吉祥号码标志
		bigCustomerSymbol =userMsgMs[0][27]; //大客户标志
		
		isUpdateFee = userMsgMs[0][29];
		ispmsuser =userMsgMs[0][31];
		isrealName=userMsgMs[0][30];
		isChnInfoFlag=userMsgMs[0][32];
		
System.out.println(isChnInfoFlag+"sunbya------------------------"+ispmsuser);
		if(vRunCodeNewName.trim().equals("正常")){
			clsName = "";
		}
		if(bigCustomerSymbol.trim().equals("非大客户")){
			clsName1 = "";
		}
		if(jxFlag.equals("1")) showJxStr = "此号码["+phone_no+"]为特殊号码";
		if(gdFlag.equals("1")) showGdStr = "此用户["+phone_no+"]为高端用户";
		if(jxFlag.equals("1")&&gdFlag.equals("1")) showJxStr = showJxStr+"、";
		if(originalCondition.toUpperCase().equals("NULL")) originalCondition = "";
		if(nowCondition.toUpperCase().equals("NULL")) nowCondition = "";
		if(bigCustomerSymbol.toUpperCase().equals("NULL")) bigCustomerSymbol = "";
		if(updStaDate.toUpperCase().equals("NULL")) updStaDate = "";
		
		//判断吉祥号码：一类号码、二类号码 20110601 update by songjia 
		String p5 = phone_no.substring(6);
		//一类吉祥号
		Pattern pattern = Pattern.compile("([0-9])\\1{4}|[0-9]([0-9])\\2{3}|01234|12345|23456|34567|45678|56789|67890");
		Matcher matcher = pattern.matcher(p5);
	    if(!matcher.matches()){
	    //二类吉祥号
			Pattern pattern2 = Pattern.compile("[0-9][0-9]([0-9])\\1{2}|[0-9]00[0-1][0-9]|[0-9]0020|\\d0123|\\d1234|\\d2345|\\d3456|\\d4567|\\d5678|\\d6789|\\d7890");
			matcher= pattern2.matcher(p5);
			if(matcher.matches()){
				nBflag="(二类号码)";
			}
	  }else{
	  		nBflag="(一类号码)";
	  	}
	}else{
		showInfo = "无此客户资料";
	}
	
%>
	<wtc:service name="sCollQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
		<wtc:param value="" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="5556" />
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="" />
	</wtc:service>
	<wtc:array id="ChannelIdentifier" scope="end" />
<%
for(int i=0;i<ChannelIdentifier.length;i++){
    for(int j=0;j<ChannelIdentifier[i].length;j++){
        System.out.println("----------------------------sCollQry-------------ChannelIdentifier["+i+"]["+j+"]="+ChannelIdentifier[i][j]);
    }
}
%>
<script type="text/javascript">
//update liuhaoa 屏蔽F5不让系统退出
	function esckeydown()
	{		
	    if((event.keyCode==27) || event.keyCode==116){
	    	  event.keyCode = 0;
	    	  event.returnValue = false;
	    }
	}
	document.onkeydown=esckeydown;	
	function addTabBySearchCustName(phoneNo,loginType){
		var packet = new AJAXPacket("getCustId.jsp");
		packet.data.add("phoneNo" ,phoneNo);
		packet.data.add("loginType" ,loginType);
		core.ajax.sendPacket(packet,doGetCustId,true);
		packet =null;
	}
	function doGetCustId(packet)
	{
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var custIdArr = packet.data.findValueByName("custIdArr");
		var custNameArr = packet.data.findValueByName("custNameArr");
		var custIccidJ = packet.data.findValueByName("custIccid");
		var custCtimeJ = packet.data.findValueByName("custCtime");
		var loginType = packet.data.findValueByName("loginType");
		var phone_no = packet.data.findValueByName("phone_no");
		if(retCode!="0")
		{
			rdShowMessageDialog(retCode+","+retMsg,0);
			return false;
		}else
		{	
			if(custIdArr.length==1)
			{
				parent.openCustMain(custIdArr,custNameArr,loginType,phone_no);
			}else
			{
				var path="selectCustId.jsp?opName=选择客户&custIdArr="+custIdArr+"&custNameArr="+custNameArr+"&custIccid="+custIccidJ+"&custCtime="+custCtimeJ;
				window.open(path,"newwindow","height=600, width=600,top=50,left=250,scrollbars=yes, resizable=yes,location=no, status=yes");
			}
		}
	}

	//yuanqs add 2010/10/14 11:32:20 2010/10/18 17:34:44
	function toCustInfo() {
		try{
			parent.removeTab("1500");
		}
		catch( e){
		}
		parent.addTab(true,'1500','综合信息查询','../query/f1500_2.jsp?QueryType=0&condText='+"<%=phone_no%>");
	}
	function activeRecommend(){
		if(parent.parent.current_CurState !=5){
			rdShowMessageDialog("非接续状态，不能点击!",0);
			return;
		}	
		var path = "getMarket_kf.jsp?phoneNo=<%=phone_no%>&contactId=<%=contactId%>";
		var h = 550;
		var w = 700;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="height="+h+", width="+w+",top=50,scrollbars=yes, resizable=yes";
		window.open(path,"asdf",prop);
	}
	function toPreDeal() {
		try{
			parent.removeTab("predeal");
		}
		catch( e){
		}
		parent.addTab(true,'predeal','投诉预处理',"http://10.110.0.206:28001/predeal/workflow/common/cspAuth.jsp?phone_no=<%=phone_no%>&login_no=<%=iLoginNo%>&password=<%=iLoginPwd%>&regionCode=<%=regionCode%>&callSkill=<%=callSkill%>&custName=<%=cust_name%>&belong_code=<%=belong_code%>");
	}
	function toSopCar(){
		//hejwa 2012年8月27日 判断购物车 是否存在
		var D = parent.parent.document.getElementById("tabtag").getElementsByTagName("li");
		for(var $=0;$<D.length;$++){
			if("custid" == D[$].id.substr(0,6)){//存在一个购物车，关掉现有购物车
				parent.parent.removeTab(D[$].id);
				break;
			}
		}
		addTabBySearchCustName("<%=phone_no%>",'1');
	}

	function resetThis(){
		location = location ;
	}
	function getFeeInfo(){
		var path = "showFeeInfo.jsp?custName="+document.all.custName.value+"&phoneNo=<%=phone_no%>";
		var h = 520;
		var w = 450;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="height="+h+", width="+w+",top=50,scrollbars=yes, resizable=yes";
		window.open(path,"",prop);
	}
	function showIntegralInfo(){
		/*update by tangsong 20121022 积分信息与营业保持一致
		var path = "showDnMarkMsg.jsp?phoneNo=<%=phone_no%>&idNo=<%=custId_g%>";
		*/
		var path = '/npage/query/f1500_dMarkMsg.jsp?fromKF=Y&idNo=<%=custId_g%>&custName=<%=cust_name%>&phoneNo=<%=phone_no%>'
						+ '&workNo=<%=iLoginNo%>&workName=<%=session.getAttribute("workName")%>';
		var h = 550;
		var w = 850;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="height="+h+", width="+w+",top=50,scrollbars=yes, resizable=yes";
		var handle = window.open(path,"",prop);
	}
	function dBillCustDetail(){
		var path = "showCustBillDet.jsp?idNo=<%=custId_g%>&custName="+document.all.custName.value;
		document.getElementById("iFrame1").src = path;
		document.all.showCustWTab.style.display="";
	}

	//add by chenhr,20100525,用户将客户挽留放入用户呼入信息页面中
	function kehuwanliu(){
		var contactId="<%=contactId%>";
		var userPhone="<%=phone_no%>";
		var path = "../callbosspage/customerDetain/customerDetain.jsp"+"?contactId="+contactId+"&userPhone="+userPhone;
		var h = 450;
		var w = 650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="height="+h+", width="+w+",top=50,scrollbars=yes, resizable=yes";
		window.open(path,"",prop);
	}
	function msgBlackName(){
		var phoneNoY="<%=phone_no%>";
		var kfcaller="<%=kfcaller%>";
		var contactId="<%=contactId%>";
		var iLoginNo="<%=iLoginNo%>";
		var path="msgBlackName.jsp?phoneNoY=<%=phone_no%>&kfcaller=<%=kfcaller%>&contactId=<%=contactId%>";
		var h = 300;
		var w = 500;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; ";
		window.showModalDialog(path,window.top,prop);
	}
	function showSimHis(){
		/*updated by tangsong 20101229
		var path = "dCustSimHis.jsp?phoneNo=<%=phone_no%>&simNo="+document.all.custSimNo.value.trim();
		var h = 420;
		var w = 750;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="height="+h+", width="+w+",top=50,scrollbars=yes, resizable=yes";
		window.open(path,"",prop);
		*/
		var path = "dCustSimHis.jsp?phoneNo=<%=phone_no%>&kfcaller=<%=kfcaller%>&contactId=<%=contactId%>&simNo="+document.all.custSimNo.value.trim();
		document.getElementById("iFrame1").src = path;
 		document.all.showCustWTab.style.display="";
 		document.getElementById("iFrame1").style.width = "750px";
		document.getElementById("iFrame1").style.height = "350px";
	}

	function showDetCusLev(){
		var path = "showDetCusLev.jsp?phoneNo=<%=phone_no%>&idno=<%=custId_g%>&contactid=<%=contactId%>&kfcaller=<%=kfcaller%>"+"&custName="+document.all.custName.value+"&custTypev="+document.all.custTypev.value;
		var h = 420;
		var w = 750;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="height="+h+", width="+w+",top=50,scrollbars=yes, resizable=yes";
		window.open(path,"",prop);
	}
	// update by wench 20111103 费用冲销明细下线
	/*
	function showCXDetail(){
		//xl 参数应该是不对的
		var path = "showCXDetail.jsp?phoneNo=<%=phone_no%>&idno=<%=custId_g%>"+"&custName="+document.all.custName.value+"&custTypev="+document.all.custTypev.value;
		document.getElementById("iFrame1").src = path;
		document.all.showCustWTab.style.display="";
	}
	*/ 
	function showYHDetail(){
		//xl 参数应该是不对的
		var path = "queryYHDetail.jsp?phoneNo=<%=phone_no%>&idno=<%=custId_g%>"+"&custTypev="+document.all.custTypev.value;
		document.getElementById("iFrame1").src = path;
		document.all.showCustWTab.style.display="";
	}
	//xl add showGf	
	function showGf(){
		//xl 参数应该是不对的
		var path = "showGf.jsp?phoneNo=<%=phone_no%>&idno=<%=custId_g%>"+"&custTypev="+document.all.custTypev.value;
		document.getElementById("iFrame1").src = path;
		document.all.showCustWTab.style.display="";
	}	
	function showZDDetail(){
		//xl 参数应该是不对的 phoneNo
		var path = "s1300UnbillDetail.jsp?phone_no=<%=phone_no%>&idno=<%=custId_g%>"+"&custName="+document.all.custName.value+"&custTypev="+document.all.custTypev.value;
		document.getElementById("iFrame1").src = path;
		document.all.showCustWTab.style.display="";
		// 3479 历史详单 把查询条件放在s1300UnbillDetail.jsp下
 	}
	//缴费信息查询
	function queryJFXX(){
		//xl 参数应该是不对的
		var path = "queryJFXX.jsp?phoneNo=<%=phone_no%>&idno=<%=custId_g%>"+"&custTypev="+document.all.custTypev.value;
		//alert(path);
		document.getElementById("iFrame1").src = path;
		document.all.showCustWTab.style.display="";
	}
	// 查询 预存分类信息
	function queryYCXX(){
		var path = "showYCXX.jsp?phoneNo=<%=phone_no%>&contractNo=<%=contract_no%>";
		//alert(path);
		document.getElementById("iFrame1").src = path;
		document.all.showCustWTab.style.display="";
	}
	// 20110314 xl tancf增加优惠信息查询
	function queryFav(){
		var path = "queryFav.jsp?phoneNo=<%=phone_no%>";
		//alert(path);
		document.getElementById("iFrame1").src = path;
		document.all.showCustWTab.style.display="";
	}
	function disShow(){
		document.all.showCustWTab.style.display="none";
	}
	function empOpr() {
		/**
		 try{
			parent.removeTab("1507");
		}
		catch( e){
		}
		parent.addTab(true,'1507','营业员操作查询','../query/f1507_1.jsp?phoneNoCall=<%=phone_no%>');
		**/
		var path = "f1507_1.jsp?phoneNoCall=<%=phone_no%>";
		document.getElementById("iFrame1").src = path;
 		document.all.showCustWTab.style.display="";
	}
	function proOpenInfo(){
		var path = "fserviceMsg.jsp?activePhone=<%=phone_no%>&idno=<%=custId_g%>"+"&custName="+document.all.custName.value+"&custTypev="+document.all.custTypev.value;
		document.getElementById("iFrame1").src = path;
 		document.all.showCustWTab.style.display="";
	}
	var callPhone = "";
	function sendMesg(){
		if(parent.parent.current_CurState !=5){
				rdShowMessageDialog("非接续状态，不能发送!",0);
				return;
		}
		//alert("parent.parent.activephone_ps.value|"+parent.parent.activephone_ps.value);
		var caller_phone1 = parent.parent.cCcommonTool.getCaller();
		if(parent.parent.cCcommonTool.getOp_code()=="K025"){
			callPhone = parent.parent.cCcommonTool.getCalled();
		}else{
			callPhone = caller_phone1;
		}
		callPhone = callPhone.trim();
		if(callPhone==""||callPhone=="045110086"||callPhone=="10086"){
			callPhone = "<%=phone_no%>";
		}
		var packet = new AJAXPacket("ajaxSendMsg.jsp","请稍后...");
		packet.data.add("phone_no" ,callPhone);
		packet.data.add("msgText" ,document.getElementById("custTcMc").innerText);
		packet.data.add("contactId","<%=contactId%>");
		packet.data.add("kfcaller","<%=kfcaller%>");
		packet.data.add("usercity","<%="".equals(belong_code)?"":belong_code.substring(0,2)%>");
		packet.data.add("acceptType","5");//短信发送的受理方式为套餐信息发送
	 	core.ajax.sendPacket(packet,doSendMesg);
		packet =null;
	}
	function doSendMesg(packet){
		var code = packet.data.findValueByName("code");
		var msg = packet.data.findValueByName("msg");
		if(code!="000000"){
			rdShowMessageDialog("向"+callPhone+"发送短信错误，"+code+":"+msg,0);
		}else{
			rdShowMessageDialog("向"+callPhone+"发送短信成功",2);
		}
	}
	function ShowDearLongTele(){//亲情长话 hejwa add 2010年11月24日16:53:07
		var path = "showDearLongTele.jsp?phoneNo=<%=phone_no%>&idno=<%=custId_g%>"+"&custName="+document.all.custName.value+"&custTypev="+document.all.custTypev.value;
		var h = 520;
		var w = 750;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="height="+h+", width="+w+",top=50,scrollbars=yes, resizable=yes";
		window.open(path,"",prop);
	}
	function toSCQry(){
	var path = "../callbosspage/common/showSCQry.jsp?phone_no=<%=phone_no%>";
	document.getElementById("iFrame1").src = path;
 	document.all.showCustWTab.style.display="";	
 	
}
	function unionPay()
	{
		//alert("1");
		try{
			parent.removeTab("1500");
		}
		catch( e){
		}
		parent.addTab(true,'1500','合帐分享信息查询','../bill/f7327Kf.jsp?phoneNo='+"<%=phone_no%>");
	}

	function chgCls(bt){ 
		$(bt).parent().find("input").removeClass("b_text");
		$(bt).parent().find("input").removeClass("btn");
		$(bt).parent().find("input").addClass("b_text");
		$(bt).addClass("btn");
		$("#hisDetail").empty();
	}
	//added by tangsong 20101228 改变长度、宽度
	function chgStyle(fWidth,fHeight) {
		document.getElementById("showCustWTab").style.width = (fWidth + 10) + "px";
		document.getElementById("iFrame1").style.width = fWidth + "px";
		document.getElementById("iFrame1").style.height = fHeight + "px";
	}
	//added by tangsong 20101228 恢复默认长度、宽度
	function resumeStyle() {
		document.getElementById("showCustWTab").style.width = "760px";
		document.getElementById("iFrame1").style.width = "750px";
		document.getElementById("iFrame1").style.height = "350px";
	}


//add by tangsong 20121019 begin
//服务积压等情况会导致用户信息页不刷新，
//点击所有按钮时都判断用户号码与当前受理号码是否一致，不一致则提醒话务员
$(document).ready(function() {
	$("input[type='button']").click(function() {
		//非通话状态不做提醒
		if(!(window.top.current_CurState==5||window.top.current_CurState==4)){
			return;
		}
		//非自动刷新用户信息页时不做提醒
		if ("<%=enterTypeAll%>" != "kf") {
			return;
		}
		//他机密码验证后自动刷新用户信息页时不做提醒
		if ("<%=checkPwdOth%>" == "1") {
			return;
		}
		var callerPhoneNo;
		if (window.top.outCallFlag == 0) {
			callerPhoneNo = window.top.cCcommonTool.getCaller();
		} else {
			callerPhoneNo = window.top.cCcommonTool.getCalled();
		}
		if (callerPhoneNo != "<%=phone_no%>") {
			window.top.cCcommonTool.DebugLog("javascript 提示话务员主叫与受理不一致 begin");
			rdShowMessageDialog("请注意，受理号码与当前主叫号码不一致，请确认号码是否正确！");
			window.top.cCcommonTool.DebugLog("javascript 提示话务员主叫与受理不一致 end");
		}
	});
});
//add by tangsong 20121019 end

window.onload = function(){
	var mainWin = window.top;
	//add wanghong 为不良骚扰和聊天骚扰赋值
	mainWin.document.getElementById("blUserNum").innerHTML="<%=BLUserNum%>";
	//added by hucw 20110413,根据状态设置错误专席接入按钮是否可以点击
	var caller = "";
	if(mainWin.cCcommonTool.getOp_code()=="K025"){    
	   caller = mainWin.cCcommonTool.getCalled();
	}else{    
	   caller = mainWin.cCcommonTool.getCaller();
	}
	if(caller == "<%=phone_no%>" && mainWin.current_CurState == 5){
		document.getElementById("errorTransfer").disabled=false;
	}else{
		document.getElementById("errorTransfer").disabled=true;
	}
	
	//updated by tangsong 20101221 输入框文字垂直居中
	$("input[type='text']").attr("style","line-height:16px;");
	if ($("#nowCondition").val() != "正常") {
		$("#nowCondition").addClass("orange");
	   }
	//added by tangsong 20101228 修改部分输入框长度
	document.getElementById("custGs").style.width = "100px";
	document.getElementById("payType").style.width = "100px";
	document.getElementById("custXyz").style.width = "100px";
	document.getElementById("originalCondition").style.width = "100px";
	document.getElementById("custTypev").style.width = "60px";
	document.getElementById("bigCustomerSymbol").style.width = "100px";
	
	//added by tangsong 20110302 默认打开2小时ivr转接日志
	$("#2hIvrLog").click();
	mainWin.document.getElementById("ispmsuser1").value="<%=ispmsuser%>";
	mainWin=null;
}
function to1930Func(){
	var path = "f1930_info.jsp?activePhone=<%=phone_no%>";
	document.getElementById("iFrame1").src = path;
 	document.all.showCustWTab.style.display="";
}	

function to9127Func(){
  var path = "queryf9127_1.jsp?phoneNo=<%=phone_no%>";
	document.getElementById("iFrame1").src = path;
 	document.all.showCustWTab.style.display="";
}

function to1500_1Func(){
	var path = "f1500_dBillCustDetail.jsp?phone_no=<%=phone_no%>&idNo=<%=custId_g%>&contactId=<%=contactId%>&kfcaller=<%=kfcaller%>";
	document.getElementById("iFrame1").src = path;
 	document.all.showCustWTab.style.display="";	
}

function info2Ivr(){
	/*var path = "../callbosspage/common/ivrAndComplaint.jsp?caller=<%=phone_no%>";*/
	var path = "../callbosspage/common/info2ivr.jsp?phoneNo=<%=phone_no%>";
	//var params = "height=1000,width=100%,status=yes,toolbar=no,menubar=no,location=no,resizable=yes";
	document.getElementById("iFrame1").src = path;
	//window.open(path,"iFrame1",params);
	document.all.showCustWTab.style.display="";
	/*var caller = "<%=phone_no%>";
	var params = "height=600,width=600,status=yes,toolbar=no,menubar=no,location=no,resizable=yes";
	document.getElementById("iFrame1").src = path;
	window.open(path+"?caller="+caller,null,params);*/
}
//梦网业务功能激活 update by liuhaoa 20120725
function toMWSInfo(){
	var path = "MWYW_Info.jsp?caller=<%=phone_no%>";
	var params = "height=1000,width=100%,status=yes,toolbar=no,menubar=no,location=no,resizable=yes"
	window.open(path,"iFrame1",params);
	document.all.showCustWTab.style.display="";
}
/*集团专线工单查询 update  by sunbya 20120313*/
function queryJTZX(){
	//alert("集团专线工单查询");  
	var path = "JTZX_callInfoQry.jsp?phoneNo=<%=phone_no%>";
	document.getElementById("iFrame1").src = path;
 	document.all.showCustWTab.style.display="";
}

function toOnlineCase() {
	var path = "../callbosspage/common/showOnlineCase.jsp?phone_no=<%=phone_no%>";
	var params = "height=600,width=100%,status=yes,toolbar=no,menubar=no,location=no,resizable=yes"
	window.open(path,"iFrame1",params);
	document.all.showCustWTab.style.display="";
}

function toTF(){
	if(parent.parent.current_CurState !=5){
		rdShowMessageDialog("非接续状态，不能办理!",0);
		return;
	}
	var custId = "<%=custIdArr%>";
	custId="custid"+custId;
	//alert(custId);
	parent.ajaxGetSession(custId);
	//alert("标志位::"+parent.phone_kf_flag);
	//alert("号码::"+parent.phone_kf_check);
	if(parent.phone_kf_check==custId&&parent.phone_kf_flag=="1"){
		var path = "speinfo.jsp?phone_no=<%=phone_no%>&idNo=<%=custId_g%>&iLoginNo=<%=iLoginNo%>&iLoginPwd=<%=iLoginPwd%>&sm_code=<%=sm_code%>&belong_code=<%=belong_code%>";
		document.getElementById("iFrame1").src = path;
	 	document.all.showCustWTab.style.display="";
	} else{
		acceptPNo = parent.parent.document.getElementById("acceptPhoneNo").value;
		var path = "../../npage/public/publicValidate_kf.jsp";
		path =  path + "?valideVal="   + "";
		path =  path + "&titleName="   + "";
		path =  path + "&activePhone=" + acceptPNo;
		path =  path + "&opCode=" + ""+"&opeFlag=1";
		path =  path + "&acceptPNo=" + acceptPNo;

		var h = 250;
		var w = 450; 
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		//var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; ";
		window.parent.openTFFlag = 1; //在进入IVR之前将标志位置成1
		var validateResult = window.showModalDialog(path,parent.parent.window,prop);
	  //parent.ajaxGetSessionTF(acceptNo);
	  //parent.addTabBySearchCustName(acceptNo,"addLink");
 		//return ;	
	}
}

function doToTF() {
	var path = "speinfo.jsp?phone_no=<%=phone_no%>&idNo=<%=custId_g%>&iLoginNo=<%=iLoginNo%>&iLoginPwd=<%=iLoginPwd%>&sm_code=<%=sm_code%>&belong_code=<%=belong_code%>";
	document.getElementById("iFrame1").src = path;
 	document.all.showCustWTab.style.display="";	
}

function toFestGreetSet()
{
	var path = "./KXXX_callMsgQry.jsp";
        var params = "height=400,width=800,status=no,toolbar=no,menubar=no,location=no,resizable=yes";
	window.open(path,"",params);

}
function toTSDetail(){
		var path = "../callbosspage/common/pms_complain_more.jsp?phoneNo=<%=phone_no%>";
		document.getElementById("iFrame1").src = path;
 		document.all.showCustWTab.style.display="";
	}
	
function toDXYYTDetail(){
	if(parent.parent.current_CurState !=5){
				rdShowMessageDialog("非接续状态，不能查询!",0);
				return;
		}
	var path = "./DTLogInfo.jsp?phoneNo=<%=phone_no%>";
	document.getElementById("iFrame1").src = path;
 	document.all.showCustWTab.style.display="";
}
function toTest()
{
	var path = "test.jsp?phoneNo=<%=phone_no%>";
	document.getElementById("iFrame1").src = path;
 	document.all.showCustWTab.style.display="";
}
/*
*@function:设置错误手机号码
*/
function setErrorTransfer(){
	var mainWin = window.top;
	var caller = "";
	if(mainWin.cCcommonTool.getOp_code()=="K025"){    
	   caller = mainWin.cCcommonTool.getCalled();
	}else{    
	   caller = mainWin.cCcommonTool.getCaller();
	}
	var transType = "99";
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K029/callTransferUpdate.jsp","正在处理,请稍后...");
	packet.data.add("TRANSFER_TYPE",transType);
	packet.data.add("CALLER",caller);
	core.ajax.sendPacket(packet,function(packet){
		var retCode = packet.data.findValueByName("retCode");
		var count = packet.data.findValueByName("count");
		if(retCode == "000000"){
			if(count == 0){
				rdShowMessageDialog("不是转人工专席接入到系统的电话!");
				return;
			}
			rdShowMessageDialog("设置成功!");
		}
	},true);
	mainWin = null;
	packet = null;
}

function ztoChgInfo() {
	var path = "f1500_wChgQry.jsp?idNo=<%=custId_g%>&phoneNo=<%=phone_no%>&iLoginPwd=<%=iLoginPwd%>&workNo=<%=iLoginNo%>&beginTime=0&endTime=0";
	document.getElementById("iFrame1").src = path;
 	document.all.showCustWTab.style.display="";
}

function showConMsg() {
	var path = "f1500_dConMsg.jsp?phoneNo=<%=phone_no%>";
	var h = 420;
	var w = 680;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="height="+h+", width="+w+",top=150,left=380,scrollbars=yes, resizable=yes";
	window.open(path,"",prop);
}
function showOpenMakMsg(){
	var path = "f1500_dCustInnet_kf.jsp?phoneNo=<%=phone_no%>";
	var h = 420;
	var w = 680;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="height="+h+", width="+w+",top=150,left=380,scrollbars=yes, resizable=yes";
	window.open(path,"",prop);	
}

//add by tangsong 20120719
//控制用户信息页最多只有一个滚动条(iframe的onload事件)
//只需将嵌入的页面名称加入到pageArr数组中即可实现
//begin
function loadFrame() {
	//需进行iframe样式处理的页面
	var pageArr = ["s1300UnbillDetail.jsp","MWYW_Info.jsp","f1500_wChgQry.jsp",
	"queryf9127_1.jsp","queryJFXX.jsp","fserviceMsg.jsp","f1500_dCustFuncHis.jsp",
	"f1500_wChgQry.jsp","f1500_dBillCustDetail.jsp","f1500_dBillCustDetail_1.jsp",
	"info2ivr.jsp","f1930_info.jsp"];
	document.getElementById("iFrame1").style.width="920px";
	document.getElementById("iFrame1").style.height="500px";
	var _win = document.frames[0];
	var _doc = _win.document;
	var _src = _win.location.href;
	for (i = 0; i < pageArr.length; i++) {
		if (_src.indexOf(pageArr[i]) != -1) {
			//子页面的子页面加载完成时,修改子页面及本页面的iframe样式
			var _frames = _doc.getElementsByTagName("iframe");
			if (_frames && _frames.length > 0) {
				for (j = 0; j < _frames.length; j++) {
					_frames[j].attachEvent("onload", new Function("chSubFrameStyle("+j+")"));
				}
			} else {
				//子页面加载完成时,修改本页面(callCustInfo.jsp)的iframe样式
				chFrameStyle();
			}
			break;
		}
	}
}

function chFrameStyle() {
	var _win = document.frames[0];
	if (!_win) {
		return;
	}
	var _doc = _win.document;
	var _iframe = _win.parent.document.getElementsByTagName("iframe")[0];
	var _div = _iframe.parentNode;
	var newHeight = _doc.body.scrollHeight+20+"px";
	var newWidth = _doc.body.scrollWidth+"px";
	_div.style.height = newHeight;
	_div.style.width = newWidth;
	_iframe.style.height = newHeight;
	_iframe.style.width = newWidth;
}

function chSubFrameStyle(idx) {
	var _win = document.frames[0].document.frames[idx];
	if (!_win) {
		return;
	}
	var _doc = _win.document;
	var _iframe = _win.parent.document.getElementsByTagName("iframe")[idx];
	var _div = _iframe.parentNode;
	var newHeight = _doc.body.scrollHeight+20+"px";
	var newWidth = _doc.body.scrollWidth+"px";
	_div.style.height = newHeight;
	_div.style.width = newWidth;
	_iframe.style.height = newHeight;
	_iframe.style.width = newWidth;
	chFrameStyle();
}
//end
</script>
</head>

<style type="text/css">
	.btn {
		color: #AA33BB;
	}
</style>
<body style="width:96%">
<form method="post" name="form1">
<div id="Main">
	<div id="Operation_Title">
		<div class="icon"></div> 
	   <div id="custInfo">
	   	<span style="color:red">
	   		<%=phone_no%>
	   		<!--<%=nBflag%>
	   		<%=showJxStr%>--><%=showGdStr%><%=showInfo%><%=specialUsercontent%><%=g_sFestivalGreeting%>
	   		<%=isUpdateFee%>
	   		<input type="button" id="errorTransfer" class="b_text"  value="接入错误专席" onclick="setErrorTransfer();">
	  	</span>
	   </div>
	</div>

	<div id="Operation_Table">
		<table cellspacing="0">
			<tr>
				<td class="blue" width="10%" nowrap>客户名称</td>
				<td width="30%" nowrap>
					<input type="text" id="custName" name="custName" value="<%=cust_name%>" readOnly>
					<!--<input type="button" class="b_text" value="综合信息" onclick="toCustInfo();" >-->  
					<%
						if(ChannelIdentifier[0][0].equals("0")){
					%>
					<input type="button" class="b_text" value="主动营销" onclick="activeRecommend();" disabled="true" >
					<%
					}else{
					%>
					<input type="button" class="b_text" value="主动营销" onclick="activeRecommend();">
					<%}%>
		<!--			<input type="button" class="b_text" value="主动推荐" onclick="activeRecommend();"> -->
					<!--<input type="button" class="b_text" value="预处理" onclick="toPreDeal();" >-->
				</td>
				<td class="blue" width="10%" nowrap>证件类型</td>
				<td width="30%">
				<input type="text" id="idType" name="idType" value="<%=type_name%>" readOnly >&nbsp;
				<td class="blue" nowrap>证件号码</td>
				<td><input type="text" id="idNo" name="idNo" value="<%=id_iccid%>" readOnly >&nbsp;
					<input type="button" class="b_text" value="特服办理" onclick="toSopCar();"> 
				</td>
			</tr>
			<tr>
				<td class="blue" nowrap>客户品牌</td>
				<td>
					<input type="text" id="custPPv" name="custPPv" value="<%=sm_name%>" readOnly >
					<input type="button" class="b_text" value="亲情号码" onclick="ShowDearLongTele()">
				</td>
				<td class="blue" width="10%" nowrap>归属局</td>
				<td width="20%"><input type="text" id="custGs" name="custGs" value="<%=belong_name%>" readOnly />
				</td>
				<td class="blue">入网日期</td>
				<td>
					<input type="text" id="inDate" name="inDate" value="<%=open_time%>" readOnly >&nbsp; 
					<!--
					<input type="button" class="b_text" value="客户挽留" onclick="kehuwanliu();">
					-->
					<input type="button" class="b_text" value="入网信息" onclick="showOpenMakMsg();">
				</td>
			</tr>
			<tr>
				<!--
				<td class="blue" nowrap>客户限额</td>
				<td><input type="text" id="custXe" name="custXe" value="<%=limit_owe%>" readOnly ></td>
				-->
        <!-- 客户信誉度： credit_value 改为 limit_owe   tangxlc 2011-12-26  -->
				<td class="blue" nowrap>现状态</td>
				<td>
					<input type="text" id="nowCondition" name="nowCondition" value="<%=vRunCodeNewName%>" readOnly >
					<input class="b_text" type=button value="话费余额" onClick="getFeeInfo()">
					</td>
				<td class="blue" nowrap>原状态</td>
				<td><input type="text" id="originalCondition" name="originalCondition" value="<%=vRunCodeOldName%>" readOnly >
					<input  type="button" class="b_text" value="短信黑名单" onclick="msgBlackName()"><input  type="button" class="b_text" value="强关操作" onclick="clickopr()">
				</td>
				<td class="blue" nowrap>状态修改时间</td>
				<td ><input type="text" id="" name="" value="<%=updStaDate%>" readOnly >&nbsp;
				<input class="b_text" type=button value="积分信息" onClick="showIntegralInfo()"> 
				</td>
			</tr>
			<tr>
				<td class="blue" nowrap>大客户标识</td>
				<td><input type="text" class="<%=clsName1%>" id="bigCustomerSymbol" name="bigCustomerSymbol" value="<%=bigCustomerSymbol%>" readOnly >
						<input type="hidden" id="custTypev" name="custTypev" value="<%=grade_name%>" >
						<input type="button" class="b_text" value="详情" onclick="showDetCusLev()">	
				</td>
				<td class="blue" nowrap>实名状态</td>
				<td ><input type="text" id="realNameState" name="realNameState" value="<%=isrealName%>" readOnly ></td>	
				<td class="blue" style="color:#F00"   nowrap>中高端标识</td>
				<td>
					<!--
					<input type="text" id="concPhone" name="concPhone" value="<%=contact_phone%>" readOnly >
					-->
					<input type="text" id="MidHighPhone" class="redcolor"  name="MidHighPhone" value="<%=strMidHighFlag%>"  readyOnly>&nbsp;
					<input type="button" class="b_text" value="合帐分享" onclick="unionPay()">
			</tr>
			<tr>
				<!--update by wench 20111104 下移
				<td class="blue" nowrap>sim卡号</td>
				<td><input type="text" id="custSimNo" name="custSimNo" value="<%=sim_no%>" readOnly ></td>
				-->
				<td class="blue" nowrap>客户信誉度值</td>
				<td><input type="text" id="custXyz" name="custXyz" value="<%=limit_owe%>" readOnly >
				</td>
				<td class="blue" nowrap>付费方式</td>
				<td><input type="text" id="payType" name="payType" value="<%=pay_name%>" readOnly >
				<input type="button" class="b_text" value="托收信息" onclick="showConMsg();">
				</td>
				<!--uodate by wench 20111104 联系电话下线 中高档标识上线
				<td class="blue" nowrap>联系电话</td>
				-->
				<td class="blue" nowrap>SIM卡号</td>
				<td><input type="text" id="custSimNo" name="custSimNo" value="<%=sim_no%>" readOnly ></td>
			  </tr>
			<tr>
				<td class="blue" nowrap>主动推荐标识</td>
				<%
					String marketChannel = "";
					if(ChannelIdentifier[0][0].equals("0")){
						marketChannel = "否";
					}else{
						marketChannel = "是";
					}
				%>
				<td><input name="marketChannel" id="marketChannel" type="text" value="<%=marketChannel%>" readOnly/></td>
				<!-- update bu wench 20111104上移
				<td class="blue" nowrap>大客户标志</td>
				<td><input type="text" class="<%=clsName1%>" id="bigCustomerSymbol" name="bigCustomerSymbol" value="<%=bigCustomerSymbol%>" readOnly ></td>				
				<td class="blue" nowrap>证件号码</td>
				<td><input type="text" id="idNo" name="idNo" value="<%=id_iccid%>" readOnly ></td>
				-->
				<!--add by sunbya 20120401-->
				<td class="blue" nowrap>社会渠道标识</td>
				<td ><input type="text" id="TociInfo" name="TociInfo" value="<%=isChnInfoFlag%>" readOnly ></td>
			  <td class="blue" nowrap>电话经理标识</td>
				<td><input type="text" id="PhoneManager" name="PhoneManager" value="<%=ispmsuser%>" readOnly ></td>
    	 </tr>
				<tr>
				<td class="blue" nowrap>呼叫技能</td>
				<td><input type="text" id="d" name="callSkill" value="<%=callSkill%>" readOnly ></td> 	
                           	<!--add by sunbya 20120401-->
				<td class="blue" nowrap >套餐代码</td>
				<td colspan="3"><input type="text" id="custTcDm" name="custTcDm" value="<%=mode_code%>" readOnly ></td>
				
			</tr>
			<tr>
				<td class="blue" nowrap>套餐名称</td>
				<td colspan="5">
					<textarea cols="85" rows="6" id="custTcMc" name="custTcMc" readOnly><%=mode_note%></textarea>
					<input class="b_text" style="margin-bottom:30px;" type=button value="发送短信" onClick="sendMesg()">
				</td>
			</tr>
			<tr>
				<td colspan="6" align="left">
					<input type="button" class="b_text" value="月费分摊" onClick="chgCls(this),dBillCustDetail()" />
					<input type="button" class="b_text" value="账单查询"  onclick="chgCls(this),showZDDetail()" />
					<input type="button" class="b_text" value="交费信息" onclick="chgCls(this),queryJFXX()" />
					<input type="button" class="b_text" value="详细优惠信息" onclick="chgCls(this),to1500_1Func()" />					
					<!--
					<input type="button" class="b_text" value="费用冲销明细" onclick="chgCls(this),showCXDetail()" />
					-->
					<input type="button" class="b_text" value="历史优惠信息" onclick="chgCls(this),showYHDetail()" />
					<input type="button" class="b_text" value="特服开通信息" onclick="chgCls(this),proOpenInfo()" />					
					<input type="button" class="b_text" value="预存分类信息" onclick="chgCls(this),queryYCXX()" />
					<input type="button" class="b_text" value="套餐优惠信息" onclick="chgCls(this),queryFav()" /><br>
					<input type="button" class="b_text" id="2hIvrLog" value="用户操作日志查询" onclick="chgCls(this),info2Ivr()"/>
					<input type="button" class="b_text" value="统一查询退订" onclick="chgCls(this),to1930Func()" />
					<input type="button" class="b_text" value="SP及自有业务使用查询" onclick="chgCls(this),to9127Func()" />						
					<input type="button" class="b_text" value="营业员操作" onclick="chgCls(this),empOpr()" />
					<input type="button" class="b_text" value="变更记录信息" onclick="chgCls(this),ztoChgInfo()" />
					<input type="button" class="b_text" value="密码延时重置查询" onclick="chgCls(this),toSCQry()"/>					
					<input type="button" class="b_text" value="SIM卡变更信息" onclick="chgCls(this),showSimHis()" />																			
					<input type="button" class="b_text" value="特服办理" onclick="chgCls(this),toTF()"/>					
					<input type="button" class="b_text" value="GPRS套餐短信预约" onclick="sendGPRSMess()"/>
					<input type="button" class="b_text" value="短厅交互日志" onclick="chgCls(this),toDXYYTDetail()"/>
					<input type="button" class="b_text" value="投诉日志" onclick="chgCls(this),toTSDetail()"/>					
					<input type="button" class="b_text" value="在线跟进工单" onclick="chgCls(this),toOnlineCase()"/>					
					<input type="button" class="b_text" value="集团专线信息" onclick="chgCls(this),queryJTZX()"/>
					<input type="button" class="b_text" value="梦网业务激活" onclick="chgCls(this),toMWSInfo()" />
				</td>
			</tr>
		</table>
		<%@ include file="/npage/include/footer.jsp"%>
	</div>
</div>
</form>
<div id="showCustWTab" style="display:none;">
	<iframe name="iFrame1" id="iFrame1" src="" frameborder="0" style="width:99%;" onload="loadFrame()"></iframe>
</div>
<script type="text/javascript">

function sendGPRSMess(){
	//update by wench 20111103
	if(parent.parent.current_CurState !=5){
				rdShowMessageDialog("非接续状态，不能发送!",0);
				return;
		}
	if(rdShowConfirmDialog("确定预约吗?")==1){
	var Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/login/send_Gprs_mess_do.jsp","请稍后...");
	Packet.data.add("phone_no", '<%=phone_no%>');
	Packet.data.add("belong_code",'<%=belong_code%>');
	Packet.data.add("sm_code",'<%=sm_code%>');
	Packet.data.add("sm_name",'<%=sm_name%>');
	Packet.data.add("contactId","<%=contactId%>");
	Packet.data.add("kfcaller","<%=kfcaller%>");
	Packet.data.add("belong_name",'<%=belong_name%>');
	core.ajax.sendPacket(Packet,doProcess,false);
	Packet =null;	
}
}
function doProcess(packet){
	var ret = packet.data.findValueByName("ret");
	    	if(ret=="000000"){
	    		rdShowMessageDialog("预约成功!",'2');
	    	}else if (ret=="333333"){
	    		rdShowMessageDialog("该用户已经预约！");
	    	}else {
	    		rdShowMessageDialog("预约失败!");
	    	 }
}


	//居中打开窗口
  function openWinMid(url,name,iHeight,iWidth)
  {
  var iTop = (window.screen.availHeight-20-iHeight)/2; //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-5-iWidth)/2; //获得窗口的水平位置;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
  }
function clickopr(){
	 openWinMid('<%=request.getContextPath()%>/npage/se323/fe323_1.jsp?activePhone=<%=phone_no%>','强关操作查询',400,900); 
	}
</script>
</body>
</html>
