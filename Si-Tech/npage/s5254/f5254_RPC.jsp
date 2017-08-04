 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-07 页面改造,修改样式
	********************/
%>  
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>

<%
	//读取session信息	
	String orgCode = (String)session.getAttribute("orgCode");   
	String regionCode = (String)session.getAttribute("regCode");           
	String districtCode = orgCode.substring(2,4);

	//错误信息，错误代码
	String errCode = "0";
	String errMsg = "";
	String errCode2 = "0";
	String errMsg2 = "";
	String groupId = request.getParameter("groupId");
	String type = request.getParameter("type");

//------------------------------------根据代理商编号查询帐户列表---------------------------------------

	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//ArrayList retList = new ArrayList();
	//String sqlStr = "select agt_phone,contract_no,status from dagtbasemsg where agt_id='"+groupId+"'";
	 String sqlStr="select a.agt_phone,a.contract_no,a.status,nvl(b.prepay_fee,0) prepay_fee from dagtbasemsg a ,dconmsgpre@bossquery b where a.contract_no = b.contract_no(+) and a.agt_id='"+groupId+"'";
	//retList = impl.sPubSelect("3",sqlStr,"region",regionCode);
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
	<%
		
		errCode=retCode1; //错误代码
		System.out.println("errCode1=========:"+errCode);		
		errMsg=retMsg1;//错误信息
		System.out.println("errMsg1========:"+errMsg);
	
	//errCode = impl.getErrCode(); //错误代码
	//errMsg = impl.getErrMsg(); //错误信息

	String[][] retListString = null;
	String agentPhone ="";
	String UserCode ="" ;
	String iStatus ="" ;
	String prepay_fee="0.00";

	if("000000".equals(errCode)){
		//retListString = (String[][])retList.get(0);
		retListString=result1;
		if(retListString!=null){
		for(int i = 0;i < retListString.length;i++){
			agentPhone = retListString[0][0];
			UserCode = retListString[0][1];
			iStatus =retListString[0][2];
			prepay_fee =retListString[0][3];
		}
		}
	}


//------------------------------------根据代理商编号查询代理商基本信息--------------------------------------
	//SPubCallSvrImpl impl2 = new SPubCallSvrImpl();
	//ArrayList retList2 = new ArrayList();
	String sqlStr2 = "select a.manage_area,a.is_active,substr(a.boss_org_code,1,2) region_code,"+
		"substr(a.boss_org_code,3,2) district_code,"+
		"b.corporation_name,b.corporation_card_no,b.agt_type,c.group_post_code,"+
		"c.contact_person,c.contact_id,c.contact_phone,c.bank_name,c.account_id,"+
		"a.bail,'0',a.active_time,nvl(c.Entity_group_Id,''),nvl(d.group_name,'') Entity_groupName,"+
		"nvl(e.login_mobile,'') login_mobile ,nvl(e.is_g3,'') is_g3 ,nvl(e.g3role_code,'') g3role_code "+
		" from dChnGroupMsg a,dChnAgentAddInfo b,dChnEntityAgentBaseInfo c ,dChnGroupMsg d,dchngthreeagentinfo e"+
		" where a.group_id=b.group_id and a.group_id = c.group_id(+) and c.Entity_group_Id=d.group_id(+) and a.group_id = e.group_id(+) and a.group_id="+groupId;
	//retList2 = impl2.sPubSelect("21",sqlStr2,"region",regionCode);
	System.out.println(sqlStr2);
	%>
	
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="21">
		<wtc:sql><%=sqlStr2%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
	
	<%
		errCode2=retCode2; //错误代码
		System.out.println("errCode2=========:"+errCode2);		
		errMsg2=retMsg2;//错误信息
		System.out.println("errMsg2===========:"+errMsg2);
	

	String[][] retListString2 = null;
	String agtAddress="";
	String agtStatus="";
	String regionCode2="";
	String districtCode2="";
	String legalName="";
	String legalId="";
	String agtType="";
	String agtZip="";
	String contactName="";
	String contactId="";
	String contactPhone="";
	String bankName="";
	String accountNo="";
	String depositFee="";
	String tabletSize="";
	String signTime="";
	String Entity_groupId = "";
	String Entity_groupName = "";
	
	String isG3="";
	String g3RoleCode="";
	String gThreePhone="";
	
	if("000000".equals(errCode2)){
		//retListString2 = (String[][])retList2.get(0);		
		retListString2=result2;	
					
		if(retListString2!=null&&retListString2.length>0){			
			agtAddress=retListString2[0][0];
			agtStatus=retListString2[0][1];
			regionCode2=retListString2[0][2];
			districtCode2=retListString2[0][3];
			legalName=retListString2[0][4];
			legalId=retListString2[0][5];
			agtType=retListString2[0][6];
			agtZip=retListString2[0][7];
			contactName=retListString2[0][8];
			contactId=retListString2[0][9];
			contactPhone=retListString2[0][10];
			bankName=retListString2[0][11];
			accountNo=retListString2[0][12];
			depositFee=retListString2[0][13];	
			tabletSize=retListString2[0][14];
			signTime=retListString2[0][15];
			Entity_groupId=retListString2[0][16];
			Entity_groupName=retListString2[0][17];
			gThreePhone=retListString2[0][18];		
			isG3=retListString2[0][19];
			g3RoleCode=retListString2[0][20];
			}
	}

%>

var response = new AJAXPacket();
response.data.add("agentPhone","<%=agentPhone%>");
response.data.add("UserCode","<%=UserCode%>");
response.data.add("iStatus","<%=iStatus%>");
response.data.add("type","<%=type%>");

response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
response.data.add("errCode2","<%=errCode2%>");
response.data.add("errMsg2","<%=errMsg2%>");

response.data.add("agtAddress","<%=agtAddress%>");
response.data.add("agtStatus","<%=agtStatus%>");
response.data.add("regionCode2","<%=regionCode2%>");
response.data.add("districtCode2","<%=districtCode2%>");
response.data.add("legalName","<%=legalName%>");
response.data.add("legalId","<%=legalId%>");
response.data.add("agtType","<%=agtType%>");
response.data.add("agtZip","<%=agtZip%>");
response.data.add("contactName","<%=contactName%>");
response.data.add("contactId","<%=contactId%>");
response.data.add("contactPhone","<%=contactPhone%>");
response.data.add("bankName","<%=bankName%>");
response.data.add("accountNo","<%=accountNo%>");
response.data.add("depositFee","<%=depositFee%>");
response.data.add("tabletSize","<%=tabletSize%>");
response.data.add("signTime","<%=signTime%>");
response.data.add("Entity_groupName","<%=Entity_groupName%>");
response.data.add("Entity_groupId","<%=Entity_groupId%>");

response.data.add("isG3","<%=isG3%>");
response.data.add("g3RoleCode","<%=g3RoleCode%>");
response.data.add("gThreePhone","<%=gThreePhone%>");

response.data.add("prepay_fee","<%=prepay_fee%>");

core.ajax.receivePacket(response);

