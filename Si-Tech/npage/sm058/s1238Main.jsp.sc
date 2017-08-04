<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-09 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml">
	<%@ page contentType="text/html; charset=GBK" %>
	<%@ include file="/npage/include/public_title_name.jsp" %>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%
	
	String dateStart="20150901";     
	String dateEnd="20151130";    
	String nowDate =new SimpleDateFormat("yyyyMMdd").format(new java.util.Date()).toString();
	
	boolean ifCanShow = false;
	
	if(!"".equals(nowDate)){
		if(Integer.parseInt(nowDate) >= Integer.parseInt(dateStart) && Integer.parseInt(nowDate) <= Integer.parseInt(dateEnd)){
			ifCanShow = true;
		}
	}

		String opCode = "m058";
		String opName = "实名登记";

		String op_code = "m058";
		
		request.setCharacterEncoding("GBK");
		String work_no = (String)session.getAttribute("workNo");
		String loginName = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String regionCode = org_code.substring(0,2);
		String groupId =(String)session.getAttribute("groupId");
		String loginPwd    = (String)session.getAttribute("password");
		String notestr=work_no+"进行手机号码和营业厅相关校验";
		String accountType =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");//1 为营业工号 2 为客服工号
	
		String[][] temfavStr=(String[][])session.getAttribute("favInfo");
		String[] favStr=new String[temfavStr.length];
		for(int i=0;i<favStr.length;i++)
		favStr[i]=temfavStr[i][0].trim();
		boolean hfrf=false;
		
		/* begin add 并老户优惠权限 for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/11 */
    boolean oldFav_a971 = false;
    if (WtcUtil.haveStr(favStr, "a971")) {
    	oldFav_a971 = true;
    }
 		/* end add 并老户优惠权限 for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/11 */


 	    //---------------根据提交页面决定处理流程-----------------------------
		String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
		/*获取输入的服务号码*/
		String phone_no = WtcUtil.repNull(request.getParameter("srv_no"));
		/*2016/2/26 10:18:01 gaopeng */
		String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
		/*2016/6/28 10:12:44  关于哈尔滨分公司申请批量更正客户信息以及进行系统优化的请示 
			接收真实的opcode
		*/
		String realOpCode=WtcUtil.repNull(request.getParameter("realOpCode")) == "" ?"m058":request.getParameter("realOpCode");
		String returnPage = "/npage/sm058/s1238Login.jsp";
		if("m389".equals(realOpCode)){
			returnPage = "/npage/sm389/fm389Main.jsp";
		}
		
		String kdNo = "";
		boolean isKd = false;
		String ifKdNo = "";
		%>
		
		<wtc:service  name="sGetBroadPhone"  routerKey="region" routerValue="<%=regionCode%>" 
		 outnum="2"  retcode="errCodeGetPhone" retmsg="errMsgGetPhone">
			<wtc:param  value="0"/>
			<wtc:param  value="01"/>
			<wtc:param  value=""/>
			<wtc:param  value="<%=work_no%>"/>
			<wtc:param  value=""/>
			<wtc:param  value=""/>
			<wtc:param  value=""/>
			<wtc:param  value="<%=srv_no%>"/>
	  </wtc:service>
  	<wtc:array id="list" scope="end"/>
	<%
			if("000000".equals(errCodeGetPhone) && list.length >0){
					/*获得第二个出参 代表宽带账号 如输入209号码 则返回ttkdXXX*/
					
					ifKdNo = list[0][1];
					System.out.println("==gaopengSeeLogM058= ifKdNo ===" + ifKdNo);
					/*如果宽带号码返回了 证明输入的是 宽带号码 */
					if(!"".equals(ifKdNo) && ifKdNo != null){
						System.out.println("==gaopengSeeLogM058= 1111 =22222==");
						isKd= true;
						/*赋值宽带号码*/
						kdNo = ifKdNo;
						srv_no = srv_no;
						phone_no = phone_no;
					}else{
						isKd= true;
						System.out.println("==gaopengSeeLogM058= isKd ===" + isKd);
						/*是宽带账号 则赋值宽带账号信息用于打印免填单*/
						kdNo = srv_no;
						System.out.println("==gaopengSeeLogM058= kdNo ===" + kdNo);
						System.out.println("==gaopengSeeLogM058= list[0][0] ===" + list[0][0]);
							/*用手机号替换当前宽带账号用于服务传值*/
							srv_no = list[0][0];
							phone_no = list[0][0];
					
				}
			}
	
	%>
	<%
		if(srv_no.equals(""))
		{
		response.sendRedirect(returnPage+"?ReqPageName=s1238Main&retMsg=1");
		}
		/* add for 是否为社会渠道工号 1：是 @2014/11/19  */
		String workChnFlag = "0" ;
		
		/*2015/9/7 13:53:52 gaopeng 关于开发新入网客户赠送彩铃、铃音盒及和阅读精品畅读包免费体验的函
    	新增服务查询是否提示内容
    */
    String backCode= "";
    String backInfo = "";
%>	
		
	<wtc:service name="sTSInfoBack" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_sTSInfoBack" retmsg="retMessage_sTSInfoBack" outnum="1"> 
    <wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=loginPwd%>"/>
		<wtc:param value="<%=phone_no%>"/>
	  <wtc:param value=""/>
	  <wtc:param value=""/>
  </wtc:service>  
  <wtc:array id="result_sTSInfoBack"  scope="end"/>
  	
		<wtc:service name="s1100Check" outnum="30"
			routerKey="region" routerValue="<%=regionCode%>" retcode="rc" retmsg="rm" >
			<wtc:param value = ""/>
			<wtc:param value = "01"/>
			<wtc:param value = "<%=opCode%>"/>
			<wtc:param value = "<%=work_no%>"/>
			<wtc:param value = "<%=loginPwd%>"/>
				
			<wtc:param value = ""/>
			<wtc:param value = ""/>
		</wtc:service>
		<wtc:array id="rst" scope="end" />
			<%
	backCode = retCode_sTSInfoBack;
	
	backInfo = retMessage_sTSInfoBack;
	System.out.println("gaopengSeeLogM058=====backCode==="+backCode);
	System.out.println("gaopengSeeLogM058=====backInfo==="+backInfo);

%>
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
    /*关于落实打击黑卡工作的BOSS优化补充需求地市配置表start*/
    String sql_appregionset1 = "select count(*) from sOrderCheck where group_id=:groupids and flag='Y' ";
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
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1"> 
			<wtc:param value="<%=sql_regionCodeFlag[0]%>"/>
			<wtc:param value="<%=sql_regionCodeFlag[1]%>"/>
		</wtc:service>  
		<wtc:array id="ret2"  scope="end"/>
<%
		if("000000".equals(retCode2)){
			if(ret2.length > 0){
				if(Integer.parseInt(ret2[0][0]) > 0){
					regionCodeFlag = "Y"; 
				}
			}
		}
%>			
		<wtc:service name="s1238Init" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCodecheck" retmsg="retMsgcheck" outnum="30" >
			<wtc:param value=" "/>
			<wtc:param value="01"/>
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=work_no%>"/>	
			<wtc:param value="<%=loginPwd%>"/>		
			<wtc:param value="<%=srv_no%>"/>	
			<wtc:param value=" "/>
			<wtc:param value="<%=notestr%>"/>
		</wtc:service>
		<wtc:array id="scheckphones" scope="end"/>
<%

    if(!"000000".equals(retCodecheck)){
%>
      <script language=javascript>
        rdShowMessageDialog('错误代码：<%=retCodecheck%><br>错误信息：<%=retMsgcheck%>');
        location='<%=returnPage%>?activePhone=<%=phone_no%>';
      </script>
<%
      return;
    }
		String  isshehuiworkno="no";	
		String  checkworknoflag [] = new String[2];
						checkworknoflag[0]="	select c.group_id from schnclassinfo a,schnclassmsg b ,dchngroupmsg c,dloginmsg d "
															+" where a.parent_class_code='7' "
															+" and a.class_code=b.class_code  "
															+" and a.class_code=c.class_code  "
															+" and c.group_id = d.group_id    "
															+" and d.login_no=:loginnos ";
					  checkworknoflag[1]= "loginnos="+work_no;		
%>
  <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCodworkno" retmsg="retMsworkno" outnum="1"> 
    <wtc:param value="<%=checkworknoflag[0]%>"/>
    <wtc:param value="<%=checkworknoflag[1]%>"/> 
  </wtc:service>  
  <wtc:array id="worknoflags"  scope="end"/>						 
<%	

if(worknoflags.length>0)	{
	isshehuiworkno="yes";
}	
System.out.println("-----m058---shehuiwork--"+isshehuiworkno);			 						
		
  /*** begin diling add for 如果用户有“NFC手机钱包业务”不允许办理实名登记业务 @2013/1/6  ***/
  String  inParams_NFC [] = new String[2];
  inParams_NFC[0]="select count(*) "
                  +" from DDSMPORDERMSG "
                  +" where PHONE_NO like :phoneno || '%' "
                  +" and serv_code = '73' "
                  +" and valid_flag = '1' "
                  +" and OPR_CODE <> '07' "
                  +" and sysdate between eff_time and end_time";
  inParams_NFC[1] = "phoneno="+srv_no;
%>
  <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode_NFC" retmsg="retMsg_NFC" outnum="1"> 
    <wtc:param value="<%=inParams_NFC[0]%>"/>
    <wtc:param value="<%=inParams_NFC[1]%>"/> 
  </wtc:service>  
  <wtc:array id="NFCArr"  scope="end"/>
<%
  if("000000".equals(retCode_NFC)){
    if(NFCArr.length>0){
      if(Integer.parseInt(NFCArr[0][0])>0){
%>

<% 
      }
    }
  }
  /*** end diling add @2013/1/6 ***/
		String  inParams [] = new String[2];
		/* diling update for 申告：1238实名登记没有限制已经结束的亲情通用户时间 @2012/10/12 
		inParams[0]="select count(*) from dRelaBaseMsg where id_no in (select id_no from dcustmsg where phone_no = :phoneNo)";
    */
    inParams[0]="select count(*) from dRelaBaseMsg where id_no in (select id_no from dcustmsg where phone_no = :phoneNo) and to_date(endtime,'yyyy/MM/dd HH24:MI:ss')>sysdate";
    inParams[1] = "phoneNo="+srv_no;
%>
    <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode_" retmsg="retMsg_" outnum="1"> 
      <wtc:param value="<%=inParams[0]%>"/>
      <wtc:param value="<%=inParams[1]%>"/> 
    </wtc:service>  
    <wtc:array id="str_sql"  scope="end"/>
<%
		if("000000".equals(retCode_))
		{
			if(str_sql!=null && str_sql.length>0)
			{
				if(!(str_sql[0][0]).equals("0"))
				{
				
				}
			}
		}
		String sqls="SELECT id_Name FROM sIdType order by id_type";
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
	 <wtc:sql><%=sqls%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="metaData" scope="end"/>
<%
		 String loginAccept = WtcUtil.repNull(request.getParameter("accept"));
		 boolean printFlag = true;
		 boolean is_Z_flag = true;//记录是否从模糊验证跳转过来的
		 if ("".equals(loginAccept)){
%>
				<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone"  routerValue="<%=srv_no%>" id="sLoginAccept"/>
<%
				loginAccept = sLoginAccept;
				printFlag = false;
				is_Z_flag = false;
		}
		
		/*
		String if24MonthText = "是否限制24个月不允许办理实名登记和过户";
		String if23Options = "<option value=''>--请选择--</option>"
                        +"<option value='1'>是</option>"
                        +"<option value='0'>否</option>";
                        */
    String if24MonthText = "手机号码实名登记和过户限制";
		String if23Options = "<option value=''>--请选择--</option>"
                        +"<option value='Y'>不限制过户和实名登记</option>"
                        +"<option value='K'>24个月不能过户和实名登记</option>"
                        +"<option value='N'>不能过户和实名登记(时间为2050年)</option>";
		/*如果从g551也就是模糊验证进入m058则依然是 是否限制24个月不允许办理实名登记和过户 
			否则如果单独办理 M058 并且不是宽带号码 则展示的是 手机号码实名登记和过户限制
		*/
		/*
		if(!is_Z_flag && !isKd){
			if24MonthText = "手机号码实名登记和过户限制";
			if23Options = "<option value=''>--请选择--</option>"
                        +"<option value='2'>不限制过户和实名登记</option>"
                        +"<option value='3'>24个月不能过户和实名登记</option>"
                        +"<option value='4'>不能过户和实名登记(时间为2050年)</option>";
		}*/
		
		//S1210Impl im=new S1210Impl();
		//ArrayList custDoc=im.sPubUsrBaseInfo(srv_no,op_code,"phone",srv_no,work_no);
%>
		<wtc:service name="sPubUsrBaseInfo" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode1" retmsg="retMsg1" outnum="30" >
			<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=work_no%>"/>	
		<wtc:param value="<%=loginPwd%>"/>		
		<wtc:param value="<%=srv_no%>"/>	
		<wtc:param value=" "/>
		</wtc:service>
		<wtc:array id="sPubUsrBaseInfoArr" scope="end"/>
<%

    System.out.println("---m058-------retCode1="+retCode1);
    if(!"000000".equals(retCode1)){
%>
      <script language=javascript>
        rdShowMessageDialog('错误代码：<%=retCode1%><br>错误信息：<%=retMsg1%>');
        location='<%=returnPage%>?activePhone=<%=phone_no%>';
      </script>
<%
      return;
    }
		ArrayList baseInfoList = new ArrayList();
		if(sPubUsrBaseInfoArr!=null&&sPubUsrBaseInfoArr.length>0&&retCode1.equals("000000")){
			for(int i=0;i<sPubUsrBaseInfoArr.length;i++){
				for(int j=0;j<sPubUsrBaseInfoArr[i].length;j++){
					baseInfoList.add(sPubUsrBaseInfoArr[i][j]);
					System.out.println("sPubUsrBaseInfoArr["+i+"]["+j+"]="+sPubUsrBaseInfoArr[i][j]);
				}
			}
		}else{
		  response.sendRedirect(returnPage+"?ReqPageName=s1238Main&retMsg=2&activePhone="+phone_no);
		}
		String userRegionCode = ((String)baseInfoList.get(2)).length()>=2?((String)baseInfoList.get(2)).substring(0,2):"";
		String handFeeSqlStr = "select hand_fee ,trim(favour_code) from snewFunctionFee where region_code='"+userRegionCode+"' and function_code='"+opCode+"'";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
    <wtc:sql><%=handFeeSqlStr%>
    </wtc:sql>
		</wtc:pubselect>
		<wtc:array id="handFeeSqlArr" scope="end"/>
<%
		if(handFeeSqlArr!=null&&handFeeSqlArr.length>0){
			for(int i=0;i<handFeeSqlArr[0].length;i++){
				baseInfoList.add(handFeeSqlArr[0][i]);
			}
		}else{
				baseInfoList.add("");
				baseInfoList.add("");
		}

		//服务返回参数可能不规范,比如返回四位等等.所以这样转化下,避免因为服务参数不规范带来的错误
		int returnCode = retCode1==""?999999:Integer.parseInt(retCode1);
		String returnMsg = retMsg1;
		baseInfoList.add(String.valueOf(returnCode));
		baseInfoList.add(returnMsg);

		//在这里进行链表转换一下
		ArrayList custDoc = baseInfoList;
		if(custDoc.size()<34){ //如果长度不够34,就表明出错了
				response.sendRedirect(returnPage+"?ReqPageName=s1238Main&retMsg=9");
		}

		/***用户品牌***/
		String sNewSmName = ((String)custDoc.get(3))==null?"":(String)custDoc.get(3);

		///////////
		//  孙振兴添加 AT 20061011
		////////////////////////////////
		String mode_name="" ;
		String good_flag="0" ;
		//lichaoa modify 20120824 关于绥化分公司增加特殊号码办理限制的请示
		//String sql = "select count(*) from dgoodphoneres a,sbillmodedes b,dCustMsg c where c.phone_no = '"+srv_no+"' and  a.bill_code=b.mode_code and substr(c.belong_code,1,2)=b.region_code and a.phone_no=c.phone_no and (good_type like '1%' or good_type like '2%') group by mode_name";
		String sql = "select count(*) from dgoodphoneres a where a.phone_no = '"+srv_no+"' ";
		System.out.println("sql="+sql);
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
    <wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="agentCodeStr" scope="end"/>
<%
		if(agentCodeStr ==null||agentCodeStr.length==0){
			System.out.println("非特殊号码");
		}else{
			good_flag = agentCodeStr[0][0];
			if(!agentCodeStr[0][0].equals("0")) {
				sql = "select count(*) from shighlogin where login_no='" +work_no+"' and op_code='m058'";
%>
				<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
		    <wtc:sql><%=sql%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="agentCodeStr" scope="end"/>
<%
				if(agentCodeStr[0][0].equals("0")) {
					
				}
			}
		}
		/**
		sql = "select d.mode_dxpay from dbillcustdetail a,dgoodphoneres b,dcustmsg c,sgoodbillcfg d "+
				" where a.MODE_CODE=b.bill_code and a.mode_time='Y' and a.end_time>sysdate "+
				" and a.id_no=c.id_no and b.phone_no=c.phone_no and b.bill_code=d.mode_code "+
				" and a.REGION_CODE=d.region_code and c.phone_no='"+srv_no+"'";
		**/
		sql = "SELECT d.mode_dxpay FROM product_offer_instance a, dgoodphoneres b, dcustmsg c, sgoodbillcfg d "+
				"WHERE to_char(a.offer_id) = trim(b.bill_code) AND a.exp_date > SYSDATE"+
				"AND a.serv_id = c.id_no AND b.phone_no = c.phone_no"+
				"AND b.bill_code = d.mode_code AND c.phone_no = '"+srv_no+"'";
		String goodFlagNew="0";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
   		 <wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="agentCodeStr" scope="end"/>
<%
		if(agentCodeStr ==null||agentCodeStr.length==0){
			System.out.println("222非特殊号码");
		}else{
			mode_name = agentCodeStr[0][0];
			goodFlagNew = "1";
		}

		System.out.println("mode_name="+mode_name);
		System.out.println("good_flag="+good_flag);

		String HasPostBill = "";

		//邮寄帐单修改20070327
		sql = "select count(*) from dCustPostPrtBill a,dcustmsg b where a.id_no = b.id_no and a.tran_type = '1' and a.post_type = '1' and b.phone_no = '"+srv_no+"'";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
    <wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="agentCodeStr" scope="end"/>
<%
		boolean hasPostBill = false;
		if(!agentCodeStr[0][0].equals("0"))
				HasPostBill = "Y";
		 else
		 		HasPostBill = "N"	;

		System.out.println("HasPostBill"+HasPostBill);
		System.out.println("agentCodeStr1="+agentCodeStr[0][0]);


		String HasEmailBill = "";
		//电子帐单修改20070327
		sql = "select count(*) from dCustPostPrtBill a,dcustmsg b where a.id_no = b.id_no and a.tran_type = '1' and a.post_type = '2' and b.phone_no = '"+srv_no+"'";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
    <wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="agentCodeStr" scope="end"/>
<%
		boolean hasEmailBill = false;
		if(!agentCodeStr[0][0].equals("0"))
			HasEmailBill = "Y";
		else
			HasEmailBill = "N";
	  System.out.println("sql"+sql);
		System.out.println("HasEmailBill"+HasEmailBill);
		System.out.println("------------------------------------1"+custDoc.get(2));
		//孙振兴添加完毕

		/**

			ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
		  String[][] allNewSmInfo=(String[][])arrSession.get(5);
      String sNewSmName=Pub_lxd.getNewSm(org_code.substring(0,2),(String)custDoc.get(3),allNewSmInfo,"1");
    **/








	
		
		
		
		
		
		
		
		
		if(Double.parseDouble(((String)custDoc.get(19)))>Double.parseDouble(((String)custDoc.get(20))))
    {
        response.sendRedirect(returnPage+"?ReqPageName=s1238Main&retMsg=100&oweAccount="+new String(((String)custDoc.get(21)).getBytes("GBK"),"ISO8859_1")+"&oweFee="+((String)custDoc.get(22)));
    }

 		if(((String)custDoc.get(30)).trim().equals("") || ((String)custDoc.get(30)).trim().equals("0") || Double.parseDouble(((String)(custDoc.get(30))))==0)
		{
 			hfrf=true;
		}else{
      if(!WtcUtil.haveStr(favStr,((String)custDoc.get(31)).trim())){
 				hfrf=true;
		  }
		}

		if(Integer.parseInt(((String)custDoc.get(32)).trim())!=0)
		{
		  if(Integer.parseInt(((String)custDoc.get(32)).trim())==1007 || Integer.parseInt(((String)custDoc.get(32)).trim())==1008)
		  {
          //response.sendRedirect(returnPage+"?ReqPageName=s1238Main&retMsg=100&oweAccount="+new String(((String)custDoc.get(21)).getBytes("GBK"),"ISO8859_1")+"&oweFee="+((String)custDoc.get(22)));
		  }
		  else
		  {
          response.sendRedirect(returnPage+"?ReqPageName=s1238Main&retMsg=101&errCode="+((String)custDoc.get(32)).trim()+"&errMsg="+new String(((String)custDoc.get(33)).trim().getBytes("GBK"),"ISO8859_1"));
		  }
		}
		
		for( int i = 0 ; i <custDoc.size(); i ++  )
		{
			System.out.println("custDoc ["+i+"]==>"+custDoc.get(i));
		}
		
 	 %>
 	 <%
 	 /*****************liucm*****************/
 	 String main_str1="";
	 String fj_str1="";
	 String main_note="";
	 String mode_code="";
	 String detail_code="";
 	 String OldId=(String)custDoc.get(0);
 	 /*
 	 String sqlStrk ="select '('||a.mode_code||' '||trim(b.mode_name)||')',a.mode_code  from dbillcustdetail a,sbillmodecode b where id_no=to_number('"+OldId+"')"+
	" and a.mode_flag='0' 	and a.mode_time='	Y' and a.mode_status='Y' and a.mode_code=b.mode_code "+
	" and a.region_code=b.region_code";
	  */
	 String sqlStrk = "SELECT '('||a.offer_id||' '||trim(b.offer_name)||')',a.offer_id FROM product_offer_instance a, product_offer b "+
	 				  "WHERE a.offer_id = b.offer_id and SYSDATE BETWEEN a.eff_date AND a.exp_date "+
	 				  "and b.offer_type = '10' and a.state = 'A' and a.serv_id = to_number('"+OldId+"')	";
%>

		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
    <wtc:sql><%=sqlStrk%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end"/>
