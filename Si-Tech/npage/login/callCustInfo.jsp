<%
/********************
 version v2.0
 ������ si-tech
 create hejwa@2009-4-20
 update hejwa@2010-11-30 ��sPubUserMsg ������sql�Ȳ�ѯ����ΪsPubUserMsgKF�����ѯ
 update tangsong@2010-12-28 �����Ű漰ҳ����ʽ����
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
<title>�ͻ���Ϣ</title>
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
	String kfcaller = request.getParameter("kfcaller");//����
	String enterTypeAll = request.getParameter("enterTypeAll");//�����ж��Ƿ�ϵͳ�Զ�ˢ���û���Ϣҳ
	String checkPwdOth = request.getParameter("checkPwdOth");//�����ж��Ƿ�����������֤��ˢ���û���Ϣҳ
	String gdSql = "select count(*) from t_sce_arpu120 where TELNO='"+phone_no+"'";
	String nBflag = ""; //һ�༪��ţ����༪��� update by songjia 20110601;
	/**��α���*/
	String iLoginAccept ="0";    //������ˮ
	String iChnSource ="1"; 	   //������ʶ
	String iOpCode  ="5556"; 	   //��������
	String iLoginNo =(String)session.getAttribute("workNo"); //��������
	String iLoginPwd =(String)session.getAttribute("password"); //��������
	String iPhoneNo =phone_no;    //�ֻ�����
	String iUserPwd ="";    //�û�����

  //�и߶��û���ʶ Add by tangxlc 2011-11-16  START 
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
      strMidHighFlag = "��";
  }
  else
  {
      strMidHighFlag = "��";
  } 
  //�и߶��û���ʶ END
  
	String specialUsercontent="";
 	List queryList =(List)KFEjbClient170.queryForList("findByPhone",phone_no);
	if (queryList != null) {                    
		for (int i = 0; i < queryList.size(); i++) {   
			Map map = (Map)queryList.get(i);       
      		specialUsercontent= map.get("CONTENT").toString(); 
		}
	}
	//add wanghong ��������ɧ�ţ�����ɧ��
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
	/**���α���*/

	String sRetCode =""; //���ش���
	String sRetMsg  =""; //��������
	String custId_g =""; //id_no
	String contract_no =""; //contract_no
	String sm_code  =""; //Ʒ�ƴ���
	String sm_name  =""; //Ʒ������
	String open_time =""; //����ʱ��
	String belong_code =""; //���д���
	String belong_name =""; //��������
	String limit_owe =""; //limit_owe
	String credit_value =""; //credit_value
	String originalCondition = "";  //ԭ״̬
	String vRunCodeOldName =""; //ԭ״̬����
	String nowCondition = "";  //��״̬
	String vRunCodeNewName =""; //ԭ״̬����
	String updStaDate = "";  //״̬�޸�ʱ��
	String cust_name =""; //�ͻ�����
	String owner_grade =""; //�û�����
	String grade_name =""; //��������
	String id_type  =""; //֤������
	String type_name =""; //֤������
	String id_iccid =""; //֤������
	String contact_phone =""; //contact_phone
	String pay_code =""; //pay_code
	String pay_name =""; //pay_name
	String sim_no =""; //SIM����
	String mode_code =""; //�ʷ�
	String mode_note =""; //�ʷ�����
	String gdFlag =""; //�߶˱�־
	String jxFlag =""; //��������־
	String bigCustomerSymbol = "";  //��ͻ���־
	String showInfo = "";
	String isUpdateFee="";//�Ƿ�����������ʷѵĻ��ʾ
	
	String ispmsuser="";//�Ƿ��ǵ绰�����û�
	String isrealName="";//�Ƿ���ʵ��״̬

	String clsName  = "orange";
	String clsName1 = "orange";
	String showJxStr = "";
	String showGdStr = "";
	String retCodeMs = "";
	String retMsgMs = "";
	String userMsgMs[][] =new String[][]{};
  String isChnInfoFlag="";//���������ʶ
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
	rdShowMessageDialog("���÷���sPubUserMsgKF����",0);
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
		sm_code  =userMsgMs[0][2] ; //Ʒ�ƴ���
		sm_name  =userMsgMs[0][3] ; //Ʒ������
		open_time =userMsgMs[0][4] ; //����ʱ��
		belong_code =userMsgMs[0][5] ; //���д���
		belong_name =userMsgMs[0][6] ; //��������
		limit_owe =userMsgMs[0][7] ; //limit_owe
		credit_value =userMsgMs[0][8] ; //credit_value
		originalCondition =userMsgMs[0][9] ; //ԭ״̬
		vRunCodeOldName =userMsgMs[0][10]; //ԭ״̬����
		nowCondition =userMsgMs[0][11]; //��״̬
		vRunCodeNewName =userMsgMs[0][12]; //��״̬����
		
		updStaDate =userMsgMs[0][13]; //״̬�޸�ʱ��
		cust_name =userMsgMs[0][14]; //�ͻ�����
		owner_grade =userMsgMs[0][15]; //�û�����
		grade_name =userMsgMs[0][16]; //��������
		id_type  =userMsgMs[0][17]; //֤������
		type_name =userMsgMs[0][18]; //֤������
		id_iccid =userMsgMs[0][19]; //֤������
		contact_phone =userMsgMs[0][20]; //contact_phone
		pay_code =userMsgMs[0][21]; //pay_code
		pay_name =userMsgMs[0][22]; //pay_name
		sim_no =userMsgMs[0][23]; //SIM����
		mode_code =userMsgMs[0][24]; //�ʷ�
		mode_note =userMsgMs[0][25]; //�ʷ�����
		jxFlag =userMsgMs[0][26]; //��������־
		bigCustomerSymbol =userMsgMs[0][27]; //��ͻ���־
		
		isUpdateFee = userMsgMs[0][29];
		ispmsuser =userMsgMs[0][31];
		isrealName=userMsgMs[0][30];
		isChnInfoFlag=userMsgMs[0][32];
		
