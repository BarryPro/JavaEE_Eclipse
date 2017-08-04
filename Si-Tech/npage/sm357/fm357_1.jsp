<%
/********************
 
-->>描述创建人、时间、模块的功能
-------------------------创建-----------何敬伟(hejwa)2016-2-19 14:10:11------------------

满足办理成员加入和退出操作的直接调用查询服务
展示家庭所有成员，满足办理家庭关系创建的直接提示是否要组建家庭关系，选择否直接退出，
选择是后进入组建家庭关系界面，该界面可以参照e281界面，调用服务查询产品，查询角色等信息，
然后做添加操作，最后调确认服务完成业务受理。

-------------------------后台人员：wangzc、zuolf--------------------------------------------

********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
  
	
	String currentDate = "";
	
	String param = "select to_char(sysdate,'yyyyMMdd HH24:mi:ss') as currentDate from dual";
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=param%>" />
	</wtc:service>
	<wtc:array id="result_currentDate" scope="end"   />

<%	
	if(result_currentDate.length>0){
		currentDate = result_currentDate[0][0];
	}
	
	System.out.println("--hejwa------fm357_1.jsp----AAAAAAAAAAA-----Currentdate--AAAAAAAAAAA----------->"+currentDate);
	
	String paraAray[] = new String[9];
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = activePhone;                                  //用户号码
	paraAray[6] = "";       
	paraAray[7] = "";  
	paraAray[8] = "";  
	
	String[][] result_sm357Qry = new String[][]{};
%> 
	<wtc:sequence name="sPubSelect" key="GROUPINTN_SEQ" routerKey="region" routerValue="<%=regionCode%>"  id="role_group_id" /> 
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
		
  <wtc:service name="sm357Check" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />	
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />
		<wtc:param value="<%=paraAray[7]%>" />					
		<wtc:param value="<%=paraAray[8]%>" />			
	</wtc:service>
	<wtc:array id="result_t2" scope="end"  />
		
<%
	String vChkFlag = "";
	String phoneNo_207 = "";
	/*@outparam			vChkFlag	        验证结果 Y/N N:需要创建家庭关系*/
	if("000000".equals(code)){
		
		if(result_t2.length>0){
			vChkFlag    = result_t2[0][0];
			phoneNo_207 = result_t2[0][1];
		}
		
		if("Y".equals(vChkFlag)){
%>
<SCRIPT language=JavaScript>
	location="fm357_5.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhoneNo=<%=activePhone%>&phoneNo_207=<%=phoneNo_207%>&vChkFlag=<%=vChkFlag%>";
</SCRIPT>	
<%		
		}
	}else{
%>
<SCRIPT language=JavaScript>
	rdShowMessageDialog("sm357Check校验错误：<%=code%>，<%=msg%>");
	removeCurrentTab();
</SCRIPT>
<%		
	}
	
%>
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>	
<style type="text/css">
	body{ 
		margin: 0; 
		font-size: 12px; 
		line-height: 100%; 
		font-family: Arial, sans-serif; 
	} 
	.background { 
		display: block; 
		width: 100%; 
		height: 100%; 
		opacity: 0.4; 
		filter: alpha(opacity=40); 
		background:while; 
		position: absolute; 
		top: 0; 
		left: 0; 
		z-index: 2000; 
	} 
	.progressBar { 
		border: solid 2px #86A5AD; 
		background: white url(progressBar_m.gif) no-repeat 10px 10px; 
	} 
	.progressBar { 
		display: block; 
		width: 200px; 
		height: 100px; 
		position: fixed; 
		top: 50%; 
		left: 50%; 
		margin-left: -74px; 
		margin-top: -14px; 
		padding: 10px 10px 10px 50px; 
		text-align: left; 
		line-height: 27px; 
		font-weight: bold; 
		position: absolute; 
		z-index: 2001; 
	} 

</style>
<SCRIPT language=JavaScript>

var vChkFlag_j = "<%=vChkFlag%>";
var phone_207 = "<%=phoneNo_207%>";

