<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2016-3-4 15:52:06------------------
 

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

	java.util.Calendar cal = java.util.Calendar.getInstance(); 
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
	System.out.println("--hejwa------fm358_1.jsp----AAAAAAAAAAA-----Currentdate--AAAAAAAAAAA----------->"+currentDate);
	
	
	cal.add(Calendar.MONTH, 1); 
	cal.set(Calendar.DATE, 1); 
	String n_month_Date = new java.text.SimpleDateFormat("yyyyMMdd 00:00:00").format(new java.util.Date(cal.getTimeInMillis()));

	
	
	String paraAray[] = new String[9];
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = activePhone;                              //用户号码
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
	
	String j_offer_flag = "";
	String sp_type = "";
	
	if("000000".equals(code)){
		if(result_t2.length>0){
			j_ProdCode = result_t2[0][1];
			j_ProdName = result_t2[0][0];
			j_GearCode = result_t2[0][3];
			j_GearName = result_t2[0][2];
			j_group_id = result_t2[0][4];
			j_offer_flag = result_t2[0][5];
			sp_type = result_t2[0][11];
		}
	}else if("m35899".equals(code)){
		System.out.println("----------1-----2----m358a--2--1------->");
%>
<SCRIPT language=JavaScript>
		var path = "/npage/sm359/fm359_5.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhoneNo=<%=activePhone%>";
		location = path;		
</SCRIPT>			
<%	
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
  <wtc:service name="sm358Qry" outnum="20" retmsg="msg_sm358Qry" retcode="code_sm358Qry" routerKey="region" routerValue="<%=regionCode%>">
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

<%


if(!"000000".equals(code_sm358Qry)){
%>

<SCRIPT language=JavaScript>
	rdShowMessageDialog("sm358Qry错误：<%=code_sm358Qry%>，<%=msg_sm358Qry%>");
	removeCurrentTab();
</SCRIPT>
<%
}
%>

<%
String outEffectType_id   = "";
String outEffectType_name = "";

//查询生效方式
//0   生方式效         	outEffectType    0 立即生效 2预约生效

		 String paraAray4[] = new String[8];
						paraAray4[0] = "";                                       //流水
						paraAray4[1] = "01";                                     //渠道代码
						paraAray4[2] = opCode;                                   //操作代码
						paraAray4[3] = (String)session.getAttribute("workNo");   //工号
						paraAray4[4] = (String)session.getAttribute("password"); //工号密码
						paraAray4[5] = activePhone;                            //用户号码
						paraAray4[6] = "";       
						paraAray4[7] = j_GearCode;    
						
						for(int hi=0;hi<paraAray4.length;hi++){
							System.out.println("-------hejwa--------------paraAray4["+hi+"]----------->"+paraAray4[hi]);
						}
%>
  <wtc:service name="sm358EffType" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray3[0]%>" />
		<wtc:param value="<%=paraAray3[1]%>" />	
		<wtc:param value="<%=paraAray3[2]%>" />
		<wtc:param value="<%=paraAray3[3]%>" />
		<wtc:param value="<%=paraAray3[4]%>" />
		<wtc:param value="<%=paraAray3[5]%>" />
		<wtc:param value="<%=paraAray3[6]%>" />
		<wtc:param value="<%=paraAray3[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t5" scope="end"  />

<%

	for(int iii=0;iii<result_t5.length;iii++){
		for(int jjj=0;jjj<result_t5[iii].length;jjj++){
			System.out.println("---------------------result_t5["+iii+"]["+jjj+"]=-----------------"+result_t5[iii][jjj]);
		}
	}
	
		
	if(result_t5.length>0){
		outEffectType_id   = result_t5[0][0];
		outEffectType_name = result_t5[0][1];
	}
	if(outEffectType_id==null||"null".equalsIgnoreCase(outEffectType_id)){
		outEffectType_id = "";
	}
	
	
		 String paraAray5[] = new String[8];
						paraAray5[0] = "";                                       //流水
						paraAray5[1] = "01";                                     //渠道代码
						paraAray5[2] = opCode;                                   //操作代码
						paraAray5[3] = (String)session.getAttribute("workNo");   //工号
						paraAray5[4] = (String)session.getAttribute("password"); //工号密码
						paraAray5[5] = activePhone;                            //用户号码
						paraAray5[6] = "";       
						paraAray5[7] = j_GearCode;    
						
		String outMonthFee = "";						
		String outMonthNum = "";
%>

  <wtc:service name="sm358FeeQry" outnum="2" retmsg="msg_sm358FeeQry" retcode="code_sm358FeeQry" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray5[0]%>" />
		<wtc:param value="<%=paraAray5[1]%>" />	
		<wtc:param value="<%=paraAray5[2]%>" />
		<wtc:param value="<%=paraAray5[3]%>" />
		<wtc:param value="<%=paraAray5[4]%>" />
		<wtc:param value="<%=paraAray5[5]%>" />
		<wtc:param value="<%=paraAray5[6]%>" />
		<wtc:param value="<%=paraAray5[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t6" scope="end"  />
		
<%
	if(result_t6.length>0){
		outMonthFee = result_t6[0][0];
		outMonthNum = result_t6[0][1];
	}
%>
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>	
<SCRIPT language=JavaScript>
var returnValue="<%=sp_type%>";
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
    var tpath = "fm358_2.jsp"+
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
      //$("#btn_check_OfferSum").attr("disabled","disabled");
    }else{//调用服务失败
    	rdShowMessageDialog("预存校验失败，"+error_code+"："+error_msg,0);
    }
}

function add_OfferSum(bt){
	
	var t_offerSum = 0;
	$("#offer_table").find("input[type='radio']").each(function(){
		if($(this).is(":checked")){//所有选中的单选框
			t_offerSum += parseInt($(this).attr("v_OfferSum"));
		}
	});
	
	$("#span_OfferSum").text(t_offerSum);
	//数字有变化，校验按钮去掉置灰
	//$("#btn_check_OfferSum").removeAttr("disabled");
}


function cen_radio_all(bt){
	$(bt).parent().parent().find("input[type='radio']").removeAttr("checked");
	
	if($(bt).parent().parent().find("td:eq(0)").text().trim()=="魔百和"){
		$("tr[name='mobaihegroup']").hide();
	}
	
	add_OfferSum();//刷新预存
}


