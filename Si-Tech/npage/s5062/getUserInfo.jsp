<%
  /*
   * 功能: 短信催缴定制2280
   * 版本: 1.0
   * 日期: 2008/01/13
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%      
	String phoneNo = request.getParameter("phoneNo");	
	String password = WtcUtil.repNull(request.getParameter("password"));
	String regionCode=(String)session.getAttribute("regCode");	
	String sql0 = "select user_passwd from dcustmsg where phone_no = '"+phoneNo+"'";
%>
	<wtc:pubselect name="TlsPubSelBoss"  routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg1">
		<wtc:sql><%=sql0%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="agentCodeStr" scope="end" />
<%	
//	comImpl co = new comImpl();
//	ArrayList agentCodeArr = co.spubqry32("1",sql0);
//	String[][] agentCodeStr = (String[][])agentCodeArr.get(0);
	//System.out.println("***************[agentCodeStr]["+agentCodeStr[0][0]+"]****************");
	String errcode;
     
  String user_name;
	String user_status;
	String card_type;
	String card_no;
	String awake_fee;
	String awake_times;
	String calling_times;
	String begin_hm;
	String end_hm;
	String time_flag;
	String forbid_flag;
	String contact_address;
	String contact_phone;
	
	
	
//		S1100View callView = new S1100View();
//		ArrayList arr2 = new ArrayList();
		String sql="select b.cust_name,c.run_name,d.ID_NAME, b.ID_ICCID, to_char(e.AWAKE_FEE), to_char(e.AWAKE_TIMES),to_char(e.calling_times),e.begin_hm,e.end_hm,to_char(e.time_flag),to_char(e.forbid_flag),b.contact_address,b.contact_phone from dCustMsg a, dCustDoc b, sRunCode c, sIdType d ,dCustAwake e where substr(a.belong_code,1,2) = c.region_code and a.id_no = e.id_no(+) and substr(a.run_code,2,1) = c.run_code and a.cust_id  = b.cust_id and b.id_type = d.id_type and a.phone_no='"+phoneNo+"'";
		System.out.println("sql===="+sql);
//		arr2 = callView.view_spubqry32("13",sql);
//		String result[][] = (String[][])arr2.get(0);
%>
	<wtc:pubselect name="TlsPubSelCrm"  routerKey="region" routerValue="<%=regionCode%>" outnum="15" retcode="retCode1" retmsg="retMsg">
		<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%		
	System.out.println("result===="+result.length);
	if (result.length==0){
		errcode="0";
		user_name = "wrong";
		user_status = "wrong";
		card_type = "wrong";
		card_no = "wrong";
	    
	    awake_fee = "wrong";
	    awake_times = "wrong";
	    calling_times = "wrong";
	    begin_hm = "wrong";
	    end_hm = "wrong";
	    time_flag = "wrong";
	    forbid_flag = "wrong";
		contact_address="wrong";
		contact_phone="wrong";
	}
	else{
		errcode="1";
		user_name = result[0][0];
		user_status = result[0][1];
		card_type = result[0][2];
		card_no = result[0][3];
        
		awake_fee = result[0][4];
	    awake_times = result[0][5];
	    calling_times = result[0][6];
	    begin_hm = result[0][7];
	    end_hm = result[0][8];
	    time_flag = result[0][9];
	    forbid_flag = result[0][10];
		contact_address = result[0][11];
	    contact_phone = result[0][12];
	}

	
	//System.out.println("------------------"+result.length);

%>
var response = new AJAXPacket();
response.data.add("user_status","<%=user_status%>");
response.data.add("card_type","<%=card_type%>");
response.data.add("card_no","<%=card_no%>");
response.data.add("user_name","<%=user_name%>");
response.data.add("errcode","<%=errcode%>");

response.data.add("awake_fee","<%=awake_fee%>");
response.data.add("awake_times","<%=awake_times%>");
response.data.add("calling_times","<%=calling_times%>");
response.data.add("begin_hm","<%=begin_hm%>");
response.data.add("end_hm","<%=end_hm%>");
response.data.add("time_flag","<%=time_flag%>");
response.data.add("forbid_flag","<%=forbid_flag%>");
response.data.add("contact_address","<%=contact_address%>");
response.data.add("contact_phone","<%=contact_phone%>");

core.ajax.receivePacket(response);

