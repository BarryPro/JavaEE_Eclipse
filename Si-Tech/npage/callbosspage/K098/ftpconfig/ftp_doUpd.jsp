<%
  /*
   * 功能: FTP配置->更新数据(业务逻辑)
　 * 版本: 1.0.0
　 * 日期: 2009/3/15
　 * 作者: fangyuan
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
//jiangbing 20091118 批量服务替换
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
	String ip = WtcUtil.repNull(request.getParameter("ip"));
	String port = WtcUtil.repNull(request.getParameter("port"));
	String username = WtcUtil.repNull(request.getParameter("username"));
	String passwd = WtcUtil.repNull(request.getParameter("passwd"));
	String panfu = WtcUtil.repNull(request.getParameter("panfu"));
	String workNo = (String)session.getAttribute("workNo");	// boss工号代码
     String myip = request.getRemoteAddr();
     String sql_update="update dcallftpservercfg t set t.ftp_user=:v1,t.ftp_passwd=:v2 where t.ftp_ip=:v3 and t.ftp_port=:v4 and t.ftp_dir=:v5&&"+username+"^"+passwd+"^"+ip+"^"+port+"^"+panfu;
	String sql_log="insert into dbcalladm.wloginopr(LOGIN_ACCEPT,OP_CODE,OP_TIME,OP_DATE,LOGIN_NO,ORG_CODE,PHONE_NO,IP_ADDR,OP_NOTE,FLAG,CALL_ID,CONTACT_ID,CONTACT_FLAG) values(seq_wloginopr.nextval,'K103',sysdate,to_char(sysdate,'yyyymmdd'),:v1,'','',:v2,:v3,'U','','','')&&"+workNo+"^"+myip+"^更新FTP配置信息,ip="+ip;
	
	//System.out.println("================================");
	//System.out.println("===========sql_update============= "+sql_update);
	//System.out.println("================================");
	//批量操作
	List sqlList=new ArrayList();
	String[] sqlArr = new String[]{};
	sqlList.add(sql_update);
	sqlList.add(sql_log);
	sqlArr=(String[])sqlList.toArray(new String[0]);
	String outnum = String.valueOf(sqlArr.length + 1); 
%>

<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
			<wtc:param value="<%=sqlMulKfCfm%>"/>
			<wtc:param value="dbchange"/>
			<wtc:params value="<%=sqlArr%>"/>
			</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);