<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-13 页面改造,修改样式
* 
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%!
/*2014/10/08 10:03:04 gaopeng 关于完善BOSS和经分系统客户信息模糊化展示的函（201409） 
	模糊化公共方法 objType 1 客户名称 账户名称 2其他（各种地址等）
*/
private String vagueFunc(String objName,int objType){
	if(objName != null && !"".equals(objName) && !"NULL".equals(objName)){
		if(objType == 1){
			if(objName.length() == 2 ){
				objName = objName.substring(0,1)+"*";
			}
			if(objName.length() == 3 ){
				objName = objName.substring(0,1)+"**";
			}
			if(objName.length() == 4){
				objName = objName.substring(0,2)+"**";
			}
			if(objName.length() > 4){
				objName = objName.substring(0,2)+"******";
			}
		}else if(objType == 2){
			objName = "********";
		}
		
	}
	return objName;
}
%>

<%

	String opCode = "1500";
	String opName = "综合信息查询";
	
	String inStr  = (String)request.getAttribute("parStr");//得到传入参数
	
	System.out.println("inStr==============="+inStr);
	if(inStr == null){
		inStr = (String)request.getParameter("parStr");
	}
	int pos = inStr.indexOf("|");
	String phoneNo  = inStr.substring(0,pos);//手机号码
	String idNo  = inStr.substring(12,inStr.length());//ID号
	String phonePwd  = (String)request.getAttribute("pwd");//得到传入参数
	if(phonePwd == null){
		phonePwd = (String)request.getParameter("pwd");
	}
	String queryType  = (String)request.getAttribute("queryType");//得到传入参数
	if(queryType == null){
		queryType = (String)request.getParameter("queryType");
	}
	
	/*gaopeng 2014/01/15 10:04:05 发现f1500_2.jsp中传到f1500_Main.jsp的passFlag参数未接受 关于实名登记BOSS审批增加报表的需求 */
	String passFlag  = (String)request.getAttribute("passFlag");//得到传入参数
	if(passFlag == null){
		passFlag = (String)request.getParameter("passFlag");
	}
	System.out.println("gaopengSeeLog=============passFlag="+passFlag);

	String workNoAccountType = (String)session.getAttribute("accountType"); 		//wanghfa 添加 为判断是否为客服工号
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String powerName = (String)session.getAttribute("powerRight");
	String deptCode = (String)session.getAttribute("orgCode");
	String ip_Addr = "172.16.23.13";
	String regionCode = deptCode.substring(0,2);
	String password = (String)session.getAttribute("password"); //diling add for 安全加固
	String custLevelVal = "";//客户等级
	String custLevelStartTime = "";//客户等级开始时间
	String custLevelEndTime = "";//客户等级结束时间
	String innetYear = ""; /*用户入网的总年份数（取整数）*/ 
	String innetDay =""; /*用户入网除去整年之后剩余的天数（取整数）*/ 
	String innetInfo = "";
	String passValidateFlag = "";

	/* ningtn@20100707 修改页面数据显示方式 start */
	String custNameStr 			 = "";
	String custAddressStr 		 = "";
	String idIccidStr 			 = "";
	String idAddressStr 		 = "";
	String contactPersonStr      = "";
	String contactPhoneStr       = "";
	String contactAddressStr     = "";
	String contactPostStr        = "";
	String contactAddress1Str    = "";
	String contactMailaddressStr = "";
	String contactFaxStr         = "";
	String conNameStr = "";
	String pwdcheck = "N";
	/* ningtn@20100707 修改页面数据显示方式 end */
	
/**
	ArrayList arlist = new ArrayList();
	try
	{	//System.out.println("--------------5555555-------------");
		s1500View viewBean = new s1500View();//实例化viewBean
		arlist = viewBean.view_s1500Qry(phoneNo,idNo); 
		//System.out.println("--------------5555555-------------");
	}
	catch(Exception e)
	{
		//System.out.println("调用EJB发生失败！");
	}
	**/
	
	/* gaopeng 2014/01/14 10:12:18  关于实名登记BOSS审批增加报表的需求 加入经办人信息的展示*/
	String gestoresName = "";
	String gestoresAddr = "";
	String gestoresIccId = "";
	String gestoresIdType = "";
	String gestoresIdTypeName = "";
	
	String responsibleName="";
	String responsibleAddr="";
	String responsibleType="";
	String responsibleIccId="";
	String responsibleTypeName="";
	
	/* begin add for 关于开发智能终端CRM模式APP的函 - 第三批@2015/3/30 */
	String realUserName = "";
	String realUserAddr = "";
	String realUserIdType = "";
	String realUserIccId = "";
%>

  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

	<wtc:service name="s1500Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="29">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=phonePwd%>"/>
	<wtc:param value="<%=idNo%>"/>
	</wtc:service>
	<wtc:array id="mainQryArr" scope="end"/>	
<%

	String xq_info_old = "";
	String xq_info_new = "";
	
	if(mainQryArr.length>0){
		xq_info_old = mainQryArr[0][25]+"--"+mainQryArr[0][23];
		xq_info_new = mainQryArr[0][26]+"--"+mainQryArr[0][24];
	}
		
	String oBroadBand = "";
	if(mainQryArr.length>0){
		oBroadBand = mainQryArr[0][27];
	}
	System.out.println("---hejwa------------oBroadBand------------->"+oBroadBand);
	
	String initoBroadBand = "";
	if(mainQryArr.length>0){
		initoBroadBand = mainQryArr[0][28];
	}
	System.out.println("---hejwa------------initoBroadBand------------->"+initoBroadBand);

 System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
 String retCodeForCntt = retCode1;
 String loginAccept =""; 
 String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo;
 System.out.println("url="+url);
 System.out.println("%%%%%%%调用统一接触结束%%%%%%%%");    
%>
<jsp:include page="<%=url%>" flush="true" />
<%
	if(!retCode1.equals("000000")){
%>
	<script language="javascript">
		rdShowMessageDialog("服务未能成功,服务代码<%=retCode1%><br>服务信息<%=retMsg1%>!");
		parent.removeTab("<%=opCode%>");
	</script>
<%
		return;
	}else if(mainQryArr==null||mainQryArr.length==0){
%>
	<script language="javascript">
		rdShowMessageDialog("查询结果为空,无此条件信息的相关内容!");
		parent.removeTab("<%=opCode%>");
	</script>
<%
		return;
	}
	
	//循环取值,并将结果储存在list中
	ArrayList arlist = new ArrayList();
	StringTokenizer resToken = null;
  for(int i = 0; i<mainQryArr.length; i++){
  System.out.println("wanghyd--gaopengSeeLog20151207----值得-mainQryArr[i][0]----"+mainQryArr[i][0]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][1]---"+mainQryArr[i][1]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][2]---"+mainQryArr[i][2]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][3]---"+mainQryArr[i][3]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][4]---"+mainQryArr[i][4]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][5]---"+mainQryArr[i][5]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][6]---"+mainQryArr[i][6]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][7]---"+mainQryArr[i][7]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][8]---"+mainQryArr[i][8]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][9]---"+mainQryArr[i][9]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][10]---"+mainQryArr[i][10]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][11]---"+mainQryArr[i][11]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][12]---"+mainQryArr[i][12]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][13]---"+mainQryArr[i][13]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][23]---"+mainQryArr[i][23]);
  System.out.println("wanghyd--gaopengSeeLog20151207----值得--mainQryArr[i][24]---"+mainQryArr[i][24]);

  	for(int j=0;j<mainQryArr[i].length;j++){
  		String value;
      for(resToken = new StringTokenizer(mainQryArr[i][j], "|"); resToken.hasMoreElements(); arlist.add(value)){
          value = (String)resToken.nextElement();
          System.out.println("gaopengSeeLog20151207===="+arlist.size()+"wanghyd-----------"+value);
      }
    }
  }
  passValidateFlag = (String)arlist.get(70);
  /*2015/12/7 10:40:17 gaopeng
 	 是否volte开户
 	*/
  String ifVolte = "否";
  String arr44 = (String)arlist.get(44);
  String arr45 = (String)arlist.get(45);
  String arr46 = (String)arlist.get(46);
  if(arr44.indexOf("volte") != -1){
  	ifVolte = "是";
  }
  if(arr45.indexOf("volte") != -1){
  	ifVolte = "是";
  }
  if(arr46.indexOf("volte") != -1){
  	ifVolte = "是";
  }
  
  /* begin add for 关于开发智能终端CRM模式APP的函 - 第三批@2015/3/30 */
  if(arlist.size() > 80 ){
  	realUserName = (String)arlist.get(79);
  	realUserAddr = (String)arlist.get(80);
  	realUserIdType = (String)arlist.get(77);
  	realUserIccId = (String)arlist.get(78);
  }
  /* end add for 关于开发智能终端CRM模式APP的函 - 第三批@2015/3/30 */
  
  /* ningtn 铁通账号 样式控制*/
  String broadStyle = "none;";
  String simStyle = "block;";
  if("GH".equals((String)arlist.get(66))
   ||"kd".equals((String)arlist.get(66))
   ||"ke".equals((String)arlist.get(66))
   ||"kf".equals((String)arlist.get(66))
   ||"kg".equals((String)arlist.get(66))
   ||"kh".equals((String)arlist.get(66))
   ||"CT".equals((String)arlist.get(66))){
   broadStyle = "block";
   simStyle = "none";
  }
    //从这里开始取值了
    String return_code = (String)arlist.get(0);
    String return_message =(String)arlist.get(1);
    
    String sql="select trim(phone_no) from wPrepayPhoneSaleOpr where second_id=to_number('"+idNo+"') and op_code='8042' and back_flag='0'";
    String sql2 = "select trim(t.true_code) from dtruenamemsg t where id_no = to_number('"+idNo+"')";
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
	<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="mainPhoneArr" scope="end" />
	<%
		/*2015/7/13 16:17:54 gaopeng R_CMI_HLJ_guanjg_2015_2303829@关于优化实名标识系列功能的需求示 
			查询实名制标识
		*/
	%>	
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode3" retmsg="retMsg3" outnum="1">
	<wtc:sql><%=sql2%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="trueNameArr" scope="end" />
