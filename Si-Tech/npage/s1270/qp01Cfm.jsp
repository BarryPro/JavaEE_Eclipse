<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name_p.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/common/qcommon/print_include.jsp"%>
<%
	String retrunCode="";
	String returnMsg="";
  String chkFlag = WtcUtil.repNull(request.getParameter("chkFlag"));	
	String loginNo = (String)session.getAttribute("workNo");
	String groupId = (String)session.getAttribute("siteId");
	
	String oldofferId = WtcUtil.repNull(request.getParameter("oldofferId"));	
	String newofferId = WtcUtil.repNull(request.getParameter("newofferId"));
	String accountType = (String)session.getAttribute("accountType"); //1 ΪӪҵ���� 2 Ϊ�ͷ�����
	
	String isWeiyuejin = WtcUtil.repStr(request.getParameter("isWeiyuejin"),"");
	String weiyuejinNote = WtcUtil.repStr(request.getParameter("weiyuejinNote"),"");
	
	System.out.println("---liangyl-----------"+isWeiyuejin);
	System.out.println("---liangyl-----------"+weiyuejinNote);
	
	String feeFactor=WtcUtil.repNull(request.getParameter("feeFactor"));	
	int hasServOrderData = 0;
	int hasServOrderSlaInfo = 0;
	int hasServOrderBookingMsg = 0;
	
	String phoneNo=WtcUtil.repNull(request.getParameter("phoneNo"));	//13083154258	ҵ�����
	String offered=WtcUtil.repNull(request.getParameter("offId"));	//"100005329";	//  #����Ʒ��ʶ 100005610
  opCode=WtcUtil.repNull(request.getParameter("opCode"));	
	String opName=WtcUtil.repNull(request.getParameter("opName"));
	String servId=WtcUtil.repNull(request.getParameter("servId"));	//servId//  #����Ʒʵ��ID "900000783066";	10099000990
	String gCustId=WtcUtil.repNull(request.getParameter("gCustId"));//  #�ͻ�ID 900001942251	//900001942251 "900000782559";	
		
	String offerSrvId=WtcUtil.repNull(request.getParameter("idNo"));	//�������װ���� //��װ����Ʒʵ��ID;����ǿͻ�������� idNo
	String orderArrayId=WtcUtil.repNull(request.getParameter("orderArrayId"));	//A0209022000000180  �ͻ���������ID
	String custOrderId=WtcUtil.repNull(request.getParameter("custOrderId"));	//C0209022000000166  �ͻ�����ID
	String servOrderId=WtcUtil.repNull(request.getParameter("servOrderId"));	//���񶩵�ID
	String servBusiId=WtcUtil.repNull(request.getParameter("servBusiId"));	//620
	String prtFlag=WtcUtil.repNull(request.getParameter("prtFlag"));
	String custOrderNo = WtcUtil.repNull(request.getParameter("custOrderNo"));
	String weiyuejin = WtcUtil.repNull(request.getParameter("weiyuejin"));
		
  String loginPwd =(String)session.getAttribute("password");
  String ipAddress =request.getRemoteAddr();	
  String oprGroupId =(String)session.getAttribute("groupId");	//10032 
  String opTime =new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());//"20080912 09:59:01";
  String regionCode =(String)session.getAttribute("regCode");	//bureau_Id  ����ID  �൱������ԭ����regionCode 
	regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);	//-------------lgz
	String opNote="";
	if(opCode.equals("1272")) {
		opNote = WtcUtil.repNull(request.getParameter("note1272result"));
  }else {
  	opNote=opName+"["+oldofferId+"]->["+newofferId+"]";
	}
   
  String bureauId =(String)session.getAttribute("groupId");	//site_id   �����ID  �൱������ԭ����groupId
  String objectId =(String)session.getAttribute("workGroupId");	//object_id �����ID	//bureau_id >  object_id > site_id
	String servOrderNo ="0";	//�ͻ����񶨵����(Ϊ��ϵͳԤ��)
	String servOrderChangeId ="0";	//���񶨵�������
	String idNo = WtcUtil.repNull(request.getParameter("offerSrvId"));
	String serviceNo =phoneNo;	//"0";//����������//-------------j	WtcUtil.repNull(request.getParameter("selNum"));
	String dispathRule ="0"; //�滻0	�����ɷ������ʶ
	String decomposeRule ="0"; //�滻0	�����ֽ�����ʶ
	String addressId ="0"; //�滻0	//��ַID//-------------j ----------------@@@@
	String orderStatus ="110"; //�滻0 //0��ʼδ����״̬	//���շ�110
	String stateDate ="0";	//-------------j
	String stateReasonId ="3"; //�滻0	//����״̬ԭ��ID//-------------j
	String finishFlag ="N";	//δ���,����� Nδ����//-------------j
	String finishTime ="0";		//����ʱ��//-------------j
	String finishLimitTime =opTime;	//�������//-------------j	//-------------------@@@@
	String warningTime =opTime;	//Ԥ��ʱ��//-------------j	//-------------------@@@@
	String dealLevel ="1";		//1:��ͨ���ȼ�//-------------j  
	String payStatus ="0";		//�ɷ�״̬ char sPayState[1+1];//-------------j
	String backFlag ="0";		//�˷ѱ�־//-------------j
	String exceptionTimes ="0";	//"int";	//�쳣���ִ���//-------------j
	String servOrderSeq ="1";	//"int";	//���񶨵�����˳��dOrderArrayOrder.serv_order_seq//-------------j//-------------------@@@@
	String isPreCreateStatus ="Y";	//"string";��ʾ�Ƿ���Ԥ����״̬��dOrderArrayOrder.create_status��ȡֵ��Χ'Y','N'���������ҵ����񶨵�����ǰ���ɵ�	//��ʾ�Ƿ���Ԥ����״̬��dOrderArrayOrder.create_status��ȡֵ��Χ'Y','N'��//-------------j
	/////�������ҵ����񶨵�����ǰ���ɵġ�//----------------@@@@@
	String contactPerson ="0";	//���񶨵��������ϵ��
	String contactPhone =WtcUtil.repNull(request.getParameter("phoneNo"));	