var in_JSONText="";
function go_cfm(){
	if("<%=outEffectType_id%>"==""){
		rdShowMessageDialog("未查询到生效方式");
		return;
	}

	if($("#sel_outEffectType").val()==""){
		rdShowMessageDialog("请选择生效方式");
		return false;
	}
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
	
	
	if(t_flag){
		rdShowMessageDialog("分类["+t_ClssName+"]必须选择一个资费");
		return;
	}
	
	t_flag = false;
	$("#offer_table tr:gt(0):visible").each(function(){
			var offer_name=$(this).find("td:eq(0)").text().trim();
		
			var U_v_B17_value = $(this).attr("v_B17_value");
			var U_v_H19_value = $(this).attr("v_H19_value");
			
			
			if(U_v_B17_value!="SS"){
				
				var U_v_E18_value = $(this).attr("v_E18_value");
				
				//alert("offer_name = "+offer_name+"\n"+"U_v_B17_value = "+U_v_B17_value+"\n"+"U_v_E18_value = "+U_v_E18_value+"\n"+"U_v_H19_value = "+U_v_H19_value+"\n");
				
				var D_i = 0;//选择了几个
				//找整个列表选择的单选框
				$("#offer_table tr:gt(0)").each(function(){
					var D_v_B17_value = $(this).attr("v_B17_value");
					if(U_v_B17_value==D_v_B17_value){
						if($(this).find("input[type='radio']:checked").size()>0){
							D_i ++;
						}
					}
				});				
				
				//alert("D_i = "+D_i+"\nU_v_E18_value = "+U_v_E18_value);
				if(D_i!=parseInt(U_v_E18_value)){
					//alert(1);
					//rdShowMessageDialog(U_v_H19_value);
					//t_flag = true;
					//return false;
				}
			}
			
			
	});
	
	if(t_flag){
		return;
	}
	
	
	/*
	var is_check_inPrePayFee = $("#btn_check_OfferSum").is(":disabled");
	if(!is_check_inPrePayFee&& "<%=j_offer_flag%>"=="Y"){
		rdShowMessageDialog("请先校验预存");
		return;
	}
	*/
	
	var j_FX_FEE = "";

	
	if("D014"=="<%=j_GearCode%>"){
		j_FX_FEE = "238";
	}
	if("D013"=="<%=j_GearCode%>"){
		j_FX_FEE = "158";
	}
	if("D012"=="<%=j_GearCode%>"){
		j_FX_FEE = "138";
	}	
	if("D011"=="<%=j_GearCode%>"){
		j_FX_FEE = "88";
	}
	if("D010"=="<%=j_GearCode%>"){
		j_FX_FEE = "58";
	}
	if("D021"=="<%=j_GearCode%>"){
		j_FX_FEE = "58";
	}
	
	
	if("D022"=="<%=j_GearCode%>"){
		j_FX_FEE = "68";
	}

	if("D023	"=="<%=j_GearCode%>"){
		j_FX_FEE = "58";
	}
	
	if("D024"=="<%=j_GearCode%>"){
		j_FX_FEE = "138";
	}
	
	
	if("D029"=="<%=j_GearCode%>"){
		j_FX_FEE = "38";
	}
	
	if("D030"=="<%=j_GearCode%>"){
		j_FX_FEE = "58";
	}
	
	if("D031"=="<%=j_GearCode%>"){
		j_FX_FEE = "88";
	}
	
	if("D040"=="<%=j_GearCode%>"){
		j_FX_FEE = "88";
	}
	
	if("D041"=="<%=j_GearCode%>"){
		j_FX_FEE = "38";
	}
	
	if("D042"=="<%=j_GearCode%>"){
		j_FX_FEE = "58";
	}
	
	if("D043"=="<%=j_GearCode%>"){
		j_FX_FEE = "88";
	}
	
	if("D044"=="<%=j_GearCode%>"){
		j_FX_FEE = "88";
	}
	
	if("D045"=="<%=j_GearCode%>"){
		j_FX_FEE = "38";
	}
	
	if("D046"=="<%=j_GearCode%>"){
		j_FX_FEE = "58";
	}
	
	if("D047"=="<%=j_GearCode%>"){
		j_FX_FEE = "88";
	}
	
	if("D048"=="<%=j_GearCode%>"){
		j_FX_FEE = "88";
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
        								"OP_NOTE":"家庭产品订购",//操作备注
        								"GROUP_ID":"<%=j_group_id%>",
        								"FX_FEE":j_FX_FEE,
        								"SP_TYPE":returnValue,
        								"DEPOSIT_FEE":DEPOSIT_FEE
											};


		//已添加角色，标志位为Y的拼一条记录
		var PAY_INFO_json      = [];
		var BASELINE_INFO_json = [];
		
		$("#old_mem_table tr:gt(0)").each(function(){
			if($(this).find("td:eq(5)").text().trim()=="Y"){//下标8的标志位
				var t_PAY_INFO_json = {
									"OPERATE_TYPE": "I",
	                "MASTER_PHONE": "<%=activePhone%>",
	                "MEMBER_PHONE": $(this).find("td:eq(0)").text().trim(),
	                "EFF_DATE":j_EFF_DATE,
	                "EXP_DATE": $(this).find("td:eq(4)").text().trim()
				};
				PAY_INFO_json.push(t_PAY_INFO_json);
			}
			
			if($(this).find("td:eq(6)").text().trim()=="Y"){//下标7的标志位
				var t_BASELINE_INFO_json = {
					 			"OPERATE_TYPE": "1",
                "HOME_PHONE": "<%=phoneNo_207%>",
                "MASTER_PHONE": "<%=activePhone%>",
                "MEMBER_PHONE": $(this).find("td:eq(0)").text().trim(),
                "GROUP_ID": "<%=j_group_id%>",
                "EFF_DATE": j_EFF_DATE,
                "EXP_DATE": $(this).find("td:eq(4)").text().trim()
									 
				};
				BASELINE_INFO_json.push(t_BASELINE_INFO_json);
			}
		});
		
		
		var ADD_OFFER_LIST_json  = [];
		var MAIN_OFFER_LIST_json = [];
    var SP_OFFER_LIST_json   = [];
    
    var LOGINOPR_json = [];
		
		var temp_json = {"PHONE_NO":"<%=activePhone%>"};
    LOGINOPR_json.push(temp_json);
    
    
		var sp_offer_flag=false;
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
				
		 
				
				//3种类型节点，需要判断
				if(t_v_CodeName=="ADD_OFFER_LIST"){
					var t_temp_json={
									"OPERATE_TYPE": "I",
	                "PHONE_NO": t_PHONE_NO,
	                "EFF_DATE": j_EFF_DATE,
	                "EXP_DATE": "20500101 00:00:00",
	                "OFFER_ID": $(this).attr("v_BPopedomCode")
					};
					
					ADD_OFFER_LIST_json.push(t_temp_json);
				}else if(t_v_CodeName=="MAIN_OFFER_LIST"){
					var t_temp_json={
	                "PHONE_NO": t_PHONE_NO,
	                "EFF_DATE": j_EFF_DATE,
	                "EXP_DATE": "20500101 00:00:00",
	                "OFFER_ID": $(this).attr("v_BPopedomCode")
					};
					if($(this).attr("v_CodeId")=="21098"){
						//alert($(this).attr("v_CodeId"));
						if("<%=j_ProdCode%>"=="JTFX"){
							go_showPrompt();
						}
					}
					
					MAIN_OFFER_LIST_json.push(t_temp_json);
				}else if(t_v_CodeName=="SP_OFFER_LIST"){
					var SPID=$("#sp_id").val().trim();
					var BIZCODE=$("#biz_code").val().trim();
					var STBID=$("#stb_id").val().trim();
					var CFM_LOGIN="";
					
					if("1"==J_count_result){
						SPID    = "";
						BIZCODE = "";
						STBID   = "";
    				}else{
    					if(!$("tr[name='mobaihegroup']").is(":hidden")){
							if(SPID==""){
								rdShowMessageDialog("请选择企业代码!");
								sp_offer_flag=true;
							}
							else if(BIZCODE==""){
								rdShowMessageDialog("请选择业务代码!");
								sp_offer_flag=true;
							}
							else if(STBID==""||STBID.length<15){
								rdShowMessageDialog("IMEI码不能为空,且位15位!");
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
		                "EFF_DATE": j_EFF_DATE,
		                "EXP_DATE": "20500101 00:00:00",
		                "SPID":SPID,//企业代码
		                "BIZCODE":BIZCODE,//业务代码
		                "STBID":STBID,//机顶盒ID
		                "CFM_LOGIN":CFM_LOGIN//宽带账号
					};					
					SP_OFFER_LIST_json.push(t_temp_json);
				}
				
				
			}
		});
		if(sp_offer_flag){
			return false;
		}
		
	 showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
	 if(!$("tr[name='mobaihegroup']").is(":hidden")){
 		sm358_show_Bill_Prt();
 	}
   if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
    
    
		var BUSI_INFO_json={};
		BUSI_INFO_json = {
					"ADD_OFFER_LIST":ADD_OFFER_LIST_json,
					"PAY_INFO":PAY_INFO_json,
      		"FAM_INS_INFO":{
						"OPERATE_TYPE": "U",//代表新增  U代表修改
						"GROUP_ID":"<%=j_group_id%>",//家庭群组
						"STATE":"2",//默认2
						"PROD_EFF_DATE": j_EFF_DATE,//产品生效时间 
						"PROD_EXP_DATE": "20500101 00:00:00"//产品失效时间
					},
					"LOGINOPR":LOGINOPR_json
					
		};
		
		
		
		if(MAIN_OFFER_LIST_json.length>0){
			BUSI_INFO_json["MAIN_OFFER_LIST"]=MAIN_OFFER_LIST_json;
		}
		
		if(SP_OFFER_LIST_json!=""){
			BUSI_INFO_json["SP_OFFER_LIST"]=SP_OFFER_LIST_json;
		}
		if(BASELINE_INFO_json.length>0){
			BUSI_INFO_json["BASELINE_INFO"]=BASELINE_INFO_json;
		}
		if("<%=j_offer_flag%>"=="Y"){
			var temp_j_EFF_DATE = "";
			if(j_EFF_DATE.length>8){
				temp_j_EFF_DATE = j_EFF_DATE.substring(0,8);
			}
			BUSI_INFO_json["SPECIAL_FUND_INFO"]={
		    "OPERATE_TYPE": "I",//I新增专款 U取消专款 D冲正专款
		    "SPECIAL_FUND_FEE": "<%=outMonthFee%>",//专款金额
		    "EFF_DATE":temp_j_EFF_DATE ,//专款开始时间
		    "EXP_DATE": "20500101",//专款结束时间
		    "SPECIAL_FUND_MONTHS":"<%=outMonthNum%>"
			};
		}
					
		var in_json_obj = {
												"OPR_INFO":OPR_INFO_json,
												"BUSI_INFO":BUSI_INFO_json
											};
											
		
		
	  //拼入参json
		in_JSONText = JSON.stringify(in_json_obj,function(key,value){return value;});
		
		var packet = new AJAXPacket("fm358_4.jsp","请稍后...");
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
var subFlag=false;