<%
	String mainPhone="";
	if(mainPhoneArr.length>0){
		mainPhone=mainPhoneArr[0][0];
	}else{
		mainPhone="无";
	}
	/*2015/7/13 16:17:54 gaopeng R_CMI_HLJ_guanjg_2015_2303829@关于优化实名标识系列功能的需求示 
			查询实名制标识
		*/
	boolean trueNameFlag = true;
	if(trueNameArr.length > 0){
		System.out.println("gaopengSeeLogqueryType======queryType=="+queryType);
		if("0".equals(queryType)){
		
			if(!"1".equals(trueNameArr[0][0])&&!"".equals(trueNameArr[0][0])){
				trueNameFlag = false;
			}
			
		}else{
			trueNameFlag = true;
		}
		
	}
	
	
	if (!return_code.equals("000000")){
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=return_message%><br>服务代码 :<%=return_code%>");
	history.go(-1);
</script>
<%	
	}else{
	String userInfo1 = (String)arlist.get(29);
	String highmsg=(String)arlist.get(30);
	String ss="中高段用户";
	int spos=highmsg.indexOf(ss,0);
%>
<script>
	if(<%=spos%>>=0){rdShowMessageDialog("该用户是中高端用户！");}
	var userInfo = "<%= userInfo1 %>" ;
	
	var userType = oneTok(userInfo,"~",1);
	var stopFlag = oneTok(userInfo,"~",2);
	var stopDesc = "";
	if ( stopFlag == "N" )
		stopDesc = "免停用户";
	else
		stopDesc = "非免停用户";
		
</script>
<%
}
%>

<%
/* ningtn@20100707 修改页面数据显示方式 start */

		custNameStr 		  = (String)arlist.get(3);
		custAddressStr 		  = (String)arlist.get(9);
		idIccidStr 			  = (String)arlist.get(11);
		idAddressStr 		  = (String)arlist.get(12);
		contactPersonStr      = (String)arlist.get(14);
		contactPhoneStr       = (String)arlist.get(15);
		contactAddressStr     = (String)arlist.get(16);
		contactPostStr        = (String)arlist.get(17);
		contactAddress1Str    = (String)arlist.get(18);
		contactMailaddressStr = (String)arlist.get(20);
		contactFaxStr         = (String)arlist.get(19);
		conNameStr         = (String)arlist.get(48);
		pwdcheck 						= (String)arlist.get(70);

/* ningtn@20100707 修改页面数据显示方式 end */
%>
<% 
	/*gaopeng 2013/12/17 15:43:00  关于在BOSS入网界面增加单位客户经办人信息的函 调用服务返回 经办人信息*/
 %>
<wtc:service name="sCustOprMsgQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeC1" retmsg="retMsgC1" outnum="8" >
    <wtc:param value="<%=printAccept%>"/>
    <wtc:param value="01"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=workNo%>"/>	
    <wtc:param value="<%=password%>"/>		
    <wtc:param value="<%=phoneNo%>"/>	
    <wtc:param value="<%=phonePwd%>"/>
    <wtc:param value="查询客户经办人信息"/>
    <wtc:param value="<%=(String)arlist.get(2)%>"/>
  </wtc:service>
  <wtc:array id="resultC1" scope="end"/>
  	
<%
	
	if("000000".equals(retCodeC1)){
		System.out.println("gaopengSeeLog=================调用sCustOprMsgQry服务成功！");
		
		gestoresName = resultC1[0][0];    
		gestoresAddr = resultC1[0][3];    
		gestoresIccId = resultC1[0][2];   
	  gestoresIdType = resultC1[0][1]; 
	  
	  responsibleName=resultC1[0][6];
	  responsibleAddr=resultC1[0][7];
	  responsibleType=resultC1[0][4];
	  responsibleIccId=resultC1[0][5];
	  
	  
	  System.out.println("gaopengSeeLog=================gestoresName="+gestoresName);
	  System.out.println("gaopengSeeLog=================gestoresAddr="+gestoresAddr);
	  System.out.println("gaopengSeeLog=================gestoresIccId="+gestoresIccId);
	  System.out.println("gaopengSeeLog=================gestoresIdType="+gestoresIdType);
	  
	  /*gaopeng 关于在BOSS入网界面增加单位客户经办人信息的函 调用TlsPubSelCrm 查询经办人证件类型名称展示在页面上，经办人证件类型不进行模糊校验。*/
	  String[] inParamsss1 = new String[2];
	  
		inParamsss1[0] = "select t.id_name from sidtype t where t.id_type=:s_idType";
		inParamsss1[1] = "s_idType="+gestoresIdType;
		
		%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeidTyp" retmsg="retMsgidTyp" outnum="1">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>	
		</wtc:service>

		<wtc:array id="s_idType0" scope="end" />
		
		
		<%
	  if("000000".equals(retCodeidTyp) && s_idType0.length > 0){
	  	gestoresIdTypeName = s_idType0[0][0];
	  	 System.out.println("gaopengSeeLog=================gestoresIdTypeName="+gestoresIdTypeName);
	  }
	  
	  
	 	  String[] inParamsss333 = new String[2];
	  
		inParamsss333[0] = "select t.id_name from sidtype t where t.id_type=:s_idType";
		inParamsss333[1] = "s_idType="+responsibleType;
		
		%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeidTypsdf" retmsg="retMsgidTypsdf" outnum="1">			
		<wtc:param value="<%=inParamsss333[0]%>"/>
		<wtc:param value="<%=inParamsss333[1]%>"/>	
		</wtc:service>

		<wtc:array id="s_idType33333" scope="end" />
		
		
		<%
	  if( s_idType33333.length > 0){
	  	responsibleTypeName = s_idType33333[0][0];
	  	System.out.println("gaopengSeeLog=================responsibleTypeName="+responsibleTypeName);
	  } 
	  
	  
	  
	}else{
		System.out.println("gaopengSeeLog=================调用sCustOprMsgQry服务失败！");
	}
%>
<%
/*gaopeng 2014/01/14 10:32:17 关于在BOSS入网界面增加单位客户经办人信息的函 获取权限*/
	boolean pwrf = false;
	String pubOpCode = opCode;
%>
<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>

<%

