<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2016-3-24 11:01:59------------------
 

 -------------------------后台人员：wangzc、zuolf--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode        = WtcUtil.repNull(request.getParameter("opCode"));
  String opName        = WtcUtil.repNull(request.getParameter("opName"));
  
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
	
	System.out.println("--hejwa------fm359_1.jsp----AAAAAAAAAAA-----Currentdate--AAAAAAAAAAA----------->"+currentDate);
	
	java.util.Calendar cal = java.util.Calendar.getInstance(); 
	cal.add(Calendar.MONTH, 1); 
	cal.set(Calendar.DATE, 1); 
	String n_month_Date = new java.text.SimpleDateFormat("yyyyMMdd 00:00:00").format(new java.util.Date(cal.getTimeInMillis()));
	String vChkFlag = "";
	String phoneNo_207 = "";
 
	System.out.println("--hejwa---------------currentDate------------->"+currentDate);
	
	String paraAray1[] = new String[8];
	
	paraAray1[0] = "";                                       //流水
	paraAray1[1] = "01";                                     //渠道代码
	paraAray1[2] = opCode;                                   //操作代码
	paraAray1[3] = (String)session.getAttribute("workNo");   //工号
	paraAray1[4] = (String)session.getAttribute("password"); //工号密码
	paraAray1[5] = activePhone;                            //用户号码
	paraAray1[6] = "";       
	paraAray1[7] = "3";    
	
%> 
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
		
  <wtc:service name="sm357Qry" outnum="12" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray1[0]%>" />
		<wtc:param value="<%=paraAray1[1]%>" />	
		<wtc:param value="<%=paraAray1[2]%>" />
		<wtc:param value="<%=paraAray1[3]%>" />
		<wtc:param value="<%=paraAray1[4]%>" />
		<wtc:param value="<%=paraAray1[5]%>" />
		<wtc:param value="<%=paraAray1[6]%>" />
		<wtc:param value="<%=paraAray1[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t2" scope="end"  />
		
<%
	
	String j_ProdCode = "";
	String j_ProdName = "";
	String j_GearCode = "";
	String j_GearName = "";
	String j_group_id = "";
	
	String j_offer_flag = "";
	String j_offer_type = "";//G；共享类，D:包月融合类
	
	String j_EFF_DATE = "";
	String j_EXP_DATE = "";
	String sp_type = "";
	
	if("000000".equals(code)){
		if(result_t2.length>0){
			j_ProdCode = result_t2[0][1];
			j_ProdName = result_t2[0][0];
			j_GearCode = result_t2[0][3];
			j_GearName = result_t2[0][2];
			j_group_id = result_t2[0][4];
			j_offer_flag = result_t2[0][5];
			j_offer_type = result_t2[0][9];
			
			j_EFF_DATE = result_t2[0][7];
			j_EXP_DATE = result_t2[0][8];
			sp_type = result_t2[0][11];
			
		}
		
		System.out.println("--hejwa---------------j_offer_type------------->"+j_offer_type);
		if("D".equals(j_offer_type)){
%>
<SCRIPT language=JavaScript>
	location = "fm359_2.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhoneNo=<%=activePhone%>";
</SCRIPT>	
<%		
		}
 
	}else{
%>
<SCRIPT language=JavaScript>
	rdShowMessageDialog("sm357Qry错误：<%=code%>，<%=msg%>");
	removeCurrentTab();
</SCRIPT>
<%}

	//查询已添加角色
	String paraAray2[] = new String[11];
	paraAray2[0] = "";                                       //流水
	paraAray2[1] = "01";                                     //渠道代码
	paraAray2[2] = opCode;                                   //操作代码
	paraAray2[3] = (String)session.getAttribute("workNo");   //工号
	paraAray2[4] = (String)session.getAttribute("password"); //工号密码
	paraAray2[5] = activePhone;                            //用户号码
	paraAray2[6] = "";       
	paraAray2[7] = "4";    	
	paraAray2[8] = j_ProdCode;    	
	paraAray2[9] = j_GearCode;    	
	paraAray2[10] = j_group_id;    	

%>


  <wtc:service name="sm357Qry" outnum="9" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray2[0]%>" />
		<wtc:param value="<%=paraAray2[1]%>" />	
		<wtc:param value="<%=paraAray2[2]%>" />
		<wtc:param value="<%=paraAray2[3]%>" />
		<wtc:param value="<%=paraAray2[4]%>" />
		<wtc:param value="<%=paraAray2[5]%>" />
		<wtc:param value="<%=paraAray2[6]%>" />
		<wtc:param value="<%=paraAray2[7]%>" />	
		<wtc:param value="<%=paraAray2[8]%>" />	
		<wtc:param value="<%=paraAray2[9]%>" />	
		<wtc:param value="<%=paraAray2[10]%>" />				
	</wtc:service>
	<wtc:array id="result_t3" scope="end"  />
		
<%
	//根据档位代码查询资费
		 String paraAray3[] = new String[8];
						paraAray3[0] = "";                                       //流水
						paraAray3[1] = "01";                                     //渠道代码
						paraAray3[2] = opCode;                                   //操作代码
						paraAray3[3] = (String)session.getAttribute("workNo");   //工号
						paraAray3[4] = (String)session.getAttribute("password"); //工号密码
						paraAray3[5] = activePhone;                            //用户号码
						paraAray3[6] = "";       
						paraAray3[7] = j_GearCode;    	
%>
  <wtc:service name="sm358Qry" outnum="17" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray3[0]%>" />
		<wtc:param value="<%=paraAray3[1]%>" />	
		<wtc:param value="<%=paraAray3[2]%>" />
		<wtc:param value="<%=paraAray3[3]%>" />
		<wtc:param value="<%=paraAray3[4]%>" />
		<wtc:param value="<%=paraAray3[5]%>" />
		<wtc:param value="<%=paraAray3[6]%>" />
		<wtc:param value="<%=paraAray3[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t4" scope="end"  />