//重置刷新页面
function reSetThis(){
	  location = location;	
}
function showBar(){
	$("#background").show();
	$("#progressBar").show();
}
function closeBar(){
	$("#background").hide();
	$("#progressBar").hide();
}
$(document).ready(function(){
	if("Y"==vChkFlag_j){
		//已经创建家庭
	}else if("N"==vChkFlag_j){
	//	if(rdShowConfirmDialog('该用户还未组建家庭关系，是否要创建?')!=1) {
		//	removeCurrentTab();
		//}else{
		
			//校验服务返回的结果为此手机号为可创建家庭的
			go_ajax_sm357Qry("0","","","<%=activePhone%>");
			
		//}
	}
});

function go_ajax_sm357Qry(inQryType,inProdCode,inGearCode,phone_no){
 
	var packet = new AJAXPacket("fm357_2.jsp","请稍后...");
      packet.data.add("opCode","<%=opCode%>");// 
      packet.data.add("phoneNo",phone_no);//手机号
      packet.data.add("inQryType",inQryType);//
      packet.data.add("inProdCode",inProdCode);//
      packet.data.add("inGearCode",inGearCode);//
    core.ajax.sendPacket(packet,do_ajax_sm357Qry);
    packet =null;
}
function do_ajax_sm357Qry(packet){
		var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code=="000000"){//操作成功
    	var inQryType  = packet.data.findValueByName("inQryType");
    	
      var retArray   = packet.data.findValueByName("retArray");	
	    if("0"==inQryType){//查询产品返回
	    	$("#sel_ProdCode option:gt(0)").remove();
	    	for(var i=0;i<retArray.length;i++){
	    		$("#sel_ProdCode").append("<option value='"+retArray[i][1]+"'>"+retArray[i][0]+"</option>");
	    	}
	    }
	    
	    if("1"==inQryType){//查询产品档位
	    	$("#sel_GearCode option:gt(0)").remove();
	    	for(var i=0;i<retArray.length;i++){
	    		$("#sel_GearCode").append("<option value='"+retArray[i][1]+"'>"+retArray[i][0]+"</option>");
	    	}
	    }
	    
	    if("2"==inQryType){//查询角色
	    	var JTFX_disabled = "";
	    	
	    	$("#table_RoleCode tr:gt(0)").remove();
	    	var in_html = "";
	    	for(var i=0;i<retArray.length;i++){
	    		
	    		if(("JTFX"==$("#sel_ProdCode").val()||"JTHB"==$("#sel_ProdCode").val())&&"21096"==retArray[i][1]){
	    			
		    		JTFX_disabled = "disabled";
		    	}else{
		    		JTFX_disabled = "";
		    	}
	    		
					if($("#sel_GearCode").val()=="D022"){
						JTFX_disabled = "";
					}	    		
	    		
	    		//JTHB 的时候 D040 -D048 可以直接添加普通成员
	    		
	    		if(
	    			$("#sel_GearCode").val()=="D041"||
	    			$("#sel_GearCode").val()=="D042"||
	    			$("#sel_GearCode").val()=="D043"||
	    			$("#sel_GearCode").val()=="D044"||
	    			$("#sel_GearCode").val()=="D045"||
	    			$("#sel_GearCode").val()=="D046"||
	    			$("#sel_GearCode").val()=="D047"||
	    			$("#sel_GearCode").val()=="D048"
	    		){
						JTFX_disabled = "";
					}	
					
					
	    		in_html += "<tr>"+
	    							 "<td>"+retArray[i][0]+"</td>"+
	    							 "<td style='display:none'>"+retArray[i][1]+"</td>"+
	    							 "<td>"+retArray[i][2]+"</td>"+
	    							 "<td>"+retArray[i][3]+"</td>"+
	    							 "<td style='display:none'>"+retArray[i][4]+"</td>"+
	    							 "<td>0</td>"+
	    							 "<td><input type='button' class='b_text' value='添加' onclick='add_role_mem(this)' "+JTFX_disabled+" />";
	    							 if(retArray[i][0]=="207家庭用户"){
	    								 in_html += "<input type='button' class='b_text' value='家庭创建' onclick='addFamily(this)'/></td></tr>";
	    							 }
	    							 else{
	    								 in_html += "</td></tr>";
	    							 }
	    							 
	    	}
	    	$("#table_RoleCode").append(in_html);
	    }
	    
    }else{//调用服务失败
    	rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }
}