function go_stb_id(){
	if(!$("#jiaoyanButton").is(":disabled")){
		$("#jiaoyanButton").attr("disabled","disabled");
		$("#stb_id").attr("readonly","readonly");
		// readonly="readonly"
	}
	var packet = new AJAXPacket("fm358_6.jsp","请稍后...");
	packet.data.add("opCode","<%=opCode%>");// 
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


function set_EFF_DATE(){
	
	if($("#sel_outEffectType").val()=="0"){//立即生效
		j_EFF_DATE = "<%=currentDate%>";
	}else if($("#sel_outEffectType").val()=="2"){//预约生效
		j_EFF_DATE = "<%=n_month_Date%>";
	}
}
var J_count_result = "";
$(document).ready(function(){
	$("#sel_outEffectType").val("<%=outEffectType_id%>");
	set_EFF_DATE();
	$("tr[name='mobaihegroup']").hide();
	
	$("input[type='radio']").click(function (){
		
		
		if($(this).parent().parent().find("td:eq(0)").text().trim()=="魔百和"){
			go_check_DDSMPORDERMSG();
		}
		
	})
	

//找到出参13位为N的隐藏这行默认选中	
$("#offer_table input[type='radio'][v_is_show='N']").each(function(){
	$(this).attr("checked","checked");
	$(this).parent().parent().hide();
});
	
	
	var hit_tr_array = new Array();
	$("#offer_table tr:gt(0):visible").each(function(){
			var U_v_H19_value = $(this).attr("v_H19_value");
			var U_v_B17_value = $(this).attr("v_B17_value");
			
			if(U_v_B17_value!="SS"&&U_v_B17_value!=""){
				if(!re_check_arr(hit_tr_array,U_v_H19_value)){//校验在数组里是否已经存在
					hit_tr_array.push(U_v_H19_value);
				}
			}
	});
	
	/*
	var tr_hit_html = "<tr><td colspan='4' align='left'><b>温馨提示：<br>";
	for(var i=0;i<hit_tr_array.length;i++){
		tr_hit_html += hit_tr_array[i]+"<br>";
	}
	tr_hit_html += "</b></td></tr>"
	$("#offer_table_hit").append(tr_hit_html);
	*/
	
});

function re_check_arr(arr,val){
	var ret_B = false;
	for(var i=0;i<arr.length;i++){
		if(arr[i]==val){
			ret_B = true;
			break;
		}
	}
	return ret_B;
}
function go_check_DDSMPORDERMSG(){
		var packet = new AJAXPacket("fm358_5.jsp","请稍后...");
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
    	}else if("<%=j_ProdCode%>"=="JTHX"){
    		return printInfo_JTHX();
    	}else if("<%=j_ProdCode%>"=="JTFX"){
    		if("D025"=="<%=j_GearCode%>"||"D026"=="<%=j_GearCode%>"||"D027"=="<%=j_GearCode%>"){
    			return printInfo_JTFX_D();
    		}else if("D028"=="<%=j_GearCode%>"){
    			return printInfo_JTFX_D028();
    		}else{
    			return printInfo_JTFX();
    		}
    	}else if("<%=j_ProdCode%>"=="JTHB"){
    	
    		return printInfo_JTHB();
    	}else if("<%=j_ProdCode%>"=="JTHA"){
    	
    		return printInfo_JTHA();
    	}else if("<%=j_ProdCode%>"=="JTHC"){
    	
    		return printInfo_JTHC();
    	}else if("<%=j_ProdCode%>"=="JTCN"){
    	
    		return printInfo_JTCN();
    	}
    	
    	
    }

        
    function printInfo_JTCN(printType){
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
      						
      opr_info += "办理业务名称：家庭C计划    操作流水: "+"<%=sysAcceptl%>" +"|";
      
      note_info1 += "资费描述："+"|";
	 



     
      if("<%=j_GearCode%>"=="D049"||
      	"<%=j_GearCode%>"=="D050"||
      	"<%=j_GearCode%>"=="D051"||
      	"<%=j_GearCode%>"=="D052"
      	){
      	
      	 note_info1 += "您已订购中国移动家庭C计划套餐普通宽带包。套餐生效期间，";
      }else if(
      	"<%=j_GearCode%>"=="D053"||
      	"<%=j_GearCode%>"=="D054"||
      	"<%=j_GearCode%>"=="D055"||
      	"<%=j_GearCode%>"=="D056"
      	){
      	
      	 note_info1 += "您已订购中国移动家庭C计划套餐幸福家庭包。套餐生效期间，";
      }else if(
      	"<%=j_GearCode%>"=="D057"||
      	"<%=j_GearCode%>"=="D058"||
      	"<%=j_GearCode%>"=="D059"||
      	"<%=j_GearCode%>"=="D060"
      	){
      	
      	 note_info1 += "您已订购中国移动家庭C计划套餐豪华家庭包。套餐生效期间，";
      }else{
      	
      	note_info1 += "您已订购中国移动家庭C计划套餐，";
      }
 
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//所有选中的单选框
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"；";
					}
				}
			});      
			
			var fanhuanjuntan = "0";

			note_info1 += temp_note_info1;
			
			var suojiaonaStr="";
			if("D029"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款360元，";
			}
			else if("D030"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款240元，";
			}
			else if("D031"=="<%=j_GearCode%>"){
				
				suojiaonaStr="所缴纳预存款0元";
				fanhuanjuntan = "1";
				
				$("#offer_table").find("input[type='radio']").each(function(){
					if($(this).is(":checked")){//所有选中的单选框
						var t_v_BPopedomCode = $(this).attr("v_BPopedomCode");
						
						if(
							"51508"==t_v_BPopedomCode||
							"51509"==t_v_BPopedomCode||
							"51510"==t_v_BPopedomCode||
							"51511"==t_v_BPopedomCode||
							"51512"==t_v_BPopedomCode||
							"51513"==t_v_BPopedomCode||
							"51514"==t_v_BPopedomCode||
							"51515"==t_v_BPopedomCode||
							"51516"==t_v_BPopedomCode||
							"51517"==t_v_BPopedomCode||
							"51518"==t_v_BPopedomCode||
							"51519"==t_v_BPopedomCode||
							"51520"==t_v_BPopedomCode
						){
							suojiaonaStr="所缴纳预存款0元";
							fanhuanjuntan = "1";
						}
					}
				});   
				
			}else if("D040"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款0元";
				fanhuanjuntan = "1";
			}else if("D041"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款360元，";
			}else if("D042"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款240元，";
			}else if("D043"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款0元";
				fanhuanjuntan = "1";
			}else if("D044"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款0元";
				fanhuanjuntan = "1";
			}else if("D045"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款360元，";
			}else if("D046"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款240元，";
			}else if("D047"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款0元";
				fanhuanjuntan = "1";
			}else if("D048"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款0元";
				fanhuanjuntan = "1";
			}
			
			if("D049"=="<%=j_GearCode%>"||"D053"=="<%=j_GearCode%>"||"D057"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款360元，";
			}
			
			if("D050"=="<%=j_GearCode%>"||"D054"=="<%=j_GearCode%>"||"D058"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款240元，";
			}
			
			if("D051"=="<%=j_GearCode%>"||"D055"=="<%=j_GearCode%>"||"D059"=="<%=j_GearCode%>"||"D052"=="<%=j_GearCode%>"||"D056"=="<%=j_GearCode%>"||"D060"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款0元";
				fanhuanjuntan = "1";
			}

			
			
			if("1"!=fanhuanjuntan){
				note_info1 += "宽带实际可用时间以宽带安装调测成功为准。"+suojiaonaStr+"一年内按月均摊返还，返还时间为每月初。"+"|";
    	}else{
				note_info1 += "宽带实际可用时间以宽带安装调测成功为准。"+suojiaonaStr+"|";
    		
    	}
		
		
			 
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){
					
					var offer_id_temp = $(this).attr("v_BPopedomCode");
					var j_EFF_DATE_fl = "<%=outEffectType_id%>";
					var j_EFF_DATE_de = "";
					
					
							if(j_EFF_DATE_fl=="0"){//立即生效
									j_EFF_DATE_de = "套餐24小时内生效";
							}else if(j_EFF_DATE_fl=="2"){//预约生效
									j_EFF_DATE_de = "套餐下月1日生效";
							}
							
						if("57572"==offer_id_temp){
							note_info1 += "您已成功办理10元共享功能包，"+j_EFF_DATE_de+"。每月成员可共享您套餐内的流量，可享受家庭共享省内移动数据流量500兆，成员间本地通话互打优惠500分钟（允许增加不超过4名家庭成员，2名以上每增加一名收10元功能费）。"+"|";
						}
						
						if("52837"==offer_id_temp){
							note_info1 += "您已成功办理IMS固话业务，月租10元/月，（含200分钟市话）市话0.1元/分钟，长途0.15元/分钟,与家庭成员间互打免费。"+"|";
						}
					 
				}
			});  	
			

		  note_info1 += "|";
		  
		  
      note_info2 += "备注：|";
      
      note_info2 += "1、办理家庭C计划后一年内不允许取消套餐。|";
      note_info2 += "2、如手机号码状态异常则同时关停宽带上网功能，状态恢复同时开启宽带上网功能。|";
      note_info2 += "3、如手机号码状态异常则家庭成员停止享受共享流量优惠和语音互打优惠，状态正常后恢复优惠。|";
      note_info2 += "4、家庭产品取消前，不可以办理预销，报停等业务。|";
      note_info2 += "5、家庭产品使用期间可根据需要升档办理其它档位套餐，新档位生效方式为预约生效。|";
      note_info2 += "6、新增家庭成员立即生效，删除家庭成员次月生效。|";
      note_info2 += "7、有效期一年，到期如无政策调整，自动续签。|";
      note_info2 += "8、用户申请办理解散且退还魔百和终端时，将收取剩余预存款30%作为违约金；用户申请办理解散且不退还魔百和终端时，将收取剩余预存款100%作为违约金。|";


      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
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
					var j_EFF_DATE_fl = "<%=outEffectType_id%>";
					var j_EFF_DATE_de = "";
					
						if(j_EFF_DATE_fl=="0"){//立即生效
								j_EFF_DATE_de = "套餐24小时内生效";
						}else if(j_EFF_DATE_fl=="2"){//预约生效
								j_EFF_DATE_de = "套餐下月1日生效";
						}
							
						if("57572"==offer_id_temp){
							note_info1 += "您已成功办理10元共享功能包，"+j_EFF_DATE_de+"。每月成员可共享您套餐内的流量，可享受家庭共享省内移动数据流量500兆，成员间本地通话互打优惠500分钟（允许增加不超过4名家庭成员，2名以上每增加一名收10元功能费）。"+"|";
						}
						
						if("52837"==offer_id_temp){
							note_info1 += "您已成功办理IMS固话业务，月租10元/月，（含200分钟市话）市话0.1元/分钟，长途0.15元/分钟,与家庭成员间互打免费。"+"|";
						}
						
						if("57570"==offer_id_temp){
							note_info1 += "您已成功办理10元1G省内流量加油包，"+j_EFF_DATE_de+"，当月可最多叠加办理10次。 "+"|";
						}
					 
				}
			});  	
			

		  note_info1 += "|";
		  
		  
      note_info2 += "备注：|";

      note_info2 += "1、如手机号码状态异常则家庭成员停止享受共享流量优惠和语音互打优惠，状态正常后恢复优惠。|";
      note_info2 += "2、家庭产品取消前，不可以办理预销，报停等业务。|";
      note_info2 += "3、已签约家庭A套餐的客户，如想降档办理主资费，需解散家庭。|";
      note_info2 += "4、新增家庭成员立即生效，删除家庭成员次月生效。|";
      note_info2 += "5、10元1G省内加油包当月内办理次数不超过10次。|";
      note_info2 += "6、有效期一年，到期如无政策调整，自动续签。|";

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
	 



     
      if("<%=j_GearCode%>"=="D029"||
      	"<%=j_GearCode%>"=="D030"||
      	"<%=j_GearCode%>"=="D031"||
      	"<%=j_GearCode%>"=="D040"
      	){
      	
      	 note_info1 += "您已订购中国移动家庭B计划套餐普通宽带包。套餐生效期间，";
      }else if(
      	"<%=j_GearCode%>"=="D041"||
      	"<%=j_GearCode%>"=="D042"||
      	"<%=j_GearCode%>"=="D043"||
      	"<%=j_GearCode%>"=="D044"
      	){
      	
      	 note_info1 += "您已订购中国移动家庭B计划套餐幸福家庭包。套餐生效期间，";
      }else if(
      	"<%=j_GearCode%>"=="D045"||
      	"<%=j_GearCode%>"=="D046"||
      	"<%=j_GearCode%>"=="D047"||
      	"<%=j_GearCode%>"=="D048"
      	){
      	
      	 note_info1 += "您已订购中国移动家庭B计划套餐豪华家庭包。套餐生效期间，";
      }else{
      	
      	note_info1 += "您已订购中国移动家庭B计划套餐普，";
      }
 
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//所有选中的单选框
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"；";
					}
				}
			});      
			
			var fanhuanjuntan = "0";

			note_info1 += temp_note_info1;
			
			var suojiaonaStr="";
			if("D029"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款360元，";
			}
			else if("D030"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款240元，";
			}
			else if("D031"=="<%=j_GearCode%>"){
				
				suojiaonaStr="所缴纳预存款0元";
				fanhuanjuntan = "1";
				
				$("#offer_table").find("input[type='radio']").each(function(){
					if($(this).is(":checked")){//所有选中的单选框
						var t_v_BPopedomCode = $(this).attr("v_BPopedomCode");
						
						if(
							"51508"==t_v_BPopedomCode||
							"51509"==t_v_BPopedomCode||
							"51510"==t_v_BPopedomCode||
							"51511"==t_v_BPopedomCode||
							"51512"==t_v_BPopedomCode||
							"51513"==t_v_BPopedomCode||
							"51514"==t_v_BPopedomCode||
							"51515"==t_v_BPopedomCode||
							"51516"==t_v_BPopedomCode||
							"51517"==t_v_BPopedomCode||
							"51518"==t_v_BPopedomCode||
							"51519"==t_v_BPopedomCode||
							"51520"==t_v_BPopedomCode
						){
							suojiaonaStr="所缴纳预存款0元";
							fanhuanjuntan = "1";
						}
					}
				});   
				
			}else if("D040"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款0元";
				fanhuanjuntan = "1";
			}else if("D041"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款360元，";
			}else if("D042"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款240元，";
			}else if("D043"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款0元";
				fanhuanjuntan = "1";
			}else if("D044"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款0元";
				fanhuanjuntan = "1";
			}else if("D045"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款360元，";
			}else if("D046"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款240元，";
			}else if("D047"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款0元";
				fanhuanjuntan = "1";
			}else if("D048"=="<%=j_GearCode%>"){
				suojiaonaStr="所缴纳预存款0元";
				fanhuanjuntan = "1";
			}
			
			
			if("1"!=fanhuanjuntan){
				note_info1 += "如选择魔百和业务，套餐生效期间，宽带和魔百和实际可用时间以宽带安装调测成功为准。"+suojiaonaStr+"一年内按月均摊返还，返还时间为每月初。"+"|";
    	}else{
				note_info1 += "如选择魔百和业务，套餐生效期间，宽带和魔百和实际可用时间以宽带安装调测成功为准。"+suojiaonaStr+"|";
    		
    	}
		
		
			 
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){
					
					var offer_id_temp = $(this).attr("v_BPopedomCode");
					var j_EFF_DATE_fl = "<%=outEffectType_id%>";
					var j_EFF_DATE_de = "";
					
					
							if(j_EFF_DATE_fl=="0"){//立即生效
									j_EFF_DATE_de = "套餐24小时内生效";
							}else if(j_EFF_DATE_fl=="2"){//预约生效
									j_EFF_DATE_de = "套餐下月1日生效";
							}
							
						if("57572"==offer_id_temp){
							note_info1 += "您已成功办理10元共享功能包，"+j_EFF_DATE_de+"。每月成员可共享您套餐内的流量，可享受家庭共享省内移动数据流量500兆，成员间本地通话互打优惠500分钟（允许增加不超过4名家庭成员，2名以上每增加一名收10元功能费）。"+"|";
						}
						
						if("52837"==offer_id_temp){
							note_info1 += "您已成功办理IMS固话业务，月租10元/月，（含200分钟市话）市话0.1元/分钟，长途0.15元/分钟,与家庭成员间互打免费。"+"|";
						}
					 
				}
			});  	
			

		  note_info1 += "|";
		  
		  
      note_info2 += "备注：|";
      
      note_info2 += "1、办理家庭B计划后一年内不允许取消套餐。|";
      note_info2 += "2、如手机号码状态异常则同时关停宽带上网功能，状态恢复同时开启宽带上网功能。|";
      note_info2 += "3、如手机号码状态异常则家庭成员停止享受共享流量优惠和语音互打优惠，状态正常后恢复优惠。|";
      note_info2 += "4、家庭产品取消前，不可以办理预销，报停等业务。|";
      note_info2 += "5、家庭产品使用期间可根据需要升档办理其它档位套餐，新档位生效方式为预约生效。|";
      note_info2 += "6、新增家庭成员立即生效，删除家庭成员次月生效。|";
      note_info2 += "7、有效期一年，到期如无政策调整，自动续签。|";
      note_info2 += "8、用户申请办理解散且退还魔百和终端时，将收取剩余预存款30%作为违约金；用户申请办理解散且不退还魔百和终端时，将收取剩余预存款100%作为违约金。|";


      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }

    
    function printInfo_JTFX_D028(printType){
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
      						
      
      opr_info += "办理业务名称：美丽乡村融合套餐    操作流水: "+"<%=sysAcceptl%>" +"|";
      
      note_info1 += "资费描述："+"|";
      note_info1 += "您已订购中国移动美丽乡村融合套餐，";
 
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
			
			
			note_info1 += "如选择魔百和业务，套餐生效期间，宽带和魔百和实际可用时间以宽带安装调测成功为准。所缴纳预存款120元，一年内按月均摊返还，返还时间为每月初。 "+"|";
      
		 
      note_info2 += "备注：|";
      

      note_info2 += "1、资费办理区域仅限黑龙江移动公司宽带资源覆盖区域。|";
      note_info2 += "2、用户承诺办理的中国移动美丽乡村融合套餐生效期间，不允许办理宽带预销、报停等终止使用类业务；如手机欠费（含其他异常）则宽带暂停，手机状态恢复正常后则开启上网功能；|";
      note_info2 += "3、套餐生效期间，因用户原因或用户住址外部环境原因导致不具备安装条件，如产生套餐费用由用户自行承担。|";
      note_info2 += "4、用户办理18元及以上指定主资费，缴纳预存款120元，可以办理美丽乡村融合套餐。|";
      note_info2 += "5、当前生效18元及以上指定主资费用户，办理美丽乡村融合宽带24小时内生效。|";
      note_info2 += "6、预约生效18元及以上指定主资费用户办理美丽乡村融合套餐，美丽乡村融合宽带预约生效。|";
      note_info2 += "7、只有美丽乡村融合套餐预约失效的用户才可以做主资费冲正。|";
      note_info2 += "8、套餐有效期为一年，如政策无调整自动续签。|";
      note_info2 += "9、只有美丽乡村专享套餐预约失效的用户才可以做主资费预约取消，预约内容全部取消，当月为0元宽带资费，次月转为标准资费。|";
      note_info2 += "10、自美丽乡村专享套餐生效12个月以内，用户如需变更套餐内的4G和宽带资费，仅能升档办理，即原套餐内生效资费仅能变更为价格更高的资费档位。|";
      note_info2 += "11、用户申请办理解散且退还魔百和终端时，将收取剩余预存款30%作为违约金；用户申请办理解散且不退还魔百和终端时，将收取剩余预存款100%作为违约金。|";
      if(printm358){
    	  note_info2 += "12、为保障您的权益，您原"+retResult2m358+"主资费包含的彩铃业务将为您免费保留一年，保留期间业务每月费用为"+retResult1m358+"元，系统每月赠送您"+retResult1m358+"元专款，相当于免费使用。该保留的彩铃业务随新主资费生效的日期开始起算，到期后如无变化此优惠将自动顺延一年，如有变化系统将提前1个月短信通知。|";
      }
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }


    
    function printInfo_JTFX_D(printType){
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
      						
      
      opr_info += "办理业务名称：和家乐享套餐    操作流水: "+"<%=sysAcceptl%>" +"|";
      opr_info += "家庭成员号码："+$("#phoneNumbers").val() +"|";
      
      note_info1 += "资费描述："+"|";
      note_info1 += "您已订购中国移动和家乐享套餐，套餐24小时内生效。";
 
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//所有选中的单选框
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"；";
					}
				}
			});      

		  var temp_preFee = "0.00";
		  
		  if("<%=outMonthFee%>".trim()!=""&&"<%=outMonthNum%>".trim()!=""){
		  	temp_preFee =  Number("<%=outMonthFee%>")*Number("<%=outMonthNum%>");
		  }
		  
			note_info1 += temp_note_info1;
			
			if("D025"=="<%=j_GearCode%>"){
				note_info1 += "套餐生效期间，宽带实际可用时间以宽带安装调测成功为准；";
			}else{
				note_info1 += "套餐生效期间，宽带和魔百和实际可用时间以宽带安装调测成功为准；";
			}
			
			note_info1 += "所缴纳预存款"+temp_preFee+"元，一年内按月均摊返还，返还时间为每月初。"+"|";
      
		 
      note_info2 += "备注：|";
      
      note_info2 += "1、资费办理区域仅限牡丹江移动公司宽带资源覆盖区域。|";
      note_info2 += "2、用户承诺办理的和家乐享套餐生效期间，不办理手机主资费变更，不办理宽带预销、报停等终止使用类业务；如手机欠费（含其他异常）则宽带暂停，手机状态恢复正常后则开启上网功能；办理业务一年内，用户承诺不办理家庭解散业务，如宽带已安装完毕，用户申请办理解散且退还魔百和终端时，将收取剩余预存款30%作为违约金；用户申请办理解散且不退还魔百和终端时，将收取剩余预存款100%作为违约金。|";
      note_info2 += "3、套餐生效期间，因用户原因或用户住址外部环境原因导致不具备安装条件，如产生套餐费用由用户自行承担。|";
      if(printm358){
    	  note_info2 += "4、为保障您的权益，您原"+retResult2m358+"主资费包含的彩铃业务将为您免费保留一年，保留期间业务每月费用为"+retResult1m358+"元，系统每月赠送您"+retResult1m358+"元专款，相当于免费使用。该保留的彩铃业务随新主资费生效的日期开始起算，到期后如无变化此优惠将自动顺延一年，如有变化系统将提前1个月短信通知。|";
      }


      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }


    
    function printInfo_JTFX(printType){
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
      						
      
      
      
      if("D022"=="<%=j_GearCode%>"){
      	opr_info += "办理业务名称：宽带伴侣卡    操作流水: "+"<%=sysAcceptl%>" +"|";
      }else{
      	opr_info += "办理业务名称：和家飞享套餐    操作流水: "+"<%=sysAcceptl%>" +"|";
      }
      
      opr_info += "家庭成员号码："+$("#phoneNumbers").val() +"|";


      
      note_info1 += "资费描述："+"|";
      if("D022"=="<%=j_GearCode%>"){
      	note_info1 += "您好，您已成功订购中国移动宽带伴侣卡套餐，24小时内生效。";
      }else{
	      if($("#sel_outEffectType").val()=="0"){//立即生效
						note_info1 += "您已订购中国移动和家飞享套餐，套餐24小时内生效。";
				}else if($("#sel_outEffectType").val()=="2"){//预约生效
						note_info1 += "您已订购中国移动和家飞享套餐，套餐次月1日生效。";
				}
			}
			note_info1 += "套餐月使用费"+$("#span_OfferSum").text().trim()+"元";
			
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){
					var offer_id_temp = $(this).attr("v_BPopedomCode");
					
						if("52963"==offer_id_temp){
							note_info1 += "，7折优惠，";
						}
						
						if("52964"==offer_id_temp){
							note_info1 += "，8折优惠，";
						}
						
						if("52965"==offer_id_temp){
							note_info1 += "，9折优惠，";
						}
						
				}
			});  	
			note_info1 += "套餐包含";
			
			
			var temp_note_info_53341 = "";
			var temp_note_info_52839 = "";
			var temp_note_info_52837 = "";
			var temp_note_info_55090 = "";
			
			
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//所有选中的单选框
					
					var offer_id_temp = $(this).attr("v_BPopedomCode");
					
					if("53341"==offer_id_temp){
						temp_note_info_53341 = "您已成功办理10元共享功能包，套餐24小时内生效。每月可享受家庭成员间本地通话互打免费，共享主卡套餐内流量；允许新增2名家庭成员，用户如需再新增成员，每加1人收取10元/月，家庭内共享人数不能超过5人（含主卡）；优先使用家庭成员自身流量，再使用家庭套餐内共享流量。如主卡状态异常则家庭成员停止享受共享流量优惠和语音互打优惠，状态正常后恢复优惠；新增家庭成员立即生效，删除家庭成员次月生效。 |";
					}
					
					if("52839"==offer_id_temp){
						temp_note_info_52839 = "您已成功办理10元1G省内流量包，套餐24小时内生效，当月可最多叠加办理10次。|";
					}

					if("52837"==offer_id_temp){
						temp_note_info_52837 = "您已成功办理IMS固话业务，月租10元/月，（含200分钟市话）市话0.1元/分钟，长途0.15元/分钟,家庭成员间本地互打免费。|";
					}
					
					if("55090"==offer_id_temp){
						temp_note_info_55090 = "您已成功办理10元1G省内流量包，如您本月新办理和家飞享套餐，流量包与套餐生效时间相同；如您已办理和家飞享套餐，流量包将在24小时内生效；如您使用期间无退订要求，流量包下月自动续订。|";
					}


					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"；";
					}
				}
			});      

			
			note_info1 += temp_note_info1;
			
			if("D022"=="<%=j_GearCode%>"){
			  var phoneNo1 = "";
      	var phoneNo2 = "";
      	
      	$("#old_mem_table tr:gt(0)").each(function(){
						var e_role_code = $(this).find("td:eq(1)").text().trim();
						if("21096"==e_role_code){
							phoneNo2 = $(this).find("td:eq(0)").text().trim();
						}
						if("21098"==e_role_code){
							phoneNo1 = $(this).find("td:eq(0)").text().trim();
						}
				});
				
      	note_info1 += "本机号码"+phoneNo1+"为主卡，副卡手机号码"+phoneNo2;
      	note_info1 += "主卡含0元来电显示，国内主叫国内0.19元/分钟，国内被叫免费（国内范围均不包含港澳台地区）。包含100M省内流量，超出部分或国内流量按照标准资费收取。注：套餐生效后每月赠送5GB省内咪咕视频定向流量；同时自动开通3元1GB省内流量日租包，每天省内流量不足5M不收费，超出5M后收取套餐使用费3元，并可免费使用省内流量至1GB，流量当天有效，不结转； 套餐有效期为一年，如政策无调整自动续签。";
      }else{
	      note_info1 += "超出套餐时，资费标准为：国内主叫0.19元/分钟，国内移动数据流量0.29元/M；其他按照标准资费收取，以上国内均不含港澳台地区。套餐生效期间，宽带和魔百和实际可用时间以宽带安装调测成功为准；所缴纳预存款240元，两年内按月均摊返还。返还时间为每月初。 ";			
				note_info1 += "||";
    	}

			note_info1 +=  "|"+temp_note_info_53341+temp_note_info_52839+temp_note_info_52837+temp_note_info_55090;
      note_info2 += "备注：|";
      


      note_info2 += "1、资费办理区域仅限黑龙江移动公司宽带资源覆盖区域。|";
		note_info2 += "2、用户承诺办理的和家飞享套餐生效期间，不办理预销，报停等终止使用类业务；如手机欠费（含其他异常）则宽带暂停，手机状态恢复正常后则开启上网功能；办理业务两年内，用户承诺不办理家庭解散业务，如宽带已安装完毕，用户申请办理解散且退还魔百和终端时，将收取剩余预存款30%作为违约金；用户申请办理解散且不退还魔百和终端时，将收取剩余预存款100%作为违约金。|";
		note_info2 += "3、套餐生效期间，因用户原因或用户住址外部环境原因导致不具备安装条件，如产生套餐费用由用户自行承担。|";
		note_info2 += "4、套餐使用期间可根据需要，订购变更其他档位套餐，新档位生效方式为预约生效。|";
		note_info2 += "5、家庭套餐合约期为24个月，到期后无政策调整自动顺延原套餐。 |";
		if(printm358){
			note_info2 += "6、为保障您的权益，您原"+retResult2m358+"主资费包含的彩铃业务将为您免费保留一年，保留期间业务每月费用为"+retResult1m358+"元，系统每月赠送您"+retResult1m358+"元专款，相当于免费使用。该保留的彩铃业务随新主资费生效的日期开始起算，到期后如无变化此优惠将自动顺延一年，如有变化系统将提前1个月短信通知。|";
      	}

      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }

    
 function printInfo_JTHX(printType){
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
      						
      opr_info += "办理业务名称：和家惠享保底消费    操作流水: "+"<%=sysAcceptl%>" +"|";
      
      opr_info += "家庭成员号码："+$("#phoneNumbers").val() +"|";
			var is_mbh_flag = "";//是否含魔百和
			var hj_xf_count = 0;//家庭合计月底线消费
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
			
			var temp_note_info1 = "";
			var temp_note_info_52837 = "";
			
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//所有选中的单选框
					
					var offer_id_temp = $(this).attr("v_BPopedomCode");
					
					if("52837"==offer_id_temp){
						temp_note_info_52837 = "|您已成功办理IMS固话业务，月租10元/月，（含200分钟市话）市话0.1元/分钟，长途0.15元/分钟,家庭成员间本地互打免费。|";
					}
					
										
					if("魔百和"==$(this).attr("v_ClssName")){
						is_mbh_flag = "魔百和互联网电视业务。";//区别为一句话
					}
					
					hj_xf_count = hj_xf_count + parseInt($(this).attr("v_OfferSum"));
					
					
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"，";
					}
					
				}
			});      
			
			note_info1 += "资费描述："+"|";
			note_info1 += "和家惠享保底消费优惠，";
			if(m_num_count != 0){
				note_info1 += "家庭成员数量为"+m_num_count+"人，"+
										"成员手机号码分别为"+m_phone_no+"。";
			}
			
			if("D070"=="<%=j_GearCode%>"){
      	note_info1 +=temp_note_info1+
										"如月家庭成员合计消费不足"+hj_xf_count+"元，差额部分将从户主<%=activePhone%>账户中扣除。";
      }else{
      	note_info1 +=temp_note_info1+
										"如月家庭成员合计消费不足"+hj_xf_count+"元，差额部分将从户主<%=activePhone%>账户中扣除。所缴纳预存款240元，两年内按月均摊返还，返还时间为每月初";

      }
      note_info1 += "|";
      
      
      note_info1 +=  temp_note_info_52837;


      note_info2 += "备注：|";
      
      note_info2 += "1、资费办理区域仅限黑龙江移动公司宽带资源覆盖区域。|";
			note_info2 += "2、用户承诺办理的和家惠享套餐生效期间，不办理预销，报停等终止使用类业务；如手机欠费（含其他异常）则宽带暂停，手机状态恢复正常后则开启上网功能；办理业务两年内，用户承诺不办理家庭解散业务，如宽带已安装完毕，用户申请办理解散且退还魔百和终端时，将收取剩余预存款30%作为违约金；用户申请办理解散且不退还魔百和终端时，将收取剩余预存款100%作为违约金。|";
			note_info2 += "3、套餐生效期间，因用户原因或用户住址外部环境原因导致不具备安装条件，如产生套餐费用由用户自行承担； |";
			note_info2 += "4、套餐使用期间可根据需要，订购变更其他档位套餐，新档位生效方式为预约生效。|";
			note_info2 += "5、套餐生效期间，优先使用家庭成员自身流量，再使用家庭套餐内共享流量。如主卡状态异常则家庭成员停止享受共享流量优惠和语音互打优惠，状态正常后恢复优惠；新增家庭成员立即生效，删除家庭成员次月生效|";

			note_info2 += "|";
			note_info2 += "家庭套餐合约期为24个月，到期后无政策调整自动顺延原套餐。 |";
			
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
      						
      opr_info += "办理业务名称：和家庭悦享套餐    操作流水: "+"<%=sysAcceptl%>" +"|";
      
      opr_info += "家庭成员号码："+$("#phoneNumbers").val() +"|";
      
      
      note_info1 += "资费描述："+"|";
      
      
      
      if($("#sel_outEffectType").val()=="0"){//立即生效
					note_info1 += "您订购的中国移动和家庭悦享套餐，24小时内生效。";
			}else if($("#sel_outEffectType").val()=="2"){//预约生效
					note_info1 += "您订购的中国移动和家庭悦享套餐，次月1日生效。";
			}
			note_info1 += "月使用费"+$("#span_OfferSum").text().trim()+"元";
			note_info1 += "（含";
			
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//所有选中的单选框
					
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"，";
					}
				}
			});      
			
			note_info1 += temp_note_info1;
      note_info1 += "宽带安装首月按实际使用天数收费）；套餐外国内移动数据流量0.29元/M，省内长市漫合一主叫语音0.1元/分钟，省内接听免费，省外国内主叫国内双向收费0.3元/分钟（不含港澳台）。允许增加不超过6名家庭成员，3名以上每增加一名收5元功能费；其他按照标准资费收取。";			
			note_info1 += "||";
      
      
      note_info2 += "备注：|";
      
      note_info2 += "1、如手机号码与宽带均为新入网，则套餐立即生效，宽带竣工后生效。|";
      note_info2 += "2、如手机号码新入网，宽带在网，则套餐立即生效，宽带已使用的天数按原包月计费规则扣费，剩余天数按套餐包月规则计费。|";
      note_info2 += "3、如手机号码在网，宽带新入网，则套餐次月生效，宽带竣工后生效。|";
      note_info2 += "4、如手机号码、宽带均在网，则套餐次月生效。|";
      note_info2 += "5、办理和家庭悦享套餐后半年内，宽带已竣工，如需取消套餐，需收取套餐剩余预存专款的30%作为违约金，宽带转为普通标准包月资费。|";
      note_info2 += "6、如手机号码状态异常则同时关停宽带上网功能，状态恢复同时开启宽带上网功能。|";
      note_info2 += "7、如手机号码状态异常则家庭成员停止享受共享语音及流量优惠，状态正常后恢复优惠。|";
      note_info2 += "8、套餐取消前，不可以办理预销，报停等业务。|";
      note_info2 += "9、如因非客户原因导致宽带无法安装，如手机号码资费已生效则需办理家庭解散，手机号码变更为指定资费，宽带可办理撤单，新资费次月生效，当月仍按去除宽带月费后的费用扣费。如手机号码资费未生效则需办理冲正。次月可按客户要求将多余预存款以现金形式返还。|";
      note_info2 += "10、可在套餐生效当月内订购魔百和互联网电视包月业务。|";
      note_info2 += "11、套餐使用期间可根据需要，订购其他档位流量及语音可选包。|";
      note_info2 += "12、新增家庭成员立即生效，删除家庭成员次月生效。|";
      note_info2 += "13、优先使用家庭成员间互打通话时长及家庭共享语音、流量，再使用家庭成员自身语音及流量。|";
      note_info2 += "14、魔百和订购一年内不允许单独办理退订。|";

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
      opr_info += "家庭成员号码："+$("#phoneNumbers").val() +"|";
      
			var is_mbh_flag = "";//是否含魔百和
			var hj_xf_count = 0;//家庭合计月底线消费
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
			
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//所有选中的单选框
					if("魔百和"==$(this).attr("v_ClssName")){
						is_mbh_flag = "魔百和互联网电视业务。";//区别为一句话
					}
					
					hj_xf_count = hj_xf_count + parseInt($(this).attr("v_OfferSum"));
					
					
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"，";
					}
					
				}
			});      
			
			note_info1 += "资费描述："+"|";
			note_info1 += "家庭保底消费优惠，家庭成员数量为"+m_num_count+"人，"+
										"成员手机号码分别为"+m_phone_no+"。"+temp_note_info1+
										"如月家庭成员合计消费不足"+hj_xf_count+"元，未使用的话费将从户主<%=activePhone%>账户扣除";
      note_info1 += "|";

      note_info1 += "备注："+"|";
      note_info1 += "家庭保底消费产品订购后，从生效第一档家庭保底消费产品开始计算，一年之内不允许做家庭产品退订"+"|";


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