<%
	if(result!=null&&result.length>0){
		main_str1 = result[0][0];
		mode_code = result[0][1];
	}	else{
				 String sqlStrk2 = "select '(' || a.structvalue || ' ' || trim(c.offer_name) || ')', a.structvalue from product_order_content a ,dservordermsg b,product_offer c "+
				 " where a.prodordid= b.serv_order_id"+
				 " and b.id_no= to_number('"+OldId+"')	"+
				 " and a.structid= 1055"+
				 " and to_number(a.structvalue)=c.offer_id"+
				 " and c.offer_type= 10";
				 System.out.println("yanpx mode_code = "+sqlStrk2);
				 %>
						<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
				    <wtc:sql><%=sqlStrk2%></wtc:sql>
						</wtc:pubselect>
						<wtc:array id="result2" scope="end"/>
				<%
				  System.out.println("yanpx  main_str1="+retCode);
					System.out.println("yanpx  main_str1="+result2.length);
				if(result2!=null&&result2.length>0){
					main_str1 = result2[0][0];
					mode_code = result2[0][1];
					System.out.println("yanpx  main_str1="+main_str1);
					System.out.println("yanpx  mode_code="+mode_code);
				}
		}
	
	/*
	sqlStrk ="select '('||a.mode_code||' '||trim(b.mode_name)||')'  from dbillcustdetail a,sbillmodecode b where id_no=to_number('"+OldId+"')"+
	" and a.mode_flag='2' 	and a.mode_time='Y' and a.mode_status='Y' and a.mode_code=b.mode_code "+
	" and a.region_code=b.region_code";
	*/
	sqlStrk = "SELECT '('||a.offer_id||' '||trim(b.offer_name)||')' FROM product_offer_instance a, product_offer b "+
	 				  "WHERE a.offer_id = b.offer_id and SYSDATE BETWEEN a.eff_date AND a.exp_date "+
	 				  "and b.offer_type = '40' and a.state = 'A' and a.serv_id = to_number('"+OldId+"')	";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
    <wtc:sql><%=sqlStrk%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end"/>
<%
	for(int i=0;i<result.length;i++){
		fj_str1=fj_str1+result[i][0]+"，";
	}

	System.out.println("fj_str1===="+fj_str1);

%>
<wtc:service name="s9611Cfm3" routerKey="regionCode" routerValue="<%=regionCode%>"  outnum="4" >
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="1"/>
    <wtc:param value="2"/>
    <wtc:param value="<%=groupId%>"/>
    <wtc:param value="<%=mode_code%>"/>
    <wtc:param value="10442"/>
    <wtc:param value="<%=regionCode%>"/>
    <wtc:param value=""/>
</wtc:service>
<wtc:array id="result" scope="end" />
<%
	main_note=result.length>0?result[0][0]:"";
	main_note = main_note.replaceAll("\"","");
	main_note = main_note.replaceAll("\'","");
	System.out.println("main_note="+main_note);
%>
<%
		/*****刘春梅20080715增加，查询用户的黑白名单信息********/
		String sqlB=" select to_char(count(*))	from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone and a.list_type='B'";
		String [] paraIn1 = new String[4];
		String liststr="";
		paraIn1[0] = "region";
		paraIn1[1] = regionCode;
		paraIn1[2] = sqlB;
		paraIn1[3] = "phone="+srv_no;
    //ArrayList offonArr = callViewn.callFXService("sPubSelectNew",paraIn1,"1");
%>
		<wtc:service name="sPubSelectNew" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
		<wtc:param value="<%=paraIn1[0]%>"/>
		<wtc:param value="<%=paraIn1[1]%>"/>
		<wtc:param value="<%=paraIn1[2]%>"/>
		<wtc:param value="<%=paraIn1[3]%>"/>
		</wtc:service>
		<wtc:array id="offnodataArray" scope="end"/>
<%
		String totalListNum = offnodataArray.length>0?offnodataArray[0][0]:"";
    if(!totalListNum.equals("0"))
    {
    	liststr="此客户在黑名单库中!";
    }else{
 			String sqloffon="select to_char(count(*)) from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone "
 				+" and op_Type='0' and op_code='0' and list_type='W' ";
  		System.out.println("sqloffon====="+sqloffon);
    	String [] paraIn2 = new String[4];
    	paraIn2[0] = "region";
    	paraIn2[1] = regionCode;
    	paraIn2[2] = sqloffon;
    	paraIn2[3] = "phone="+srv_no;
    	//offonArr = callViewn.callFXService("sPubSelectNew",paraIn2,"1");
%>
			<wtc:service name="sPubSelectNew" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
			<wtc:param value="<%=paraIn1[0]%>"/>
			<wtc:param value="<%=paraIn1[1]%>"/>
			<wtc:param value="<%=paraIn1[2]%>"/>
			<wtc:param value="<%=paraIn1[3]%>"/>
			</wtc:service>
			<wtc:array id="offnodataArray" scope="end"/>
<%
			totalListNum = offnodataArray.length>0?offnodataArray[0][0]:"";

    	if(totalListNum.equals("0"))
    	{
    		liststr="此客户不在白名单库中!";
    	}else{
    		liststr="此客户在白名单库中!";
    	}
    }
    int listlen=liststr.length();
    String attrcode=(String)custDoc.get(9);
 System.out.println("aaaaaaaaaaaaaaaaaaa="+attrcode);
 /**************liucm end **************/
%>

<!-- 20091201 fengry begin for 增加特殊号码实名登记限制 -->
<%
	String sys_Date=new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
	String sysDate_Good=sys_Date.substring(0,8);
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@sysDate_Good in s1238Main.jsp="+sysDate_Good);

	StringBuffer Goodsql = new StringBuffer();
		Goodsql.append(" select phone_no,to_char(to_date(total_date,'YYYY-MM-DD'),'YYYY-MM-DD')");
		Goodsql.append(" from dOpenGsmChk");
		Goodsql.append(" where phone_no= '"+srv_no+"' and id_no= to_number('"+custDoc.get(0)+"')");
		Goodsql.append(" AND to_char(total_date) - to_char(sysdate,'yyyymmdd') > 0");
	System.out.println("Goodsql==="+Goodsql);
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" retcode="GoodRetCode" retmsg="GoodRetMsg" outnum="2" >
<wtc:sql><%=Goodsql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="GoodStr" scope="end" />
<%
	System.out.println("@@@@@@@@@@GoodRetCode in s1238Main.jsp="+GoodRetCode+"/GoodRetMsg="+GoodRetMsg+"/GoodStr.length="+GoodStr.length);

	if(GoodStr.length > 0 && GoodStr != null)
	{
		if(GoodStr[0][1].substring(0,10).equals("2050-01-01"))
		{%>

<%
		}else{
%>

<%
		}
	}

	String sqlStrl0 ="SELECT count(*) FROM dChnGroupMsg a,dbChnAdn.sChnClassMsg b WHERE a.group_id='"+groupId+"' AND a.is_active='Y' AND a.class_code=b.class_code AND b.class_kind='2'";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCodel0" retmsg="retMsgl0" outnum="1">
	<wtc:sql><%=sqlStrl0%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultl0" scope="end" />
<%
	StringBuffer GoodPhoneYes = new StringBuffer();
	GoodPhoneYes.append(" select phone_no from dgoodphoneres ");
	GoodPhoneYes.append(" where phone_no = '"+srv_no+"'" );

	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@GoodPhoneYes in s1238Main.jsp="+GoodPhoneYes);
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" retcode="YesRetCode" retmsg="YesRetMsg" outnum="1" >
<wtc:sql><%=GoodPhoneYes%></wtc:sql>
</wtc:pubselect>
<wtc:array id="YesStr" scope="end" />
<%
	System.out.println("@@@@@@@@@@YesRetCode in s1238Main.jsp="+YesRetCode+"/YesRetMsg="+YesRetMsg+"/YesStr.length="+YesStr.length);

	int YesStrNum = YesStr.length;
	if(YesStrNum > 0)
	{
%>
			<script language=javascript>
				//rdShowMessageDialog("是特殊号码");
				//默认实名登记限制项可选可不选
			</script>
<%
	}else{
%>
			<script language=javascript>
				//rdShowMessageDialog("非特殊号码");
				//实名登记限制项隐藏
			</script>
<%
		}
%>
<!-- 20091201 end -->
<%
	String opNote = "用户"+srv_no+"进行了["+opName+"]操作";
	String qRealUserName = "";
  String qRealUserAddr = "";
  String qRealUserIdType = "";
  String qRealUserIccId = "";
  
  

%>
<wtc:service name="sm245Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_realUser" retmsg="retMsg_realUser" outnum="6"	>
	<wtc:param value = "<%=loginAccept%>"/>
	<wtc:param value = "01"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=work_no%>"/>
	<wtc:param value = "<%=loginPwd%>"/>
	<wtc:param value = "<%=srv_no%>"/>
	<wtc:param value = ""/>
	<wtc:param value = "<%=opNote%>"/>
</wtc:service>
<wtc:array id="ret_realUser" scope="end" />
<%

	if("000000".equals(retCode_realUser)){
		if(ret_realUser.length > 0){
			qRealUserIdType = ret_realUser[0][2];
		  qRealUserIccId = ret_realUser[0][3];
		  qRealUserName = ret_realUser[0][4];
		  qRealUserAddr = ret_realUser[0][5];
		}
	}
	
%>
		


	 <head>
 	 <title>实名登记</title>
	 <script language=javascript>
	 <%
	 	String highmsg=(String)custDoc.get(17);
		String ss="中高端用户";
		int spos=highmsg.indexOf(ss,0);
	%>
	if(<%=spos%>>=0){rdShowMessageDialog("该用户是中高端用户！");}
	if(<%=listlen%>>0){rdShowMessageDialog("<%=liststr%>");}
	   var blackFlag3=true;     //新建客户黑名单标志
	   var blackFlag=true;    //新已存在客户黑名单标志
	   var assuBlackFlag=true; //担保人黑名单标志
	   
	   var v_groupId = "<%=groupId%>";
		 var v_printAccept = "<%=loginAccept%>";
		 var v_workNo = "<%=work_no%>";
		 var phone_no = "<%=phone_no%>";

	   onload=function()
	   {
	   	 getIdTypes();
	 		 self.status="";
			 fillSelect();
			 chgCustType();

				//20091201 begin
				/* if(<%=YesStrNum%>>0) */		//市场部要求对所有号码增加实名登记限制项,而不是只针对特殊号码
				{
					//特殊号码,实名登记限制项不隐藏,默认可选可不选
					/*
					document.all.Good_PhoneDate_GSM.style.display = "";
					document.all.GoodPhoneFlag.value = "0";
					*/
				}
				//20091201 end
				setRealUserFormat();
	   }
	   
			//实际使用人证件类型改变
			function valiRealUserIdTypes(idtypeVal){
				if(idtypeVal == "0"){
					document.all.realUserIccId.v_type = "idcard";
					$("#scan_idCard_two2").css("display","");
					$("#scan_idCard_two22").css("display","");
					$("input[name='realUserName']").attr("class","InputGrey");
					$("input[name='realUserName']").attr("readonly","readonly");
					$("input[name='realUserAddr']").attr("class","InputGrey");
					$("input[name='realUserAddr']").attr("readonly","readonly");
					$("input[name='realUserIccId']").attr("class","InputGrey");
					$("input[name='realUserIccId']").attr("readonly","readonly");
					$("input[name='realUserName']").val("");
					$("input[name='realUserAddr']").val("");
					$("input[name='realUserIccId']").val("");
				}else{
					document.all.realUserIccId.v_type = "string";
					$("#scan_idCard_two2").css("display","none");
					$("#scan_idCard_two22").css("display","none");
					$("input[name='realUserName']").removeAttr("class");
					$("input[name='realUserName']").removeAttr("readonly");
					$("input[name='realUserAddr']").removeAttr("class");
					$("input[name='realUserAddr']").removeAttr("readonly");
					$("input[name='realUserIccId']").removeAttr("class");
					$("input[name='realUserIccId']").removeAttr("readonly");
				}
				if($("#realUserIdType").val() == "<%=qRealUserIdType%>"){ //选择初始证件类型，则还原初始证件信息
					$("#realUserName").val("<%=qRealUserName%>");
					$("#realUserAddr").val("<%=qRealUserAddr%>");
					$("#realUserIccId").val("<%=qRealUserIccId%>");
				}else{
					$("input[name='realUserName']").val("");
					$("input[name='realUserAddr']").val("");
					$("input[name='realUserIccId']").val("");
				}
			}




/*
	2013/11/15 15:33:56 gaopeng 关于进一步提升省级支撑系统实名登记功能的通知  
	注意：只针对个人客户 start
*/  

/*1、客户名称、联系人姓名 校验方法 objType 0 代表客户名称校验 1代表联系人姓名校验  ifConnect 代表是否联动赋值(点击确认按钮时，不进行联动赋值)*/
function checkCustNameFunc(obj,objType,ifConnect){
	var nextFlag = true;
	var objName = "";
	var idTypeVal ="";
		
	if(objType == 0){
		objName = "客户名称";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "联系人姓名";
		idTypeVal = document.all.idType.value;
	}
	/*2013/12/16 11:24:47 gaopeng 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人姓名*/
	if(objType == 2){
		objName = "经办人姓名";
		/*规则按照经办人证件类型*/
		idTypeVal = document.all.gestoresIdType.value;
	}
	
	if(objType == 3){
		objName = "责任人姓名";
		/*规则按照经办人证件类型*/
		idTypeVal = document.all.responsibleType.value;
	}	
	
	idTypeVal = $.trim(idTypeVal);
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		
		/*获取证件类型主键 */
		var idTypeText = idTypeVal.split("|")[0];
		
		/*客户名称、联系人姓名均要求“大于等于2个中文汉字”，外国公民护照除外（外国公民护照客户名称必须大于3个字符，不全为阿拉伯数字)*/
		
		/*如果不是外国公民护照*/
		if(idTypeText != "6"){
			/*原有的业务逻辑校验 只允许是英文、汉字、俄文、法文、日文、韩文其中一种语言！*/
			if(idTypeText == "3" || idTypeText == "9" || idTypeText == "8" || idTypeText == "A" || idTypeText == "B" || idTypeText == "C"){
				if(objValueLength < 2){
					rdShowMessageDialog(objName+"必须大于等于2个汉字！");
					nextFlag = false;
					return false;
				}
				var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//分别获取输入内容
            var key = checkNameStr(code); //校验
            if(key == undefined){
              rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
                obj.value = "";
              	nextFlag = false;
                return false;
            }	
       }
       else{
					/*获取含有中文汉字的个数以及'()（）'的个数*/
					var m = /^[\u0391-\uFFE5]*$/;
					var mm = /^·|\.|\．*$/;
					var chinaLength = 0;
					var kuohaoLength = 0;
					var zhongjiandianLength=0;
					for (var i = 0; i < objValue.length; i ++){
			          var code = objValue.charAt(i);//分别获取输入内容
			          var flag22=mm.test(code);
			          var flag = m.test(code);
			          /*先校验括号*/
			          if(forKuoHao(code)){
			          	kuohaoLength ++;
			          }else if(flag){
			          	chinaLength ++;
			          }else if(flag22){
			          	zhongjiandianLength++;
			          }
			    }
			    var machLength = chinaLength + kuohaoLength+zhongjiandianLength;
					/*括号的数量+汉字的数量 != 总数量时 提示错误信息(这里需要注意一点，中文括号也是中文。。。所以这里只进行英文括号的匹配个数，否则会匹配多个)*/
					if(objValueLength != machLength || chinaLength == 0){
						rdShowMessageDialog(objName+"必须输入中文或中文与括号的组合(括号可以为中文或英文括号“()（）”)！");
						/*赋值为空*/
						obj.value = "";
						
						nextFlag = false;
						return false;
					}else if(objValueLength == machLength && chinaLength != 0){
						if(objValueLength < 2){
							rdShowMessageDialog(objName+"必须大于等于2个中文汉字！");
							
							nextFlag = false;
							return false;
						}
					}
					/*原有逻辑
					if(idTypeText == "0" || idTypeText == "2"){
						if(objValueLength > 6){
							rdShowMessageDialog(objName+"最多输入6个汉字！");
							
							nextFlag = false;
							return false;
						}
				}
				*/
			}
       
		}
		/*如果是外国公民护照 校验 外国公民护照客户名称(后续添加了联系人姓名也同理(sunaj已确定))必须大于3个字符，不全为阿拉伯数字*/
		if(idTypeText == "6"){
			/*如果校验客户名称*/
				if(objValue % 2 == 0 || objValue % 2 == 1){
						rdShowMessageDialog(objName+"不能全为阿拉伯数字!");
						/*赋值为空*/
						obj.value = "";
						
						nextFlag = false;
						return false;
				}
				if(objValueLength <= 3){
						rdShowMessageDialog(objName+"必须大于三个字符!");
						
						nextFlag = false;
						return false;
				}
         var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//分别获取输入内容
            var key = checkNameStr(code); //校验
            if(key == undefined){
              rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
		}
		
		
		if(ifConnect == 0){
		
		if(nextFlag){
		 if(objType == 0){
		 	/*联系人姓名随客户名称改名而改变*/
			document.all.contactPerson.value = objValue;
			 
		 	}	
		}
			}
		
	}	
	return nextFlag;
}



/*
	2013/11/18 11:15:44
	gaopeng
	客户地址、证件地址、联系人地址校验方法
	“客户地址”、“证件地址”和“联系人地址”均需“大于等于8个中文汉字”
	（外国公民护照和台湾通行证除外，外国公民护照要求大于2个汉字，台湾通行证要求大于3个汉字）
*/

function checkAddrFunc(obj,objType,ifConnect){
	var nextFlag = true;
	var objName = "";
	var idTypeVal = "";
	if(objType == 0){
		objName = "证件地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "客户地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 2){
		objName = "联系人地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 3){
		objName = "联系人通讯地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 4){
		objName = "经办人联系地址";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 5){
		objName = "责任人联系地址";
		idTypeVal = document.all.responsibleType.value;
	}	
	idTypeVal = $.trim(idTypeVal);
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		
		/*获取证件类型主键 */
		var idTypeText = idTypeVal.split("|")[0];
		
		/*获取含有中文汉字的个数*/
		var m = /^[\u0391-\uFFE5]*$/;
		var chinaLength = 0;
		for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	chinaLength ++;
          }
    }
      
		/*如果既不是外国公民护照 也不是台湾通行证 */
		if(idTypeText != "6" && idTypeText != "5"){
			/*含有至少8个中文汉字*/
			if(chinaLength < 8){
				rdShowMessageDialog(objName+"必须含有至少8个中文汉字！");
				/*赋值为空*/
				obj.value = "";
				
				nextFlag = false;
				return false;
			}
		
	}
	/*外国公民护照 大于2个汉字*/
	if(idTypeText == "6"){
		/*大于2个中文汉字*/
			if(chinaLength <= 2){
				rdShowMessageDialog(objName+"必须含有大于2个中文汉字！");
				
				nextFlag = false;
				return false;
			}
	}
	/*台湾通行证 大于3个汉字*/
	if(idTypeText == "5"){
		/*含有至少3个文汉字*/
			if(chinaLength <= 3){
				rdShowMessageDialog(objName+"必须含有大于3个中文汉字！");
				
				nextFlag = false;
				return false;
			}
	}
	/*联动赋值 ifConnect 传0时才赋值，否则不赋值*/
	if(ifConnect == 0){
		if(nextFlag){
			/*证件地址改变时，赋值其他地址*/
			if(objType == 0){
			    document.all.custAddr.value=objValue;
			    document.all.contactAddr.value=objValue;
			    document.all.contactMAddr.value=objValue;
			}
			/*客户地址改变时，赋值联系人地址和联系人通讯地址*/
			if(objType == 1){
				document.all.contactAddr.value = objValue;
	  		document.all.contactMAddr.value = objValue;
			}
			/*联系人地址改变时，赋值联系人通讯地址，2013/12/16 15:20:17 20131216 gaopeng 赋值经办人联系地址联动*/
			if(objType == 2){
				document.all.contactMAddr.value=objValue;
				document.all.gestoresAddr.value=objValue;
				document.all.responsibleAddr.value=objValue;
			}
		}
	}
	
	
}
return nextFlag;
}

/*
	2013/11/18 14:01:09
	gaopeng
	证件类型变更时，证件号码的校验方法
*/