//添加按钮
function add_role_mem(bt){
		if(!$("#opr_info").is(":hidden")){
			rdShowMessageDialog("请先保存受理区");
			return;
		}
	
		var trObj = $(bt).parent().parent();
		var role_code = trObj.find("td:eq(1)").text().trim();
		var role_name = trObj.find("td:eq(0)").text().trim();
		
		var inCheckFlag = trObj.find("td:eq(4)").text().trim();//角色校验标识
		
		
		$("#operRoleId").val(role_code);
		$("#operRolename").val(role_name);
		$("#inCheckFlag").val(inCheckFlag);
		
		
		$("#role_name_span").text(role_name+"-");
		
		$("#phoneNo").val("");
		$("#phoneNo").removeAttr("readOnly");
		$("#phoneNo").removeClass("InputGrey");
		$("#pwdContent").show();
		$("#sel_kd_flag").hide();
		
		if("21098"==role_code){//付费人
			$("#pwdContent").hide();
			$("#phoneNo").val("<%=activePhone%>");
			$("#phoneNo").attr("readOnly","readOnly");
			$("#phoneNo").addClass("InputGrey");
		}
		
		if("21097"==role_code){//宽带
			$("#sel_kd_flag").show();
		}
		
		if("21099"==role_code){// 207号码
				$("#pwdContent").hide();
				$("#phoneNo").val(phone_207);
				$("#phoneNo").attr("readOnly","readOnly");
				$("#phoneNo").addClass("InputGrey");
		}
		
		$("#opr_info").show();
}

function addFamily(obj){
	$(obj).attr("disabled","disabled");
//	showBar();
	var myPacket = new AJAXPacket("fm357_8.jsp","正在创建家庭，请稍候......");
	myPacket.data.add("iLoginAccept","0");
	myPacket.data.add("iChnSource","01");
	myPacket.data.add("iOpCode","g629");	
	myPacket.data.add("iLoginNo","<%=workNo%>");
	myPacket.data.add("iLoginPwd","<%=password%>");
	myPacket.data.add("iPhoneNo","<%=activePhone%>");					//传空
	myPacket.data.add("iUserPwd","");		//工号
	core.ajax.sendPacket(myPacket, do_addFamily);
}
function do_addFamily(packet) {
	var code = packet.data.findValueByName("code");
	var msg = packet.data.findValueByName("msg");
	if (code=="000000") {
		var phone207 = packet.data.findValueByName("phone207");
		setFamilyNum(phone207);
		rdShowMessageDialog("家庭客户开户成功!");
	}else{
		rdShowMessageDialog(msg);
	}
}

function setFamilyNum(phone207){
	phone_207=phone207;
	vChkFlag="N";
}

function go_sel_GearCode(){
	if($("#sel_ProdCode").val()=="JTFX"){
		//rdShowMessageDialog("和家飞享家庭产品订购前，不允许做手机成员添加");
		$("#tr_JTFX_hit").show();
	}else{
		$("#tr_JTFX_hit").hide();
	}
	if($("#sel_ProdCode").val()!=""){
		go_ajax_sm357Qry("1",$("#sel_ProdCode").val(),"","<%=activePhone%>");
		$("#table_Role_result tr:gt(0)").remove();
		$("#table_RoleCode tr:gt(0)").remove();
		
	}
}
function go_sel_RoleCode(){
	if($("#sel_GearCode").val()!=""){
		go_ajax_sm357Qry("2","",$("#sel_GearCode").val(),"<%=activePhone%>");
		$("#table_Role_result tr:gt(0)").remove();
	}
	if($("#sel_GearCode").val()=="D022"){
			$("#tr_JTFX_hit").hide();
	}
}

function close_mem(){
	$("#phoneNo").val("");
	$("#pwdContent").show();
	$("#opr_info").hide();
	$("#operRoleId").val("");
	$("#operRolename").val("");
	$("#inCheckFlag").val("");
	$("#role_name_span").text("");
	
	$("input[name='phonePwd']").val("");
	$("#sel_kd_flag").hide();
}

