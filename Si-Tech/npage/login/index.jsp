<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<html>
<head>
<title>黑龙江移动综合客户服务系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<OBJECT id="clo" type="application/x-oleobject" classid="clsid:adb880a6-d8ff-11cf-9377-00aa003b7a11"><PARAM name="Command" value="Close"></OBJECT>
<script>
	function createCookie(name,value,days) {
		if (days) {
			var date = new Date();
			date.setTime(date.getTime()+(days*24*60*60*1000));
			var expires = "; expires="+date.toGMTString();
		} else {
			var expires = "";
		}
		document.cookie = name+"="+value+expires+"; path=/";
	}

	function isGoodBrowser() {
	    browserOk = false;
	    versionOk = false;
	    browserOk = (navigator.appName.indexOf('Microsoft') != -1);
	    var appVer = navigator.appVersion.replace(/.+(MSIE[^;]+).+/,"$1");
	    versionOk = (5 < parseFloat(appVer.substring(5,8)));
	    return browserOk && versionOk;
	}

	if (isGoodBrowser() == false){
	    rdShowMessageDialog("请使用IE5.5以上(包含IE5.5)的浏览器",0);
	    clo.Click();
	}
</script>

<jsp:include page="/npage/contact/GetCnttStatus.jsp" flush="true" />
<%
	String workNo = request.getParameter("staffNo");
	String nopass = request.getParameter("password");
	String macAddr = request.getParameter("uuidCode");//add by gaolw 客户端mac地址
	System.out.println(workNo+"2---------------------------------------"+nopass+"----------------------------------"+macAddr);
	String versonType = request.getParameter("versonType"); // 页面框架版本:: normal:普通版;simple:高速版.
	String paramStr="l/"+workNo;
	/* 4a */
	String addressFlag = request.getParameter("addressFlag")==null? "" : request.getParameter("addressFlag");
	String token4a = request.getParameter("token4a")==null? "" : request.getParameter("token4a");
	System.out.println("addressFlag ----------> " + addressFlag + " | " + token4a);
	Date date=new Date();
	SimpleDateFormat myFmt=new SimpleDateFormat("yyyyMMdd");
	String myDate = myFmt.format(date);
	/*
	*防止从4a登陆的时候，跳过验证密码的问题 yanpx 
	*1.在login_4a中的工号与request中的工号不符合
	*2.在session中的token与request中的token不符合
	*/
	if(addressFlag.equals("1")){
		String sessionToken = (String)session.getAttribute("token4a");
		String workNo4a   = (String)session.getAttribute("workNo");
		if(!workNo.equals(workNo4a)){
%>
			<SCRIPT language="javascript">
				window.open("","_self");
				window.close();
			</SCRIPT>
<%				
		}
		if(sessionToken == null || "null".equals(sessionToken) || (!sessionToken.equals(token4a))){
			/*如果session中的token串为空，或者与获取的不相符，直接关闭页面*/
			System.out.println("ningtn error token");
%>
				<SCRIPT language="javascript">
					window.open("","_self");
					window.close();
				</SCRIPT>
<%
		}	
	}
/* liyan 20090925 为解决session串的问题，加入清session部分 begion*/
	session.setAttribute("allArr",null);
	session.setAttribute("password",null);
	session.setAttribute("workName",null);
	session.setAttribute("groupId",null);
	session.setAttribute("powerCode",null);
	session.setAttribute("orgId",null);
	session.setAttribute("powerRight",null);
	session.setAttribute("rptRight",null);
	session.setAttribute("orgCode",null);
	session.setAttribute("ipAddr",null);
	session.setAttribute("favInfo",null);
	session.setAttribute("deptCode",null);
	session.setAttribute("regCode",null);
	session.setAttribute("workGroupId",null);
	session.setAttribute("groupId",null);
	session.setAttribute("orgName",null);
	session.setAttribute("phoneHeadList",null);
//mengxj add 
 	session.setAttribute("accountType",null);
 	session.setAttribute("kf_login_no",null);
 	session.setAttribute("allowend",null);