function checkIccIdFunc(obj,objType,ifConnect){
	var nextFlag = true;
	var idTypeVal = "";
	if(objType == 0){
		var objName = "证件号码";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "经办人证件号码";
		idTypeVal = document.all.gestoresIdType.value;
	}	
	if(objType == 2){
		objName = "责任人证件号码";
		idTypeVal = document.all.responsibleType.value;
	}	
	
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		
		/*获取证件类型主键 */
		var idTypeText = idTypeVal.split("|")[0];
		
		/*1、身份证及户口薄时，证件号码长度为18位*/
		if(idTypeText == "0" || idTypeText == "2"){
			if(objValueLength != 18){
					rdShowMessageDialog(objName+"必须是18位！");
					
					nextFlag = false;
					return false;
			}
		}
		/*军官证 警官证 外国公民护照时 证件号码大于等于6位字符*/
		if(idTypeText == "1" || idTypeText == "4" || idTypeText == "6"){
			if(objValueLength < 6){
					rdShowMessageDialog(objName+"必须大于等于六位字符！");
					
					nextFlag = false;
					return false;
			}
		}
		/*证件类型为港澳通行证的，证件号码为9位或11位，并且首位为英文字母“H”或“M”(只可以是大写)，其余位均为阿拉伯数字。*/
		if(idTypeText == "3"){
			if(objValueLength != 9 && objValueLength != 11){
					rdShowMessageDialog(objName+"必须是9位或11位！");
					
					nextFlag = false;
					return false;
			}
			/*获取首字母*/
			var valHead = objValue.substring(0,1);
			if(valHead != "H" && valHead != "M"){
					rdShowMessageDialog(objName+"首字母必须是‘H’或‘M’！");
					
					nextFlag = false;
					return false;
			}
			/*获取首字母之后的所有信息*/
			var varWithOutHead = objValue.substring(1,objValue.length);
			if(varWithOutHead % 2 != 0 && varWithOutHead % 2 != 1){
					rdShowMessageDialog(objName+"除首字母之外，其余位必须是阿拉伯数字！");
					
					nextFlag = false;
					return false;
			}
		}
		/*证件类型为
			台湾通行证 
			证件号码只能是8位或11位
			证件号码为11位时前10位为阿拉伯数字，
			最后一位为校验码(英文字母或阿拉伯数字）；
			证件号码为8位时，均为阿拉伯数字
		*/
		if(idTypeText == "5"){
			if(objValueLength != 8 && objValueLength != 11){
					rdShowMessageDialog(objName+"必须为8位或11位！");
					
					nextFlag = false;
					return false;
			}
			/*8位时，均为阿拉伯数字*/
			if(objValueLength == 8){
				if(objValue % 2 != 0 && objValue % 2 != 1){
					rdShowMessageDialog(objName+"必须为阿拉伯数字");
					
					nextFlag = false;
					return false;
				}
			}
			/*11位时，最后一位可以是英文字母或阿拉伯数字，前10位必须是阿拉伯数字*/
			if(objValueLength == 11){
				var objValue10 = objValue.substring(0,10);
				if(objValue10 % 2 != 0 && objValue10 % 2 != 1){
					rdShowMessageDialog(objName+"前十位必须为阿拉伯数字");
					
					nextFlag = false;
					return false;
				}
				var objValue11 = objValue.substring(10,11);
  			var m = /^[A-Za-z]+$/;
				var flag = m.test(objValue11);
				
				if(!flag && objValue11 % 2 != 0 && objValue11 % 2 != 1){
					rdShowMessageDialog(objName+"第11位必须为阿拉伯数字或英文字母！");
					
					nextFlag = false;
					return false;
				}
			}
			
		}
		/*组织机构代 证件号码大于等于9位，为数字、“-”或大写拉丁字母*/
		if(idTypeText == "A"){
		 if(objValueLength != 10){
					rdShowMessageDialog(objName+"必须是10位！");				
					nextFlag = false;
					return false;
			}
			if(objValue.substr(objValueLength-2,1)!="-" && objValue.substr(objValueLength-2,1)!="－") {
					rdShowMessageDialog(objName+"倒数第二位必须是“-”！");				
					nextFlag = false;
					return false;			
			}
		}
		/*营业执照 证件号码号码大于等于4位数字，出现其他如汉字等字符也合规*/
		if(idTypeText == "8"){
		
		 if(objValueLength != 13 && objValueLength != 15 && objValueLength != 18 && objValueLength != 20){
					rdShowMessageDialog(objName+"必须是13位或15位或18位或20位！");				
					nextFlag = false;
					return false;
			}
				    
			var m = /^[\u0391-\uFFE5]*$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum > 0){
					rdShowMessageDialog(objName+"不允许录入汉字！");				
					nextFlag = false;
					return false;
			}

		}
		/*法人证书 证件号码大于等于4位字符*/
		if(idTypeText == "B"){
		 if(objValueLength != 12){
					rdShowMessageDialog(objName+"必须是12位！");				
					nextFlag = false;
					return false;
			}
				    
			var m = /^[\u0391-\uFFE5]*$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum > 0){
					rdShowMessageDialog(objName+"不允许录入汉字！");				
					nextFlag = false;
					return false;
			}
			
		}	
		/*调用原有逻辑*/
		rpc_chkX('idType','idIccid','A');
		
	}
	return nextFlag;
}

/**
 * hejwa add 2015/5/12 14:40:16
 * 关于进一步加强省级支撑系统实名补登记功能的通知
 * 2、修改“GSM过户(1238)”和“实名登记(m058)”功能，新建客户时如果输入的证件号码是黑名单里的号码，
 *	  则弹出提示框。即与客户开户一致即可
 */
function rpc_chkX(x_type,x_no,chk_kind)
{
  var obj_type=document.all(x_type);
  var obj_no=document.all(x_no);
  var idname="";

  if(obj_type.type=="text")
  {
    idname=(obj_type.value).trim();
  }
  else if(obj_type.type=="select-one")
  {
    idname=(obj_type.options[obj_type.selectedIndex].text).trim();  
  }

  if((obj_no.value).trim().length>0)
  {
  	
   
      if(idname=="身份证")
    {
        if(checkElement(obj_no)==false) return false;
    }
  
  }
  else 
  return;
  var myPacket = new AJAXPacket("/npage/innet/chkX.jsp","正在验证黑名单信息，请稍候......");
    myPacket.data.add("retType","chkX");
    myPacket.data.add("retObj",x_no);
    myPacket.data.add("x_idType",getX_idno(idname));
    myPacket.data.add("x_idNo",obj_no.value);
    myPacket.data.add("x_chkKind",chk_kind);
    core.ajax.sendPacket(myPacket);
    myPacket=null;
  
}

   
   
   
/*
	2013/11/15 15:33:56 gaopeng 关于进一步提升省级支撑系统实名登记功能的通知  
	注意：只针对个人客户 end
*/ 

/*2013/12/16 15:41:14 gaopeng 经办人证件类型下拉表单改变函数*/
function validateGesIdTypes(idtypeVal){
	
		if(idtypeVal.indexOf("身份证") != -1){
  		document.all.gestoresIccId.v_type = "idcard";
  		$("#scan_idCard_two3").css("display","");
  		$("#scan_idCard_two31").css("display","");
  		$("input[name='gestoresName']").attr("class","InputGrey");
  		$("input[name='gestoresName']").attr("readonly","readonly");
  		$("input[name='gestoresAddr']").attr("class","InputGrey");
  		$("input[name='gestoresAddr']").attr("readonly","readonly");
  		$("input[name='gestoresIccId']").attr("class","InputGrey");
  		$("input[name='gestoresIccId']").attr("readonly","readonly");
  		$("input[name='gestoresName']").val("");
  		$("input[name='gestoresAddr']").val("");
  		$("input[name='gestoresIccId']").val("");

  	}else{
  		document.all.gestoresIccId.v_type = "string";
  		$("#scan_idCard_two3").css("display","none");
  		$("#scan_idCard_two31").css("display","none");
  		$("input[name='gestoresName']").removeAttr("class");
  		$("input[name='gestoresName']").removeAttr("readonly");
  		$("input[name='gestoresAddr']").removeAttr("class");
  		$("input[name='gestoresAddr']").removeAttr("readonly");
  		$("input[name='gestoresIccId']").removeAttr("class");
  		$("input[name='gestoresIccId']").removeAttr("readonly");

  	}
}

function validateresponIdTypes(idtypeVal){
		if(idtypeVal.indexOf("身份证") != -1){
  		document.all.responsibleIccId.v_type = "idcard";
  			$("#scan_idCard_two3zrr").css("display","");
  			$("#scan_idCard_two57zrr").css("display","");
	  		$("input[name='responsibleName']").attr("class","InputGrey");
	  		$("input[name='responsibleName']").attr("readonly","readonly");
	  		$("input[name='responsibleAddr']").attr("class","InputGrey");
	  		$("input[name='responsibleAddr']").attr("readonly","readonly");
	  		$("input[name='responsibleIccId']").attr("class","InputGrey");
	  		$("input[name='responsibleIccId']").attr("readonly","readonly");
	  		$("input[name='responsibleName']").val("");
	  		$("input[name='responsibleAddr']").val("");
	  		$("input[name='responsibleIccId']").val("");
  		
  	}else{
  		document.all.responsibleIccId.v_type = "string";
  			$("#scan_idCard_two3zrr").css("display","none");
  			$("#scan_idCard_two57zrr").css("display","none");
	  		$("input[name='responsibleName']").removeAttr("class");
	  		$("input[name='responsibleName']").removeAttr("readonly");
	  		$("input[name='responsibleAddr']").removeAttr("class");
	  		$("input[name='responsibleAddr']").removeAttr("readonly");
	  		$("input[name='responsibleIccId']").removeAttr("class");
	  		$("input[name='responsibleIccId']").removeAttr("readonly");
  		
  	}
}


//20091201 begin
/*
function GoodPhoneDateChg()
{
	if(document.all.GoodPhoneFlag.value == "Y")
	{
		//允许实名登记,默认可实名登记时间为系统时间且该时间可修改
		document.all.GoodPhoneDate.value = <%=sysDate_Good%>;
		document.all.GoodPhoneDate.disabled=false;
	}
	else if(document.all.GoodPhoneFlag.value == "N")
	{
		//不允许实名登记,默认可实名登记时间为固定时间且该时间不可修改
		document.all.GoodPhoneDate.value="20500101";
		document.all.GoodPhoneDate.disabled=true;
	}
	else
	{
		//对实名登记无限制,可实名登记时间不可修改
		document.all.GoodPhoneDate.value="";
		document.all.GoodPhoneDate.disabled=true;
	}
}
*/
//20091201 end

	  function doProcess(packet)
	  {
			//RPC处理函数findValueByName
			var retType = packet.data.findValueByName("retType");
			var retCode = packet.data.findValueByName("retCode");
			var retMessage = packet.data.findValueByName("retMessage");
			self.status="";
			if(jtrim(retCode)=="")
			{
			   rdShowMessageDialog("调用"+retType+"服务时失败！");
			   return false;
			}
			//---------------------------------------
			if(retType == "chkID")
			{
				//得到新建客户ID
				var retnewId = packet.data.findValueByName("retnewId");
				if(retCode=="000000")
				{
				   var h_custName = packet.data.findValueByName("cust_name");
				   var h_contactPhone = packet.data.findValueByName("contact_phone");
				   var h_contactAddr = packet.data.findValueByName("contact_address");
				   var h_idIccid = packet.data.findValueByName("ic_iccid");
				   var h_idAddr = packet.data.findValueByName("id_address");

				   document.all.h_custName.value=h_custName;
				   document.all.h_contactPhone.value=h_contactPhone;
				   document.all.h_contactAddr.value=h_contactAddr;
				   document.all.h_idIccid.value=h_idIccid;
				   document.all.h_idAddr.value=h_idAddr;

				   //伊春简单密码不能通过
			   	  if("09" == "<%=regionCode%>"){
					 if(document.all.passwd.value == "000000"||document.all.passwd.value == "111111"||document.all.passwd.value == "222222"
		 	 		  ||document.all.passwd.value == "333333"||document.all.passwd.value == "444444"||document.all.passwd.value == "555555"
		 	 		  ||document.all.passwd.value == "666666"||document.all.passwd.value == "777777"||document.all.passwd.value == "888888"
		 	 		  ||document.all.passwd.value == "999999"||document.all.passwd.value == "123456")
	   				  {
	   						rdShowMessageDialog("密码过于简单，请修改后再办理业务！");
	   						return false;
	   				  }
	   			  }

		          rdShowMessageDialog("校验新客户ID成功！",2);
	   			  document.all.b_print.disabled=false;
				}else{
					if(retCode=="000001"){
             rdShowMessageDialog("密码错误！");
 					}
					if(retCode=="000001"){
					   if(rdShowConfirmDialog("新客户ID不存在，是否新开户？")==1){
                getId();
 					   }else{
                //rdShowMessageDialog("您无法继续进行实名登记业务！");
						 		return false;
					   }
					}else{
					   retMessage = "错误" + retCode + "："+retMessage;
					   rdShowMessageDialog(retMessage);
					   document.all.passwd.value="";
					   document.all.new_srv_no.focus();
					   return false;
					}
				}
			 }
			 //----------------
	if(retType=="chkX_1"){
    var retObj = packet.data.findValueByName("retObj");

		if(retCode == "000000"){
       rdShowMessageDialog(retMessage,2);
       blackFlag=true;
		}else{
       retMessage = "错误" + retCode + "："+retMessage;
       rdShowMessageDialog(retMessage);
			 blackFlag=false;
			 document.all(retObj).focus();
			 return false;
    }
	}

	if(retType=="chkX_2")
	{
    var retObj = packet.data.findValueByName("retObj");
		if(retCode == "000000"){
       assuBlackFlag=true;
		}else{
		  retMessage = "错误" + retCode + "："+retMessage;
		  rdShowMessageDialog(retMessage);
		  assuBlackFlag=false;
		  document.all(retObj).focus();
		  return false;
    }
	}
	if(retType=="chkX_3")
	{
    var retObj = packet.data.findValueByName("retObj");
		if(retCode == "000000"){
          blackFlag3=true;
		}else{
		  retMessage = "错误" + retCode + "："+retMessage;
		  rdShowMessageDialog(retMessage);
		  blackFlag3=true;
		  document.all(retObj).focus();
		  return true;
    }
	}
     //----------------------------------
 	if(retType == "qryID")
	{
		//得到新建客户ID
		var new_cus_id = packet.data.findValueByName("new_cus_id");
		var main_str1 = packet.data.findValueByName("main_str1");
		var fj_str1 = packet.data.findValueByName("fj_str1");
		var main_note = packet.data.findValueByName("main_note");
		if(retCode=="000000")
		{
			document.all.new_cus_id.value = new_cus_id;
			document.all.main_str1.value = main_str1;
			document.all.fj_str1.value = fj_str1;
			document.all.main_note.value = main_note;
			rdShowMessageDialog("新服务号码校验成功!",2);
 		}
		else
		{
			retMessage = "错误" + retCode + "："+retMessage;
			rdShowMessageDialog(retMessage);
			document.all.new_srv_no.value="";
			document.all.new_srv_no.focus();
			return false;
		}
	}
	if(retType == "getID")
	{
 		//得到新建客户ID
		var retnewId = packet.data.findValueByName("retnewId");
		if(retCode=="000000")
		{
			document.all.new_cus_id.value = retnewId;
			document.all.custId.value = retnewId;
			document.all.b_print.disabled=false;
		}else
		{
			retMessage = "错误" + retCode + "："+retMessage;
			rdShowMessageDialog(retMessage);
			return false;
		}
	}


	var cussid=packet.data.findValueByName("cussid");
	if(cussid!=null)
	{
	   if(cussid!="")
       document.all.new_cus_id.value=cussid;
	   else
	   {
	      rdShowMessageDialog("没有此客户！");
          document.all.new_cus_id.focus();
	   }
 	}
 	//dujl add at 20100428 for 身份证验证
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
			document.all.get_Photo.disabled=true;
	 	}
	 	document.all.iccIdCheck.disabled=false;
	 }

	 if(retType=="iccIdCheck1")
	 {
	 	if(retCode == "000000")
	 	{
	 		rdShowMessageDialog("校验通过！");
	 		document.all.get_Photo1.disabled=false;
	 	}
	 	else
	 	{
	 		retMessage = retCode + "："+retMessage;
			rdShowMessageDialog(retMessage);
			document.all.get_Photo1.disabled=true;
	 	}
	 	document.all.iccIdCheck1.disabled=false;
	 }
	 
	 
if(retType=="chkX")
   {
   	
    var retObj = packet.data.findValueByName("retObj");
    if(retCode == "000000"){
      }else if(retCode=="100001"){
        retMessage = retCode + "："+retMessage;  
        rdShowMessageDialog(retMessage);     
        return true;
      }else{
        retMessage = "错误" + retCode + "："+retMessage;      
        rdShowMessageDialog(retMessage,0);
        return false;
       
    }
   }
}



/*1、客户名称、联系人姓名 校验方法 objType 0 代表客户名称校验 1代表联系人姓名校验  ifConnect 代表是否联动赋值(点击确认按钮时，不进行联动赋值)*/
function checkCustNameFuncNew(obj,objType,ifConnect){
	var nextFlag = true;
	
	if(document.all.realUserName.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	
	var objName = "";
	var idTypeVal = "";
	if(objType == 0){
		objName = "客户名称";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "联系人姓名";
		idTypeVal = document.all.idType.value;
	}
	/*2013/12/16 11:24:47 gaopeng 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人姓名*/
	if(objType == 2){
		objName = "经办人姓名";
		/*规则按照经办人证件类型*/
		idTypeVal = document.all.gestoresIdType.value;
	}
	
	if(objType == 3){
		objName = "实际使用人姓名";
		/*规则按照经办人证件类型*/
		idTypeVal = document.all.realUserIdType.value;
	}
	
	idTypeVal = $.trim(idTypeVal);
	
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		/*获取证件类型主键 */
		var idTypeText = idTypeVal;
		
		/*有临时、代办字样的都不行*/
		if(objValue.indexOf("临时") != -1 || objValue.indexOf("代办") != -1){
					rdShowMessageDialog(objName+"不能带有‘临时’或‘代办’字样！");
					
					nextFlag = false;
					return false;
			
		}
		
		/*客户名称、联系人姓名均要求“大于等于2个中文汉字”，外国公民护照除外（外国公民护照客户名称必须大于3个字符，不全为阿拉伯数字)*/
		
		/*如果不是外国公民护照*/
		if(idTypeText != "6"){
			/*原有的业务逻辑校验 只允许是英文、汉字、俄文、法文、日文、韩文其中一种语言！*/
			
			/*2014/08/27 16:14:22 gaopeng 哈分公司申请优化开户名称限制的请示 要求单位客户时，客户名称可以填写英文大小写组合 目前先搞成跟 idTypeText == "3" || idTypeText == "9" 一样的逻辑 后续问问可不可以*/
			if(idTypeText == "3" || idTypeText == "9" || idTypeText == "8" || idTypeText == "A" || idTypeText == "B" || idTypeText == "C"){
				if(objValueLength < 2){
					rdShowMessageDialog(objName+"必须大于等于2个汉字！");
					nextFlag = false;
					return false;
				}
				 var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//分别获取输入内容
            var key = checkNameStr(code); //校验
            if(key == undefined){
              rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
       }
       else{
					
					/*获取含有中文汉字的个数以及'()（）'的个数*/
					var m = /^[\u0391-\uFFE5]*$/;
					var mm = /^·|\.|\．*$/;
					var chinaLength = 0;
					var kuohaoLength = 0;
					var zhongjiandianLength=0;
					for (var i = 0; i < objValue.length; i ++){
								
			          var code = objValue.charAt(i);//分别获取输入内容
			          var flag22=mm.test(code);
			          var flag = m.test(code);
			          /*先校验括号*/
			          if(forKuoHao(code)){
			          	kuohaoLength ++;
			          }else if(flag){
			          	chinaLength ++;
			          }else if(flag22){
			          	zhongjiandianLength++;
			          }
			          
			    }
			    var machLength = chinaLength + kuohaoLength+zhongjiandianLength;
					/*括号的数量+汉字的数量 != 总数量时 提示错误信息(这里需要注意一点，中文括号也是中文。。。所以这里只进行英文括号的匹配个数，否则会匹配多个)*/
					if(objValueLength != machLength || chinaLength == 0){
						rdShowMessageDialog(objName+"必须输入中文或中文与括号的组合(括号可以为中文或英文括号“()（）”)！");
						/*赋值为空*/
						obj.value = "";
						
						nextFlag = false;
						return false;
					}else if(objValueLength == machLength && chinaLength != 0){
						if(objValueLength < 2){
							rdShowMessageDialog(objName+"必须大于等于2个中文汉字！");
							
							nextFlag = false;
							return false;
						}
					}
					/*原有逻辑
					if(idTypeText == "0" || idTypeText == "2"){
						if(objValueLength > 6){
							rdShowMessageDialog(objName+"最多输入6个汉字！");
							
							nextFlag = false;
							return false;
						}
				}
				*/
			}
       
		}
		/*如果是外国公民护照 校验 外国公民护照客户名称(后续添加了联系人姓名也同理(sunaj已确定))必须大于3个字符，不全为阿拉伯数字*/
		if(idTypeText == "6"){
			/*如果校验客户名称*/
				if(objValue % 2 == 0 || objValue % 2 == 1){
						rdShowMessageDialog(objName+"不能全为阿拉伯数字!");
						/*赋值为空*/
						obj.value = "";
						
						nextFlag = false;
						return false;
				}
				if(objValueLength <= 3){
						rdShowMessageDialog(objName+"必须大于三个字符!");
						
						nextFlag = false;
						return false;
				}
				var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//分别获取输入内容
            var key = checkNameStr(code); //校验
            if(key == undefined){
              rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
				
		}
		
		
		
	}	
	return nextFlag;
}


/*
	2013/11/18 11:15:44
	gaopeng
	客户地址、证件地址、联系人地址校验方法
	“客户地址”、“证件地址”和“联系人地址”均需“大于等于8个中文汉字”
	（外国公民护照和台湾通行证除外，外国公民护照要求大于2个汉字，台湾通行证要求大于3个汉字）
*/

function checkAddrFuncNew(obj,objType,ifConnect){
	var nextFlag = true;
	
		if(document.all.realUserAddr.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	var objName = "";
	var idTypeVal = ""
	if(objType == 0){
		objName = "证件地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "客户地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 2){
		objName = "联系人地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 3){
		objName = "联系人通讯地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 4){
		objName = "经办人联系地址";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 5){
		objName = "实际使用人联系地址";
		idTypeVal = document.all.realUserIdType.value;
	}
		
	idTypeVal = $.trim(idTypeVal);
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		
		/*获取证件类型主键 */
		var idTypeText = idTypeVal;
		
		/*获取含有中文汉字的个数*/
		var m = /^[\u0391-\uFFE5]*$/;
		var chinaLength = 0;
		for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	chinaLength ++;
          }
    }
      
		/*如果既不是外国公民护照 也不是台湾通行证 */
		if(idTypeText != "6" && idTypeText != "5"){
			/*含有至少8个中文汉字*/
			if(chinaLength < 8){
				rdShowMessageDialog(objName+"必须含有至少8个中文汉字！");
				/*赋值为空*/
				obj.value = "";
				
				nextFlag = false;
				return false;
			}
		
	}
	/*外国公民护照 大于2个汉字*/
	if(idTypeText == "6"){
		/*大于2个中文汉字*/
			if(chinaLength <= 2){
				rdShowMessageDialog(objName+"必须含有大于2个中文汉字！");
				
				nextFlag = false;
				return false;
			}
	}
	/*台湾通行证 大于3个汉字*/
	if(idTypeText == "5"){
		/*含有至少3个文汉字*/
			if(chinaLength <= 3){
				rdShowMessageDialog(objName+"必须含有大于3个中文汉字！");
				
				nextFlag = false;
				return false;
			}
	}
	
	
}
return nextFlag;
}

/*
	2013/11/18 14:01:09
	gaopeng
	证件类型变更时，证件号码的校验方法
*/