System.out.println(isChnInfoFlag+"sunbya------------------------"+ispmsuser);
		if(vRunCodeNewName.trim().equals("����")){
			clsName = "";
		}
		if(bigCustomerSymbol.trim().equals("�Ǵ�ͻ�")){
			clsName1 = "";
		}
		if(jxFlag.equals("1")) showJxStr = "�˺���["+phone_no+"]Ϊ�������";
		if(gdFlag.equals("1")) showGdStr = "���û�["+phone_no+"]Ϊ�߶��û�";
		if(jxFlag.equals("1")&&gdFlag.equals("1")) showJxStr = showJxStr+"��";
		if(originalCondition.toUpperCase().equals("NULL")) originalCondition = "";
		if(nowCondition.toUpperCase().equals("NULL")) nowCondition = "";
		if(bigCustomerSymbol.toUpperCase().equals("NULL")) bigCustomerSymbol = "";
		if(updStaDate.toUpperCase().equals("NULL")) updStaDate = "";
		
		//�жϼ�����룺һ����롢������� 20110601 update by songjia 
		String p5 = phone_no.substring(6);
		//һ�༪���
		Pattern pattern = Pattern.compile("([0-9])\\1{4}|[0-9]([0-9])\\2{3}|01234|12345|23456|34567|45678|56789|67890");
		Matcher matcher = pattern.matcher(p5);
	    if(!matcher.matches()){
	    //���༪���
			Pattern pattern2 = Pattern.compile("[0-9][0-9]([0-9])\\1{2}|[0-9]00[0-1][0-9]|[0-9]0020|\\d0123|\\d1234|\\d2345|\\d3456|\\d4567|\\d5678|\\d6789|\\d7890");
			matcher= pattern2.matcher(p5);
			if(matcher.matches()){
				nBflag="(�������)";
			}
	  }else{
	  		nBflag="(һ�����)";
	  	}
	}else{
		showInfo = "�޴˿ͻ�����";
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
//update liuhaoa ����F5����ϵͳ�˳�
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
				var path="selectCustId.jsp?opName=ѡ��ͻ�&custIdArr="+custIdArr+"&custNameArr="+custNameArr+"&custIccid="+custIccidJ+"&custCtime="+custCtimeJ;
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
		parent.addTab(true,'1500','�ۺ���Ϣ��ѯ','../query/f1500_2.jsp?QueryType=0&condText='+"<%=phone_no%>");
	}
	function activeRecommend(){
		if(parent.parent.current_CurState !=5){
			rdShowMessageDialog("�ǽ���״̬�����ܵ��!",0);
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
		parent.addTab(true,'predeal','Ͷ��Ԥ����',"http://10.110.0.206:28001/predeal/workflow/common/cspAuth.jsp?phone_no=<%=phone_no%>&login_no=<%=iLoginNo%>&password=<%=iLoginPwd%>&regionCode=<%=regionCode%>&callSkill=<%=callSkill%>&custName=<%=cust_name%>&belong_code=<%=belong_code%>");
	}
	function toSopCar(){
		//hejwa 2012��8��27�� �жϹ��ﳵ �Ƿ����
		var D = parent.parent.document.getElementById("tabtag").getElementsByTagName("li");
		for(var $=0;$<D.length;$++){
			if("custid" == D[$].id.substr(0,6)){//����һ�����ﳵ���ص����й��ﳵ
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
		/*update by tangsong 20121022 ������Ϣ��Ӫҵ����һ��
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

	//add by chenhr,20100525,�û����ͻ����������û�������Ϣҳ����
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
	// update by wench 20111103 ���ó�����ϸ����
	/*
	function showCXDetail(){
		//xl ����Ӧ���ǲ��Ե�
		var path = "showCXDetail.jsp?phoneNo=<%=phone_no%>&idno=<%=custId_g%>"+"&custName="+document.all.custName.value+"&custTypev="+document.all.custTypev.value;
		document.getElementById("iFrame1").src = path;
		document.all.showCustWTab.style.display="";
	}
	*/ 
	function showYHDetail(){
		//xl ����Ӧ���ǲ��Ե�
		var path = "queryYHDetail.jsp?phoneNo=<%=phone_no%>&idno=<%=custId_g%>"+"&custTypev="+document.all.custTypev.value;
		document.getElementById("iFrame1").src = path;
		document.all.showCustWTab.style.display="";
	}
	//xl add showGf	
	function showGf(){
		//xl ����Ӧ���ǲ��Ե�
		var path = "showGf.jsp?phoneNo=<%=phone_no%>&idno=<%=custId_g%>"+"&custTypev="+document.all.custTypev.value;
		document.getElementById("iFrame1").src = path;
		document.all.showCustWTab.style.display="";
	}	
	function showZDDetail(){
		//xl ����Ӧ���ǲ��Ե� phoneNo
		var path = "s1300UnbillDetail.jsp?phone_no=<%=phone_no%>&idno=<%=custId_g%>"+"&custName="+document.all.custName.value+"&custTypev="+document.all.custTypev.value;
		document.getElementById("iFrame1").src = path;
		document.all.showCustWTab.style.display="";
		// 3479 ��ʷ�굥 �Ѳ�ѯ��������s1300UnbillDetail.jsp��
 	}
	//�ɷ���Ϣ��ѯ
	function queryJFXX(){
		//xl ����Ӧ���ǲ��Ե�
		var path = "queryJFXX.jsp?phoneNo=<%=phone_no%>&idno=<%=custId_g%>"+"&custTypev="+document.all.custTypev.value;
		//alert(path);
		document.getElementById("iFrame1").src = path;
		document.all.showCustWTab.style.display="";
	}
	// ��ѯ Ԥ�������Ϣ
	function queryYCXX(){
		var path = "showYCXX.jsp?phoneNo=<%=phone_no%>&contractNo=<%=contract_no%>";
		//alert(path);
		document.getElementById("iFrame1").src = path;
		document.all.showCustWTab.style.display="";
	}
	// 20110314 xl tancf�����Ż���Ϣ��ѯ
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
		parent.addTab(true,'1507','ӪҵԱ������ѯ','../query/f1507_1.jsp?phoneNoCall=<%=phone_no%>');
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
				rdShowMessageDialog("�ǽ���״̬�����ܷ���!",0);
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
		var packet = new AJAXPacket("ajaxSendMsg.jsp","���Ժ�...");
		packet.data.add("phone_no" ,callPhone);
		packet.data.add("msgText" ,document.getElementById("custTcMc").innerText);
		packet.data.add("contactId","<%=contactId%>");
		packet.data.add("kfcaller","<%=kfcaller%>");
		packet.data.add("usercity","<%="".equals(belong_code)?"":belong_code.substring(0,2)%>");
		packet.data.add("acceptType","5");//���ŷ��͵�����ʽΪ�ײ���Ϣ����
	 	core.ajax.sendPacket(packet,doSendMesg);
		packet =null;
	}
	function doSendMesg(packet){
		var code = packet.data.findValueByName("code");
		var msg = packet.data.findValueByName("msg");
		if(code!="000000"){
			rdShowMessageDialog("��"+callPhone+"���Ͷ��Ŵ���"+code+":"+msg,0);
		}else{
			rdShowMessageDialog("��"+callPhone+"���Ͷ��ųɹ�",2);
		}
	}
	function ShowDearLongTele(){//���鳤�� hejwa add 2010��11��24��16:53:07
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
		parent.addTab(true,'1500','���ʷ�����Ϣ��ѯ','../bill/f7327Kf.jsp?phoneNo='+"<%=phone_no%>");
	}

	function chgCls(bt){ 
		$(bt).parent().find("input").removeClass("b_text");
		$(bt).parent().find("input").removeClass("btn");
		$(bt).parent().find("input").addClass("b_text");
		$(bt).addClass("btn");
		$("#hisDetail").empty();
	}
	//added by tangsong 20101228 �ı䳤�ȡ����
	function chgStyle(fWidth,fHeight) {
		document.getElementById("showCustWTab").style.width = (fWidth + 10) + "px";
		document.getElementById("iFrame1").style.width = fWidth + "px";
		document.getElementById("iFrame1").style.height = fHeight + "px";
	}
	//added by tangsong 20101228 �ָ�Ĭ�ϳ��ȡ����
	function resumeStyle() {
		document.getElementById("showCustWTab").style.width = "760px";
		document.getElementById("iFrame1").style.width = "750px";
		document.getElementById("iFrame1").style.height = "350px";
	}


//add by tangsong 20121019 begin
//�����ѹ������ᵼ���û���Ϣҳ��ˢ�£�
//������а�ťʱ���ж��û������뵱ǰ��������Ƿ�һ�£���һ�������ѻ���Ա
$(document).ready(function() {
	$("input[type='button']").click(function() {
		//��ͨ��״̬��������
		if(!(window.top.current_CurState==5||window.top.current_CurState==4)){
			return;
		}
		//���Զ�ˢ���û���Ϣҳʱ��������
		if ("<%=enterTypeAll%>" != "kf") {
			return;
		}
		//����������֤���Զ�ˢ���û���Ϣҳʱ��������
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
			window.top.cCcommonTool.DebugLog("javascript ��ʾ����Ա����������һ�� begin");
			rdShowMessageDialog("��ע�⣬��������뵱ǰ���к��벻һ�£���ȷ�Ϻ����Ƿ���ȷ��");
			window.top.cCcommonTool.DebugLog("javascript ��ʾ����Ա����������һ�� end");
		}
	});
});
//add by tangsong 20121019 end

window.onload = function(){
	var mainWin = window.top;
	//add wanghong Ϊ����ɧ�ź�����ɧ�Ÿ�ֵ
	mainWin.document.getElementById("blUserNum").innerHTML="<%=BLUserNum%>";
	//added by hucw 20110413,����״̬���ô���רϯ���밴ť�Ƿ���Ե��
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
	
	//updated by tangsong 20101221 ��������ִ�ֱ����
	$("input[type='text']").attr("style","line-height:16px;");
	if ($("#nowCondition").val() != "����") {
		$("#nowCondition").addClass("orange");
	   }
	//added by tangsong 20101228 �޸Ĳ�������򳤶�
	document.getElementById("custGs").style.width = "100px";
	document.getElementById("payType").style.width = "100px";
	document.getElementById("custXyz").style.width = "100px";
	document.getElementById("originalCondition").style.width = "100px";
	document.getElementById("custTypev").style.width = "60px";
	document.getElementById("bigCustomerSymbol").style.width = "100px";
	
	//added by tangsong 20110302 Ĭ�ϴ�2Сʱivrת����־
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
//����ҵ���ܼ��� update by liuhaoa 20120725
function toMWSInfo(){
	var path = "MWYW_Info.jsp?caller=<%=phone_no%>";
	var params = "height=1000,width=100%,status=yes,toolbar=no,menubar=no,location=no,resizable=yes"
	window.open(path,"iFrame1",params);
	document.all.showCustWTab.style.display="";
}
/*����ר�߹�����ѯ update  by sunbya 20120313*/
function queryJTZX(){
	//alert("����ר�߹�����ѯ");  
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
		rdShowMessageDialog("�ǽ���״̬�����ܰ���!",0);
		return;
	}
	var custId = "<%=custIdArr%>";
	custId="custid"+custId;
	//alert(custId);
	parent.ajaxGetSession(custId);
	//alert("��־λ::"+parent.phone_kf_flag);
	//alert("����::"+parent.phone_kf_check);
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
		window.parent.openTFFlag = 1; //�ڽ���IVR֮ǰ����־λ�ó�1
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
				rdShowMessageDialog("�ǽ���״̬�����ܲ�ѯ!",0);
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
*@function:���ô����ֻ�����
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
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K029/callTransferUpdate.jsp","���ڴ���,���Ժ�...");
	packet.data.add("TRANSFER_TYPE",transType);
	packet.data.add("CALLER",caller);
	core.ajax.sendPacket(packet,function(packet){
		var retCode = packet.data.findValueByName("retCode");
		var count = packet.data.findValueByName("count");
		if(retCode == "000000"){
			if(count == 0){
				rdShowMessageDialog("����ת�˹�רϯ���뵽ϵͳ�ĵ绰!");
				return;
			}
			rdShowMessageDialog("���óɹ�!");
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
//�����û���Ϣҳ���ֻ��һ��������(iframe��onload�¼�)
//ֻ�轫Ƕ���ҳ�����Ƽ��뵽pageArr�����м���ʵ��
//begin
function loadFrame() {
	//�����iframe��ʽ�����ҳ��
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
			//��ҳ�����ҳ��������ʱ,�޸���ҳ�漰��ҳ���iframe��ʽ
			var _frames = _doc.getElementsByTagName("iframe");
			if (_frames && _frames.length > 0) {
				for (j = 0; j < _frames.length; j++) {
					_frames[j].attachEvent("onload", new Function("chSubFrameStyle("+j+")"));
				}
			} else {
				//��ҳ��������ʱ,�޸ı�ҳ��(callCustInfo.jsp)��iframe��ʽ
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
	   		<input type="button" id="errorTransfer" class="b_text"  value="�������רϯ" onclick="setErrorTransfer();">
	  	</span>
	   </div>
	</div>

	<div id="Operation_Table">
		<table cellspacing="0">
			<tr>
				<td class="blue" width="10%" nowrap>�ͻ�����</td>
				<td width="30%" nowrap>
					<input type="text" id="custName" name="custName" value="<%=cust_name%>" readOnly>
					<!--<input type="button" class="b_text" value="�ۺ���Ϣ" onclick="toCustInfo();" >-->  
					<%
						if(ChannelIdentifier[0][0].equals("0")){
					%>
					<input type="button" class="b_text" value="����Ӫ��" onclick="activeRecommend();" disabled="true" >
					<%
					}else{
					%>
					<input type="button" class="b_text" value="����Ӫ��" onclick="activeRecommend();">
					<%}%>
		<!--			<input type="button" class="b_text" value="�����Ƽ�" onclick="activeRecommend();"> -->
					<!--<input type="button" class="b_text" value="Ԥ����" onclick="toPreDeal();" >-->
				</td>
				<td class="blue" width="10%" nowrap>֤������</td>
				<td width="30%">
				<input type="text" id="idType" name="idType" value="<%=type_name%>" readOnly >&nbsp;
				<td class="blue" nowrap>֤������</td>
				<td><input type="text" id="idNo" name="idNo" value="<%=id_iccid%>" readOnly >&nbsp;
					<input type="button" class="b_text" value="�ط�����" onclick="toSopCar();"> 
				</td>
			</tr>
			<tr>
				<td class="blue" nowrap>�ͻ�Ʒ��</td>
				<td>
					<input type="text" id="custPPv" name="custPPv" value="<%=sm_name%>" readOnly >
					<input type="button" class="b_text" value="�������" onclick="ShowDearLongTele()">
				</td>
				<td class="blue" width="10%" nowrap>������</td>
				<td width="20%"><input type="text" id="custGs" name="custGs" value="<%=belong_name%>" readOnly />
				</td>
				<td class="blue">��������</td>
				<td>
					<input type="text" id="inDate" name="inDate" value="<%=open_time%>" readOnly >&nbsp; 
					<!--
					<input type="button" class="b_text" value="�ͻ�����" onclick="kehuwanliu();">
					-->
					<input type="button" class="b_text" value="������Ϣ" onclick="showOpenMakMsg();">
				</td>
			</tr>
			<tr>
				<!--
				<td class="blue" nowrap>�ͻ��޶�</td>
				<td><input type="text" id="custXe" name="custXe" value="<%=limit_owe%>" readOnly ></td>
				-->
        <!-- �ͻ������ȣ� credit_value ��Ϊ limit_owe   tangxlc 2011-12-26  -->
				<td class="blue" nowrap>��״̬</td>
				<td>
					<input type="text" id="nowCondition" name="nowCondition" value="<%=vRunCodeNewName%>" readOnly >
					<input class="b_text" type=button value="�������" onClick="getFeeInfo()">
					</td>
				<td class="blue" nowrap>ԭ״̬</td>
				<td><input type="text" id="originalCondition" name="originalCondition" value="<%=vRunCodeOldName%>" readOnly >
					<input  type="button" class="b_text" value="���ź�����" onclick="msgBlackName()"><input  type="button" class="b_text" value="ǿ�ز���" onclick="clickopr()">
				</td>
				<td class="blue" nowrap>״̬�޸�ʱ��</td>
				<td ><input type="text" id="" name="" value="<%=updStaDate%>" readOnly >&nbsp;
				<input class="b_text" type=button value="������Ϣ" onClick="showIntegralInfo()"> 
				</td>
			</tr>
			<tr>
				<td class="blue" nowrap>��ͻ���ʶ</td>
				<td><input type="text" class="<%=clsName1%>" id="bigCustomerSymbol" name="bigCustomerSymbol" value="<%=bigCustomerSymbol%>" readOnly >
						<input type="hidden" id="custTypev" name="custTypev" value="<%=grade_name%>" >
						<input type="button" class="b_text" value="����" onclick="showDetCusLev()">	
				</td>
				<td class="blue" nowrap>ʵ��״̬</td>
				<td ><input type="text" id="realNameState" name="realNameState" value="<%=isrealName%>" readOnly ></td>	
				<td class="blue" style="color:#F00"   nowrap>�и߶˱�ʶ</td>
				<td>
					<!--
					<input type="text" id="concPhone" name="concPhone" value="<%=contact_phone%>" readOnly >
					-->
					<input type="text" id="MidHighPhone" class="redcolor"  name="MidHighPhone" value="<%=strMidHighFlag%>"  readyOnly>&nbsp;
					<input type="button" class="b_text" value="���ʷ���" onclick="unionPay()">
			</tr>
			<tr>
				<!--update by wench 20111104 ����
				<td class="blue" nowrap>sim����</td>
				<td><input type="text" id="custSimNo" name="custSimNo" value="<%=sim_no%>" readOnly ></td>
				-->
				<td class="blue" nowrap>�ͻ�������ֵ</td>
				<td><input type="text" id="custXyz" name="custXyz" value="<%=limit_owe%>" readOnly >
				</td>
				<td class="blue" nowrap>���ѷ�ʽ</td>
				<td><input type="text" id="payType" name="payType" value="<%=pay_name%>" readOnly >
				<input type="button" class="b_text" value="������Ϣ" onclick="showConMsg();">
				</td>
				<!--uodate by wench 20111104 ��ϵ�绰���� �иߵ���ʶ����
				<td class="blue" nowrap>��ϵ�绰</td>
				-->
				<td class="blue" nowrap>SIM����</td>
				<td><input type="text" id="custSimNo" name="custSimNo" value="<%=sim_no%>" readOnly ></td>
			  </tr>
			<tr>
				<td class="blue" nowrap>�����Ƽ���ʶ</td>
				<%
					String marketChannel = "";
					if(ChannelIdentifier[0][0].equals("0")){
						marketChannel = "��";
					}else{
						marketChannel = "��";
					}
				%>
				<td><input name="marketChannel" id="marketChannel" type="text" value="<%=marketChannel%>" readOnly/></td>
				<!-- update bu wench 20111104����
				<td class="blue" nowrap>��ͻ���־</td>
				<td><input type="text" class="<%=clsName1%>" id="bigCustomerSymbol" name="bigCustomerSymbol" value="<%=bigCustomerSymbol%>" readOnly ></td>				
				<td class="blue" nowrap>֤������</td>
				<td><input type="text" id="idNo" name="idNo" value="<%=id_iccid%>" readOnly ></td>
				-->
				<!--add by sunbya 20120401-->
				<td class="blue" nowrap>���������ʶ</td>
				<td ><input type="text" id="TociInfo" name="TociInfo" value="<%=isChnInfoFlag%>" readOnly ></td>
			  <td class="blue" nowrap>�绰�����ʶ</td>
				<td><input type="text" id="PhoneManager" name="PhoneManager" value="<%=ispmsuser%>" readOnly ></td>
    	 </tr>
				<tr>
				<td class="blue" nowrap>���м���</td>
				<td><input type="text" id="d" name="callSkill" value="<%=callSkill%>" readOnly ></td> 	
                           	<!--add by sunbya 20120401-->
				<td class="blue" nowrap >�ײʹ���</td>
				<td colspan="3"><input type="text" id="custTcDm" name="custTcDm" value="<%=mode_code%>" readOnly ></td>
				
			</tr>
			<tr>
				<td class="blue" nowrap>�ײ�����</td>
				<td colspan="5">
					<textarea cols="85" rows="6" id="custTcMc" name="custTcMc" readOnly><%=mode_note%></textarea>
					<input class="b_text" style="margin-bottom:30px;" type=button value="���Ͷ���" onClick="sendMesg()">
				</td>
			</tr>
			<tr>
				<td colspan="6" align="left">
					<input type="button" class="b_text" value="�·ѷ�̯" onClick="chgCls(this),dBillCustDetail()" />
					<input type="button" class="b_text" value="�˵���ѯ"  onclick="chgCls(this),showZDDetail()" />
					<input type="button" class="b_text" value="������Ϣ" onclick="chgCls(this),queryJFXX()" />
					<input type="button" class="b_text" value="��ϸ�Ż���Ϣ" onclick="chgCls(this),to1500_1Func()" />					
					<!--
					<input type="button" class="b_text" value="���ó�����ϸ" onclick="chgCls(this),showCXDetail()" />
					-->
					<input type="button" class="b_text" value="��ʷ�Ż���Ϣ" onclick="chgCls(this),showYHDetail()" />
					<input type="button" class="b_text" value="�ط���ͨ��Ϣ" onclick="chgCls(this),proOpenInfo()" />					
					<input type="button" class="b_text" value="Ԥ�������Ϣ" onclick="chgCls(this),queryYCXX()" />
					<input type="button" class="b_text" value="�ײ��Ż���Ϣ" onclick="chgCls(this),queryFav()" /><br>
					<input type="button" class="b_text" id="2hIvrLog" value="�û�������־��ѯ" onclick="chgCls(this),info2Ivr()"/>
					<input type="button" class="b_text" value="ͳһ��ѯ�˶�" onclick="chgCls(this),to1930Func()" />
					<input type="button" class="b_text" value="SP������ҵ��ʹ�ò�ѯ" onclick="chgCls(this),to9127Func()" />						
					<input type="button" class="b_text" value="ӪҵԱ����" onclick="chgCls(this),empOpr()" />
					<input type="button" class="b_text" value="�����¼��Ϣ" onclick="chgCls(this),ztoChgInfo()" />
					<input type="button" class="b_text" value="������ʱ���ò�ѯ" onclick="chgCls(this),toSCQry()"/>					
					<input type="button" class="b_text" value="SIM�������Ϣ" onclick="chgCls(this),showSimHis()" />																			
					<input type="button" class="b_text" value="�ط�����" onclick="chgCls(this),toTF()"/>					
					<input type="button" class="b_text" value="GPRS�ײͶ���ԤԼ" onclick="sendGPRSMess()"/>
					<input type="button" class="b_text" value="����������־" onclick="chgCls(this),toDXYYTDetail()"/>
					<input type="button" class="b_text" value="Ͷ����־" onclick="chgCls(this),toTSDetail()"/>					
					<input type="button" class="b_text" value="���߸�������" onclick="chgCls(this),toOnlineCase()"/>					
					<input type="button" class="b_text" value="����ר����Ϣ" onclick="chgCls(this),queryJTZX()"/>
					<input type="button" class="b_text" value="����ҵ�񼤻�" onclick="chgCls(this),toMWSInfo()" />
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
				rdShowMessageDialog("�ǽ���״̬�����ܷ���!",0);
				return;
		}
	if(rdShowConfirmDialog("ȷ��ԤԼ��?")==1){
	var Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/login/send_Gprs_mess_do.jsp","���Ժ�...");
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
	    		rdShowMessageDialog("ԤԼ�ɹ�!",'2');
	    	}else if (ret=="333333"){
	    		rdShowMessageDialog("���û��Ѿ�ԤԼ��");
	    	}else {
	    		rdShowMessageDialog("ԤԼʧ��!");
	    	 }
}


	//���д򿪴���
  function openWinMid(url,name,iHeight,iWidth)
  {
  var iTop = (window.screen.availHeight-20-iHeight)/2; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-5-iWidth)/2; //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
  }
function clickopr(){
	 openWinMid('<%=request.getContextPath()%>/npage/se323/fe323_1.jsp?activePhone=<%=phone_no%>','ǿ�ز�����ѯ',400,900); 
	}
</script>
</body>
</html>
