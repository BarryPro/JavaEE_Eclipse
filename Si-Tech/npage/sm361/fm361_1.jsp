<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟2016-3-29 10:17:41------------------
 

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
	
	System.out.println("--hejwa------fm360_1.jsp----AAAAAAAAAAA-----Currentdate--AAAAAAAAAAA----------->"+currentDate);
		
	java.util.Calendar cal = java.util.Calendar.getInstance(); 
	cal.add(Calendar.MONTH, 1); 
	cal.set(Calendar.DATE, 1); 
	String n_month_Date = new java.text.SimpleDateFormat("yyyyMMdd 00:00:00").format(new java.util.Date(cal.getTimeInMillis()));


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
	
%> 
		
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
		
		if("N".equals(vChkFlag)){
%>
<SCRIPT language=JavaScript>
	rdShowMessageDialog("此用户未创建家庭，请到m357进行创建");
	removeCurrentTab();
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
	
	String j_offer_flag  = "";
	String prod_eff_date = "";
	String prod_order_flag = "";
	String sp_type = "";
	
	if("000000".equals(code)){
		if(result_t2.length>0){
			j_ProdCode = result_t2[0][1];
			j_ProdName = result_t2[0][0];
			j_GearCode = result_t2[0][3];
			j_GearName = result_t2[0][2];
			j_group_id = result_t2[0][4];
			j_offer_flag    = result_t2[0][5];
			prod_order_flag = result_t2[0][6];
			prod_eff_date   = result_t2[0][7];
			sp_type = result_t2[0][11];
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
		 String paraAray4[] = new String[8];
						paraAray4[0] = "";                                       //流水
						paraAray4[1] = "01";                                     //渠道代码
						paraAray4[2] = opCode;                                   //操作代码
						paraAray4[3] = (String)session.getAttribute("workNo");   //工号
						paraAray4[4] = (String)session.getAttribute("password"); //工号密码
						paraAray4[5] = activePhone;                            //用户号码
						paraAray4[6] = "";       
						paraAray4[7] = j_GearCode;    	
%>


  <wtc:service name="sm358Qry" outnum="17" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray4[0]%>" />
		<wtc:param value="<%=paraAray4[1]%>" />	
		<wtc:param value="<%=paraAray4[2]%>" />
		<wtc:param value="<%=paraAray4[3]%>" />
		<wtc:param value="<%=paraAray4[4]%>" />
		<wtc:param value="<%=paraAray4[5]%>" />
		<wtc:param value="<%=paraAray4[6]%>" />
		<wtc:param value="<%=paraAray4[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t4" scope="end"  />
		
<%
if("1".equals(prod_order_flag)){
	n_month_Date = currentDate;
}
%>
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>	
<SCRIPT language=JavaScript>

var j_EFF_DATE = "";

//重置刷新页面
function reSetThis(){
	  location = location;	
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



function go_cfm(){
 
	
		var OPR_INFO_json = {
												"PHONE_NO":"<%=activePhone%>",
								        "OP_CODE": "<%=opCode%>",
								        "LOGIN_NO": "<%=workNo%>",
								        "LOGIN_ACCEPT": "<%=sysAcceptl%>",
								        "BACK_ACCEPT": "",
								        "OPR_TIME": "<%=currentDate%>",
								        "PROD_CODE":"<%=j_ProdCode%>",//产品代码
        								"PROD_CODE_DW":"<%=j_GearCode%>",//档位代码
        								"OP_NOTE":"家庭冲正",//操作备注
        								"GROUP_ID":"<%=j_group_id%>",
        								"BACK_ACCEPT": $("#loginAccept").val(),
        								"SP_TYPE":"<%=sp_type%>"
											};

			
		
		//已添加角色，标志位为Y的拼一条记录
		var PAY_INFO_json      = [];
		var BASELINE_INFO_json = [];
		
		$("#old_mem_table tr:gt(0)").each(function(){
			if($(this).find("td:eq(5)").text().trim()=="Y"){//下标8的标志位
				var t_PAY_INFO_json = {
									"OPERATE_TYPE": "U",
	                "MASTER_PHONE": "<%=activePhone%>",
	                "MEMBER_PHONE": $(this).find("td:eq(0)").text().trim(),
	                "EFF_DATE":"",
	                "EXP_DATE": "<%=n_month_Date%>"
				};
				PAY_INFO_json.push(t_PAY_INFO_json);
			}
			
			if($(this).find("td:eq(6)").text().trim()=="Y"){//下标7的标志位
				var t_BASELINE_INFO_json = {
					 			"OPERATE_TYPE": "2",
                "HOME_PHONE": "<%=phoneNo_207%>",
                "MASTER_PHONE": "<%=activePhone%>",
                "MEMBER_PHONE": $(this).find("td:eq(0)").text().trim(),
                "GROUP_ID": "<%=j_group_id%>",
                "EFF_DATE": "",
                "EXP_DATE": "<%=n_month_Date%>"
									 
				};
				BASELINE_INFO_json.push(t_BASELINE_INFO_json);
			}
		});
		
		
    var SP_OFFER_LIST_json   = [];
    
    var LOGINOPR_json = [];
		
		var temp_json = {"PHONE_NO":"<%=activePhone%>"};
    LOGINOPR_json.push(temp_json);
    
    
    $("#old_offer_table").find("input[type='hidden']").each(function(){
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
				
		 
				
				//3种类型节点，需要判断
				if(t_v_CodeName=="SP_OFFER_LIST"){
					var CFM_LOGIN = "";
					$("#old_mem_table").find("td[name='rolename']").each(function(i){
							if($(this).text()=="宽带成员"){
								CFM_LOGIN=$("#old_mem_table").find("td[name='phonenumber']").eq(i).text();
							}
						});
					var t_temp_json={
									 "OPERATE_TYPE": "D",//I代表新增 U代表退订
		                "MEMBER_PHONE": t_PHONE_NO,//成员号码
		                "MASTER_PHONE":"<%=activePhone%>",//付费人号码
		                "OFFER_ID": $(this).attr("v_BPopedomCode"),//资费代码
		                "EFF_DATE": "",
		                "EXP_DATE": "<%=n_month_Date%>",
		                "CFM_LOGIN":CFM_LOGIN
					};					
					SP_OFFER_LIST_json.push(t_temp_json);
				}
    });
    

    
    
		var BUSI_INFO_json={};
		BUSI_INFO_json = {
					"PAY_INFO":PAY_INFO_json,
      		"FAM_INS_INFO":{
						"OPERATE_TYPE": "D",//代表新增  U代表修改
						"GROUP_ID":"<%=j_group_id%>",//家庭群组
						"STATE":"1",//默认2
						"PROD_EFF_DATE": "<%=prod_eff_date%>",//产品生效时间 
						"PROD_EXP_DATE": "<%=n_month_Date%>"
					},
					"LOGINOPR":LOGINOPR_json
					
			};
 

		
		
		if(SP_OFFER_LIST_json!=""){
			BUSI_INFO_json["SP_OFFER_LIST"]=SP_OFFER_LIST_json;
		}
		if(BASELINE_INFO_json.length>0){
			BUSI_INFO_json["BASELINE_INFO"]=BASELINE_INFO_json;
		}
		
		
		if("<%=j_offer_flag%>"=="Y"){
			BUSI_INFO_json["SPECIAL_FUND_INFO"]={
		    "OPERATE_TYPE": "D",//I新增专款 U取消专款 D冲正专款
		    "SPECIAL_FUND_FEE": "",//专款金额
		    "EFF_DATE": "",//专款开始时间
		    "EXP_DATE": "<%=n_month_Date%>"
			};
		}
					
		var in_json_obj = {
												"OPR_INFO":OPR_INFO_json,
												"BUSI_INFO":BUSI_INFO_json
											};
	
	//拼入参json
		var in_JSONText = JSON.stringify(in_json_obj,function(key,value){
													return value;
											});
				
				
				
	  showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
   if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
		
	//	$("#messagediv").text(in_JSONText);
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
      						
      opr_info += "办理业务名称：家庭冲正    操作流水: "+"<%=sysAcceptl%>" +"|";
      
      
      note_info1 += "备注：|";
    	
			
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
	
	$("#old_offer_table tr:gt(0)").each(function(){
		if($(this).find("td:eq(1)").text().trim()==""){
			$(this).hide();
		}
	});
	
	//找到出参13位为N的隐藏这行默认选中	
	$("#old_offer_table input[type='hidden'][v_is_show='N']").each(function(){
		$(this).attr("checked","checked");
		$(this).parent().parent().hide();
	});

});    




function go_check_accept(){
		if($("#loginAccept").val()==""){
			rdShowMessageDialog("请输入冲正流水");
			return;
		}
   var packet = new AJAXPacket("fm361_2.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("loginAccept",$("#loginAccept").val().trim());//
    core.ajax.sendPacket(packet,do_check_accept);
    packet =null;
}
//查询客户基础信息回调
function do_check_accept(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code=="000000"){//操作成功
      rdShowMessageDialog("校验成功",2);
      $("#loginAccept").attr("disabled","disabled");
      $("#check_accept").attr("disabled","disabled");
      $("#submit").removeAttr("disabled");
    }else{//调用服务失败
    	rdShowMessageDialog("校验失败，"+error_code+"："+error_msg,0);
    	$("#submit").attr("disabled","disabled");
    }
}


</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
<input type="hidden" id="prt_cust_name" name="prt_cust_name" value="" />
<input type="hidden" id="prt_cust_bran" name="prt_cust_bran" value="" />
<input type="hidden" id="prt_note_into" name="prt_note_into" value="" />		
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">选择产品</div></div>


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



<div class="title"><div id="title_zi">已订购资费列表</div></div>
<table cellSpacing="0"  id="old_offer_table">
	 <tr>
		<th width="25%">资费分类</th>
		<th >资费名称</th>
	</tr>
<%
String ja_ClssName = "";
if(result_t4.length>0){
	ja_ClssName = result_t4[0][10];
	out.print("<tr v_OfferFlag='"+result_t4[0][11]+"'>");
	out.print("<td>"+result_t4[0][10]+"</td>");
	out.print("<td >");
}

for(int i=0;i<result_t4.length;i++){

if(ja_ClssName.equals(result_t4[i][10])){//一行
if("Y".equals(result_t4[i][9])){
%>

	<input  type="hidden" name="offer_radio_<%=result_t4[i][4]%>"
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
														v_is_show='<%=result_t4[i][13]%>'
	 />
	
	<a href="javascript:void(0)" onclick="show_offer_det('<%=result_t4[i][10]%>','<%=result_t4[i][6]%>','<%=result_t4[i][7]%>','<%=result_t4[i][8]%>')"><%=result_t4[i][6]%></a>

<%
}	
}else{
	out.print("</td>");
	out.print("</tr>");
	out.print("<tr v_OfferFlag='"+result_t4[i][11]+"'>");
	out.print("<td>"+result_t4[i][10]+"</td>");
	out.print("<td >");
	if("Y".equals(result_t4[i][9])){
%>
	<input  type="hidden" name="offer_radio_<%=result_t4[i][4]%>"
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
														v_is_show='<%=result_t4[i][13]%>'
	 />
	
	<a href="javascript:void(0)" onclick="show_offer_det('<%=result_t4[i][10]%>','<%=result_t4[i][6]%>','<%=result_t4[i][7]%>','<%=result_t4[i][8]%>')"><%=result_t4[i][6]%></a>

<%	
}
	ja_ClssName = result_t4[i][10];
}
%>

	
<%
}

if(result_t4.length>0){
	out.print("</td>");
	out.print("</tr>");
}	
%>

</table>


<table cellSpacing="0">
	 <tr>
	 	<td class="blue" width="25%">
	 		冲正流水：
	 	</td>
	 	<td>
	 		<input type="text" name="loginAccept" id="loginAccept" maxlength="14" v_type="0_9" v_must="1"  onblur="checkElement(this)" />
	 		<input type="button" class="b_text" id="check_accept" value="校验" onclick="go_check_accept()" />
	 	</td>
	</tr>
</table>

<table cellSpacing="0">
	<tr>
	 	<td style="color:red" align="center">
	 		魔百合设备请去“(g836)押金返还业务”进行返回
	 	</td>
	</tr>
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定" onclick="go_cfm()"   id="submit"  disabled      />
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