<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>	
<SCRIPT language=JavaScript>
var returnValue = "<%=sp_type%>";
var vChkFlag_j = "<%=vChkFlag%>";

var j_EFF_DATE = "";

//重置刷新页面
function reSetThis(){
	  location = location;	
}

function check_offer(bt){
	var j_t_v_CodeValue     = $(bt).attr("v_CodeValue");
	var j_t_v_ClssName      = $(bt).attr("v_ClssName");
	var j_t_v_BPopedomCode  = $(bt).attr("v_BPopedomCode");
	
	
	var c_flag = false;
	var temp_v_OfferName = "";
	$("#offer_table").find("input[type='checkbox']").each(function(){
		var e_CodeValue     = $(this).attr("v_CodeValue");
		var e_BPopedomCode  = $(this).attr("v_BPopedomCode");
		
		if($(this).is(":checked")&&j_t_v_CodeValue==e_CodeValue&&e_BPopedomCode!=j_t_v_BPopedomCode){//此分类已有选中的，不是自己
			temp_v_OfferName = $(this).attr("v_OfferName");
			c_flag = true;
			return false;
		}
	});
	
	if(c_flag){
		rdShowMessageDialog(j_t_v_ClssName+"分类下已选择‘"+temp_v_OfferName+"’");
		$(bt).removeAttr("checked");
	}
}

function show_offer_det(outClssName,offer_name,offer_desc,offer_sum){
	  var h     = 400;
    var w     = 880;
    var t     = screen.availHeight/2-h/2;
    var l     = screen.availWidth/2-w/2;
    var prop  = "dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var tpath = "/npage/sm358/fm358_2.jsp"+
    												"?outClssName="+outClssName+//
    												"&offer_name="+offer_name+//
    												"&offer_desc="+offer_desc+
    												"&offer_sum="+offer_sum+
    												"&opCode=<%=opCode%>"+
    												"&opName=<%=opName%>";
    var ret   = window.showModalDialog(tpath,"",prop);
}

function go_check_OfferSum(){
   var packet = new AJAXPacket("fm358_3.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("inPrePayFee",$("#span_OfferSum").text().trim());//
    core.ajax.sendPacket(packet,do_check_OfferSum);
    packet =null;
}
//查询客户基础信息回调
function do_check_OfferSum(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code=="000000"){//操作成功
      rdShowMessageDialog("预存校验成功",2);
      $("#btn_check_OfferSum").attr("disabled","disabled");
    }else{//调用服务失败
    	rdShowMessageDialog("预存校验失败，"+error_code+"："+error_msg,0);
    }
}
 

function cen_radio_all(bt){
	$(bt).parent().parent().find("input[type='radio']").removeAttr("checked");
	if("N"==$("#offer_table").find("input[type='radio'][v_ClssName='魔百和']").attr("v_IsOrder")){
		if($(bt).parent().parent().find("input[type='radio']").attr("v_ClssName")=="魔百和"){
			$("tr[name='mobaihegroup']").hide();
		}
	}
	
	//是不是12个月内办理的 只有超过12个月 才可以取消
	if("Y"==$(bt).parent().parent().find("input[type='radio'][v_ClssName='魔百和']").attr("v_IsOrder")){
		var j_v_EffDate = $("#offer_table").find("input[type='radio'][v_ClssName='魔百和']").attr("v_EffDate");
		var currentDate = "<%=currentDate%>".substring(0,8);
		
		if(j_v_EffDate.length>8){
			j_v_EffDate = j_v_EffDate.substring(0,8);
			
			var date1 = parseInt(j_v_EffDate.substring(0,4)) * 12 + parseInt(j_v_EffDate.substring(4,6));
			var date2 = parseInt(currentDate.substring(0,4)) * 12 + parseInt(currentDate.substring(4,6));
			//alert("j_v_EffDate = "+j_v_EffDate+"\ncurrentDate = "+currentDate);
			
			/* if(Math.abs(date2 - date1)<12){
				rdShowMessageDialog("魔百和只有超过12个月才可以取消");
				$("#offer_table").find("input[type='radio'][v_ClssName='魔百和']").attr("checked","checked");
			} */
			
		}
		
	}
}