//校验&添加成员 按钮
function check_and_add(){
	if($("#phoneNo").val()==""){
			rdShowMessageDialog("请输入手机号码");
			return;
	}
	var phone_no_flag = false;
	//判断手机号是否已经在已添加角色列表
	$("#table_Role_result tr:gt(0)").each(function(){
		var phone_no = $(this).find("td:eq(0)").text().trim();
		if(phone_no==$("#phoneNo").val().trim()){
				phone_no_flag = true;//找到，返回
				return false;
		}
	});	
	
	if(phone_no_flag){
			rdShowMessageDialog("此手机号已经存在已添加角色列表");
			return;
	}
		
	if($("#operRoleId").val()=="21098"||$("#operRoleId").val()=="21099"){//付费人，207号码，不需要校验密码
		add_to_memtable();
		
	}else{
		var phoneNo_209 = "";
		
		if($("#operRoleId").val()=="21097"){//宽带先去查询对应209号码
			var packet = new AJAXPacket("fm357_6.jsp","请稍后...");
		      packet.data.add("CFM_LOGIN",$("#phoneNo").val());//手机号
		    core.ajax.sendPacket(packet,function(packet){
		    		var error_code = packet.data.findValueByName("code");//返回代码
    				var error_msg =  packet.data.findValueByName("msg");//返回信息
    					if (error_code != "000000") {
								/*  0失败    */
								rdShowMessageDialog("查询失败");
							}else{
								/* 1成功 */
								
								var retArray = packet.data.findValueByName("retArray");
								if(retArray.length>0){
									phoneNo_209 = retArray[0][0];		
								}
							}
		    	});
		    packet =null;
		    
		    if(""==phoneNo_209){
					rdShowMessageDialog("未查询到对应209号码");
					return;
				}
		}
		
		
		
		var userPsw = $("input[name='phonePwd']").val();
		if(userPsw == ""){
			rdShowMessageDialog("请输入手机密码");
			return false;
		}
		
		var phoneNo_pwd_check = $("#phoneNo").val();
		if($("#operRoleId").val()=="21097"){//宽带先去查询对应209号码
			phoneNo_pwd_check = phoneNo_209;
		}
		
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
				checkPwd_Packet.data.add("custType","01");				//01:手机号码 02 客户密码校验 03帐户密码校验
				checkPwd_Packet.data.add("phoneNo",phoneNo_pwd_check);	//移动号码,客户id,帐户id
				checkPwd_Packet.data.add("custPaswd",userPsw);//用户/客户/帐户密码
				checkPwd_Packet.data.add("idType","");				//en 密码为密文，其它情况 密码为明文
				checkPwd_Packet.data.add("idNum","");					//传空
				checkPwd_Packet.data.add("loginNo","<%=workNo%>");		//工号
				core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
	}
				
}
function doCheckPwd(packet) {
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			/*  0失败    */
			rdShowMessageDialog(msg);
		}else{
			/* 1成功 */
			
			add_to_memtable();			
		}
}

//添加一行到业务受理列表
function add_to_memtable(){
	//先调用校验号码服务
		var packet = new AJAXPacket("fm357_4.jsp","请稍后...");
	      packet.data.add("opCode","<%=opCode%>");//
	      packet.data.add("activePhone","<%=activePhone%>");//
	      packet.data.add("phoneNo",$("#phoneNo").val());//手机号
	      packet.data.add("inCheckFlag",$("#inCheckFlag").val());//
	      if($("#operRoleId").val()=="21097"){
	      	packet.data.add("sel_kd_flag",$("#sel_kd_flag").val());//	
	      	packet.data.add("kd_phoneNo",$("#phoneNo").val());//	
	      }
	      
	    core.ajax.sendPacket(packet,do_add_to_memtable);
	    packet =null;
}

function do_add_to_memtable(packet){
		var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code=="000000"){//操作成功
    	
    		var tr_html = "<tr>"+
								"<td>"+$("#phoneNo").val()+"</td>"+
								"<td style='display:none'>"+$("#operRoleId").val()+"</td>"+
								"<td>"+$("#operRolename").val()+"</td>"+
								"<td><input type='button' value='删除' class='b_text' onclick='delete_mem(this)' /></td>"+
								"</tr>";
	
					$("#table_Role_result").append(tr_html);
					
					//刷新家庭角色信息的已添加数量、添加按钮置灰
					ref_table_RoleCode();
					
					close_mem();
    }else{//调用服务失败
    	rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }
}