System.out.println("gaopengSeeLog==============init1====pwrf="+pwrf+"--passFlag="+passFlag+"---pwdcheck="+pwdcheck);
/*如果没有免密权限 并且 密码校验不通过*/
	if(!pwrf && !"0".equals(passFlag)){
	/* gaopeng 2014/01/14 10:59:51 经办人姓名模糊化处理*/
		if(gestoresName != null && !"".equals(gestoresName)){
			if(gestoresName.length() == 2 ){
				String custNameCut = gestoresName.substring(1,gestoresName.length());
				gestoresName = gestoresName.substring(0,1)+"*";
			}
			if(gestoresName.length() == 3 ){
				String custNameCut = gestoresName.substring(1,gestoresName.length());
				gestoresName = gestoresName.substring(0,1)+"**";
			}
			if(gestoresName.length() == 4){
				String custNameCut = gestoresName.substring(2,gestoresName.length());
				gestoresName = gestoresName.substring(0,2)+"**";
			}
			if(gestoresName.length() > 4){
				String custNameCut = gestoresName.substring(2,gestoresName.length());
				gestoresName = gestoresName.substring(0,2)+"******";
			}
		}
		if(gestoresAddr != null && !"".equals(gestoresAddr)){
			gestoresAddr = "********";
		}
		if(gestoresIccId != null && !"".equals(gestoresIccId)){
			gestoresIccId = "********";
		}
		System.out.println("gaopengSeeLog=================gestoresName="+gestoresName);
	  System.out.println("gaopengSeeLog=================gestoresAddr="+gestoresAddr);
	  System.out.println("gaopengSeeLog=================gestoresIccId="+gestoresIccId);
	  System.out.println("gaopengSeeLog=================gestoresIdType="+gestoresIdType);
	  System.out.println("gaopengSeeLog==============init2====pwrf="+pwrf);
	  /*2014/10/08 10:38:00 gaopeng 关于完善BOSS和经分系统客户信息模糊化展示的函（201409） 
	  	进行1500模糊化验证
	  */
	  
	  custNameStr 		      = vagueFunc(custNameStr,1);
		custAddressStr 		    = vagueFunc(custAddressStr,2);
		idIccidStr 			      = vagueFunc(idIccidStr,2);
		idAddressStr 		      = vagueFunc(idAddressStr,2);
		contactPersonStr      = vagueFunc(contactPersonStr,1);
		contactAddressStr     = vagueFunc(contactAddressStr,2);
		contactAddress1Str    = vagueFunc(contactAddress1Str,2);
		conNameStr            = vagueFunc(conNameStr,1);
		
		System.out.println("gaopengSeeLog=================custNameStr="+custNameStr);
		System.out.println("gaopengSeeLog=================custAddressStr="+custAddressStr);
		System.out.println("gaopengSeeLog=================idIccidStr="+idIccidStr);
		System.out.println("gaopengSeeLog=================idAddressStr="+idAddressStr);
		System.out.println("gaopengSeeLog=================contactPersonStr="+contactPersonStr);
		System.out.println("gaopengSeeLog=================contactAddressStr="+contactAddressStr);
		System.out.println("gaopengSeeLog=================contactAddress1Str="+contactAddress1Str);
		System.out.println("gaopengSeeLog=================conNameStr="+conNameStr);
	  
	  
	  
	  
	  	/* gaopeng 2014/01/14 10:59:51 经办人姓名模糊化处理*/
		if(responsibleName != null && !"".equals(responsibleName)){
			if(responsibleName.length() == 2 ){

				responsibleName = responsibleName.substring(0,1)+"*";
			}
			if(responsibleName.length() == 3 ){

				responsibleName = responsibleName.substring(0,1)+"**";
			}
			if(responsibleName.length() == 4){

				responsibleName = responsibleName.substring(0,2)+"**";
			}
			if(responsibleName.length() > 4){

				responsibleName = responsibleName.substring(0,2)+"******";
			}
		}
		if(responsibleAddr != null && !"".equals(responsibleAddr)){
			responsibleAddr = "********";
		}
		if(responsibleIccId != null && !"".equals(responsibleIccId)){
			responsibleIccId = "********";
		}

	
	}
	
	/*
		2015/06/15 15:33:25 gaopeng R_CMI_HLJ_guanjg_2015_2233990@关于在BOSS系统中特殊号码查询增加密码验证功能的请示
		查看详细优惠信息
	*/
	String canSeeXXYH = "";
%>

	<wtc:service name="sCommonCheck" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeXXYH" retmsg="retMsgXXYH" outnum="1">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=phonePwd%>"/>
		<wtc:param value="1"/>
		</wtc:service>
	<wtc:array id="XXYHRet" scope="end"/>	
		
<%
	if("000000".equals(retCodeXXYH) && XXYHRet.length > 0){
		if("0".equals(XXYHRet[0][0])){
			canSeeXXYH = "true";
		}else{
			canSeeXXYH = "false";
		}
	}else{
		canSeeXXYH = "false";
	}
	System.out.println("gaopengSeeLog1500-------canSeeXXYH===="+canSeeXXYH);
%>

<script>
	x = screen.availWidth;
	y = screen.availHeight;
	window.innerWidth = x;
	window.innerHeight = y;
</script>

<%--add by zhanghonga@20090107,版本合并时增加的新增内容--%>
<%
	String fee_return_code = "";//s1500_fee返回retCode
	String fee_return_msg = "";//s1500_fee返回retMsg
	String show_fee = ""; //当前预存;
	String prepayFee = "";//当前可划拨预存
	String nobillpay = ""; //未出账话费
	String now_prepayFee = "";//当前可用预存
	
	//liuxmc add 20100907 begin
	String zx_yc_fee = "";//专款预存余额
	String pt_yc_fee = "";//普通预存余额
	//liuxmc add 20100907 end
	/*wanghyd2012/9/12 10:41增加是否是底线资费用户*/
	String isdxzfflag=""; /*是否是底线类资费用户0不是 1是*/
	String dxzfmoney="";
%>
	<wtc:service name="s1500_feeVW" routerKey="region" routerValue="<%=regionCode%>" retcode="feeRetCode" retmsg="feeRetMsg" outnum="10">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=idNo%>"/>
	</wtc:service>
	<wtc:array id="s1500FeeArr" scope="end"/>
<%
	//System.out.println("###########################zhanghonga->feeRetCode->"+feeRetCode);
	
	//因为服务返回的retCode不规范,返回了只有一个"0",所以这样比较下
	if(Integer.parseInt(feeRetCode)==0){
		if(s1500FeeArr.length>0){
			fee_return_code = s1500FeeArr[0][0];
			fee_return_msg = s1500FeeArr[0][1];
			show_fee = s1500FeeArr[0][2]; //当前预存;
			prepayFee = s1500FeeArr[0][3];//当前可划拨预存
			nobillpay = s1500FeeArr[0][4]; //未出账话费
			now_prepayFee = s1500FeeArr[0][5];//当前可用预存
			
			//liuxmc add 20100907 begin
			zx_yc_fee=s1500FeeArr[0][6];
			pt_yc_fee=s1500FeeArr[0][7];
			isdxzfflag=s1500FeeArr[0][8];
			
			
			if(isdxzfflag!=null) {
					if(isdxzfflag.equals("1")) {
					isdxzfflag="是";
					dxzfmoney=s1500FeeArr[0][9];
					}else if(isdxzfflag.equals("0")) {
					isdxzfflag="否";
					dxzfmoney="--";
					}	
			}else {
					isdxzfflag="服务返回null";
					dxzfmoney="服务返回null";
			}																				
			
			
			/* ningtn */
			if(zx_yc_fee == null){
				zx_yc_fee = "";
			}
			if(pt_yc_fee == null){
				pt_yc_fee = "";
			}
			System.out.println("zx_yc_fee:"+zx_yc_fee);
			System.out.println("pt_yc_fee:"+pt_yc_fee);
			//liuxmc add 20100907 end
		}
	}
%>
<%--add by zhanghonga@20090107,版本合并时增加的新增内容到这里结束--%>
<%/*2015/3/23 15:34 gaopeng 关于客户星级改造内容20150311定版 加入计费测服务,返回 星级月均消费得分 和 星级网龄得分*/
	String custLevelFeeIntegral = "";
	String custLevelNetIntegral = "";