function go_cfm(){
	
	var t_flag     = false;
	var t_ClssName = "";
	$("#offer_table tr:gt(0)").each(function(){
		var t_OfferFlag = $(this).attr("v_OfferFlag");
		if("0"==t_OfferFlag){
			if($(this).find("input[type='radio']:checked").size()==0){
				t_flag     = true;
				t_ClssName = $(this).find("td:eq(0)").text().trim();
				return false;
			}
		}
	});
	
	var submitFlag=false;
	if(!$("tr[name='mobaihegroup']").is(":hidden")){
		if(!subFlag){
			rdShowMessageDialog("imei校验没有通过不允许提交!");
			submitFlag=true;
		}
		
 
		
	}
	if(submitFlag){
		return false;
	}
	
	
	if(t_flag){
		rdShowMessageDialog("分类["+t_ClssName+"]必须选择一个资费");
		return;
	}
 
		var DEPOSIT_FEE = "";
		if(!$("tr[name='mobaihegroup']").is(":hidden")){
			if(typeof($("#mobaiheyajin").val())!="undefined"){
				DEPOSIT_FEE = $("#mobaiheyajin").val().trim();
			}
			
			if(is_show_mobaihe!="Y"){
				DEPOSIT_FEE = "0";
			}
		}
		var OPR_INFO_json = {
												"PHONE_NO":"<%=activePhone%>",
								        "OP_CODE": "<%=opCode%>",
								        "LOGIN_NO": "<%=workNo%>",
								        "LOGIN_ACCEPT": "<%=sysAcceptl%>",
								        "BACK_ACCEPT": "",
								        "OPR_TIME": "<%=currentDate%>",
								        "PROD_CODE":"<%=j_ProdCode%>",//产品代码
        								"PROD_CODE_DW":"<%=j_GearCode%>",//档位代码
        								"OP_NOTE":"家庭产品变更",//操作备注
        								"GROUP_ID":"<%=j_group_id%>",
        								"PROD_CODE_NDW":"<%=j_GearCode%>",
        								"SP_TYPE":returnValue,
        								"DEPOSIT_FEE":DEPOSIT_FEE
											};


		//已添加角色，标志位为Y的拼一条记录
		var BASELINE_INFO_json = [];
		
		$("#old_mem_table tr:gt(0)").each(function(){
			
			
			if($(this).find("td:eq(6)").text().trim()=="Y"){//下标7的标志位
				var t_BASELINE_INFO_json = {
					 			"OPERATE_TYPE": "1",
                "HOME_PHONE": "<%=phoneNo_207%>",
                "MASTER_PHONE": "<%=activePhone%>",
                "MEMBER_PHONE": $(this).find("td:eq(0)").text().trim(),
                "GROUP_ID": "<%=j_group_id%>",
                "EFF_DATE": "",
                "EXP_DATE": $(this).find("td:eq(4)").text().trim()
									 
				};
				BASELINE_INFO_json.push(t_BASELINE_INFO_json);
			}
		});
		
		
		var ADD_OFFER_LIST_json  = [];
    var SP_OFFER_LIST_json   = [];
    
    var LOGINOPR_json = [];
    var MAIN_OFFER_LIST_json = [];
		
		var temp_json = {"PHONE_NO":"<%=activePhone%>"};
    LOGINOPR_json.push(temp_json);
    
    var count_change = 0;
    var sp_offer_flag = false;
    
		$("#offer_table").find("input[type='radio']").each(function(){
			if($(this).is(":checked")){//所有选中的单选框
				
				var t_v_CodeName = $(this).attr("v_CodeName");//拼节点的名称
				
				var t_PHONE_NO = "";
				
				//一个角色标识吧 拿角色标识去上面号码列表里找到对应角色的号码
					var t_v_CodeId = $(this).attr("v_CodeId");
					$("#old_mem_table tr:gt(0)").each(function(){
						var e_role_code = $(this).find("td:eq(1)").text().trim();
						if(t_v_CodeId==e_role_code){
							t_PHONE_NO = $(this).find("td:eq(0)").text().trim();
							return false;
						}
					});
				
				
				var offer_id_t   = $(this).attr("v_BPopedomCode");
		 		var t_v_IsOrder  = $(this).attr("v_IsOrder");//是否为默认选中标志位
		 		
				if(t_v_IsOrder=="Y"){//默认选中还是选中的，不变化
					
				}else{//找到这行有默认选中的offerid拼退订节点
					
					var old_offer_id = $(this).parent().find("input[type='radio'][v_IsOrder='Y']").attr("v_BPopedomCode");
					//3种类型节点，需要判断
					if(t_v_CodeName=="ADD_OFFER_LIST"){
						
						//新增
						var t_temp_json={
										"OPERATE_TYPE": "I",
		                "PHONE_NO": t_PHONE_NO,
		                "EFF_DATE": "<%=n_month_Date%>",
		                "EXP_DATE": "20500101 00:00:00",
		                "OFFER_ID": offer_id_t
						};
						
						ADD_OFFER_LIST_json.push(t_temp_json);
						
						//取消
						if(typeof(old_offer_id)!="undefined"&&old_offer_id!=""&&old_offer_id!="undefined"){
							var t_temp_json={
										"OPERATE_TYPE": "U",
		                "PHONE_NO": t_PHONE_NO,
		                "EFF_DATE": "",
		                "EXP_DATE": "<%=n_month_Date%>",
		                "OFFER_ID": old_offer_id
							};
							
							ADD_OFFER_LIST_json.push(t_temp_json);
						}
						 
						
					}else if(t_v_CodeName=="MAIN_OFFER_LIST"){
						var t_temp_json={
		                "PHONE_NO": t_PHONE_NO,
		                "EFF_DATE": "<%=n_month_Date%>",
		                "EXP_DATE": "20500101 00:00:00",
		                "OFFER_ID": $(this).attr("v_BPopedomCode")
						};
						
						MAIN_OFFER_LIST_json.push(t_temp_json);
					}else if(t_v_CodeName=="SP_OFFER_LIST"){
						 
						$("#old_mem_table").find("td[name='rolename']").each(function(i){
							
							if($(this).text()=="宽带成员"){
								CFM_LOGIN=$("#old_mem_table").find("td[name='phonenumber']").eq(i).text();
							}
						});

						//新增，默认未选中才新增
						//找到魔百合单选框
						var mbh_v_IsOrder = $("#offer_table").find("input[type='radio'][v_ClssName='魔百和']").attr("v_IsOrder");
						
						var SPID = "";
						var BIZCODE = "";
						var STBID = "";
						var ADDRESS = "";
						var CFM_LOGIN="";
						
						
						if("1"==J_count_result){
							SPID    = "";
							BIZCODE = "";
							STBID   = "";
	    				}else{
							if(mbh_v_IsOrder=="N"){
								 SPID=$("#sp_id").val().trim();
								 BIZCODE=$("#biz_code").val().trim();
								 STBID=$("#stb_id").val().trim();
								
								if(SPID==""){
									rdShowMessageDialog("请选择企业代码!");
									sp_offer_flag=true;
								}
								else if(BIZCODE==""){
									rdShowMessageDialog("请选择业务代码!");
									sp_offer_flag=true;
								}
								else if(STBID==""||STBID.length<15){
									rdShowMessageDialog("IMEI码不能为空,且为15位!");
									sp_offer_flag=true;
								}
							}
						}
						
						
						
						$("#old_mem_table").find("td[name='rolename']").each(function(i){
							if($(this).text()=="宽带成员"){
								CFM_LOGIN=$("#old_mem_table").find("td[name='phonenumber']").eq(i).text();
							}
						});
						var t_temp_json={
										 "OPERATE_TYPE": "I",//I代表新增 U代表退订
			                "MEMBER_PHONE": t_PHONE_NO,//成员号码
			                "MASTER_PHONE":"<%=activePhone%>",//付费人号码
			                "OFFER_ID": $(this).attr("v_BPopedomCode"),//资费代码
			                "EFF_DATE": "<%=currentDate%>",
			                "EXP_DATE": "20500101 00:00:00",
			                "SPID":SPID,//企业代码
			                "BIZCODE":BIZCODE,//业务代码
			                "STBID":STBID,//机顶盒ID
			                "CFM_LOGIN":CFM_LOGIN//宽带账号
						};					
						SP_OFFER_LIST_json.push(t_temp_json);
					
						 //取消
						if(typeof(old_offer_id)!="undefined"&&old_offer_id!=""&&old_offer_id!="undefined"){
								var t_temp_json={
											 "OPERATE_TYPE": "U",//I代表新增 U代表退订
				                "MEMBER_PHONE": t_PHONE_NO,//成员号码
				                "MASTER_PHONE":"<%=activePhone%>",//付费人号码
				                "OFFER_ID": old_offer_id,//资费代码
				                "EFF_DATE": "",
				                "EXP_DATE": "<%=n_month_Date%>"
							};					
							SP_OFFER_LIST_json.push(t_temp_json);
						}
					 
					}
					count_change ++;
				}
				
			}
		});
		
		
		//一行完全取消的那种情况
		$("#offer_table tr:gt(0)").each(function(){
				var checkradio_num = $(this).find("input[type='radio'][checked]").size();
				if(checkradio_num==0){//这行没有单选框选中
					//这行默认选中的
					var old_radio_obj = $(this).find("input[type='radio'][v_IsOrder='Y']");
						
					if(old_radio_obj==null||old_radio_obj.size()==0){
						
					}else{
						var t_v_CodeName  = old_radio_obj.attr("v_CodeName");//拼节点的名称
						var old_offer_id  = old_radio_obj.attr("v_BPopedomCode");
						var t_PHONE_NO = "";
						//一个角色标识吧 拿角色标识去上面号码列表里找到对应角色的号码
						var t_v_CodeId = old_radio_obj.attr("v_CodeId");
						$("#old_mem_table tr:gt(0)").each(function(){
							var e_role_code = $(this).find("td:eq(1)").text().trim();
							if(t_v_CodeId==e_role_code){
								t_PHONE_NO = $(this).find("td:eq(0)").text().trim();
								return false;
							}
						});
						
						
						
						//3种类型节点，需要判断
						if(t_v_CodeName=="ADD_OFFER_LIST"){
								var t_temp_json={
											"OPERATE_TYPE": "U",
			                "PHONE_NO": t_PHONE_NO,
			                "EFF_DATE": "",
			                "EXP_DATE": "<%=n_month_Date%>",
			                "OFFER_ID": old_offer_id
								};
								ADD_OFFER_LIST_json.push(t_temp_json);
							 
							
						}else if(t_v_CodeName=="MAIN_OFFER_LIST"){
							var t_temp_json={
			                "PHONE_NO": t_PHONE_NO,
			                "EFF_DATE": "<%=n_month_Date%>",
			                "EXP_DATE": "20500101 00:00:00",
			                "OFFER_ID": old_offer_id
							};
							MAIN_OFFER_LIST_json.push(t_temp_json);
						}else if(t_v_CodeName=="SP_OFFER_LIST"){
							 
							var CFM_LOGIN="";
							$("#old_mem_table").find("td[name='rolename']").each(function(i){
								if($(this).text()=="宽带成员"){
									CFM_LOGIN=$("#old_mem_table").find("td[name='phonenumber']").eq(i).text();
								}
							}); 
							
									var t_temp_json={
												 "OPERATE_TYPE": "U",//I代表新增 U代表退订
					                "MEMBER_PHONE": t_PHONE_NO,//成员号码
					                "MASTER_PHONE":"<%=activePhone%>",//付费人号码
					                "OFFER_ID": old_offer_id,//资费代码
					                "EFF_DATE": "",
					                "EXP_DATE": "<%=n_month_Date%>",
					                "CFM_LOGIN": CFM_LOGIN
									};					
								SP_OFFER_LIST_json.push(t_temp_json);
						}
						
						count_change ++;
					}
				}
		});
		
    
    if(count_change==0){
    		rdShowMessageDialog("资费未发生变化");
    		return;
    }

		if(sp_offer_flag){
			return false;
		}
    
		var BUSI_INFO_json={
			"LOGINOPR":LOGINOPR_json
		};
		
		if(MAIN_OFFER_LIST_json.length > 0){
			BUSI_INFO_json["MAIN_OFFER_LIST"]=MAIN_OFFER_LIST_json;
		}
		
		if(ADD_OFFER_LIST_json.length > 0){
			BUSI_INFO_json["ADD_OFFER_LIST"]=ADD_OFFER_LIST_json;
		}
		
		if(SP_OFFER_LIST_json!=""){
			BUSI_INFO_json["SP_OFFER_LIST"]=SP_OFFER_LIST_json;
		}
		if(BASELINE_INFO_json.length>0){
			BUSI_INFO_json["BASELINE_INFO"]=BASELINE_INFO_json;
		}
	 
					
		var in_json_obj = {
												"OPR_INFO":OPR_INFO_json,
												"BUSI_INFO":BUSI_INFO_json
											};
	
	//拼入参json
		var in_JSONText = JSON.stringify(in_json_obj,function(key,value){
													return value;
											});
				
				
		//alert(in_JSONText);	


	 showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	 if(!$("tr[name='mobaihegroup']").is(":hidden")){
	 		sm359_show_Bill_Prt();
	 	}
   if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;


		var packet = new AJAXPacket("/npage/sm357/fm357_3.jsp","请稍后...");
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
    		rdShowMessageDialog("操作成功",2);
	      removeCurrentTab();
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

    
    function printInfo(printType){
    	if("<%=j_ProdCode%>"=="JTRH"){
    		return printInfo_JTRH();
    	}else if("<%=j_ProdCode%>"=="JTDX"){
    		return printInfo_JTDX();
    	}else if("<%=j_ProdCode%>"=="JTHB"){
    		return printInfo_JTHB();
    	}else if("<%=j_ProdCode%>"=="JTHA"){
    	
    		return printInfo_JTHA();
    	}
    }

    
    function printInfo_JTHA(printType){
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
      						
      opr_info += "办理业务名称：家庭A计划    操作流水: "+"<%=sysAcceptl%>" +"|";
      
      note_info1 += "资费描述："+"|";
	 

	 
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){
					
					var offer_id_temp = $(this).attr("v_BPopedomCode");
 
							
						if("57572"==offer_id_temp){
							note_info1 += "您已成功办理10元共享功能包，套餐24小时内生效。每月成员可共享您套餐内的流量，可享受家庭共享省内移动数据流量500兆，成员间本地通话互打优惠500分钟（允许增加不超过4名家庭成员，2名以上每增加一名收10元功能费）。"+"|";
						}
						
						if("52837"==offer_id_temp){
							note_info1 += "您已成功办理IMS固话业务，月租10元/月，（含200分钟市话）市话0.1元/分钟，长途0.15元/分钟,与家庭成员间互打免费。"+"|";
						}
						
						if("57570"==offer_id_temp){
							note_info1 += "您已成功办理10元1G省内流量加油包，套餐24小时内生效，当月可最多叠加办理10次。 "+"|";
						}
					 
					 
				}
			});  	
			

		  note_info1 += "|";
		  
		  


      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }


    
    function printInfo_JTHB(printType){
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
      						
      opr_info += "办理业务名称：家庭B计划    操作流水: "+"<%=sysAcceptl%>" +"|";
      
      note_info1 += "资费描述："+"|";
	 


      note_info1 += "您已订购中国移动家庭B计划套餐，";
 
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//所有选中的单选框
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"；";
					}
				}
			});      

	 
			note_info1 += temp_note_info1;
			note_info1 += "如选择魔百和业务，套餐生效期间，宽带和魔百和实际可用时间以宽带安装调测成功为准。所缴纳预存款240元，一年内按月均摊返还，返还时间为每月初。"+"|";
      
      
      
      	 
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){
						var offer_id_temp = $(this).attr("v_BPopedomCode");
 
						if("57572"==offer_id_temp){
							note_info1 += "您已成功办理10元共享功能包，套餐24小时内生效。每月成员可共享您套餐内的流量，可享受家庭共享省内移动数据流量500兆，成员间本地通话互打优惠500分钟（允许增加不超过4名家庭成员，2名以上每增加一名收10元功能费）。|";
						}
						
						
						if("52837"==offer_id_temp){
							note_info1 += "您已成功办理IMS固话业务，月租10元/月，（含200分钟市话）市话0.1元/分钟，长途0.15元/分钟,与家庭成员间互打免费。|";
						}
					 
				}
			});  	
			

		 
      note_info2 += "备注：|";
      note_info2 += "1、当月办理产品变更后，当月不允许办理家庭解散。|";
      if(returnValue=="Y"){
    	  note_info2 += "2、如单独退订魔百和业务，魔百和退订功能立即生效。|";
      }
      else{
    	  note_info2 += "2、如单独退订魔百和业务，退订将于当月最后一天的20点生效。|";
      }

      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }


    
	//打印模板id为：
    function printInfo_JTRH(printType){
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
      						
      opr_info += "办理业务名称：和家庭悦享套餐变更    操作流水: "+"<%=sysAcceptl%>" +"|";
      
			note_info1 += "资费描述："+"|";
			
			var temp_note_info1 = "";
			var temp_v_OfferSum = 0;
			var is_mbh_flag = "";//是否含魔百和

			note_info1 += "您已变更中国移动和家庭悦享套餐内容，变更次月1日生效。变更后月使用费";
			
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//所有选中的单选框
					if("魔百和"==$(this).attr("v_ClssName")){
						is_mbh_flag = "魔百和互联网电视业务";//区别为一句话
					}
					var v_OfferSum = $(this).attr("v_OfferSum");
					temp_v_OfferSum = temp_v_OfferSum + parseInt(v_OfferSum);
					
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"，";
					}
					
				}
			}); 
			note_info1 += temp_v_OfferSum+"元（含";
			note_info1 += temp_note_info1;
      note_info1 += "宽带安装首月按实际使用天数收费）；套餐外国内移动数据流量0.29元/M，省内长市漫合一主叫语音0.1元/分钟，省内接听免费，省外国内主叫国内双向收费0.3元/分钟（不含港澳台）。允许增加不超过6名家庭成员，3名以上每增加一名收5元功能费；其他按照标准资费收取。|";    
      
      
			note_info1 +="备注：|";    
			note_info1 +="1、当月办理产品变更后，当月不允许办理家庭解散。|";    
			if(returnValue=="Y"){
				note_info1 += "2、如单独退订魔百和业务，魔百和退订功能立即生效。|";
			}
			else{
				note_info1 += "2、如单独退订魔百和业务，退订将于当月最后一天的20点生效。|";
			}

			note_info2 += "|";
			note_info2 += "家庭套餐合约期为12个月，到期后无政策调整自动顺延原套餐。 |";
			      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }


function printInfo_JTDX(printType){
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
      						
      opr_info += "办理业务名称：家庭保底消费优惠    操作流水: "+"<%=sysAcceptl%>" +"|";
      
      
      var is_mbh_flag = "";//是否含魔百和
			var m_num_count = 0;//家庭成员数量为
			var m_phone_no  = "";//成员手机号码
			
			$("#old_mem_table tr:gt(0)").each(function(){
				if($(this).find("td:eq(2)").text().trim()=="普通成员"){
					m_num_count ++ ;
					m_phone_no += $(this).find("td:eq(0)").text().trim()+"，";
				}
			});
			
			if(m_phone_no.length>0){
				m_phone_no = m_phone_no.substring(0,m_phone_no.length-1);
			}
			
      $("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//所有选中的单选框
					
					if("魔百和"==$(this).attr("v_ClssName")){
						is_mbh_flag = "魔百和互联网电视业务。";//区别为一句话
					}
					
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"，";
					}
					
				}
			}); 
			
			if(temp_note_info1.length>0){
				temp_note_info1 = temp_note_info1.substring(0,temp_note_info1.length-1);
			}
			note_info1 += "资费描述："+"|";
			note_info1 += "您已变更家庭保底消费优惠底线，当前家庭成员数量为"+m_num_count+"人，成员手机号码分别为"+m_phone_no+"。";
			note_info1 += temp_note_info1+" "+is_mbh_flag;
			note_info1 += "|";
			
			note_info1 +="备注：|";    
			note_info1 +="1、当月办理产品变更后，当月不允许办理家庭解散。|";    
			note_info1 +="2、如办理底线变更后，不符合魔百和业务赠送条件，魔百和将于当月最后一天的20点自动退订。|";   
			

			note_info2 += "|";
			note_info2 += "家庭套餐合约期为12个月，到期后无政策调整自动顺延原套餐。 |";
			
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
    
    
function go_get_prt_info(){
		var packet = new AJAXPacket("/npage/sm357/fm357_7.jsp","请稍后...");
	      packet.data.add("opCode","<%=opCode%>");// 
	      packet.data.add("phoneNo","<%=activePhone%>");//手机号
	      packet.data.add("inProdCode","");//
	      packet.data.add("inGearCode","");//
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

    
$(document).ready(function(){
	$("tr[name='mobaihegroup']").hide();
	if("N"==$("#offer_table").find("input[type='radio'][v_ClssName='魔百和']").attr("v_IsOrder")){
		$("input[type='radio']").click(function (){
			if($(this).attr("v_ClssName")=="魔百和"){
			 $("tr[name='mobaihegroup']").show();
			}
		});
	}
	
	//找到出参13位为N的隐藏这行默认选中	
$("#offer_table input[type='radio'][v_is_show='N']").each(function(){
	$(this).attr("checked","checked");
	$(this).parent().parent().hide();
});


var mbh_obj = $("#offer_table").find("input[type='radio'][v_ClssName='魔百和']");
$(mbh_obj).click(function(){
	if(mbh_obj.attr("v_IsOrder")!="Y"){// 发现魔百和没被选中  然后订购时判断 家庭产品生效的当月才可以单独在家庭中办理
			var j_EFF_DATE_j = "";
			if("<%=j_EFF_DATE%>".length>8){
				j_EFF_DATE_j = "<%=j_EFF_DATE%>".substring(0,6);
			}
			
			<%-- if(j_EFF_DATE_j!="<%=currentDate%>".substring(0,6)){
				rdShowMessageDialog("家庭产品生效的当月才可以单独在家庭中办理");
				mbh_obj.removeAttr("checked");
				$("tr[name='mobaihegroup']").hide();
			} --%>
			
	}
});



$("#offer_table tr:gt(0)").each(function(){
	//有2个默认选中的
	if($(this).find("input[type='radio'][v_IsOrder='Y']").size()>1){
		//置灰此行
		$(this).find("input").attr("disabled","disabled");
		//选中这行状态是A的
		$(this).find("input[type='radio'][v_offer_status='A']").attr("checked","checked");
		
	}
});


	$("input[type='radio']").click(function (){
		if($(this).parent().parent().find("td:eq(0)").text().trim()=="魔百和"){
			go_check_DDSMPORDERMSG();
		}
		
	})


});


var J_count_result="";
function go_check_DDSMPORDERMSG(){
		var packet = new AJAXPacket("/npage/sm358/fm358_5.jsp","请稍后...");
	      packet.data.add("phoneNo","<%=activePhone%>");//手机号
    core.ajax.sendPacket(packet,do_check_DDSMPORDERMSG);
    packet =null;
}
function do_check_DDSMPORDERMSG(packet){
		var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg  =  packet.data.findValueByName("msg");//返回信息

    if(error_code=="000000"){//操作成功
    	J_count_result = packet.data.findValueByName("count_result");//返回信息
    	if("1"==J_count_result){
    		if("<%=j_ProdCode%>"=="JTRH"){
    			rdShowMessageDialog("用户已经订购魔百和，不允许再订购");
    			$("input[type='radio']").click(function (){
						if($(this).attr("v_ClssName")=="魔百和"){
							$(this).removeAttr("checked");
						}
					})
    		}
    		if("<%=j_ProdCode%>"=="JTDX"){
    		}
    		$("tr[name='mobaihegroup']").hide();
    		returnValue="N";
    	}else{
    		$("tr[name='mobaihegroup']").show();
    		subFlag = false;
			$("#jiaoyanButton").attr("disabled","");
			$("#stb_id").attr("readonly","");
			$("#stb_id").val("");
    	}
    }
}

var subFlag=false;
function go_stb_id(){
	if(!$("#jiaoyanButton").is(":disabled")){
		$("#jiaoyanButton").attr("disabled","disabled");
		$("#stb_id").attr("readonly","readonly");
		// readonly="readonly"
	}
	var packet = new AJAXPacket("/npage/sm358/fm358_6.jsp","请稍后...");
	packet.data.add("opCode","<%=opCode%>");
	packet.data.add("phoneNo","<%=activePhone%>");//手机号
    packet.data.add("stb_id",$("#stb_id").val());//
    core.ajax.sendPacket(packet,do_stb_id);
    packet =null;
}
var is_show_mobaihe = "";
function do_stb_id(packet){
	subFlag=false;
	var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code=="000000"){//操作成功
    	subFlag=true;
    	returnValue=packet.data.findValueByName("returnValue");
    	    	is_show_mobaihe = packet.data.findValueByName("returnValue");
    	if(is_show_mobaihe=="Y"){
    		$("#td_mobaihe1").show();
    		$("#td_mobaihe2").show();
    	}else{
    		$("#td_mobaihe1").hide();
    		$("#td_mobaihe2").hide();
    	}
    	rdShowMessageDialog("IMEI码校验成功!");
    }else{//调用服务失败
    	subFlag = false;
    	rdShowMessageDialog(error_code+":"+error_msg);
    	if($("#jiaoyanButton").is(":disabled")){
    		$("#jiaoyanButton").attr("disabled","");
    		$("#stb_id").attr("readonly","");
    	}
	    return;
   }
}

