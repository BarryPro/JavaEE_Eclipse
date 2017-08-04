 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-07 页面改造,修改样式
	********************/
%>  
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
	String opCode = "5254";	
	String opName = "空中充值代理商修改";	//header.jsp需要的参数   
	
  	String myretFlag="",myretMsg="";//用于判断页面刚进入时的正确性
  	
	//读取session信息	
	String loginNo = (String)session.getAttribute("workNo");    //工号 
	String nopass = (String)session.getAttribute("password");		
	String regionCode = (String)session.getAttribute("regCode"); 
	
	String loginAccept=getMaxAccept();
	System.out.println("loginAccept==================="+loginAccept);
	String groupId = request.getParameter("groupId");							//代理商编号
	String agentName = request.getParameter("agentName");					//代理商名称
	String agentAddress = request.getParameter("agentAddress");		//代理商地址
	String agtStatus = request.getParameter("agtStatus");				//充值帐户状态
	String regionCode2 = request.getParameter("regionCode");			//地市代码
	String districtCode2 = request.getParameter("districtCode");	//区县代码
	String legalPresent = request.getParameter("legalPresent");		//法人代表姓名 
	String legalId = request.getParameter("legalId");							//法人代表身份证号
	String angentClass = request.getParameter("angentClass");			//网点类型
	String zip = request.getParameter("zip");											//邮编
	String contactName = request.getParameter("contactName");			//联系人姓名
	String contactId = request.getParameter("contactId");					//联系人身份证
	String contactPhone = request.getParameter("contactPhone");		//联系人电话
	String bankName = request.getParameter("bankName");						//开户银行
	String accountNo = request.getParameter("accountNo");					//相应帐号
	String deposit = request.getParameter("deposit");							//押金金额
	String pb_size = request.getParameter("pb_size");							//牌匾尺寸
	String signTime = request.getParameter("signTime");						//签约时间	
	String agentPhone = request.getParameter("agentPhone");				//捆绑手机号
	String UserPassword = request.getParameter("UserPassword");		//帐户密码
	String UserCode = request.getParameter("UserCode");						//充值帐户号码
	String UserStatus = request.getParameter("UserStatus");				//充值帐户状态
	String opNote = request.getParameter("opNote");								//备注
	
	String isG3= request.getParameter("is_ghtree");
	String g3roleCode  = request.getParameter("g3roleCode");
	String gThreePhone = request.getParameter("gthree_phone");
	String parterId = request.getParameter("parterid");
	
	System.out.println("ningtn  5254  agentPhone " + agentPhone);
	//begin add by zhenghan 2009-07-09 增加"网点是否为公司现有其他实体渠道"
	String entryType = request.getParameter("entryType");					//备注
	String Entity_groupId = request.getParameter("Entity_groupId");	//网点是否为公司现有其他实体渠道
	if("0".equals(entryType))
	{
		Entity_groupId="";
	}
	//end
	
	String retMsg = null;
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();	

	/****************调用  sDemoGetMsg  ***********************/
  
	String[] paraStrIn = new String[30];

	paraStrIn[0] = loginNo;                   //工号
	paraStrIn[1] = nopass;                    //工号密码
	paraStrIn[2] = groupId;                 	//代理商编号 
	paraStrIn[3] = agentName;									//代理商名称
	paraStrIn[4] = agentAddress;							//代理商地址
	paraStrIn[5] = agtStatus;									//代理商状态
	paraStrIn[6] = regionCode2;								//地市代码
	paraStrIn[7] = districtCode2;							//区县代码
	paraStrIn[8] = legalPresent;							//法人代表姓名
	paraStrIn[9] = legalId;										//法人代表身份证号
	paraStrIn[10] = angentClass;							//网点类型
	paraStrIn[11] = zip;											//邮编
	paraStrIn[12] = contactName;							//联系人姓名
	paraStrIn[13] = contactId;								//联系人身份证号
	paraStrIn[14] = contactPhone;							//联系人电话
	paraStrIn[15] = bankName;									//开户银行
	paraStrIn[16] = accountNo;								//相应帐号
	paraStrIn[17] = deposit;									//押金金额
	paraStrIn[18] = pb_size;									//牌匾尺寸
	paraStrIn[19] = signTime;									//签约时间			
	paraStrIn[20] = agentPhone;               //捆绑手机号码
	paraStrIn[21] = UserCode;                 //账号
	paraStrIn[22] = UserStatus;								//充值帐户状态
	paraStrIn[23] = opNote;                   //备注信息
	paraStrIn[24] = loginAccept; 
	paraStrIn[25] = Entity_groupId;            //网点所在的实体渠道
	
	paraStrIn[26] = isG3;            					//是否G3销售代理商
	paraStrIn[27] = g3roleCode;            		//g3角色
	paraStrIn[28] = gThreePhone;            	//登陆电话号
	paraStrIn[29] = parterId;                 //合作伙伴代码
	
	String srvName = "s5254Cfm";              //服务名
	//String outParaNums = "0";                 //输出参数个数
	//impl.callFXService(srvName, paraStrIn,outParaNums,"region",regionCode);
	%>
	
	<wtc:service name="<%=srvName%>" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:params value="<%=paraStrIn%>"/>
	</wtc:service>
	
	<%    
	String returnCode="0";  //错误代码	        
	String returnMsg=""; //错误信息
		
		returnCode=retCode1; //错误代码
		System.out.println("returnCode=============:"+returnCode);		
		returnMsg=retMsg1;//错误信息
		System.out.println("returnMsg===========:"+returnMsg);
	

	if("000000".equals(returnCode)){
		retMsg = "空中充值代理商修改成功";
		%>
		
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",2);
		    history.go(-1);
		</script>
	<%}else{
		retMsg = returnMsg;%>
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",0);
		    history.go(-1);
		</script>
	<%}
	

%>

<% 
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+returnCode+"&retMsgForCntt="+returnMsg+"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+loginAccept+"&pageActivePhone="+agentPhone+"&opBeginTime="+opBeginTime+"&contactId="+agentPhone+"&contactType=user";
%>

<jsp:include page="<%=url%>" flush="true" />
