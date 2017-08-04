<%
/********************
 * version v2.0
 * 开发商: si-tech
 * create by wanglm @ 2010-12-09
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>  
<%
    String workNo = (String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String loginNo = request.getParameter("loginNo");
	String sql = "select * from (select my_table.*, rownum as my_rownum from "
			+ "(select a.login_no,a.login_name,a.password,a.power_code,"
			+ "a.power_right,a.login_flag,to_char(a.op_time,'yyyymmdd hh24:mi:ss'),a.rpt_right, "
			+ "to_char(a.allow_begin,'yyyymmdd hh24:mi:ss'),"
			+ "to_char(a.allow_end,'yyyymmdd hh24:mi:ss'), "
			+ "to_char(a.pass_time,'yyyymmdd hh24:mi:ss'), "
			+ "to_char(a.expire_time,'yyyymmdd hh24:mi:ss'),"
			+ "a.try_times,a.vilid_flag,a.maintain_flag,a.org_code,a.region_char,"
			+ "a.district_char,a.relogin_flag,a.dept_code,a.login_status,a.ip_address,"
			+ "to_char(a.run_time,'yymmdd hh24:mi:ss'),a.contract_phone, "
			+ "a.SENDPWD_FLAG,a.IPBIND_FLAG,a.MAX_ERRNUM,"
			+ "a.Account_no,a.account_type,a.group_id,nvl(b.power_name,'未定义'),c.Mail_Code,d.account_name "
			+ "from dLoginMsg a,sPowerCode b,dloginmsgmail c,sAccType d where a.power_code = b.power_code(+) and a.login_no = c.login_no "
			+ " and a.account_type = d.account_type " ;	
		if(workNo.substring(0,1).equals("8") || workNo.substring(0,1).equals("9"))
		{
			sql = sql + " and account_type = '2' ";
		}
		sql = sql + "and a.login_no = '"+loginNo+"' order by login_no ) my_table ) ";
		
 	System.out.println("wanglm test ----sql-------------------------- " + sql);	
	String flag = ""; /*判断是否为空*/
	String flag1 = ""; /*判断是否失效*/
	String opcode = "";
	String opcode_type = "";
	String opname = "";
	String role = "";
	String power = "";
	String availability = "";
	String accTypeName = "营业类BOSS帐号";
    String  validFlagValue="";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="33">
		<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
   <%
    String[][] nott = result;
    
	if(nott.length ==  0){
	   flag = "false";
    }else{
    flag = "true";	
    opcode = nott[0][27];
    opname = nott[0][1];
    role = nott[0][30]+"("+nott[0][3]+")";
    power = nott[0][4];
    
	if(nott[0][28].equals("2"))
	{
		accTypeName = "客服帐号";
	}
	else if(nott[0][28].equals("3"))
	{
		accTypeName = "管理类BOSS帐号";
	}
	if(nott[0][13].equals("1"))
	{
		validFlagValue="有效";
		flag1 = "true";
	}
	if(nott[0][13].equals("0"))
	{
		validFlagValue="无效";
		flag1 = "false";
	}
	System.out.println(".............................................. opcode    " + opcode);
	System.out.println(".............................................. opcode_type     " + accTypeName);
    System.out.println(".............................................. opname     " + opname);
    System.out.println(".............................................. role     " + role);
	System.out.println(".............................................. power    " + power);
	System.out.println(".............................................. availability    " + validFlagValue);
	}
	System.out.println(".............................................. flag    " + flag);
	%>
	
	
var response = new AJAXPacket();
response.data.add("flag","<%=flag%>");
response.data.add("flag1","<%=flag1%>");
response.data.add("opcode","<%=opcode%>");
response.data.add("opcode_type","<%=accTypeName%>");
response.data.add("opname","<%=opname%>");
response.data.add("role","<%=role%>");
response.data.add("power","<%=power%>");
response.data.add("availability","<%=validFlagValue%>");
core.ajax.receivePacket(response);

	    
		