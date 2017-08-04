<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.config.INIT_DATA"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ page import="com.sitech.boss.s5010.viewBean.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<jsp:useBean id="s5010" class="com.sitech.boss.s5010.viewBean.S5010Impl" />

<script type="text/javascript" src="../../js/common/common_util.js"></script>
<script type="text/javascript" src="../../js/common/common_single.js"></script>
<script type="text/javascript" src="../../js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="../../js/common/date/iOffice_Popup.js"></script>
<script type="text/javascript" src="../../js/rpc/src/core_c.js"></script>

<%
	    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	    String[][] baseInfoSession = (String[][])arrSession.get(0);
	    String[][] otherInfoSession = (String[][])arrSession.get(2);
	    String loginNo = baseInfoSession[0][2];
	    String loginName = baseInfoSession[0][3];
	    String powerCode= otherInfoSession[0][4];
	    String orgCode = baseInfoSession[0][16];
	    String ip_Addr = request.getRemoteAddr();
	    
	    String regionCode = orgCode.substring(0,2);
	    String regionName = otherInfoSession[0][5];
	    
	    String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];


		String login_accept=request.getParameter("login_accept");
		String totalCode = request.getParameter("detail_code");
		String typeButtonNum = request.getParameter("typeButtonNum");
		String region_code = request.getParameter("region_code");
	    
		//begin for debug.
		///String    loginNo = "aaaa88";
		///String    loginName = "test";
		///String    powerCode= "01";
		///String   orgCode = "010100101";
		///String   regionCode = "01";
		///String ip_Addr = "172.16.27.13";
		///String dept = "test dept ";
		///String regionName= "test regionName";
		//end for debug.
		
	int		LISTROWS=16;
			
	//进行工号权限检验
%>

<%
	List al = null;

	String[][] favourTypeData = new String[][] {};
	String[][] favCondTypeData = new String[][] {};
	String[][] typeModeFixData = new String[][]{};
	String[][] typeModeData = new String[][]{};
	String[][] cycleUnitData = new String[][] {};


	int		isGetDataFlag = 1;	//0:正确,其他错误. add by yl.
	String errorMsg ="";
	String tmpStr="";
	int ttt=0;
	
	StringBuffer  insql = new StringBuffer();

dataLabel:
	while(1==1){	
	//1.SQL 优惠方式
    insql.delete(0,insql.length());
    insql.append("select favour_type,favour_type||'-->'||trim(type_name) from sFavcondType order by favour_type asc");
	al = s5010.getCommONESQL(insql.toString(),2,0);
	if( al == null ){
		isGetDataFlag = 2;
		break dataLabel;
	}	
	favCondTypeData = (String[][])al.get(1);    

	//2.SQL 优惠方式
    insql.delete(0,insql.length());
    insql.append("select favour_type,favour_type||'-->'||trim(type_name) from sFavourType order by favour_type asc");
	al = s5010.getCommONESQL(insql.toString(),2,0);
	if( al == null ){
		isGetDataFlag = 3;
		break dataLabel;
	}	
	favourTypeData = (String[][])al.get(1);   
	
	//1.1 SQL 送费模式 ylylyl.
	if( favourTypeData.length >0 ){
		tmpStr= favourTypeData[0][0];
		//2.SQL 资费类别
		if( tmpStr.equals("1") ){//1：打折
			ttt=0;
		}else{
			insql.delete(0,insql.length());
			insql.append("select mode_type,mode_type||'-->'||trim(type_name) from sModeType ");
			insql.append(" order by mode_type ");
	
			al = s5010.getCommONESQL(insql.toString(),2,0);
			if( al == null ){
				isGetDataFlag = 4;
				break dataLabel;
			}
			typeModeData = (String[][])al.get(1);
		}
	}
	
	   
	//2.SQL 优惠周期
    insql.delete(0,insql.length());
    insql.append("select to_char(unit_type),unit_type||'-->'||trim(type_name) from sCycleUnit order by unit_type");
	al = s5010.getCommONESQL(insql.toString(),2,0);
		if( al == null ){
		isGetDataFlag = 5;
		break dataLabel;
	}
	cycleUnitData = (String[][])al.get(1);    
	       

	//3.取送费模式数据
	insql.delete(0,insql.length());
	insql.append("select mode_type,mode_type||'-->'||trim(type_name) from sModeType ");
	insql.append(" order by mode_type ");

	al = s5010.getCommONESQL(insql.toString(),2,0);
	if( al == null ){
		isGetDataFlag = 6;
		break dataLabel;
	}
	typeModeFixData = (String[][])al.get(1);

	isGetDataFlag = 0;
 break;
 }	


 errorMsg = "取数据错误:"+Integer.toString(isGetDataFlag);	    
 System.out.println(errorMsg);


 //获取已有的优惠信息
 	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	ArrayList retList = new ArrayList();
    String sqlStr="";
/*
    sqlStr = "select FAVOUR_CODE,trim(CODE_NAME),to_char(order_code), "+
					" trim(chat_types),trim(call_types),trim(roam_types), "+
					" trim(toll_types),trim(rate_codes),"+
					" trim(city_types),trim(data_types),"+
					" FAVCOND_TYPE,trim(fee_type),"+
					" favour_type,type_mode,"+
					" to_char(MULTI_CYCLE),to_char(cycle_unit),"+
					" to_char(step_val1),to_char(favoure1),"+
					" to_char(step_val2),to_char(favoure2),"+
					" to_char(step_val3),to_char(favoure3) "+
					" from tMidBillFavCfg "+
					" where login_accept=" + login_accept ;
*/
 sqlStr = "select trim(FAVOUR_CODE),trim(CODE_NAME),trim(to_char(order_code)), "+
					" trim(chat_types),trim(call_types),trim(roam_types), "+
					" trim(toll_types),trim(rate_codes),"+
					" trim(city_types),trim(data_types),"+
					" trim(FAVCOND_TYPE),trim(fee_type),"+
					" trim(favour_type),trim(type_mode),"+
					" trim(to_char(MULTI_CYCLE)),trim(to_char(cycle_unit)),"+
					" trim(to_char(step_val1)),trim(to_char(favoure1)),"+
					" trim(to_char(step_val2)),trim(to_char(favoure2)),"+
					" trim(to_char(step_val3)),trim(to_char(favoure3)) "+
					" from tMidBillFavCfg "+
					" where login_accept=" + login_accept ;

	retList = callView.sPubSelect("22",sqlStr);
    isGetDataFlag=callView.getErrCode();   
	errorMsg=callView.getErrMsg(); 
	
	String[][] result = (String[][])retList.get(0);
	String totalName="",orderCode="",chatType1="",callType1="",roamType1="",
	       tollType1="",rateCodes1="",cityTypes1="",
	       dataTypes1="",favCondType1="",feeType1="",
	       favourType1="",typeMode="",favourCycle="",cycleUnit="",
	       stepVal1="",favoure1="",stepVal2="",favoure2="",stepVal3="",favoure3="";

    if(result[0][0]==null || (result[0][0].equals("")) ) isGetDataFlag=0;
	if(result[0][0]!=null && !(result[0][0].equals("")) )
	{
	    //totalCode=result[0][0];
		totalName=result[0][1];
		orderCode=result[0][2];
		chatType1=result[0][3];
		callType1=result[0][4];
		roamType1=result[0][5];
	    tollType1=result[0][6];
		rateCodes1=result[0][7];
		cityTypes1=result[0][8];
	    dataTypes1=result[0][9];
		favCondType1=result[0][10];
		feeType1=result[0][11];
	    favourType1=result[0][12];
		typeMode=result[0][13];
		favourCycle=result[0][14];
		cycleUnit=result[0][15];
	    stepVal1=result[0][16];
		favoure1=result[0][17];
		stepVal2=result[0][18];
		favoure2=result[0][19];
		stepVal3=result[0][20];
		favoure3=result[0][21];
	}

  //获取已有的优惠条件信息