function checkIccIdFuncNew(obj,objType,ifConnect){
	var nextFlag = true;
	
	if(document.all.realUserIccId.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	var idTypeVal = "";
	if(objType == 0){
		var objName = "证件号码";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "经办人证件号码";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 2){
		objName = "实际使用人证件号码";
		idTypeVal = document.all.realUserIdType.value;
	}
	
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		
		/*获取证件类型主键 */
		var idTypeText = idTypeVal;
		
		/*1、身份证及户口薄时，证件号码长度为18位*/
		if(idTypeText == "0" || idTypeText == "2"){
			if(objValueLength != 18){
					rdShowMessageDialog(objName+"必须是18位！");
					
					nextFlag = false;
					return false;
			}
		}
		/*军官证 警官证 外国公民护照时 证件号码大于等于6位字符*/
		if(idTypeText == "1" || idTypeText == "4" || idTypeText == "6"){
			if(objValueLength < 6){
					rdShowMessageDialog(objName+"必须大于等于六位字符！");
					
					nextFlag = false;
					return false;
			}
		}
		/*证件类型为港澳通行证的，证件号码为9位或11位，并且首位为英文字母“H”或“M”(只可以是大写)，其余位均为阿拉伯数字。*/
		if(idTypeText == "3"){
			if(objValueLength != 9 && objValueLength != 11){
					rdShowMessageDialog(objName+"必须是9位或11位！");
					
					nextFlag = false;
					return false;
			}
			/*获取首字母*/
			var valHead = objValue.substring(0,1);
			if(valHead != "H" && valHead != "M"){
					rdShowMessageDialog(objName+"首字母必须是‘H’或‘M’！");
					
					nextFlag = false;
					return false;
			}
			/*获取首字母之后的所有信息*/
			var varWithOutHead = objValue.substring(1,objValue.length);
			if(varWithOutHead % 2 != 0 && varWithOutHead % 2 != 1){
					rdShowMessageDialog(objName+"除首字母之外，其余位必须是阿拉伯数字！");
					
					nextFlag = false;
					return false;
			}
		}
		/*证件类型为
			台湾通行证 
			证件号码只能是8位或11位
			证件号码为11位时前10位为阿拉伯数字，
			最后一位为校验码(英文字母或阿拉伯数字）；
			证件号码为8位时，均为阿拉伯数字
		*/
		if(idTypeText == "5"){
			if(objValueLength != 8 && objValueLength != 11){
					rdShowMessageDialog(objName+"必须为8位或11位！");
					
					nextFlag = false;
					return false;
			}
			/*8位时，均为阿拉伯数字*/
			if(objValueLength == 8){
				if(objValue % 2 != 0 && objValue % 2 != 1){
					rdShowMessageDialog(objName+"必须为阿拉伯数字");
					
					nextFlag = false;
					return false;
				}
			}
			/*11位时，最后一位可以是英文字母或阿拉伯数字，前10位必须是阿拉伯数字*/
			if(objValueLength == 11){
				var objValue10 = objValue.substring(0,10);
				if(objValue10 % 2 != 0 && objValue10 % 2 != 1){
					rdShowMessageDialog(objName+"前十位必须为阿拉伯数字");
					
					nextFlag = false;
					return false;
				}
				var objValue11 = objValue.substring(10,11);
  			var m = /^[A-Za-z]+$/;
				var flag = m.test(objValue11);
				
				if(!flag && objValue11 % 2 != 0 && objValue11 % 2 != 1){
					rdShowMessageDialog(objName+"第11位必须为阿拉伯数字或英文字母！");
					
					nextFlag = false;
					return false;
				}
			}
			
		}
		/*组织机构代 证件号码大于等于9位，为数字、“-”或大写拉丁字母*/
		if(idTypeText == "A"){
			var m = /^([0-9\-A-Z]*)$/;
			var flag = m.test(objValue);
			if(!flag){
					rdShowMessageDialog(objName+"必须由数字、‘-’、或大写字母组成！");
					
					nextFlag = false;
					return false;
			}
			if(objValueLength < 9){
					rdShowMessageDialog(objName+"必须大于等于9位！");
					
					nextFlag = false;
					return false;
				
			}
		}
		/*营业执照 证件号码号码大于等于4位数字，出现其他如汉字等字符也合规*/
		if(idTypeText == "8"){
			var m = /^[0-9]+$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum < 4){
					rdShowMessageDialog(objName+"包含至少4个数字！");
					
					nextFlag = false;
					return false;
			}
			/*20131216 gaopeng 关于在BOSS入网界面增加单位客户经办人信息的函 界面中的证件类型为“营业执照”时，要求证件号码的位数为15位字符*/
			if(objValueLength != 15){
					rdShowMessageDialog(objName+"必须为15个字符！");
					nextFlag = false;
					return false;
			}
		}
		/*法人证书 证件号码大于等于4位字符*/
		if(idTypeText == "B"){
			if(objValueLength < 4){
					rdShowMessageDialog(objName+"必须大于等于4位！");
					
					nextFlag = false;
					return false;
			}
			
		}


	}else if(opCode == "1993"){

	}
	return nextFlag;
}


	var printAddFlag = false;
	 //--------4---------显示打印对话框----------------
	 function printCommit()
	 {
	 		if("<%=realOpCode%>" == "m389"){
		 		var serviceFileName = $("input[name='serviceFileName']").val();
			 	if(serviceFileName.length == 0){
			 		rdShowMessageDialog( "请上传实名制批量文件!" , 0 );
					return false;
			 	}
			}
		 	
	 		/* begin add 如 没有进行“工单结果查询”,则不能进行提交 for 关于电话用户实名登记近期重点工作的通知 @2014/11/4 */
			if("<%=opCode%>" == "m058"){
				if(document.all.r_cus[0].checked){ //新建客户
					var checkVal = document.all.isJSX.value;//个人开户分类 普通客户：0
					var idTypeSelect = $("#idType option[@selected]").val();//证件类型：身份证
					if(idTypeSelect.indexOf("|") != -1){
						var v_idTypeSelect = idTypeSelect.split("|")[0];
						if(checkVal == "0" && v_idTypeSelect == "0" && "<%=workChnFlag%>" == "1" && "<%=regionCodeFlag%>" == "Y"){ 
						 if("<%=appregionflag%>"=="0") {//如果不在app配置表里则只能进行工单查询。
							if(($("#isQryListResultFlag").val() == "N") && (parseInt($("#sendListOpenFlag").val()) > 0)){ //已查询工单列表，并下发工单开关为开，则进行校验
								rdShowMessageDialog("请先进行工单结果查询，再进行实名登记!");
						    return false;		
								}
							}
						}
					}
				}
		  }
			/* end add for 关于电话用户实名登记近期重点工作的通知 @2014/11/4 */	 
	 	//齐齐哈尔简单密码 20100201 sunaj
		/*if("02" == "<%=regionCode%>")
		{
			if(document.all.custPwd.value == "000000"||document.all.custPwd.value == "111111"||document.all.custPwd.value == "222222"
		 	 ||document.all.custPwd.value == "333333"||document.all.custPwd.value == "444444"||document.all.custPwd.value == "555555"
		 	 ||document.all.custPwd.value == "666666"||document.all.custPwd.value == "777777"||document.all.custPwd.value == "888888"
		 	 ||document.all.custPwd.value == "999999"||document.all.custPwd.value == "123456")
	   		{
	   			rdShowMessageDialog("客户密码过于简单，请修改后再办理业务！");
	   			return false;
	   		}
	   		if(document.all.passwd.value == "000000"||document.all.passwd.value == "111111"||document.all.passwd.value == "222222"
		 	 ||document.all.passwd.value == "333333"||document.all.passwd.value == "444444"||document.all.passwd.value == "555555"
		 	 ||document.all.passwd.value == "666666"||document.all.passwd.value == "777777"||document.all.passwd.value == "888888"
		 	 ||document.all.passwd.value == "999999"||document.all.passwd.value == "123456")
	   		{
	   				rdShowMessageDialog("客户密码过于简单，请修改后再办理业务！");
	   				return false;
	   		}
	   	}
	   	*/
	   	
	  /*2013/11/18 15:09:28 gaopeng 加入提交之前的校验 关于进一步提升省级支撑系统实名登记功能的通知 start*/
		/*重新校验*/
    		/*客户名称*/
    		if(!checkCustNameFunc16New(document.all.custName,0,1)){
    			return false;
    		}
    		/*联系人姓名*/
    		if(!checkCustNameFunc(document.all.contactPerson,1,1)){
					return false;
				}
				/*证件地址*/
				if(!checkAddrFunc(document.all.idAddr,0,1)){
					return false;
				}
				/*客户地址*/
				if(!checkAddrFunc(document.all.custAddr,1,1)){
					return false;
				}
				/*联系人地址*/
				if(!checkAddrFunc(document.all.contactAddr,2,1)){
					return false;
				}
				/*联系人通讯地址*/
				if(!checkAddrFunc(document.all.contactMAddr,3,1)){
					return false;
				}
				/*证件号码*/
				if(!checkIccIdFunc16New(document.all.idIccid,0,1)){
					return false;
				}
				else{
					rpc_chkX('idType','idIccid','A');
				}
				
				/*gaopeng 20131216 2013/12/16 19:50:11 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人信息确认服务前校验 start*/
					if(!checkElement(document.all.gestoresName)){
						return false;
					}
					if(!checkElement(document.all.gestoresAddr)){
						return false;
					}
					if(!checkElement(document.all.gestoresIccId)){
						return false;
					}
					/*经办人姓名*/
					if(!checkCustNameFunc16New(document.all.gestoresName,1,1)){
						return false;
					}
					/*经办人联系地址*/
					if(!checkAddrFunc(document.all.gestoresAddr,4,1)){
						return false;
					}
					/*经办人证件号码*/
					if(!checkIccIdFunc16New(document.all.gestoresIccId,1,1)){
						return false;
					}
					else{
						rpc_chkX('idType','idIccid','A');
					}
					
				/*gaopeng 20131216 2013/12/16 19:50:11 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人信息确认服务前校验 start*/
				
				
					/*责任人姓名*/
				if(!checkElement(document.all.responsibleName)){
					return false;
				}
				/*责任人联系地址*/
				if(!checkElement(document.all.responsibleAddr)){
					return false;
				}
				/*责任人证件号码*/
				if(!checkElement(document.all.responsibleIccId)){
					return false;
				}
				
			
				if(!checkCustNameFunc16New(document.all.responsibleName,2,1)){
					return false;
				}
			
				if(!checkAddrFunc(document.all.responsibleAddr,5,1)){
							return false;
				}
			
				if(!checkIccIdFunc16New(document.all.responsibleIccId,2,1)){
									return false;
				}				
				else{
					rpc_chkX('idType','idIccid','A');
				}
				
				/*实际使用人姓名*/
				if(!checkElement(document.all.realUserName)){
					return false;
				}
				/*实际使用人联系地址*/
				if(!checkElement(document.all.realUserAddr)){
					return false;
				}
				/*实际使用人证件号码*/
				if(!checkElement(document.all.realUserIccId)){
					return false;
				}
				
			  if(!checkCustNameFunc16New(document.all.realUserName,3,1)){
					return false;
				}
			
				if(!checkAddrFuncNew(document.all.realUserAddr,5,1)){
							return false;
					}
			
				if(!checkIccIdFunc16New(document.all.realUserIccId,3,1)){
									return false;
				}
				else{
					rpc_chkX('idType','idIccid','A');
				}

				/*模糊验证进来的隐藏 或者 宽带号码进来的隐藏 其他的都不隐藏 24个月*/
				if("<%=is_Z_flag%>"=="true" || "<%=isKd%>"=="true"){
					
				}else{
					if($("#is_sPwdAuthChk_sel").val()==""){
						rdShowMessageDialog("请选择<%=if24MonthText%>");
						return false;						
					}
				}
		/*2013/11/18 15:09:28 gaopeng 加入提交之前的校验 关于进一步提升省级支撑系统实名登记功能的通知 end*/
	 	getAfterPrompt();
	 	
	 	/*和阅读*/
		
		if(("100001" == "<%=backCode%>" || "100002" == "<%=backCode%>") && ("<%=sNewSmName%>" == "dn" || "<%=sNewSmName%>" == "gn" || "<%=sNewSmName%>" == "zn") && "<%=ifCanShow%>" == "true"){
			if(rdShowConfirmDialog("<%=backInfo%>")==1){
				printAddFlag = true;
			}else{
				printAddFlag = false;
			};
			
		}
		$("#printAddFlag").val(printAddFlag+"");
		$("#backCode").val("<%=backCode%>");
		
		// in here form check
		showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	 }

	 function showPrtDlg(printType,DlgMessage,submitCfm)
	 {
//----------------------add by huy 20050722
/* update “信誉度”内容不可见（包括已有老户和新建客户） for 关于哈分公司申请优化M058实名制登记信誉度清零问题的请示@2015/2/11
		if(jtrim(document.all.xinYiDu.value).length==0)
		{
			   rdShowMessageDialog(document.all.xinYiDu.v_name+"不能为空！");
               document.all.xinYiDu.focus();
			   return false;
		}
*/
//-----------------------
        if(document.all.tr_newCust.style.display=="")
		{
            //判断非空性
			if(jtrim(document.all.custName.value).length==0)
			{
			   rdShowMessageDialog(document.all.custName.v_name+"不能为空！");
               document.all.custName.focus();
			   return false;
			}
			if(jtrim(document.all.idIccid.value).length==0)
			{
			   rdShowMessageDialog(document.all.idIccid.v_name+"不能为空！");
               document.all.idIccid.focus();
			   return false;
			}

			if(jtrim(document.all.idAddr.value).length==0)
			{
			   rdShowMessageDialog(document.all.idAddr.v_name+"不能为空！");
               document.all.idAddr.focus();
			   return false;
			} else if (!checkElement(document.all.idAddr)){
			   rdShowMessageDialog(document.all.idAddr.v_name+"长度有误！");
               document.all.idAddr.focus();
			   return false;
			}

			if(jtrim(document.all.custPwd.value).length==0)
			{
			   /*rdShowMessageDialog(document.all.custPwd.v_name+"不能为空！");
               document.all.custPwd.focus();
			   return false;*/
			}
			else
			{
				if(jtrim(document.all.custPwd.value).length!=6)
				{
				   rdShowMessageDialog(document.all.custPwd.v_name+"长度有误！");
				   document.all.custPwd.focus();
				   return false;
				}
			}
			if(jtrim(document.all.custAddr.value).length==0)
			{
			   rdShowMessageDialog(document.all.custAddr.v_name+"不能为空！");
               document.all.custAddr.focus();
			   return false;
			} else if (!checkElement(document.all.custAddr)){
			   rdShowMessageDialog(document.all.custAddr.v_name+"长度有误！");
               document.all.custAddr.focus();
			   return false;
			}
			/* begin update 联系人姓名为必填 for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
			if(jtrim(document.all.contactPerson.value).length==0)
			{
			   rdShowMessageDialog(document.all.contactPerson.v_name+"不能为空！");
         document.all.contactPerson.focus();
			   return false;
			}
			/* end update 联系人姓名为必填 for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
			if(jtrim(document.all.contactPhone.value).length==0)
			{
			   rdShowMessageDialog(document.all.contactPhone.v_name+"不能为空！");
               document.all.contactPhone.focus();
			   return false;
			}
			if(!checkElement(document.all.contactPhone)){
				rdShowMessageDialog(document.all.contactPhone.v_name+"格式不正确！");
               document.all.contactPhone.focus();
			   return false;
			}

			if(jtrim(document.all.contactAddr.value).length==0)
			{
			   rdShowMessageDialog(document.all.contactAddr.v_name+"不能为空！");
               document.all.contactAddr.focus();
			   return false;
			} else if (!checkElement(document.all.contactAddr)){
			   rdShowMessageDialog(document.all.contactAddr.v_name+"长度有误！");
               document.all.contactAddr.focus();
			   return false;
			}

			if(jtrim(document.all.contactMAddr.value).length==0)
			{
			   rdShowMessageDialog(document.all.contactMAddr.v_name+"不能为空！");
               document.all.contactMAddr.focus();
			   return false;
			} else if (!checkElement(document.all.contactMAddr)){
			   rdShowMessageDialog(document.all.contactMAddr.v_name+"长度有误！");
               document.all.contactMAddr.focus();
			   return false;
			}

			change_idType('2');   //判断客户证件类型是否是身份证
			if(jtrim(document.all.contactMail.value) == "")
			{
				document.all.contactMail.value = "";
			}
			//判断生日、证件有效期有效性	birthDay	idValidDate

			if((typeof(document.all.birthDay)!="undefined") &&
			   (document.all.birthDay.value != ""))
			{
				if(forDate(document.all.birthDay) == false)
				{	
				return false;		}
			}
			else if((typeof(document.all.yzrq)!="undefined")&&
			   (document.all.yzrq.value != ""))
			{
				if(forDate(document.all.yzrq) == false)
				{	return false;		}
			}

			var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());

			if(jtrim(document.all.idValidDate.value).length>0)
			{
			   if(forDate(document.all.idValidDate)==false) return false;

			   if(to_date(document.all.idValidDate)<=d)
			   {
				  rdShowMessageDialog("证件有效期不能早于当前时间，请重新输入！");
				  document.all.idValidDate.focus();
				  document.all.idValidDate.select();
				  return false;
			   }
			}

			if(jtrim(document.all.birthDay.value).length>0)
			{
			   if(to_date(document.all.birthDay)>=d)
			   {
				 rdShowMessageDialog("出生日期期不能晚于当前时间，请重新输入！");
				 document.all.birthDay.focus();
				 document.all.birthDay.select();
				 return false;
			   }
			}
			
		}
if((document.all.but_flag.value =="1")&&document.all.upbut_flag.value=="0"){//二代证
	rdShowMessageDialog("请先上传身份证照片",0);
	return false;
	}
        
var upflag =document.all.up_flag.value;//二代证
if(upflag==3&&(document.all.but_flag.value =="1"))//二代证
{
	rdShowMessageDialog("请选择jpg类型图像文件");
	return false;
	}
if(upflag==4&&(document.all.but_flag.value =="1"))//二代证
{
	rdShowMessageDialog("请先扫描或读取证件信息");
	return false;
	}
	
	
if(upflag==5&&(document.all.but_flag.value =="1"))//二代证
{
	rdShowMessageDialog("请选择最后一次扫描或读取证件而生成的证件图像文件"+document.all.pic_name.value);
	return false;
	}
			
if((document.all.but_flag.value =="1")&&document.all.upbut_flag.value=="0"){//二代证
	rdShowMessageDialog("请先上传身份证照片",0);
	return false;
	}
		//20091201 begin
		/*
		var da_te= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());
		if(document.all.GoodPhoneFlag.value == "Y")
		{
			if((document.all.GoodPhoneDate.value).trim().length != 8)
			{
				rdShowMessageDialog("请按正确格式输入实名登记时间");
				document.frm1104.GoodPhoneDate.focus();
				return false;
			}

			if(to_date(document.all.GoodPhoneDate) < da_te)
			{
				rdShowMessageDialog("实名登记限制时间小于当前系统时间，请重新输入！");
				document.all.GoodPhoneDate.focus();
				return false;
			}
		}
		*/
		//20091201 end


        //-------------------------------------------
		//if(check(frm))
		{
          if(document.all.tr_newCust.style.display=="" && "09" != "<%=regionCode%>")
		  {
          if(checkPwd(document.all.custPwd,document.all.cfmPwd)==false) return false;
          chkPwdEasy(document.all.custPwd.value);
		  } else {
			  continueCfm();
		  }
		}
	 }

	 //--------------------------------------
	 function checkPwd(obj1,obj2)
	 {
			//密码一致性校验,明码校验
			var pwd1 = obj1.value;
			var pwd2 = obj2.value;
			if(pwd1 != pwd2)
			{
					var message = "两次输入的密码不一致，请重新输入！";
					rdShowMessageDialog(message);
					if(obj1.type != "hidden")
					{   obj1.value = "";    }
					if(obj2.type != "hidden")
					{   obj2.value = "";    }
					obj1.focus();
					return false;
			}
			return true;
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
			if("<%=isKd%>" == "true"){
				cust_info+="手机号码：   <%=kdNo%>|";
			}else{
				cust_info+="手机号码：   "+document.all.srv_no.value+"|";
			}
 		  cust_info+="客户姓名：   " +document.all.cust_name.value+"|";
      //cust_info+="客户地址：   "+document.all.cust_addr.value+"|";
      //cust_info+="证件号码：   "+document.all.ic_no.value+"|";

 		  opr_info+="用户品牌："+"<%=sNewSmName%>"+"  *"+"办理业务："+"实名登记"+"|";
		  opr_info+="操作流水："+document.all.loginAccept.value+"|";


		  if(document.all.r_cus[0].checked)
		 {
			
			if("<%=isKd%>" == "true"){
				opr_info+="用户号码"+"<%=kdNo%>"+"由用户"+"<%=(String)custDoc.get(5)%>"+"实名登记到用户"+document.all.custName.value+"|";
			}else{
				opr_info+="用户号码"+"<%=srv_no%>"+"由用户"+"<%=(String)custDoc.get(5)%>"+"实名登记到用户"+document.all.custName.value+"|";
			}
		  
		  opr_info+="新客户资料：客户名称："+document.all.custName.value+"*"+"证件号码："+document.all.idIccid.value+"|";
		  opr_info+="客户地址："+document.all.idAddr.value+"|";
		  }else{
		  
		  if("<%=isKd%>" == "true"){
				opr_info+="用户号码"+"<%=kdNo%>"+"由用户"+"<%=(String)custDoc.get(5)%>"+"实名登记到用户"+document.all.h_custName.value+"|";
			}else{
				opr_info+="用户号码"+"<%=kdNo%>"+"由用户"+"<%=(String)custDoc.get(5)%>"+"实名登记到用户"+document.all.h_custName.value+"|";
			}
		  
		  opr_info+="新客户资料：客户名称："+document.all.h_custName.value+"*"+"证件号码："+document.all.h_idIccid.value+"|";
		  opr_info+="客户地址："+document.all.h_idAddr.value+"|";
		  }
		  opr_info+=" "+"|";
		  opr_info+="当前主资费："+"<%=main_str1%>"+"|";
		  opr_info+="当前可选资费："+"<%=fj_str1%>"+"|";
		  opr_info+=" "+"|";
		  opr_info+="主资费说明："+"<%=main_note%>"+"|";



	  	/*模糊验证进来的隐藏 或者 宽带号码进来的隐藏 其他的都不隐藏 24个月*/
			if("<%=is_Z_flag%>"=="true" || "<%=isKd%>"=="true"){
				
			}else{
				if($("#is_sPwdAuthChk_sel").val()=="K"){
					opr_info += "已限制24个月不允许办理实名登记和过户"+"|";
				}else if($("#is_sPwdAuthChk_sel").val()=="N"){
					opr_info += "实名登记后不允许办理更名、过户业务，不使用此号码时仅允许办理销户业务"+"|";
				}
			}
				
				
				
		  if("<%=goodFlagNew%>"=="1"){ 

			note_info1+=" "+"|";
			note_info1+="注意：该号码为特殊号码，底线消费金额为"+"<%=mode_name%>"+"元,实名登记后原底线消费标准保持不变，仍按原规定执行，即需在您选择的资费基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。|";
		  }

		  note_info1+="备注："+document.all.assuNote.value+"|";
		  
	
				  		  
<%
			if(printFlag){
%>
					note_info1 += '您本次实名登记是通过模糊验证的方式进行办理，并未出具开户的业务工单及发票，|';
					note_info1 += '若日后其他客户持相关凭据要求进行实名登记，我公司将无条件过回，由此引发的法律问题由您自行承担。';
<%
			}
%>
		  /*和阅读提示信息*/
		 if("<%=backCode%>" == "100001" && printAddFlag){
		 	note_info1+= "尊敬的客户，为感谢您的支持，我公司将自本月起为您赠送“和阅读精品畅读包体验版”免费体验服务三个月，体验到期当月25号系统将自动为您退订业务，体验期间您也可以发送短信QXCDBTY到10086取消。"+"|";
		 }
		 
		 /*彩铃提示信息*/
		 if("<%=backCode%>" == "100002" && printAddFlag){
		 	note_info1+= "尊敬的客户，为感谢您的支持，我公司赠送您“彩铃0元体验包”及“铃听天下0元包”免费体验至2016年3月15日，办理成功48小时内生效，体验到期系统自动为您退订业务，体验期间您也可以发送短信QXCLTY到10086取消。体验彩铃与其他彩铃产品不能同时订购，系统以客户最后一次订购产品为准。"+"|";
		 }
		  //#23->#
			//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		  return retInfo;
	 }

	 //--------5----------提交处理函数-------------------
	 function conf()
	 {
		if(document.all.r_cus[0].checked)
		{
			//判断非空性
			if ( jtrim (document.all.new_cus_id.value).length == 0 )
			{
				rdShowMessageDialog( "新客户ID不能为空,请重试!" , 0 );
				return false;
			}
		}
		var responsibleType = $("select[name='responsibleType']").find("option:selected").val();
		document.all.b_print.disabled=true;
		document.all.b_clear.disabled=true;
		document.frm.method="post";
		document.frm.target="_self";
		 if("<%=realOpCode%>" == "m389"){
		 	$("input[name='b_print']").attr("disabled","disabled");
		 	frm.action="/npage/sm389/fm389Cfm.jsp";
		 	frm.submit();
		 }else{
			 if($("#gestoresInfo1").css("display")=="none"){
				 frm.action="s1238_conf.jsp";
	        }
	        else{
	        	frm.action="s1238_conf.jsp?xsjbrxx=1";
	        }
		 	
		 	frm.submit();
		 }
		 
	 }

	 function canc()
	 {
		frm.submit();
	 }

    //-------6--------实收栏专用函数----------------
     function ChkHandFee()
	 {
       if(jtrim(document.all.oriHandFee.value).length>=1 && jtrim(document.all.t_handFee.value).length>=1)
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

	   if(jtrim(document.all.oriHandFee.value).length>=1 && jtrim(document.all.t_handFee.value).length==0)
	   {
         document.all.t_handFee.value="0";
	   }
	 }

	 function getFew()
	 {
		 var fee=document.all.t_handFee;
		 var fact=document.all.t_factFee;
		 var few=document.all.t_fewFee;
		 if(jtrim(fact.value).length==0)
		 {
		  rdShowMessageDialog("实收金额不能为空！");
		  fact.value="";
		  fact.focus();
		  return;
		 }
		 if(parseFloat(fact.value)<parseFloat(fee.value))
		 {
		  rdShowMessageDialog("实收金额不足！");
		  fact.value="";
		  fact.focus();
		  return;
		 }

			var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();
			var tem2=tem1;
			if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
	    few.value=(tem2/100).toString();
			few.focus();
	 }

	 function chkID()
	 {
	    if(jtrim(document.all.new_cus_id.value).length==0)
		{
		    rdShowMessageDialog("新客户ID不能为空！");
        document.all.new_cus_id.focus();
			  return false;
 		}

		else
		{
       if(forInt(document.all.new_cus_id)==false) return false;

		   if(jtrim(document.all.new_cus_id.value)=="<%=(String)custDoc.get(1)%>")
		   {
		  		rdShowMessageDialog("新客户ID不能与原客户ID相同！");
          document.all.new_cus_id.focus();
	  			return false;
		   }

		   if(document.all.passwd.value.trim().len()==0){
		   		rdShowMessageDialog("客户密码不能为空!");
		   		return false;
		   }

		   if(document.all.passwd.value.trim().len()!=6){
		   		rdShowMessageDialog("客户密码必须是6位!");
		   		return false;
		   }
		   
		   if("<%=opCode%>" == "m058"){
		   	 //判断这个客户是否是新开户的客户
					var isExitCustFlag = "N";
					var userIdType = "";
					var myPacket = new AJAXPacket("/npage/portal/shoppingCar/ajax_isExitForCust.jsp","正在查询信息，请稍候......");
				  myPacket.data.add("g_CustId",jtrim(document.all.new_cus_id.value)); 
				  myPacket.data.add("opCode","<%=opCode%>");
				  core.ajax.sendPacket(myPacket,function(packet){
				  	var retCode=packet.data.findValueByName("retCode");
					  var retMsg=packet.data.findValueByName("retMsg");
					  var v_isExitCustFlag=packet.data.findValueByName("isExitCustFlag"); //当前客户下，用户是否存在
					  var v_userIdType=packet.data.findValueByName("userIdType"); //当前客户下，证件类型
					  if(retCode == "000000"){
					  	isExitCustFlag = v_isExitCustFlag;
					  	userIdType = v_userIdType;
					 	}else{
					 		rdShowMessageDialog("查询此客户是否存在用户信息失败！错误代码:<%=retCode%><br>错误信息:<%=retMsg%>！",0);
							return  false;
					 	}
				  });
				  myPacket = null;	
					if(isExitCustFlag == "Y"){//说明客户已存在用户
						//1-判断此用户当前证件类型，是否是身份证
						if(userIdType == "0" || userIdType == "00"){ //身份证:如果是身份证开户的，就不允许进行实名登记
							rdShowMessageDialog("老客户证件类型为身份证，不允许办理“并老客户”业务！请新建客户！",1);
							return  false;
						}else{ //2-判断是否有优惠权限 之前已判断
							//当为单位客户，实际使用人相关信息必填。证件类型即：营业执照、组织机构代码、单位法人证书和介绍信
						  if(userIdType == "8" || userIdType == "A" || userIdType == "B" || userIdType == "C"){
								/*实际使用人姓名*/
						  	document.all.realUserName.v_must = "1";
						  	/*经实际使用人地址*/
						  	document.all.realUserAddr.v_must = "1";
						  	/*实际使用人证件号码*/
						  	document.all.realUserIccId.v_must = "1";	
						  }else{
						  	/*实际使用人姓名*/
						  	document.all.realUserName.v_must = "0";
						  	/*经实际使用人地址*/
						  	document.all.realUserAddr.v_must = "0";
						  	/*实际使用人证件号码*/
						  	document.all.realUserIccId.v_must = "0";			
						  }
						}
					}	
					/*经办人姓名*/
			  	document.all.gestoresName.v_must = "0";
			  	/*经办人地址*/
			  	document.all.gestoresAddr.v_must = "0";
			  	/*经办人证件号码*/
			  	document.all.gestoresIccId.v_must = "0";			
			  	
			  	/*责任人人姓名*/
			  	document.all.responsibleName.v_must = "0";
			  	/*责任人人地址*/
			  	document.all.responsibleAddr.v_must = "0";
			  	/*经责任人人证件号码*/
			  	document.all.responsibleIccId.v_must = "0";  				  	
			  	  
		   }

       var getUserId_Packet = new AJAXPacket("s1238_chkID.jsp","正在校验新客户ID，请稍候......");
  	   getUserId_Packet.data.add("retType","chkID");
   	   getUserId_Packet.data.add("new_cus_id",jtrim(document.all.new_cus_id.value));
       getUserId_Packet.data.add("region_code","<%=regionCode%>");
       getUserId_Packet.data.add("passwd",document.all.passwd.value);
       core.ajax.sendPacket(getUserId_Packet);
       getUserId_Packet = null;
		}

	 }

	 function qryID()
	 {
	    if(jtrim(document.all.new_srv_no.value).length==0)
		{
		     rdShowMessageDialog("新服务号码不能为空！");
         document.all.new_srv_no.focus();
			   return false;
 		}

		else
		{
		   if(forMobil(document.all.new_srv_no)==false) return false;
		   if(jtrim(document.all.new_srv_no.value)=="<%=srv_no%>")
		   {
	     		 rdShowMessageDialog("新服务号码不能与原服务号码相同！");
           document.all.new_srv_no.focus();
		 			 return false;
		   }

       document.all.b_print.disabled=true;
		   document.all.new_cus_id.value="";
		   if(document.all.tr_newCust.style.display=="")
		   {
			  document.all.tr_newCust.style.display="none";
		   }

       var getUserId_Packet = new AJAXPacket("s1238_qryID.jsp","正在查询新客户ID，请稍候......");
  	   getUserId_Packet.data.add("retType","qryID");
		   getUserId_Packet.data.add("region_code","<%=regionCode%>");
		   getUserId_Packet.data.add("new_srv_no",document.all.new_srv_no.value);
       core.ajax.sendPacket(getUserId_Packet);
       getUserId_Packet = null;
		}
	 }

	 function getId()
	 {
		//得到客户ID
		document.all.tr_newCust.style.display="";

		var getUserId_Packet = new AJAXPacket("s1238_getID.jsp","正在获得新客户ID，请稍候......");
		getUserId_Packet.data.add("retType","getID");
		getUserId_Packet.data.add("region_code","<%=regionCode%>");
		getUserId_Packet.data.add("idType","0");
		getUserId_Packet.data.add("oldId","0");
		core.ajax.sendPacket(getUserId_Packet);
		getUserId_Packet = null;
	 }

     function chgNewId()
	 {
	   //document.all.new_srv_no.value="";
	   document.all.b_print.disabled=true;

	   if(document.all.tr_newCust.style.display=="")
	   {
         document.all.tr_newCust.style.display="none";
	   }
	 }

	/*** dujl add at 20090806 for R_HLJMob_cuisr_CRM_PD3_2009_0314@关于规范客户开户过程中基本资料中非法字符校验的需求 ****/
	function feifa(textName)
	{
		if(textName.value != "")
		{
			if((textName.value.indexOf("~")) != -1 || (textName.value.indexOf("|")) != -1 || (textName.value.indexOf(";")) != -1)
			{
				rdShowMessageDialog("不允许输入非法字符，请重新输入！");
				textName.value = "";
	 	  		return;
			}
		}
	}
	
function forKuoHao(obj){
	var m = /^(\(?\)?\（?\）?)\·|\.|\．+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}
function forEnKuoHao(obj){
	var m = /^(\(?\)?)+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}
  function forHanZi1(obj)
  {
  	var m = /^[\u0391-\uFFE5]+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		//showTip(obj,"必须输入汉字！");
  		return false;
  	}
  		if (!isLengthOf(obj,obj.v_minlength*2,obj.v_maxlength*2)){
  		//showTip(obj,"长度有错误！");
  		return false;
  	}
  	return true;
  }
  
  //匹配由26个英文字母组成的字符串
  function forA2sssz1(obj)
  {
  	var patrn = /^[A-Za-z]+$/;
  	var sInput = obj;
  	if(sInput.search(patrn)==-1){
  		//showTip(obj,"必须为字母！");
  		return false;
  	}
  	if (!isLengthOf(obj,obj.v_minlength,obj.v_maxlength)){
  		//showTip(obj,"长度有错误！");
  		return false;
  	}
  
  	return true;
  }
  

  function checkNameStr(code){
  	/*优先匹配括号*/
    if(forKuoHao(code)) return "KH";//括号
    if(forA2sssz1(code)) return "EH"; //英语
    var re2 =new RegExp("[\u0400-\u052f]");
    if(re2.test(code)) return "RU"; //俄文
    var re3 =new RegExp("[\u00C0-\u00FF]");
    if(re3.test(code)) return "FH"; //法文
    var re4 = new RegExp("[\u3040-\u30FF]");
    var re5 = new RegExp("[\u31F0-\u31FF]");
    if(re4.test(code)||re5.test(code)) return "JP"; //日文
    var re6 = new RegExp("[\u1100-\u31FF]");
    var re7 = new RegExp("[\u1100-\u31FF]");
    var re8 = new RegExp("[\uAC00-\uD7AF]");
    if(re6.test(code)||re7.test(code)||re8.test(code)) return "KR"; //韩国
    if(forHanZi1(code)) return "CH"; //汉字
    
   }

	/**** tianyang add for 中文字符限制 start ****/
	function feifaCustName(textName)
	{
		if(textName.value != "")
		{
			if(document.all.isJSX.value=="0"){
				var m = /^[\u0391-\uFFE5]+$/;
				var flag = m.test(textName.value);
				if(!flag){
					rdShowMessageDialog("只允许输入中文！");
					reSetCustName();
				}
				if(textName.value.length > 6){
					rdShowMessageDialog("只允许输入6个汉字！");
					reSetCustName();
				}
			}else{
				if((textName.value.indexOf("~")) != -1 || (textName.value.indexOf("|")) != -1 || (textName.value.indexOf(";")) != -1)
				{
					rdShowMessageDialog("不允许输入非法字符，个人开户分类请选择介绍信开户！");
					textName.value = "";
		 	  		return;
				}
			}
		}
	}
		
	function setRealUserFormat(){
  	if(document.all.r_cus[0].checked){//新建客户
  		if(document.all.isJSX.value=="1"){ //单位客户
  			/*实际使用人姓名*/
		  	document.all.realUserName.v_must = "1";
		  	/*经实际使用人地址*/
		  	document.all.realUserAddr.v_must = "1";
		  	/*实际使用人证件号码*/
		  	document.all.realUserIccId.v_must = "1";
  		}else{
  			/*实际使用人姓名*/
		  	document.all.realUserName.v_must = "0";
		  	/*经实际使用人地址*/
		  	document.all.realUserAddr.v_must = "0";
		  	/*实际使用人证件号码*/
		  	document.all.realUserIccId.v_must = "0";
  		}
  	}else{
  		
  	}
		$("#realUserInfo1").find("td:eq(0)").attr("width","13%");
  	$("#realUserInfo1").find("td:eq(0)").attr("nowrap","nowrap");
  	$("#realUserInfo1").find("td:eq(1)").attr("nowrap","nowrap");
  	$("#realUserInfo1").find("td:eq(2)").attr("width","13%");
  	$("#realUserInfo1").find("td:eq(2)").attr("nowrap","nowrap");
  	$("#realUserInfo1").find("td:eq(3)").attr("nowrap","nowrap");
  	$("#realUserInfo1").find("td:eq(3)").attr("colSpan","3");
  	
  	$("#realUserInfo2").find("td:eq(0)").attr("width","13%");
  	$("#realUserInfo2").find("td:eq(0)").attr("nowrap","nowrap");
  	$("#realUserInfo2").find("td:eq(1)").attr("nowrap","nowrap");
  	$("#realUserInfo2").find("td:eq(2)").attr("width","13%");
  	$("#realUserInfo2").find("td:eq(2)").attr("nowrap","nowrap");
  	$("#realUserInfo2").find("td:eq(3)").attr("nowrap","nowrap");
  	$("#realUserInfo2").find("td:eq(3)").attr("colSpan","3");
  	
  	//给实际使用人赋值
		$("#realUserName").val("<%=qRealUserName%>");
		$("#realUserIccId").val("<%=qRealUserIccId%>");
		$("#realUserAddr").val("<%=qRealUserAddr%>");
		if("<%=qRealUserIdType%>" != ""){
			$("#realUserIdType option").each(function(){
		    if($(this).val().indexOf("<%=qRealUserIdType%>") != -1){
		      $(this).attr("selected","true");
		    }
		  });
		}
		if("<%=qRealUserIdType%>" == "0" || "<%=qRealUserIdType%>" == ""){ //身份证，则显示读卡按钮
			$("#scan_idCard_two2").css("display","");
			$("#scan_idCard_two22").css("display","");
			$("input[name='realUserName']").attr("class","InputGrey");
			$("input[name='realUserName']").attr("readonly","readonly");
			$("input[name='realUserAddr']").attr("class","InputGrey");
			$("input[name='realUserAddr']").attr("readonly","readonly");
			$("input[name='realUserIccId']").attr("class","InputGrey");
			$("input[name='realUserIccId']").attr("readonly","readonly");
			
		}else{
			$("#scan_idCard_two2").css("display","none");
			$("#scan_idCard_two22").css("display","none");
			$("input[name='realUserName']").removeAttr("class");
			$("input[name='realUserName']").removeAttr("readonly");
			$("input[name='realUserAddr']").removeAttr("class");
			$("input[name='realUserAddr']").removeAttr("readonly");
			$("input[name='realUserIccId']").removeAttr("class");
			$("input[name='realUserIccId']").removeAttr("readonly");
		}	
	}

	function reSetCustName(){/*重置客户名称*/
		document.all.custName.value="";
		document.all.contactPerson.value="";
		
		/*20131216 gaopeng 2013/12/16 15:11:05 当选择单位开户时，展示经办人信息并将其信息设计为必填选项 start*/
  var checkVal = $("select[name='isJSX']").find("option:selected").val();
  if(checkVal == 1){
  	$("#gestoresInfo1").show();
  	$("#gestoresInfo2").show();
  	$("#sendProjectList").hide(); //下发工单按钮
		$("#qryListResultBut").hide(); //工单结果查询按钮
  	/*经办人姓名*/
  	document.all.gestoresName.v_must = "1";
  	/*经办人地址*/
  	document.all.gestoresAddr.v_must = "1";
  	/*经办人证件号码*/
  	document.all.gestoresIccId.v_must = "1";
  	var checkIdType = $("select[name='gestoresIdType']").find("option:selected").val();
  	/*身份证加入校验方法*/
  	if(checkIdType.indexOf("身份证") != -1){
  		document.all.gestoresIccId.v_type = "idcard";
			$("#scan_idCard_two3").css("display","");
			$("#scan_idCard_two31").css("display","");
  		$("input[name='gestoresName']").attr("class","InputGrey");
  		$("input[name='gestoresName']").attr("readonly","readonly");
  		$("input[name='gestoresAddr']").attr("class","InputGrey");
  		$("input[name='gestoresAddr']").attr("readonly","readonly");
  		$("input[name='gestoresIccId']").attr("class","InputGrey");
  		$("input[name='gestoresIccId']").attr("readonly","readonly");

  	}else{
  		document.all.gestoresIccId.v_type = "string";
  		$("#scan_idCard_two3").css("display","none");
  		$("#scan_idCard_two31").css("display","none");
  		$("input[name='gestoresName']").removeAttr("class");
  		$("input[name='gestoresName']").removeAttr("readonly");
  		$("input[name='gestoresAddr']").removeAttr("class");
  		$("input[name='gestoresAddr']").removeAttr("readonly");
  		$("input[name='gestoresIccId']").removeAttr("class");
  		$("input[name='gestoresIccId']").removeAttr("readonly");
  	}
  	
  	
  	//责任人信息
  	$("#responsibleInfo1").show();
  	$("#responsibleInfo2").show();

  	/*责任人人姓名*/
  	document.all.responsibleName.v_must = "1";
  	/*责任人人地址*/
  	document.all.responsibleAddr.v_must = "1";
  	/*经责任人人证件号码*/
  	document.all.responsibleIccId.v_must = "1";
  	var checkIdType22 = $("select[name='responsibleType']").find("option:selected").val();
  	/*身份证加入校验方法*/
  	if(checkIdType22.indexOf("身份证") != -1){
  		document.all.responsibleIccId.v_type = "idcard";
  		$("#scan_idCard_two3zrr").css("display","");
  		$("#scan_idCard_two57zrr").css("display","");
  		$("input[name='responsibleName']").attr("class","InputGrey");
  		$("input[name='responsibleName']").attr("readonly","readonly");
  		$("input[name='responsibleAddr']").attr("class","InputGrey");
  		$("input[name='responsibleAddr']").attr("readonly","readonly");
  		$("input[name='responsibleIccId']").attr("class","InputGrey");
  		$("input[name='responsibleIccId']").attr("readonly","readonly");  		
  		
  	}else{
  		document.all.responsibleIccId.v_type = "string";
  		$("#scan_idCard_two3zrr").css("display","none");
  		$("#scan_idCard_two57zrr").css("display","none");
  		$("input[name='responsibleName']").removeAttr("class");
  		$("input[name='responsibleName']").removeAttr("readonly");
  		$("input[name='responsibleAddr']").removeAttr("class");
  		$("input[name='responsibleAddr']").removeAttr("readonly");
  		$("input[name='responsibleIccId']").removeAttr("class");
  		$("input[name='responsibleIccId']").removeAttr("readonly");  		
  		
  	}
  	
  	
  	
  }
  /*没选择单位客户的时候，均不展示并设置为不需要必填选项*/
  else{
  	$("#gestoresInfo1").hide();
  	$("#gestoresInfo2").hide();
  	/*经办人姓名*/
  	document.all.gestoresName.v_must = "0";
  	/*经办人地址*/
  	document.all.gestoresAddr.v_must = "0";
  	/*经办人证件号码*/
  	document.all.gestoresIccId.v_must = "0";
  	
  	//责任人信息
  	$("#responsibleInfo1").hide();
  	$("#responsibleInfo2").hide();

  	/*责任人人姓名*/
  	document.all.responsibleName.v_must = "0";
  	/*责任人人地址*/
  	document.all.responsibleAddr.v_must = "0";
  	/*经责任人人证件号码*/
  	document.all.responsibleIccId.v_must = "0";   	
  	
  	
  }
  /*20131216 gaopeng 2013/12/16 15:11:05 当选择单位开户时，展示经办人信息并将其信息设计为必填选项 end*/
  
		getIdTypes();
		/* begin add 如 m058+普通开户+身份证+社会渠道工号+开关+开展地市，则显示“下发工单”按钮 for 关于电话用户实名登记近期重点工作的通知 @2014/11/4 */
	  if(checkVal == 0){
			var idTypeSelect = $("#idType option[@selected]").val();//证件类型：身份证
			if(idTypeSelect.indexOf("|") != -1){
				var v_idTypeSelect = idTypeSelect.split("|")[0];
				if(v_idTypeSelect == "0" && "<%=workChnFlag%>" == "1" && "<%=opCode%>" == "m058" && (parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){
					$("#sendProjectList").show();
					$("#qryListResultBut").show();
				}else{
					$("#sendProjectList").hide();
					$("#qryListResultBut").hide();
				}
			}
	  }
	  /* end add for 关于电话用户实名登记近期重点工作的通知 @2014/11/4 */	
	  /* begin update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
	  var idTypeSelect2 = $("#idType option[@selected]").val();//证件类型：身份证
	  if("<%=opCode%>" == "m058"){
	  	if(idTypeSelect2.indexOf("|") != -1){
	  		var v_idTypeSelect2 = idTypeSelect2.split("|")[0];
	  		if(v_idTypeSelect2 == "0"){ //身份证
					if("<%=workChnFlag%>" != "1"){ //自有营业厅
						$("#idIccid").attr("class","InputGrey");
						$("#idIccid").attr("readonly","readonly");
						$("#custName").attr("class","InputGrey");
						$("#custName").attr("readonly","readonly");
						$("#idAddr").attr("class","InputGrey");
						$("#idAddr").attr("readonly","readonly");
						$("#idValidDate").attr("class","InputGrey");
						$("#idValidDate").attr("readonly","readonly");
						$("#idIccid").val("");
						$("#custName").val("");
						$("#idAddr").val("");
						$("#idValidDate").val("");
					}else{ //社会渠道
						if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //集团公司查验开关为“开”+地市开关为“开”时
							$("#idIccid").attr("class","InputGrey");
							$("#idIccid").attr("readonly","readonly");
							$("#custName").attr("class","InputGrey");
							$("#custName").attr("readonly","readonly");
							$("#idAddr").attr("class","InputGrey");
							$("#idAddr").attr("readonly","readonly");
							$("#idValidDate").attr("class","InputGrey");
							$("#idValidDate").attr("readonly","readonly");
							$("#idIccid").val("");
							$("#custName").val("");
							$("#idAddr").val("");
							$("#idValidDate").val("");
						}
					}
	  		}else{
	  			if("<%=workChnFlag%>" != "1"){ //自有营业厅
						$("#idIccid").removeAttr("class");
						$("#idIccid").removeAttr("readonly");
						$("#custName").removeAttr("class");
						$("#custName").removeAttr("readonly");
						$("#idAddr").removeAttr("class");
						$("#idAddr").removeAttr("readonly");
						$("#idValidDate").removeAttr("class");
						$("#idValidDate").removeAttr("readonly");
					}else{ //社会渠道
						if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //集团公司查验开关为“开”+地市开关为“开”时
							$("#idIccid").removeAttr("class");
							$("#idIccid").removeAttr("readonly");
							$("#custName").removeAttr("class");
							$("#custName").removeAttr("readonly");
							$("#idAddr").removeAttr("class");
							$("#idAddr").removeAttr("readonly");
							$("#idValidDate").removeAttr("class");
							$("#idValidDate").removeAttr("readonly");
						}
					}
	  		}
				/* end update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */		
			}
	  }
	 	setRealUserFormat();	  
	}
	/*2013/11/07 21:14:36 gaopeng 关于实名制工作需求整合的函*/
