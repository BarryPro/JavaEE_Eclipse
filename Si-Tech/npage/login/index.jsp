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
<title>�������ƶ��ۺϿͻ�����ϵͳ</title>
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
	    rdShowMessageDialog("��ʹ��IE5.5����(����IE5.5)�������",0);
	    clo.Click();
	}
</script>

<jsp:include page="/npage/contact/GetCnttStatus.jsp" flush="true" />
<%
	String workNo = request.getParameter("staffNo");
	String nopass = request.getParameter("password");
	String macAddr = request.getParameter("uuidCode");//add by gaolw �ͻ���mac��ַ
	System.out.println(workNo+"2---------------------------------------"+nopass+"----------------------------------"+macAddr);
	String versonType = request.getParameter("versonType"); // ҳ���ܰ汾:: normal:��ͨ��;simple:���ٰ�.
	String paramStr="l/"+workNo;
	/* 4a */
	String addressFlag = request.getParameter("addressFlag")==null? "" : request.getParameter("addressFlag");
	String token4a = request.getParameter("token4a")==null? "" : request.getParameter("token4a");
	System.out.println("addressFlag ----------> " + addressFlag + " | " + token4a);
	Date date=new Date();
	SimpleDateFormat myFmt=new SimpleDateFormat("yyyyMMdd");
	String myDate = myFmt.format(date);
	/*
	*��ֹ��4a��½��ʱ��������֤��������� yanpx 
	*1.��login_4a�еĹ�����request�еĹ��Ų�����
	*2.��session�е�token��request�е�token������
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
			/*���session�е�token��Ϊ�գ��������ȡ�Ĳ������ֱ�ӹر�ҳ��*/
			System.out.println("ningtn error token");
%>
				<SCRIPT language="javascript">
					window.open("","_self");
					window.close();
				</SCRIPT>
<%
		}	
	}
/* liyan 20090925 Ϊ���session�������⣬������session���� begion*/
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


//add by liubo �洢���ֻ�����Ϊ�����ĽӴ���Ϣ
session.setAttribute("contactInfoMap",new HashMap());
//add by liubo �洢�Կͻ�����Ϊ�����ĽӴ���Ϣ
session.setAttribute("contactInfo",new HashMap());
//add by liubo �洢�Կͻ�����Ϊ����,�ͻ���Ӧ�û���������Ϊֵ�Ĺ�����Ϣ 
session.setAttribute("contactInfoRelation",new HashMap());
//add by liubo �洢���ֻ�����Ϊ����������У��ʱ����Ϣ
session.setAttribute("contactTimeMap",new HashMap());

HashMap hm = new HashMap(); //custid - У���־λ

session.setAttribute("phoneKfCheck",hm);

String selfIp =  request.getParameter("localclientip")==null? request.getRemoteAddr() : request.getParameter("localclientip");

//System.out.println("workNo="+workNo);
//System.out.println("nopass="+nopass);
//System.out.println("selfIp="+selfIp);
String sessionIdStr = session.getId();
/*add begin ����4a�˺���� for �������ҵ��֧���������ϵͳ��������ĺ�-CRM��¼��־���Ӽ�¼4A���˺���Ϣ@2014/11/10 */
//token4a = "Token=OGFlZWVmNDEyYzNlODQ2MDAxMmM0MDBhNzU2YzAyMmEtOGFmNWM2YTY0OTE4ODc1ODAxNDkxYmY2OTU1MjAxNzcxNDEzNTEzMzg1Mjk4QGJlOGI3NDIyNjMwMTRjYzZhMmY1ZjVmYzMzNjQxOTgyOjhhZWVlZjQxMzEzYzg5M2QwMTMxNDVhOGNkMDAwN2RkQGxpdXlhbmZhbmc=@b20035@8aeeef412c3e8460012c400a756c022a@liuyanfang@iam35]";
String v_loginNo_4a = "";
if(token4a.indexOf("@") != -1){
	v_loginNo_4a = token4a.split("@")[3];
}
/*add end ����4a�˺���� @2014/11/10 */
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
    <wtc:param value="<%=v_loginNo_4a%>" /> <% /*add ����4a�˺���� for �������ҵ��֧���������ϵͳ��������ĺ�-CRM��¼��־���Ӽ�¼4A���˺���Ϣ@2014/11/10 */ %>
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
	 //��½bossϵͳ
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
			//add by mengxj for �ͷ�����
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

/**  modified by hejwa in 20110714 ��OP����  begin **/			
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
				//�������Ѿ����ã����Ȱ��չ������ý�����ʾ��������û���������ս�ɫ���õ�Ĭ��ѡ�������ʾ
				//sqlΪ���ֽ�ɫ��ϵ�������ɫ��ϵ��Ĭ��ֵ
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
			/**  modified by hejwa in 20110714 ��OP����  end **/
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

			/*****��������*****/
			session.setAttribute("orgCode",orgCode);

			/*****ip��ַ*****/
			session.setAttribute("ipAddr",selfIp);

			/*****�Ż���Ϣ*****/
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
			System.out.println("ҳ���ܰ汾Ϊ��"+versonType);
			session.setAttribute("versonType",versonType);
			
			//add by mengxj for �ͷ����� begin
			String accountType = str7[0][0];
			String kf_login_no = str8[0][0]; 
			/*****��������*****/
			session.setAttribute("accountType",accountType);
			/* ningtn �����ŵ�¼����ʱ�����session */
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
				rdShowMessageDialog("��ǰʱ�䲻����ù��ŵ�¼");
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
	  	    //add by yl.��session�����ӹ��ŵ�groupId
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
				//add by liwl ��Ϊ������dchngroupmsg,�����������޸�
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
	  	    //add by sunzx.��session�кŶ��б�
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
	   	 	//update by songjia for �ͷ����� 20100203
	   	 	<%
	   	 	System.out.println("--------------kf_login_no---------------["+kf_login_no+"]-------------");
	   	 	//����ǿͷ����������ͷ���ҳ��
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
			 	//�粻�ǿͷ��������½Ӫҵ��ҳ��
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
			      
		        //����ٶ������������Ҫ����ʱ���  ����ʽ�����ſ� liubo
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
		rdShowMessageDialog("��¼�쳣�������µ�¼");
		window.open('/npage/login/index.html','','width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
		window.opener=null;
	  this.close();
   </script>
<%
}
%>
</head>
</html>
