<%
/********************
 version v2.0
开发商: si-tech
update:liutong@20080919
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String phoness = request.getParameter("phone");

String opcode=WtcUtil.repNull(request.getParameter("opcode"));

if(opcode=="") {
		opcode="1104";
}


String beizhussdese="根据phoneNo=["+phoness+"]进行查询";
String loginNo = (String)session.getAttribute("workNo");
String loginNoPass = (String)session.getAttribute("password");
String ipAddrss = (String)session.getAttribute("ipAddr");
String groupId = (String)session.getAttribute("groupId");
String work_name =(String)session.getAttribute("workName");

String smcodess=WtcUtil.repNull(request.getParameter("smcodes"));
String id_noss=WtcUtil.repNull(request.getParameter("id_nos"));
String contract_noss=WtcUtil.repNull(request.getParameter("contract_nos"));
%>

        
<wtc:service name="sUserCustInfo" outnum="100"  retcode="errCode" retmsg="errMsg" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opcode%>" />	
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=loginNoPass%>" />
			<wtc:param value="<%=phoness%>" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />
</wtc:service>
<wtc:array id="baseArr" scope="end"/>
<%
			String id_no="";
			String smcode="";
			String smname="其他品牌";
			String group_names="";
			String billtypemodel="model4";
			String contract_no="";
			String username="";
			String op_name="";
			
	int ran=0;
	java.util.Random r = new java.util.Random();
	ran = r.nextInt(9999);
	int ran1 = r.nextInt(10)*1000;
	if((ran+"").length()<4){
		ran = ran+ran1;
	}
	String randomshu=ran+"";
				
    if(baseArr!=null&&baseArr.length>0){
   System.out.println("baseArr.length===="+baseArr.length); 
    	if(baseArr[0][0].equals("00")) {
    	  
          id_no = (baseArr[0][30]);
          contract_no=(baseArr[0][32]);
          smcode = (baseArr[0][38]);
          username = (baseArr[0][5]);
          }
    }
    if(id_no!=null && !id_no.equals("")) {
    			id_no=id_no.trim();
    }else {
    			id_no="";
    }
    if(contract_no!=null && !contract_no.equals("")) {
    			contract_no=contract_no.trim();
    }else {
    			contract_no="";
    }
    if(smcode!=null && !smcode.equals("")) {
    			smcode=smcode.trim();
    }else {
    			smcode="";
    }
     if(username!=null && !username.equals("")) {
    			username=username.trim();
    }else {
    			username="";
    }       
    
    String sim_feeCC0="";
    String hand_feeCC4="";
    String depositLL0="";
    String innet_feeCC1="";
    
%>
<wtc:service name="sRateQry" outnum="100"  retcode="errCode223" retmsg="errMsg223" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opcode%>" />	
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=loginNoPass%>" />
			<wtc:param value="<%=phoness%>" />
			<wtc:param value="" />

</wtc:service>
<wtc:array id="result" scope="end"  start="0"  length="1"/>
<wtc:array id="result2" scope="end"  start="1"  length="4"/>
	    


<%

if(result.length>0) {
		billtypemodel=result[0][0];
		System.out.println("模板========="+billtypemodel);
}
System.out.println("长度1========="+result2.length);
if(result2.length>0) {
		for(int sis=0;sis<result2.length;sis++) {
	    System.out.println("result2["+sis+"]["+0+"]="+result2[sis][0]);
	    System.out.println("result2["+sis+"]["+1+"]="+result2[sis][1]);
	    System.out.println("result2["+sis+"]["+2+"]="+result2[sis][2]);
	    System.out.println("result2["+sis+"]["+3+"]="+result2[sis][3]);
	}
}
%>
		var array = [];
<%

			//封装js数组
     for(int sis=0;sis<result2.length;sis++) {
		%>
					var type = {};
					type.value = '<%=result2[sis][3]%>';
				  type.name = '<%=result2[sis][2]%>';
				  array.push(type);
		<%
			}
if(smcode.equals("")) {
smcode=smcodess;
}

	String sql_select = "select band_name from band where sm_code=:smcodes";
	String sql_param = "smcodes=" + smcode;
	String changeType = "";
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="ret_codedd" retmsg="ret_messagedd" outnum="1">
		<wtc:param value="<%=sql_select%>"/>
		<wtc:param value="<%=sql_param%>"/>
	</wtc:service>
	<wtc:array id="resultStatus" scope="end" />
<%
	if((ret_codedd.equals("0")||ret_codedd.equals("000000")) && resultStatus.length > 0) {
		smname = resultStatus[0][0];
	}else {

	}

	String sql_selectss = "select group_name from dchngroupmsg where group_id=:groupidss";
	String sql_paramss = "groupidss=" + groupId;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="ret_codess" retmsg="ret_messagess" outnum="1">
		<wtc:param value="<%=sql_selectss%>"/>
		<wtc:param value="<%=sql_paramss%>"/>
	</wtc:service>
	<wtc:array id="resultStatusss" scope="end" />
<%
	if((ret_codess.equals("0")||ret_codess.equals("000000")) && resultStatusss.length > 0) {
		group_names = resultStatusss[0][0];
	}else {

	}

	String sql_selectssss = "select function_name from sfunccodenew where function_code=:functioncodes";
	String sql_paramssss = "functioncodes=" + opcode;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="ret_codessss" retmsg="ret_messagessss" outnum="1">
		<wtc:param value="<%=sql_selectssss%>"/>
		<wtc:param value="<%=sql_paramssss%>"/>
	</wtc:service>
	<wtc:array id="resultStatusss111" scope="end" />
<%	
	if((ret_codessss.equals("0")||ret_codessss.equals("000000")) && resultStatusss111.length > 0) {
		op_name = resultStatusss111[0][0];
	}else {

	}	

if(id_no.equals("")){
id_no=id_noss;
}
if(contract_no.equals("")){
contract_no=contract_noss;
}
	
	
System.out.println("id_no==========="+id_no);
System.out.println("smname==========="+smname);
System.out.println("group_name==========="+group_names);
System.out.println("op_name==========="+op_name);
%>


var response = new AJAXPacket();
var errCode = "<%=errCode%>";
var errMsg = "<%=errMsg%>";

response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);
response.data.add("id_no","<%=id_no%>");
response.data.add("smname","<%=smname%>");
response.data.add("smcodes","<%=smcode%>");
response.data.add("group_name","<%=group_names%>");
response.data.add("billtypemodel","<%=billtypemodel%>");
response.data.add("contract_no","<%=contract_no%>");
response.data.add("username","<%=username%>");
response.data.add("work_name","<%=work_name%>");
response.data.add("kdsuijima","<%=randomshu%>");
response.data.add("op_name","<%=op_name%>");
response.data.add("result",array);


core.ajax.receivePacket(response);




