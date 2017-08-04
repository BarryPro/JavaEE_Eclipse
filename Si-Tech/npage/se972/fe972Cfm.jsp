<%
    /********************
     version v1.0
     开发商: si-tech
     *
     ********************/
%>
	<%@ page contentType="text/html; charset=GBK" %>
	<%@ include file="/npage/include/public_title_name.jsp" %>
	<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
	<%@ page import="java.text.*"%>

<%
	 String opCode = "e972";
	 String opName = "宽带过户";	

  request.setCharacterEncoding("GBK");
	String retCode = "999999";
	String retMsg = "";
 
	String cust_name=WtcUtil.repNull(request.getParameter("cust_name"));
	String cust_addr=WtcUtil.repNull(request.getParameter("cust_addr"));
	String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
	String user_id=WtcUtil.repNull(request.getParameter("user_id"));
	String new_cus_id=WtcUtil.repNull(request.getParameter("new_cus_id"));
  String ic_no=WtcUtil.repNull(request.getParameter("ic_no"));
  String broadPhone=WtcUtil.repNull(request.getParameter("broadPhone"));

	
  String work_no = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String org_code = (String)session.getAttribute("orgCode");
	String nopass = (String)session.getAttribute("password");
	String paraStr[]=new String[57];	//20091201 fengry 将String[44]改为String[45]
	paraStr[0]=WtcUtil.repNull(request.getParameter("loginAccept"));
	paraStr[1]="01";
 	paraStr[2]=opCode;
	paraStr[3]=work_no;
	paraStr[4]=nopass;
	paraStr[5]=srv_no;
	paraStr[6]="";
	paraStr[7]=broadPhone;
	paraStr[8]=org_code;
  paraStr[9]=user_id;
	paraStr[10]=new_cus_id; 

  paraStr[11] = request.getParameter("regionCode") + request.getParameter("districtCode") + "999";
	paraStr[12]= WtcUtil.repNull(request.getParameter("custName")); 
	String tmppwd = WtcUtil.repNull(request.getParameter("custPwd"));
  paraStr[13]= Encrypt.encrypt(tmppwd);
	paraStr[14]=WtcUtil.repNull(request.getParameter("custStatus")); 
	paraStr[15]="00";//WtcUtil.repNull(request.getParameter("custGrade"));
	paraStr[16]=WtcUtil.repNull(request.getParameter("custAddr")); 	
	paraStr[17] = WtcUtil.repNull(request.getParameter("idType"));
	paraStr[17] = paraStr[17].substring(0,paraStr[17].indexOf("|"));    //证件类型：0-身份证
  paraStr[18]= WtcUtil.repNull(request.getParameter("idIccid")); 
	paraStr[19]=WtcUtil.repNull(request.getParameter("idAddr")); 
	paraStr[20]=WtcUtil.repNull(request.getParameter("idValidDate"));
	if(paraStr[20].compareTo("")==0)
	{	  
/*
	*闰年问题
	  int toy=Integer.parseInt(new SimpleDateFormat("yyyy", Locale.getDefault()).format(new Date())); 
      String tomd= new SimpleDateFormat("MMdd", Locale.getDefault()).format(new Date());  
	  paraStr[16]=String.valueOf(toy+10)+tomd;
*/
		Calendar cc = Calendar.getInstance();
		cc.setTime(new Date());
		cc.add(Calendar.YEAR, 10);
		Date _tempDate = cc.getTime();
		paraStr[20] = new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(_tempDate);
	}
	paraStr[21]=WtcUtil.repNull(request.getParameter("newContactPerson")); 
	paraStr[22]=WtcUtil.repNull(request.getParameter("newContactPhone"));
	paraStr[23]=WtcUtil.repNull(request.getParameter("contactAddr"));
	paraStr[24] = WtcUtil.repNull(request.getParameter("contactPost"));
	if(paraStr[24].compareTo("")==0)
	{	paraStr[24] = " ";	}
	paraStr[25] = WtcUtil.repNull(request.getParameter("contactMAddr")); 	
	paraStr[26] = WtcUtil.repNull(request.getParameter("contactFax")); 
	if(paraStr[26].compareTo("")==0)
	{	paraStr[26] = " ";	}	
    paraStr[27] = WtcUtil.repNull(request.getParameter("contactMail")); 
	if(paraStr[27].compareTo("")==0)
	{	paraStr[27] = " ";	}
	paraStr[28]  = WtcUtil.repNull(request.getParameter("custSex"));  	//客户性别
	paraStr[29]  = WtcUtil.repNull(request.getParameter("birthDay")); //出生日期
	if(paraStr[29] .compareTo("") == 0)
	{
 	  if(paraStr[18].trim().length()==15 && paraStr[17].equals("0")) 
		paraStr[29] ="19"+paraStr[18].substring(6,8)+paraStr[18].substring(8,12);
	  else if(paraStr[18].trim().length()==18 && paraStr[17].equals("0")) 
        paraStr[29]=paraStr[18].substring(6,10)+paraStr[18].substring(10,14);
	  else
        paraStr[29]="19491001";
	} 
	paraStr[30] = WtcUtil.repNull(request.getParameter("professionId")); 
	paraStr[31] = WtcUtil.repNull(request.getParameter("vudyXl")); //学历
	paraStr[32] = WtcUtil.repNull(request.getParameter("custAh")); //客户爱好 
	if(paraStr[32].length() == 0)
	{	paraStr[32] = "";	}
	paraStr[33] = WtcUtil.repNull(request.getParameter("custXg")); //客户习惯
	if(paraStr[33].compareTo("") == 0)
	{	paraStr[33] = "";	}

  paraStr[34]=WtcUtil.repNull(request.getParameter("oriHandFee"));
	paraStr[35]=WtcUtil.repNull(request.getParameter("t_handFee"));
  paraStr[36]=WtcUtil.repNull(request.getParameter("t_sys_remark"));
  paraStr[37]=WtcUtil.repSpac(request.getParameter("t_op_remark"));
	paraStr[38]=request.getRemoteAddr();
	paraStr[39]=WtcUtil.repNull(request.getParameter("assuName"));
	paraStr[40]=WtcUtil.repNull(request.getParameter("assuPhone"));
	paraStr[41]=WtcUtil.repNull(request.getParameter("assuIdType"));
	paraStr[42]=WtcUtil.repNull(request.getParameter("assuId"));
	paraStr[43]=WtcUtil.repNull(request.getParameter("assuIdAddr"));
	paraStr[44]=WtcUtil.repNull(request.getParameter("assuAddr"));
	paraStr[45]=WtcUtil.repNull(request.getParameter("assuNote"));
	paraStr[46]=WtcUtil.repNull(request.getParameter("xinYiDu"));
	paraStr[47]=WtcUtil.repNull(request.getParameter("print_query"));
	
		/*责任人姓名*/
	String responsibleName = WtcUtil.repStr(request.getParameter("responsibleName"),"");
	/*责任人联系地址*/
	String responsibleAddr = WtcUtil.repStr(request.getParameter("responsibleAddr"),"");
	/*责任人证件类型*/
	String responsibleType = WtcUtil.repStr(request.getParameter("responsibleType"),"");
	responsibleType = responsibleType.substring(0,responsibleType.indexOf("|"));
	/*责任人证件号码*/
	String responsibleIccId = request.getParameter("responsibleIccId");
	
	String zerenrenstrss=responsibleType+"|"+responsibleIccId+"|"+responsibleName+"|"+responsibleAddr;	
	
	paraStr[48]=WtcUtil.repNull(request.getParameter("isJSX"));
	
	/*经办人姓名*/
	String gestoresName = request.getParameter("gestoresName");
	/*经办人联系地址*/
	String gestoresAddr = request.getParameter("gestoresAddr");
	/*经办人证件类型*/
	String gestoresIdType = request.getParameter("gestoresIdType");
	gestoresIdType = gestoresIdType.substring(0,gestoresIdType.indexOf("|"));
	
	String xsjbrxx=WtcUtil.repStr(request.getParameter("xsjbrxx"),"0");
	/*经办人证件号码*/
	String gestoresIccId = request.getParameter("gestoresIccId");
	System.out.println("-----------gaopeng---------gestoresName------------------------------"+gestoresName);
	System.out.println("-----------gaopeng---------gestoresAddr------------------------------"+gestoresAddr);
	System.out.println("-----------gaopeng---------gestoresIdType------------------------------"+gestoresIdType);
	System.out.println("-----------gaopeng---------gestoresIccId------------------------------"+gestoresIccId);
	
	/*实际使用人姓名*/
	String realUserName = WtcUtil.repStr(request.getParameter("realUserName"),"");
	/*实际使用人地址*/
	String realUserAddr = WtcUtil.repStr(request.getParameter("realUserAddr"),"");
	/*实际使用人证件号码*/
	String realUserIccId = WtcUtil.repStr(request.getParameter("realUserIccId"),"");
	/*实际使用人证件号码*/
	String realUserIdType = WtcUtil.repStr(request.getParameter("realUserIdType"),"");
	
	paraStr[49] = gestoresName;
	paraStr[50] = gestoresAddr;
	paraStr[51] = gestoresIdType;
	paraStr[52] = gestoresIccId;
	
	paraStr[53] = realUserIdType;
	paraStr[54] = realUserIccId;
	paraStr[55] = realUserName;
	paraStr[56] = realUserAddr;
	
	
	
	
	//20091201 begin 号码过户限制信息串:是否允许过户标志~允许过户时间
	String GoodPhoneFlag=WtcUtil.repNull(request.getParameter("GoodPhoneFlag"));
	String GoodPhoneDate=WtcUtil.repNull(request.getParameter("GoodPhoneDate"));	
	//20091201 end
   for(int i = 0; i<paraStr.length; i++)
   	System.out.println("#########################fe972Cfm->paraStr["+i+"]->"+paraStr[i]);
   	
		/**********************************************************************
		 *@ 服务名称：sE972Cfm
		 *@ 编码日期：2012/08/05
		 *@ 服务版本: Ver1.0
		 *@ 编码人员：chenlina
		 *@ 功能描述：宽带过户确认服务
		 *@input parameter information
		 *@inparam0		loginAccept			流水	可以输入，如果不输入则在服务中取流水
		 *@inparam1   chnSource			渠道标识
		 *@inparam2		opCode				操作代码
		 *@inparam3		loginNo				操作工号
		 *@inparam4		loginPasswd			操作工号密码
		 *@inparam5		iPhoneNo			服务号码
		 *@inparam6		userPwd				用户密码
		 *@inparam7		cfmLogin			宽带账号
		 *@inparam8		orgCode				操作工号归属
		 *@inparam9		idNo				用户ID
		 *@inparam10	newCustID			新客户ID
		 *--------------------------------------------------------------*
		 *@inparam11	vNOrg				新客户归属网点
		 *@inparam12	vNName				新客户名称
		 *@inparam13	vNPwd				新客户密码
		 *@inparam14	vNStatus			新客户状态
		 *@inparam15	vNGrade				新客户级别
		 *@inparam16	vNHomeAddr			新客户地址
		 *@inparam17	vNIdType			新客户证件类型
		 *@inparam18	vNIdNum				新客户证件号码
		 *@inparam19	vNIdAddr			新客户证件地址
		 *@inparam20	vNIdDate			新客户证件有效期
		 *@inparam21	vNConName			新客户联系人姓名
		 *@inparam22	vNConTel			新客户联系人电话
		 *@inparam23	vNConAddr			新客户联系人地址
		 *@inparam24	vNConPostNum		新客户联系人邮编
		 *@inparam25	vNConPostAddr		新客户联系人通讯地址
		 *@inparam26	vNConFax			新客户联系人传真
		 *@inparam27	vNConEMail			新客户联系人电子信箱
		 *@inparam28	vNSex				新客户性别
		 *@inparam29	vNBirth				新客户出生日期
		 *@inparam30	vNWork				新客户职业类型
		 *@inparam31	vNEduLevel			新客户学历
		 *@inparam32	vNLove				新客户爱好
		 *@inparam33	vNHabit				新客户习惯
		 *--------------------------------------------------------------*
		 *@inparam34	payFee				应收
		 *@inparam35	realFee				实收
		 *@inparam36	systemNote			系统备注
		 *@inparam37	opNote				用户备注
		 *@inparam38	ipAddr				IP地址
		 *--------------------------------------------------------------*
		 *@inparam39	cust_name			担保人姓名
		 *@inparam40    contact_phone		担保人联系电话
		 *@inparam41    id_type				担保人证件类型
		 *@inparam42    id_iccid			担保人证件号码
		 *@inparam43    id_address	 		担保人证件地址
		 *@inparam44    contact_address		担保人联系地址
		 *@inparam45    notes				担保备注
		 *@inparam46    iCreditValue		信誉度
		 *@inparam47    chPrintQueryFlag		是否允许查询详单
		 *@			号码过户限制信息串 20091201 add by fengry
		 *--------------------------------------------------------------*
		
		 *@output parameter information
		 *@outparam	loginAccept		流水	返回在服务中生成的流水，或还原传入的流水
		 *@return SVR_ERR_NO
		 */
		/********************************************************************/


    //SPubCallSvrImpl im1210=new SPubCallSvrImpl();
    //String[] fg=im1210.callService("s1238Cfm", paraStr,"2");