%>
	<wtc:service name="sLevelDetQry" routerKey="region" routerValue="<%=regionCode%>" retcode="feeRetCode22" retmsg="feeRetMsg22" outnum="10">
		<wtc:param value=""/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=workNo%>"/>
		</wtc:service>
	<wtc:array id="s1500FeeArr22" scope="end"/>

<%
	if(s1500FeeArr22.length>0 && "000000".equals(feeRetCode22)){
		
		custLevelFeeIntegral = s1500FeeArr22[0][4];
		custLevelNetIntegral = s1500FeeArr22[0][6];
		
	}


String s_FamUnbill = "0.00";

System.out.println("--------1500-----phoneNo------------->"+phoneNo);

%>
	<wtc:service name="sGet_FamUnbill" routerKey="region" routerValue="<%=regionCode%>" retcode="code_FamUnbill" retmsg="msg_FamUnbill" outnum="4">
		<wtc:param value="<%=phoneNo%>"/>
	</wtc:service>
	<wtc:array id="result_FamUnbill" scope="end"/>
<%

if(result_FamUnbill.length>0){
	try {
			float count_2_3 = java.lang.Float.parseFloat(result_FamUnbill[0][0]);
			
			java.text.DecimalFormat df = new java.text.DecimalFormat();
			df.applyPattern("0.00");
			s_FamUnbill = df.format(count_2_3);
			
		} catch (Exception e) {
		}
}

String s_MonthDOU = "";
%>
<wtc:service name="sFavSumMsg" routerKey="region" routerValue="<%=regionCode%>" retcode="code_MonthDOU" retmsg="msg_MonthDOU" outnum="4">
	<wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="result_MonthDOU" scope="end"/>
<%
if(result_MonthDOU.length>0){
		s_MonthDOU = result_MonthDOU[0][0];
}
%>
		
<HTML>
	<HEAD>
	<TITLE>综合信息查询</TITLE>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	
	<!---add by zhanghonga@20081225(圣诞节),应用户要求,修改&添加"其他信息"的样式,没放到公共css里,因为只有1500用到此样式--->
	<style>
	/*全局导航菜单定义*/
	#nav{
		list-style-type:none;
		padding:0px;
		margin-top: 2px;
		margin-right: 60px;
		margin-bottom: 0px;
		margin-left: 0px;
		float: right;
		line-height: 12px;
	 }
	 
	#nav dl {
		width: 68px;
		margin: 0;
		float: left;
		background-image: url(../../nresources/default/images/button_other.gif);
		background-repeat: no-repeat;
		height: 21px;
		padding-top: 4px;
		padding-right: 0;
		padding-bottom: 0;
		padding-left: 0px;
		color: #439337;
	}
	
	#nav dt {
		margin:0;
		padding-top: 0;
		padding-right: 0;
		padding-bottom: 0;
		padding-left: 0px;
		text-align: center;
	}

	#nav a{
		position:relative;
		text-decoration: none;
	}

	#nav a:hover{
		color: #FF9933;
		font-size: 12px;
		font-weight: normal;
		text-decoration: none;
	} 
 
	.showmenu_shadow{
		background:#e9e8e8;
		width:160px;
		position:absolute;
		z-index:500;
		display:none;
		text-align:left;
		right:0px;
	    filter: alpha(opacity=86);
	    -moz-opacity: .86;
	    margin-top:-8px;
	    font-size:12px;
		font-family:Tahoma,Arial, Helvetica, sans-serif;
	}
	.showmenu_shadow a,
	.showmenu_shadow a:link,
	.showmenu_shadow a:visited{
	 	display:block;
		padding:2px 0 0 5px;
		color:#289312;
		font-weight:bold;
		border-bottom:1px solid #addc61;
		height:22px;
		text-decoration:none;
	}	
	.showmenu_shadow a:hover{
		color:#cc0000;
		background:#FFFFFF;
		border-bottom:1px solid #999999;
	}
	.showmenu_shadow .showmenuBody{/*内容层*/
		z-index:100;
		border:solid 1px #999;
		position:relative;
		background:#dff6b3;
		margin:0 2px 2px 0;
		padding-left:3px;
		padding-right:3px;
	}
	</style>
	<!---add by zhanghonga@20081225(圣诞节)添加样式结束--->

	<!---add by zhanghonga@20081225(圣诞节):这段代码使用jquery编写,配合上面的样式,构成菜单效果;--->
	<!---如果不使用此菜单,删除这段代码即可,不对其他内容构成任何不良影响--->
	<script language="javascript">
		<!--
	    var showmua = false;
	    function showmenu(a, b) {
	        //强制hide()
	        for (i = 1; i <= 4; i++) {
	            var el = $('#mc' + i);
	            hid(el)
	        }
	        showmua = true;
	        var e = $('#' + a);
	        if (e.css("display") == "none") {
	            e.fadeIn('normal')
	        }
	        ;
	        if (b) {//默认不传入b参数
	            var mc_left = document.getElementById(b).offsetLeft;
	            e.css("left", mc_left);
	        }
	    }
	    function hidemenu(a) {
	        showmua = false
	        setTimeout('hid("' + a + '")', 1)
	        //hid(a)
	    }
	    function hid(a) {
	        var e = $('#' + a)
	        if (e.css("display") == "block" && showmua == false) {
	            e.fadeOut('normal')
	        }
	        showmua = true;
	    }
		//xl 查询未出帐
		function searchUnbillDetail() {
		var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;

		var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

    var returnValue = window.showModalDialog('s1500UnbillDetail.jsp?phone_no=<%=phoneNo%>&contractno=<%=(String)arlist.get(47)%>',"",prop);
  }
      //-->
  </script>
  <!---add by zhanghonga@20081225(圣诞节):为菜单样式所添加js脚本结束--->

	</HEAD>
<script language=javascript>
function init(){
	document.all.attrCode.value = userType;
	document.all.stop.value = stopDesc;

	if ("<%=pwdcheck%>" == "N") {
		if("<%=trueNameFlag%>" == "true"){
			rdShowMessageDialog("密码不正确，只能显示部分信息。");
		}else{
			rdShowMessageDialog("密码不正确，只能显示部分信息。</br></n>请进行实名登记，补充客户资料！");
		}
	}else{
		if("<%=trueNameFlag%>" == "true"){
			
		}else{
			rdShowMessageDialog("请进行实名登记，补充客户资料！");
		}
	}
}


function  actionchk()
{
   var smCode = document.form1.smCode.value;
   if(smCode=="动感地带" || smCode=="dn")
	{
		document.form1.action="f1500_dMarkMsg.jsp?idNo=<%=idNo%>&custName=<%=(String)arlist.get(3)%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>";
		document.form1.submit();
	}else{
		document.form1.action="f1500_dMarkMsg.jsp?idNo=<%=idNo%>&custName=<%=(String)arlist.get(3)%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>";
		document.form1.submit();
	}
	
}
function  actionchkhis()
{
   var smCode = document.form1.smCode.value;
   if(smCode=="动感地带" || smCode=="dn")
	{
		document.form1.action="../queryhis/f1500_dnMarkMsg.jsp?idNo=<%=idNo%>&custName=<%=(String)arlist.get(3)%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>";
		document.form1.submit();
	}else{
		document.form1.action="../queryhis/f1500_dMarkMsg.jsp?idNo=<%=idNo%>&custName=<%=(String)arlist.get(3)%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>";
		document.form1.submit();
	}
	
	}
	
