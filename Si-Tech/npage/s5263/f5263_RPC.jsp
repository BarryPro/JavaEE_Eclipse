<%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-07 页面改造,修改样式
	********************/
%>  
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
	//读取session信息		
	String loginNo=(String)session.getAttribute("workNo");    //工号 	
	String nopass = (String)session.getAttribute("password");	
	String regionCode =(String)session.getAttribute("regCode");   
	//错误信息，错误代码
	String errCode = "0";
	String errMsg = "";

	String agentPhone = request.getParameter("agentPhone");
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//ArrayList retList = null;  
	String[] paraStrIn = new String[3];
	String srvName = "s5263Cfm";
	String outParaNums = "28";

	paraStrIn[0] = loginNo;
	paraStrIn[1] = nopass;
	paraStrIn[2] = agentPhone;

	//retList = impl.callFXService(srvName,paraStrIn,outParaNums);
	%>
	<wtc:service name="<%=srvName%>" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="<%=outParaNums%>" >
		<wtc:param value="<%=paraStrIn[0]%>"/>
		<wtc:param value="<%=paraStrIn[1]%>"/>
		<wtc:param value="<%=paraStrIn[2]%>"/>		
	</wtc:service>
	<wtc:array id="retList" start="0" length="28" scope="end"/>
	<wtc:array id="retList1" start="23" length="4" scope="end"/>
	
	<%
	//int returnCode = impl.getErrCode();
	String returnCode=retCode1;
	System.out.println("returnCode:=================:"+returnCode);
	//String returnMsg = impl.getErrMsg();
	String returnMsg =retMsg1;
	System.out.println("returnMsg:=============:"+returnMsg);	
	System.out.println("========================================");

	if(retList != null){
		 //for(int i = 0;i < retList.get(0)).length;i++){
		 for(int i = 0;i < retList.length;i++){
			 for(int j = 0;j < 26;j++){
				 if(j == 17 || j == 25){
					String time =retList[i][j].trim();
					String changertime = null;
					if(time.length() == 14){
						String sign1 = "/";
						String sign2 = ":";
						String year = time.substring(0,4);
						String month = time.substring(4,6);
						String day = time.substring(6,8);
						String hour = time.substring(8,10);
						String minute = time.substring(10,12);
						String second = time.substring(12,14);
				
						changertime = year + sign1 + month + sign1 + day + " " + hour + sign2 + minute + sign2 + second;
	
						System.out.println(j+"*******************"+changertime);
					}
				 }else{
					System.out.println(j+"*******************");
				 }
			 }
		 }
}

%>

	var agent_name = new Array();
	var agent_address = new Array();
	var legal_present = new Array();
	var legal_id = new Array();
	var account_no = new Array();
	
	var agent_phone = new Array();
	var register_money = new Array();
	var contact_person = new Array();
	var contact_id = new Array();
	var contact_phone = new Array();
	
	var bank_name = new Array();
	var bank_code = new Array();
	var deposit = new Array();
	var agent_size = new Array();
	var person_count = new Array();
	
	var person_count1 = new Array();
	var pb_size = new Array();
	var sign_time = new Array();
	var father_agent = new Array();
	var limit_owe = new Array();
	
	var agent_code = new Array();
	var agent_type = new Array();
	var describe = new Array();
	var entity_group_name = new Array();
	
	var work_no = new Array();
	var amend_time = new Array();
	var amend_before = new Array();
	var amend_after = new Array();


