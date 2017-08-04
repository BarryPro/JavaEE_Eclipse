<%
/********************
 version v2.0
开发商: si-tech
update:liutong@20080918
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>


<%
  	/**
  	ArrayList arrSession1 = (ArrayList)session.getAttribute("allArr");
		String[][] temfavStr1=(String[][])arrSession1.get(3);
    String[] favStr1=new String[temfavStr1.length];
    **/

    String[][]  temfavStr1 = (String[][])session.getAttribute("favInfo");
    String[] favStr1=new String[temfavStr1.length];

    String currentTime = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()); //当前时间
    String sim="readonly";

  for(int i=0;i<favStr1.length;i++){
     favStr1[i]=temfavStr1[i][0].trim();

	}//aegn0G
	if(WtcUtil.haveStr(favStr1,"a090")){
		sim="";
		}
 %>

<%
  request.setCharacterEncoding("GBK");
//	Logger logger = Logger.getLogger("sa220Main.jsp");
  String op_name="补卡变更";
  String op_code = request.getParameter("op_code");
  boolean istestNum=false;

%>
<html>
<head>
<title><%=op_name%></title>
<%
    /**
    SPubCallSvrImpl co=new SPubCallSvrImpl();

    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
 	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String org_code = baseInfoSession[0][16];
    String region_code=org_code.substring(0,2);
    **/
	String opCode= op_code;
	String opName =op_name;
	String work_no =(String)session.getAttribute("workNo");
	String loginName =(String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String region_code = org_code.substring(0,2);
	String regionCode = org_code.substring(0,2);
	String workNo =(String)session.getAttribute("workNo");

	boolean hfrf=false;

 	String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
    String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
    String password = request.getParameter("pname");
    if(op_code.equals("1220")){
    	String[] inParas = new String[2];
    	inParas[0]="select t.phone_type from DBCUSTADM.dTestPhoneMsg t where t.phone_no = :phoneNo";
    	inParas[1]="phoneNo="+srv_no;
    	%>
    	<wtc:service name="TlsPubSelCrm" retcode="retCode1" retmsg="retMsg1" outnum="3">
    		<wtc:param value="<%=inParas[0]%>"/>
    		<wtc:param value="<%=inParas[1]%>"/>
    	</wtc:service>
    	<wtc:array id="result1" scope="end" />
    	<%
    	if(result1==null||result1.length==0){
    		istestNum=false;
		}
		else{
			if("1".equals(result1[0][0])){
				istestNum=true;
			}
			else{
				istestNum=false;
			}
		}
    }
    
//	String smCode=request.getParameter("smCode");
 	ArrayList simStatusArr=new ArrayList();

	String [][]initStr=new String[][]{};
	String [][]errStr=new String[][]{};

	ArrayList retArray = new ArrayList();
    //String[][] result = new String[][]{};

	//String [][]simStatusStr=new String[][]{};
	//String [][]springbz=new String[][]{};
 	//-----------获得手续费-------------
	String oriHandFee="0";
	String oriHandFeeFlag="";

     //-----------获得sim卡状态----------
	//String sq1="select trim(sim_status),trim(status_name) from sSimStatus where sim_status='2' or sim_status='3' or sim_status = 'B'";
	//lj. 绑定参数
	String sql_select1 = "select trim(sim_status),trim(status_name) from sSimStatus where sim_status='2' or sim_status='3' or sim_status = 'B'";

	//simStatusArr=co.sPubSelect("2",sq1,"phone",srv_no);
    //simStatusStr=(String[][])simStatusArr.get(0);
    %>
		<wtc:service name="TlsPubSelCrm"  routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code" retmsg="ret_message" outnum="2">
			<wtc:param value="<%=sql_select1%>"/>
		</wtc:service>
		<wtc:array id="simStatusStr" scope="end" />
	<%
	   if(ret_code.equals("0")||ret_code.equals("000000")){
          System.out.println("调用服务sPubSelect in s1220main.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	      if(simStatusStr.length==0){
 	      	 String forwardURL = "fm280.jsp?ReqPageName=s1220Main&activePhone="+srv_no+"&op_code="+op_code+"&retMsg=2";
 	          /*
	 	      if(!response.isCommitted())
	 	      {
	 	          response.sendRedirect("fm280.jsp?ReqPageName=s1220Main&activePhone="+srv_no+"&op_code="+op_code+"&retMsg=2");
	 	          out.close();
	 	          return;
	 	      }
	 	      */
	 	      request.getRequestDispatcher(forwardURL).forward(request,response);
	 	      return;
 	      }else{

 	      }

 	   }else{
 	         	System.out.println(ret_code+"    ret_code");
 	     		System.out.println(ret_message+"    ret_message");
 			   System.out.println("调用服务sPubSelect in s1220main.jsp  失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			   %>
					    <script language='jscript'>
					       rdShowMessageDialog("查询服务sPubSelect调用失败");
					       parent.removeTab(<%=opCode%>);
				       </script>
				<%
 		}

/*	String sq2="select to_char(count(*)) from dSpringCard a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phoneNo1 and valid_flag='N' and op_code='1442' ";*/

	//simStatusArr=co.sPubSelect("1",sq1,"phone",srv_no);
    //springbz=(String[][])simStatusArr.get(0);
    String [] paraIn = new String[2];
/*    paraIn[0] = sq2;
    paraIn[1]="phoneNo1="+srv_no;*/
    %>

	<%
/*	   if(ret_code1.equals("0")||ret_code1.equals("000000")){
          System.out.println("调用服务sPubSelect in s1220main.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
          System.out.println("springbz="+springbz);

 	   }else{
 	         	System.out.println(ret_code1+"    ret_code1");
 	     		System.out.println(ret_message1+"    ret_message1");
 			   System.out.println("调用服务sPubSelect in s1220main.jsp  失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			   %>
					    <script language='jscript'>
					       rdShowMessageDialog("查询服务sPubSelect调用失败");
					       parent.removeTab(<%=opCode%>);
				       </script>
				<%
 		}*/
    
    /*取dcustres的*/
    String sqlXhzw="select region_code from dcustres t where t.phone_no=:phoneNoRes";
    String [] prmXhzw = new String[2];
    prmXhzw[0]=sqlXhzw;
    prmXhzw[1]="phoneNoRes="+srv_no;
    %>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>"  
		retcode="rcXhzw" retmsg="rmXhzw" outnum="1">
		<wtc:param value="<%=prmXhzw[0]%>"/>
		<wtc:param value="<%=prmXhzw[1]%>"/>
	</wtc:service>
	<wtc:array id="belRes" scope="end" />    
   
 <%
 
 	   if(rcXhzw.equals("0")||rcXhzw.equals("000000"))
 	   {
          System.out.println("1220~~~belRes="+belRes[0][0]);
 	   }
 	   else
 	   {
         	System.out.println(rcXhzw+"    rcXhzw");
     		System.out.println(rmXhzw+"    rmXhzw");
		    System.out.println("调用服务sPubSelect in s1220main.jsp  失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
		   %>
				    <script language='jscript'>
				       rdShowMessageDialog("查询服务sPubSelect调用失败");
				       parent.removeTab(<%=opCode%>);
			       </script>
			<%
 		}
 
 
 
    String sq8="select substr(belong_code,1,2) from dcustmsg where phone_no=:phoneNo2 ";
    paraIn[0] = sq8;
    paraIn[1]="phoneNo2="+srv_no;

    %>
		<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code1" retmsg="ret_message1" outnum="1">
			<wtc:param value="<%=paraIn[0]%>"/>
			<wtc:param value="<%=paraIn[1]%>"/>
		</wtc:service>
		<wtc:array id="belreg" scope="end" />
	<%
	   if(ret_code1.equals("0")||ret_code1.equals("000000")){
          System.out.println("调用服务sPubSelect in s1220main.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
         // System.out.println("belreg="+belreg[0][0]);

 	   }else{
 	         	System.out.println(ret_code1+"    ret_code1");
 	     		System.out.println(ret_message1+"    ret_message1");
 			    System.out.println("调用服务sPubSelect in s1220main.jsp  失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			   %>
					    <script language='jscript'>
					       rdShowMessageDialog("查询服务sPubSelect调用失败");
					       parent.removeTab(<%=opCode%>);
				       </script>
				<%
 		}
 	/********* 异地换卡，卡费不可输入  sunaj 2091204*******/
	/**if(!region_code.equals(belreg[0][0]))
	{
		sim="readonly";
	}**/
   /************liucm add 20081223 增加空中充值标识*****************/

   /***********dujl add at 20100408 for 毛亮的需求 begin******/
   //String hlrsql = "SELECT a.hlr_code||'--'||b.hlr_name FROM shlrcode a,shlrcodename b where a.phoneno_head=substr('"+srv_no+"',1,7) and a.region_code='"+belreg[0][0]+"' AND a.hlr_code=b.hlr_code ";
	 //lj. 绑定参数
	 String sql_select2 = "SELECT a.hlr_code||'--'||b.hlr_name "
	 	+"FROM shlrcode a,shlrcodename b , dcustres t "
	 	+"where a.phoneno_head=substr(:srv_no,1,7) and t.phone_no=:srv_no2 "
	 	+"and a.region_code=t.region_code AND a.hlr_code=b.hlr_code";
	 String srv_params2 = "srv_no=" + srv_no+" ,srv_no2="+srv_no ;
	 System.out.println("sql_select2="+sql_select2);
   %>
		<wtc:service name="TlsPubSelCrm"  routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code" retmsg="ret_message" outnum="2">
			<wtc:param value="<%=sql_select2%>"/>
			<wtc:param value="<%=srv_params2%>"/>
		</wtc:service>
		<wtc:array id="hlrcode" scope="end" />
   <%
   /***********dujl add at 20100408 for 毛亮的需求 end********/
		String hlrCodeOne = "无";
		if(hlrcode.length > 0){
			hlrCodeOne = hlrcode[0][0];
		}

    String sq3="select to_char(count(*)) from dagtbasemsg where agt_phone=:phoneNo3 and status='Y' ";

    paraIn[0] = sq3;
    paraIn[1]="phoneNo3="+srv_no;
    %>
		<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code1" retmsg="ret_message1" outnum="1">
			<wtc:param value="<%=paraIn[0]%>"/>
			<wtc:param value="<%=paraIn[1]%>"/>
			</wtc:service>
		<wtc:array id="agtmsgbz" scope="end" />
	<%
	   if(ret_code1.equals("0")||ret_code1.equals("000000")){
          System.out.println("调用服务sPubSelect in s1220main.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
         // System.out.println("agtmsgbz="+agtmsgbz[0][0]);

 	   }else{
 	         	System.out.println(ret_code1+"    ret_code1");
 	     		System.out.println(ret_message1+"    ret_message1");
 			   System.out.println("调用服务sPubSelect in s1220main.jsp  失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			   %>
					    <script language='jscript'>
					       rdShowMessageDialog("查询服务sPubSelect调用失败");
					       parent.removeTab(<%=opCode%>);
				       </script>
				<%
 		}

 	//------------获得服务器端初始化信息数组-----------
	//SPubCallSvrImpl im1210=new SPubCallSvrImpl();
	int inputNumber = 3;
	String   outputNumber = "30";
/**
	String  inputParsm [] = new String[inputNumber];
	inputParsm[0] = work_no;
	inputParsm[1] = srv_no;
	inputParsm[2] = op_code;
	**/
  	//String [] initBack = im1210.callService("s1220Init",inputParsm,outputNumber,"phone",srv_no);
  //  int retCode = im1210.getErrCode();
  //	String retMsg = im1210.getErrMsg();
  
    /*关于落实打击黑卡工作的BOSS优化补充需求地市配置表start*/
    String groupId =(String)session.getAttribute("groupId");
    String sql_appregionset1 = "select count(*) from sOrderCheck where group_id=:groupids and op_code='m280' and flag='Y' ";
    String sql_appregionset2 = "groupids="+groupId;
    String appregionflag="0";//==0只能进行工单查询，>0可以进行工单查询或者读卡
 %>
 		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeappregion" retmsg="retMsgappregion" outnum="1"> 
			<wtc:param value="<%=sql_appregionset1%>"/>
			<wtc:param value="<%=sql_appregionset2%>"/>
		</wtc:service>  
		<wtc:array id="appregionarry"  scope="end"/>
<%
			if("000000".equals(retCodeappregion)){
				if(appregionarry.length > 0){
					appregionflag = appregionarry[0][0]; 
				}
		}
		/*关于落实打击黑卡工作的BOSS优化补充需求地市配置表end*/
 
    String accountType =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");//1 为营业工号 2 为客服工号
		String sql_sendListOpenFlag = "select count(*) from shighlogin where login_no='K' and op_code='m194'";
		String sendListOpenFlag = "0"; //下发工单开关 0：关，>0：开
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
			<wtc:param value="<%=sql_sendListOpenFlag%>"/>
		</wtc:service>  
		<wtc:array id="ret1"  scope="end"/>
<%
		if("000000".equals(retCode1)){
			if(ret1.length > 0){
				sendListOpenFlag = ret1[0][0]; 
			}
		}
		
		String sql_regionCodeFlag [] = new String[2];
	  sql_regionCodeFlag[0] = "select count(*) from shighlogin where op_code ='m195' and login_no=:regincode";
	  sql_regionCodeFlag[1] = "regincode="+regionCode;
		String regionCodeFlag = "N"; //地市是否可见 下发工单按钮 Y可见，N不可见
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode12" retmsg="retMsg12" outnum="1"> 
			<wtc:param value="<%=sql_regionCodeFlag[0]%>"/>
			<wtc:param value="<%=sql_regionCodeFlag[1]%>"/>
		</wtc:service>  
		<wtc:array id="ret2"  scope="end"/>
<%
		if("000000".equals(retCode12)){
			if(ret2.length > 0){
				if(Integer.parseInt(ret2[0][0]) > 0){
					regionCodeFlag = "Y"; 
				}
			}
		}

String passwd = ( String )session.getAttribute( "password" );
String workChnFlag = "0" ;
%>
<wtc:service name="s1100Check" outnum="30"
	routerKey="region" routerValue="<%=regionCode%>" retcode="rc" retmsg="rm" >
	<wtc:param value = ""/>
	<wtc:param value = "01"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
		
	<wtc:param value = ""/>
	<wtc:param value = ""/>
</wtc:service>
<wtc:array id="rst" scope="end" />
<%
if ( rc.equals("000000") )
{
	if ( rst.length!=0 )
	{
		workChnFlag = rst[0][0];
	}
	else
	{
	%>
		<script>
			rdShowMessageDialog( "服务s1100Check没有返回结果!" );
			removeCurrentTab();
		</script>
	<%	
	}
}
else
{
%>
	<script>
		rdShowMessageDialog( "<%=rc%>:<%=rm%>" );
		removeCurrentTab();
	</script>
<%
} 
  

    //add by diling for 安全加固修改服务列表
	  String loginPswInput = (String)session.getAttribute("password");
  %>
 			<wtc:service name="s1220Init" routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code2" retmsg="ret_message2"  outnum="33" >
			<wtc:param value=""/>
			<wtc:param value="01"/>
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=loginPswInput%>"/> 
			<wtc:param value="<%=srv_no%>"/>
			<wtc:param value=""/>
			</wtc:service>
			<wtc:array id="initBack" scope="end" />
  <%
 		  if(ret_code2.equals("0")||ret_code2.equals("000000")){
       	   System.out.println("调用服务s1220Init in s1220main.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	     	}else{
 	         	System.out.println(ret_code2+"    ret_code2");
 	     		System.out.println(ret_message2+"    ret_message2");
 			    System.out.println("调用服务s1220Init in pubSysAccept.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			    String forwardURL = "fm280.jsp?ReqPageName=s1220Main&activePhone="+srv_no+"&op_code="+op_code+"&retMsg=101&errCode="+ret_code2+"&errMsg="+ret_message2;
 			    /*
 			    if(!response.isCommitted())
	 	      	{
 			    	response.sendRedirect("fm280.jsp?ReqPageName=s1220Main&activePhone="+srv_no+"&op_code="+op_code+"&retMsg=101&errCode="+ret_code2+"&errMsg="+ret_message2);
 			    	out.close();
 			    	return;
 			    }
 			    */
 			    request.getRequestDispatcher(forwardURL).forward(request,response);
 			    System.out.println("22调用服务s1220InitEx in pubSysAccept.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			    return;
 			}
/********************** add by dujl at 20090724 start ********************************/
 		if((!initBack[0][30].equals("0000"))&&(!initBack[0][30].equals("11")))
  		{
%>
  			<script language="javascript">
  				rdShowMessageDialog("平台内部错误[<%=initBack[0][30]%>],请等平台故障恢复后在继续交易!");
  				removeCurrentTab();
  			</script>
<%
  		}
  		else if(initBack[0][30].equals("0000"))
		{
%>
  			<script language="javascript">
  				var	prtFlag = rdShowConfirmDialog("取消现场脱机支付功能还是继续换卡?");
  				if(prtFlag==1)
  				{

  				}
  				else
  				{
  					removeCurrentTab();
  				}
  			</script>
<%
  		}
/********************** add by dujl at 20090724 end   ********************************/


	//------------获取当前主资费名称，所需信息----------
	//SPubCallSvrImpl im1220=new SPubCallSvrImpl();
	int inputNo = 4;
	String   outputNo = "31";
	/**
	String  inParsm [] = new String[inputNo];
	inParsm[0] = work_no;
	inParsm[1] = srv_no;
	inParsm[2] = op_code;
	inParsm[3] = password;
  	String [] initBack1 = im1220.callService("s1270GetMsgView",inParsm,outputNo,"phone",srv_no);
  	**/
  	  %>
 			<wtc:service name="s1270GetMsg" routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code3" retmsg="ret_message3"  outnum="32" >
 			<wtc:param value=""/>
 			<wtc:param value="01"/>
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=loginPswInput%>"/> 
			<wtc:param value="<%=srv_no%>"/>
			<wtc:param value=""/>
			</wtc:service>
			<wtc:array id="initBack1" scope="end" />
    <%
 		  if(ret_code3.equals("0")||ret_code3.equals("000000")){
       	   System.out.println("调用服务s1270GetMsg in s1220main.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
/*			System.out.println("springbz[0][0]="+springbz[0][0]);*/

 	     	}else{
 	         	System.out.println(ret_code3+"    ret_code3");
 	     		System.out.println(ret_message3+"    ret_message3");
 			    System.out.println("调用服务s1270GetMsg in  s1220main.jsp  失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			    if(!response.isCommitted())
	 	      	{
	 	      	/*begin huangrong 修改转向fm280.jsp错误信息 2010-11-1 10:41*/
 			    	response.sendRedirect("fm280.jsp?ReqPageName=s1220Main&activePhone="+srv_no+"&op_code="+op_code+"&retMsg=101&errCode="+ret_code3+"&errMsg="+ret_message3);
 			    	/*end huangrong 修改转向fm280.jsp错误信息 2010-11-1 10:41*/
 			    	out.close();
 			    	return;
 			    }
 			}



	String[] twoFlag= new String[2];
	twoFlag[0] = "0";
	twoFlag[1] = "0";

	String existPhoneNo="";

%>
<%
	/* ningtn 号簿管家需求 */
	String loginNo =(String)session.getAttribute("workNo");
	String workNoPsw = (String)session.getAttribute("password");
	String[] paraAray4 = new String[7];
	paraAray4[0] = initBack[0][28].trim();
	paraAray4[1] = "01";
	paraAray4[2] = opCode;
	paraAray4[3] = loginNo;
	paraAray4[4] = workNoPsw;
	paraAray4[5] = srv_no;
	paraAray4[6] = "";
	String showText = "";
%>
	<wtc:service name="sAdTermQry" routerKey="regionCode" routerValue="<%=region_code%>"
				 retcode="retCode4" retmsg="retMsg4"  outnum="3" >
		<wtc:param value="<%=paraAray4[0]%>"/>
		<wtc:param value="<%=paraAray4[1]%>"/>
		<wtc:param value="<%=paraAray4[2]%>"/>
		<wtc:param value="<%=paraAray4[3]%>"/>
		<wtc:param value="<%=paraAray4[4]%>"/>
		<wtc:param value="<%=paraAray4[5]%>"/>
		<wtc:param value="<%=paraAray4[6]%>"/>
	</wtc:service>
	<wtc:array id="result4" scope="end" />
<%
	if("000000".equals(retCode4)){
		System.out.println("~~~~调用sAdTermQry成功~~~~");
		if(result4 != null && result4.length > 0){
			showText = result4[0][2];
		}
	}else{
		System.out.println("~~~~调用sAdTermQry失败~~~~");
%>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=retCode4%>，错误信息：<%=retMsg4%>");
				history.go(-1);
			</script>
<%
	}
%>

<%
String highmsg=(initBack[0][5]).trim();
String ss="中高端用户";
	int spos=highmsg.indexOf(ss,0);
	%>


<script language=javascript>
if(<%=spos%>>=0){rdShowMessageDialog("该用户是中高端用户！");}

if("<%=agtmsgbz[0][0]%>">"0"){rdShowMessageDialog("该用户是空中充值用户！");}
  core.loadUnit("debug");
  core.loadUnit("rpccore");

  onload=function()
  {
    self.status="";
    document.all.s_oldStatus.focus();
	chgSmCode1220();
		if("<%=op_code%>" == "m280"){
			$("#t_sys_remark").attr("readonly",false);
		}else{
			$("#t_sys_remark").attr("readonly",true);
		}
		
		if("<%=op_code%>" == "m280meishang"){
			if("<%=initBack[0][13].trim()%>"=="身份证") {
					if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y" ){//如果开关都开着
			
							if("<%=workChnFlag%>" == "1"){ //社会渠道
							$("#sendProjectList").show();
							$("#qryListResultBut").show();
							 if("<%=appregionflag%>"=="0") {//如果不在app配置表里则只能进行工单查询。
							 
							 }else {
							 		$("#scan_idCard_two").show();
							 		$("#scan_idCard_two222").show();
							 }
						  }else {//自有营业厅
							 		$("#scan_idCard_two").show();
							 		$("#scan_idCard_two222").show();						  
						  }
					}else{
					
					}
	  }
			
  }
  }

function chgcardtype()

{
	document.all.t_newsimf.value="";
    	document.all.simType.value="";
    	document.all.cardcard.value="";

	 if(document.all.cardtype[1].checked==true)  //空卡
  	{
  		 var phone = (document.all.srv_no.value).trim();
  		document.all.cardtype_bz.value="k";
  		  		 /****新增调大唐功能取SIM卡类型****/
  		 /* 
        * diling update for 修改营业系统访问远程写卡系统的访问地址，由现在的10.110.0.125地址修改成10.110.0.100！@2012/6/4
        */
  		 path ="http://10.110.0.100:33000/writecard/writecard/writeCardInfo.jsp";
  		 var retInfo1 = window.showModalDialog("<%=request.getContextPath()%>/npage/s1210/Trans.html",path,"","dialogWidth:10;dialogHeight:10;");
  		 
    	retInfo1 = "RESULT=0&OP_ID=100&REQUEST_SOURCE=1&CARD_SERIAL=00000000000000000000&MSISDN=13720017196&ICCID=89860000000000000000&IMSI=400612345678900&PIN1=1234&PIN2=1234&PUK1=12345678&PUK2=12345678&KI=11111111111111111111111111111111";

		 
		 if(typeof(retInfo1) == "undefined")
    	 {
    		 rdShowMessageDialog("读卡类型出错!");
    		return false;
    	 }

    	var chPos;
    	chPosn = retInfo1.indexOf("&");
    	if(chPosn < 0)
    	{
    		rdShowMessageDialog("读卡类型出错!");
    		return false ;
    	}
   		//alert( retInfo1.substring(0,chPos));
    	retInfo1=retInfo1+"&";
    	var retVal=new Array();
    	for(i=0;i<4;i++)
    	{

    		var chPos = retInfo1.indexOf("&");
        	valueStr = retInfo1.substring(0,chPos);
        	var chPos1 = valueStr.indexOf("=");
        	valueStr1 = valueStr.substring(chPos1+1);
        	retInfo1 = retInfo1.substring(chPos+1);
        	retVal[i]=valueStr1;

    	}
    	//alert("retVal[0]"+retVal[0]);
    	if(retVal[0]=="0")
    	{

    		var rescode_str=retVal[2]+"|";

    		//alert("rescode_str"+rescode_str);
    		var rescode_strstr="";
    		//alert("rescode_str="+rescode_str)
    		var chPosm = rescode_str.indexOf("|");
    		for(i=0;i<4;i++)
    		{

    			var chPos1 = rescode_str.indexOf("|");
        		valueStr = rescode_str.substring(0,chPos1);
        		rescode_str = rescode_str.substring(chPos1+1);
        		//alert("rescode_str="+rescode_str)
        		if(i==0 && valueStr=="")
        		{
        			rdShowMessageDialog("读卡类型出错!");
    		 		return false;
        		}
        		//alert("valueStr="+valueStr);
        		if(valueStr!=""){
        			rescode_strstr=rescode_strstr+"'"+valueStr+"'"+",";
        			//alert("rescode_strstr="+rescode_strstr);
        		}

    		}
    		rescode_strstr=rescode_strstr.substring(0,rescode_strstr.length-1);
    		if(rescode_strstr=="")
    		{
    			rdShowMessageDialog("读卡类型出错!");
    		 	return false;
    		}
  			 //alert("rescode_strstr="+rescode_strstr);
  		}
  		else{
  			 rdShowMessageDialog("读卡类型出错!");
    		 return false;
    	}
  		 /****取SIM卡类型结束******/
    		 var path = "/npage/innet/fgetsimno_1104.jsp";
    		 path = path + "?regioncode=" + "<%=belRes[0][0]%>";
    	         path = path + "&phone=" + phone + "&rescode=" + rescode_strstr+ "&pageTitle=" + "生成SIM卡号码";

    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");

    		 if(typeof(retInfo) == "undefined")
    			{	return false;   }

    		var simsim=oneTok(oneTok(retInfo,"~",1));
    		var typetype=oneTok(oneTok(retInfo,"~",2));
    		var cardcard=oneTok(oneTok(retInfo,"~",3));


    		document.all.t_newsimf.value=simsim;
    		document.all.simType.value=typetype;
    		document.all.cardcard.value=cardcard;


			if("10073"==cardcard.trim()){
       	rdShowMessageDialog("请去“m404城市通开卡代收费界面”收取公交费。");
       }
       
  	}else{
  		document.all.b_write.disabled=true;
  		document.all.cardtype_bz.value="s";
  	}

}
function writechg(){
	if(document.all.t_newsimf.value==""){
		rdShowMessageDialog("新sim卡号不能是空!");
		return false;
	}
	if(document.all.cardtype_bz.value=="k"){
		var phone = (document.all.srv_no.value).trim();
  			document.all.b_write.disabled=true;
    		 var path = "/npage/innet/fwritecard.jsp";
    		 path = path + "?regioncode=" + "<%=region_code%>";
    		 path = path + "&sim_type=" +document.all.cardcard.value;
    		 path = path + "&sim_no=" +document.all.t_newsimf.value;
    		 path = path + "&op_code=" +"m280";
    		 path = path + "&phone=" + phone + "&pageTitle=" + "写卡";
    		 path = path + "&deleteShowCardNoFlag=" +"isDelCardNo"; //add by diling  for 关于哈分公司申请优化远程写卡操作步骤的请示
    		 path = path + "&selectRegionCode="+"<%=belRes[0][0]%>";
    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    		  if(typeof(retInfo) == "undefined")
    			{	rdShowMessageDialog("写卡失败");
    				//document.all.b_write.disabled=false;
    				document.all.writecardbz.value="1";
    				return false;   }
    		 //rdShowMessageDialog("ssssssssssss");
    		 var retsimcode=oneTok(oneTok(retInfo,"|",1));
    		 var retsimno=oneTok(oneTok(retInfo,"|",2))
    		 var cardstatus=oneTok(oneTok(retInfo,"|",3))
    		 var cardNO=oneTok(oneTok(retInfo,"|",4));
    		 //alert("cardNO="+cardNO);
    		  if(retsimcode=="0"){
    		  	/* 关于优化BOSS换卡和营销活动执行操作界面的需求@2014/12/29 */
    		  	//rdShowMessageDialog("写卡成功");
    		 document.all.writecardbz.value="0";
    		 document.all.t_newsimf.value=retsimno;
    		  	document.all.cardstatus.value=cardstatus;
    		  	document.all.cardNO.value=cardNO;  /****add by sungq******/

    		  	if(cardstatus=="3"){document.all.t_simFeef.value="0";}
    		 }else{rdShowMessageDialog("写卡失败");
    		 	//document.all.b_write.disabled=false;
    		 	document.all.writecardbz.value="1";
    		 }
		// rdShowMessageDialog(document.all.writecardbz.value);

	}
	else{
		rdShowMessageDialog("实卡不能写卡");
		document.all.b_write.disabled=true;
		return false;
	}
}
// 获取身份证照片--wanghyd20120426
function getPhoto()
{
	window.open("../innet/fgetIccIdPhoto.jsp?idIccid="+document.all.icc_no.value,"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-500) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
}
//wanghyd add at 20120426 for 身份证校验
function checkIccId()
{

	document.all.iccIdCheck.disabled=true;
	var myPacket = new AJAXPacket("/npage/innet/fIccIdCheck.jsp","正在验证身份证信息，请稍候......");
	myPacket.data.add("retType","iccIdCheck");
	myPacket.data.add("idIccid",document.all.icc_no.value);
	myPacket.data.add("custName",document.all.cus_name.value);
	myPacket.data.add("IccIdAccept","<%=initBack[0][28].trim()%>");
	myPacket.data.add("opCode",document.all.op_code.value);
	myPacket.data.add("phoneNo","<%=srv_no%>");
	core.ajax.sendPacket(myPacket,docheckICCID);
	myPacket=null;
	document.all.iccIdCheck.disabled=false;
}
function docheckICCID(packet) {
   	//RPC处理函数findValueByName
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage"); 
	if((retCode).trim()=="")
	{
       rdShowMessageDialog("调用"+retType+"服务时失败！");
       return false;
	}
	 if(retType=="iccIdCheck")
	 {
	 	if(retCode == "000000")
	 	{
	 		rdShowMessageDialog("校验通过！");
	 		document.all.get_Photo.disabled=false;
	 	}
	 	else
	 	{

	 		retMessage = retCode + "："+retMessage;	
			rdShowMessageDialog(retMessage);

	 	}
	 }

}
//----------------验证及提交函数-----------------
function printCommit()
{

		if("<%=op_code%>" == "m280meishang"){
			if("<%=initBack[0][13].trim()%>"=="身份证") {
					if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y" ){//如果开关都开着
							if("<%=workChnFlag%>" == "1"){ //社会渠道
							$("#sendProjectList").show();
							$("#qryListResultBut").show();
							 if("<%=appregionflag%>"=="0") {//如果不在app配置表里则只能进行工单查询。
							 
								if(($("#isQryListResultFlag").val() == "N")){ //已查询工单列表，并下发工单开关为开，则进行校验
									rdShowMessageDialog("请先进行工单结果查询，再进行确认操作！");
							    return false;		
								}
				
							 }else {
							 
							 		if($("#hqdcusticcid").val().trim()==""){
									rdShowMessageDialog("请先进行工单结果查询或读卡后，再进行确认操作！");
							    return false;																 			
							 		}

							 }
						  }else {//自有营业厅
							 		if($("#hqdcusticcid").val().trim()==""){
									rdShowMessageDialog("请先进行读卡后，再进行确认操作！");
							    return false;																 			
							 		}				  
						  }
						  if($("#hqdcusticcid").val().trim()!="<%=initBack[0][14].trim()%>"){
									rdShowMessageDialog("获取的证件号码和原证件号码不一致，不能进行换卡操作！");
							    return false;							  
						  }
					}
	  }
			
  }

	/*zhangyan add*/

	if ("<%=initBack[0][31]%>"=="0")
	{
		if (  !(document.all.cardtype[1].checked==true )  )
		{
			rdShowMessageDialog("号码办理了携号转网卡类型只能选择空卡!",0);
			return false;
		}
	}
	getAfterPrompt();
	// in here form check
	// begin huangrong add 验证sim卡费不能为空
	if((document.all.t_simFeef.value.trim().length==0)){
		 	rdShowMessageDialog("sim卡费不能为空!");
		 	return false;
 	}
 	// end huangrong add 验证sim卡费不能为空
	 if((document.all.writecardbz.value!="0") && (document.all.cardtype_bz.value=="k")){
 	rdShowMessageDialog("写卡未成功不能确认!");
 	return false;

 }
 	
	 <%if(istestNum&&opCode.equals("m280")){%>
	 	var oaNum = $("#oaNum").val().trim();
	   	if(oaNum==""){
	 		rdShowMessageDialog("OA编号不能为空!");
	 	    return false;
	 	}
		<%}%>
 
 	
 	
	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
}

 function showPrtDlg(printType,DlgMessage,submitCfm)
 {
	 if((document.all.assuId.value).trim().length>0)
	 {
        if(document.all.assuId.value.length<5)
		{
          rdShowMessageDialog("证件号码长度有误(至少5位)！");
	      document.all.assuId.focus();
		}
	 }

     if(check(frm))
     {
     		/* diling add for 关于申请开放BOSS1220换卡界面备注信息的申请@2014/11/4  */
     		if(document.all.t_sys_remark.value == ""){
     			document.all.t_sys_remark.value="用户"+"<%=initBack[0][1].trim()%>"+"<%=op_name%>";
     		}

		 if((document.all.t_op_remark.value).trim().length==0)
      {
			  if("<%=op_code%>" == "m280"){
			  	document.all.t_op_remark.value=document.all.t_sys_remark.value;
			  }else{
			  	document.all.t_op_remark.value="操作员<%=work_no%>"+"对用户"+"<%=initBack[0][1].trim()%>"+"进行 "+"<%=op_name%>";	
			  }

	  }
	  if("<%=op_code%>" == "m280"){
	  	document.all.t_op_remark.value=document.all.t_sys_remark.value;
	  }else{
	  	document.all.t_op_remark.value="操作员<%=work_no%>"+"对用户"+"<%=initBack[0][1].trim()%>"+"进行 "+"<%=op_name%>";
	  }
	   if((document.all.assuNote.value).trim().length==0)
      {
			  document.all.assuNote.value="操作员<%=work_no%>"+"对用户"+"<%=initBack[0][1].trim()%>"+"进行"+"<%=op_name%>";

	  }

		//显示打印对话框
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var pType="subprint";
		var billType="1";
		var printStr = printInfo(printType);

		var mode_code=null;
		var fav_code=null;
		var area_code=null;
		var sysAccept = "<%=initBack[0][28].trim()%>";
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
		var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=op_code%>&sysAccept="+sysAccept+"&phoneNo=<%=srv_no%>&loginacceptJT="+$("#loginacceptJT").val()+"&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);

		if(typeof(ret)!="undefined")
		{
			if((ret=="confirm")&&(submitCfm == "Yes"))
			{
				if(rdShowConfirmDialog('确认电子免填单吗？')==1)
				{
					conf();
				}
			}
			if(ret=="continueSub")
			{
				if(rdShowConfirmDialog('确认要提交<%=op_name%>信息吗？')==1)
				{
					 conf();
				}
			}
		}
		else
		{
			if(rdShowConfirmDialog('确认要提交<%=op_name%>信息吗？')==1)
			{
				conf();
			}
		}
	 }
 }

function printInfo(printType)
{
  var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";

	cust_info+="手机号码："+document.all.srv_no.value+"|";
	cust_info+="客户姓名："+document.all.cus_name.value+"|";
	cust_info+="客户地址："+document.all.cus_addr.value+"|";
	cust_info+="证件号码："+document.all.icc_no.value+"|";

	opr_info+="用户品牌："+"<%=initBack[0][29].trim()%>"+"  办理业务:补卡变更"+"|";
	opr_info+="操作流水："+"<%=initBack[0][28].trim()%>"+"  SIM卡费："+parseFloat(document.all.t_simFeef.value)+"|";
	opr_info+="原SIM卡号："+"<%=initBack[0][9].trim()%>"+"  原SIM卡类型"+"<%=initBack[0][10].trim()%>"+"|";
	opr_info+="新SIM卡号："+document.all.t_newsimf.value+"  新SIM卡类型"+document.all.simType.value+"|";

	note_info1="备注："+"|";
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	
	//4G项目要求修改免填单 hejwa add 2014年3月6日8:59:57
 //note_info4+=""+"|";
// note_info4+="4G试商用提示："+"|";
// note_info4+="1、中国移动4G业务需要TD-LTE制式终端支持，并更换支持4G功能的USIM卡、开通4G服务功能；"+"|";
// note_info4+="2、客户入网时选用或更换支持4G功能USIM卡时，将同时开通4G服务功能；"+"|";
// note_info4+="3、4G网速较快，办理高档位套餐可以享受更多的流量优惠；"+"|";
// note_info4+="4、4G业务仅在4G网络所覆盖的范围内提供，中国移动将不断扩大4G覆盖区域、提高服务质量。"+"|";
	//retInfo+="哈尔滨地区用户自SIM卡售出日起30天内，由于非人为原因引起的SIM卡损坏或因机卡配合"+"|";
	//retInfo+="引起的SIM无法使用，我公司可为您免费补卡。"+"|";
    return retInfo;
}

 //--------3---------验证按钮专用函数-------------
 function chkSim(phoneNo,simOldNo,simNewNo)
 {
	if((document.all.t_newsimf.value).trim().length==0)
	{
      rdShowMessageDialog("新SIM卡号不能为空！");
	  document.all.t_newsimf.value="";
	  document.all.t_newsimf.focus();
	  return false;
	}
		var idsd_no = <%=initBack[0][1].trim()%>;
	var smtypesd =(document.all.t_newsimf.value).trim();
	var myPacketsd = new AJAXPacket("<%=request.getContextPath()%>/npage/s1210/checkWLYXLR.jsp","正在验证新SIM类型，请稍候......");
	myPacketsd.data.add("id_no",idsd_no);
	myPacketsd.data.add("t_newsimf",smtypesd);
	myPacketsd.data.add("phoneNo",phoneNo);
	myPacketsd.data.add("simOldNo",simOldNo);
	myPacketsd.data.add("simNewNo",simNewNo);
	core.ajax.sendPacket(myPacketsd,checksimtypesd);
	myPacketsd=null;
	
  	var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s1210/chgSim1220.jsp","正在验证新SIM卡号，请稍候......");
	myPacket.data.add("phoneNo",phoneNo);
	myPacket.data.add("simOldNo",simOldNo);
	myPacket.data.add("simNewNo",simNewNo);
	myPacket.data.add("orgCode", document.all.orgCode.value);
	myPacket.data.add("cardsim_type",document.all.cardcard.value);
	
	var smCodeDivHtml = $.trim($("#smCodeDiv").html());
	var simTypeOne = $("select[name='simTypeOne']").find("option:selected").val();
	if( smCodeDivHtml == "铁通e固话"){
		myPacket.data.add("simTypeOne",simTypeOne);
	}else{
		myPacket.data.add("simTypeOne","");
	}
	
	var cardtype="";
	if(document.all.cardtype[1].checked==true){
		document.all.cardtype_bz.value="k";
		cardtype="k";}
	else{	document.all.cardtype_bz.value="s";
		cardtype="s";
	}

	myPacket.data.add("cardtype",cardtype);

	core.ajax.sendPacket(myPacket);
	myPacket=null;
 }

 function checksimtypesd(packet) {
 var simtypesz = packet.data.findValueByName("simtypesz");
 //alert(simtypesz)
 var phoneNo = packet.data.findValueByName("phoneNo");
 var simOldNo = packet.data.findValueByName("simOldNo");
 var simNewNo = packet.data.findValueByName("simNewNo");
 
 var sim_type_code = packet.data.findValueByName("sim_type_code");
       if("10073"==sim_type_code){
       	rdShowMessageDialog("请去“m404城市通开卡代收费界面”收取公交费。");
       } 
 
 		if(simtypesz=="wlyxlr") {//如果是网络优先接入客户给予提示
 		rdShowMessageDialog("该用户是优先接入用户，请更换专用的sim卡，如果不使用专用的sim卡，该用户将不能使用优先接入服务！");
 		}
 		else {
 		}
 }
 //--------3---------验证按钮专用函数-------------
 function chgSmCode1220()
 {
    if("<%=op_code%>"=="m280")
    {
		if((document.all.srv_no.value).trim().length==0)
		{
		  return true;
		}
		else
		{
		  if(document.all.srv_no.value.length!=11) return false;
		}

		var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s1210/chSmCode1220_rpc.jsp","正在获得业务品牌，请稍候......");
		myPacket.data.add("srv_no",(document.all.srv_no.value).trim());
		myPacket.data.add("verifyType","smcode");
		core.ajax.sendPacket(myPacket);
		myPacket=null;
    }
	else
    {
		if(frm.cus_pass.disabled){frm.qryPage.focus();}else{frm.cus_pass.focus();}
	}
 }

 function doProcess(packet)
 {
	var verifyType = packet.data.findValueByName("verifyType");

	if(verifyType == "smcode" )
	{
		var smCode=packet.data.findValueByName("smCode");
 		document.getElementById("smCodeDiv").innerHTML = smCode;
 		$("#simCodeHide").val(smCode);
 		if(smCode == "铁通e固话"){
 			$("#simTypeOneShowHide").show();
 		}else{
 			$("#simTypeOneShowHide").hide();
 		}
	}
    else
	{
		var errCode=packet.data.findValueByName("errCode");
		var errMsg=packet.data.findValueByName("errMsg");
		var simFee=packet.data.findValueByName("simFee");
		var nomalchg4gflag=packet.data.findValueByName("nomalchg4gflag");
		
		var simType=packet.data.findValueByName("simType");
		/*liujian 2012-12-25 15:15:58 首次办理换卡变更 begin*/
		var changeType=packet.data.findValueByName("changeType");	
		if(changeType == 'N') {
			$('#changeType').val('N');
			//设置sim卡费为0
			simFee = '0';
			rdShowMessageDialog("该客户为SIM卡数据异常客户，本次补卡免费!");
		}else {
			$('#changeType').val('Y');	
		}
		/*liujian 2012-12-25 15:15:58 首次办理换卡变更 over*/
		self.status="";

		if(parseInt(errCode)!=0)
		{
		  //rdShowMessageDialog("SIM卡验证错误！");
		  rdShowMessageDialog("错误"+errCode+"："+errMsg);
		  document.all.t_newsimf.value="";
		  document.all.t_newsimf.focus();
		}
		else
		{
		  document.all.t_simFeef.value=(simFee).trim();
		  document.all.simType.value=(simType).trim();
		  document.all.oriSimFee.value=(simFee).trim();
		  
		  if(nomalchg4gflag=="Y") {//用户由非4GSIM卡更换为4GSIM卡，则SIM卡非默认为0元
		  document.all.t_simFeef.value='0';
		  }
		  
		  if((document.all.t_simFeef.value).trim().length==0)
		  document.all.t_simFeef.value="0.00";
		  if((document.all.simType.value).trim().length=="")
		  document.all.simType.value="";
		  if((document.all.oriSimFee.value).trim().length==0)
		  document.all.oriSimFee.value="0.00";
		  document.all.t_simFeef.focus();
		  document.all.t_simFeef.select();

		  document.all.b_print.disabled=false;

		  if(document.all.cardtype_bz.value=='k'){
			  document.all.b_write.disabled=false;

		  }
		  document.all.t_newsimf.disabled=true;
		}
	}
 }
 
  /*2014/04/04 11:02:20 gaopeng 调用公共查询返回品牌sm_code*/
	function getPubSmCode(myNo){
			var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("phoneNo",myNo);
			getdataPacket.data.add("kdNo","");
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

 function conf()
 {
 	var vPhoneNo = $.trim(document.all.srv_no.value);
 	getPubSmCode(vPhoneNo);
 	var pubSmCode = $("#pubSmCode").val();
 	/*gaopeng 2013/4/2 星期二 18:34:04 物联网需求 判断是205 206开头的物联网号码，进行调用zhangzhea的服务sWLWInterFace begin */
	    if(pubSmCode=="PA"||pubSmCode=="PB")
			{
				 var myPacket = new AJAXPacket("/npage/public/sWLWI.jsp", "正在提交，请稍候......");
			    myPacket.data.add("iLoginAccept", document.all.loginAccept.value);							//流水              
			    myPacket.data.add("iChnSource", "01");																					//渠道标识          
			    myPacket.data.add("iOpCode", "1220");												//操作代码          
			    myPacket.data.add("iLoginNo", "");																							//操作工号	        
			    myPacket.data.add("iLoginPwd", "");																							//工号密码	        
			    myPacket.data.add("iPhoneNo", document.all.srv_no.value); 											//手机号码	        
			    myPacket.data.add("iUserPwd", "");																							//号码密码          
			    myPacket.data.add("iOrgCode", "");																							//工号归属          
			    myPacket.data.add("iIdNo", document.all.cus_id.value);                        	//用户ID		        
			    myPacket.data.add("iOldSim", document.all.simOldNo.value);                      //用户旧SIM卡号			
			    myPacket.data.add("iOldSimStatus", document.all.s_oldStatus.value);             //用户旧SMI卡状态	  
			    myPacket.data.add("iNewSim", document.all.t_newsimf.value);                     //用户新SIM卡号	    
			    myPacket.data.add("iNewSimShouldFee", document.all.oriSimFee.value);            //用户新SIM卡应收费 
			    myPacket.data.add("iNewSimRealFee", document.all.t_simFeef.value);              //用户新SIM卡实收费 
			    myPacket.data.add("iHandShouldFee", document.frm.oriHandFee.value);             //用户手续费应收		
			    myPacket.data.add("iHandRealFee", document.frm.t_handFee.value);                //用户手续费实收	  
			    myPacket.data.add("iSystemNote", document.frm.t_sys_remark.value);              //系统备注          
			    myPacket.data.add("iOpNote", document.frm.t_op_remark.value);                   //用户备注          
			    myPacket.data.add("iIpAddr", document.frm.ipAdd.value);                         //IP地址            
			    myPacket.data.add("iCardBZ", document.frm.cardtype_bz.value);                   //写卡状态          
			    myPacket.data.add("iCardStatus", document.frm.cardstatus.value);                //空卡状态          
			    myPacket.data.add("iCardNo", document.frm.cardNO.value);                   			//空卡卡号          
			    myPacket.data.add("iTransConId", "");                    												//转存帐户          
			    myPacket.data.add("iTransMoney", "");                														//转存金额          
			    myPacket.data.add("iTransPhoneNo", "");                													//转存手机号        
			    myPacket.data.add("iTurnPhoneNo", "");                      										//转赠资源号码      
			    myPacket.data.add("iTurnType", "");                                      				//转赠资源号码类型  
			    myPacket.data.add("iRemindPhone", "");                                          //欠费提醒号码(问diling怎么取的，目前有问题)	    
			    
			    core.ajax.sendPacket(myPacket,retsWLWI);
			    
			    myPacket=null;
					
			}
 	else{
   frm.action="fm280_conf.jsp";
   document.all.t_newsimf.disabled=false;
   frm.submit();
	 }
 }
	function retsWLWI(packet)
{
	 var errCode = packet.data.findValueByName("errCode");
   var errMsg = packet.data.findValueByName("errMsg");
   if(errCode=="000000")
   {
	   	rdShowMessageDialog("物联网用户申请信息已经发送集团公司，审批通过后继续为您办理业务。");
	   	removeCurrentTab();
   }
   else
   	{
   		rdShowMessageDialog("物联网用户申请信息发送失败！"+errCode + "[" + errMsg + "]",0);
   		removeCurrentTab();
   	}
   
}
 //-------6--------实收栏专用函数----------------
function ChkHandFee()
 {
   if((document.all.oriHandFee.value).trim().length>=1 && (document.all.t_handFee.value).trim().length>=1)
   {
	 if(parseFloat(document.all.oriHandFee.value)<parseFloat(document.all.t_handFee.value))
	 {
	   rdShowMessageDialog("实收手续费不能大于原始手续费！");
	   document.all.t_handFee.value=document.all.oriHandFee.value;
	   document.all.t_handFee.select();
	   document.all.t_handFee.focus();
	   return;
	 }
   }

   if((document.all.oriHandFee.value).trim().length>=1 && (document.all.t_handFee.value).trim().length==0)
   {
	 document.all.t_handFee.value="0";
   }
 }
  function ChkSimFee()
 {
   if((document.all.t_simFeef.value).trim().length>=1)
   {
	 if(parseFloat(document.all.oriSimFee.value)<parseFloat(document.all.t_simFeef.value))
	 {
	  rdShowMessageDialog("实收SIM卡费不能大于原始SIM卡费！");
	  document.all.t_simFeef.value=document.all.oriSimFee.value;
	  document.all.t_simFeef.select();
	  document.all.t_simFeef.focus();
	  return;
	 }
   }

   if((document.all.oriSimFee.value).trim().length>=1 && (document.all.t_simFeef.value).trim().length==0)
   {
	 document.all.t_simFeef.value="0";
   }
 }
function getFew()
{
  if(window.event.keyCode==13)
  {
    var fee=document.all.t_handFee
	var simFee = document.all.t_simFeef;
    var fact=document.all.t_factFee;
    var few=document.all.t_fewFee;
    if((fact.value).trim().length==0)
    {
	  rdShowMessageDialog("实收金额不能为空！");
	  fact.value="";
	  fact.focus();
	  return;
    }
    if(parseFloat(fact.value)<parseFloat(fee.value) + parseFloat(simFee.value))
    {
  	  rdShowMessageDialog("实收金额不足！");
	  fact.value="";
	  fact.focus();
	  return;
    }

	var tem1=((parseFloat(fact.value)-parseFloat(fee.value)-parseFloat(simFee.value))*100+0.5).toString();
	var tem2=tem1;
	if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
    few.value=(tem2/100).toString();
    few.focus();
  }
}
/* ningtn 号簿管家需求 */
	$(document).ready(function(){
		var showtext = "<%=showText%>";
		var showMsgObj = $("#showMsg");
		showMsgObj.hide();
		if(showtext.length > 0){
			showMsgObj.children("div").text(showtext);
			showMsgObj.show();
		}
	});
	
	
	
	     	
     	//下发工单
		  function sendProLists(){
				var packet = new AJAXPacket("/npage/sq100/fq100_ajax_sendProLists.jsp","正在获得数据，请稍候......");
				packet.data.add("opCode","<%=opCode%>");
				packet.data.add("phoneNo","<%=srv_no.trim()%>");
				core.ajax.sendPacket(packet,doSendProLists);
				packet = null;
		  } 
		  
		  function doSendProLists(packet){
		  	var retCode = packet.data.findValueByName("retCode");
				var retMsg =  packet.data.findValueByName("retMsg");
				if(retCode != "000000"){
					rdShowMessageDialog( "下发工单失败!<br>错误代码："+retCode+"<br>错误信息："+retMsg,0 );
					//记录为没点击
					$("#isSendListFlag").val("N");
				}else{
					rdShowMessageDialog( "下发工单成功!" );
					//记录为点击
					$("#isSendListFlag").val("Y");
				}
		  }
		  
		  //工单结果查询
			function qryListResults(){
				var h=450;
				var w=800;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;status:no;help:no";
				var ret=window.showModalDialog("/npage/sq100/f1100_qryListResults.jsp?opCode=<%=opCode%>&opName=<%=opName%>&accp="+Math.random(),"",prop);
				if(typeof(ret) == "undefined"){
					rdShowMessageDialog("如果没有工单查询结果，请先进行下发工单操作！");
					$("#isQryListResultFlag").val("N");//选择了工单查询结果
				}else if(ret!=null && ret!=""){
					$("#isQryListResultFlag").val("Y");//选择了工单查询结果
					$("#hqdcustname").val(ret.split("~")[0]); //客户姓名
					$("#hqdcusticcid").val(ret.split("~")[1]); //证件号码
					$("#loginacceptJT").val(ret.split("~")[4]); //集团流水
					
				}
			}
			
</script>
</head>
<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">

<form name="frm" method="POST"  onKeyUp="chgFocus(frm)">

	   <%@ include file="/npage/include/header.jsp" %>
 <!-- /* ningtn 号簿管家需求 */  -->
<div class="title" id="showMsg">
	<div id="title_zi">

	</div>
</div>
					<div class="title">
						<div id="title_zi"><%=opName%></div>
					</div>


  <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1220Main">
  <input type="hidden" name="srv_no" id="srv_no"  value="<%=srv_no%>">
   <input type="hidden" name="cardcard" id="cardcard">
   <input type="hidden" name="cardNO" id="cardNO">
   <input name=writecardbz type=hidden value="">
   <input name="cardstatus" type=hidden value="">
   <input type="hidden" name="cardtype_bz" id="cardtype_bz" value="s">
  <input type="hidden" name="cus_id" id="cus_id" value="<%=initBack[0][1].trim()%>">
  <input type="hidden" name="cus_name" id="cus_name" value="<%=initBack[0][8].trim()%>">
  <input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=oriHandFee.trim()%>">
  <input type="hidden" name="oriSimFee" id="oriSimFee"  value="">
  <input type="hidden" name="simOldNo" id="simOldNo" value="<%=initBack[0][9].trim()%>">
  <input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
  <input type="hidden" name="icc_no" id="icc_no" value="<%=initBack[0][14].trim()%>">
  <input type="hidden" name="cus_addr" id="cus_addr" value="<%=initBack[0][15].trim()%>">
  <input type="hidden" name="loginAccept" id="loginAccept" value="<%=initBack[0][28]%>">
  <input type="hidden" name="orgCode" id="orgCode" value="<%=org_code%>">
  <!--liujian 2012-12-25 15:17:32 首次办理换卡变更 begin-->
  <input type="hidden" name="changeType" id="changeType" value="">
  <!--2015/9/7 9:10:41 gaopeng pubSmCode -->
  <input type="hidden" name="pubSmCode" id="pubSmCode" value="">
  <!--liujian 2012-12-25 15:17:32 首次办理换卡变更 over-->
  <%@ include file="../../include/remark.htm" %>

        <table cellspacing="0" >
          <tr>
            <td width="11%" nowrap class="blue">
              <div align="left">大客户标志</div>
            </td>
            <td nowrap width="18%">
              <div align="left"><b><font color="red"><%=twoFlag[0]%></font></b></div>
            </td>
            <td width="11%" nowrap  class="blue">
              <div align="left">集团标志</div>
            </td>
            <td nowrap height="14">
              <div align="left"><%=twoFlag[1]%></div>
            </td>
            <td nowrap  class="blue">
              <div align="left">服务号码</div>
            </td>
            <td nowrap height="14"><%=srv_no.trim()%></td>
          </tr>
          <tr>
            <td width="11%" nowrap  class="blue">
              <div align="left">证件类型</div>
            </td>
            <td nowrap width="18%">
              <div align="left"><%=initBack[0][13].trim()%></div>
            </td>
            <td width="11%" nowrap class="blue">
              <div align="left">证件号码</div>
            </td>
            <td nowrap height="14">
              <div align="left"><%=initBack[0][14].trim()%></div>
            </td>
            <td nowrap  class="blue">
              <div align="left">SIM卡名</div>
            </td>
            <td nowrap height="14"><%=initBack[0][10].trim()%></td>
          </tr>
          <tr>
            <td width="11%" nowrap class="blue">
              <div align="left">用户ID</div>
            </td>
            <td nowrap width="18%">
              <div align="left"><%=initBack[0][1].trim()%></div>
            </td>
            <td nowrap width="11%" class="blue">
              <div align="left">用户名称</div>
            </td>
            <td nowrap width="31%">
              <div align="left"><%=initBack[0][8].trim()%></div>
            </td>
            <td nowrap width="11%" class="blue">
              <div align="left">号码归属hlr</div>
            </td>
            <td nowrap width="18%">
              <!--<div align="left"><%=initBack[0][5].trim()%></div>-->
              <div align="left"><%=hlrCodeOne%></div>
            </td>
          </tr>
          <tr>
            <td width="11%" nowrap  class="blue">
              <div align="left">当前预存</div>
            </td>
            <td nowrap width="18%" height="2">
              <div align="left"><%=initBack[0][6].trim()%></div>
            </td>
            <td nowrap width="11%"  class="blue">
              <div align="left">当前欠费</div>
            </td>
            <td nowrap width="31%">
              <div align="left"><%=initBack[0][7].trim()%></div>
            </td>
            <td nowrap width="11%" class="blue">
              <div align="left">当前状态</div>
            </td>
            <td nowrap width="18%">
              <div align="left"><%=initBack[0][3].trim()%></div>
            </td>
          </tr>
		  <tr>
		  	<td nowrap width="11%" class="blue">
              <div align="left">品牌</div>
            </td>
            <td nowrap width="18%">
              <div align="left" id="smCodeDiv"></div>
              <input type="hidden" name="simCodeHide" id="simCodeHide" value="" />
            </td>

			  <td nowrap width="11%"  class="blue">
							<div align="left">当前主资费</div>
			  </td>
				<td nowrap width="31%" >
							<div align="left"><%=initBack1[0][17].trim()%></div>
				</td>
							  <td nowrap width="11%"  class="blue">
							<div align="left"><input type="button" name="iccIdCheck" class="b_text" value="校验" onclick="checkIccId()" ></div>
			  </td>
				<td nowrap width="31%" >
							<div align="left"><input type="button" name="get_Photo" class="b_text"   value="显示照片" onClick="getPhoto()" disabled></div>
				</td>

		  </tr>
		  <tr>
		  		<td colspan="6">
		  							<input type="button" id="sendProjectList" name="sendProjectList" class="b_text" value="下发工单" onclick="sendProLists()" style="display:none" />                    
                  	&nbsp;&nbsp;&nbsp;
                  	<input type="button" id="qryListResultBut" name="qryListResultBut" class="b_text" value="工单结果查询" onclick="qryListResults()" style="display:none" /> 
                  	&nbsp;&nbsp;&nbsp;   
                  	<input type="button" name="scan_idCard_two" id="scan_idCard_two" class="b_text"   value="读卡" onClick="Idcard_realUser()" style="display:none">
                    <input type="button" name="scan_idCard_two222" id="scan_idCard_two222" class="b_text"   value="读卡(2代)" onClick="Idcard2('1')" style="display:none">	
          </td>
		  </tr>
		      <tr style="display:none">
            <td nowrap width="16%" class="blue">
              <div align="left">获取的证件名称</div>
            </td>
            <td >
              <div align="left">
                <input type="text" name="hqdcustname" id="hqdcustname" size="20"  readonly class="InputGrey"/>
              </div>
            </td>
             <td nowrap width="16%" class="blue">
              <div align="left">获取的证件号码</div>
            </td>
            <td nowrap colspan="5">
              <div align="left">
                <input type="text" name="hqdcusticcid" id="hqdcusticcid" size="20" readonly  class="InputGrey"/>
              </div>
            </td>
          </tr>
          
          <tr>
            <td colspan="6">
              <hr>
            </td>
          </tr>
                <tr style="display:none">
                  <td nowrap width="15%" class="blue">
                    <div align="left">担保人姓名</div>
                  </td>
                  <td nowrap width="19%">
                    <input name=assuName class="button"  value="<%=initBack[0][16].trim()%>">
                  </td>
                  <td nowrap width="15%" class="blue">
                    <div align="left">担保人电话</div>
                  </td>
                  <td nowrap width="18%">
                    <input name=assuPhone class="button"  value="<%=initBack[0][17].trim()%>">
                  </td>
                </tr>
                <tr style="display:none">
                  <td nowrap width="15%" class="blue">
                    <div align="left">担保人证件类型</div>
                  </td>
                  <td nowrap width="18%">
                    <select name="assuIdType" id="assuIdType" index="2">
<%
        //得到输入参数

                //String sqlStr ="select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType order by id_type";
                //lj. 绑定参数
								String sql_select3 = "select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType order by id_type";
                //retArray = co.sPubSelect("3",sqlStr,"phone",srv_no);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
                //result = (String[][])retArray.get(0);
                %>
						<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code" retmsg="ret_message" outnum="3">
							<wtc:param value="<%=sql_select3%>"/>
						</wtc:service>
						<wtc:array id="result" scope="end" />
				  <%


			         if(ret_code.equals("0")||ret_code.equals("000000")){
			          System.out.println("调用服务sPubSelect in s1220Main.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
			 	        	if(result.length==0){
			 	            }else{
			 	            	 int recordNum = result.length;
			 	        	      for(int i=0;i<recordNum;i++){
									  if(result[i][0].trim().equals(initBack[0][18].trim()))
					                    out.println("<option class='button' value='" + result[i][0] + "' selected>" + result[i][1] + "</option>");
					 				  else
								       out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
					                }
			 	        	}

			 	     	}else{
			 	         	System.out.println(ret_code+"    ret_code");
			 	     		System.out.println(ret_message+"    ret_message");
			 				System.out.println("调用服务sPubSelect in s1220Main.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");

			 			}

%>
                    </select>
                  </td>
                  <td nowrap width="15%" class="blue">
                    <div align="left">担保人证件号码</div>
                  </td>
                  <td nowrap width="19%">
                    <input name=assuId class="button"  value="<%=initBack[0][19].trim()%>">
                  </td>
                </tr>
                <tr style="display:none">
                  <td nowrap width="15%" class="blue">
                    <div align="left">担保人证件地址</div>
                  </td>
                  <td nowrap colspan="3">
                    <input name=assuIdAddr class="button"  value="<%=initBack[0][20].trim()%>">
                  </td>
                </tr>
                <tr style="display:none">
                  <td nowrap width="15%" class="blue">
                    <div align="left">担保人联系地址</div>
                  </td>
                  <td nowrap colspan="3">
                    <input name=assuAddr class="button"  value="<%=initBack[0][21].trim()%>">
                  </td>
                </tr>
                <tr style="display:none">
                  <td nowrap width="15%" class="blue">
                    <div align="left">担保人备注信息</div>
                  </td>
                  <td nowrap colspan="3">
                    <input name=assuNote0 class="button"  value="<%=initBack[0][22].trim()%>">
                  </td>
                </tr>
                
                <tr style="display:none" id="simTypeOneShowHide">
									<td class="blue">SIM卡类型</td>
									<td colspan="3">
										<select name="simTypeOne" >
											<option value="1" selected>TD固话SIM卡</option>	
											<option value="0">非TD固话的SIM卡</option>
										</select>	
									</td>
								</tr>
                
                <tr>
                  <td nowrap width="13%" class="blue">
                    <div align="left">旧卡SIM卡号</div>
                  </td>
                  <td nowrap width="35%">
                    <div align="left"><%=initBack[0][9].trim()%></div>
                  </td>
                  <td nowrap width="10%" class="blue">
                    <div align="left">旧卡状态</div>
                  </td>
                  <td nowrap width="35%" colspan="3">

					 <div align="left">
                      <select name="s_oldStatus" index="7">
                        <%
					  for(int i=0;i<simStatusStr.length;i++)
					  {
						  if(i==0)
						  {
					  %>
                        <option value="<%=simStatusStr[i][0].trim()%>" selected><%=simStatusStr[i][1].trim()%></option>
                        <%
						  }
						  else
						  {
					   %>
                        <option value="<%=simStatusStr[i][0].trim()%>"><%=simStatusStr[i][1].trim()%></option>
                        <%
						  }
					  }
					  %>
                      </select>
                      <font color="red">*</font></div>
                  </td>
                </tr>
                <tr>
                  <td nowrap width="18%" class="blue">
                    <div align="left">新卡SIM卡号</div>
                  </td>
                  <td nowrap width="35%">
                    <div align="left">
                      <input class="button" type="text" name="t_newsimf" id="t_newsimf" size="20" v_minlength=1 v_maxlength=100  v_type=string v_name="新卡SIM卡号" maxlength="20" value="<%=existPhoneNo%>" index="8" onkeyup="if(event.keyCode==13)chkSim((document.all.srv_no.value).trim(),(document.all.simOldNo.value).trim(),(document.all.t_newsimf.value).trim())">
                      <font color="red">*</font>
                      <input  class="b_text" type="button" name="b_tr_normal" value="验证"  onClick="chkSim((document.all.srv_no.value).trim(),(document.all.simOldNo.value).trim(),(document.all.t_newsimf.value).trim())">
                       <input class="b_text" type="button" name="b_write" value="写卡" onmouseup="writechg()" onkeyup="if(event.keyCode==13)writechg()" disabled index="19">
                      <input type="hidden" name="flg_normal" id="flg_normal" value="0">
                    </div>
                  </td>
				  <td nowrap width="19%" colspan="4"> <input type="radio" name="cardtype" value="N" checked onclick="chgcardtype()" index="-4">
                    实卡
                    <input type="radio" name="cardtype"   value="Y" onclick="chgcardtype()" index="-3">
                    空卡</td>

				  </tr>
				  <tr>
                  <td nowrap width="15%" class="blue">
                    <div align="left">SIM卡费</div>
                  </td>
                  <td nowrap width="19%">
                    <div align="left">

                      <input class="button" type="text" name="t_simFeef" id="t_simFeef" size="10" v_minlength=1 v_maxlength=10  v_type=float  v_name="SIM卡费"  maxlength="10" onblur="ChkSimFee()" <%=sim%> index="9"  >



                      <font color="red">*</font></div>
				 </td>
 					<td nowrap width="15%" class="blue">SIM卡类型</td>
				 <td colspan="3">
				 	<input class="button" type="text" name="simType" size="20" index="9" readonly="ture"></td>
                  </td>
                </tr>
          <tr>
            <td nowrap width="16%" class="blue">
              <div align="left">手续费</div>
            </td>
            <td nowrap width="24%">
              <div align="left">
                <input type="text" class="button" name="t_handFee" id="t_handFee" size="16"
	value="<%=(oriHandFee.trim().equals(""))?("0"):(oriHandFee.trim()) %>" v_type=float v_name="手续费" <%if(hfrf){%>readonly<%}%> onblur="ChkHandFee()" index="10">
              </div>
            </td>
            <td nowrap width="10%" class="blue">
              <div align="left">实收</div>
            </td>
            <td nowrap width="16%">
              <div align="left">
                <input type="text" class="button" name="t_factFee" id="t_factFee" size="16" onKeyUp="getFew()" index="11" v_type=float v_name="实收" <%
	                             if(hfrf)
	                             {
							   %>
								   readonly
							  <%
								 }
							   %>
							   >
              </div>
            </td>
            <td nowrap width="10%" class="blue">
              <div align="left">找零</div>
            </td>
            <td nowrap width="24%">
              <div align="left">
                <input type="text" class="button" name="t_fewFee" id="t_fewFee" size="16" readonly>
              </div>
            </td>
          </tr>
          <tr>
            <td nowrap width="16%" class="blue">
              <div align="left">系统备注</div>
            </td>
            <td nowrap colspan="2">
              <div align="left">
                <input type="text" class="button" name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30 />
              </div>
            </td>
            <%if(istestNum&&opCode.equals("m280")){%>
	    		<td class="blue">OA编号</td>
	        	<td nowrap colspan="2">
		        	<input class="button"type="text" id="oaNum" name="oaNum" size="17" maxlength="30">
		        	<font color="orange">*</font>
	        	</td>
	    	<%}else{%>
	        	<td nowrap colspan="3"></td>
	    	<%}%>
          </tr>
          <tr style="display:none">
            <td nowrap width="16%" class="blue">
              <div align="left">用户备注</div>
            </td>
            <td nowrap colspan="5">
              <div align="left">
                <input type="text" class="button" name="t_op_remark" id="t_op_remark" size="60"  v_maxlength=60  v_type=string  v_name="用户备注" maxlength=60 >
              </div>
            </td>
          </tr>
          <tr style="display:none">
            <td nowrap width="16%" class="blue">用户备注</td>
            <td nowrap colspan="5">
              <input name=assuNote class="button" v_must=0 v_maxlength=60 v_type="string" v_name="用户备注" maxlength="60" size=60 index="12" value="">
            </td>
          </tr>
        </table>
        <jsp:include page="/npage/public/hwReadCustCard.jsp">
					<jsp:param name="hwAccept" value="<%=initBack[0][28]%>"  />
					<jsp:param name="showBody" value="11"  />
					<jsp:param name="sopcode" value="<%=opCode%>"  />
				</jsp:include>
      	<table>
          <tr>
            <td nowrap colspan="6" id = "footer">
              <div align="center">
                <input class="b_foot" type="button" name="b_print" value="确认&打印" onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()"  index="13" disabled />
                <input class="b_foot" type="button" name="b_clear" value="清除" onClick="frm.reset();" index="14">
                <input class="b_foot" type="button" name="b_back" value="关闭" onClick="parent.removeTab(<%=opCode%>)" index="15">
              </div>
            </td>
          </tr>
        </table>
			<%@ include file="/npage/include/footer.jsp" %>
			<input type=hidden name="ipAdd" value="<%=request.getRemoteAddr()%>">
			 <input type="hidden" name="isSendListFlag" id="isSendListFlag" value="N" />
			 <input type="hidden" name="isQryListResultFlag" id="isQryListResultFlag" value="N" />
			 <input type="hidden" name="sendListOpenFlag" id="sendListOpenFlag" value="<%=sendListOpenFlag%>" />
			 <input type="hidden" name="loginacceptJT" id="loginacceptJT" />
   </form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>
<script type="text/javascript" language="JavaScript">
var v_printAccept = "<%=initBack[0][28].trim()%>";
	function Idcard_realUser(flag){
		//读取二代身份证
		//document.all.card_flag.value ="2";
		
		var picName = getCuTime();
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
		var tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//取得系统目录盘符
		var cre_dir = filep1+":\\custID";//创建目录
		//判断文件夹是否存在，不存在则创建目录
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);  
		}
		var picpath_n = cre_dir +"\\"+picName+"_"+ document.all.cus_id.value +".jpg";
		
		var result;
		var result2;
		var result3;

		result=IdrControl1.InitComm("1001");
		if (result==1)
		{
			result2=IdrControl1.Authenticate();
			if ( result2>0)
			{              
				result3=IdrControl1.ReadBaseMsgP(picpath_n); 
				if (result3>0)           
				{     
			  var name = IdrControl1.GetName();
				var code =  IdrControl1.GetCode();
			  	document.all.hqdcustname.value =name;//姓名
					document.all.hqdcusticcid.value =code;//身份证号
					$("#loginacceptJT").val(""); //集团流水
				}
				else
				{
					rdShowMessageDialog(result3); 
					IdrControl1.CloseComm();
				}
			}
			else
			{
				IdrControl1.CloseComm();
				rdShowMessageDialog("请重新将卡片放到读卡器上");
			}
		}
		else
		{
			IdrControl1.CloseComm();
			rdShowMessageDialog("端口初始化不成功",0);
		}
		IdrControl1.CloseComm();
	}
	
		function Idcard2(str){
			//扫描二代身份证
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
		tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//取得系统目录盘符
		var cre_dir = filep1+":\\custID";//创建目录
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
		var ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1000);
		if(ret_open!=0){
			ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1001);
		}	
		var cardType ="11";
		if(ret_open==0){
				//多功能设备RFID读取
				var ret_getImageMsg=CardReader_CMCC.MutiIdCardGetImageMsg(cardType,"c:\\custID\\cert_head_"+v_printAccept+str+".jpg");
				if(ret_getImageMsg==0){
					//二代证正反面合成
					var xm =CardReader_CMCC.MutiIdCardName;					
					var xb =CardReader_CMCC.MutiIdCardSex;
					var mz =CardReader_CMCC.MutiIdCardPeople;
					var cs =CardReader_CMCC.MutiIdCardBirthday;
					var yx =CardReader_CMCC.MutiIdCardSigndate+"-"+CardReader_CMCC.MutiIdCardValidterm;
					var yxqx = CardReader_CMCC.MutiIdCardValidterm;//证件有效期
					var zz =CardReader_CMCC.MutiIdCardAddress; //住址
					var qfjg =CardReader_CMCC.MutiIdCardOrgans; //签发机关
					var zjhm =CardReader_CMCC.MutiIdCardNumber; //证件号码
					var base64 =CardReader_CMCC.MutiIdCardPhoto;
					var v_validDates = "";

			    	document.all.hqdcustname.value =xm;//姓名
						document.all.hqdcusticcid.value =zjhm;//身份证号
						$("#loginacceptJT").val(""); //集团流水
	
				}else{
						rdShowMessageDialog("获取信息失败");
						return ;
				}
		}else{
						rdShowMessageDialog("打开设备失败");
						return ;
		}
		//关闭设备
		var ret_close=CardReader_CMCC.MutiIdCardCloseDevice();
		if(ret_close!=0){
			rdShowMessageDialog("关闭设备失败");
			return ;
		}
		
	}
	  function getCuTime(){
	 var curr_time = new Date(); 
	 with(curr_time) 
	 { 
	 var strDate = getYear()+"-"; 
	 strDate +=getMonth()+1+"-"; 
	 strDate +=getDate()+" "; //取当前日期，后加中文“日”字标识 
	 strDate +=getHours()+"-"; //取当前小时 
	 strDate +=getMinutes()+"-"; //取当前分钟 
	 strDate +=getSeconds(); //取当前秒数 
	 return strDate; //结果输出 
	 } 
	}
</script>