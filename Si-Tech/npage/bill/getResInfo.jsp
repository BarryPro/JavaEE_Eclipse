<%
/********************
 version v2.0
开发商: si-tech
********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
  int errCode = 0;
  String errMsg = "查询成功";  
  String sqlStr = "";
  String area_flag = "0";
  String rpcPage = "getResInfo";
  
	String login_no = request.getParameter("LoginNo");
	String mis_code = request.getParameter("MisCode");
	String jtFlag = request.getParameter("JtFlag");   //市场部库存时为01，集团库存时为02
	
	String regionCode=(String)session.getAttribute("regCode");
	
  /*ArrayList retArray = new ArrayList();
  String[][] modeTypeArr ;  
  String[][] result ;*/
  
System.out.println("rpcPage ===================="+rpcPage);
  /*SPubCallSvrImpl co = new SPubCallSvrImpl();
  sqlStr = "select a.store_number from dbgiftrun.dchnresbalance a,dloginmsg b,dbgiftrun.schngiftrescode c where a.year_month = to_char(sysdate,'yyyymm') and b.login_no = '"
  			+login_no+
  			"' and c.mis_code = '"
  			+mis_code+
  			"' and a.belong_code = '"
  			+jtFlag+
  			"' and a.res_code = c.res_code and a.group_id = b.group_id " ;
			
  retArray = co.sPubSelect("1",sqlStr);
  modeTypeArr = (String[][])retArray.get(0);
  
  
  sqlStr = "select a.store_number from dbgiftrun.dchnresbalance a,dloginmsg b,dbgiftrun.schngiftrescode c where a.year_month = to_char(sysdate,'yyyymm') and b.login_no = '?' and c.mis_code = '?' and a.belong_code = '?' and a.res_code = c.res_code and a.group_id = b.group_id " ;
   */         
	sqlStr = "select a.STORE_NUM from dbgiftrun.RS_PROGIFT_UNORDER_INFO_XX a,dloginmsg b,dbgiftrun.rs_code_info c where b.login_no = '?' and c.BAK = '?' and a.belong_code = '?' and a.res_code = c.res_code and a.group_id = b.group_id ";
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode1" retmsg="errMsg2" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
	<wtc:param value="<%=login_no%>"/>
	<wtc:param value="<%=mis_code%>"/>
	<wtc:param value="<%=jtFlag%>"/>
</wtc:pubselect>
<wtc:array id="modeTypeArr" scope="end"/>

<%
  
  int res_num = 0;
  int appointed_num = 0;
  
  if(modeTypeArr!=null)
  {
  	if(modeTypeArr[0][0]!=null &&  !"".equals(modeTypeArr[0][0]) )
    	res_num = Integer.parseInt(modeTypeArr[0][0]);
    System.out.println("modeTypeArr[0][0]===================="+modeTypeArr[0][0]);
    /*sqlStr = "select sum(c.res_num) from dbgiftrun.schngiftrescode a,dloginmsg b,dbgiftrun.dchnrescustgift c where b.login_no = '"
    		+login_no+
    		"' and a.mis_code = '"
    		+mis_code+
    		"' and c.belong_code = '"
    		+jtFlag+
    		"' and c.OUT_STATUS = '2' and b.group_id = c.out_group and a.RES_CODE = c.RES_CODE ";
	retArray = co.sPubSelect("1",sqlStr);
	modeTypeArr = (String[][])retArray.get(0);
	sqlStr = "select sum(c.res_num) from dbgiftrun.schngiftrescode a,dloginmsg b,dbgiftrun.dchnrescustgift c where b.login_no = '?' and a.mis_code = '?' and c.belong_code = '?' and c.OUT_STATUS = '2' and b.group_id = c.out_group and a.RES_CODE = c.RES_CODE ";
	*/
	sqlStr = "select sum(c.res_num) from dbgiftrun.rs_code_info a,dloginmsg b,dbgiftrun.rs_progift_cust_reservation c where b.login_no = '?' and a.bak = '?' and c.belong_code = '?' and c.OUT_STATUS = '2' and b.group_id = c.out_group and a.RES_CODE = c.RES_CODE ";
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode1" retmsg="errMsg2" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
	<wtc:param value="<%=login_no%>"/>
	<wtc:param value="<%=mis_code%>"/>
	<wtc:param value="<%=jtFlag%>"/>
</wtc:pubselect>
<wtc:array id="modeTypeArr" scope="end"/>

<%
	if(modeTypeArr!=null)
	{
	System.out.println("modeTypeArr[0][0]===================="+modeTypeArr[0][0]);
		if(modeTypeArr[0][0]!=null &&  !"".equals(modeTypeArr[0][0]) )
	  	appointed_num = Integer.parseInt(modeTypeArr[0][0]);
	}
  }
System.out.println("rpcPage ==================== "+ rpcPage);
System.out.println("res_num-appointed_num===================="+(res_num-appointed_num));
%>

var rpcPage="<%=rpcPage%>";
var area_flag="<%=area_flag%>";

var response = new AJAXPacket();
response.guid		= '<%= request.getParameter("guid") %>';

response.data.add("rpcPage",rpcPage); 
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>"); 

response.data.add("available_num","<%=res_num-appointed_num%>");

core.ajax.receivePacket(response);