//打印发票
function sm359_show_Bill_Prt(){
			var jf_money = "";
			if(is_show_mobaihe=="Y"){
				jf_money = $("#mobaiheyajin").val();
			}else{
				jf_money = "0";
			}
			var  billArgsObj = new Object();
			$(billArgsObj).attr("10001","<%=workNo%>");     //工号
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",$("#prt_cust_name").val());   //客户名称
			$(billArgsObj).attr("10006","家庭产品变更-魔百和押金");    //业务类别
			
			$(billArgsObj).attr("10008","<%=activePhone%>");    //用户号码
			$(billArgsObj).attr("10015",jf_money);   //本次发票金额
			$(billArgsObj).attr("10016",jf_money);   //大写金额合计
			$(billArgsObj).attr("10017","*");        //本次缴费：现金
			/*10028 10029 不打印*/
		  	$(billArgsObj).attr("10028","");   //参与的营销活动名称：
			$(billArgsObj).attr("10029","");	 //营销代码	
			$(billArgsObj).attr("10030","<%=sysAcceptl%>");   //流水号：--业务流水
			$(billArgsObj).attr("10036","m358");   //操作代码
			/**/

			
			/*型号不打*/
			$(billArgsObj).attr("10061","");	       //型号
			$(billArgsObj).attr("10062","");	//税率
			$(billArgsObj).attr("10063","");	//税额	   
	    	$(billArgsObj).attr("10071","6");	//
	 		$(billArgsObj).attr("10076",0);
 			
 			$(billArgsObj).attr("10083", ""); //证件类型
 			$(billArgsObj).attr("10084", ""); //证件号码
 			$(billArgsObj).attr("10086", "尊敬的客户，如您办理业务退订、取消等中止业务使用的操作时，请携带本收据、有效身份证件、办理业务时所得魔百和终端到移动指定自有营业厅办理押金退还手续。"); //备注
 			$(billArgsObj).attr("10065", ""); //宽带账号
 			$(billArgsObj).attr("10087", $("#stb_id").val()); //imei号码
 			
			$(billArgsObj).attr("10041", "魔百和终端押金费用");           //品名规格
			$(billArgsObj).attr("10042","台");                   //单位
			$(billArgsObj).attr("10043","1");	                   //数量
			$(billArgsObj).attr("10044",jf_money);	                //单价
			
 			$(billArgsObj).attr("10085", "zsj"); //宽带费用收取方式 只弹出打印收据的框
 			$(billArgsObj).attr("10072","1"); //1--正常发票  2--冲正类发票  2--退费类发票

 			$(billArgsObj).attr("10088","m358"); //收据模块
 			
 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？";
			
						//发票项目修改为新路径
			$(billArgsObj).attr("11213","REC");  //新版发票新增票据标志位，默认空位发票 REC == 只有 打印纸质收据
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "确实要进行发票打印吗？";

			var loginAccept = "<%=sysAcceptl%>";
			var path = path +"&loginAccept="+loginAccept+"&opCode=m358&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);		

}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
<input type="hidden" id="prt_cust_name" name="prt_cust_name" value="" />
<input type="hidden" id="prt_cust_bran" name="prt_cust_bran" value="" />
<input type="hidden" id="prt_note_into" name="prt_note_into" value="" />		
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">选择产品G</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="25%">家庭产品：</td>
		  <td width="25%">
		  	<%=j_ProdName%>
		  </td>
 
	    <td class="blue" width="25%">产品档位：</td>
		  <td width="25%">
			   <%=j_GearName%>
		  </td>
	</tr>
	<tr>
		<td class="blue">群组：</td>
		<td colspan="3">
			<%=j_group_id%>
		</td>
	</tr>