///////////////////////////////////////////////////////servOrderData
	String classCode ="0";	//"long";	//��������  ----�ɿջ�Ĭ��
	String arraySeq ="0";	//"int";	//�������
	String classValue ="0";		//����ֵ
///////////////////////////////////////////////////////servOrderSlaInfo----�ɿ�----Ĭ��//-------------lgz
	String srvOrderSlaId ="0";	//����SLA��ʶ
	String slaIndexId ="0"; //�滻0	//ָ���ʶ
	String salValueSeq ="0"; //�滻0	//ָ�����
	String slaValue ="0";	//ָ�����
///////////////////////////////////////////////////////servOrderBookingMsg----�ɿ�----Ĭ��//-------------lgz
	String bookSrvId ="0";		//ԤԼ������Ϣ��ʶ
	String modifyTime =opTime;	//����޸�ʱ��
	String bookingTime =opTime;	//ԤԼʱ��
///////////////////////////////////////////////////////servOrderExcpInfo
	String srvOrderExcpId ="0";	//�쳣��Ϣ��ʶ
	String excpType ="1"; //�滻0				//�쳣����
	String excpReason ="0";		//�쳣ԭ��
	String handleResult ="OK";		//�쳣������
	String handleLogin ="0";		//�쳣������

	String brand ="0";			//�û���Ʒ����Ϣ���磺00 ����� 01 ������ 02 ����ͨ��//-------------j
	String userNo ="0";		//�û����ڲ�11λ���룬���ڳ���//-------------j
	
	groupId=(String)session.getAttribute("groupId");	//�û�������--------ȡ�û���,��ӪҵԱ�Ĳ�ͬ//-------------lgz
	
	String UseCustId =gCustId;	//ʹ�ÿͻ�ID

	stateDate =opTime;		//״̬ʱ��
	
	String operatorFlag0 ="0";
	String resType ="0";		//��Դ����
	String resSeq ="0";		//��Դ����
	String resNo =phoneNo;			//��Դ���

	String paramType ="C";			//������Ϣ------------Ӫҵ�Է�����
	String paramCode ="C2";			//��������
	String paramValueBegin =feeFactor;	//��ʼ����ֵ
	String paramValueEnd ="0";	
	String paramObj ="0";			//������չ��Ϣ

	//C       ��������
	//C2      ��������
	//MODE    ��ʼֵ
	// 0        ����ֵ
	// 0        ��������
	//		 ��������ƷID

///////////////////////////////////////////////////////