function getIdTypes(){
	 var checkVal = $("select[name='isJSX']").find("option:selected").val();
	 //alert(checkVal);
   var getdataPacket = new AJAXPacket("/npage/sq100/fq100GetIdTypes.jsp","正在获得数据，请稍候......");
			
			getdataPacket.data.add("checkVal",checkVal);
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("opName","<%=opName%>");
			core.ajax.sendPacketHtml(getdataPacket,resIdTypes);
			getdataPacket = null;
	
}
function resIdTypes(data){
			//找到添加的select
				var markDiv=$("#tdappendSome"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
 
}
	/**** tianyang add for 中文字符限制 end ****/


	function change_ConPerson()
	{   //联系人姓名随客户名称改名而改变
		document.all.contactPerson.value = document.all.custName.value;
	}
	function change_ConAddr()
	{   //联系人姓名随客户名称改名而改变
		document.all.contactAddr.value = document.all.custAddr.value;
		document.all.contactMAddr.value = document.all.custAddr.value;
		checkElement(document.all.contactAddr);
	}
	function change_idType(chgFlag)
	{
	  var Str = document.all.idType.value;
	  
	  /* begin diling update for 关于增加开户界面客户登记信息验证功能的函@2013/9/22 */
    
      checkCustNameFunc16New(document.all.custName,0,1); //校验客户名称是否符合
      if(Str.indexOf("军官证") > -1){
  	    $("#idAddrDiv").text("证件地址(部别)");
  	  }else{
  	    $("#idAddrDiv").text("证件地址");
  	  }
    
	  /* end diling update@2013/9/22 */
		if(Str.indexOf("0") > -1||Str.indexOf("D") > -1)
		{   document.all.idIccid.v_type = "idcard";  
				document.all("card_id_type").style.display="";
				/* begin add 如 m058+普通开户+身份证+社会渠道工号+开关，则显示“下发工单”按钮 for 关于电话用户实名登记近期重点工作的通知 @2014/11/19 */
				var checkVal = document.all.isJSX.value;//个人开户分类 普通客户：0
				if(checkVal == "0" && "<%=workChnFlag%>" == "1" && "<%=opCode%>" == "m058" && (parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){
					$("#sendProjectList").show();
					$("#qryListResultBut").show();
				}else{
					$("#sendProjectList").hide();
					$("#qryListResultBut").hide();
				}
				/* end add for 关于电话用户实名登记近期重点工作的通知 @2014/11/19 */
				/* begin update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
				if("<%=opCode%>" == "m058"){
					if("<%=workChnFlag%>" != "1"){ //自有营业厅
						$("#idIccid").attr("class","InputGrey");
						$("#idIccid").attr("readonly","readonly");
						$("#custName").attr("class","InputGrey");
						$("#custName").attr("readonly","readonly");
						$("#idAddr").attr("class","InputGrey");
						$("#idAddr").attr("readonly","readonly");
						$("#idValidDate").attr("class","InputGrey");
						$("#idValidDate").attr("readonly","readonly");
						if(chgFlag == "1"){
							$("#idIccid").val("");
							$("#custName").val("");
							$("#idAddr").val("");
							$("#idValidDate").val("");
						}
					}else{ //社会渠道
						if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //集团公司查验开关为“开”+地市开关为“开”时
							$("#idIccid").attr("class","InputGrey");
							$("#idIccid").attr("readonly","readonly");
							$("#custName").attr("class","InputGrey");
							$("#custName").attr("readonly","readonly");
							$("#idAddr").attr("class","InputGrey");
							$("#idAddr").attr("readonly","readonly");
							$("#idValidDate").attr("class","InputGrey");
							$("#idValidDate").attr("readonly","readonly");
							if(chgFlag == "1"){
								$("#idIccid").val("");
								$("#custName").val("");
								$("#idAddr").val("");
								$("#idValidDate").val("");
							}
						}
					}
				}
				/* end update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */		
		 }
		else
		{   document.all.idIccid.v_type = "string";   
				document.all("card_id_type").style.display="none";
				$("#sendProjectList").hide(); //下发工单按钮
				$("#qryListResultBut").hide(); //工单结果查询按钮
				/* begin update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
				if("<%=opCode%>" == "m058"){
					if("<%=workChnFlag%>" != "1"){ //自有营业厅
						$("#idIccid").removeAttr("class");
						$("#idIccid").removeAttr("readonly");
						$("#custName").removeAttr("class");
						$("#custName").removeAttr("readonly");
						$("#idAddr").removeAttr("class");
						$("#idAddr").removeAttr("readonly");
						$("#idValidDate").removeAttr("class");
						$("#idValidDate").removeAttr("readonly");
					}else{ //社会渠道
						if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //集团公司查验开关为“开”+地市开关为“开”时
							$("#idIccid").removeAttr("class");
							$("#idIccid").removeAttr("readonly");
							$("#custName").removeAttr("class");
							$("#custName").removeAttr("readonly");
							$("#idAddr").removeAttr("class");
							$("#idAddr").removeAttr("readonly");
							$("#idValidDate").removeAttr("class");
							$("#idValidDate").removeAttr("readonly");
						}
					}
				}
				/* end update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */		
		}
		

		
		
	}

	function chkValid()
	{
		 var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());

		 if(jtrim(document.all.idValidDate.value).length>0)
		 {
			if(forDate(document.all.idValidDate)==false) return false;

			if(to_date(document.all.idValidDate)<=d)
			{
			  rdShowMessageDialog("证件有效期不能早于当前时间，请重新输入！");
			  document.all.idValidDate.focus();
			  document.all.idValidDate.select();
			  return false;
			}
		}
	}

	/********校验日期的合法性**********/
	function to_date(obj)
{
  var theTotalDate="";
  var one="";
  var flag="0123456789";
  for(i=0;i<obj.value.length;i++)
  {
     one=obj.value.charAt(i);
     if(flag.indexOf(one)!=-1)
		 theTotalDate+=one;
  }
  return theTotalDate;
}

	function chgCustType()
	{
	  if(document.all.r_cus[0].checked)
	  {
			getIdTypes();
		  var divPassword = document.getElementById("divPassword");
		  var divCustPad1 = document.getElementById("divCustPad1");
		  var divCustPad2 = document.getElementById("divCustPad2");

		  if("09" == "<%=regionCode%>")
		  {
		  	divPassword.style.display="none";
		  	divCustPad1.style.display="none";
		  	divCustPad2.style.display="none";
		  }

		  frm.reset();

		  document.all.tr_qryCondition.style.display="none";
		  document.all.tr_iccid.style.display="none";
		  document.all.tr_srvno.style.display="none";
		  document.all.new_cus_id.readOnly=true;
		  document.all.new_cus_id.className="InputGrey";
		  document.all.b_chkId.style.display="none";
      document.all.r_cus[0].checked=true;
		  getId();
		  document.all.districtCode.focus();
		  /* begin add 如 m058+普通开户+身份证+社会渠道工号+开关+开展地市，则显示“下发工单”按钮 for 关于电话用户实名登记近期重点工作的通知 @2014/11/19 */
		  if("<%=opCode%>" == "m058"){
		  	var checkVal = $("select[name='isJSX']").find("option:selected").val();//个人开户分类 普通客户：0
				$("#idType").find("option").eq(0).attr("selected","selected");
				var idTypeSelect = $("#idType").find("option:selected").val();//证件类型：身份证
				if(idTypeSelect.indexOf("|") != -1){
					var v_idTypeSelect = idTypeSelect.split("|")[0];
					if(checkVal == "0" && v_idTypeSelect == "0" && "<%=workChnFlag%>" == "1" && (parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){
						$("#sendProjectList").show();
						$("#qryListResultBut").show();
					}
					/* begin update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
					if(v_idTypeSelect == "0"){//身份证
						if("<%=workChnFlag%>" != "1"){ //自有营业厅
							$("#idIccid").attr("class","InputGrey");
							$("#idIccid").attr("readonly","readonly");
							$("#custName").attr("class","InputGrey");
							$("#custName").attr("readonly","readonly");
							$("#idAddr").attr("class","InputGrey");
							$("#idAddr").attr("readonly","readonly");
							$("#idValidDate").attr("class","InputGrey");
							$("#idValidDate").attr("readonly","readonly");
							$("#idIccid").val("");
							$("#custName").val("");
							$("#idAddr").val("");
							$("#idValidDate").val("");
						}else{ //社会渠道
							if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //集团公司查验开关为“开”+地市开关为“开”时
								$("#idIccid").attr("class","InputGrey");
								$("#idIccid").attr("readonly","readonly");
								$("#custName").attr("class","InputGrey");
								$("#custName").attr("readonly","readonly");
								$("#idAddr").attr("class","InputGrey");
								$("#idAddr").attr("readonly","readonly");
								$("#idValidDate").attr("class","InputGrey");
								$("#idValidDate").attr("readonly","readonly");
								$("#idIccid").val("");
								$("#custName").val("");
								$("#idAddr").val("");
								$("#idValidDate").val("");
							}
						}
					}
					/* end update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */	
				}
		  }
		  /* end add for 关于电话用户实名登记近期重点工作的通知 @2014/11/19 */
		  $("#gestoresInfo1").hide();
	  	$("#gestoresInfo2").hide();
	  	/*经办人姓名*/
	  	document.all.gestoresName.v_must = "0";
	  	/*经办人地址*/
	  	document.all.gestoresAddr.v_must = "0";
	  	/*经办人证件号码*/
	  	document.all.gestoresIccId.v_must = "0";
	  	
	  	
  	//责任人信息
  	$("#responsibleInfo1").hide();
  	$("#responsibleInfo2").hide();

  	/*责任人人姓名*/
  	document.all.responsibleName.v_must = "0";
  	/*责任人人地址*/
  	document.all.responsibleAddr.v_must = "0";
  	/*经责任人人证件号码*/
  	document.all.responsibleIccId.v_must = "0";  	  	
	  	
	  	
	  	
	  }else if(document.all.r_cus[1].checked){ //已有客户

		  var divPassword = document.getElementById("divPassword");
  		  var divCustPad1 = document.getElementById("divCustPad1");
		  var divCustPad2 = document.getElementById("divCustPad2");

		  divPassword.style.display="";
		  divCustPad1.style.display="";
		  divCustPad2.style.display="";

		  frm.reset();
		  document.all.r_cus[1].checked=true;
		  document.all.tr_qryCondition.style.display="";
		  document.all.tr_iccid.style.display="";
		  document.all.tr_srvno.style.display="";
		  document.all.new_cus_id.readOnly=false;
		  document.all.new_cus_id.className=" ";
		  document.all.b_chkId.style.display="";
		  document.all.tr_newCust.style.display="none";
		  chgCon();
		  
			$("#sendProjectList").hide(); //下发工单按钮
			$("#qryListResultBut").hide(); //工单结果查询按钮
	  }
	  setRealUserFormat();	  
	}

	function chgCon()
	{
		if(document.all.r_con[0].checked)     //手机号码
		{
			/* begin add for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/13 */
			if("<%=opCode%>" == "m058"){
				//2-判断是否有优惠权限
				var oldFav_a971 = <%=oldFav_a971%>;
				if(!oldFav_a971){ //无权限，则不允许办理
					rdShowMessageDialog("工号没有并老客户权限，不允许办理“并老客户”业务！请新建客户！",1);
					document.all.r_cus[0].checked = true;
					chgCustType();
					return  false;
				}else{//有权限，则可以进行并老户 服务号码+客户ID 的过户操作
				}
			}
			/* end add for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/13 */
			document.all.tr_srvno.style.display="";
			document.all.tr_iccid.style.display="none";
			document.all.new_srv_no.value="";
			document.all.new_cus_id.value="";
			document.all.new_srv_no.focus();
		}
		else if(document.all.r_con[1].checked)       //证件号码
		{
			document.all.tr_srvno.style.display="none";
			document.all.tr_iccid.style.display="";
			document.all.id_no.value="";
			document.all.new_cus_id.value="";
			document.all.id_type.focus();
		}
		else if(document.all.r_con[2].checked)      //客户ID
		{
			document.all.tr_srvno.style.display="none";
			document.all.tr_iccid.style.display="none";
			document.all.new_cus_id.value="";
			document.all.new_cus_id.focus();
		}
	}

	function getAllId_No(){
   if(jtrim(document.all.id_no.value).length<1)
   {
     rdShowMessageDialog("证件号码不能为空！");
 	 	 return;
   }

   if(jtrim(document.all.id_type.value)=="1")
   {
   	 
     if(!forIdCard(document.all.id_no)){
	  		return false;
	  	}
	  //liujian 2013-5-15 10:03:02 身份证号是18位
	  	if(document.all.id_no.value.length != 18){
	  		rdShowMessageDialog("身份证号码必须是18位！");
	  		return false;
	  	}	
	  	
   }

   var h=400;
   var w=600;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
   var ret=window.showModalDialog("AllId_No.jsp?id_no="+document.all.id_no.value+"&id_type=" +document.all.id_type.value,"",prop);

   if(typeof(ret)!="undefined")
   {
		 document.all.new_cus_id.value=ret;
	 	 document.all.new_cus_id.focus();
	 	 document.all.new_cus_id.select();
		 rpc_chkX_2("id_type","id_no","A","chkX_1");
   }else{
     rdShowMessageDialog("您必须选择一个客户ID！");
	 	 document.all.id_no.select();
     document.all.id_no.focus();
   }
 }



  function getOneId()
  {
    if(jtrim(document.all.new_srv_no.value).length<1)
	{
      rdShowMessageDialog("服务号码不能为空！");
 	  	return;
	}
	if(forMobil(document.all.new_srv_no)==false) return;

   	var myPacket = new AJAXPacket("qryCus_id.jsp","正在查询客户ID，请稍候......");
		myPacket.data.add("phoneNo",jtrim(document.all.new_srv_no.value));
		core.ajax.sendPacket(myPacket);
		myPacket = null;
  }
  /* update “信誉度”内容不可见（包括已有老户和新建客户） for 关于哈分公司申请优化M058实名制登记信誉度清零问题的请示@2015/2/11
  function checkXi()
  {
  	if(frm.xinYiDu.value>0)
	{
	  rdShowMessageDialog("信誉度不能大于零！");
 	  return;
	}
  }
  */
//---------------add by baixf 20080221 需求039 新增客户时可以查询录入的身份证在系统中的使用信息。
function getInfo_IccId_JustSee()
{
	/*
    var Str = document.all.idType.value;
    
      if(Str.indexOf("身份证") > -1){
        if($("#idIccid").val().length<18){
          rdShowMessageDialog("身份证号码必须是18位！");
          document.all.idIccid.focus();
          return false;
        }
      }
   */ 
    //根据客户证件号码得到相关信息
    if(jtrim(document.frm.idIccid.value).length == 0)
    {
        rdShowMessageDialog("请输入客户证件号码！");
        return false;
    }
    /*
	else if(jtrim(document.frm.idIccid.value).length < 5)
	{
        rdShowMessageDialog("证件号码长度有误（最少五位）！");
        return false;
	}
	*/
    var pageTitle = "客户信息查询";
    var fieldName = "手机号码|开户时间|证件类型|证件号码|归属地|状态|";
    var sqlStr = " ";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
    custInfoQueryJustSee(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}
		//--------------------add by baixf 20080221 需要039
		function custInfoQueryJustSee(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
		{
		    /*
		    参数1(pageTitle)：查询页面标题
		    参数2(fieldName)：列中文名称，以'|'分隔的串
		    参数3(sqlStr)：sql语句
		    参数4(selType)：类型1 rediobutton 2 checkbox
		    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
		    参数6(retToField))：返回值存放域的名称,以'|'分隔
		    */
		var custnamess=document.all.custName.value.trim();
		var idTypesss="";
		var idTypeSelect = $("#idType option[@selected]").val();//证件类型
		if(idTypeSelect.indexOf("|") != -1){
			  idTypesss = idTypeSelect.split("|")[0];
			  if(idTypesss=="0") {//身份证
				    if(custnamess.len() == 0)
				    {
				        //rdShowMessageDialog("请输入客户名称后再进行信息查询！");
				        //return false;
				    }
			   }   
    }

    var path = "/npage/sq100/getPhoneNumInner.jsp";
    path = path + "?idIccid=" + document.frm.idIccid.value.trim()+"&idtype="+idTypesss+"&custnames="+custnamess+"&opcode=m058";
    window.showModalDialog(path,"","dialogWidth:30;dialogHeight:15;");
    
		}

		/***add by zhanghonga@20080911去掉字符串两端的空格,使用了新式的正则表达式验证.***/
		function jtrim(str){
			return str.replace( /^\s*/, "" ).replace( /\s*$/, "" );
    }


  /***验证黑名单的函数***/
  function rpc_chkX_2(x_type,x_no,chk_kind,retFlag)
{
	  var obj_type=document.all(x_type);
	  var obj_no=document.all(x_no);
	  var idname="";
	  if(obj_type.type=="text")
	  {
	    idname=jtrim(obj_type.value);
	  }
	  else if(obj_type.type=="select-one")
	  {
	    idname=jtrim(obj_type.options[obj_type.selectedIndex].text);
	  }

	  
			return;
		

		  var myPacket = new AJAXPacket("/npage/innet/chkX.jsp","正在验证黑名单信息，请稍候......");
		  myPacket.data.add("retType",retFlag);
		  myPacket.data.add("retObj",x_no);
		  myPacket.data.add("x_idType",getX_idno(idname));
		  myPacket.data.add("x_idNo",obj_no.value);
		  myPacket.data.add("x_chkKind",chk_kind);
		  core.ajax.sendPacket(myPacket);
		  myPacket = null;
	}

	/***验证黑名单的函数中调用此函数***/
			function getX_idno(xx)
		{
		  if(xx==null) return "0";

		  if(xx=="身份证") return "0";
		  else if(xx=="军官证") return "1";
		  else if(xx=="驾驶证") return "2";
		  else if(xx=="警官证") return "4";
		  else if(xx=="学生证") return "5";
		  else if(xx=="单位") return "6";
		  else if(xx=="校园") return "7";
		  else if(xx=="营业执照") return "8";
		  else return "0";
		}

		//dujl add at 20100415 for 身份证校验
function checkIccId()
{
	<%if(isshehuiworkno.equals("yes")) {%>
		rdShowMessageDialog("您工号所属营业厅为合作厅，权限受限！");
		return false;
	<%}%>
	document.all.iccIdCheck.disabled=true;
	var myPacket = new AJAXPacket("/npage/innet/fIccIdCheck.jsp","正在验证身份证信息，请稍候......");
	myPacket.data.add("retType","iccIdCheck");
	myPacket.data.add("idIccid",document.all.ic_no.value);
	myPacket.data.add("custName",document.all.cust_name.value);
	myPacket.data.add("IccIdAccept",document.all.loginAccept.value);
	myPacket.data.add("opCode",document.all.opCode.value);
	myPacket.data.add("phoneNo","<%=srv_no%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
	document.all.iccIdCheck.disabled=false;
}

//dujl add at 20100421 for 身份证校验
// 获取身份证照片
function getPhoto()
{
	window.open("../innet/fgetIccIdPhoto.jsp?idIccid="+document.all.ic_no.value,"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-500) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
}

function checkIccId1()
{
	<%if(isshehuiworkno.equals("yes")) {%>
		rdShowMessageDialog("您工号所属营业厅为合作厅，权限受限！");
		return false;
	<%}%>
	
	if(document.all.idType.value.split("|")[0] != "0")
	{
		rdShowMessageDialog("只有身份证可以校验！");
		return false;
	}
	if(document.all.custName.value.trim() == "")
	{
		rdShowMessageDialog("请先输入客户名称！");
		return false;
	}
	if(document.all.idIccid.value.trim() == "")
	{
		rdShowMessageDialog("请先输入证件号码！");
		return false;
	}
	var Str = document.all.idType.value;
  
    if(Str.indexOf("身份证") > -1){
      if($("#idIccid").val().length<18){
        rdShowMessageDialog("身份证号码必须是18位！");
        document.all.idIccid.focus();
        return false;
      }
    }
  

	document.all.iccIdCheck1.disabled=true;
	var myPacket = new AJAXPacket("/npage/innet/fIccIdCheck.jsp","正在验证身份证信息，请稍候......");
	myPacket.data.add("retType","iccIdCheck1");
	myPacket.data.add("idIccid",document.all.idIccid.value);
	myPacket.data.add("custName",document.all.custName.value);
	myPacket.data.add("IccIdAccept",document.all.loginAccept.value);
	myPacket.data.add("opCode",document.all.opCode.value);
	myPacket.data.add("phoneNo","<%=srv_no%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
	document.all.iccIdCheck1.disabled=false;
}

//dujl add at 20100421 for 身份证校验
// 获取身份证照片
function getPhoto1()
{
	window.open("../innet/fgetIccIdPhoto.jsp?idIccid="+document.all.idIccid.value,"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-500) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
}

function chkPwdEasy1(pwd){
	if(pwd == ""){
		rdShowMessageDialog("请先输入密码！");
		return ;
	}
	var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","正在验证密码是否过于简单，请稍候......");
	checkPwd_Packet.data.add("password", pwd);
	checkPwd_Packet.data.add("phoneNo", "<%=phone_no%>");
	checkPwd_Packet.data.add("idNo", frm.idIccid.value);
	checkPwd_Packet.data.add("custId", "");

	core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy1);
	checkPwd_Packet=null;
}

function doCheckPwdEasy1(packet) {
	var retResult = packet.data.findValueByName("retResult");
	if (retResult == "1") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为相同数字类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "2") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为连号类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "3") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为手机号码中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "4") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为证件中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "0") {
		//rdShowMessageDialog("校验成功！密码可用！");
	}
}
function chkPwdEasy(pwd){
	if(pwd == ""){
		rdShowMessageDialog("请先输入密码！");
		return ;
	}
	var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","正在验证密码是否过于简单，请稍候......");
	checkPwd_Packet.data.add("password", pwd);
	checkPwd_Packet.data.add("phoneNo", "<%=phone_no%>");
	checkPwd_Packet.data.add("idNo", frm.idIccid.value);
	checkPwd_Packet.data.add("custId", "");

	core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy);
	checkPwd_Packet=null;
}



function doCheckPwdEasy(packet) {
	var retResult = packet.data.findValueByName("retResult");
	if (retResult == "1") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为相同数字类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "2") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为连号类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "3") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为手机号码中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "4") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为证件中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		document.frm.custPwd.value="";
		document.frm.cfmPwd.value="";
		return;
	} else if (retResult == "0") {
		//rdShowMessageDialog("校验成功！密码可用！");
		continueCfm();
	}
}