</table>

<div class="title"><div id="title_zi">已添加角色</div></div>
<table cellSpacing="0"  id="old_mem_table">
	<tr>
		<th width="25%" name="phonenumber">手机号码</th>
		<th style="display:none">角色代码</th>
		<th width="25%" name="rolename">角色名称</th>
		<th width="25%">生效时间</th>
		<th width="25%">失效时间</th>
		<th style="display:none">标志位，标识是否需要付费，返回Y的代表需要付费，需要拼一条PAY_INFO</th>
	</tr>
<%
for(int i=0;i<result_t3.length;i++){
%>
<tr>
	<td name="phonenumber"><%=result_t3[i][0]%></td>
	<td  style="display:none"><%=result_t3[i][6]%></td>
	<td name="rolename"><%=result_t3[i][1]%></td>
	<td><%=result_t3[i][2]%></td>
	<td><%=result_t3[i][3]%></td>
	<td  style="display:none" ><%=result_t3[i][8]%></td>
	<td  style="display:none" ><%=result_t3[i][7]%></td>
</tr>
<%
}
%>
</table>


<div class="title"><div id="title_zi">资费列表</div></div>
<table cellSpacing="0"  id="offer_table">
	 <tr>
		<th width="25%">资费分类</th>
		<th colspan='2'>资费名称</th>
		<th width="25%">操作</th>
	</tr>