%>

<%if( isGetDataFlag != 0 ){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<%=errorMsg%>");
	window.close();
	window.opener.focus();
//-->
</script>
<%}%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>通话类型优惠代码配置</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../css/jl.css" rel="stylesheet" type="text/css">


<script language="JavaScript">
<!--
	//定义应用全局的变量
	var SUCC_CODE	= "0";   		//自己应用程序定义
	var ERROR_CODE  = "1";			//自己应用程序定义
	var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改     

	var dynRowNum = 0;
	var dynTbIndex=1;				//用于动态表数据的索引位置,开始值为1.考虑表头。
	var orderIndex=0;				//优惠顺序自动增加1生成. yl.

	//代表关系表达式
	var relationExprArr = new Array(new Array(),new Array(),new Array(),new Array(),new Array(),new Array());
		 relationExprArr[0][0]=">";
		 relationExprArr[0][1]=">";		 
		 relationExprArr[1][0]=">=";
		 relationExprArr[1][1]=">=";	
		 relationExprArr[2][0]="=";
		 relationExprArr[2][1]="=";
		 relationExprArr[3][0]="<";
		 relationExprArr[3][1]="<";
		 relationExprArr[4][0]="<=";
		 relationExprArr[4][1]="<=";
		 relationExprArr[5][0]="!=";
		 relationExprArr[5][1]="!=";

	//代表逻辑 关系
	var localExprArr = new Array(new Array(),new Array());
		 localExprArr[0][0]="AND";
		 localExprArr[0][1]="AND";		 
		 localExprArr[1][0]="OR";
		 localExprArr[1][1]="OR";
		 	
	//代表送费模式

	var typeModeArr = <%=S5010Impl.createArraySelf("typeModeArr",typeModeFixData.length)%>;
    <% for(int i=0; i<typeModeFixData.length; i++){ 
    	for(int j=0; j<typeModeFixData[i].length; j++){
    	//System.out.println("==111["+i+"]["+j+"]="+typeModeFixData[i][j]);
    %>
    		typeModeArr[<%=i%>][<%=j%>] = "<%=typeModeFixData[i][j]%>";
    <%	}
    }
    %>	
		 		 		 	
	core.loadUnit("debug");
	core.loadUnit("rpccore"); 
	onload=function()
	{		
		init();
		core.rpc.onreceive = doProcess;	

<%      if(result[0][0]!=null && !(result[0][0].equals("")) )
	    {    
%>	
		document.all.favCondType1.value="<%=favCondType1%>"; 
		document.all.favourType1.value="<%=favourType1%>";
	    document.all.typeMode.value="<%=typeMode%>"; 
		document.all.cycleUnit.value="<%=cycleUnit%>";

		document.all.queryAllDetail.onclick();
<%
        }	
%>
	}

	function init(){
		document.all.showID1.style.display="none";
		
		fillSelect("relationExpr",relationExprArr,1);
		fillSelect("localExpr",localExprArr,1);
		
			
	}

	//-----------公共函数0:检查对象是否为空.
	function checkNull(checkObj,msg){
		if(document.all(checkObj).value == ""){
			rdShowMessageDialog(msg);
			document.all(checkObj).focus();
			return false;
		}
		return true;
	}
	//-----------公共函数1:使用javascript的数组填充SELECT的域.
	function fillSelect(fillObject,dataArr,type)
	{	
		//必须使用,否则出现空值。options is a array. yl.
		document.all(fillObject).options.length=dataArr.length;
		for(var i=0;i<dataArr.length;i++){
			if(type == 0){//使用组合填充显示数据
			 	document.all(fillObject).options[i].text=dataArr[i][0]+"-->"+dataArr[i][1];
			 }else{
			 	document.all(fillObject).options[i].text=dataArr[i][1];
			 }
             document.all(fillObject).options[i].value=dataArr[i][0];
		}
	}


	function fillSelectUseValue(fillObject,dataArr,indValue)
	{	
		//必须使用,否则出现空值。options is a array. yl.
		document.all(fillObject).options.length=dataArr.length;
				
		for(var i=0;i<dataArr.length;i++){

			 document.all(fillObject).options[i].text=dataArr[i][1];
             document.all(fillObject).options[i].value=dataArr[i][0];
             
			if(document.all(fillObject).options[i].value == indValue){
				document.all(fillObject).options[i].selected = true;
			}             
		}
	}

	function fillSelectUseValue_noArr(fillObject,indValue)
	{	

			for(var i=0;i<document.all(fillObject).options.length;i++){
				if(document.all(fillObject).options[i].value == indValue){
					document.all(fillObject).options[i].selected = true;
					break;
				}
			}
							
	}

	//---------1------RPC处理函数------------------
	function doProcess(packet)
	{

		//使用RPC的时候,以下三个变量作为标准使用.
		var error_code = packet.data.findValueByName("errorCode");
		var error_msg =  packet.data.findValueByName("errorMsg");
		var verifyType = packet.data.findValueByName("verifyType");
		var backArrMsg = packet.data.findValueByName("backArrMsg");
		var backArrMsg1 = "";
	//alert("=====doprocess.............verifyType="+verifyType);
		
		self.status="";
		
		var tmpObj="";
		var i=0;
		var j=0;
		var ret_code=0;
		
		ret_code =  parseInt(error_code);
		
		if(verifyType=="query_all_detail"){//检测优惠代码
			if( ret_code == 0 ){
				//以下是具体的处理
				
				var condition_order="";
				var chat_type="";
				var call_type="";
				var roam_type="";
				var toll_type="";
				var rate_codes="";
				var city_types="";
				var data_types="";
				var fee_type="";
				var favcond_type="";
				var favour_type="";
				var relation_expr="";
				var condition_step="";
				var local_expr="";
				
				var curMaxOrder="";	
												
				var flag=0;		

				//alert("backArrMsg.length="+backArrMsg.length);
				dyn_deleteAll();  //删除所有的行
				reset_globalVar();
								
		        for(i=0;i<backArrMsg.length;i++)
			    {
				   condition_order = backArrMsg[i][0];
				   chat_type = backArrMsg[i][1];
				   call_type = backArrMsg[i][2];
				   roam_type = backArrMsg[i][3];
				   toll_type = backArrMsg[i][4];
				   rate_codes = backArrMsg[i][5];
				   city_types = backArrMsg[i][6];
				   data_types = backArrMsg[i][7];
				   fee_type = backArrMsg[i][8];
				   favcond_type = backArrMsg[i][9];
				   favour_type = backArrMsg[i][10];
				   relation_expr = backArrMsg[i][11];
				   condition_step = backArrMsg[i][12];
				   local_expr = backArrMsg[i][13];
 			   				   				   				   				   
				   curMaxOrder = backArrMsg[i][14];		
				   if(flag==0){
				   		orderIndex = parseInt(curMaxOrder);
				   }else{
				   		flag=1;
				   }				   
					queryAddAllRow(1,condition_order,chat_type,call_type,roam_type,toll_type,rate_codes,city_types,data_types,fee_type,favcond_type,favour_type,relation_expr,condition_step,local_expr);
					
			    }

			}else{
				rdShowMessageDialog("取信息错误:"+error_msg+"!");
				return;			
			}
		}
				
		
		
	}

	function dynAddRow()
	{
	var condition_order="";
	var chat_type="";
	var call_type="";
	var roam_type="";
	var toll_type="";
	var rate_codes="";
	var city_types="";
	var data_types="";
	var fee_type="";
	var favcond_type="";
	var favour_type="";
	var relation_expr="";
	var condition_step="";
	var local_expr="";
	  

	var tmpStr="";

	//检查域的合法性
	 if(!checkNull("chatType2","请输入对端类型串的信息!!")) return false;
	 if(!checkNull("callType2","请输入呼叫类型串的信息!!")) return false;
	 if(!checkNull("roamType2","请输入漫游类型串的信息!!")) return false;
	 if(!checkNull("tollType2","请输入长途类型串的信息!!")) return false;
	 if(!checkNull("rateCodes2","请输入批价代码串的信息!!")) return false;
	 if(!checkNull("cityTypes2","请输入对端同城串的信息!!")) return false;
	 if(!checkNull("dataTypes2","请输入数据类型串的信息!!")) return false;
	 if(!checkNull("feeType2","请输入费用类型串的信息!!")) return false;
	 if(!checkNull("conditionStep","请输入优惠条件阀值的信息!!")) return false;
	 
	 flag = check_Real("conditionStep","请输入数值!!");
	 if( flag == false ) return false;
	 
	//取数值
	chat_type =  document.frm.chatType2.value;
	call_type =  document.frm.callType2.value;
	roam_type =  document.frm.roamType2.value;
	toll_type =  document.frm.tollType2.value;
	rate_codes =  document.frm.rateCodes2.value;
	city_types =  document.frm.cityTypes2.value;
	data_types =  document.frm.dataTypes2.value;
	fee_type =  document.frm.feeType2.value;
	//alert("ssssssssssss");
	//favcond_type = document.all.favCondType2[document.all.favCondType2.selectedIndex].value;
	favcond_type = document.all.favCondType2.value;
	//alert("ssssssssssss1");
	//favour_type = document.all.favourType2[document.all.favourType2.selectedIndex].value;
	favour_type = document.all.favourType2.value;
	//relation_expr = document.all.relationExpr[document.all.relationExpr.selectedIndex].value;
	relation_expr = document.all.relationExpr.value;
	condition_step =  document.frm.conditionStep.value; 
	//logic_expr = document.all.localExpr[document.all.localExpr.selectedIndex].value;
	logic_expr = document.all.localExpr.value;

//alert(cond_order+"^"+fav_cond_type+"^"+fav_cond+"^"+cond_attr+"^"+relation_expr+"^"+cond_step+"^"+logic_expr);	  
	queryAddAllRow(0,condition_order,chat_type,call_type,roam_type,toll_type,rate_codes,city_types,data_types,fee_type,favcond_type,favour_type,relation_expr,condition_step,local_expr);
	
	}	


	function queryAddAllRow(add_type,condition_order,chat_type,call_type,roam_type,toll_type,rate_codes,city_types,data_types,fee_type,favcond_type,favour_type,relation_expr,condition_step,local_expr)
	{
	var tr1="";
	var i=0;
	var tmp_flag=false;

	  if( add_type == 0){//使用"增加条件"button增加
	  	orderIndex++;
	  	condition_order=""+orderIndex;
	  }
	  
      tr1=dyntb.insertRow();	//注意:插入的必须与下面的在一起,否则造成空行.yl.
	  tr1.id="tr"+dynTbIndex;
	  	    
  	  tr1.insertCell().innerHTML = '<input id=in0d0    type=checkBox    size=4 value="删除" onClick="dynDelRow()" ></input>';
      //改成自动增加的方式.yl.
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d1    type=text size=10    value="'+condition_order +'" readonly></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d2    type=text size=10    value="'+chat_type +'" readonly></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d3    type=text size=10   value="'+call_type +'" readonly></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d4    type=text size=10    value="'+roam_type +'" readonly></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d5    type=text size=10    value="'+toll_type +'" readonly></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d6    type=text size=10    value="'+rate_codes +'" readonly></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d7    type=text size=10    value="'+city_types +'" readonly></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d8    type=text size=10   value="'+data_types +'" readonly></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d9    type=text size=10    value="'+fee_type +'" readonly></input>';         
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d10 type=text size=4 value="'+ favcond_type+'" readonly></input>';   
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d11 type=text size=4 value="'+ favour_type+'" readonly></input>';

      tr1.insertCell().innerHTML = '<select id=in'+dynTbIndex+'d12></select>';
  	  fillSelectUseValue("in"+dynTbIndex+"d12",relationExprArr,relation_expr);
  	  
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d13    type=text   size=4  value="'+ condition_step +'"  ></input>';
          
      tr1.insertCell().innerHTML = '<select id=in'+dynTbIndex+'d14></select>';
  	  fillSelectUseValue("in"+dynTbIndex+"d14",localExprArr,local_expr);
           
		dynRowNum++;
		dynTbIndex++;

	}

	function dynDelRow()
	{
		var tmpObject="";
		var tmpTr="";
		
		dynRowNum--;		
    
           if( (typeof(document.all.in0d0.length)=="undefined")
           	&& (document.all.tr1.style.display=="") 
           ){//只有一行的情况

	            document.all.tr1.style.display="none";         
	           return;
          }
          
         for(var i=document.all.in0d0.length;i>0;i--){
         		tmpTr="tr"+i;
     
         	if( (document.all.in0d0[i-1].checked == true)
         		&& (document.all(tmpTr).style.display=="")
         	){

         		document.all(tmpTr).style.display="none"; 
         		break;
         	}
         }
         
	}



	function dyn_deleteAll()
	{
		//清除增加表中的数据
		for(t=dyntb.rows.length;t>1;t--)
		 dyntb.deleteRow();
		
	}	

	function reset_globalVar()
	{
	  dynRowNum = 0;	
	  dynTbIndex=1;				
	  orderIndex=0;				
	}
	
	function chg_opType()
	{

		var op_type = document.all.opType[document.all.opType.selectedIndex].value;
		
		if(op_type == "a"){//增加
			document.all.showID1.style.display="none";
			document.all.confirm.disabled = false;

		}else{
			document.all.showID1.style.display="";
			document.all.confirm.disabled = true;
		}
	
	}	

	function call_feeTypeQuery(field_type)
	{
	    var pageTitle = "费用类型查询";               
	    var fieldName = "代码|描述|";

		var sqlStr ="";

						 
		sqlStr ="select trim(fee_type),trim(fee_name) from sFeeType where fee_type != '*' ";	 
		sqlStr = sqlStr + " order by  fee_type";
		
	    var selType = "M";    //'S'单选；'M'多选      
	    var retQuence = "1|0|";             
	    var retToField = "";
	    var valueStr="";

		if( field_type < 10 ){
			valueStr=document.frm.feeType1.value;
			retToField = "feeType1|";
		}else{
			valueStr=document.frm.feeType2.value;
			retToField = "feeType2|";
		}	    
	    //alert(sqlStr);
	    PubSimpSel_toll(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,field_type,valueStr); 		

	}
	
	function call_dataTypesQuery(field_type)
	{
	    var pageTitle = "数据类型查询";               
	    var fieldName = "代码|描述|";

		var sqlStr ="";

						 
		sqlStr ="select trim(data_type),trim(data_name) from sDataType where data_type != '*' ";	 
		sqlStr = sqlStr + " order by  data_type" ;
		
	    var selType = "M";    //'S'单选；'M'多选      
	    var retQuence = "1|0|";             
	    var retToField = "";
	    var valueStr="";

		if( field_type < 10 ){
			valueStr=document.frm.dataTypes1.value;
			retToField = "dataTypes1|";
		}else{
			valueStr=document.frm.dataTypes2.value;
			retToField = "dataTypes2|";
		}		    
	    //alert(sqlStr);
	    PubSimpSel_toll(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,field_type,valueStr); 		
	
	}

	function call_cityTypesQuery(field_type)
	{
	    var pageTitle = "同城代码查询";               
	    var fieldName = "代码|描述|";

		var sqlStr ="";

						 
		sqlStr ="select trim(city_codes),trim(codes_name) from sCityTypes where city_codes != '*' "; 
		sqlStr = sqlStr + " order by  city_codes";
		
	    var selType = "M";    //'S'单选；'M'多选      
	    var retQuence = "1|0|";             
	    var retToField = "";
	    var valueStr="";

		if( field_type < 10 ){
			valueStr=document.frm.cityTypes1.value;
			retToField = "cityTypes1|";
		}else{
			valueStr=document.frm.cityTypes2.value;
			retToField = "cityTypes2|";
		}		    
	    //alert(sqlStr);
	    PubSimpSel_toll(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,field_type,valueStr); 	
			
	}
		
	function call_rateCodesQuery(field_type)
	{
	    var pageTitle = "批价代码查询";               
	    var fieldName = "代码|描述|";

		var sqlStr ="";

						 
		sqlStr ="select trim(rate_code),trim(note) from sBillRateCode "+
				" where region_code='" + "<%=regionCode%>" +"'" +" and rate_code != '*' ";	 
		sqlStr = sqlStr + " order by  rate_code";
		
	    var selType = "M";    //'S'单选；'M'多选      
	    var retQuence = "1|0|";             
	    var retToField = "";
	    var valueStr="";

		if( field_type < 10 ){
			valueStr=document.frm.rateCodes1.value;
			retToField = "rateCodes1|";
		}else{
			valueStr=document.frm.rateCodes2.value;
			retToField = "rateCodes2|";
		}		    
	    //alert(sqlStr);
	    PubSimpSel_toll(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,field_type,valueStr); 	
		
		
	}
	
	function call_tollTypeQuery(field_type)
	{
	    var pageTitle = "长途类型查询";               
	    var fieldName = "代码|描述|";

		var sqlStr ="";
						 
		sqlStr ="select trim(toll_type),trim(toll_name) from sTollType where toll_type != '*' ";		 
		sqlStr = sqlStr + " order by  toll_type";
		
	    var selType = "M";    //'S'单选；'M'多选      
	    var retQuence = "1|0|";             
	    var retToField = "";
	    var valueStr="";

		if( field_type < 10 ){
			valueStr=document.frm.tollType1.value;
			retToField = "tollType1|";
		}else{
			valueStr=document.frm.tollType2.value;
			retToField = "tollType2|";
		}	    
	    //alert(sqlStr);
	    PubSimpSel_toll(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,field_type,valueStr); 	
		
	
	}
	
	function call_roamTypeQuery(field_type)
	{
	    var pageTitle = "漫游类型查询";               
	    var fieldName = "代码|描述|";

		var sqlStr ="";
						 
		sqlStr ="select trim(roam_type),trim(roam_name) from sRoamType where roam_type != '*' ";		 
		sqlStr = sqlStr + " order by  roam_type";
		
	    var selType = "M";    //'S'单选；'M'多选      
	    var retQuence = "1|0|";             
	    var retToField = "";
	    var valueStr="";

		if( field_type < 10 ){
			valueStr=document.frm.roamType1.value;
			retToField = "roamType1|";
		}else{
			valueStr=document.frm.roamType2.value;
			retToField = "roamType2|";
		}				    
	    //alert(sqlStr);
	    PubSimpSel_toll(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,field_type,valueStr); 	
	
	}
	
	function call_callTypeQuery(field_type)
	{
	    var pageTitle = "呼叫类型查询";               
	    var fieldName = "代码|描述|";

		var sqlStr ="";
						 
		sqlStr ="select trim(call_type),trim(call_name) from sCallType where call_type != '*' ";		 
		sqlStr = sqlStr + " order by  call_type";
		
	    var selType = "M";    //'S'单选；'M'多选      
	    var retQuence = "1|0|";             
	    var retToField = "";
	    var valueStr="";

		if( field_type < 10 ){
			valueStr=document.frm.callType1.value;
			retToField = "callType1|";
		}else{
			valueStr=document.frm.callType2.value;
			retToField = "callType2|";
		}			    
	    //alert(sqlStr);
	    PubSimpSel_toll(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,field_type,valueStr); 	
	}
	
	function call_chatTypeQuery(field_type)
	{
	    var pageTitle = "对端类型查询";               
	    var fieldName = "代码|描述|";

		var sqlStr ="";
						 
		sqlStr ="select trim(chat_type),trim(chat_name) from sChatType where chat_type != '*' ";					 
		sqlStr = sqlStr + " order by  chat_type";
		
	    var selType = "M";    //'S'单选；'M'多选      
	    var retQuence = "1|0|";             
	    var retToField = "";
	    var valueStr="";

		if( field_type < 10 ){
			valueStr=document.frm.chatType1.value;
			retToField = "chatType1|";
		}else{
			valueStr=document.frm.chatType2.value;
			retToField = "chatType2|";
		}
			    
	    //alert(sqlStr);
	    PubSimpSel_toll(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,field_type,valueStr); 	
	}

	function PubSimpSel_toll(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,field_type,valueStr)
	{

	    
	    var path = "<%=request.getContextPath()%>/page/s5010/fPubSimpSel_toll.jsp";

	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType;  
		path = path + "&inStr=" + valueStr; 
	
	    retInfo = window.showModalDialog(path);
	    if(typeof(retInfo) == "undefined")     
	    {   return false;   }
	    var chPos_retInfo = retInfo.indexOf("|");
	    var valueStr;
	    var tmpStr="";
	    var flag=0;
	
	
	    if( field_type == 0){
	    	document.frm.chatType1.value =retInfo;
	    }else if( field_type == 1){
	    	document.frm.callType1.value =retInfo;    
	    }else if( field_type == 2){
	    	document.frm.roamType1.value =retInfo;    
	    }else if( field_type == 3){
	    	document.frm.tollType1.value =retInfo;    
	    }else if( field_type == 4){
	    	document.frm.rateCodes1.value =retInfo;    
	    }else if( field_type == 5){
	    	document.frm.cityTypes1.value =retInfo;    
	    }else if( field_type == 6){
	    	document.frm.dataTypes1.value =retInfo;    
	    }else if( field_type == 7){
	    	document.frm.feeType1.value =retInfo;    
	    }else if( field_type == 10){
	    	document.frm.chatType2.value =retInfo;    
	    }else if( field_type == 11){
	    	document.frm.callType2.value =retInfo;    
	    }else if( field_type == 12){
	    	document.frm.roamType2.value =retInfo;    
	    }else if( field_type == 13){
	    	document.frm.tollType2.value =retInfo;    
	    }else if( field_type == 14){
	    	document.frm.rateCodes2.value =retInfo;    
	    }else if( field_type == 15){
	    	document.frm.cityTypes2.value =retInfo;    
	    }else if( field_type == 16){
	    	document.frm.dataTypes2.value =retInfo;    
	    }else if( field_type == 17){
	    	document.frm.feeType2.value =retInfo;    
	    }



	    
	}
	
	
	function call_totalCodeQuery()
	{
	    var pageTitle = "通话类型优惠查询";               
	    var fieldName = "代码|描述|优惠顺序|对端类型串|"+
	    				"呼叫类型串|漫游类型串|长途类型串|批价代码串|对端同城串|"+
	    				"数据类型串|优惠条件|费用类型串|优惠方式|送费模式|"+
	    				"周期单位|优惠周期|"+
	    				"阀值1|优惠1|阀值2|优惠2|阀值3|优惠3|";
		var sqlStr ="";
						 
			sqlStr ="select FAVOUR_CODE,trim(CODE_NAME),to_char(order_code), "+
					" trim(chat_types),trim(call_types),trim(roam_types), "+
					" trim(toll_types),trim(rate_codes),"+
					" trim(city_types),trim(data_types),"+
					" FAVCOND_TYPE,trim(fee_type),"+
					" favour_type,type_mode,"+
					" to_char(MULTI_CYCLE),to_char(cycle_unit),"+
					" to_char(step_val1),to_char(favoure1),"+
					" to_char(step_val2),to_char(favoure2),"+
					" to_char(step_val3),to_char(favoure3) "+
					" from sBillFavCfg "+
					" where region_code='" + "<%=regionCode%>" +"'" ;
				
		if( (document.frm.totalCode.value == "")
			&& (document.frm.totalName.value == "")
		  ){
			i=0;
		}else if( document.frm.totalCode.value == ""){
			sqlStr = sqlStr + " and code_name like '%" +jtrim(document.frm.totalName.value)+"%'" ;					  
		}else if( document.frm.totalName.value == ""){
			sqlStr = sqlStr + " and FAVOUR_CODE like '"+encodeURI("%" +jtrim(document.frm.totalCode.value))+"%'" ;	
		}else{
			sqlStr = sqlStr + " and ( code_name like '%" +jtrim(document.frm.totalName.value)+"%'" +
								" or FAVOUR_CODE like '"+encodeURI("%" +jtrim(document.frm.totalCode.value))+"%' )";
		}				 
		sqlStr = sqlStr + " order by  FAVOUR_CODE,order_code";
		
	    var selType = "S";    //'S'单选；'M'多选      
	    var retQuence = "22|0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|";             
	    var retToField = "totalCode|totalName|orderCode|"+
	    				 "chatType1|callType1|roamType1|"+
	    				 "tollType1|rateCodes1|cityTypes1|"+
	    				 "dataTypes1|favCondType1|feeType1|"+
	    				 "favourType1|typeMode|favourCycle|cycleUnit|"+
	    				 "stepVal1|favoure1|stepVal2|favoure2|stepVal3|favoure3|";
	    
	    //alert(sqlStr);
	    PubSimpSel_field(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 	
	
	}

	function PubSimpSel_field(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
	{
	 
	    var path = "<%=request.getContextPath()%>/page/public/fPubSimpSel.jsp";
	    //var path = "../public/fPubSimpSel.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType;  
	
	//alert(path);
	    retInfo = window.showModalDialog(path);
	    if(typeof(retInfo) == "undefined")     
	    {   return false;   }
	    var chPos_field = retToField.indexOf("|");
	    var chPos_retStr;
	    var valueStr;
	    var obj;
	    var i=0;
	    var favourTypeFlag = 0;
	    
	    //alert(retInfo);
	    while(chPos_field > -1)
	    {
	        obj = retToField.substring(0,chPos_field);
	        //alert(obj);
	        chPos_retInfo = retInfo.indexOf("|");
	        valueStr = retInfo.substring(0,chPos_retInfo);
	//alert("valueStr="+valueStr+"|");

	        if( i == 10){//优惠条件
				fillSelectUseValue_noArr("favCondType1",valueStr);							        
	        }else if( i == 12){//优惠方式
				fillSelectUseValue_noArr("favourType1",valueStr);
				favourTypeFlag = valueStr;								        
	        }else if( i == 13){//送费模式
				if( favourTypeFlag == "1" ){//1：打折
					document.all.typeMode.options.length=0;
				}else{
					fillSelect("typeMode",typeModeArr,1);
					fillSelectUseValue_noArr("typeMode",valueStr);				
				}	        	
	        }else if( i == 15){//优惠周期
	        	fillSelectUseValue_noArr("cycleUnit",valueStr);
	        }else{
	        	document.all(obj).value = valueStr;
	        }
	        
	        retToField = retToField.substring(chPos_field + 1);
	        retInfo = retInfo.substring(chPos_retInfo + 1);
	        chPos_field = retToField.indexOf("|");
	        
	        i++;
	    }
	}

	function chg_favourType(){

 		var favour_type = document.all.favourType1[document.all.favourType1.selectedIndex].value;
 		var sqlBuf="";

		if( favour_type == "1" ){//1：打折
			document.all.typeMode.options.length=0;
			return false;
		}else{
			fillSelect("typeMode",typeModeArr,1);		
		}
	}

	function queryAllDetailRpc()
	{
		document.all.confirm.disabled = false;
		//获取所有细项的数据
		if(document.all.totalCode.value == ""){
			//rdShowMessageDialog("请输入优惠代码数据!!");
			return false;
		}
		
		var total_code="";
		var order_code="";
 		var sqlBuf="";
		var myPacket = new RPCPacket("CallCommONESQL.jsp","正在获得明细信息，请稍候......");
		
			total_code = document.all.totalCode.value;
			order_code = document.all.orderCode.value;

			sqlBuf="select to_char(cond_order),trim(chat_types), "+
					" trim(call_types),trim(roam_types), "+
					" trim(toll_types),trim(rate_codes),"+
					" trim(city_types),trim(data_types),"+
					" trim(fee_type),trim(favcond_type),trim(fee_type),"+
					" trim(relation_expr),to_char(condition_step),"+
					" trim(local_expr),"+
					" (select max(cond_order) from tMidBillFavCond "+
					" where region_code='" + "<%=regionCode%>" +"'" +
					" and favour_code='"+ total_code +"'"+
					" and order_code='"+ order_code +"'"+
				    " and login_accept=<%=login_accept%>" +   
					" ) " +					
					" from tMidBillFavCond "+
					" where login_accept=" + "<%=login_accept%>" +
					" order by cond_order ";
			//增加max(fav_order)的方式可以使用多个SQL语句的方式处理较好. yl.

			myPacket.data.add("verifyType","query_all_detail");

			myPacket.data.add("sqlBuf",sqlBuf);
			myPacket.data.add("recv_number",15);
			core.rpc.sendPacket(myPacket);
			delete(myPacket);			
	
	}
	
	function commitJsp()
	{

	  var tmpStr="";
	  var tmpTr="";
	  var tmpObject="";
	 	
	  var msg ="";
	  var flag=0;
	  var hasBufData = 0;
	    
	  var ind1Str ="";
	  var ind2Str ="";
	  var ind3Str ="";
	  var ind4Str ="";
	  var ind5Str ="";
	  var ind6Str ="";
	  var ind7Str ="";
	  var ind8Str ="";
	  var ind9Str ="";
	  var ind10Str ="";
	  var ind11Str ="";
	  var ind12Str ="";
	  var ind13Str ="";
	  var ind14Str ="";
	  	
	//检查域的合法性
	    if(!checkNull("totalCode","请输入优惠代码的信息!!")) return false;
	    if(!checkNull("totalName","请输入优惠名称的信息!!")) return false;
	    if(!checkNull("orderCode","请输入优惠顺序的信息!!")) return false;
		if(!checkNull("chatType1","请输入对端类型串的信息!!")) return false;
		if(!checkNull("callType1","请输入呼叫类型串的信息!!")) return false;
		if(!checkNull("roamType1","请输入漫游类型串的信息!!")) return false;
		if(!checkNull("tollType1","请输入长途类型串的信息!!")) return false;
		if(!checkNull("rateCodes1","请输入批价代码串的信息!!")) return false;
		if(!checkNull("cityTypes1","请输入对端同城串的信息!!")) return false;
	    if(!checkNull("dataTypes1","请输入数据类型串的信息!!")) return false;
	    if(!checkNull("feeType1","请输入费用类型串的信息!!")) return false;
	 
	    if(!checkNull("stepVal1","请输入阀值1的信息!!")) return false;
	    if(!checkNull("favoure1","请输入优惠值1的信息!!")) return false;
	    if(!checkNull("stepVal2","请输入阀值2的信息!!")) return false;
	    if(!checkNull("favoure2","请输入优惠值2的信息!!")) return false;		
	    if(!checkNull("stepVal3","请输入阀值3的信息!!")) return false;
	    if(!checkNull("favoure3","请输入优惠值3的信息!!")) return false;		

	
		flag = fucCheckNUM(document.frm.favourCycle.value);
		if(flag == 0) { showErrMsg("favourCycle","请输入数值!!");  return false};

		flag = fucCheckNUM(document.frm.orderCode.value);
		if(flag == 0) { showErrMsg("favourCycle","请输入数值!!");  return false};
		
		flag = check_Real("stepVal1","请输入数值!!"); if( flag == false ) return false;
		flag = check_Real("favoure1","请输入数值!!"); if( flag == false ) return false;
		flag = check_Real("stepVal2","请输入数值!!"); if( flag == false ) return false;
		flag = check_Real("favoure2","请输入数值!!"); if( flag == false ) return false;
		flag = check_Real("stepVal3","请输入数值!!"); if( flag == false ) return false;
		flag = check_Real("favoure3","请输入数值!!"); if( flag == false ) return false;

	 	//检查缓冲区是否有数据
	 	if( dyntb.rows.length == 1){
	 		rdShowMessageDialog("请添加数据!!");
	 		return false;
	 	}	

		//检查数据的合法性
 		if( (typeof(document.all.in0d0.length)=="undefined")
           	&& (document.all.tr1.style.display=="") 
           ){//只有一行的情况
			ind1Str =		document.all.in1d1.value+"^";
			ind2Str =       document.all.in1d2.value+"^";
			ind3Str =       document.all.in1d3.value+"^";
			ind4Str =       document.all.in1d4.value+"^";
			ind5Str =       document.all.in1d5.value+"^";
			ind6Str =       document.all.in1d6.value+"^";
			ind7Str =       document.all.in1d7.value+"^";
			ind8Str =		document.all.in1d8.value+"^";
			ind9Str =       document.all.in1d9.value+"^";
			ind10Str =       document.all.in1d10.value+"^";
			ind11Str =       document.all.in1d11.value+"^";
			ind12Str =       document.all.in1d12.value+"^";
			flag = check_Real("in1d13","请输入数值!!");
	 		if( flag == false ) return false;
			ind13Str =       document.all.in1d13.value+"^";
			ind14Str =       document.all.in1d14.value+"^"; 
			hasBufData = 1; 		
          }					

          //for(var i=document.all.in0d0.length;i>0;i--){ 
          for(var i=1; i<document.all.in0d0.length+1;i++){ 
            tmpTr="tr"+i; 
         	if(    (document.all(tmpTr).style.display=="") ){

			ind1Str =ind1Str +document.all("in"+i+"d1").value+"^";
			ind2Str =ind2Str +document.all("in"+i+"d2").value+"^";
			ind3Str =ind3Str +document.all("in"+i+"d3").value+"^";
			ind4Str =ind4Str +document.all("in"+i+"d4").value+"^";
			ind5Str =ind5Str +document.all("in"+i+"d5").value+"^";
			ind6Str =ind6Str +document.all("in"+i+"d6").value+"^";
			ind7Str =ind7Str +document.all("in"+i+"d7").value+"^";
			ind8Str =ind8Str +document.all("in"+i+"d8").value+"^";
			ind9Str =ind9Str +document.all("in"+i+"d9").value+"^";
			ind10Str =ind10Str +document.all("in"+i+"d10").value+"^";
			ind11Str =ind11Str +document.all("in"+i+"d11").value+"^";
			ind12Str =ind12Str +document.all("in"+i+"d12").value+"^";
			flag = check_Real("in"+i+"d13","请输入数值!!");
	 		if( flag == false ) return false;			
			ind13Str =ind13Str +document.all("in"+i+"d13").value+"^";
			ind14Str =ind14Str +document.all("in"+i+"d14").value+"^";	
			if( hasBufData == 0 ) hasBufData = 1;	       
         	}       	
         }
         
		if( hasBufData == 0 ){
	 		rdShowMessageDialog("请添加数据!!");
	 		return false;		
		}
		 document.all.tmpCondOrder.value = ind1Str;
		 document.all.tmpChatType.value = ind2Str;
		 document.all.tmpCallType.value = ind3Str;		 
		 document.all.tmpRoamType.value = ind4Str;
		 document.all.tmpTollType.value = ind5Str;
		 document.all.tmpRateCodes.value = ind6Str;
		 document.all.tmpCityTypes.value = ind7Str;
		 document.all.tmpDataTypes.value = ind8Str;
		 document.all.tmpFeeType.value = ind9Str;
		 document.all.tmpFavCondType.value = ind10Str;
		 document.all.tmpFavourType.value = ind11Str;
		 document.all.tmpRelationExpr.value = ind12Str;
		 document.all.tmpConditionStep.value = ind13Str;
		 document.all.tmpLocalExpr.value = ind14Str;

		 
		//6.对form的隐含字段赋值
		document.frm.loginNo.value = "<%=loginNo%>";
		document.frm.loginName.value = "<%=loginName%>";
		document.frm.opCode.value="5016";
		document.frm.orgCode.value="<%=orgCode%>";
		
		
		//7.形成系统备注
		document.frm.opNote.value="";
		tmpStr ="增加";
		tmpStr = tmpStr + "优惠代码:"+document.frm.totalCode.value+"";
		document.frm.opNote.value=document.frm.opNote.value+" "+tmpStr;

		//优化：其实可以在此处形成调用存储过程的SQL语句,这样不需要临时的隐含域,
		//		也不需要将form的域post到下一个页面.这样更简洁. yl.
		
		//8.提交页面
		document.frm.confirm.disabled = true;
		page = "f5238_opBillFav_submit.jsp";
		frm.action=page;
		frm.method="post";
	  	frm.submit();
         
         
//alert("==succeed=======");		
		

	}

	
	
//-->
</script>

</head>

<body bgcolor="#FFFFFF" text="#000000" background="../../images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="frm" method="post" action="">
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
      <td background="../../images/jl_background_1.gif" bgcolor="E8E8E8"> 
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="45%"> 
            <p><img src="../../images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
          <td width="55%" align="right"><img src="../../images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">工号：<%=loginNo%>
		  <img src="../../images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">操作员：<%=loginName%></td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" background="../../images/jl_background_3.gif" height="69"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="../../images/jl_logo.gif"></td>
                <td align="right"><img src="../../images/jl_head_1.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="73%"> 
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="42"><img src="../../images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td nowrap background="../../images/jl_background_4.gif"><font color="FFCC00"><b>通话类型优惠代码配置</b></font></td>
                      <td><img src="../../images/jl_ico_3.gif" width="389" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            
          </td>
          <td width="27%"> 
            <table border="0" cellspacing="0" cellpadding="4" align="right">
              <tr>
                <td><img src="../../images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="../../images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="../../images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
        <table width="98%" align="center" bgcolor="#FFFFFF" cellspacing="1" border="0" >
          <!--
    <tr> 
      <td width="16%" bgcolor="#99ccff" class="button">操作工号:<%=loginNo%></td>
      <td width="34%" bgcolor="#99ccff" class="button">操作员:<%=loginName%></td>
      <td width="16%" bgcolor="#99ccff" class="button">角色:<%=powerCode%></td>
      <td width="34%" bgcolor="#99ccff" class="button">部门:<%=dept%></td>
    </tr>
-->
          <tr bgcolor="#E8E8E8"> 
            <td bgcolor="#E8E8E8">配置流水:</td>
            <td> <input name="login_accept" type="text" id="login_accept" maxlength="20" value="<%=login_accept%>" readonly></td>
            <td> </td>
            <td> </tr>
          <tr bgcolor="#F5F5F5"> 
            <td bgcolor="#F5F5F5">优惠代码:</td>
            <td> <input name="totalCode" type="text" id="totalCode" size="4" maxlength="4" value="<%=totalCode%>"> 
              <input name="totalName" type="text" id="totalName" maxlength="60" value="<%=totalName%>">
            <td>优惠顺序:</td>
            <td><input name="orderCode" type="text" id="orderCode" maxlength="3" v_type="0-9" v_must=1 v_name="请输入优惠顺序信息!!" value="<%=orderCode%>"></td>
          </tr>
          <tr bgcolor="#E8E8E8"> 
            <td bgcolor="#E8E8E8">对端类型串:</td>
            <td colspan="3"> <input name="chatType1" type="text" id="chatType1" size="60" maxlength="200" readonly value="<%=chatType1%>"> 
              <input name="chatType1Query" type="button" class="button" id="chatType1Query"  value="查询" onClick="call_chatTypeQuery(0)"> 
            </td>
          </tr>
          <tr bgcolor="#F5F5F5"> 
            <td bgcolor="#F5F5F5">呼叫类型串:</td>
            <td colspan="3"> <input name="callType1" type="text" id="callType1" size="60" maxlength="50" readonly value="<%=callType1%>"> 
              <input name="callType1Query" type="button" class="button" id="callType1Query" value="查询" onClick="call_callTypeQuery(1)"></td>
          </tr>
          <tr bgcolor="#E8E8E8"> 
            <td bgcolor="#E8E8E8">漫游类型串:</td>
            <td colspan="3"> <input name="roamType1" type="text" id="roamType1" size="60" maxlength="20" readonly value="<%=roamType1%>"> 
              <input name="roamType1Query" type="button" class="button" id="roamType1Query" value="查询" onClick="call_roamTypeQuery(2)"> 
            </td>
          </tr>
          <tr bgcolor="#F5F5F5"> 
            <td bgcolor="#F5F5F5">长途类型串:</td>
            <td colspan="3"> <input name="tollType1" type="text" id="tollType1" size="60" maxlength="20" readonly value="<%=tollType1%>"> 
              <input name="tollType1Query" type="button" class="button" id="tollType1Query" value="查询" onClick="call_tollTypeQuery(3)"></td>
          </tr>
          <tr bgcolor="#E8E8E8"> 
            <td bgcolor="#E8E8E8">批价代码串:</td>
            <td colspan="3"> <input name="rateCodes1" type="text" id="rateCodes1" size="60" maxlength="200" readonly value="<%=rateCodes1%>"> 
              <input name="rateCodes1Query" type="button" class="button" id="rateCodes1Query" value="查询" onClick="call_rateCodesQuery(4)"> 
            </td>
          </tr>
          <tr bgcolor="#F5F5F5"> 
            <td bgcolor="#F5F5F5">对端同城串:</td>
            <td colspan="3"> <input name="cityTypes1" type="text" id="cityTypes1" size="60" maxlength="2" readonly value="<%=cityTypes1%>"> 
              <input name="cityTypes1Query" type="button" class="button" id="cityTypes1Query" value="查询" onClick="call_cityTypesQuery(5)"></td>
          </tr>
          <tr bgcolor="#E8E8E8"> 
            <td bgcolor="#E8E8E8">数据类型串:</td>
            <td colspan="3"> <input name="dataTypes1" type="text" id="dataTypes1" size="60" maxlength="10" readonly value="<%=dataTypes1%>"> 
              <input name="dataTypes1Query" type="button" class="button" id="dataTypes1Query" value="查询" onClick="call_dataTypesQuery(6)"></td>
          </tr>
          <tr bgcolor="#F5F5F5">
            <td bgcolor="#F5F5F5">费用类型串:</td>
            <td> <input name="feeType1" type="text" id="feeType1" maxlength="10" value="<%=feeType1%>"> 
              <input name="feeType1Query" type="button" class="button" id="feeType1Query" value="查询" onClick="call_feeTypeQuery(7)"></td>           
            <td >优惠条件:</td>
            <td> <select name="favCondType1" id="favCondType1">
                <%
        	for(int i=0;i<favCondTypeData.length; i++){
			out.println("<option class='button' value='"+favCondTypeData[i][0]+"'>"+favCondTypeData[i][1]+"</option>");
			}
		  %>
              </select></td>

          </tr>
          <tr bgcolor="#E8E8E8"> 
            <td height="16%" bgcolor="#E8E8E8">优惠方式:</td>
            <td height="34%"> <select name="favourType1" id="favourType1" onchange="chg_favourType()">
                <%
        	for(int i=0;i<favourTypeData.length; i++){
			out.println("<option class='button' value='"+favourTypeData[i][0]+"'>"+favourTypeData[i][1]+"</option>");
			}
		  %>
              </select></td>
            <td height="16%">送费模式:</td>
            <td height="34%"> <select name="typeMode" id="typeMode" >
                <%
        	for(int i=0;i<typeModeData.length; i++){
			out.println("<option class='button' value='"+typeModeData[i][0]+"'>"+typeModeData[i][1]+"</option>");
			}
		  %>
              </select></td>
          </tr>
          <tr bgcolor="#F5F5F5"> 
            <td height="16%" bgcolor="#F5F5F5">周期单位:</td>
            <td height="34%"> <input name="favourCycle" type="text" id="favourCycle" maxlength="5" value="<%=favourCycle%>"></td>
            <td height="16%">优惠周期:</td>
            <td height="34%"> <select name="cycleUnit" id="cycleUnit" >
                <%
        	for(int i=0;i<cycleUnitData.length; i++){
			out.println("<option class='button' value='"+cycleUnitData[i][0]+"'>"+cycleUnitData[i][1]+"</option>");
			}
		  %>
              </select></td>
          </tr>
          <tr bgcolor="#E8E8E8"> 
            <td height="16%" bgcolor="#E8E8E8">阀值1:</td>
            <td height="34%"> <input name="stepVal1" type="text" id="stepVal1" maxlength="15" value="<%=stepVal1%>"></td>
            <td height="16%">优惠值1:</td>
            <td height="34%"> <input name="favoure1" type="text" id="favoure1" maxlength="15" value="<%=favoure1%>"></td>
          </tr>
          <tr bgcolor="#F5F5F5"> 
            <td height="16%" bgcolor="#F5F5F5">阀值2:</td>
            <td height="34%"> <input name="stepVal2" type="text" id="stepVal2" maxlength="15" value="<%=stepVal2%>"></td>
            <td height="16%">优惠值2:</td>
            <td height="34%"> <input name="favoure2" type="text" id="favoure2" maxlength="15" value="<%=favoure2%>"></td>
          </tr>
          <tr bgcolor="#E8E8E8"> 
            <td height="16%">阀值3:</td>
            <td height="34%" bgcolor="#E8E8E8"> <input name="stepVal3" type="text" id="stepVal3" maxlength="15" value="<%=stepVal3%>"></td>
            <td height="16%">优惠值3:</td>
            <td height="34%"> <input name="favoure3" type="text" id="favoure3" maxlength="15" value="<%=favoure3%>"></td>
          </tr>
          <tr id="showID1" bgcolor="F5F5F5"> 
            <td colspan="4"> 
              <input name="queryAllDetail" type="button" id="queryAllDetail" value="查询细项" onClick="queryAllDetailRpc()" class="button">
            </td>
          </tr>            
          <tr> 
            <td colspan="4" bgcolor="#649ECC">条件</td>
          </tr>
          <tr bgcolor="#F5F5F5"> 
            <td bgcolor="#F5F5F5">对端类型串:</td>
            <td colspan="3"> <input name="chatType2" type="text" id="chatType2" size="60" maxlength="200" readonly> 
              <input name="chatType2Query" type="button" class="button" id="chatType2Query" value="查询" onClick="call_chatTypeQuery(10)"> 
            </td>
          </tr>
          <tr bgcolor="#E8E8E8"> 
            <td bgcolor="#E8E8E8">呼叫类型串:</td>
            <td colspan="3"> <input name="callType2" type="text" id="callType2" size="60" maxlength="50" readonly> 
              <input name="callType2Query" type="button" class="button" id="callType2Query" value="查询" onClick="call_callTypeQuery(11)"></td>
          </tr>
          <tr bgcolor="#F5F5F5"> 
            <td bgcolor="#F5F5F5">漫游类型串:</td>
            <td colspan="3"> <input name="roamType2" type="text" id="roamType2" size="60" maxlength="20" readonly> 
              <input name="roamType2Query" type="button" class="button" id="roamType2Query" value="查询" onClick="call_roamTypeQuery(12)"> 
            </td>
          </tr>
          <tr bgcolor="#E8E8E8"> 
            <td bgcolor="#E8E8E8">长途类型串:</td>
            <td colspan="3"> <input name="tollType2" type="text" id="tollType2" size="60" maxlength="20" readonly> 
              <input name="tollType2Query" type="button" class="button" id="tollType2Query" value="查询" onClick="call_tollTypeQuery(13)"></td>
          </tr>
          <tr bgcolor="#F5F5F5"> 
            <td bgcolor="#F5F5F5">批价代码串:</td>
            <td colspan="3"> <input name="rateCodes2" type="text" id="rateCodes2" size="60" maxlength="200" readonly> 
              <input name="rateCodes2Query" type="button" class="button" id="rateCodes2Query" value="查询" onClick="call_rateCodesQuery(14)"> 
            </td>
          </tr>
          <tr bgcolor="#E8E8E8"> 
            <td bgcolor="#E8E8E8">对端同城串:</td>
            <td colspan="3"> <input name="cityTypes2" type="text" id="cityTypes2" size="60" maxlength="2" readonly> 
              <input name="cityTypes2Query" type="button" class="button" id="cityTypes2Query" value="查询" onClick="call_cityTypesQuery(15)"></td>
          </tr>
          <tr bgcolor="#F5F5F5"> 
            <td bgcolor="#F5F5F5">数据类型串:</td>
            <td colspan="3"> <input name="dataTypes2" type="text" id="dataTypes2" size="60" maxlength="10" readonly> 
              <input name="dataTypes2Query" type="button" class="button" id="dataTypes2Query" value="查询" onClick="call_dataTypesQuery(16)"></td>
          </tr>
          <tr bgcolor="#E8E8E8">
            <td bgcolor="#E8E8E8">费用类型串:</td>
            <td> <input name="feeType2" type="text" id="feeType2" maxlength="10"> 
              <input name="feeType2Query" type="button" class="button" id="feeType2Query" value="查询" onClick="call_feeTypeQuery(17)"></td>           
            <td >优惠条件:</td>
            <td> <select name="favCondType2" id="favCondType2">
                <%
        	for(int i=0;i<favCondTypeData.length; i++){
			out.println("<option class='button' value='"+favCondTypeData[i][0]+"'>"+favCondTypeData[i][1]+"</option>");
			}
		  %>
              </select></td>
          </tr>
          <tr bgcolor="#F5F5F5"> 
            <td height="16%" bgcolor="#F5F5F5">优惠方式:</td>
            <td height="34%"> <select name="favourType2" id="favourType2" >
                <%
        	for(int i=0;i<favourTypeData.length; i++){
			out.println("<option class='button' value='"+favourTypeData[i][0]+"'>"+favourTypeData[i][1]+"</option>");
			}
		  %>
              </select></td>
            <td height="16%">&nbsp;</td>
            <td height="34%">&nbsp; </td>
          </tr>
          <tr bgcolor="#E8E8E8"> 
            <td height="16%">关系表达式:</td>
            <td height="34%" bgcolor="#E8E8E8"> <select name="relationExpr" id="relationExpr">
                <option value=">">></option>
                <option value=">=">>=</option>
                <option value="=">=</option>
                <option value="<"><</option>
                <option value="<="><=</option>
                <option value="!=">!=</option>
              </select></td>
            <td height="16%">优惠条件阀值:</td>
            <td height="34%"> <input name="conditionStep" type="text" id="conditionStep" maxlength="15"></td>
          </tr>
          <tr bgcolor="#F5F5F5"> 
            <td height="16%" bgcolor="#F5F5F5">逻辑 关系:</td>
            <td height="34%"> <select name="localExpr" id="localExpr">
                <option value="AND">AND</option>
                <option value="OR">OR</option>
              </select></td>
            <td height="16%"> <input name="addCondConfirm" type="button" class="button" id="addCondConfirm" onClick="dynAddRow()" value="增加条件"></td>
            <td height="34%">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4" bgcolor="#eeeeee" class="button">
              <table width="100%" border="1" id="dyntb">
                <tr> 
                  <td  >删除</td>
                  <td  >顺序</td>
                  <td  >对端类型串</td>
                  <td  >呼叫类型串</td>
                  <td  >漫游类型串</td>
                  <td  >长途类型串</td>
                  <td  >批价代码串</td>
                  <td  >对端同城串</td>                  
                  <td  >数据类型串</td>
                  <td  >费用类型串</td>                   
                  <td  >优惠条件</td>                  
                  <td  >优惠方式</td>                   
                  <td  >关系表达式</td> 
                  <td  >阀值</td>  
                  <td  >逻辑关系</td>                                                     
                </tr>
              </table>
              </td>
          </tr>
          <tr bgcolor="#F5F5F5"> 
            <td bgcolor="#F5F5F5">系统备注:</td>
            <td colspan="3"> <input name="sysNote" type="text" id="sysNote" size="60" maxlength="60"></td>
          </tr>
          <tr bgcolor="#F5F5F5"> 
            <td>操作备注:</td>
            <td colspan="3"> <input name="opNote" type="text" id="opNote" size="60" maxlength="60"></td>
          </tr>
          <tr bgcolor="#F5F5F5"> 
            <td colspan="4" class="button"> <div align="center"> 
                <input name="confirm" type="button" class="button" value="确认" onClick="commitJsp()">
                &nbsp; 
                <input name="reset" type="reset" class="button" value="清除">
                &nbsp; 
                <input name="back" onClick="window.opener.form1.typeButton<%=typeButtonNum%>.disabled=false;window.close()" type="button" class="button" value="返回">
                &nbsp; </div></td>
          </tr>
        </table>


  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  
  </td>
  </tr>
  </table>


  	<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
  	<input type="hidden" name="loginName" id="loginName" value="">
  	<input type="hidden" name="opCode" id="opCode" value="">
  	<input type="hidden" name="orgCode" id="orgCode" value="">
  	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
  	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">
	<input type="hidden" name="typeButtonNum" value="<%=typeButtonNum%>">

  	<input type="hidden" name="tmpCondOrder" id="tmpCondOrder" value="">
   	<input type="hidden" name="tmpChatType" id="tmpChatType" value="">
   	<input type="hidden" name="tmpCallType" id="tmpCallType" value="">
   	<input type="hidden" name="tmpRoamType" id="tmpRoamType" value="">
   	<input type="hidden" name="tmpTollType" id="tmpTollType" value="">
   	<input type="hidden" name="tmpRateCodes" id="tmpRateCodes" value="">
   	<input type="hidden" name="tmpCityTypes" id="tmpCityTypes" value="">
   	<input type="hidden" name="tmpDataTypes" id="tmpDataTypes" value="">
   	<input type="hidden" name="tmpFeeType" id="tmpFeeType" value="">
   	<input type="hidden" name="tmpFavCondType" id="tmpFavCondType" value="">
   	<input type="hidden" name="tmpFavourType" id="tmpFavourType" value="">
   	<input type="hidden" name="tmpRelationExpr" id="tmpRelationExpr" value="">
   	<input type="hidden" name="tmpConditionStep" id="tmpConditionStep" value="">
   	<input type="hidden" name="tmpLocalExpr" id="tmpLocalExpr" value="">   
   	
</form>
</body>
</html>