function continueCfm() {
	
	if("<%=realOpCode%>" == "m389"){
		document.all.t_sys_remark.value="用户"+jtrim(document.all.cust_name.value)+"进行批量实名登记";
		document.all.t_op_remark.value="操作员<%=work_no%>"+"进行批量实名登记。此号码所有业务实名登记后均保留。"
		document.all.assuNote.value="操作员<%=work_no%>"+"进行批量实名登记。此号码所有业务实名登记后均保留。"
		if(rdShowConfirmDialog('确认要提交批量实名登记信息吗？')==1)
	  {
	   conf();
	   return;
	  }
	}
			if(document.all.r_cus[0].checked)
	  {
	      document.all.t_sys_remark.value="用户"+jtrim(document.all.cust_name.value)+"实名登记到"+document.all.custName.value;
	     }else{
	     document.all.t_sys_remark.value="用户"+jtrim(document.all.cust_name.value)+"实名登记到"+document.all.h_custName.value;
	     }

	      if(jtrim(document.all.t_op_remark.value).length==0)
          {
          	if("<%=isKd%>" == "true"){
          		document.all.t_op_remark.value="操作员<%=work_no%>"+"对用户宽带<%=kdNo%>进行实名登记。此号码所有业务实名登记后均保留。"
          	}else{
          		document.all.t_op_remark.value="操作员<%=work_no%>"+"对用户手机"+jtrim(document.all.srv_no.value)+"进行实名登记。此号码所有业务实名登记后均保留。"
          	}
			  
	      }
		  if(jtrim(document.all.assuNote.value).length==0)
          {
          	if("<%=isKd%>" == "true"){
          		document.all.assuNote.value="操作员<%=work_no%>"+"对用户宽带<%=kdNo%>进行实名登记。此号码所有业务实名登记后均保留。"
          	}else{
          		document.all.assuNote.value="操作员<%=work_no%>"+"对用户手机"+jtrim(document.all.srv_no.value)+"进行实名登记。此号码所有业务实名登记后均保留。"
          	}
          	
			  
	      }


		 //显示打印对话框
		  var h=210;
		  var w=400;
		  var t=screen.availHeight/2-h/2;
		  var l=screen.availWidth/2-w/2;
		  var pType="subprint";
	    var billType="1";

	    var mode_code="<%=mode_code%>";
	 		var fav_code=null;
	 		var area_code=null

		  var sysAccept = document.all.loginAccept.value;

		  var printStr = printInfo("Detail");
		  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no;	scrollbars:yes; resizable:no;location:no;status:no;help:no"
				/* ningtn */
				var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
				var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
				/* ningtn */
		  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + "确实要进行电子免填单打印吗？"+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
  	  var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=srv_no%>&loginacceptJT="+$("#loginacceptJT").val()+"&submitCfm=" + "Yes"+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

  	  var ret=window.showModalDialog(path,printStr,prop);

		  if(typeof(ret)!="undefined")
		  {
			if((ret=="confirm"))
			{
			  if(rdShowConfirmDialog('确认电子免填单吗？')==1)
			  {
			   conf();
			  }
		    }
		    if(ret=="continueSub")
		    {
			  if(rdShowConfirmDialog('确认要提交实名登记信息吗？')==1)
			  {
			   conf();
			  }
    		}
		  }
		  else
		  {
			  if(rdShowConfirmDialog('确认要提交实名登记信息吗？')==1)
			  {
			   conf();
			  }
		  }
}

