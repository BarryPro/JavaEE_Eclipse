<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-25 页面改造,修改样式
********************/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.csp.bsf.pwm.util.*"%>

<%
	//读取用户session信息
	
	String workNo=(String)session.getAttribute("workNo");               //工号
	String nopass=(String)session.getAttribute("password");             //登陆密码
	String regionCode=(String)session.getAttribute("regCode");
	String opCode          = request.getParameter("opCode");
	String opType          = request.getParameter("opType");
	String loginNo         = request.getParameter("loginNo");
	String contractPhoneNo = request.getParameter("contractPhoneNo");
	String loginName       = request.getParameter("loginName");
	String loginFlag       = request.getParameter("loginFlag");
	String loginPass       = request.getParameter("loginPass");
	String powerCode       = request.getParameter("powerCode");
	String powerRight      = request.getParameter("powerRight").trim();
	String rptRight        = request.getParameter("rptRight");
	String allowBegin      = request.getParameter("allowBegin");
	String allowEnd        = request.getParameter("allowEnd");
	String expireTime      = request.getParameter("expireTime");
	String tryTimes        = request.getParameter("tryTimes");
	String maintainFlag    = request.getParameter("maintainFlag");
	String validFlag       = request.getParameter("validFlag");
	String orgCode         = request.getParameter("orgCode");
	String deptCode        = request.getParameter("deptCode");
	String lastIpAdd       = request.getParameter("lastIpAdd");
	String reFlag          = request.getParameter("reFlag");
	String otherFlag       = request.getParameter("otherFlag");
	String loginStatus     = request.getParameter("loginStatus");
	String remark          = request.getParameter("remark");
	
	String regionChar      = request.getParameter("regionChar");
	String AccountNo       = request.getParameter("AccountNo");
	String AccountType     = request.getParameter("AccountType");
	String groupId         = request.getParameter("groupId");
	String SEQ_MailCode    = request.getParameter("SEQ_MailCode");//20100317 add
	String reject_flag    	 = request.getParameter("reject_flag");//add 工号操作在实收报表中剔除@2014/3/10 
	String oaNumber = request.getParameter("oaNumber");//OA编号
	String oaTitle = request.getParameter("oaTitle");  //OA标题
	System.out.println("liangyl===oaNumber========================"+oaNumber);
	System.out.println("liangyl===oaTitle========================"+oaTitle);
	
	MD5 _md5 = new MD5();
	String kfPassWord = _md5.encode(loginPass); /*加密 loginPass 为加密前的密码，即密码明文*/
	
	if(opType.equals("1"))
	{
		/*如果是修改工号信息，密码传空，客服端接收后不修改密码*/
		kfPassWord = "";
		System.out.println("++++++1+++修改工号信息操作+++++++++++");
	}
	else if(!AccountType.equals("2"))
	{
		/*如果是BOSS工号，传给客服的密码为111111的加密*/
		kfPassWord = _md5.encode("111111");
		System.out.println("++++++2+++增加BOSS工号信息操作+++++++++++");
	}
	
	System.out.println("gourpId       is : " + groupId      );
	
	//ArrayList acceptList = new ArrayList();
	String paramsIn[] = new String[34];//20100317 modified String[30] to String[31]

	paramsIn[0]  = workNo;          //工号
	paramsIn[1]  = nopass;          //密码
	paramsIn[2]  = opCode;          //OP_CODE 新建  8058	 修改  8059
	paramsIn[3]  = opType;          //操作代码(0_增加; 1_修改; 2_查询);
	paramsIn[4]  = loginNo;         //新建工号代码
	paramsIn[5]  = loginName;       //新建工号姓名
	paramsIn[6]  = loginFlag;       //工号类型
	paramsIn[7]  = loginPass;       //登陆密码
	paramsIn[8]  = powerCode;       //角色代码
	paramsIn[9]  = powerRight; 	    //角色权限
	paramsIn[10] = rptRight;        //报表权限
	paramsIn[11] = allowBegin;      //开始登陆时间
	paramsIn[12] = allowEnd;   	    //结束登陆时间
	paramsIn[13] = expireTime;      //密码失效时间
	paramsIn[14] = tryTimes;        //登陆次数
	paramsIn[15] = validFlag;       //有效标识
	paramsIn[16] = maintainFlag;    //维护标识
	paramsIn[17] = orgCode;         //归属代码
	paramsIn[18] = deptCode;   	    //工单归属部门
	paramsIn[19] = lastIpAdd;       //登陆IP地址
	paramsIn[20] = reFlag;          //重复登陆标志
	paramsIn[21] = loginStatus;     //登陆状态
	paramsIn[22] = remark;     	    //备注
	paramsIn[23] = contractPhoneNo;	//工号电话
	paramsIn[24] = regionChar;      //异地操作权限
	paramsIn[25] = "0";             //员工工号
	paramsIn[26] = AccountNo;       //客服工号
	paramsIn[27] = AccountType;     //帐号类型
	paramsIn[28] = groupId;         //组织节点号码
	paramsIn[29] = kfPassWord;      //客服加密密码
	paramsIn[30] = SEQ_MailCode;    //工号邮箱序列 20100317 add
	paramsIn[31] = "";    	  			//2014/3/10 add
	paramsIn[32] = reject_flag;    	  //工号操作在实收报表中剔除 2014/3/10 add
	paramsIn[33] = "RJBB";    	    //标志位 2014/3/10 add
	System.out.println(">>>>["+powerRight+"]>>>>>["+rptRight+"]>>>>["+lastIpAdd);
	for(int i = 0 ; i <paramsIn.length ; i ++){
		System.out.println("1--------hejwa---------paramsIn["+i+"]--------------->"+paramsIn[i]);
	}
	if("0".equals(paramsIn[27])){
		String sql = "select substr(a.boss_org_code,1,4)||substr(:pLoginNo,2,5) from dChnGroupMsg a where a.group_id = trim(:vGroupId)";
		String sqlpLoginNo = "pLoginNo="+paramsIn[4]+",vGroupId="+paramsIn[28];
		%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=sqlpLoginNo%>" />
		</wtc:service>
		<wtc:array id="result_orgcode" scope="end" />
		<%
		if("000000".equals(retCode)){
			if(result_orgcode.length>0){
				System.out.println("--------hejwa---------result_orgcode[0][0]="+result_orgcode[0][0]);
				paramsIn[17]=result_orgcode[0][0];
			}
        }
	}
			for(int i = 0 ; i <paramsIn.length ; i ++){
			System.out.println("2--------hejwa---------paramsIn["+i+"]--------------->"+paramsIn[i]);
		}
	String errCode="0";
	String errMsg="";
	
	 	//acceptList = impl.callFXService("s8002Cfm",paramsIn,"2");