String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
UType cfmParamUtype = new UType();
	//-------------ȡ����Ʒ,��Ʒ����----------
%>
<%String regionCode_sCrtOrderMsg = (String)session.getAttribute("regCode");%>
<wtc:utype name="sCrtOrderMsg" id="retVal1" scope="end" routerKey="region" routerValue="<%=regionCode_sCrtOrderMsg%>">
	<wtc:uparam value="<%=loginNo%>" type="string"/>
  <wtc:uparam value="<%=loginAccept%>" type="long"/>
  <wtc:uparam value="<%=servId%>" type="long"/>
  <wtc:uparam value="<%=chkFlag%>" type="STRING"/>
</wtc:utype>	
<%
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal1,1,"2",logBuffer);
	System.out.println(logBuffer.toString());

	retCode = retVal1.getValue(0);
	retMsg  = retVal1.getValue(1).replaceAll("\\n"," ");
	if(retCode.equals("0")){
		cfmParamUtype = retVal1.getUtype("2");
	}else{  
%>
  <script language='JavaScript'>
        rdShowMessageDialog("<%=retrunCode%>:<%=retMsg%>");
        window.history.go(-1);
   </script> 
<%
 }
 

 String serverNameSub = "";
 if(opCode.equals("1270")){
 	 serverNameSub = "s1270ChgCfm";
 }else if(opCode.equals("1272")){
 	 serverNameSub = "s1272ChgCfm";
 }else{
 	 serverNameSub = "sProdChgCfm";
 }
 
 
 System.out.println("-----------------opCode-------------------------"+opCode);
 System.out.println("-----------------serverNameSub------------------"+serverNameSub);