function ref_table_RoleCode(){
	
	//先看已添加角色列表中有几种角色
	var role_re_array = new Array();//存储已经添加的角色代码
	$("#table_Role_result tr:gt(0)").each(function(){
		role_re_array.push($(this).find("td:eq(1)").text().trim());
	});
	
	$("#table_RoleCode tr:gt(0)").each(function (){
			var rolename = $(this).find("td:eq(0)").text().trim();
			
			var role_id_JTFX = $(this).find("td:eq(1)").text().trim();
			
		//alert("sel_ProdCode=["+$("#sel_ProdCode").val()+"]"+"\nrole_id_JTFX=["+role_id_JTFX+"]");
		
		  if(("JTFX"==$("#sel_ProdCode").val()||"JTHB"==$("#sel_ProdCode").val())&&"21096"==role_id_JTFX&&$("#sel_GearCode").val()!="D022"){
		  	
    	}else{
		    	
				var temp_count = 0;
				var roleCode = $(this).find("td:eq(1)").text().trim();
				//在已添加的角色代码中寻找当前行的角色代码，找到一个自增1
				for(var i=0;i<role_re_array.length;i++){
					if(roleCode==role_re_array[i]){
						temp_count ++;
					}
				}
				
				//更新已添加数量
				$(this).find("td:eq(5)").text(temp_count);
				//最大数量
				var max_num = $(this).find("td:eq(3)").text().trim();
				
				
				//如果最大数量与已添加的数量相同则置灰添加按钮
				if(temp_count==max_num){
					$(this).find("td:last").find("input").attr("disabled","disabled");
				}else{
					//删除的时候小于最大数量
					$(this).find("td:last").find("input").removeAttr("disabled");
				}
			}
	});
}

function delete_mem(bt){
	if(rdShowConfirmDialog('确认删除记录吗？')!=1) return;
	$(bt).parent().parent().remove();
	ref_table_RoleCode();
}


