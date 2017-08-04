<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-16 页面改造,修改样式
********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String cust_name = "";
	String strIdType = "";
	String strTypeName = "";
	String strTypeNo = "";
	String strCustAddress = "";
	String strContactNo = "";
	String retCode = "";
	String retMsg = "";
	String SqlStr1 = "";
	String strValidFlag = "";
	String[][]psot = new String [][]{};
	String phoneNo = request.getParameter("phoneNo");
	System.out.println("phoneNO ===: "+ phoneNo);
	//comImpl co1 = new comImpl();

	SqlStr1 = "select b.cust_name from dcustmsg a, dCustDoc b where a.cust_id = b.cust_id and  a.phone_no ='"+phoneNo+"' and substr(run_code,2,1) < 'a'";
	retMsg = "用户信息资料不存在，不能录入!";	 

	//ArrayList arr1 = co1.spubqry32("1", SqlStr1);	
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=SqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="arr1" scope="end" />
	
<%
	psot=arr1;
	System.out.println("psot[0][0]=================="+psot[0][0]);
	if(psot!=null&&psot.length>0&&psot.length == 1){
		cust_name = psot[0][0];
		SqlStr1 = "SELECT c.cust_name,c.id_type||'-->'||c.id_type_name,c.id_type_no,c.cust_address,c.contact_no,valid_flag  FROM dPhoneRealNameMsg c WHERE c.phone_no='"+phoneNo+"'";
		

		//arr1 = co1.spubqry32("6", SqlStr1);	
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="6">
			<wtc:sql><%=SqlStr1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="arr2" scope="end" />
	<%
		
		psot = arr2;		
		System.out.println("arr2=================="+arr2.length);
		if(psot!=null&&psot.length>0&&psot.length == 1)
		{
			System.out.println("1");
			cust_name = psot[0][0];
			strTypeName = psot[0][1];
			strTypeNo = psot[0][2];
			strCustAddress = psot[0][3];
			strContactNo = psot[0][4];
			strValidFlag = psot[0][5]; 
		}else
		{
			retCode = "100002";
			retMsg = "用户实名预登记信息不存在!";
		}
	}else{
		retCode = "100001";
		retMsg = "用户信息资料不存在，不能录入!";
	}

	String rpcPage = "realName";
%>
var response = new AJAXPacket();

var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";
var cust_name = "<%=cust_name%>";
var type_name = "<%=strTypeName%>";
var type_no = "<%=strTypeNo%>";
var contact_no = "<%=strContactNo%>";
var cust_address = "<%=strCustAddress%>";
var valid_flag = "<%=strValidFlag%>";
var rpcPage = "<%=rpcPage%>";

response.data.add("rpc_page",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("cust_name",cust_name); 
response.data.add("type_name",type_name); 
response.data.add("type_no",type_no);
response.data.add("contact_no",contact_no);
response.data.add("cust_address",cust_address);
response.data.add("valid_flag",valid_flag);
core.ajax.receivePacket(response);