<%
	if(retList != null && returnCode.equals("000000")){
		// for(int i = 0;i < ((String[][])retList.get(0)).length;i++){
		for(int i = 0;i < retList.length;i++){%>
			agent_name[<%=i%>] = '<%=retList[i][0]%>';
			agent_address[<%=i%>] = '<%=retList[i][1]%>';
			legal_present[<%=i%>] = '<%=retList[i][2]%>';
			legal_id[<%=i%>] = '<%=retList[i][3]%>';
			account_no[<%=i%>] = '<%=retList[i][4]%>';
	
			agent_phone[<%=i%>] = '<%=retList[i][5]%>';
			register_money[<%=i%>] = '<%=retList[i][6]%>';
			contact_person[<%=i%>] = '<%=retList[i][7]%>';
			contact_id[<%=i%>] = '<%=retList[i][8]%>';
			contact_phone[<%=i%>] = '<%=retList[i][9]%>';
	
			bank_name[<%=i%>] = '<%=retList[i][10]%>';
			bank_code[<%=i%>] = '<%=retList[i][11]%>';
			deposit[<%=i%>] = '<%=retList[i][12]%>';
			agent_size[<%=i%>] = '<%=retList[i][13]%>';
			person_count[<%=i%>] = '<%=retList[i][14]%>';
	
			person_count1[<%=i%>] = '<%=retList[i][15]%>';
			pb_size[<%=i%>] = '<%=retList[i][16]%>';
			<%
			String time = retList[i][17].trim();
			String changertime = "";
			if(time.length() == 14){
				String sign1 = "/";
				String sign2 = ":";
				String year = time.substring(0,4);
				String month = time.substring(4,6);
				String day = time.substring(6,8);
				String hour = time.substring(8,10);
				String minute = time.substring(10,12);
				String second = time.substring(12,14);
				
				changertime = year + sign1 + month + sign1 + day + " " + hour + sign2 + minute + sign2 + second;
			}
			%>
			sign_time[<%=i%>] = '<%=changertime%>';
			father_agent[<%=i%>] = '<%=retList[i][18]%>';
			limit_owe[<%=i%>] = '<%=retList[i][19]%>';
	
			agent_code[<%=i%>] = '<%=retList[i][20]%>';
			agent_type[<%=i%>] = '<%=retList[i][21]%>';
			describe[<%=i%>] = '<%=retList[i][22]%>';
			entity_group_name[<%=i%>] = '<%=retList[i][27]%>';
			<%
		}
	if(retList1!=null){
		for(int i = 0;i < retList1.length;i++){
		
		%>
			amend_before[<%=i%>] = '<%=retList1[i][0]%>';
			amend_after[<%=i%>] = '<%=retList1[i][1]%>';
			work_no[<%=i%>] = '<%=retList1[i][2]%>';
			amend_time[<%=i%>]=<%=retList1[i][3].substring(0,8)%>
			
			<%
			/*String time1 = retList.get(26))[i][0].trim();
			String changertime1 = "";
			if(time1.length() == 14){
				String sign1 = "/";
				String sign2 = ":";
				String year = time1.substring(0,4);
				String month = time1.substring(4,6);
				String day = time1.substring(6,8);
				String hour = time1.substring(8,10);
				String minute = time1.substring(10,12);
				String second = time1.substring(12,14);
				
				changertime1 = year + sign1 + month + sign1 + day + " " + hour + sign2 + minute + sign2 + second;
			}
			*/
	
		}
		}
	}
	
%>

	var response = new AJAXPacket();	
	response.data.add("agentPhone","<%=agentPhone%>");
	response.data.add("agent_name",agent_name);
	response.data.add("agent_address",agent_address);
	response.data.add("legal_present",legal_present);
	response.data.add("legal_id",legal_id);
	response.data.add("account_no",account_no);
	
	response.data.add("agent_phone",agent_phone);
	response.data.add("register_money",register_money);
	response.data.add("contact_person",contact_person);
	response.data.add("contact_id",contact_id);
	response.data.add("contact_phone",contact_phone);
	
	response.data.add("bank_name",bank_name);
	response.data.add("bank_code",bank_code);
	response.data.add("deposit",deposit);
	response.data.add("agent_size",agent_size);
	response.data.add("person_count",person_count);
	
	response.data.add("person_count1",person_count1);
	response.data.add("pb_size",pb_size);
	response.data.add("sign_time",sign_time);
	response.data.add("father_agent",father_agent);
	response.data.add("limit_owe",limit_owe);
	
	response.data.add("agent_code",agent_code);
	response.data.add("agent_type",agent_type);
	response.data.add("describe",describe);
	response.data.add("entity_group_name",entity_group_name);
	
	response.data.add("work_no",work_no);
	response.data.add("amend_time",amend_time);
	response.data.add("amend_before",amend_before);
	response.data.add("amend_after",amend_after);
	
	response.data.add("errCode","<%=returnCode%>");
	response.data.add("errMsg","<%=returnMsg%>");
	core.ajax.receivePacket(response);