function relatLink1300(){
		parent.parent.L('1','1300','缴费(帐号)','s1300/s1300.jsp','0');
}	
	function recodeThisId(bt){
		var oprinfo = $(bt).text();
		var recodeIDd = parent.parent.oprInfoRecode('<%=phoneNo%>','0','<%=opCode%>',oprinfo);
		var oldhref = $(bt).attr("href");
		$(bt).attr("href",oldhref+"&recodeIDd="+recodeIDd);
	}
	$(document).ready(function(){
		$(".sendPost").css("cursor","pointer");
	});
	function sendPost(postUrl,bt){
		$("#postForm").empty();
		$("#postForm").attr("action",postUrl);
		if(postUrl == "f1500_uConQry.jsp"){
			$("#postForm").append("<input type='hidden' name='idNo' value='<%=idNo%>' />").append("<input type='hidden' name='phoneNo' value='<%=phoneNo%>' />").append("<input type='hidden' name='busy_type' value='1' />").append("<input type='hidden' name='count' value='<%=(String)arlist.get(47)%>' />").append("<input type='hidden' name='pwdcheck' value='<%=pwdcheck%>' />");
		}else if(postUrl == "f1500_custcon.jsp"){
			var oprinfo = $(bt).text();
			var recodeIDd = parent.parent.oprInfoRecode('<%=phoneNo%>','0','<%=opCode%>',oprinfo);
			$("#postForm").append("<input type='hidden' name='custId' value='<%=(String)arlist.get(2)%>' />").append("<input type='hidden' name='custName' value='<%=(String)arlist.get(3)%>' />").append("<input type='hidden' name='workNo' value='<%=workNo%>' />").append("<input type='hidden' name='workName' value='<%=workName%>' />").append("<input type='hidden' name='powerName' value='<%=powerName%>' />").append("<input type='hidden' name='deptCode' value='<%=deptCode%>' />").append("<input type='hidden' name='pwdcheck' value='<%=pwdcheck%>' />").append("<input type='hidden' name='recodeIDd' value='"+recodeIDd+"' />");
		}else if(postUrl == "f1500_cConQry.jsp"){
			$("#postForm").append("<input type='hidden' name='idNo' value='<%=idNo%>' />").append("<input type='hidden' name='phoneNo' value='<%=phoneNo%>' />").append("<input type='hidden' name='busy_type' value='2' />").append("<input type='hidden' name='count' value='<%=(String)arlist.get(47)%>' />").append("<input type='hidden' name='pwdcheck' value='<%=pwdcheck%>' />");
		}else if(postUrl == "f1500_dConMsgHis01.jsp"){
			$("#postForm").append("<input type='hidden' name='contractNo' value='<%=(String)arlist.get(47)%>' />").append("<input type='hidden' name='bankCust' value='<%=(String)arlist.get(48)%>' />").append("<input type='hidden' name='workNo' value='<%=workNo%>' />").append("<input type='hidden' name='workName' value='<%=workName%>' />").append("<input type='hidden' name='powerName' value='<%=powerName%>' />").append("<input type='hidden' name='deptCode' value='<%=deptCode%>' />").append("<input type='hidden' name='pwdcheck' value='<%=pwdcheck%>' />");
		}
		$("#postForm").submit();
	}
	
	function goToYH(){
		if("<%=canSeeXXYH%>" == "true"){
			window.location.href = "f1500_dBillCustDetail.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>";
			return false;
		}else{
			rdShowMessageDialog("没有详细优惠信息查询权限！",1);
			return false;
		}
		
	}
	
$(document).ready(function(){
		if("<%=xq_info_old%>"!=""||"<%=xq_info_new%>"!=""){
			$("#tr_xq").show();
		}else{
			$("#tr_xq").hide();
		}
});
function llcx(phone_no)
{
	//var phone_no=18246927811;
	//alert(phone_no);
	var h=480;
    var w=650;
   	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;

	var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	//alert(id_no);
	var returnValue = window.showModalDialog('/npage/s1300/s1300_llcx.jsp?phone_no='+phone_no,"",prop);
}
</script>
<body onLoad="init()">
  <form name="form1" method="post" action="">
  	<%@ include file="/npage/include/header.jsp" %>
  	
  		<div class="title">
			<div id="title_zi">客户信息</div>
	  		<!--div id="nav">
				<dl>
		  			<dt>
						<a href="#" id="mha" onmouseover="showmenu('mca','mha')" onmouseout="hidemenu('mca')">历史信息</a>
					</dt>
				</dl>
			</div-->			
	  		<div id="nav">
				<dl>
		  			<dt>
						<a href="#" id="mh1" onmouseover="showmenu('mc1','mh1')" onmouseout="hidemenu('mc1')">其他信息</a>
					</dt>
				</dl>
			</div>
		</div>
		<!--div class="showmenu_shadow" id="mca" onmouseover="showmenu('mca')" onmouseout="hidemenu('mca')">
			<div class="showmenuBody">
			  <a href="../queryhis/f1502_custhis01.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户历史记录</font></a> 
			</div>
		</div--> 		
		<div class="showmenu_shadow" id="mc1" onmouseover="showmenu('mc1')" onmouseout="hidemenu('mc1')">
			<div class="showmenuBody">
			  <a  onclick="recodeThisId(this)" href="f1500_custuser.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户-用户对应关系</font></a>
			  <a href="#" class="sendPost" onclick="sendPost('f1500_custcon.jsp',this);" ><font color="#3366CC">客户-帐户对应关系</font></a> 
			  <a  onclick="recodeThisId(this)" href="f1500_custuserh.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户-用户对应关系历史</font></a> 
			  <a  onclick="recodeThisId(this)" href="f1500_custhis01.jsp?passValidateFlag=<%=passValidateFlag%>&custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户历史记录</font></a> 
			  <a  onclick="recodeThisId(this)" href="f1500_dCustDocInAdd.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">客户附加信息</font></a> 
	      <!--<a href="fGetUserFavMsg.jsp?idNo=<%=idNo%>&openTime=<%=(String)arlist.get(28)%>&custName=<%=(String)arlist.get(3)%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC">优惠信息查询</font></a>-->
			  <a  onclick="recodeThisId(this)" href="f1500_CustManage.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>&custName=<%=(String)arlist.get(3)%>"> <font color="#3366CC"> 客户经理信息</font></a> 
			  <a  onclick="recodeThisId(this)" href="f1500_RoamInfo.jsp?idNo=<%=idNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC">边界漫游投诉信息</font></a></dd> 
			  <a  onclick="recodeThisId(this)" href="f1500_sPubCustBillDet1.jsp?idNo=<%=idNo%>&workNo=<%=workNo%>&loginAccept=<%=loginAccept%>"><font color="#3366CC">详细资费信息</font></a></dd> 
			  <a  onclick="recodeThisId(this)" href="f1534_1.jsp?phoneNo=<%=phoneNo%>"><font color="#3366CC">用户底线资费优惠查询</font></a></dd> 
			</div>
		</div> 
  <table id=tb1 cellspacing="0">
    <tr> 
      <td class="blue">客户标识</td>
      <td> 
        <input name=custId  class="InputGrey" maxlength="20" readonly value="<%=(String)arlist.get(2)%>">
      </td>
      <td class="blue">客户名称</td>
      <td> 
        <input name=custName class="InputGrey" readonly value="<%=custNameStr%>" >
        </td>
      <td class="blue">归属地点</td>
      <td> 
        <input name=regionCode class="InputGrey" readonly value="<%=(String)arlist.get(4)%>">
      </td>
      <td class="blue">客户状态</td>
      <td class="blue"> 
        <input name=custStatus class="InputGrey" readonly value="<%=(String)arlist.get(5)%>">
      </td>
    </tr>
    <tr> 
      <td class="blue">状态时间</td>
      <td> 
        <input name=runTime class="InputGrey" readonly value="<%=(String)arlist.get(6)%>">
        </td>
      <td class="blue">客户级别</td>
      <td> 
        <input name=ownerGrade class="InputGrey" readonly value="<%=(String)arlist.get(7)%>" >
        </td>
      <td class="blue">客户类别</td>
      <td> 
        <input name=ownerType class="InputGrey" readonly value="<%=(String)arlist.get(8)%>">
        </td>
      <td class="blue">客户地址</td>
      <td> 
        <input name=custAddress class="InputGrey" readonly value="<%=custAddressStr%>">
      </td>
    </tr>
    <tr> 
      <td class="blue">证件类型</td>
      <td> 
        <input name=idType class="InputGrey" readonly value="<%=(String)arlist.get(10)%>">
        </td>
      <td class="blue">证件号码</td>
      <td> 
        <input name=idIccid class="InputGrey" readonly value="<%=idIccidStr%>"    style='font-size:16px' />
      </td>
      <td class="blue">证件地址</td>
      <td> 
        <input name=idAddress class="InputGrey" readonly value="<%=idAddressStr%>" style='font-size:16px' />
      </td>
      <td class="blue">证件有效期</td>
      <td> 
        <input name=idValiddate class="InputGrey" readonly value="<%=(String)arlist.get(13)%>" style='font-size:16px' />
      </td>
    </tr>
    <tr> 
      <td class="blue">联系人</td>
      <td> 
        <input name=contactPerson class="InputGrey" readonly value="<%=contactPersonStr%>">
        </td>
      <td class="blue">联系电话</td>
      <td> 
        <input name=contactPhone class="InputGrey" readonly value="<%=contactPhoneStr%>">
        </td>
      <td class="blue">联系地址</td>
      <td> 
        <input name=contactAddress class="InputGrey" readonly value="<%=contactAddressStr%>" >
      </td>
      <td class="blue">邮政编码</td>
      <td class="blue"> 
        <input name=contactPost class="InputGrey" readonly value="<%=contactPostStr%>">
      </td>
    </tr>
    <tr> 
      <td class="blue">通讯地址</td>
      <td> 
        <input name=contactAddress1 class="InputGrey" readonly value="<%=contactAddress1Str%>" >
        </td>
      <td class="blue">联系人传真</td>
      <td> 
        <input name=contactFax class="InputGrey" readonly value="<%=contactFaxStr%>" >
      </td>
      <td class="blue">电子邮箱</td>
      <td class="blue"> 
        <input name=contactMailaddress class="InputGrey" readonly value="<%=contactMailaddressStr%>">
      </td>
      <td class="blue">建档渠道标识</td>
      <td> 
        <input name=contact_emaill class="InputGrey" readonly value="<%=(String)arlist.get(21)%>">
      </td>
    </tr>
    <tr> 
      <td class="blue">建档时间</td>
      <td> 
        <input name=create_time class="InputGrey" readonly value="<%=(String)arlist.get(22)%>">
      </td>
      <td class="blue">销档时间</td>
      <td> 
        <input name=close_time class="InputGrey" readonly value="<%=(String)arlist.get(23)%>">
      </td>
      <td class="blue">上级客户ID</td>
      <td> 
        <input name=parent_id class="InputGrey" readonly value="<%=(String)arlist.get(24)%>">
      </td>
      <td class="blue">预存换手机话费共分享主卡</td>
      <td>
      	<input name=parent_id class="InputGrey" readonly value="<%=mainPhone%>">
     	</td>
    </tr>
    <tr>
    	<td class="blue">经办人姓名</td>
    	<td><input name="gestoresName" class="InputGrey" readonly value="<%=gestoresName %>"></td>
    	<td class="blue">经办人联系地址</td>
    	<td><input name="gestoresAddr" class="InputGrey" readonly value="<%=gestoresAddr %>"></td>
    	<td class="blue">经办人证件类型</td>
    	<td><input name="gestoresIdType" class="InputGrey" readonly value="<%=gestoresIdTypeName %>"></td>
    	<td class="blue">经办人证件号码</td>
    	<td><input name="gestoresIccId" class="InputGrey" readonly value="<%=gestoresIccId %>"></td>
    </tr>
    
    <tr>
    	<td class="blue">责任人姓名</td>
    	<td><input name="responsibleName" class="InputGrey" readonly value="<%=responsibleName %>"></td>
    	<td class="blue">责任人联系地址</td>
    	<td><input name="responsibleAddr" class="InputGrey" readonly value="<%=responsibleAddr %>"></td>
    	<td class="blue">责任人证件类型</td>
    	<td><input name="responsibleType" class="InputGrey" readonly value="<%=responsibleTypeName %>"></td>
    	<td class="blue">责任人证件号码</td>
    	<td><input name="responsibleIccId" class="InputGrey" readonly value="<%=responsibleIccId %>"></td>
    </tr>
    
         <tr> 
      <td class="blue">用户备注信息</td>
      <td> 
        <input name="user_note" class="InputGrey" readonly value="<%=(String)arlist.get(69)%>">
      </td>
    </tr>
  </table>
  </div>
  