%>
		<wtc:service name="sE972Cfm" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=paraStr[0]%>"/>
		<wtc:param value="<%=paraStr[1]%>"/> 
		<wtc:param value="<%=paraStr[2]%>"/>
		<wtc:param value="<%=paraStr[3]%>"/>
		<wtc:param value="<%=paraStr[4]%>"/>
		<wtc:param value="<%=paraStr[5]%>"/> 
		<wtc:param value="<%=paraStr[6]%>"/>
		<wtc:param value="<%=paraStr[7]%>"/>	
		<wtc:param value="<%=paraStr[8]%>"/>
		<wtc:param value="<%=paraStr[9]%>"/> 
		<wtc:param value="<%=paraStr[10]%>"/>
		<wtc:param value="<%=paraStr[11]%>"/> 
		<wtc:param value="<%=paraStr[12]%>"/>
		<wtc:param value="<%=paraStr[13]%>"/>
		<wtc:param value="<%=paraStr[14]%>"/>
		<wtc:param value="<%=paraStr[15]%>"/> 
		<wtc:param value="<%=paraStr[16]%>"/>
		<wtc:param value="<%=paraStr[17]%>"/>	
		<wtc:param value="<%=paraStr[18]%>"/>
		<wtc:param value="<%=paraStr[19]%>"/> 
		<wtc:param value="<%=paraStr[20]%>"/>
		<wtc:param value="<%=paraStr[21]%>"/> 
		<wtc:param value="<%=paraStr[22]%>"/>
		<wtc:param value="<%=paraStr[23]%>"/>
		<wtc:param value="<%=paraStr[24]%>"/>
		<wtc:param value="<%=paraStr[25]%>"/> 
		<wtc:param value="<%=paraStr[26]%>"/>
		<wtc:param value="<%=paraStr[27]%>"/>	
		<wtc:param value="<%=paraStr[28]%>"/>
		<wtc:param value="<%=paraStr[29]%>"/>
		<wtc:param value="<%=paraStr[30]%>"/>
		<wtc:param value="<%=paraStr[31]%>"/> 
		<wtc:param value="<%=paraStr[32]%>"/>
		<wtc:param value="<%=paraStr[33]%>"/>
		<wtc:param value="<%=paraStr[34]%>"/>
		<wtc:param value="<%=paraStr[35]%>"/> 
		<wtc:param value="<%=paraStr[36]%>"/>
		<wtc:param value="<%=paraStr[37]%>"/>	
		<wtc:param value="<%=paraStr[38]%>"/>
		<wtc:param value="<%=paraStr[39]%>"/> 
		<wtc:param value="<%=paraStr[40]%>"/>
		<wtc:param value="<%=paraStr[41]%>"/> 
		<wtc:param value="<%=paraStr[42]%>"/>
		<wtc:param value="<%=paraStr[43]%>"/>
		<wtc:param value="<%=paraStr[44]%>"/>
		<wtc:param value="<%=paraStr[45]%>"/>
		<wtc:param value="<%=paraStr[46]%>"/>
		<wtc:param value="<%=paraStr[47]%>"/>
		
			
			<%
		    String loginacceptJTrc=WtcUtil.repNull(request.getParameter("loginacceptJT"));
		    String pinjiecanshu="";
          if(!"".equals(loginacceptJTrc)) {
          pinjiecanshu="1";
          }else {
          pinjiecanshu="";
        	}
          
    /*当选择单位开户时,再传值*/
    	if(paraStr[48].equals("1")||xsjbrxx.equals("1")){
    	String inputStr11 = paraStr[49]+"|"+paraStr[51]+"|"+paraStr[52]+"|"+paraStr[50]+"|"+paraStr[53]+"|"+paraStr[54]+"|"+paraStr[55]+"|"+paraStr[56]+"|"+pinjiecanshu+"|"+zerenrenstrss ;
    %>
    
      <wtc:param value="<%=inputStr11%>"/>
    <%
    	}else{
    	String inputStr22 = ""+"|"+""+"|"+""+"|"+""+"|"+paraStr[53]+"|"+paraStr[54]+"|"+paraStr[55]+"|"+paraStr[56]+"|"+pinjiecanshu+"|"+"|"+"|"+"|" ;
    %>	
    	<wtc:param value="<%=inputStr22%>"/>
    <%	
    	}
    %>					
			
		</wtc:service>
		<wtc:array id="s1238CfmArr" scope="end"/>



<%
	 	System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
		String s1238LoginAccept = s1238CfmArr.length>0?s1238CfmArr[0][1]:"";
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraStr[0]+"&pageActivePhone="+srv_no+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime;
	  System.out.println("--------------统一接触url----:"+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%	
	 	System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
%>


<%	
		String vPostFlag = s1238CfmArr.length>0?s1238CfmArr[0][0]:"";		
		retCode = retCode1==""?retCode:retCode1;
		retMsg = retMsg1;
		System.out.println("--liujian--e972--retCode=" + retCode);
    if(retCode != null && retCode.equals("000000"))
    {
      String vPostContent = "";
      if(vPostFlag.equals("Y"))
      {
        vPostContent = ",该用户办理过邮寄帐单业务，请提醒用户更改邮寄地址";
      }

%>
      <script language="javascript">
	     	 rdShowMessageDialog("宽带过户成功！",2);  
         removeCurrentTab();
	    </script>
<%
   }else{
%>
   <script>
	   rdShowMessageDialog('错误<%=retCode%>：'+'<%=retMsg%>，请重新操作！');
	   removeCurrentTab();
	 </script>
<%
   }
%>