%>
<%String regionCode_sProdChgCfm = (String)session.getAttribute("regCode");%>
<%if(opCode.equals("e301")&&!"".equals(isWeiyuejin)){
System.out.println("---liangyl----------������se301cfm");
%>
  	<wtc:service name="se301Cfm" outnum="100" retmsg="e301Msg" retcode="e301Code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=loginAccept%>" />
		<wtc:param value="01" />	
		<wtc:param value="<%=opCode%>" />	
		<wtc:param value="<%=loginNo%>" />
		<wtc:param value="<%=loginPwd%>" />
		<wtc:param value="<%=phoneNo%>" />
		<wtc:param value="" />
		<wtc:param value="" />
		<wtc:param value="<%=isWeiyuejin%>"/>
		<wtc:param value="<%=weiyuejinNote%>" />
	</wtc:service>
	<wtc:array id="result_custInfo" scope="end"/>
<%}%>
<wtc:utype name="<%=serverNameSub%>" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sProdChgCfm%>">
	<wtc:uparams name="ctrlInfo" iMaxOccurs="1">
			<wtc:uparam value="0" type="string"/>
	</wtc:uparams>	
	<wtc:uparams name="batchDataList" iMaxOccurs="1">
			<wtc:uparams name="batchData" iMaxOccurs="1">
				<wtc:uparam value="0" type="long"/>
				<wtc:uparam value="0" type="string"/>
				<wtc:uparam value="0" type="string"/>
			</wtc:uparams>	
	</wtc:uparams>	
	<wtc:uparams name="msgBodyType" iMaxOccurs="1">
		<wtc:uparams name="oprInfo" iMaxOccurs="1">
		        <wtc:uparam value="<%=loginAccept %>" type="long"/>
		        <wtc:uparam value="<%=opCode %>" type="string"/>
		        <wtc:uparam value="<%=loginNo %>" type="string"/>
		        <wtc:uparam value="<%=loginPwd %>" type="string"/>
		        <wtc:uparam value="<%=ipAddress %>" type="string"/>
		        <wtc:uparam value="<%=oprGroupId %>" type="string"/>
		        <wtc:uparam value="<%=opTime %>" type="string"/>
		        <wtc:uparam value="<%=regionCode %>" type="string"/>
		        <wtc:uparam value="<%=opNote %>" type="string"/>
		        <wtc:uparam value="<%=bureauId %>" type="string"/>
		        <wtc:uparam value="<%=objectId %>" type="string"/>
		</wtc:uparams>
		<wtc:uparams name="custOrder" iMaxOccurs="1">
		  <wtc:uparams name="custOrderMsg" iMaxOccurs="1">
		     <wtc:uparam value="<%=custOrderId %>" type="string"/>
		  </wtc:uparams>
		  <wtc:uparams name="orderArrayList" iMaxOccurs="1">		
		    <wtc:uparams name="orderArrayListContainer" iMaxOccurs="1">				
		      <wtc:uparams name="orderArrayMsg" iMaxOccurs="1">						
		          <wtc:uparam value="<%=orderArrayId %>" type="string"/>
		      </wtc:uparams>
		      <wtc:uparams name="servOrderList" iMaxOccurs="1">	
		        <wtc:uparams name="servOrderListContainer" iMaxOccurs="1">														
		          <wtc:uparams name="servOrderMsg" iMaxOccurs="1">										
		            <wtc:uparam value="<%=servOrderId %>" type="string"/>
		            <wtc:uparam value="<%=servOrderNo %>" type="string"/>
		            <wtc:uparam value="<%=servOrderChangeId %>" type="string"/>
		            <wtc:uparam value="<%=idNo %>" type="long"/>
		            <wtc:uparam value="<%=serviceNo %>" type="string"/>
		            <wtc:uparam value="<%=dispathRule %>" type="int"/>
		            <wtc:uparam value="<%=decomposeRule %>" type="int"/>
		            <wtc:uparam value="<%=addressId %>" type="long"/>
		            <wtc:uparam value="<%=orderStatus %>" type="int"/>
		            <wtc:uparam value="<%=stateDate %>" type="string"/>
		            <wtc:uparam value="<%=stateReasonId %>" type="int"/>
		            <wtc:uparam value="<%=servBusiId %>" type="string"/>
		            <wtc:uparam value="<%=finishFlag %>" type="string"/>
		            <wtc:uparam value="<%=finishTime %>" type="string"/>
		            <wtc:uparam value="<%=finishLimitTime %>" type="string"/>
		            <wtc:uparam value="<%=warningTime %>" type="string"/>
		            <wtc:uparam value="<%=dealLevel %>" type="int"/>
		            <wtc:uparam value="<%=payStatus %>" type="string"/>
		            <wtc:uparam value="<%=backFlag %>" type="string"/>
		            <wtc:uparam value="<%=exceptionTimes %>" type="int"/>
		            <wtc:uparam value="<%=servOrderSeq %>" type="int"/>
		            <wtc:uparam value="<%=isPreCreateStatus %>" type="string"/>
		            <wtc:uparam value="<%=contactPerson %>" type="string"/>
		            <wtc:uparam value="<%=contactPhone %>" type="string"/>
		          </wtc:uparams>
		          <wtc:uparams name="servOrderDataList" iMaxOccurs="1">										
							<%
							if(hasServOrderData == 1){ 
							%>
		              <wtc:uparams name="servOrderData" iMaxOccurs="1">								
		                <wtc:uparam value="<%=classCode %>" type="long"/>
		                <wtc:uparam value="<%=arraySeq %>" type="int"/>
		                <wtc:uparam value="<%=classValue %>" type="string"/>
		              </wtc:uparams>
							<%
							}
							%>
							<%
							if("1258".equals(opCode)){
							%>
				              <wtc:uparams name="servOrderData" iMaxOccurs="1">								
				                <wtc:uparam value="125800" type="long"/>
				                <wtc:uparam value="0" type="int"/>
				                <wtc:uparam value="<%=weiyuejin %>" type="string"/>
				              </wtc:uparams>
							<%
							}
							%>
		          </wtc:uparams>
		          <wtc:uparams name="servOrderSlaList" iMaxOccurs="1">										
							<% 
							if(hasServOrderSlaInfo == 1){ 
							%>										
		            <wtc:uparams name="servOrderSlaInfo" iMaxOccurs="1">
		              <wtc:uparam value="<%=srvOrderSlaId %>" type="string"/>
		              <wtc:uparam value="<%=slaIndexId %>" type="int"/>
		              <wtc:uparam value="<%=salValueSeq %>" type="int"/>
		              <wtc:uparam value="<%=slaValue %>" type="double"/>
		            </wtc:uparams>
							<% 
							} 
							%>
		          </wtc:uparams>
		          <wtc:uparams name="servOrderBookingMsg" iMaxOccurs="1">											
		          <% 
		          if(hasServOrderBookingMsg == 1){ 
		          %>		
		            <wtc:uparam value="<%=bookSrvId %>" type="string"/>
		            <wtc:uparam value="<%=modifyTime %>" type="string"/>
		            <wtc:uparam value="<%=bookingTime %>" type="string"/>
							<% 
							}
						  %>
		          </wtc:uparams>
		          <wtc:uparams name="servOrderExcpInfo" iMaxOccurs="1">											
		            <wtc:uparam value="<%=srvOrderExcpId %>" type="string"/>
		            <wtc:uparam value="<%=excpType %>" type="int"/>
		            <wtc:uparam value="<%=excpReason %>" type="string"/>
		            <wtc:uparam value="<%=handleResult %>" type="string"/>
		            <wtc:uparam value="<%=handleLogin %>" type="string"/>
		          </wtc:uparams>
		        </wtc:uparams>
		      </wtc:uparams>
		    </wtc:uparams>
		  </wtc:uparams>
		</wtc:uparams>
		
		<wtc:uparams name="customer" iMaxOccurs="1">								
	    <wtc:uparams name="custDoc" iMaxOccurs="1">								
	      <wtc:uparams name="custDocBaseInfo" iMaxOccurs="1">				
	    	  <wtc:uparam value="<%=gCustId %>" type="long"/>
	      </wtc:uparams>
	     </wtc:uparams>
	     <wtc:uparam value="<%=cfmParamUtype%>" type="UTYPE"/>
		</wtc:uparams>
	 </wtc:uparams>