<div id="Operation_Table">	
  	<div class="title">
		  <div id="title_zi">用户信息</div>
			<!--div id="nav">
				<dl>
		  			<dt>
						<a href="#" id="mhb" onmouseover="showmenu('mcb','mhb')" onmouseout="hidemenu('mcb')">历史信息</a>
					</dt>
				</dl>
			</div-->		  
			<div id="nav">
				<dl>
		  			<dt>
						<a href="#" id="mh2" onmouseover="showmenu('mc2','mh2')" onmouseout="hidemenu('mc2')">其他信息</a>
					</dt>
				</dl>
			</div>
		</div>
		<!--div class="showmenu_shadow" id="mcb" onmouseover="showmenu('mcb')" onmouseout="hidemenu('mcb')">
			<div class="showmenuBody">
			  <a href="../queryhis/f1502_wChgQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">变更记录</font></a> 
			  <a href="../queryhis/f1502_dCustSimHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">换卡记录</font></a> 
			  <a href="../queryhis/f1502_dCustMsgHis01.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">用户历史</font></a> 
			  <a href="../queryhis/f1502_wPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">用户交费信息</font></a> 
			  <a href="../queryhis/f1502_dCustFuncHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC"> 特服变更明细</font></a> 
			</div>
		</div-->		
		<div class="showmenu_shadow" id="mc2" onmouseover="showmenu('mc2')" onmouseout="hidemenu('mc2')">
			<div class="showmenuBody">
			  <a href="#" class="sendPost" onclick="sendPost('f1500_uConQry.jsp')"><font color="#3366CC">用户帐单</font></a>
			  <a href="javascript:void(0);" onclick="goToYH();return false;"><font color="#3366CC">详细优惠信息</font></a>
			  <a href="f1500_wChgQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">变更记录</font></a> 
			  <a href="f1500_dCustSimHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">换卡记录</font></a> 
			  <a href="f1500_dCustMsgHis01.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">用户历史</font></a> 
			  <a href="f1500_dAssuMsg.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>&opwrf=<%=pwrf %>&opassFlag=<%=passFlag %>"><font color="#3366CC">入网担保信息</font></a> 
			  <a href="assuNote.jsp?id_no=<%=idNo%>"><font color="#3366CC">用户业务备注</font></a> 
			  <a href="f1500_dCustInnet.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">入网信息</font></a> 
			  <a href="f1500_wPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">用户交费信息</font></a> 
			  <a href="f1500_dCustFuncHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC"> 特服变更明细</font></a> 
			  <a href='javascript:actionchk()'><font color="#3366CC">用户积分</font></a> 
			  <a href="f1550_dConUserMsg.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC">用户-帐户对应关系</font></a> 
			  <a href="f1500_sPubCustColorRing.jsp?phoneNo=<%=phoneNo%>"><font color="#3366CC">彩铃信息查询</font></a> 
			</div>
		</div> 		
		
		