function go_cfm(){


	if($("#table_RoleCode tr:gt(0)").size()==0){
		rdShowMessageDialog("请查询家庭角色");
		return;
	}
	
	var max_min_chenk = false;
	var temp_role_name = "";
	//最小数、最大数校验
		$("#table_RoleCode tr:gt(0)").each(function (){
			var rolename = $(this).find("td:eq(0)").text().trim();
			//已添加数量
			var add_num = $(this).find("td:eq(5)").text().trim();
			
			//最大数量
			var max_num = $(this).find("td:eq(3)").text().trim();
			//最小数量
			var min_num = $(this).find("td:eq(2)").text().trim();
			
			if(parseInt(add_num)<parseInt(min_num)){
				max_min_chenk = true;
				temp_role_name = rolename;
				return false;
			}
	});
	
	if(max_min_chenk){
		rdShowMessageDialog(temp_role_name+"的角色添加数量小于最小数量");
		return;
	}
	
	// showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
   if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
	   
	
		//var in_json = "{    \"OPR_INFO\": {        \"PHONE_NO\": \"123456\",        \"OP_CODE\": \"\",        \"LOGIN_NO\": \"\",        \"LOGIN_ACCEPT\": \"\",        \"BACK_ACCEPT\": \"\",        \"OPR_TIME\": \"\"    },    \"BUSI_INFO\": {        \"MAIN_OFFER_LIST\": [            {                \"PHONE_NO\": \"\",                \"EFF_TYPE\": \"\",                \"OFFER_ID\": \"\"            }        ],        \"ADD_OFFER_LIST\": [            {                \"PHONE_NO\": \"11111\",                \"EFF_TYPE\": \"\",                \"OFFER_ID\": \"\",                \"OPERATE_TYPE\": \"\"            },            {                \"PHONE_NO\": \"22222\",                \"EFF_TYPE\": \"\",                \"OFFER_ID\": \"\",                \"OPERATE_TYPE\": \"\"            }        ],        \"SP_OFFER_LIST\": [            {                \"PHONE_NO\": \"\",                \"EFF_TYPE\": \"\",                \"OFFER_ID\": \"\",                \"OPERATE_TYPE\": \"\"            }        ],        \"GROUP_INFO_LIST\": [            {                \"OPERATE_TYPE\": \"I\",                \"PHONE_NO\": \"123\",                \"GROUP_ID\": \"1111111\",                \"EFF_DATE\": \"yyyymmdd hh24:mi:ss\",                \"EXP_DATE\": \"yyyymmdd hh24:mi:ss\",                \"MEMBER_ROLE_ID\": \"\",                \"MEMBER_TYPE_ID\": \"\"            },            {                \"OPERATE_TYPE\": \"I\",                \"PHONE_NO\": \"456\",                \"GROUP_ID\": \"111111\",                \"EFF_DATE\": \"yyyymmdd hh24:mi:ss\",                \"EXP_DATE\": \"yyyymmdd hh24:mi:ss\",                \"MEMBER_ROLE_ID\": \"\",                \"MEMBER_TYPE_ID\": \"\"            }        ]    }}";
		//拼入参json
		var OPR_INFO_json = {
													"PHONE_NO":"<%=activePhone%>",
									        "OP_CODE": "<%=opCode%>",
									        "LOGIN_NO": "<%=workNo%>",
									        "LOGIN_ACCEPT": "<%=sysAcceptl%>",
									        "BACK_ACCEPT": "",
									        "OPR_TIME": "<%=currentDate%>",
									        "OP_NOTE":"家庭用户与成员关系管理",
									        "CHK_FLAG":"<%=vChkFlag%>",
									        "PROD_CODE":$("#sel_ProdCode").val(),
                					"PROD_CODE_DW":$("#sel_GearCode").val(),
                					"GROUP_ID":"<%=role_group_id%>"
												};
		
		var GROUP_INSTANCE_json = {
				 				"GROUP_OPERATE_TYPE": "I",
                "GROUP_ID": "<%=role_group_id%>",
                "EFF_DATE": "<%=currentDate%>",
                "EXP_DATE": "20500101 00:00:00",
                "GROUP_TYPE_ID": "24",
                "PROD_CODE":$("#sel_ProdCode").val(),
                "PROD_CODE_DW":$("#sel_GearCode").val(),
                "GROUP_DESC":$("#sel_ProdCode option:selected").text()
			};
			
		var GROUP_INSTANCE_MEMBER_LIST = [];
		var LOGINOPR_json = [];
		
     $("#table_Role_result tr:gt(0)").each(function(){
     			
     			//付费人和普通成员传PH  宽带用户传KD 虚拟号码传XN  拿界面角色做判断就行
     			var MEMBER_TYPE_temp = "";
     			if("21098"==$(this).find("td:eq(1)").text().trim()||"21096"==$(this).find("td:eq(1)").text().trim()){
     				MEMBER_TYPE_temp = "PH";
     			}
     			if("21097"==$(this).find("td:eq(1)").text().trim()){
     				MEMBER_TYPE_temp = "KD";
     			}
     			if("21099"==$(this).find("td:eq(1)").text().trim()){
     				MEMBER_TYPE_temp = "XN";
     			}
     			
					var temp_member_json = 		{
                    "MEMBER_OPERATE_TYPE": "I",
                    "PHONE_NO": $(this).find("td:eq(0)").text().trim(),
                    "GROUP_ID": "<%=role_group_id%>",
                  	"EFF_DATE": "<%=currentDate%>",
                		"EXP_DATE": "20500101 00:00:00",
                    "MEMBER_ROLE_ID":$(this).find("td:eq(1)").text().trim(),
                    "MEMBER_TYPE_ID": "4",
                    "MEMBER_TYPE":MEMBER_TYPE_temp,
                    "MEMBER_DESC":$(this).find("td:eq(2)").text().trim()
          };		
          
          var temp_json = {"PHONE_NO":$(this).find("td:eq(0)").text().trim()};
          LOGINOPR_json.push(temp_json);
          
          GROUP_INSTANCE_MEMBER_LIST.push(temp_member_json);
			});           
		
		
		
		var BUSI_INFO_json = {
					"GROUP_INFO":{
						"GROUP_INSTANCE":GROUP_INSTANCE_json,
						"GROUP_INSTANCE_MEMBER_LIST":GROUP_INSTANCE_MEMBER_LIST
					},
					"LOGINOPR":LOGINOPR_json
		};      
		
					          
		var in_json_obj = {
												"OPR_INFO":OPR_INFO_json,
												"BUSI_INFO":BUSI_INFO_json
											};
		
		
		var in_JSONText = JSON.stringify(in_json_obj,function(key,value){
													return value;
											});
				
				
		//alert(in_JSONText);	
		
		var packet = new AJAXPacket("fm357_3.jsp","请稍后...");
	      packet.data.add("opCode","<%=opCode%>");// 
	      packet.data.add("phoneNo","<%=activePhone%>");//手机号
	      packet.data.add("sysAcceptl","<%=sysAcceptl%>");//流水
	      packet.data.add("in_JSONText",in_JSONText);//
    core.ajax.sendPacket(packet,do_cfm);
    packet =null;
    
}