</wtc:utype>


<%
	System.out.println("2222=============================");
	retrunCode=retVal.getValue(0);//���ص�retCodeΪLONG���ͣ�
	returnMsg=retVal.getValue(1);
	System.out.println("returnCode=================="+retrunCode);
	System.out.println("returnMsg=======#################==========="+returnMsg);
%>
<%
 String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+
							"&retCodeForCntt="+retrunCode+
							"&opName="+opName+
							"&workNo="+loginNo+
							"&loginAccept="+loginAccept+
							"&pageActivePhone="+phoneNo+
							"&retMsgForCntt="+returnMsg+
							"&opBeginTime="+opBeginTime; 
%>
<%
	System.out.println("url��"+url);
%>
<jsp:include page="<%=url%>" flush="true" />
<%	
	
	if(retrunCode.equals("0"))
	{
	
		String statisLoginAccept = request.getParameter("loginAccept"); /*��ˮ*/
		String statisOpCode=opCode;
		String statisPhoneNo= request.getParameter("phoneNo");	
		String statisIdNo="";	
		String statisCustId="";
		String statisUrl = "/npage/public/pubCustSatisIn.jsp"
			+"?statisLoginAccept="+statisLoginAccept
			+"&statisOpCode="+statisOpCode
			+"&statisPhoneNo="+statisPhoneNo
			+"&statisIdNo="+statisIdNo	
			+"&statisCustId="+statisCustId;
		String statisUrl1 = "/npage/public/pubSendNPS.jsp"
    			+"?statisLoginAccept="+statisLoginAccept
    			+"&statisOpCode="+statisOpCode
    			+"&statisPhoneNo="+statisPhoneNo;
    	System.out.println("@zhangyan~~~~statisLoginAccept="+statisLoginAccept);
    	System.out.println("@zhangyan~~~~statisOpCode="+statisOpCode);
    	System.out.println("@zhangyan~~~~statisPhoneNo="+statisPhoneNo);
    	System.out.println("@zhangyan~~~~statisIdNo="+statisIdNo);
    	System.out.println("@zhangyan~~~~statisCustId="+statisCustId);
    	System.out.println("@zhangyan~~~~statisUrl="+statisUrl);
    	statisOpCode=statisOpCode.trim();
    	accountType=accountType.trim();
		regionCode=regionCode.trim();
		newofferId=newofferId.trim();
		opNote=opNote.trim();
		System.out.println("@zhangyan-----------------------------------------------------");
		System.out.println("@zhangyan~~~~statisOpCode="+statisOpCode);
		System.out.println("@zhangyan~~~~accountType="+accountType);
		System.out.println("@zhangyan~~~~regionCode="+regionCode);
		System.out.println("@zhangyan~~~~newofferId="+newofferId);
		System.out.println("@zhangyan~~~~statisUrl1="+statisUrl1);
		System.out.println("@zhangyan-----------------------------------------------------");

		System.out.println("@zhangyan-------------------is_offer_list(newofferId)----------------"+is_offer_list(newofferId));
		
				
    	if ("1270".equals(statisOpCode)||"1272".equals(statisOpCode))
		{
    		
    		if(
	    		("1".equals(accountType)&&
	    			(
		    			("1270".equals(statisOpCode)&&"01".equals(regionCode)&&is_offer_list(newofferId))||
			 				("1270".equals(statisOpCode)&&"02".equals(regionCode)&&is_offer_list(newofferId))||
			 				("1270".equals(statisOpCode)&&"03".equals(regionCode)&&is_offer_list(newofferId))||
			 				("1270".equals(statisOpCode)&&"04".equals(regionCode)&&is_offer_list(newofferId))||
			 				("1270".equals(statisOpCode)&&"05".equals(regionCode)&&is_offer_list(newofferId))||
			 				("1270".equals(statisOpCode)&&"06".equals(regionCode)&&is_offer_list(newofferId))||
			 				("1270".equals(statisOpCode)&&"07".equals(regionCode)&&is_offer_list(newofferId))||
			 				("1270".equals(statisOpCode)&&"08".equals(regionCode)&&is_offer_list(newofferId))||
			 				("1270".equals(statisOpCode)&&"09".equals(regionCode)&&is_offer_list(newofferId))||
			 				("1270".equals(statisOpCode)&&"10".equals(regionCode)&&is_offer_list(newofferId))||
			 				("1270".equals(statisOpCode)&&"11".equals(regionCode)&&is_offer_list(newofferId))||
			 				("1270".equals(statisOpCode)&&"12".equals(regionCode)&&is_offer_list(newofferId))||
			 				("1270".equals(statisOpCode)&&"13".equals(regionCode)&&is_offer_list(newofferId))
		 				)
		 			)
		 			||
	 				("1272".equals(statisOpCode)&& opNote.indexOf("41086")>0)
	 				||
	 				("2".equals(accountType)&&
		 				(
			 				("1270".equals(statisOpCode)&&is_offer_list(newofferId)) 
		 				)
		 			)
    		){
    				
		System.out.println("@zhangyan----------------������������-------------------------------------");
    		%>
    		<jsp:include page="<%=statisUrl1%>" flush="true" />	
    		
    		<%	}
		
		%>
		<jsp:include page="<%=statisUrl%>" flush="true" />	
		
		<%
    		
		}	
	%>
    <script language='JavaScript'>
        //rdShowMessageDialog("�����ɹ���");
        goNext("<%=custOrderId%>","<%=custOrderNo%>","<%=prtFlag%>");
    </script>            
<%
	}else{
%>
    <script language='JavaScript'>
        rdShowMessageDialog('����<%=retrunCode%>��'+'<%=returnMsg%>�������²�����');
        window.history.go(-1);
   </script> 
<%     
  }            
