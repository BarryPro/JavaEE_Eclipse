<%
  /*
   * 功能: 网站开户
   * 版本: 2.0
   * 日期: 2010/11/26
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="01"  id="seq"/>
<%
	String workno 		= (String)session.getAttribute("workNo");	//操作工号
	String loginPwd 	= (String)session.getAttribute("password");
	String orgCode 		= (String)session.getAttribute("orgCode");
	String ip_Addr 		= (String)session.getAttribute("ip_Addr");
	String groupId 		= (String)session.getAttribute("groupId");	
	String custId 		= ""; 
	String login_accept	= seq;
	String regionCode 	= orgCode.substring(0,2);
%>
	<wtc:service name="spubGetId" routerKey="region" routerValue="<%=regionCode%>" retCode="retCode1" retMsg="retMsg1" outnum="3" >
	<wtc:param value="<%=regionCode%>"/>
	<wtc:param value="0"/>
	<wtc:param value="0"/>
	</wtc:service>
	<wtc:array id="result11" scope="end"/>
<%
	if(result11!=null&&result11.length>0){
	   	custId = result11[0][2];			
	} 
	String districtCode = orgCode.substring(2,4);
	String regionId 	= regionCode + districtCode + "999"; 
	String custStatus 	= "01";//客户状态默认是正常
	String custGrade 	= "00"; //客户等级一般客户
	String ownerType 	= "01"; //客户类别为个人
	String idType 		= "0";	 //证件类型：0-身份证 
	String custName 	= request.getParameter("custName"); 
	String custPassword	= request.getParameter("custPwd");
	String custAddr 	= WtcUtil.repNull(request.getParameter("custAddr"));  
	String idIccid 		= request.getParameter("idIccid"); 
	String idAddr 		= request.getParameter("idAddr"); 
	String contactPerson = request.getParameter("contactPerson"); 
	String contactPhone = request.getParameter("contactPhone"); 
	String contactAddr 	= request.getParameter("contactAddr"); 
	String contactMAddr = request.getParameter("contactMAddr"); 
	String custSex 		= request.getParameter("custSex");  	//客户性别	
	String idValidDate 	= "20201129";//证件的有效期
	String contactPost 	= " ";//联系人邮编
	String contactFax 	= " ";//联系人传真
	String contactMail 	= " ";//联系人电子邮件
	String unitCode 	= orgCode; //机构代码
	String parentId 	= custId;//默认为当前客户Id
	String birthDay 	= "";//出生日期
 	  if(idIccid.trim().length()==15 && idType.equals("0")) {
		birthDay="19"+idIccid.substring(6,8)+idIccid.substring(8,12);
	  }else if(idIccid.trim().length()==18 && idType.equals("0")) {
        birthDay=idIccid.substring(6,10)+idIccid.substring(10,14);
	  }else{
        birthDay="19491001"; 
      }
	String professionId = "9999"; //其他
	String vudyXl 		= "05"; //学历
	String custAh 		= "无"; //客户爱好 
	String custXg 		= "无"; //客户习惯
	String unitXz 		= "C1"; //集团规模等级
	String yzlx 		= ""; //执照类型//后台未用到,所以利用其传送策反集团标志
	String yzhm 		= ""; //执照号码
	String yzrq 		= ""; //执照有效期
	String frdm 		= ""; //法人代码
	String groupCharacter = WtcUtil.repStr(request.getParameter("groupCharacter"),"无");//群组信息
	String opCode 		= "1100";	
	String sysNote 		= "新建户:客户ID[" + custId + "]";
	String opNote 		= ""; 
	String oriGrpNo		= "0";
	
	//预占
	String phoneNo 		= request.getParameter("phoneNo");
	String phoneStatus  = "2";
	
	/*经办人姓名*/
	String gestoresName = WtcUtil.repStr(request.getParameter("gestoresName"),"");
	/*经办人联系地址*/
	String gestoresAddr = WtcUtil.repStr(request.getParameter("gestoresAddr"),"");
	/*经办人证件类型*/
	String gestoresIdType = WtcUtil.repStr(request.getParameter("gestoresIdType"),"");
	gestoresIdType = gestoresIdType.substring(0,gestoresIdType.indexOf("|"));
	/*经办人证件号码*/
	String gestoresIccId = WtcUtil.repStr(request.getParameter("gestoresIccId"),"");
	/*经办人状态*/
	String xsjbrxx=WtcUtil.repStr(request.getParameter("xsjbrxx"),"0");
	
	String inputStr11="";
	if(xsjbrxx.equals("1")){
		inputStr11=gestoresName+"|"+gestoresIdType+"|"+gestoresIccId+"|"+gestoresAddr+"|||||||||||01|";
	}
	else{
		inputStr11="||||||||||||||01|";
	}
	
	
   