function do_cfm(packet){
		var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code=="000000"){//操作成功
    		var returnFlag = rdShowMessageDialog("操作成功!",2);
    		//alert(returnFlag);
    		//alert(returnFlag=="1");
    		if(returnFlag=="1"){
    			var path="/npage/sm358/fm358_1.jsp?opCode=m358&opName=家庭产品订购&crmActiveOpCode=m358&activePhone=<%=activePhone%>&broadPhone=";
    			parent.addTab(false,"m358","家庭产品订购",path);
    		}
    		//rdShowMessageDialog("请到m358，做家庭产品订购!",1);
	     // removeCurrentTab();
    		parent.removeTab("m357");
    }else{//调用服务失败
    	rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }
}


 
   function showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
      var h=180;
      var w=350;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;		   	   
      var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
      var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
      var sysAccept =<%=sysAcceptl%>;             	//流水号
        var printStr = printInfo(printType);
      
	 		                      //调用printinfo()返回的打印内容
      var mode_code=null;           							  //资费代码
      var fav_code=null;                				 		//特服代码
      var area_code=null;             				 		  //小区代码
      var opCode="<%=opCode%>" ;                   			 	//操作代码
      var phoneNo="<%=activePhone%>";                  //客户电话
      
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
      path+="&mode_code="+mode_code+
      	"&fav_code="+fav_code+"&area_code="+area_code+
      	"&opCode=<%=opCode%>&sysAccept="+sysAccept+
      	"&phoneNo="+phoneNo+
      	"&submitCfm="+submitCfm+"&pType="+
      	pType+"&billType="+billType+ "&printInfo=" + printStr;
      var ret=window.showModalDialog(path,printStr,prop);
      return ret;
    }				
		//打印模板id为：
    function printInfo(printType){
    	go_get_prt_info();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
      cust_info+="客户姓名：   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    用户品牌："+$("#prt_cust_bran").val()+"|";
      						
      opr_info += "业务办理名称：家庭用户与成员关系管理    操作流水: "+"<%=sysAcceptl%>" +"|";
      opr_info += "家庭户主号码：<%=activePhone%>"+"|";
      
			opr_info += "本次新增家庭成员号码：";
			var temp_phone_no = "";
      $("#table_Role_result tr:gt(0)").each(function(){
				var phone_no = $(this).find("td:eq(0)").text().trim();
				temp_phone_no += phone_no+"，"	;
			});	
			if(temp_phone_no.length>0){
				temp_phone_no = temp_phone_no.substring(0,temp_phone_no.length-1);
			}
			opr_info   += temp_phone_no+"|";
			
      note_info1 += "订购家庭产品前：新增成员立即生效，删除成员立即生效"+"|";
      note_info1 += "订购家庭产品后：新增成员立即生效，删除成员次月生效"+"|";
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }

function go_get_prt_info(){
		var packet = new AJAXPacket("fm357_7.jsp","请稍后...");
	      packet.data.add("opCode","<%=opCode%>");// 
	      packet.data.add("phoneNo","<%=activePhone%>");//手机号
	      packet.data.add("inProdCode",$("#sel_ProdCode").val());//
	      packet.data.add("inGearCode",$("#sel_GearCode").val());//
    core.ajax.sendPacket(packet,do_get_prt_info);
    packet =null;	
}