<table id=tb2 cellspacing="0">
  <tr> 
    <td class="blue" nowrap>服务号码</td>
    <td> 
      <input name="phone_no"   maxlength="20" class="InputGrey" readonly value="<%=phoneNo%>">
    </td>
    <td class="blue" nowrap>业务品牌</td>
    <td> 
      <input name="smCode"  class="InputGrey" readonly value="<%=(String)arlist.get(26)%>">
    </td>
    <td class="blue" nowrap>服务类型</td>
    <td> 
      <input name=serviceType  class="InputGrey" readonly value="<% if("4G用户".equals(arlist.get(27))){out.print("4G USIM卡客户");}else{out.print(arlist.get(27));}%>">
    </td>
    <td class="blue" nowrap>入网时间</td>
    <td> 
      <input name=openTime  class="InputGrey" readonly value="<%=(String)arlist.get(28)%>">
    </td>
  </tr>
  <tr> 
    <td class="blue">用户属性</td>
    <td> 
      <input name=attrCode   class="InputGrey" readonly value=userType>
    </td>
    <td class="blue">大客户标志</td>
    <td> 
      <input name=creditCode class="InputGrey" readonly value="<%=(String)arlist.get(30)%>">
      </td>
    <td class="blue">信用度</td>
    <td> 
      <input name=creditValue class="InputGrey" readonly value="<%=(String)arlist.get(31)%>">
    </td>
    <td class="blue" nowrap>旧运行状态</td>
    <td> 
      <input name=runName1 class="InputGrey" readonly value="<%=(String)arlist.get(32)%>">
    </td>
  </tr>
  <tr> 
    <td class="blue">当前状态</td>
    <td> 
      <input name=runName2 class="InputGrey" readonly value="<%=(String)arlist.get(33)%>">
    </td>
    <td class="blue">状态修改时间</td>
    <td> 
      <input name=runTime class="InputGrey" readonly value="<%=(String)arlist.get(34)%>">
    </td>
    <td class="blue">出帐时间</td>
    <td> 
      <input name=billDate class="InputGrey" readonly value="<%=(String)arlist.get(35)%>">
    </td>
    <td class="blue">出帐周期</td>
    <td> 
      <input name=billUnit class="InputGrey" readonly value="<%=(String)arlist.get(36)%>">
    </td>
  </tr>
  <tr> 
    <td class="blue">套餐类型</td>
    <td> 
      <input name=idAddress1 class="InputGrey" readonly value="<%=(String)arlist.get(37)%>">
      </td>
    <td class="blue">下月套餐</td>
    <td> 
      <input name=idValiddate class="InputGrey" readonly value="<%=(String)arlist.get(38)%>">
      </td>
    <td class="blue">套餐起始时间</td>
    <td> 
      <input name=contactPerson1 class="InputGrey" readonly value="<%=(String)arlist.get(39)%>">
      </td>
    <td class="blue">生效时间</td>
    <td> 
      <input name=contactPhone1 class="InputGrey" readonly value="<%=(String)arlist.get(40)%>">
      </td>
  </tr>
  
  <tr id="tr_xq"> 
    <td colspan="2" class="blue">小区代码--小区名称(当前)</td>
    <td colspan="2"> 
      <input name=idAddress1 class="InputGrey" readonly value="<%=xq_info_old%>" />
      </td>
    <td colspan="2" class="blue">小区代码--小区名称(下档)</td>
    <td colspan="2"> 
      <input name=idValiddate class="InputGrey" readonly value="<%=xq_info_new%>" />
    </td>
  </tr>
  
  <tr> 
    <td class="blue" style="display:<%=simStyle%>">SIM卡号</td>
    <td  style="display:<%=simStyle%>"> 
      <input name=simNo class="InputGrey" readonly value="<%=(String)arlist.get(41)%>">
      </td>
    <td class="blue"  style="display:<%=simStyle%>">IMSI号</td>
    <td  style="display:<%=simStyle%>"> 
      <input name=imsiNo class="InputGrey" readonly value="<%=(String)arlist.get(42)%>">
      </td>
    <td class="blue">免停标志</td>
    <td> 
      <input name="stop" class="InputGrey" readonly>&nbsp;
    </td>
    <td class="blue">主资费单双向属性</td>
    <td>
      <input name="" class="InputGrey" readonly="readonly" value="<%=(String)arlist.get(43)%>"/>
    </td>
    <td class="blue"  style="display:<%=broadStyle%>">宽带账号</td>
    <td  style="display:<%=broadStyle%>">
      <input name="broadNo" class="InputGrey" readonly value="<%=(String)arlist.get(63)%>">
    </td>
        <td class="blue"  style="display:<%=broadStyle%>">电信分局</td>
    <td  style="display:<%=broadStyle%>">
      <input name="dianxinfj" class="InputGrey" readonly value="<%=(String)arlist.get(67)%>">
    </td>
  </tr>
      <tr> 
      <td class="blue">客户等级</td>
      <td> 
        <%
        		custLevelVal = (String)arlist.get(74);
        		custLevelStartTime = (String)arlist.get(75);
        		custLevelEndTime = (String)arlist.get(76);
        %>
        <input name="cust_level" class="InputGrey" readonly value="<%=custLevelVal%>">
      </td>
      
      <td class="blue">客户等级开始时间</td>
      <td> 
        
        <input name="custLevelStartTime" class="InputGrey" readonly value="<%=custLevelStartTime%>">
      </td>
      
      <td class="blue">客户等级结束时间</td>
      <td> 
       
        <input name="custLevelEndTime" class="InputGrey" readonly value="<%=custLevelEndTime%>">
      </td>
      
      <%
      	/*** begin diling add for 关于利用相关渠道开展客户网龄、星级查询需求@2014/2/19 ***/
      %>
      <td class="blue">客户网龄</td>
      <td> 
        <%
            innetYear = (String)arlist.get(71) ;
						innetDay = (String)arlist.get(72) ;
						innetInfo = innetYear+"年"+innetDay+"天";
        %>
        <input name="cust_level" class="InputGrey" readonly value="<%=innetInfo%>">
      </td>
      </tr>
      <%/* begin add for 关于开发智能终端CRM模式APP的函 - 第三批@2015/3/30 */%>
      <tr>
	    	<td class="blue">实际使用人姓名</td>
	    	<td><input name="realUserName" class="InputGrey" readonly value="<%=realUserName %>"></td>
	    	<td class="blue">实际使用人联系地址</td>
	    	<td><input name="realUserAddr" class="InputGrey" readonly value="<%=realUserAddr%>"></td>
	    	<td class="blue">实际使用人证件类型</td>
	    	<td><input name="realUserIdType" class="InputGrey" readonly value="<%=realUserIdType%>"></td>
	    	<td class="blue">实际使用人证件号码</td>
	    	<td><input name="realUserIccId" class="InputGrey" readonly value="<%=realUserIccId%>"></td>
	    </tr>
	    <%/* end add for 关于开发智能终端CRM模式APP的函 - 第三批@2015/3/30 */%>
			<%
				/*** end diling add for 关于利用相关渠道开展客户网龄、星级查询需求@2014/2/19 ***/
			%>
			<td class="blue">到期主资费</td>
      <td> 

        <input name="dqoffer" class="InputGrey" readonly value="<%=(String)arlist.get(73)%>">
      </td>
  
 
 <%if(!"".equals(initoBroadBand)){%>
	 <td class="blue">初始带宽</td>
	 <td> 
		<%=initoBroadBand%>
   </td>
<%}%> 
    
<%if(!"".equals(oBroadBand)){%>
	 <td class="blue">当前带宽</td>
	 <td> 
		<%=oBroadBand%>
   </td>
<%}%>

    <td class="blue">是否volte用户</td>
		<td><%=ifVolte%></td>      

</tr>
<tr>
		<%if(!"没有宽带账号".equals(arlist.get(63))){%>
	      <td class="blue">宽带安装地址</td>
	      <td>
	        <input name="kdFixAddr" class="InputGrey" readonly value="<%=(String)arlist.get(64)%>">
	      </td>
      <%}%>
    </tr>
    
  <tr>
    <th colspan="5" class="blue"><span style="padding-left:250px;">特服明细列表</span></th>
    <th colspan="3" class="blue"><span style="padding-left:90px;">用户业务属性列表</span></th>
  </tr>
  <tr>
    <td colspan="5">
      <textarea name="textarea" rows=6 cols='' readonly style="width:98%"><%=(String)arlist.get(44)%><%=(String)arlist.get(45)%><%=(String)arlist.get(46)%></textarea>
    </td>
    <td colspan="3">
      <textarea name="textarea2" rows=6 cols='' readonly style="width:95%"><%=(String)arlist.get(61)%></textarea>
    </td>
  </tr>
</table>
</DIV>