function chcek_pic1121()//二代证
{
	
var pic_path = document.all.filep.value;
	
var d_num = pic_path.indexOf("\.");
var file_type = pic_path.substring(d_num+1,pic_path.length);
//判断是否为jpg类型 //厂家设备生成图片固定为jpg类型
if(file_type.toUpperCase()!="JPG")
{ 
		rdShowMessageDialog("请选择jpg类型图像文件");
		document.all.up_flag.value=3;
		//document.all.print.disabled=true;
		resetfilp();
	return ;
	}

	var pic_path_flag= document.all.pic_name.value;
	
	if(pic_path_flag=="")
	{
	rdShowMessageDialog("请先扫描或读取证件信息");
	document.all.up_flag.value=4;
	//document.all.print.disabled=true;
	resetfilp();
	return;
}
	else
		{
			if(pic_path!=pic_path_flag)
			{
			rdShowMessageDialog("请选择最后一次扫描或读取证件而生成的证件图像文件"+pic_path_flag);
			document.all.up_flag.value=5;
			//document.all.print.disabled=true;
			resetfilp();
		return;
		}
		else{
			document.all.up_flag.value=2;
			document.all.uploadpic_b.disabled=false;//二代证
			}
			}
			
	}
	
	function uploadpic(){//二代证
	
	if(document.all.filep.value==""){
		rdShowMessageDialog("请选择要上传的图片",0);
		return;
		}
	if(document.all.but_flag.value=="0"){
		rdShowMessageDialog("请先扫描或读取图片",0);
		return;
		}
	frm.target="upload_frame";
	document.frm.encoding="multipart/form-data";
	var actionstr ="s1238Main_uppic.jsp?custId="+document.frm.custId.value+
									"&regionCode="+document.frm.regionCode.value+
									"&filep_j="+document.all.filep.value+
									"&card_flag="+document.all.card_flag.value+ 
									"&but_flag="+document.all.but_flag.value+
									"&idSexH="+document.all.idSexH.value+
									"&custName="+document.all.custName.value+
									"&idAddrH="+document.all.idAddrH.value.replace(new RegExp("#","gm"),"%23")+
									"&birthDayH="+document.all.birthDayH.value+
									"&custId="+document.all.custId.value+
									"&idIccid="+document.all.idIccid.value+
									"&workno="+document.all.workno.value+
									"&zhengjianyxq="+document.all.idValidDate.value+
									"&upflag=1";
									
	frm.action = actionstr; 
	document.all.upbut_flag.value="1";
	frm.submit();
	resetfilp();
	frm.target="_self";
	document.frm.encoding="application/x-www-form-urlencoded";
	}
	
	function resetfilp(){//二代证
		document.getElementById("filep").outerHTML = document.getElementById("filep").outerHTML;
		}
		
		function changeCardAddr(obj){

		document.all.custAddr.value=obj.value;
		document.all.contactAddr.value=obj.value;
		document.all.contactMAddr.value=obj.value;
	
}

function pubM032Cfm(){
	/*2015/8/19 16:12:01 gaopeng 关于修改BOSS系统实名判断条件及在经分系统中增加全省实名补登记日报表的函-补充需求
					在这里调用服务 sM032Cfm 
				*/
				
				var myPacket = new AJAXPacket("/npage/public/pubM032Cfm.jsp","正在查询信息，请稍候......");
			  myPacket.data.add("idSexH",document.all.idSexH.value);
			  myPacket.data.add("custName",document.all.custName.value);
			  myPacket.data.add("idAddrH",document.all.idAddrH.value.replace(new RegExp("#","gm"),"%23"));
			  myPacket.data.add("birthDayH",document.all.birthDayH.value);
			  myPacket.data.add("custId",document.all.custId.value);
			  myPacket.data.add("idIccid",document.all.idIccid.value);
			  myPacket.data.add("zhengjianyxq",document.all.idValidDate.value);
			  myPacket.data.add("opCode","<%=opCode%>");
			  
			  core.ajax.sendPacket(myPacket,function(packet){
			  	var retCode=packet.data.findValueByName("retCode");
				  var retMsg=packet.data.findValueByName("retMsg");
				  
				  if(retCode == "000000"){
				  	//document.all.uploadpic_b.disabled=false;
				 	}else{
				 		//rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,0);
				 		//document.all.uploadpic_b.disabled=true;
						//return  false;
				 	}
		 		});
				myPacket = null;
}

function changeCardAddr1(obj){
  var Str = document.all.idType.value;
  
    if((Str.indexOf("身份证") > -1)||(Str.indexOf("户口簿") > -1)){
      if(obj.value.length<8){
        rdShowMessageDialog("要求8个及以上汉字！请重新输入！");
        obj.focus();
  			return false;
      }
    }
  
  document.all.custAddr.value=obj.value;
	document.all.contactAddr.value=obj.value;
	document.all.contactMAddr.value=obj.value;
	checkElement(document.all.contactAddr);
}

function scheckandread() {
			Idcardss();
			//alert(document.all.idIccid.value);	
			var myPacket = new AJAXPacket("addReadcardsum_1238.jsp","正在获得系统时间，请稍候......");
			myPacket.data.add("srv_no","<%=srv_no%>");
			myPacket.data.add("liushuihao","<%=loginAccept%>");
			myPacket.data.add("idIccid",document.all.idIccid.value);
			core.ajax.sendPacket(myPacket,sreturncodes);
			myPacket = null;
	
}
		function sreturncodes(packet)
     	{
					var retcodes = packet.data.findValueByName("retcode");
					var retmsgs = packet.data.findValueByName("retmsg");
					if(retcodes=="000000"){
							
					}else {
					rdShowMessageDialog("记录读卡次数出错！错误代码："+retcodes+"错误信息："+retmsgs);
					}
					
     	}
     	
     	//下发工单
		  function sendProLists(){
				var packet = new AJAXPacket("/npage/sq100/fq100_ajax_sendProLists.jsp","正在获得数据，请稍候......");
				packet.data.add("opCode","<%=opCode%>");
				packet.data.add("phoneNo","<%=srv_no%>");
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
					$("#custName").val(ret.split("~")[0]); //客户姓名
					$("#idIccid").val(ret.split("~")[1]); //证件号码
					if($("#idIccid").val() != ""){
						checkIccIdFunc16New(document.all.idIccid,0,0);
						rpc_chkX('idType','idIccid','A');
					}
					$("#idAddr").val(ret.split("~")[2]);  //证件地址
					$("input[name='custAddr']").val(ret.split("~")[2]); //客户地址
					$("input[name='contactAddr']").val(ret.split("~")[2]); //联系人地址
					$("input[name='contactMAddr']").val(ret.split("~")[2]); //联系人通讯地址
					$("#idValidDate").val(ret.split("~")[3]); //证件有效期
					$("#loginacceptJT").val(ret.split("~")[4]); //集团流水
					
					$("#idIccid").attr("class","InputGrey");
		  		$("#idIccid").attr("readonly","readonly");
		  		$("#custName").attr("class","InputGrey");
		  		$("#custName").attr("readonly","readonly");
		  		$("#idAddr").attr("class","InputGrey");
		  		$("#idAddr").attr("readonly","readonly");
		  		$("#idValidDate").attr("class","InputGrey");
		  		$("#idValidDate").attr("readonly","readonly");
				}
			}  
			
			//只需要将table增加一个vColorTr='set' 属性就可以隔行变色
			$("table[vColorTr='set']").each(function(){
				$(this).find("tr").each(function(i,n){
					$(this).bind("mouseover",function(){
						$(this).addClass("even_hig");
					});
				
					$(this).bind("mouseout",function(){
						$(this).removeClass("even_hig");
					});
				
					if(i%2==0){
						$(this).addClass("even");
					}
				});
			});
			
$(document).ready(function(){
	
	/*模糊验证进来的隐藏 同时 宽带号码进来的隐藏 其他的都不隐藏 24个月*/
	
	if("<%=is_Z_flag%>"=="true" || "<%=isKd%>"=="true"){
		$("#is_sPwdAuthChk_tr").hide();
	}else{
		$("#is_sPwdAuthChk_tr").show();
	}
	
	if("<%=realOpCode%>" == "m389"){
		
		$("select[name='isJSX']").find("option").eq(1).attr("selected","selected");
		$("select[name='isJSX']").find("option").eq(0).remove();
		reSetCustName();
		
		document.all.t_handFee.value = "0.0";
		document.all.t_factFee.value = "0.0";
		
		$("input[name='t_handFee']").attr("readonly","readonly");
		$("input[name='t_handFee']").attr("class","InputGrey");
		$("input[name='t_factFee']").attr("readonly","readonly");
		$("input[name='t_factFee']").attr("class","InputGrey");
	}
	
	
});



/*上传txt文件的方法*/
		function uploadBroad(){
			if($("#workNoList").val() == ""){
				rdShowMessageDialog("请上传文件！");
				$("#workNoList").focus();
				return false;
			}
			var formFile=frm.workNoList.value.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=frm.workNoList.value.length;
			formFile=frm.workNoList.value.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("上传文件格式只能是txt，请重新选择文件！",1);
				document.frm.workNoList.focus();
				return false;
			}
			else
				{
					/*准备上传*/
					document.frm.target="hidden_frame";
			    document.frm.encoding="multipart/form-data";
			    document.frm.action="/npage/sm389/fm389Upload.jsp";
			    document.frm.method="post";
			    document.frm.submit();
			    document.frm.encoding="application/x-www-form-urlencoded";
					return true;
				}
				
			
		}
		/*上传成功后要做的事儿*/
		function doSetFileName(oldFileName,newFileName,newFilePath){
			rdShowMessageDialog("上传文件"+oldFileName+"成功！",2);
			$("input[name='serviceFileName']").val(newFileName);
			$("input[name='serviceFilePath']").val(newFilePath);
			/*上传置无效*/
			$("#uploadFile").attr("disabled","disabled");
			
			
		}
		/*上传失败后要做的事儿*/
		function showUploadError(errorInfo){
			rdShowMessageDialog(errorInfo,1);
		}
    
   	function tellMore1000(){
			rdShowMessageDialog("最多只能上传1000条数据！，请重新选择文件",1);
			return false;
		}
		function tellNotHaveOldPhone(phoneNo){
			rdShowMessageDialog("上传txt文件中必须存在办理号码："+phoneNo,1);
			return false;
		}
		
		



	 </script>
	 </head>
	 <body>
 	<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
		<%@ include file="../../include/remark.htm" %>
		<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
		<input type="hidden" name="srv_no" id="srv_no" value="<%=srv_no%>">
  	<input type="hidden" name="cust_name" id="cust_name" value="<%=(String)custDoc.get(5)%>">
    <input type="hidden" name="cust_addr" id="cust_addr" value="<%=(String)custDoc.get(13)%>">
		<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
   	<input type="hidden" name="ic_no" id="ic_no" value="<%=(String)custDoc.get(16)%>">
  	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1238Main">
		<input type="hidden" name="user_id" id="user_id" value="<%=(String)custDoc.get(0)%>">
 		<input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=((String)custDoc.get(23))%>">
    <input type="hidden" name="oldPass" id="oldPass" value="<%=((String)custDoc.get(6)).trim()%>">
    <input type="hidden" name="workno" value=<%=work_no%>>

    <input type="hidden" name="main_str1" >
    <input type="hidden" name="fj_str1"  >
    <input type="hidden" name="main_note" >

	  <input type="hidden" name="h_custName" id="h_custName" value="">
		<input type="hidden" name="h_contactPhone" id="h_contactPhone" value="">
		<input type="hidden" name="h_contactAddr" id="h_contactAddr" value="">
		<input type="hidden" name="h_idIccid" id="h_idIccid" value="">
		<input type="hidden" name="h_idAddr" id="h_idAddr" value="">
	  <input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	  <input type="hidden" name="HasPostBill" value="<%=HasPostBill%>">
	  <input type="hidden" name="HasEmailBill" value="<%=HasEmailBill%>">
	  <input type="hidden" name="ziyou_check" value="<%=resultl0[0][0]%>">
	  