<%
String ja_ClssName = "";
if(result_t4.length>0){
	ja_ClssName = result_t4[0][10];
	out.print("<tr v_OfferFlag='"+result_t4[0][11]+"'>");
	out.print("<td>"+result_t4[0][10]+"</td>");
	out.print("<td colspan='2'>");
}

for(int i=0;i<result_t4.length;i++){
	
	 
	
	
	String checked_str = "";
	
	if("Y".equals(result_t4[i][9])){
		checked_str = "checked";
	}
	
if(ja_ClssName.equals(result_t4[i][10])){//一行
	
	//是否被选中
	
%>

	<input  type="radio" name="offer_radio_<%=result_t4[i][4]%>"
														v_PopedomCode='<%=result_t4[i][0]%>' 
														v_CodeId='<%=result_t4[i][1]%>' 
														v_TopCodeId='<%=result_t4[i][2]%>' 
														v_CodeName='<%=result_t4[i][3]%>' 
														v_CodeValue='<%=result_t4[i][4]%>' 
														v_BPopedomCode='<%=result_t4[i][5]%>' 
														v_OfferName='<%=result_t4[i][6]%>' 
														v_OfferComments='<%=result_t4[i][7]%>' 
														v_OfferSum='<%=result_t4[i][8]%>' 
														v_IsOrder='<%=result_t4[i][9]%>' 
														v_ClssName='<%=result_t4[i][10]%>' 
														v_OfferFlag='<%=result_t4[i][11]%>' 
														v_OfferDesc='<%=result_t4[i][12]%>' 
														v_is_show='<%=result_t4[i][13]%>'
														v_EffDate='<%=result_t4[i][14]%>'
														v_offer_status='<%=result_t4[i][16]%>'
			<%=checked_str%>
	 />
	
	<a href="javascript:void(0)" onclick="show_offer_det('<%=result_t4[i][10]%>','<%=result_t4[i][6]%>','<%=result_t4[i][7]%>','<%=result_t4[i][8]%>')"><%=result_t4[i][6]%></a>

<%	
}else{
	out.print("</td>");
	out.print("<td><input type='button' value='取消' class='b_text' onclick='cen_radio_all(this)' ></td>");
	out.print("</tr>");
	out.print("<tr v_OfferFlag='"+result_t4[i][11]+"'>");
	out.print("<td>"+result_t4[i][10]+"</td>");
	out.print("<td colspan='2'>");
%>
	<input  type="radio" name="offer_radio_<%=result_t4[i][4]%>"
														v_PopedomCode='<%=result_t4[i][0]%>' 
														v_CodeId='<%=result_t4[i][1]%>' 
														v_TopCodeId='<%=result_t4[i][2]%>' 
														v_CodeName='<%=result_t4[i][3]%>' 
														v_CodeValue='<%=result_t4[i][4]%>' 
														v_BPopedomCode='<%=result_t4[i][5]%>' 
														v_OfferName='<%=result_t4[i][6]%>' 
														v_OfferComments='<%=result_t4[i][7]%>' 
														v_OfferSum='<%=result_t4[i][8]%>' 
														v_IsOrder='<%=result_t4[i][9]%>' 
														v_ClssName='<%=result_t4[i][10]%>' 
														v_OfferFlag='<%=result_t4[i][11]%>' 
														v_OfferDesc='<%=result_t4[i][12]%>' 
														v_is_show='<%=result_t4[i][13]%>'
														v_EffDate='<%=result_t4[i][14]%>'
														v_offer_status='<%=result_t4[i][16]%>'
						<%=checked_str%>													
	 />
	
	<a href="javascript:void(0)" onclick="show_offer_det('<%=result_t4[i][10]%>','<%=result_t4[i][6]%>','<%=result_t4[i][7]%>','<%=result_t4[i][8]%>')"><%=result_t4[i][6]%></a>

<%	
	ja_ClssName = result_t4[i][10];
}
%>

	
<%
}

