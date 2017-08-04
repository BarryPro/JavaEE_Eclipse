 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-04 页面改造,修改样式
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%

	String opCode = "5252";	
	String opName = "空中充值代理商注册";	//header.jsp需要的参数   

	String loginAccept = getMaxAccept();
  	
	//读取session信息	
	//String loginNo = baseInfoSession[0][2];
	String loginNo = (String)session.getAttribute("workNo");    //工号 
	String nopass = (String)session.getAttribute("password");
		
	String groupId = request.getParameter("groupId");							//代理商编号
	String agentName = request.getParameter("agentName");					//代理商名称
	String agentAddress = request.getParameter("agentAddress");		//代理商地址
	String regionCode = request.getParameter("regionCode");				//地市代码
	String districtCode = request.getParameter("districtCode");		//区县代码
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
	String opNote = request.getParameter("opNote");								//备注
	//begin add by zhenghan 2009-07-09 增加"网点是否为公司现有其他实体渠道"
	String entryType = request.getParameter("entryType");					//备注
	String Entity_groupId = request.getParameter("Entity_groupId");	//网点是否为公司现有其他实体渠道
	if("0".equals(entryType))
	{
		Entity_groupId="";
	}
	//end
	//20141009增加G3代理商属性
	String isgThree =  request.getParameter("is_ghtree");	
	String g3roleCode =  request.getParameter("g3roleCode");	
	String gthreePhone = request.getParameter("gthree_phone");
	String parterid = request.getParameter("parterid");	
	
	String retMsg = null;
	String returnCode="0";
 	String returnMsg="";

	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//ArrayList retList = new ArrayList();
	String mysql = "select contract_passwd from dconmsg where contract_no = '" + UserCode + "'";
	String outParaNums = "1";
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="<%=outParaNums%>">
		<wtc:sql><%=mysql%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="retList" scope="end" />
	
	<%

	//retList = impl.sPubSelect(outParaNums,mysql,"region",regionCode);
	//System.out.println("retList================"+retList.length);
	//System.out.println("retList================"+retList[0][0]);
	//System.out.println("retCode1================"+retCode1);
	//System.out.println("retMsg1================"+retMsg1);
	String[][] retListString = null;

	if(retList != null){
		//retListString = (String[][])retList.get(0);
		retListString=retList;
		
 		if(retList.length==0){
			System.out.println("账户不存在");
		}
		if(1==Encrypt.checkpwd1(UserPassword,retListString[0][0])){
			String[] paraStrIn = new String[28];
			paraStrIn[0] = loginNo;                   //工号
			paraStrIn[1] = nopass;                    //工号密码
			paraStrIn[2] = groupId;                 	//代理商编号 
			paraStrIn[3] = agentName;									//代理商名称
			paraStrIn[4] = agentAddress;							//代理商地址
			paraStrIn[5] = regionCode;								//地市代码
			paraStrIn[6] = districtCode;							//区县代码
			paraStrIn[7] = legalPresent;							//法人代表姓名
			paraStrIn[8] = legalId;										//法人代表身份证号
			paraStrIn[9] = angentClass;								//网点类型
			paraStrIn[10] = zip;											//邮编
			paraStrIn[11] = contactName;							//联系人姓名
			paraStrIn[12] = contactId;								//联系人身份证号
			paraStrIn[13] = contactPhone;							//联系人电话
			paraStrIn[14] = bankName;									//开户银行
			paraStrIn[15] = accountNo;								//相应帐号
			paraStrIn[16] = deposit;									//押金金额
			paraStrIn[17] = pb_size;									//牌匾尺寸
			paraStrIn[18] = signTime;									//签约时间			
			paraStrIn[19] = agentPhone;               //捆绑手机号码
			paraStrIn[20] = UserCode;                 //账号
			paraStrIn[21] = opNote;                   //备注信息8
		  paraStrIn[22] = loginAccept;
		  paraStrIn[23] = Entity_groupId;            //网点所在的实体渠道
		  //add by wanglz 20141009
		  paraStrIn[24] = isgThree;									 //是否销售G3产品
		  paraStrIn[25] = g3roleCode;								 //G3角色
		  paraStrIn[26] = gthreePhone;               //G3登陆手机号
			paraStrIn[27] = parterid;                  //供货商代码
		  
			String srvName = "s5252Cfm"; //服务名1
			//String outParaNums1 = "0"; //输出参数个数
			String outParaNums1 = "0"; //输出参数个数
			//impl.callFXService(srvName, paraStrIn,outParaNums1,"region",regionCode);
			System.out.println("===========================");
 			%>
 			<wtc:service name="<%=srvName%>" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2" >
				<wtc:param value="<%=paraStrIn[0]%>"/>
				<wtc:param value="<%=paraStrIn[1]%>"/>
				<wtc:param value="<%=paraStrIn[2]%>"/>
				<wtc:param value="<%=paraStrIn[3]%>"/>
				<wtc:param value="<%=paraStrIn[4]%>"/>
				<wtc:param value="<%=paraStrIn[5]%>"/>
				<wtc:param value="<%=paraStrIn[6]%>"/>
				<wtc:param value="<%=paraStrIn[7]%>"/>
				<wtc:param value="<%=paraStrIn[8]%>"/>
				<wtc:param value="<%=paraStrIn[9]%>"/>
				<wtc:param value="<%=paraStrIn[10]%>"/>
				<wtc:param value="<%=paraStrIn[11]%>"/>
				<wtc:param value="<%=paraStrIn[12]%>"/>
				<wtc:param value="<%=paraStrIn[13]%>"/>
				<wtc:param value="<%=paraStrIn[14]%>"/>
				<wtc:param value="<%=paraStrIn[15]%>"/>
				<wtc:param value="<%=paraStrIn[16]%>"/>
				<wtc:param value="<%=paraStrIn[17]%>"/>
				<wtc:param value="<%=paraStrIn[18]%>"/>
				<wtc:param value="<%=paraStrIn[19]%>"/>
				<wtc:param value="<%=paraStrIn[20]%>"/>
				<wtc:param value="<%=paraStrIn[21]%>"/>		
				<wtc:param value="<%=paraStrIn[22]%>"/>				
				<wtc:param value="<%=paraStrIn[23]%>"/>		
				<wtc:param value="<%=paraStrIn[24]%>"/>	
				<wtc:param value="<%=paraStrIn[25]%>"/>	
				<wtc:param value="<%=paraStrIn[26]%>"/>	
				<wtc:param value="<%=paraStrIn[27]%>"/>
			</wtc:service>
			
 			<%
 				System.out.println("+++++++++++++++++++++++++++");				
 			
				returnCode = retCode2 ;//错误代码
				System.out.println("returnCode999999999:"+returnCode);
				returnMsg = retMsg2; //错误信息
				System.out.println("returnMsg99999999:"+returnMsg);
		
			if(returnCode.equals("000000")){
				retMsg = "空中充值代理商注册成功";
			}else{
				retMsg = returnMsg;
			}

		}else{
			retMsg = "充值帐户号码或密码有误";
		}
	}
	if(retMsg.equals("空中充值代理商注册成功")){
%>

	<script language="JavaScript">	  
	    rdShowMessageDialog("<%=retMsg%>",2);
	    history.go(-1);
	</script>
<%}else{%>
	<script language="JavaScript">	  
	    rdShowMessageDialog("<%=retMsg%>",0);
	    history.go(-1);
	</script>
<%}%>

<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+returnCode+"&retMsgForCntt="+returnMsg+"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+loginAccept+"&pageActivePhone="+agentPhone+"&opBeginTime="+opBeginTime+"&contactId="+agentPhone+"&contactType=user";%>
<jsp:include page="<%=url%>" flush="true" />