<input type="hidden" name="card_flag" value="">  <!--身份证几代标志-->
  <input type="hidden" name="m_flag" value="">   <!--扫描或者读取标志，用于确定上传图片时候的图片名-->
  <input type="hidden" name="sf_flag" value="">   <!--扫描是否成功标志-->
  <input type="hidden" name="pic_name" value="">   <!--标识上传文件的名称-->
	<input type="hidden" name="up_flag" value="0">
	<input type="hidden" name="but_flag" value="0"> <!--按钮点击标志-->
	<input type="hidden" name="upbut_flag" value="0"> <!--上传按钮点击标志-->
	<input type="hidden" name="custId" value="0">
	<input type="hidden" name="card2flag" value="0">
	
	<input type="hidden" name="isSendListFlag" id="isSendListFlag" value="N" />
  <input type="hidden" name="isQryListResultFlag" id="isQryListResultFlag" value="N" />
  <input type="hidden" name="sendListOpenFlag" id="sendListOpenFlag" value="<%=sendListOpenFlag%>" />
  <input type="hidden" name="loginacceptJT" id="loginacceptJT" />
  
	<input type="hidden" id="printAddFlag" name="printAddFlag" value="true"/>
	<input type="hidden" id="backCode" name="backCode" value="true"/>
	  <%@ include file="/npage/include/header.jsp" %>
	  			<div class="title">
					    <div id="title_zi">用户信息</div>
					</div>
              <table cellspacing="0">
                <tr>
                  <td class="blue" width="13%">
                    <div align="left">客户名称</div>
                  </td>
                  <td width="20%">
                    <div align="left"><%=(String)custDoc.get(5)%></div>
                  </td>
                  <td class="blue" width="13%">
                    <div align="left">大客户标志</div>
                  </td>
                  <td width="20%">
                    <div align="left"><b><font class="orange"><%=(String)custDoc.get(17)%></font></b></div>
                  </td>
                  <td class="blue" width="13%">
                    <div align="left">集团标志</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(18)%></div>
                  </td>
                </tr>
                <tr>
                  <td class="blue">
                    <div align="left">客户状态</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(8)%> </div>
                  </td>
                  <td class="blue">
                    <div align="left">客户级别</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(10)%> </div>
                  </td>
                  <td class="blue">
                    <div align="left">客户类别</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(12)%> </div>
                  </td>
                </tr>
                <tr>
                  <td class="blue">
                    <div align="left">证件类型</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(15)%></div>
                  </td>
                  <td class="blue">
                    <div align="left">证件号码</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(16)%></div>
                  </td>
                  <td class="blue">
                    <div align="left">用户ID</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(0)%></div>
                  </td>
                </tr>
                <tr>
                  <td class="blue">
                    <div align="left">客户地址</div>
                  </td>
                  <td nowrap colspan="2"><%=(String)custDoc.get(13)%></td>
                  	<td class="blue">
                  		<input type="button" name="iccIdCheck" class="b_text" value="校验" onclick="checkIccId()" >
                	</td>
                	<td class="blue">
                		<input type="button" name="get_Photo" class="b_text"   value="显示照片" onClick="getPhoto()" disabled>
                	</td>
                	<td class="blue">
                	</td>
                </tr>
                <tr>
                  <td class="blue">业务品牌</td>
                  <td nowrap colspan="5"><%=sNewSmName%></td>
                </tr>
                <tr>
                  <td class="blue">
                    <div align="left">业务类型</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(4)%></div>
                  </td>
                  <td class="blue">
                    <div align="left">当前预存</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(20)%></div>
                  </td>
                  <td class="blue">
                    <div align="left">当前欠费</div>
                  </td>
                  <td>
                    <div align="left"><%=(String)custDoc.get(19)%></div>
                  </td>
                </tr>
                <tr>
                  <td class="blue">
                    <div align="left">原服务号码</div>
                  </td>
                  <td>
                  	
                  	<%
                  		if(isKd){
                  			out.println(kdNo);
                  		}else{
                  			out.println(srv_no);
                  		}
                  	%>
                  	
                  </td>
                  <td class="blue">
                    <div align="left">原客户ID</div>
                  </td>
                  <td nowrap colspan="3">
                    <div align="left"><%=(String)custDoc.get(1)%></div>
                  </td>
                  <td  class="blue" style="DISPLAY: none">
                    <div align="left" >担保人姓名</div>
                  </td>
                  <td nowrap style="DISPLAY: none">
                    <input name=assuName v_must=0 v_maxlength=30 v_type="string" v_name="担保人姓名" maxlength="30" size=20 index="0" value="<%=WtcUtil.repNull((String)custDoc.get(23))%>">
                  </td>
                </tr>
							</table>
							</div>
							<div id="Operation_Table">
								<div class="title">
									<div id="title_zi">业务办理</div>
								</div>
                    <table cellspacing="0">
                      <tr>
                        <td width="13%" class="blue">
                          <div align="left">客户类型</div>
                        </td>
                        <td colspan="3" class="blue" width="30%">
                          <div align="left">
                            <input type="radio" name="r_cus" value="radiobutton" onclick="chgCustType()" index="7" checked>
                            新建客户
                            
                            <input type="radio" name="r_cus" value="radiobutton" <%if("m389".equals(realOpCode)){out.println("disabled");}%> onclick="chgCustType()" index="8" >
                            已有客户</div>
                        </td>
                        <!-- //update “信誉度”内容不可见（包括已有老户和新建客户） for 关于哈分公司申请优化M058实名制登记信誉度清零问题的请示@2015/2/11
											  <td class="blue" width="13%" >
													<div align="left">信誉度</div>
												</td>
									  			<td>
									  			<input v_name="信誉度" name= "xinYiDu" type="text" v_type="int" v_must=1 maxlength="6" value="0" size="10" onBlur="if(this.value!=''){if(checkElement(document.all.xinYiDu)==false){return false;}}; checkXi()" >
					                <font class="orange">*</font>
												</td>
												-->
                      </tr>

                      <tr id="tr_qryCondition" style="display:none">
                        <td class="blue">
                          <div align="left">查询条件</div>
                        </td>
                        <td colspan="3" class="blue">
                          <div align="left">
                            <input type="radio" name="r_con" id="r_con" value="0" onClick="chgCon()" index="9" checked>
                            服务号码
                            <input type="radio" name="r_con" id="r_con" value="1" onClick="chgCon()" index="10">
                            客户证件
                            <input type="radio" name="r_con" id="r_con" value="2" onClick="chgCon()" index="11">
                            客户ID
                         	</div>
                        </td>
                      </tr>
                      <tr  id="tr_iccid" style="display:none">
                        <td  class="blue">
                          <div align="left">证件类型</div>
                        </td>
                        <td>
                          <div align="left">
                            <select name="id_type" id="id_type"  index="0">
                            </select>
                          </div>
                        </td>
                        <td class="blue">
                          <div align="left">证件号码</div>
                        </td>
                        <td>
                          <div align="left">
                            <input  type="text" size="18" name="id_no" id="id_no" v_name="证件号码" maxlength="18" index="13" onKeyUp="if(event.keyCode==13)getAllId_No()">
                            <font class="orange">*</font>
                            <input type="button" class="b_text" name="qryId_No" value="查询" onClick="getAllId_No()">
                          </div>
                        </td>
                      </tr>
                      <tr id="tr_srvno" style="display:none">
                        <td class="blue">
                          <div align="left">服务号码</div>
                        </td>
                        <td colspan="3">
                          <div align="left">
                            <input type="text" name="new_srv_no" v_must=1 id="new_srv_no" size="14" v_minlength=0 v_maxlength=11 v_type=mobphone  v_name="服务号码" maxlength="11" index="14" onBlur="if(this.value!=''){if(checkElement(document.all.new_srv_no)==false){return false;}}" onKeyUp="if(event.keyCode==13)qryID();">
                            <input class="b_text" type="button" name="b_print22" value="查询" onMouseUp="qryID()" onKeyUp="if(event.keyCode==13)qryID()">
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">新客户ID</div>
                        </td>
                        <td>
                           <input type="text" name="new_cus_id" value="" id="new_cus_id" size="14"  v_must=1 v_maxlength=14 v_type=int v_name="新客户ID" maxlength="14" index="15" onKeyUp="chgNewId();if(event.keyCode==13)chkID();">
                        </td>

                        <td  class=blue>
				    		<span align="left" id="divCustPad1" style="display:;">客户密码</span>&nbsp;
			      		</td>

                        <td   width=35% >
			      			<span  id="divCustPad2" style="display:;">
														<jsp:include page="/npage/query/pwd_one.jsp">
														<jsp:param name="width1" value="16%"  />
														<jsp:param name="width2" value="34%"  />
														 <jsp:param name="pname" value="passwd"  />
														<jsp:param name="pwd" value="12345"  />
							 							</jsp:include>
														<input type="button" class="b_text" name="b_chkId" value="校验" onMouseUp="chkID()" onKeyUp="if(event.keyCode==13)chkID()">
														<font class="orange">*</font>
														</span>&nbsp;
			                  	</td>
			                </tr>
			              </table>

                    <table id="tr_newCust" style="display:none" cellspacing="0">
                    	<!-- tianyang add for custNameCheck start -->
                    	<!--

					            -->
					            <tr id="ownerType_Type">
					            	<TD width=16% class="blue" >
					                <div align="left">个人开户分类</div>
					              </TD>
					              <TD colspan="3" width="34%" class="blue" >
					              	<select align="left" name="isJSX" onChange="reSetCustName()" width=50 index="6">
					              		<option class="button" value="0" selected>普通客户</option>
					              		<option class="button" value="1">单位客户</option>
					              	<select align="left" name=isJSX onChange="" width=50 index="6">
					              	&nbsp;&nbsp;&nbsp;
													<input type="button" id="sendProjectList" name="sendProjectList" class="b_text" value="下发工单" onclick="sendProLists()" style="display:none" />                    
			                  	&nbsp;&nbsp;&nbsp;
                  				<input type="button" id="qryListResultBut" name="qryListResultBut" class="b_text" value="工单结果查询" onclick="qryListResults()" style="display:none" /> 
					              </TD>
					            </tr>
                      <!-- tianyang add for custNameCheck end -->
                      <tr>
                        <td class="blue" width="13%">
                          <div align="left">客户归属市县</div>
                        </td>
                        <td width="30%">
                          <select align="left" name=districtCode width=50 index="16">
                          	<wtc:qoption name="sPubSelect" outnum="2">
														<wtc:sql>select trim(DISTRICT_CODE),DISTRICT_NAME from  SDISCODE Where region_code='<%=regionCode%>' order by DISTRICT_CODE</wtc:sql>
														</wtc:qoption>
                          </select>
                        </td>
                        <td class="blue" width="13%">
                          <div align="left">客户名称</div>
                        </td>
                        <td>
                          <input name=custName id="custName" v_must=0 v_type="string" v_name="客户名称"  maxlength="30" size=35 index="17" onblur="checkCustNameFunc16New(this,0,0);">
                          <font class="orange">*</font> </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">证件类型</div>
                        </td>
                        <td id="tdappendSome">
                          
                        </td>
                        <td class="blue">
                          <div align="left">证件号码</div>
                        </td>
                        <td>
                          <input name=idIccid id="idIccid" v_must=0 v_type="string" v_name="证件号码"  maxlength="20"  index="19" onBlur="checkIccIdFunc16New(this,0,0);rpc_chkX('idType','idIccid','A');">
                          <font class="orange">*</font>
                          <input name=IDQueryJustSee type=button class="b_text" style="cursor:hand" onClick="getInfo_IccId_JustSee()" id="custIdQueryJustSee" value=信息查询>&nbsp;&nbsp;&nbsp;
                          <input type="button" name="iccIdCheck1" class="b_text" value="校验" onclick="checkIccId1()" >&nbsp;
                          <input type="button" name="get_Photo1" class="b_text"   value="显示照片" onClick="getPhoto1()" disabled>
                        </td>
                      </tr>
                      <TR id="card_id_type">
									    
								      <td colspan=2 align=center>
								  			<input type="button" style="display:none;" name="read_idCard_one" class="b_text"   value="扫描一代身份证" onClick="RecogNewIDOnly_oness()" >
												<input type="button" name="read_idCard_two" class="b_text"   value="扫描二代身份证" onClick="RecogNewIDOnly_twoss()">
												<input type="button" name="scan_idCard_two" class="b_text"   value="读卡" onClick="scheckandread()" >
												<input type="button" name="scan_idCard_two222" class="b_text"   value="读卡(2代)" onClick="Idcard2('1')" >
								  			 <input type="hidden"  class="b_text"   value="上传身份证图像" onClick="sfztpsc1238()">	
								  			
												</td>
								  <td  class="blue">
								      	证件照片上传
								      </td>
								      <td>
								      	
												 <input type="file" name="filep" id="filep" onchange="chcek_pic1121();" >    &nbsp;
												 
												 <iframe name="upload_frame" id="upload_frame" style="display:none"></iframe>
												
												<input type="hidden" name="idSexH" value="1">
								  			<input type="hidden" name="birthDayH" value="20090625">
								  			<input type="hidden" name="idAddrH" value="哈尔滨">
								  			
												 <input type="button" name="uploadpic_b" class="b_text"   value="上传身份证图像" onClick="uploadpic()"  disabled>
								      	
								      	</td>
								     </tr>
                      <tr>
                        <td class="blue">
                          <div id="idAddrDiv" align="left">证件地址</div>
                        </td>
                        <td>
                          <input name=idAddr id="idAddr" v_must=0 v_type="addrs" v_name="证件地址" v_maxlength=60 maxlength="60" size="30" index="20" onBlur="if(checkElement(this)){checkAddrFunc(this,0,0)}">
                          <font class="orange">*</font> </td>
                        <td class="blue">
                          <div align="left">证件有效期</div>
                        </td>
                        <td>
                          <input name="idValidDate" id="idValidDate"  v_must=0 v_maxlength=8 v_type="date" v_name="证件有效期" maxlength=8 size="8" index="21" onBlur="chkValid();" v_format="yyyyMMdd" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" >
                        </td>
                      </tr>
                      <tr id ="divPassword" style="display:;">
                        <td class="blue">
                          <div align="left">客户密码</div>
                        </td>
                        <td>
						<input name="custPwd" type="password" onblur="" class="button"  maxlength="6">
						<input id="bttn1" name="bttn1" type="button" value="输入"  class="b_text" >
						<font class="orange">*</font>
                        </td>
                        <td class="blue">
                          <div align="left">校验客户密码</div>
                        </td>
                        <td>
							<input  name="cfmPwd" type="password"  class="button" prefield="cfmPwd" filedtype="pwd"  maxlength="6">
						    <input onclick="showNumberDialog(document.all.cfmPwd);" id="btn2" type="button" value="再输入" class="b_text" >
							<font class="orange">*</font>
                        </td>
                      </tr>
<script type="text/javascript">
	var btn1Obj = document.getElementById("bttn1");
	btn1Obj.attachEvent("onclick",foo);
	btn1Obj.attachEvent("onclick",doo);
	function foo(){
		chkPwdEasy1(document.all.custPwd.value);
	}
	function doo(){
		showNumberDialog(document.all.custPwd);
	}
</script>
                      <tr>
                        <td class="blue">
                          <div align="left">客户状态</div>
                        </td>
                        <td colspan="3">
                          <select align="left" name=custStatus width=50 index="24">
                          	<wtc:qoption name="sPubSelect" outnum="2">
														<wtc:sql>select trim(STATUS_CODE),STATUS_NAME from sCustStatusCode order by STATUS_CODE</wtc:sql>
														</wtc:qoption>
                          </select>
                          <select  align="left" name=custGrade width=50 index="25" style="display:none">
                          	<wtc:qoption name="sPubSelect" outnum="2">
														<wtc:sql>select trim(OWNER_CODE), TYPE_NAME from sCustGradeCode where REGION_CODE ='<%=regionCode%>' order by OWNER_CODE</wtc:sql>
														</wtc:qoption>
                          </select>
                        </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">客户地址</div>
                        </td>
                        <td colspan="3">
                          <input name=custAddr v_type="addrs" v_must=0 v_name="客户地址"  v_maxlength=60 maxlength="60" size=35 index="26" onBlur="if(checkElement(this)){checkAddrFunc(this,1,0);}">
                          <font class="orange">*</font> </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">联系人姓名</div>
                        </td>
                        <td>
                          <input name=contactPerson v_must=0 v_type="string" v_name="联系人姓名" onblur="checkCustNameFunc(this,1,0);" maxlength="20" size=20 index="27" v_maxlength=20>
                        	<font class="orange">*</font>
                        </td>
                        <td class="blue">
                          <div align="left">联系人电话</div>
                        </td>
                        <td>
                          <input name=contactPhone v_must=0 v_type="phone" v_name="联系人电话" maxlength="20"  index="28" size="20" onBlur="checkElement(this)">
                          <font class="orange">*</font> </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">联系人地址</div>
                        </td>
                        <td>
                          <input name=contactAddr  v_must=0 v_type="addrs" v_name="联系人地址" v_maxlength=60 maxlength="60" size=55 index="29" onBlur="if (checkElement(this)){ checkAddrFunc(this,2,0) }">
                          <font class="orange">*</font> </td>
                        <td class="blue">
                          <div align="left">联系人邮编</div>
                        </td>
                        <td>
                          <input name=contactPost v_type="zip" v_name="联系人邮编" maxlength="6"  index="30" size="20">
                        </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">联系人传真</div>
                        </td>
                        <td>
                          <input name=contactFax v_must=0 v_type="phone" v_name="联系人传真" maxlength="20"  index="31" size="20">
                        </td>
                        <td class="blue">
                          <div align="left">联系人E_MAIL</div>
                        </td>
                        <td>
                          <input name=contactMail v_must=0 v_type="email" v_name="联系人EMAIL" maxlength="30" size=30 index="32">
                        </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">联系人通讯地址</div>
                        </td>
                        <td colspan="3">
                          <input name=contactMAddr v_must=0 v_type="addrs" v_name="联系人通讯地址" v_maxlength=60 maxlength="60" size=55 index="33" onBlur="if(checkElement(this)){checkAddrFunc(this,3,0)};">
                          <font class="orange">*</font> </td>
                      </tr>
                      
		                 <!-- 20131216 gaopeng 2013/12/16 10:29:28 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人信息 start -->
		                 <%@ include file="/npage/sq100/gestoresInfo.jsp" %>
		                 <%@ include file="/npage/sq100/responsibleInfo.jsp" %>
                      <tr>
                        <td class="blue">
                          <div align="left">客户性别</div>
                        </td>
                        <td>
                          <select align="left" name=custSex width=50 index="34">
                           	<wtc:qoption name="sPubSelect" outnum="2">
														<wtc:sql>select trim(SEX_CODE), SEX_NAME from ssexcode order by SEX_CODE</wtc:sql>
														</wtc:qoption>
                          </select>
                        </td>
                        <td class="blue">
                          <div align="left">出生日期</div>
                        </td>
                        <td>
                          <input name=birthDay maxlength=8 index="35"  v_must=0 v_maxlength=8 v_type="date" v_name="出生日期" size="8" v_format="yyyyMMdd" onblur="checkElement(this);">
                        </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">职业类别</div>
                        </td>
                        <td>
                          <select align="left" name=professionId width=50 index="36">
                           	<wtc:qoption name="sPubSelect" outnum="2">
														<wtc:sql>select trim(PROFESSION_ID), PROFESSION_NAME from sprofessionid order by PROFESSION_ID DESC</wtc:sql>
														</wtc:qoption>
                          </select>
                        </td>
                        <td class="blue">
                          <div align="left">学历</div>
                        </td>
                        <td>
                          <select align="left" name=vudyXl width=50 index="37">
                           	<wtc:qoption name="sPubSelect" outnum="2">
														<wtc:sql>select trim(WORK_CODE), TYPE_NAME from SWORKCODE Where region_code ='<%=regionCode%>' order by work_code DESC</wtc:sql>
														</wtc:qoption>
                          </select>
                        </td>
                      </tr>
                      <tr>
                        <td class="blue">
                          <div align="left">客户爱好</div>
                        </td>
                        <td>
                          <input name=custAh maxlength="20"  index="38" size="20">
                        </td>
                        <td class="blue">
                          <div align="left">客户习惯</div>
                        </td>
                        <td>
                          <input name=custXg maxlength="20"  index="39">
                        </td>
                      </tr>
                      
                      
                    </table>
                     <table cellspacing="0" id="is_sPwdAuthChk_tr" >
 										<tr >
                      	<td class="blue" width="30%" >
                          <div align="left"><%=if24MonthText%></div>
                        </td>
                        <td >
                          <select style='width:220px'  id="is_sPwdAuthChk_sel" name="is_sPwdAuthChk_sel">
                          	<%=if23Options%>
                          </select>
                        </td>
                      </tr>
                    </table>

							<table cellspacing="0">
							<%@ include file="/npage/sq100/realUserInfo.jsp" %>
<!-- 20091201 begin -->
<%/*%>
							<TR style="display:none" id="Good_PhoneDate_GSM" >
								<TD nowrap class=blue width="13%">
									<div align="left">原服务号码实名登记限制</div>
								</TD>
								<TD nowrap>
									<select name ="GoodPhoneFlag" onchange="GoodPhoneDateChg();">
										<option class='button' value='0' selected>--请选择--</option>
										<option class='button' value='Y' >允许实名登记</option>
										<option class='button' value='N' >不允许实名登记</option>
									</select>
								</TD>

								<TD nowrap class=blue width="13%">
									<div align="left" >可办理实名登记的时间</div>
								</TD>
								<TD nowrap colspan="3">
									<input id="GoodPhoneDate" class="button" name="GoodPhoneDate" maxlength="8" disabled >
									<font class="orange">(格式YYYYMMDD)</font>&nbsp;&nbsp;
								</TD>
							</TR>
<!-- 20091201 end -->
<%*/%>

                <tr>
                  <td class="blue" width="13%">
                    <div align="left">手续费</div>
                  </td>
                  <td width="20%">
                    <div align="left">
                      <input type="text" name="t_handFee" id="t_handFee" size="16" value="<%=(((String)custDoc.get(30)).trim().equals(""))?("0"):(((String)custDoc.get(30)).trim()) %>" v_type=float v_name="手续费" <%if(hfrf){%>readonly<%}%> onblur="ChkHandFee()" index="40">
                    </div>
                  </td>
                  <td class="blue" width="13%">
                    <div align="left">实收</div>
                  </td>
                  <td width="20%">
                    <div align="left">
                      <input type="text" name="t_factFee" id="t_factFee" index="41" size="16"  onKeyUp="getFew()" v_type=float v_name="实收"
                      <%
                        System.out.println("hfrf====="+hfrf);
	                       if(hfrf){
														 if(((String)custDoc.get(30)).trim().equals("") || ((String)custDoc.get(30)).trim().equals("0")  || Double.parseDouble(((String)(custDoc.get(30))))==0)
														 {
							   %>
								   								readonly
										<%
														 }
												 }
										%>
							   >
                    </div>
                  </td>
                  <td class="blue" width="13%">
                    <div align="left">找零</div>
                  </td>
                  <td width="20%">
                    <div align="left">
                      <input type="text" name="t_fewFee" id="t_fewFee" size="16" readonly>
                    </div>
                  </td>
                </tr>
                <tr>
                	<td class="blue">
  	              	<div align="left">资料查询</div>
                	</td>
							  	 <td nowrap colspan="5">
							  		<select name ="print_query" >
							  			<option class='button' value='Y' >是</option> 
							  			<%/*
							  			<option class='button' value='N' selected>否</option>
							  			<option class='button' value='Y' >是</option>
							  			*/%>
							  		</select>
								  		<font class="orange">* 说明:新机主是否有权察看实名登记前的所有资料</font>
							  		</td>
							  </tr>
							  <%if("m389".equals(realOpCode)){%>
							  <tr>
									<td width="20%" class="blue">
										批量手机号码导入
									</td>
									<td colspan="5">
										<input type="file" name="workNoList" id="workNoList" class="button"
										style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
										&nbsp;&nbsp;
										<input type="button" name="uploadFile" id="uploadFile" class="b_text" value="上传" onclick="uploadBroad();"/>
										<font class="yellow">*</font>
									</td>
								</tr>
								<tr>
									<td class="blue">
										文件格式说明
									</td>
						      <td colspan="5"> 
						          上传文件文本格式为 手机号码+回车换行 的.txt文件，示例如下：<br>
						          <font class='orange'>
						          	&nbsp;&nbsp; 13904510000<br/>
						          	&nbsp;&nbsp; 13904510001<br/>
						          	&nbsp;&nbsp; 13904510002<br/>
						          	&nbsp;&nbsp; 13904510003<br/>
						          	&nbsp;&nbsp; 13904510004<br/>
						          	&nbsp;&nbsp; 13904510005<br/>
						          	&nbsp;&nbsp; 13904510006<br/>
						          	&nbsp;&nbsp; 13904510007<br/>
						          	&nbsp;&nbsp; 13904510008
						          </font>
						          <b>
						          <br>&nbsp;&nbsp; 注：格式中的每一项均不允许存在空格,且每条信息都需要回车换行。最多允许上传1000条数据。
						          		&nbsp;&nbsp; 批量导入信息需添加当前办理工号。
						          <br>
						          </b> 
						      </td>
						      <iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
						    	<!--上传文件名 -->	
									<input type="hidden" name="serviceFileName" value=""/>
									<!--上传文件全路径名 -->	
									<input type="hidden" name="serviceFilePath" value=""/>
						    </tr>
		    				<%}%>

                <tr>
                  <td class="blue">
                    <div align="left">系统备注</div>
                  </td>
                  <td nowrap colspan="5">
                    <div align="left">
                      <input type="text" name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=60>
                    </div>
                  </td>
                </tr>
                <tr style="display:none">
                  <td class="blue">
                    <div align="left">用户备注</div>
                  </td>
                  <td nowrap colspan="5">
                    <div align="left">
                      <input type="text" name="t_op_remark" id="t_op_remark" size="60"	v_maxlength=60  v_type=string  v_name="用户备注" maxlength=60 >
                    </div>
                  </td>
                </tr>
                <tr >
                  <td class="blue">用户备注</td>
                  <td nowrap colspan="5">
                    <input name=assuNote v_must=0 v_maxlength=60 v_type="string" v_name="用户备注" maxlength="60" size=60  value="" index="42">
                  </td>
                </tr>
              </table>
              <jsp:include page="/npage/public/hwReadCustCard.jsp">
								<jsp:param name="hwAccept" value="<%=loginAccept%>"  />
								<jsp:param name="showBody" value="11"  />
								<jsp:param name="sopcode" value="m058"  />
							</jsp:include>
            	<table>
                <tr>
                  <td nowrap colspan="6" id="footer">
                    <div align="center">
                      <input class="b_foot" type="button" name="b_print" value="确认&打印" onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" index="43" disabled>
                      <input class="b_foot" type="button" name="b_clear" value="清除" onClick="frm.reset();" index="44">
                      <input class="b_foot" type="button" name="b_back" value="返回" onClick="location='<%=returnPage%>?activePhone=<%=phone_no%>' " index="45">
                    </div>
                  </td>
                </tr>
              </table>
		   <%@ include file="/npage/include/footer.jsp" %>
		   <%@ include file="/npage/common/pwd_comm.jsp" %>
 	 </form>

 	 </body>
 	 <%@ include file="/npage/public/hwObject.jsp" %> 
 	 <%@ include file="interface_provider1238.jsp" %> 
 	 <%@ include file="/npage/include/public_smz_check.jsp" %>
 	 </html>

	<script language="JavaScript">
	function fillSelect()
	{
		<%
			if(metaData!=null&&metaData.length>0){
		%>
		  	document.all.id_type.options.length=<%=metaData[0].length%>;
		<%
					for(int i=0;i<metaData[0].length;i++){
		%>
		    	   document.all.id_type.options[<%=i%>].text="<%=metaData[0][i].trim()%>";
		    	   document.all.id_type.options[<%=i%>].value=<%=i+1%>
		<%
					}
		%>
			    document.all.id_type.options[0].selected=true;
		<%
			}
		%>
	}

	</script>