//打印发票
function sm358_show_Bill_Prt(){
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
			$(billArgsObj).attr("10006","家庭产品订购-魔百和押金");    //业务类别
			
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
var printm358=false;
var retResult1m358="";
var retResult2m358="";
function go_showPrompt(){
	var packet = new AJAXPacket("../s1270/ajax_showPrompt.jsp","请稍后...");
	packet.data.add("iOpCode","<%=opCode%>");
	packet.data.add("iPhoneNo","<%=activePhone%>");
	packet.data.add("iUserPwd","");
	packet.data.add("iOfferId","");
	core.ajax.sendPacket(packet,do_showPrompt);
	packet =null; 
}
function do_showPrompt(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retCode = packet.data.findValueByName("retCode"); 
	if(retCode =="000000"){
		retResult1m358 = packet.data.findValueByName("retResult1");
		retResult2m358 = packet.data.findValueByName("retResult2");
		if(retResult1m358!=""&&retResult2m358!=""){
			alert("为保障您的权益，您原"+retResult2m358+"主资费包含的彩铃业务将为您免费保留一年，保留期间业务每月费用为"+retResult1m358+"元，系统每月赠送您"+retResult1m358+"元专款，相当于免费使用。该保留的彩铃业务随新主资费生效的日期开始起算，到期后如无变化此优惠将自动顺延一年，如有变化系统将提前1个月短信通知。");
			printm358=true;
		}
		else{
			printm358=false;
		}
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
		<td>
			<%=j_group_id%>
		</td>
		<%if("JTHB".equals(j_ProdCode)){%>
			<td class="red" colspan="2">如是本省魔百和终端，系统自动签约0元/月。</td>
		<%}else{%>
			<td class="red" colspan="2"></td>
		<%}%>
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
String phoneNumbers="";
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
	phoneNumbers+=result_t3[i][0]+",";
	if(i%4==0&&i!=0){
		phoneNumbers+="|";
	}
}
%>
<input type="hidden" id="phoneNumbers" value="<%=phoneNumbers%>"/>
</table>


<div class="title"><div id="title_zi">资费列表</div></div>
<table cellSpacing="0"  id="offer_table">
	 <tr>
		<th width="15%">资费分类</th>
		<th colspan='2'>资费名称</th>
		<th width="7%">操作</th>
	</tr>
<%
String ja_ClssName = "";
if(result_t4.length>0){
	ja_ClssName = result_t4[0][10];
	out.print("<tr v_OfferFlag='"+result_t4[0][11]+"' v_H19_value='"+result_t4[0][19]+"' v_B17_value='"+result_t4[0][17]+"' v_E18_value='"+result_t4[0][18]+"' >");
	out.print("<td>"+result_t4[0][10]+"</td>");
	out.print("<td colspan='2'>");
}

for(int i=0;i<result_t4.length;i++){

if(ja_ClssName.equals(result_t4[i][10])){//一行
	
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
			onclick="add_OfferSum(this)"														
	 />
	
<a href="javascript:void(0)" onclick="show_offer_det('<%=result_t4[i][10]%>','<%=result_t4[i][6]%>','<%=result_t4[i][7]%>','<%=result_t4[i][8]%>')"><%=result_t4[i][6]%></a>

<%	
}else{
	out.print("</td>");
	out.print("<td><input type='button' value='取消' class='b_text' onclick='cen_radio_all(this)' ></td>");
	out.print("</tr>");
	out.print("<tr v_OfferFlag='"+result_t4[i][11]+"'   v_H19_value='"+result_t4[i][19]+"' v_B17_value='"+result_t4[i][17]+"' v_E18_value='"+result_t4[i][18]+"'  >");
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
						onclick="add_OfferSum(this)"														
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
</table>
<table  cellSpacing="0" >
 <tr name="mobaihegroup" style="display:none">
 	<td scope="col" >企业代码</td>
 	<td scope="col">
	 	<select id="sp_id" name="sp_id">
	 		<option value="">-请选择-</option>
	 		<option value="699213">未来电视</option>
	 		<option value="699212">百视通</option>
	 	</select>
 	</td>
 	<td scope="col"  >业务代码</td>
 	<td scope="col" >
 		<select id="biz_code" name="biz_code">
 			<!-- <option value="">-请选择-</option> -->
	 		<option value="20830000">20830000</option>
	 	</select>
 	</td>
 	
 	</tr>
 <tr name="mobaihegroup" style="display:none">
 	<td scope="col">IMEI码</td>
 	<!-- 003903FF00210070 -->
 	<td scope="col"><input type="text" id="stb_id" name="stb_id" size="40" value="" maxlength="32">
 	<input type="button" class='b_text' id="jiaoyanButton" value="校验" onclick="go_stb_id()"/>
 	</td>
 	<td scope="col" id="td_mobaihe1" style="display:none">魔百合押金</td>
 	<td  id="td_mobaihe2" style="display:none">
 		
 		<input type="text" id="mobaiheyajin" name="mobaiheyajin" maxlength="3"  readOnly="readOnly" class="InputGrey" value="0" v_must="0" v_type="money"  onblur = "checkElement(this)"  />
 	</td>
 	</tr>
 
</table>
<table  cellSpacing="0" id="offer_table_hit">
 
</table>



<table cellSpacing="0"  id="offer_table">
	<%
	//是Y就计算资费总额，N不计算 
	if("Y".equals(j_offer_flag)){
	%>
	<tr>
		<td class="blue" width="25%">套餐总额：</td>
		<td >
			<span id="span_OfferSum">0</span>
			&nbsp;&nbsp;&nbsp;
			<!--
			<input type="hieedn" value="校验预存" class="b_text" id="btn_check_OfferSum" onclick="go_check_OfferSum()" >
			-->
		</td>
	</tr>
	<%
	}
	%>
	<td class="blue" width="25%" style="display: none">生效方式：</td>
		<td style="display: none">
			<select id="sel_outEffectType" onchange="set_EFF_DATE()">
				<option value="">--请选择--</option>
				<% for(int i=0;i<result_t5.length;i++){
						System.out.println("-------hejwa----------result_t5--------------->"+result_t5[i][0]);
						System.out.println("-------hejwa----------result_t5--------------->"+result_t5[i][1]);
				
				%>
						<option value="<%=result_t5[i][0]%>"><%=result_t5[i][1]%></option>
				<%}%>
			</select>
		</td>
</table>

<%
if(
	 (
		"JTFX".equals(j_ProdCode)&&
		!"D022".equals(j_GearCode)&&
    !"D023".equals(j_GearCode)&&
    !"D024".equals(j_GearCode)&&
    !"D028".equals(j_GearCode)&&
    !"D025".equals(j_GearCode)
   )
   ||"JTHX".equals(j_ProdCode)){
 
%>
<table cellSpacing="0">
	 <tr>
	 	<td>
	 		<font class="orange">“魔百和”为必选业务，如用户已有魔百和功能，则默认为用户延续现有魔百和功能，次月开始魔百和免费。</font>
	 	</td>
	 </tr>
</table>
<%
}%>
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