%>
	<wtc:service name="s8002Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="29" >
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>				
		<wtc:param value="<%=paramsIn[5]%>"/>
		<wtc:param value="<%=paramsIn[6]%>"/>
		<wtc:param value="<%=paramsIn[7]%>"/>
		<wtc:param value="<%=paramsIn[8]%>"/>
		<wtc:param value="<%=paramsIn[9]%>"/>		
		<wtc:param value="<%=paramsIn[10]%>"/>		
		<wtc:param value="<%=paramsIn[11]%>"/>
		<wtc:param value="<%=paramsIn[12]%>"/>
		<wtc:param value="<%=paramsIn[13]%>"/>
		<wtc:param value="<%=paramsIn[14]%>"/>		
		<wtc:param value="<%=paramsIn[15]%>"/>
		<wtc:param value="<%=paramsIn[16]%>"/>
		<wtc:param value="<%=paramsIn[17]%>"/>
		<wtc:param value="<%=paramsIn[18]%>"/>
		<wtc:param value="<%=paramsIn[19]%>"/>		
		<wtc:param value="<%=paramsIn[20]%>"/>
		<wtc:param value="<%=paramsIn[21]%>"/>
		<wtc:param value="<%=paramsIn[22]%>"/>
		<wtc:param value="<%=paramsIn[23]%>"/>
		<wtc:param value="<%=paramsIn[24]%>"/>		
		<wtc:param value="<%=paramsIn[25]%>"/>
		<wtc:param value="<%=paramsIn[26]%>"/>
		<wtc:param value="<%=paramsIn[27]%>"/>
		<wtc:param value="<%=paramsIn[28]%>"/>
		<wtc:param value="<%=paramsIn[29]%>"/>
		<wtc:param value="<%=paramsIn[30]%>"/>//20100317 add
		<wtc:param value="<%=paramsIn[31]%>"/>//2014/3/10  add
	  	<wtc:param value="<%=paramsIn[32]%>"/>//2014/3/10  add
	  	<wtc:param value="<%=paramsIn[33]%>"/>//2014/3/10  add
	  	<wtc:param value="<%=oaNumber%>" />
		<wtc:param value="<%=oaTitle%>" />
	</wtc:service>
	<wtc:array id="results" scope="end"/>
<%
		errCode=retCode1;
		errMsg=retMsg1;	
	System.out.println("errCode       is : " + errCode      );
	System.out.println("errMsg       is : " + errMsg      );
	
	if(errCode.equals("000000"))
    {
%>
        alert("操作成功！");
<%	}
    else
    {
%>
		alert("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" );
		//history.go(-1);
<%
    }
    	
	String[]info=new String[29];	
	if(results!=null&&results.length>0){
		for(int i = 0 ; i <results[0].length ; i ++){
			
			info[i]=results[0][i];
			System.out.println("info["+i+"]=:"+info[i]);
		}
	}
	

	
    String strArray="";
%>

<%=strArray%>

var info=new Array();
info[0]=new Array;
info[1]=new Array;
info[0][0]="<%=errCode%>";
info[1][0]="<%=errMsg%>";

var response = new AJAXPacket();
response.data.add("backString",info);
response.data.add("flag","9");
core.ajax.receivePacket(response);




