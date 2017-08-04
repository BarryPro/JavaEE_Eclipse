<%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%      
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String opCode =request.getParameter("opCode");
		//String opName =request.getParameter("opName");
		String opName="宽带移机";
    String isDoNoResource=request.getParameter("isDoNoResource");
    String cfm_login =request.getParameter("cfm_login");
    String workNo=request.getParameter("workNo");
    String sysAcceptl=request.getParameter("sysAcceptl");
    String phone_no=request.getParameter("phone_no");
    
	 	String[] inPubParams = new String[29];
		inPubParams[0] = request.getParameter("sysAcceptl");//操作流水
		inPubParams[1] = "";//渠道标识
	  inPubParams[2] = request.getParameter("opCode");
	  inPubParams[3] = request.getParameter("workNo");
	  inPubParams[4] = request.getParameter("password");
	  inPubParams[5] = request.getParameter("phone_no"); //手机号码
	  inPubParams[6] = "" ;//用户密码
    inPubParams[7] =request.getParameter("enter_type");
	  inPubParams[8] =request.getParameter("area_codeh");
	  inPubParams[9] =request.getParameter("area_nameh");
	  inPubParams[10] =request.getParameter("portCode");
	  inPubParams[11] =request.getParameter("portCodeOld");
	  inPubParams[12] =request.getParameter("deviceCode");
	  inPubParams[13] =request.getParameter("deviceCodeOld");
	  inPubParams[14] =request.getParameter("enter_addr");
	  inPubParams[15] =request.getParameter("ipAddress");
	  inPubParams[16] =request.getParameter("ipAddressOld");
	  inPubParams[17] =request.getParameter("deviceInAddress");
	  inPubParams[18] =request.getParameter("deviceInAddressOld");
	  inPubParams[19] =request.getParameter("contactPhone");
	  inPubParams[20] =request.getParameter("contactCustName");//联系人
	  inPubParams[21] =request.getParameter("construct_request");
	  inPubParams[22] =request.getParameter("appointvTime");
	  inPubParams[23] =request.getParameter("vOpNote");
	  inPubParams[24] =request.getParameter("ipAddr");
	  inPubParams[25] =request.getParameter("standardContent");//标准地址名称新
	  inPubParams[26] ="";//标准地址名称旧
	  inPubParams[27] =request.getParameter("cctId");//电信局编码新
	  inPubParams[28] =request.getParameter("cctIdOld");//电信局编码旧
	  System.out.println("the input of service sBroadBandMove below");
	  System.out.println("sysAcceptl------------------"+inPubParams[0]);
	  System.out.println("chnSource--------------------"+inPubParams[1]);
	  System.out.println("opCode----------------------"+inPubParams[2]);
	  System.out.println("workNo----------------------"+inPubParams[3]);
	  System.out.println("password----------------------"+inPubParams[4]);
	  System.out.println("phone_no--------------------"+inPubParams[5]);
	  System.out.println("userpwd-------------------"+inPubParams[6]);
	  System.out.println("enter_type---------------------"+inPubParams[7]);
	  System.out.println("area_codeh------------------"+inPubParams[8]);
	  System.out.println("area_nameh------------------"+inPubParams[9]);
	  System.out.println("portCode------------------"+inPubParams[10]);
	  System.out.println("portCodeOld--------------------"+inPubParams[11]);
	  System.out.println("deviceCode-----------------"+inPubParams[12]);
	  System.out.println("deviceCodeOld------------------"+inPubParams[13]);
	  System.out.println("enter_addr---------------"+inPubParams[14]);
	  System.out.println("ipAddress------------------"+inPubParams[15]);
	  System.out.println("ipAddressOld------------------"+inPubParams[16]);
	  System.out.println("deviceInAddress----------------"+inPubParams[17]);
	  System.out.println("deviceInAddressOld-------------"+inPubParams[18]);
	  System.out.println("contractPhone----------"+inPubParams[19]);
	  System.out.println("contactCustName---------------"+inPubParams[20]);
	  System.out.println("construct_request-------------"+inPubParams[21]);
	  System.out.println("appointvTime-----------"+inPubParams[22]);
	  System.out.println("vOpNote----------------"+inPubParams[23]);
	  System.out.println("ipAddr---------------------"+inPubParams[24]);
	  System.out.println("standardContent-----------------"+inPubParams[25]);
	  System.out.println("standardContentOld----------------------"+inPubParams[26]);
	  System.out.println("cctId-------------"+inPubParams[27]);
	  System.out.println("cctIdOld----------"+inPubParams[28]);
	    
    System.out.println("sBroadBandMove service begin~~~~~~~~~~~~~~~~~~~~~~~\n");