%>


<wtc:service name="s1100Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="retMessage"  outnum="4" >
					<wtc:param value="<%=login_accept%>"/>
			        <wtc:param value="<%=custId%>"/>
			        <wtc:param value="<%=regionId%>"/>
			        <wtc:param value="<%=custName%>"/>
			        <wtc:param value="<%=custPassword%>"/>
			        <wtc:param value="<%=custStatus%>"/>
			        <wtc:param value="<%=custGrade%>"/>
			        <wtc:param value="<%=ownerType%>"/>         
			        <wtc:param value="<%=custAddr%>"/>
			        <wtc:param value="<%=idType%>"/>
			        <wtc:param value="<%=idIccid%>"/>
			        <wtc:param value="<%=idAddr%>"/>
			        <wtc:param value="<%=idValidDate%>"/>
			        <wtc:param value="<%=contactPerson%>"/>
			        <wtc:param value="<%=contactPhone%>"/>
			        <wtc:param value="<%=contactAddr%>"/>
			        <wtc:param value="<%=contactPost%>"/>
			        <wtc:param value="<%=contactMAddr%>"/>
			        <wtc:param value="<%=contactFax%>"/>
			        <wtc:param value="<%=contactMail%>"/>
			        <wtc:param value="<%=unitCode%>"/>	
			        <wtc:param value="<%=parentId%>"/>
			        <wtc:param value="<%=custSex%>"/>
			        <wtc:param value="<%=birthDay%>"/>
			        <wtc:param value="<%=professionId%>"/>
			        <wtc:param value="<%=vudyXl%>"/>
			        <wtc:param value="<%=custAh%>"/>	
			        <wtc:param value="<%=custXg%>"/>
			        <wtc:param value="<%=unitXz%>"/>
			        <wtc:param value="<%=yzlx%>"/>
			        <wtc:param value="<%=yzhm%>"/>
			        <wtc:param value="<%=yzrq%>"/>
			        <wtc:param value="<%=frdm%>"/>
			        <wtc:param value="<%=groupCharacter%>"/>
			        <wtc:param value="<%=opCode%>"/>
			        <wtc:param value="<%=workno%>"/>
			        <wtc:param value="<%=sysNote%>"/>
			        <wtc:param value="<%=opNote%>"/>
			        <wtc:param value="<%=ip_Addr%>"/>
			        <wtc:param value="<%=oriGrpNo%>"/>
			        <wtc:param value=""/>
			        <wtc:param value=""/>
			        <wtc:param value=""/>
			        <wtc:param value=""/>
			        <wtc:param value=""/>
			        <wtc:param value=""/>
			        <wtc:param value="<%=inputStr11%>"/>
			        
			</wtc:service>
			<wtc:array id="result" scope="end" />
			<wtc:service name="sb893Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retCode="retCode12" retMsg="retMsg12" outnum="2" >
				<wtc:param value="b893"/>
				<wtc:param value="<%=workno%>"/>
				<wtc:param value="<%=loginPwd%>"/>
				<wtc:param value="<%=groupId%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value="<%=phoneStatus%>"/>
				<wtc:param value="<%=custId%>"/>
			</wtc:service>
			<wtc:array id="result111" scope="end"/>	

<%
	System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
	String retCodeForCntt = ret_code ;
    String retMsgForCntt =retMessage;
	String loginAccept =login_accept; 
	String opName = "客户开户";
	if(ret_code.equals("0")||ret_code.equals("000000")){
		if(result.length>0){
			System.out.println("s1100Cfm执行成功！");
			loginAccept=result[0][2];
		}
	}else{
		System.out.println("s1100Cfm执行失败！");	
	}
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&retMsgForCntt="+retMsgForCntt+"&opName="+opName+"&workNo="+workno+"&loginAccept="+loginAccept+"&pageActivePhone=&opBeginTime="+opBeginTime+"&contactId="+custId+"&contactType=cust";
	System.out.println("url="+url);
	System.out.println("retCodeForCntt>>"+retCodeForCntt+"  retMsgForCntt>>"+retMsgForCntt+" custId>>"+custId);
%>
<jsp:include page="<%=url%>" flush="true" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCodeForCntt%>");
response.data.add("retMsg","<%=retMsgForCntt%>");
response.data.add("cust","<%=custId%>");
core.ajax.receivePacket(response);