if(result_t4.length>0){
	out.print("</td>");
	out.print("<td><input type='button' value='取消' class='b_text' onclick='cen_radio_all(this)' ></td>");
	out.print("</tr>");
}	
%>


 <tr name="mobaihegroup" style="display:none">
 	<td scope="col" width="10%">企业代码</td>
 	<td scope="col" width="40%">
	 	<select id="sp_id" name="sp_id">
	 		<option value="">-请选择-</option>
	 		<option value="699213">未来电视</option>
	 		<option value="699212">百视通</option>
	 	</select>
 	</td>
 	<td scope="col" width="10%">业务代码</td>
 	<td scope="col" width="40%">
 		<select id="biz_code" name="biz_code">
	 		<option value="20830000">20830000</option>
	 	</select>
 	</td>
 	
 	</tr>
 <tr name="mobaihegroup" style="display:none">
 	<!-- 003903FF00210070 -->
 	<td scope="col">IMEI码</td>
 	<td scope="col"><input type="text" id="stb_id" name="stb_id" size="40" value="" maxlength="32">
 	<input type="button" class='b_text' id="jiaoyanButton" value="校验" onclick="go_stb_id()"/>
 	</td>
 	<td scope="col" id="td_mobaihe1" style="display:none">魔百合押金</td>
 	<td  id="td_mobaihe2" style="display:none">
 		
 		<input type="text" id="mobaiheyajin" name="mobaiheyajin" maxlength="3"  readOnly="readOnly" class="InputGrey" value="0" value="100" v_must="0" v_type="money"  onblur = "checkElement(this)"  />
 	</td>
 	</tr>

</table>

<table cellSpacing="0">
	<tr>
		<td><font class="orange">备注：如果当月做完产品变更，当月则不允许办理家庭解散业务</font> </td>
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
<div id="messagediv"></div>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>