%>

<%!
	/**
	 * �ж������ʷ��Ƿ����б���
	 */
	boolean is_offer_list(String newofferId){
		boolean ret_B = false;
	String[] offerArr =new String[]{
				"53074","53075","53076","53077","53078","53079","53080","53081",
				"53082","53083","53084","53085","53086","53087","53088","53089",
				"53090","53091","53092","53093","53094","53095","53096","53097",
				"53098","53099","53100","53101","53102","53103","53104","53105",
				"53106","53107","53108","53109","53110","53111","53112","53113",
				"53114","53115","53116","53117","53118","53119","53120","53121",
				"53122","53123","53124","53125","53126","53127","53128","53129",
				"53130","53131","53132","53133","53134","53135","53136","53137",
				"53138","53139","53140","53141","53142","53143","53144","53145",
				"53146","53147","53148","53149","53150",
				"53151","53152","53153","53154","53155","53156","53157","53158",
				"53159","53160","53161","53162","53163","53164","53165","53166",
				"53167","53168","53169","53170","53171","53172","53173","53174",
				"53175","53176","53177","53178","53179","53180","53181","53182",
				"53183","53184","53185","53186","53187","53188","53189","53190"
};


		for(int i=0;i<offerArr.length;i++){
			if(newofferId.equals(offerArr[i])){
				ret_B = true;
				break;
			}
		}
		
		return ret_B;

	}
%>