function do_get_prt_info(packet){
		var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code=="000000"){//操作成功
    	$("#prt_cust_name").val(packet.data.findValueByName("prt_cust_name"));
    	$("#prt_cust_bran").val(packet.data.findValueByName("prt_cust_bran"));
    	$("#prt_note_into").val(packet.data.findValueByName("prt_note_into"));
    }
}

</SCRIPT>
</HEAD>	
<BODY>
<div id="background" class="background" style="display: none; "></div> 
<div id="progressBar" class="progressBar" style="display: none; ">家庭创建中，请稍候...</div>
<FORM name="msgFORM" action="" method="post"> 
<input type="hidden" id="prt_cust_name" name="prt_cust_name" value="" />
<input type="hidden" id="prt_cust_bran" name="prt_cust_bran" value="" />
<input type="hidden" id="prt_note_into" name="prt_note_into" value="" />

	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">选择产品</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="20%">家庭产品</td>
		  <td width="30%">
			    <select id="sel_ProdCode" onchange="go_sel_GearCode()" >
			    	<option value="">--请选择--</option>
			    </select>
		  </td>
 
	    <td class="blue" width="20%">产品档位</td>
		  <td width="30%">
			    <select id="sel_GearCode" onchange="go_sel_RoleCode()" style="width:200px" >
			    	<option value="">--请选择--</option>
			    </select>
		  </td>
	</tr>
	<tr>
		<td class="blue">群组</td>
		<td>
			<input type="text" id="group_id" readonly class="InputGrey" value="<%=role_group_id%>" />
		</td>
		<td colspan="2"><b style="font: 20;color: red">办理家庭成员关系前，请先点击“家庭创建”按钮</b></td>
	</tr>
	
	<tr id="tr_JTFX_hit" style="display:none">
			<td colspan="4">
				<font class="orange">和家飞享家庭产品订购前，不允许做手机成员添加</font> 
			</td>	
	</tr>
</table>

<div class="title"><div id="title_zi">家庭角色信息</div></div>
<table cellSpacing="0" id="table_RoleCode">
	<tr>
		<th width="25%">角色名称</th>
		<th style="display:none">角色代码</th>
		<th width="20%">最小人数</th>
		<th width="20%">最大人数</th>
		<th width="20%">已添加数量</th>
		<th>操作</th>
	</tr>
</table>

<div id="opr_info" style="display:none">
<div class="title"><div id="title_zi">业务受理</div></div>
	<table>
			<tr>
				<td class="blue" width="30%" id="chenynames"><span id="role_name_span"></span>成员手机号码</td>
				<td width="30%">
					<input type="text" id="phoneNo" name="phoneNo"  />
					<input type="hidden" id="operRoleId" name="operRoleId" />
					<input type="hidden" id="operRolename" name="operRolename" />
					<input type="hidden" id="inCheckFlag" name="inCheckFlag" />
					<select id="sel_kd_flag" style="display:none" >
						<option value="N">未竣工</>
						<option value="Y">竣工</>
					</select>
				</td>
				<td class="blue" width="10%">密码</td>
				<td>
					<span id="pwdContent">
						<jsp:include page="/npage/common/pwd_1.jsp">
							<jsp:param name="width1" value="16%"/>
							<jsp:param name="width2" value="34%"/>
							<jsp:param name="pname" value="phonePwd"/>
							<jsp:param name="pwd" value=""/>
						</jsp:include>
					</span>
				</td>
			</tr>
			<tr>
				<td id="footer" colspan="4">
					<input type="button" class="b_foot" value="校验&添加成员" onclick="check_and_add()"           />
					<input type="button" class="b_foot" value="取消"          onclick="close_mem()"           />
				</td>
			</tr>
		</table>
</div>

<div class="title"><div id="title_zi">已添加角色</div></div>
<table cellSpacing="0" id="table_Role_result">
	<tr>
		<th width="50%">手机号码</th>
		<th width="30%">角色</th>
		<th>操作</th>
	</tr>
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定" onclick="go_cfm()"           />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
<jsp:include page="/npage/common/pwd_comm.jsp"/>
</FORM>
<iframe id="addFamily" src="" width="100%" style="display:none "></iframe>

</BODY>
</HTML>