%>
<wtc:service name="sBroadBandMove" routerKey="region" routerValue="<%=regionCode%>"   retcode="retcode" retmsg="retmsg"  outnum="3">                
    <wtc:param value="<%=inPubParams[0]%>"/>
		<wtc:param value="<%=inPubParams[1]%>"/>
		<wtc:param value="<%=inPubParams[2]%>"/>
		<wtc:param value="<%=inPubParams[3]%>"/>
		<wtc:param value="<%=inPubParams[4]%>"/>
		<wtc:param value="<%=inPubParams[5]%>"/>
		<wtc:param value="<%=inPubParams[6]%>"/>
		<wtc:param value="<%=inPubParams[7]%>"/>
		<wtc:param value="<%=inPubParams[8]%>"/>
		<wtc:param value="<%=inPubParams[9]%>"/>	
		<wtc:param value="<%=inPubParams[10]%>"/>
		<wtc:param value="<%=inPubParams[11]%>"/>
		<wtc:param value="<%=inPubParams[12]%>"/>
		<wtc:param value="<%=inPubParams[13]%>"/>
		<wtc:param value="<%=inPubParams[14]%>"/>	
		<wtc:param value="<%=inPubParams[15]%>"/>	
		<wtc:param value="<%=inPubParams[16]%>"/>
		<wtc:param value="<%=inPubParams[17]%>"/>
		<wtc:param value="<%=inPubParams[18]%>"/>	
		<wtc:param value="<%=inPubParams[19]%>"/>	
		<wtc:param value="<%=inPubParams[20]%>"/>	
		<wtc:param value="<%=inPubParams[21]%>"/>
		<wtc:param value="<%=inPubParams[22]%>"/>
		<wtc:param value="<%=inPubParams[23]%>"/>	
		<wtc:param value="<%=inPubParams[24]%>"/>
		<wtc:param value="<%=inPubParams[25]%>"/>
		<wtc:param value="<%=inPubParams[26]%>"/>	
		<wtc:param value="<%=inPubParams[27]%>"/>
		<wtc:param value="<%=inPubParams[28]%>"/>							
</wtc:service>
<wtc:array id="result"  scope="end"/>

<%
		System.out.println("retcode======"+retcode);
		System.out.println("retmsg======"+retmsg);
   //增加统一接触	
   String opBeginTime1  = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());//业务开始时间
	 String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retcode+"&opName=宽带移机&workNo="+workNo+"&loginAccept="+sysAcceptl+"&pageActivePhone="+phone_no+"&retMsgForCntt="+retmsg+"&opBeginTime="+opBeginTime1;
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
    //System.out.println(result.length);
    //String strArray = createArray("backInfo", result.length);
%>
<%
if(retcode.equals("000000")){%>
	<script language='JavaScript'>
	rdShowMessageDialog("操作成功！请返回.......");
	 history.go(-1);
	</script>
<%}
else{%>
<script language='JavaScript'>
		function realeaseResource()
	  {	
					var myPacket = new AJAXPacket("../se276/ajax_yzResource1.jsp", "正在校验，请稍候......");
					  myPacket.data.add("servicetype","40007");
					   myPacket.data.add("type", "2" );
							myPacket.data.add("businessCity",  "");
							myPacket.data.add("businessArea","");/*业务所属区域*/
							myPacket.data.add("businessDemand","");/*业务需求描述*/
							myPacket.data.add("productApplyUses","宽带移机资源释放");/*用途*/
							
							myPacket.data.add("loginNo", "");
							myPacket.data.add("applyId","");/*申请系统主工单号*/
							
							myPacket.data.add("productName", "");
							myPacket.data.add("productCode", "");
							myPacket.data.add("productType","12");/*产品类型*/
							myPacket.data.add("productState","");/*产品业务状态*/
							myPacket.data.add("validateTime","");/*拟生效时间*/
							myPacket.data.add("relatedProductCode","");/*关联产品*/
							
							myPacket.data.add("account", "<%=cfm_login%>");
							myPacket.data.add("password","null");/*密码*/
							myPacket.data.add("customerName", "");
							myPacket.data.add("customerAddress","");
							myPacket.data.add("customerGrade","");/*用户级别*/
							myPacket.data.add("customerLinkMan","");/*用户联系人*/
							myPacket.data.add("customerPhone", "");
							myPacket.data.add("customerMail","");/*联系邮箱*/
							myPacket.data.add("customerCode","");/*用户编号*/
							myPacket.data.add("newCustomerName","");/*新客户名称*/
							myPacket.data.add("newCustomerAddress","");/*新客户地址*/
							myPacket.data.add("newCustomerPhone","");/*新联系电话*/
							myPacket.data.add("stdAddress","");/*用户标准地址*/
							myPacket.data.add("newRate","");/*新宽带速率*/
							myPacket.data.add("oldRate","");/*旧宽带速率*/
							
							myPacket.data.add("serviceType","17");/*服务类型*/	
							myPacket.data.add("deviceName","");
							myPacket.data.add("deviceId","");
							myPacket.data.add("portName","");
							myPacket.data.add("portId","");
	
							myPacket.data.add("collType","");/*合作类型*/
							myPacket.data.add("broadBandObject","");/*宽带对象*/
							myPacket.data.add("opNote", "资源释放");/*备注*/
									
							myPacket.data.add("opCode", "<%=opCode%>");
					   core.ajax.sendPacket(myPacket,doRealeaseResource);
			       myPacket = null;			 	
	  } 
		function doRealeaseResource(packet)
		{
		  var retCode = packet.data.findValueByName("retCode");
		   var retMsg = packet.data.findValueByName("retMsg");
		   var retContent = packet.data.findValueByName("retContent");
		    var iType = packet.data.findValueByName("iType");
		    var retValue=retContent.split(",");
		    var retContent=retValue[2].split("=");
		     if(retCode=="000000" && retContent[1]=="0"){	 
		      		rdShowMessageDialog("资源释放成功");
		     }
		     else{ 
		         	rdShowMessageDialog("资源释放失败"); 
		     }
		}
    rdShowMessageDialog("操作失败,<%=retcode%>:<%=retmsg%>",0);
    if("<%=isDoNoResource%>" !="1"){
    	realeaseResource();//释放已预占的资源
    }
    history.go(-1);
</script>
<%}%>
