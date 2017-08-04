<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
 
<script>
	if(window.opener!=undefined){
		window.opener=undefined;
	}else if(window.parent!=undefined){
		window.parent=undefined;
	}
</script>	
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<html>
<head>
<title>黑龙江移动综合客户服务系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<OBJECT id="clo" type="application/x-oleobject" classid="clsid:adb880a6-d8ff-11cf-9377-00aa003b7a11"><PARAM name="Command" value="Close"></OBJECT>
<script>
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
String workNo  = (String)request.getParameter("staffNo");
String oWorkNo = "";
if(session.getAttribute("workNo")!=null){
	oWorkNo = (String)session.getAttribute("workNo");
}
String nopass  = (String)request.getParameter("password");
String macAddr = (String)request.getParameter("uuidCode");//add by gaolw 客户端mac地址
String phoneNoPms = (String)request.getParameter("phoneNoPms");
session.setAttribute("phoneNoPms",phoneNoPms);


System.out.println(workNo+"2---------------------------------------"+nopass+"----------------------------------"+macAddr);
String versonType = "normal"; // 页面框架版本:: normal:普通版;simple:高速版.
String paramStr="l/"+workNo;

Date date=new Date();
SimpleDateFormat myFmt=new SimpleDateFormat("yyyyMMdd");
String myDate=myFmt.format(date);

session.setAttribute("workNo",null);
session.setAttribute("currentYear",null);
session.setAttribute("verifyFlag",null);
session.setAttribute("contactInfoMap",null);
session.setAttribute("contactInfo",null);
session.setAttribute("contactInfoRelation",null);
session.setAttribute("contactTimeMap",null);


session.setAttribute("currentYear",myDate);

session.setAttribute("verifyFlag","false");

session.setAttribute("versonType",null);
System.out.println("页面框架版本为："+versonType);
session.setAttribute("versonType",versonType);

//add by liubo 存储以手机号码为主键的接触信息
	ContactInfo contactInfo = new ContactInfo();
    contactInfo.setPhoneno(phoneNoPms);
    contactInfo.setPasswdVal("",0);
	contactInfo.setPasswd_status(""); 
	System.out.println("-hjw----phoneNoPms--"+phoneNoPms);
    Map map = new HashMap();
    map.put(phoneNoPms, contactInfo);
    
	session.setAttribute("contactInfoMap",map);
	session.setAttribute("cssPath","default");
//add by liubo 存储以客户号码为主键的接触信息
session.setAttribute("contactInfo",new HashMap());
//add by liubo 存储以客户号码为主键,客户对应用户号码数组为值的关联信息 
session.setAttribute("contactInfoRelation",new HashMap());
//add by liubo 存储以手机号码为主键的密码校验时间信息
session.setAttribute("contactTimeMap",new HashMap());

HashMap hm = new HashMap(); //custid - 校验标志位

session.setAttribute("phoneKfCheck",hm);

String selfIp = request.getRemoteAddr();//从请求中获得ip地

//System.out.println("workNo="+workNo);
//System.out.println("nopass="+nopass);
//System.out.println("selfIp="+selfIp);
/**zhangyan add 电话经理渠道标志  2010-12-09 11:06:18 b
电话经理的class_code 定为22 , 
传入sLoginCheck的第五个参数
***********/
String chn_code = "22";
/*传入sLoginCheck的参数*/
System.out.println("workNo="+workNo);
System.out.println("nopass"+nopass);
System.out.println("selfIp="+selfIp);
System.out.println("macAddr="+macAddr);
System.out.println("chn_code="+chn_code);
/**zhangyan add 电话经理渠道标志  2010-12-09 11:06:18 e***********/

if(oWorkNo==null) oWorkNo = "";
System.out.println("-----hjw--session里面-oWorkNo="+oWorkNo+"----入参workNo="+workNo+"----!oWorkNo.equals(workNo)------"+(!oWorkNo.equals(workNo)));

if(!oWorkNo.equals(workNo)){
try{ 
%>
<wtc:service name="sLoginCheck" outnum="46" retmsg="retMsg" retcode="code" >
	<wtc:param value="<%=workNo%>" />
    <wtc:param value="<%=nopass%>" />
    <wtc:param value="<%=selfIp%>" />
    <wtc:param value="<%=macAddr%>" />
    <wtc:param value="<%=chn_code%>" />
</wtc:service>
<wtc:array id="str1" start="0"  length="24" scope="end"/>
<%
if(!str1[0][0].equals("000000")&&!str1[0][0].equals("900099")){
%>
<script language="javascript">
	rdShowMessageDialog("<%=code%>:<%=retMsg%>");
  	window.close();
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
			session.setAttribute("workNo",workNo);
			session.setAttribute("allArr",arr);
			session.setAttribute("password",lastPass);
			session.setAttribute("workName",workName);
			session.setAttribute("groupId",groupId);
			session.setAttribute("powerCode",powerCode);
			session.setAttribute("orgId",orgId);
			session.setAttribute("powerRight",powerRight);
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
			//add by mengxj for 客服整合 begin
			String accountType = str7[0][0];
			String kf_login_no = str8[0][0]; 
			/*****工号类型*****/
			session.setAttribute("accountType",accountType);
			if( accountType.equals("2") ){
				//String kf_login_no = str8[0][0];
				session.setAttribute("kf_login_no",kf_login_no.trim());
			}			
			System.out.println("kf_login_no=["+kf_login_no.trim()+"]");
			System.out.println("accountType="+accountType);
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
			if(retCode1.equals("000000")){
				if(allowEndRes.length > 0){
					allowEnd = allowEndRes[0][0];
				}
			}
			session.setAttribute("allowend",allowEnd);
	    %>
	   	 <script language="javascript">
			window.open('main_pms.jsp','BOSS','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0');
			window.close();
	     </script>
		<%
  }
}catch(Exception ex)
{
	ex.printStackTrace();
%>
	<script language="javascript">
		rdShowMessageDialog("跳转异常，请重试",0);
		window.close();
   </script>
<%
}
}else{
%>	
		<script language="javascript">
			rdShowMessageDialog("请先关闭购物车页面后操作",0);
			window.close();
	     </script>
<%	
	}
%>
</head>
</html>