/* end */
//-------------------------------------------------



session.setAttribute("token4a",null);
session.setAttribute("workNo",null);
session.setAttribute("currentYear",null);
session.setAttribute("verifyFlag",null);
session.setAttribute("contactInfoMap",null);
session.setAttribute("contactInfo",null);
session.setAttribute("contactInfoRelation",null);
session.setAttribute("contactTimeMap",null);
session.setAttribute("versonType",null);


//add by liubo 存储以手机号码为主键的接触信息
session.setAttribute("contactInfoMap",new HashMap());
//add by liubo 存储以客户号码为主键的接触信息
session.setAttribute("contactInfo",new HashMap());
//add by liubo 存储以客户号码为主键,客户对应用户号码数组为值的关联信息 
session.setAttribute("contactInfoRelation",new HashMap());
//add by liubo 存储以手机号码为主键的密码校验时间信息
session.setAttribute("contactTimeMap",new HashMap());

HashMap hm = new HashMap(); //custid - 校验标志位

session.setAttribute("phoneKfCheck",hm);

String selfIp =  request.getParameter("localclientip")==null? request.getRemoteAddr() : request.getParameter("localclientip");

//System.out.println("workNo="+workNo);
//System.out.println("nopass="+nopass);
//System.out.println("selfIp="+selfIp);
String sessionIdStr = session.getId();
/*add begin 新增4a账号入参 for 关于配合业务支撑中心审计系统完善需求的函-CRM登录日志增加记录4A主账号信息@2014/11/10 */
//token4a = "Token=OGFlZWVmNDEyYzNlODQ2MDAxMmM0MDBhNzU2YzAyMmEtOGFmNWM2YTY0OTE4ODc1ODAxNDkxYmY2OTU1MjAxNzcxNDEzNTEzMzg1Mjk4QGJlOGI3NDIyNjMwMTRjYzZhMmY1ZjVmYzMzNjQxOTgyOjhhZWVlZjQxMzEzYzg5M2QwMTMxNDVhOGNkMDAwN2RkQGxpdXlhbmZhbmc=@b20035@8aeeef412c3e8460012c400a756c022a@liuyanfang@iam35]";
String v_loginNo_4a = "";
if(token4a.indexOf("@") != -1){
	v_loginNo_4a = token4a.split("@")[3];
}
/*add end 新增4a账号入参 @2014/11/10 */
try{

%>
<wtc:service name="sLoginCheck" outnum="46">
	<wtc:param value="<%=workNo%>" />
    <wtc:param value="<%=nopass%>" />
    <wtc:param value="<%=selfIp%>" />
    <wtc:param value="<%=macAddr%>" />
    <wtc:param value="01" />
    <wtc:param value="<%=addressFlag%>" />
    <wtc:param value="<%=sessionIdStr%>" />
    <wtc:param value="<%=v_loginNo_4a%>" /> <% /*add 新增4a账号入参 for 关于配合业务支撑中心审计系统完善需求的函-CRM登录日志增加记录4A主账号信息@2014/11/10 */ %>
</wtc:service>
<wtc:array id="str1" start="0" length="24" scope="end"/>
<%

System.out.println("-------hejwa------sLoginCheck------str1[0][0]------------->"+str1[0][0]);
System.out.println("-------hejwa------retMsg-----------str1[0][0]------------->"+retMsg);

if(!str1[0][0].equals("000000")&&!str1[0][0].equals("900099")){
%>
<script language="javascript">
	rdShowMessageDialog("<%=retMsg%>");
	//window.location="/npage/login/index.html";
	window.open('/npage/login/index.html','','width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	window.opener=null;
  this.close();
</script>
<%
}else{
%>
<wtc:array id="str2" start="24" length="4"  scope="end"/>
<wtc:array id="str3" start="28" length="8"  scope="end"/>
<wtc:array id="str4" start="36" length="1"  scope="end"/>
<wtc:array id="str5" start="37" length="1"  scope="end"/>
<wtc:array id="str6" start="38" length="6"  scope="end"/>
<wtc:array id="str7" start="44" length="1"  scope="end"/>
<wtc:array id="str8" start="45" length="1"  scope="end"/>	
<%
	 //登陆boss系统
	 if (str1[0][0].equals("900099")){
	 %>
	   <script language="javascript">
		  rdShowMessageDialog("<%=str1[0][1]%>");
	   </script>
     <%
     }
			ArrayList arr=new ArrayList();
			arr.add(str1);
			arr.add(str2);
			arr.add(str3);
			arr.add(str4);
			arr.add(str5);
			arr.add(str6);
			//add by mengxj for 客服整合
			arr.add(str7);
			arr.add(str8);

			String lastPass = str5[0][0];
			String rtn_code = str1[0][0];
			String rtn_message = str1[0][1];
			String department = str1[0][16];

			String orgCode = str1[0][16];
			String workName = str1[0][3];

			String groupId = str1[0][21];
			String orgId  = str1[0][23];
			String powerCode = str1[0][4];
			String powerRight = str1[0][5];
			String rptRight = str1[0][6];
			String deptCode = str3[0][3];

/**  modified by hejwa in 20110714 多OP改造  begin **/			
			String sqlBuf="select theme_css,layout_css from dlogintheme where login_no=:login_no";
			String myParams="login_no="+workNo;
%>
<wtc:service name="TlsPubSelCrm" outnum="2">
	<wtc:param value="<%=sqlBuf%>"/>
  <wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="cssResult" scope="end" />
<%
			if(cssResult.length>0){
			 	session.setAttribute("themePath","".equals(cssResult[0][0].trim())?"default":cssResult[0][0]);
			 	session.setAttribute("layout","".equals(cssResult[0][1].trim())?"1":cssResult[0][1]);
			}else{
				//若工号已经设置，首先按照工号设置进行显示，若工号没有设置则按照角色设置的默认选项进行显示
				//sql为布局角色关系、主题角色关系的默认值
				String themeSql = "select theme_css from dthemerole_rel where  op_role=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode =:powerCode) and is_default = '1'";
				String layoutSql= "select layout_css from dlayoutrole_rel where  op_role=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode =:powerCode) and is_default = '1'";
				String layoutThemeparam = "powerCode=" + powerCode;
				%>
				<wtc:service name="TlsPubSelCrm" outnum="1">
					<wtc:param value="<%=layoutSql%>"/>
				  	<wtc:param value="<%=layoutThemeparam%>"/>
				</wtc:service>
				<wtc:array id="layoutRes" scope="end" />
				<wtc:service name="TlsPubSelCrm" outnum="1">
					<wtc:param value="<%=themeSql%>"/>
				  	<wtc:param value="<%=layoutThemeparam%>"/>
				</wtc:service>
				<wtc:array id="themeRes" scope="end" />
				<%
					if(themeRes.length>0){
						session.setAttribute("themePath",themeRes[0][0]);
					}else{
						session.setAttribute("themePath","default");
					}
					if(layoutRes.length>0){
			 			session.setAttribute("layout",layoutRes[0][0]);
					}else{
			 			session.setAttribute("layout","1");
					}
			}
			/**  modified by hejwa in 20110714 多OP改造  end **/
			session.setAttribute("allArr",arr);
			session.setAttribute("password",lastPass);
			session.setAttribute("workName",workName);
			session.setAttribute("groupId",groupId);
			session.setAttribute("powerCode",powerCode);
			System.out.println("-----------------powerCode------###----------"+powerCode);
			session.setAttribute("orgId",orgId);
			session.setAttribute("powerRight",powerRight);
			System.out.println("-----------------powerRight--------###--------"+powerRight);
			session.setAttribute("rptRight",rptRight);

			/*****归属代码*****/
			session.setAttribute("orgCode",orgCode);

			/*****ip地址*****/
			session.setAttribute("ipAddr",selfIp);

			/*****优惠信息*****/
			session.setAttribute("favInfo",str4);

			session.setAttribute("deptCode",deptCode);
			String regionCode = "";
			if( orgCode != null && orgCode.length()>2 ){
				regionCode = orgCode.substring(0,2);
				session.setAttribute("regCode",regionCode);
			}
			session.setAttribute("token4a",token4a);
			session.setAttribute("currentYear",myDate);
			session.setAttribute("workNo",workNo);
			session.setAttribute("verifyFlag","false");
			System.out.println("页面框架版本为："+versonType);
			session.setAttribute("versonType",versonType);
			
			//add by mengxj for 客服整合 begin
			String accountType = str7[0][0];
			String kf_login_no = str8[0][0]; 
			/*****工号类型*****/
			session.setAttribute("accountType",accountType);
			/* ningtn 将工号登录结束时间记入session */
			String allowEnd = "";
			String getAllowEndSql = "SELECT TO_CHAR(allow_end, 'HH24miss')"
						+ " FROM dloginmsg WHERE TO_CHAR (SYSDATE, 'HH24miss') - TO_CHAR (allow_begin, 'HH24miss') > 0"
						+ " AND login_no = :login_no";
			String[] inParams = new String[2];
			inParams[0] = getAllowEndSql;
			inParams[1] = "login_no="+workNo;
%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" 
				 retcode="retCode1" retmsg="retMsg1" outnum="1"> 
			<wtc:param value="<%=inParams[0]%>"/>
			<wtc:param value="<%=inParams[1]%>"/> 
			</wtc:service> 
			<wtc:array id="allowEndRes" scope="end" />
<%
			System.out.println("======= qxjy == " + retCode1 + " , " + allowEndRes.length);
			if(retCode1.equals("000000")){
				if(allowEndRes.length > 0){
				System.out.println("======= qxjy ==allowEndRes[0][0] " + allowEndRes[0][0]);
					allowEnd = allowEndRes[0][0];
				}else{
%>
				<script language="javascript">
				rdShowMessageDialog("当前时间不允许该工号登录");
				window.open('/npage/login/index.html','','width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
				window.opener=null;
				this.close();
				</script>
<%
				}
			}
			System.out.println("======= qxjy ==allowEnd " + allowEnd);
			session.setAttribute("allowend",allowEnd);
			
			if( accountType.equals("2") ){
				//String kf_login_no = str8[0][0];
				session.setAttribute("kf_login_no",kf_login_no.trim());
			}
			System.out.println("kf_login_no=["+kf_login_no.trim()+"]");
			System.out.println("ng35 accountType="+accountType);
		  //add by mengxj end 
		
		    User user = new User();
		    user.setLoginNo(workNo);
		    user.setLoginName(str1[0][3]);
		    user.setIp(selfIp);
		    user.setLoginTime(DateUtils.getNowTime());
		    user.setUnitName(str3[0][5]+"-"+str3[0][6]+"-"+str3[0][7]);
		    Counter.login(selfIp,user);
		    Logger logger = Logger.getLogger("index.jsp");

	  try{
	  	    //add by yl.在session中增加工号的groupId
			String sqlStr ="SELECT a.group_id,b.group_name FROM dLoginMsg a,dChnGroupMsg b WHERE a.login_no='"+workNo+"' AND a.group_id=b.group_id";
			%>
			<wtc:pubselect name="sPubSelect" outnum="2">
			 <wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result" scope="end" />
			<%
			if( result.length > 0 ){
			  session.setAttribute("workGroupId",result[0][0]);
			  session.setAttribute("groupId",result[0][0]);
			  session.setAttribute("orgName",result[0][1]);
			}else {
				//add by liwl 因为有两套dchngroupmsg,所以做如下修改
				String sqlStr_temp ="SELECT a.group_id,b.group_name FROM dLoginMsg a,dbresadm.dChnGroupMsg b WHERE a.login_no='"+workNo+"' AND a.group_id=b.group_id";
			%>
			 <wtc:pubselect name="sPubSelect" outnum="2">
				<wtc:sql><%=sqlStr_temp%></wtc:sql>
			 </wtc:pubselect>
			 <wtc:array id="result" scope="end" />
			<%
				if( result.length > 0 ){
					session.setAttribute("workGroupId",result[0][0]);
					session.setAttribute("groupId",result[0][0]);
					session.setAttribute("orgName",result[0][1]);
			    }
		  	}
		 }catch(Exception e){
		       Logger groupIdLogger = Logger.getLogger("index.jsp");
	           groupIdLogger.error("Call sunView is Failed:get group_id!");
	     }

	    try{
	  	    //add by sunzx.在session中号段列表
			String sqlStr ="SELECT no FROM dbresadm.snotype order by no";
			%>
			<wtc:pubselect name="sPubSelect" outnum="1">
			 <wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result" scope="end" />
			<%

			if( result.length > 0 ){
				String []phoneHeadList = new String[result.length];

				for(int i=0 ; result != null && i< result.length; i++)
		        {
		        	phoneHeadList[i] = result[i][0];
		        }
				session.setAttribute("phoneHeadList",phoneHeadList);

			}
			else
			{
				session.setAttribute("phoneHeadList",null);
			}
		 }catch(Exception e){
		       Logger groupIdLogger = Logger.getLogger("index.jsp");
		       session.setAttribute("phoneHeadList",null);
	           groupIdLogger.error("Call View is Failed:get phoneHeadList!");
	     }
	    %>
	   	<script language="javascript">
				createCookie("workNo", "<%=workNo%>", 1000);
				
				createCookie("regionCode", "<%=regionCode%>", 1000);
				createCookie("workName", "<%=workName%>", 1000);
				createCookie("groupId", "<%=groupId%>", 1000);
	   	 	
		 var iVersonType = "<%=versonType%>";
	   	 	//update by songjia for 客服整合 20100203
	   	 	<%
	   	 	System.out.println("--------------kf_login_no---------------["+kf_login_no+"]-------------");
	   	 	//如果是客服工号则进入客服主页面
	     	 if("2".equals(accountType)){
	     	 String msid=workNo;
	     	 try{
	     	    
						String msidSql ="SELECT STAFFID FROM DBLNKUSR.V_C_UCP_STAFFBASICINFO@DBCALLLINK_44 WHERE MSID="+msid;
						%>
			   <wtc:pubselect name="sPubSelect" outnum="1">
			   <wtc:sql><%=msidSql%></wtc:sql>
			   </wtc:pubselect>
			   <wtc:array id="result" scope="end" />
			  <%
					if( result.length > 0 ){
						msid=(String)result[0][0];
						}
					
				}catch(Exception e){}
				//System.out.println("------------lipf--kf_login_no-----------msid----["+msid+"]-------------");
				if(!"".equals(msid)){
     				com.huawei.sso.client.util.SingleSignOnUtil.generateSsoStatus(request,msid);
     		}else{
   	 			  com.huawei.sso.client.util.SingleSignOnUtil.generateSsoStatus(request,"800920");
   			}
	     	 //com.huawei.sso.client.util.SingleSignOnUtil.generateSsoStatus(request,"800920");
			 	%>
	
	     	 
	
				window.location = "csp_hlj.jsp";
			 	//window.open('csp_hlj.jsp','BOSS','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0');
			 	<%
			 	}else{
				%>
			 	//如不是客服工号则登陆营业主页面
				if(iVersonType == "simple"){
					window.location = "main_simple.jsp";
					//window.open('main_simple.jsp','BOSS','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0');
				}else{
					window.location = "main.jsp";
					//window.open('main.jsp','BOSS','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0');
				}
				<%
			 	}
				%>	
			      
		        //解决速度慢问题测试需要，暂时封闭  ，正式环境放开 liubo
		        //location.href='main.jsp';

		     /*window.opener=null;
		     window.open("","_self");
		     window.close(); */
	     </script>
		<%
  }
}catch(Exception ex)
{
	ex.printStackTrace();
%>
	<script language="javascript">
		rdShowMessageDialog("登录异常，请重新登录");
		window.open('/npage/login/index.html','','width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
		window.opener=null;
	  this.close();
   </script>
<%
}
%>
</head>
</html>