<!-- 表单title -->
<DIV id="Operation_Table">
    <div class="title">
      <div id="title_zi">帐户信息</div>
      <!--div id="nav">
        <dl>
            <dt>
            <a href="#" id="mhc" onmouseover="showmenu('mcc','mhc')" onmouseout="hidemenu('mcc')">历史信息</a>
          </dt>
        </dl>
      </div-->      
      <div id="nav">
        <dl>
            <dt>
            <a href="#" id="mh3" onmouseover="showmenu('mc3','mh3')" onmouseout="hidemenu('mc3')">其他信息</a>
          </dt>
        </dl>
      </div>
    </div>
    <!--div class="showmenu_shadow" id="mcc" onmouseover="showmenu('mcc')" onmouseout="hidemenu('mcc')">
      <div class="showmenuBody">
          <a href="../queryhis/f1502_dConUserMsg.jsp?idNo=<%=idNo%>&contractNo=<%=(String)arlist.get(47)%>&bankCust=<%=(String)arlist.get(48)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">付费计划信息</font></a> 
        <a href="../queryhis/f1502_cConQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&busy_type=2&count=<%=(String)arlist.get(47)%>"><font color="#3366CC">帐户帐单</font></a> 
        <a href="../queryhis/f1502_dConMsg.jsp?idNo=<%=idNo%>&bankCust=<%=(String)arlist.get(48)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">托收帐号信息</font></a> 
        <a href="../queryhis/f1502_wConPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&contractNo=<%=(String)arlist.get(47)%>&bankCust=<%=(String)arlist.get(46)%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">帐户交费信息</font></a>
        <a href="../queryhis/f1502_dConMsgHis01.jsp?contractNo=<%=(String)arlist.get(47)%>&bankCust=<%=(String)arlist.get(48)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">帐户历史记录</font></a> 
        <a href="../queryhis/f1502_dConMsgPre.jsp?contractNo=<%=(String)arlist.get(47)%>&bankCust=<%=(String)arlist.get(48)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">预存分类信息</font></a> 
        <a href="../queryhis/f1502_dDepositQry.jsp?contractNo=<%=(String)arlist.get(47)%>&bankCust=<%=(String)arlist.get(48)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">帐户押金信息</font></a> 
        
      </div>
    </div-->    
    <div class="showmenu_shadow" id="mc3" onmouseover="showmenu('mc3')" onmouseout="hidemenu('mc3')">
      <div class="showmenuBody">
          <a href="f1500_dConUserMsg.jsp?idNo=<%=idNo%>&contractNo=<%=(String)arlist.get(47)%>&bankCust=<%=(String)arlist.get(48)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">付费计划信息</font></a> 
        <a href="#" class="sendPost" onclick="sendPost('f1500_cConQry.jsp')"><font color="#3366CC">帐户帐单</font></a> 
        <a href="f1500_dConMsg.jsp?idNo=<%=idNo%>&bankCust=<%=(String)arlist.get(48)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">托收帐号信息</font></a> 
        <a href="f1500_wConPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&contractNo=<%=(String)arlist.get(47)%>&bankCust=<%=(String)arlist.get(46)%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">帐户交费信息</font></a>
        <a href="#" class="sendPost" onclick="sendPost('f1500_dConMsgHis01.jsp')"><font color="#3366CC">帐户历史记录</font></a> 
        <a href="f1500_dConMsgPre.jsp?contractNo=<%=(String)arlist.get(47)%>&bankCust=<%=(String)arlist.get(48)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>&phoneNo=<%=phoneNo%>"><font color="#3366CC">预存分类信息</font></a> 
        <a href="f1500_dDepositQry.jsp?contractNo=<%=(String)arlist.get(47)%>&bankCust=<%=(String)arlist.get(48)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">帐户押金信息</font></a>
         <!--xl 新增 未出帐查询-->
        <a href='javascript:searchUnbillDetail()'><font color="#3366CC">未出帐明细</font></a>
        <a href="javascript:llcx('<%=phoneNo%>');"><font color="#3366CC">月均流量DOU</font></a>
      </div>
    </div>
  <table id=tb3 cellspacing="0">
    <tr> 
      <td class="blue">帐户号</td>
      <td> 
        <input name=contractNo class="InputGrey" readonly value="<%=(String)arlist.get(47)%>">
        </td>
      <td class="blue">帐户名称</td>
      <td> 
        <input name=bankCust class="InputGrey" readonly value="<%=conNameStr%>">
      </td>
      <td class="blue">帐户零头</td>
      <td> 
        <input name=oddment class="InputGrey" readonly value="<%=(String)arlist.get(49)%>">
      </td>
      <td class="blue">预存时间</td>
      <td> 
        <input name=prepayTime class="InputGrey" readonly value="<%=(String)arlist.get(51)%>">
      </td>
    </tr>
    <tr>
      <td class="blue">帐号类型</td>
      <td> 
        <input name=accountType class="InputGrey" readonly value="<%=(String)arlist.get(52)%>">
      </td>
      <td class="blue">欠费标志</td>
      <td> 
        <input name=status class="InputGrey" readonly value="<%=(String)arlist.get(53)%>">
      </td>
      <td class="blue">状态改变时间</td>
      <td> 
        <input name=statusTime class="InputGrey" readonly value="<%=(String)arlist.get(54)%>">
      </td>
      <td class="blue">邮寄标志</td>
      <td> 
        <input name=postFlag class="InputGrey" readonly value="<%=(String)arlist.get(55)%>">
      </td>
    </tr>
    <tr> 
      <td class="blue">押 金</td>
      <td> 
        <input name=deposit class="InputGrey" readonly value="<%=(String)arlist.get(56)%>">
      </td>
      <td class="blue">最小欠费年月</td>
      <td> 
        <input name=minYM class="InputGrey" readonly value="<%=(String)arlist.get(57)%>">
      </td>
      <td class="blue">帐户信誉度</td>
      <td> 
        <input name=accountLimit class="InputGrey" readonly value="<%=(String)arlist.get(59)%>">
      </td>
      <td class="blue">付款方式</td>
      <td> 
        <input name=payCode class="InputGrey" readonly value="<%=(String)arlist.get(60)%>">
      </td>
    </tr>
    <tr>
      <td class="blue">当前预存</td>
      <td>
    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="<%=show_fee.trim()%>" >
      </td>
	  <td class="blue">当前可划拨预存</td>
      <td>
    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="<%=prepayFee.trim()%>" >
      </td>
	  <td class="blue">未出帐话费</td>
      <td>
    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="<%=nobillpay.trim()%>" >
      </td>
      <td class="blue">当前可用预存</td>
      <td>
    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="<%=now_prepayFee.trim()%>" >
      </td>
    </tr>
    
    <!-- liuxmc add 20100907 begin-->
    <tr>
      <td class="blue">当前可用专款余额</td>
      <td>
    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="<%=zx_yc_fee.trim()%>" >
      </td>
	  <td class="blue">当前可用普通余额</td>
      <td>
    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="<%=pt_yc_fee.trim()%>" >
      </td>

	  <td class="blue">底线类资费客户</td>
      <td>
    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="<%=isdxzfflag%>" >
      </td>
      <td class="blue">当前未出帐可继续使用的底线费用</td>
      <td>
    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="<%=dxzfmoney%>" >
      </td>
    </tr>
    <!--liuxmc add 20100907 end-->
    <tr>
      <td class="blue">星级月均消费得分</td>
      <td>
    	<input name=custLevelFeeIntegral class="InputGrey" style="color:red" readonly value="<%=custLevelFeeIntegral%>" >
      </td>
      <td class="blue">星级网龄得分</td>
      <td>
    	<input name=custLevelNetIntegral class="InputGrey" style="color:red" readonly value="<%=custLevelNetIntegral%>" >
      </td>
      
      <td class="blue">家庭未出账话费</td>
      <td>
    	<input name=FamUnbill class="InputGrey" style="color:red" readonly value="<%=s_FamUnbill%>" >
      </td>
      <td class="blue">月均流量DOU</td>
      <td>
    	<input name=FamUnbill class="InputGrey" style="color:red" readonly value="<%=s_MonthDOU%>" >
      </td>
    </tr>
  </table>
  
  <table>
    <tr> 
    	 <td id="footer">
<%
if(!"2".equals(workNoAccountType)){
%>
          <input class="b_foot" name=back onClick="location='f1500_1.jsp'" type=button value="  返  回  ">
<%
}
%>
	        <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value="  关  闭  ">
       </td>
    </tr>
  </table>
  
  <%@ include file="/npage/include/footer.jsp" %>
   <div class="relative_link">
	<span>相关链接：</span><a href="#" onclick="relatLink1300()">缴费</a>
</div>
  </form>
  <form id="postForm" method="post">
  </form>
</BODY>

</HTML>