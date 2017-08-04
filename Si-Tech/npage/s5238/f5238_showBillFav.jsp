   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "5240";
  String opName = "产品发布";
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>

<%
	    String loginNo = (String)session.getAttribute("workNo");
	    String loginName = (String)session.getAttribute("workName");
	    String orgCode = (String)session.getAttribute("orgCode");
	    String ip_Addr = (String)session.getAttribute("ipAddr");
	    
	    String regionCode = (String)session.getAttribute("regCode");
	    


		String login_accept=request.getParameter("login_accept");
		String totalCode = request.getParameter("detail_code");
		String typeButtonNum = request.getParameter("typeButtonNum");
		String region_code = request.getParameter("region_code");
 
		
	int		LISTROWS=16;
			
	//进行工号权限检验
%>

<%

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

	//1.SQL 优惠方式
    insql.delete(0,insql.length());
    insql.append("select favour_type,favour_type||'-->'||trim(type_name) from sFavcondType order by favour_type asc");
//	al = s5010.getCommONESQL(insql.toString(),2,0);
		String sql1= insql.toString();
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%
	if( result_t1 == null ){
		isGetDataFlag = 2;
	}	
	else
	favCondTypeData = result_t1;    

	//2.SQL 优惠方式
    insql.delete(0,insql.length());
    insql.append("select favour_type,favour_type||'-->'||trim(type_name) from sFavourType order by favour_type asc");
	//al = s5010.getCommONESQL(insql.toString(),2,0);
	String sql2=insql.toString();
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql2%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>


<%	
	if( result_t2 == null ){
		isGetDataFlag = 3;
	}	
else
	favourTypeData = result_t2;   
	
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
	
			//al = s5010.getCommONESQL(insql.toString(),2,0);
			String sql3 = insql.toString();
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql3%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>

<%			
			if( result_t3 == null ){
				isGetDataFlag = 4;
			}
		else
			typeModeData = result_t3;
		}
	}
	
	   
	//2.SQL 优惠周期
    insql.delete(0,insql.length());
    insql.append("select to_char(unit_type),unit_type||'-->'||trim(type_name) from sCycleUnit order by unit_type");
	//al = s5010.getCommONESQL(insql.toString(),2,0);
	String sql4=insql.toString();
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg4" retcode="code4" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql4%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t4" scope="end"/>

<%	
		if( result_t4 == null ){
		isGetDataFlag = 5;
	}
else
	cycleUnitData = result_t4;    
	       

	//3.取送费模式数据
	insql.delete(0,insql.length());
	insql.append("select mode_type,mode_type||'-->'||trim(type_name) from sModeType ");
	insql.append(" order by mode_type ");

	//al = s5010.getCommONESQL(insql.toString(),2,0);
	String sql5=insql.toString();
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg5" retcode="code5" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql5%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t5" scope="end"/>

<%	
	if( result_t5 == null ){
		isGetDataFlag = 6;
	}
else
	typeModeFixData = result_t5;

	isGetDataFlag = 0;


 errorMsg = "取数据错误:"+Integer.toString(isGetDataFlag);	    


 //获取已有的优惠信息
    String sqlStr="";

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
					" from sBillFavCfg "+
					" where region_code ='" + region_code + "' and  FAVOUR_CODE ='" + totalCode + "'";

	//retList = callView.sPubSelect("22",sqlStr);
	
%>

		<wtc:pubselect name="sPubSelect" outnum="22" retmsg="msg6" retcode="code6" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t6" scope="end"/>

<%	
	errorMsg=msg6; 
	
	String[][] result = result_t6;
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
	rdShowMessageDialog("<%=errorMsg%>",0);
	window.close();
	window.opener.focus();
//-->
</script>
<%}%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>通话类型优惠排息</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


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

	var typeModeArr = new Array();
	
    <% for(int i=0; i<typeModeFixData.length; i++){
    %>
     
    	typeModeArr[<%=i%>] = new Array();
    	<%
    	for(int j=0; j<typeModeFixData[i].length; j++){
    	
    	//System.out.println("==111["+i+"]["+j+"]="+typeModeFixData[i][j]);
    %>
    		typeModeArr[<%=i%>][<%=j%>] = "<%=typeModeFixData[i][j]%>";
    <%	
    }
    }
    %>	
		 		 		 	
	onload=function()
	{		
		init();

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
			rdShowMessageDialog(msg,0);
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
				rdShowMessageDialog("取信息错误:"+error_msg+"!",0);
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
	 
	 flag = forReal(document.frm.conditionStep);
	 alert("flag = "+flag);
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
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d1    type=text size=10    value="'+condition_order +'" readonly  Class=InputGrey ></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d2    type=text size=10    value="'+chat_type +'" readonly  Class=InputGrey ></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d3    type=text size=10   value="'+call_type +'" readonly  Class=InputGrey ></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d4    type=text size=10    value="'+roam_type +'" readonly  Class=InputGrey ></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d5    type=text size=10    value="'+toll_type +'" readonly  Class=InputGrey ></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d6    type=text size=10    value="'+rate_codes +'" readonly  Class=InputGrey ></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d7    type=text size=10    value="'+city_types +'" readonly  Class=InputGrey ></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d8    type=text size=10   value="'+data_types +'" readonly  Class=InputGrey ></input>';
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d9    type=text size=10    value="'+fee_type +'" readonly  Class=InputGrey ></input>';         
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d10 type=text size=4 value="'+ favcond_type+'" readonly  Class=InputGrey ></input>';   
      tr1.insertCell().innerHTML = '<input id=in'+dynTbIndex+'d11 type=text size=4 value="'+ favour_type+'" readonly  Class=InputGrey ></input>';

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
				" where region_code='" + document.all.region_code.value +"'" +" and rate_code != '*' ";	 
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

	    
	    var path = "<%=request.getContextPath()%>/npage/s5010/fPubSimpSel_toll.jsp";

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
					" where region_code='" + document.all.region_code.value +"'" ;
				
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
	 
	    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
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
		var myPacket = new AJAXPacket("CallCommONESQL.jsp","正在获得明细信息，请稍候......");
		
			total_code = document.all.totalCode.value;
			order_code = document.all.orderCode.value;

			sqlBuf="select to_char(cond_order),trim(chat_types), "+
					" trim(call_types),trim(roam_types), "+
					" trim(toll_types),trim(rate_codes),"+
					" trim(city_types),trim(data_types),"+
					" trim(fee_type),trim(favcond_type),trim(fee_type),"+
					" trim(relation_expr),to_char(condition_step),"+
					" trim(local_expr),"+
					" (select max(cond_order) from sBillFavCond "+
					" where region_code='" + document.all.region_code.value +"'" +
					" and favour_code='"+ total_code +"'"+
					" and order_code='"+ order_code +"'"+
				    " and region_code='" + document.all.region_code.value + "' and FAVOUR_CODE = '" + "<%=totalCode%>" + "' " +   
					" ) " +					
					" from sBillFavCond "+
					" where region_code='" + document.all.region_code.value+"' and FAVOUR_CODE = '" + "<%=totalCode%>"+"'" +
					" order by cond_order ";
			//增加max(fav_order)的方式可以使用多个SQL语句的方式处理较好. yl.

			myPacket.data.add("verifyType","query_all_detail");

			myPacket.data.add("sqlBuf",sqlBuf);
			myPacket.data.add("recv_number",15);
			core.ajax.sendPacket(myPacket);
			myPacket = null;	
	
	}


	
	
//-->
</script>

</head>

<body>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">通话类型优惠排息</div>
	</div>

        <table cellspacing="0" >
   
          <tr > 
            <td class="blue">配置流水</td>
            <td> <input name="login_accept" type="text" id="login_accept" maxlength="20" value="<%=login_accept%>" readonly  Class=InputGrey ></td>
            <td> &nbsp;</td>
            <td> &nbsp;</td></tr>
          <tr > 
            <td  class="blue">优惠代码</td>
            <td> <input name="totalCode" type="text" id="totalCode" size="4" maxlength="4" value="<%=totalCode%>"> 
              <input name="totalName" type="text" id="totalName" maxlength="60" value="<%=totalName%>">
            <td class="blue">优惠顺序</td>
            <td><input name="orderCode" type="text" id="orderCode" maxlength="3" v_type="0-9" v_must=1 v_name="请输入优惠顺序信息!!" value="<%=orderCode%>"></td>
          </tr>
          <tr > 
            <td  class="blue">对端类型串</td>
            <td colspan="3"> <input name="chatType1" type="text" id="chatType1" size="60" maxlength="200" readonly  Class=InputGrey  value="<%=chatType1%>"> 
            </td>
          </tr>
          <tr > 
            <td  class="blue">呼叫类型串</td>
            <td colspan="3"> <input name="callType1" type="text" id="callType1" size="60" maxlength="50" readonly   Class=InputGrey value="<%=callType1%>"> 
          </tr>
          <tr > 
            <td  class="blue">漫游类型串</td>
            <td colspan="3"> <input name="roamType1" type="text" id="roamType1" size="60" maxlength="20" readonly  Class=InputGrey  value="<%=roamType1%>"> 
              <input name="roamType1Query" type="button"  id="roamType1Query" value="查询" onClick="call_roamTypeQuery(2)" class="b_text"> 
            </td>
          </tr>
          <tr > 
            <td  class="blue">长途类型串</td>
            <td colspan="3"> <input name="tollType1" type="text" id="tollType1" size="60" maxlength="20" readonly  Class=InputGrey  value="<%=tollType1%>"> 
              <input name="tollType1Query" type="button" class="b_text"  id="tollType1Query" value="查询" onClick="call_tollTypeQuery(3)"></td>
          </tr>
          <tr > 
            <td  class="blue">批价代码串</td>
            <td colspan="3"> <input name="rateCodes1" type="text" id="rateCodes1" size="60" maxlength="200" readonly  Class=InputGrey  value="<%=rateCodes1%>"> 
              <input name="rateCodes1Query" type="button" class="b_text"  id="rateCodes1Query" value="查询" onClick="call_rateCodesQuery(4)"> 
            </td>
          </tr>
          <tr > 
            <td  class="blue">对端同城串</td>
            <td colspan="3"> <input name="cityTypes1" type="text" id="cityTypes1" size="60" maxlength="2" readonly  Class=InputGrey  value="<%=cityTypes1%>"> 
              <input name="cityTypes1Query" type="button" class="b_text"  id="cityTypes1Query" value="查询" onClick="call_cityTypesQuery(5)"></td>
          </tr>
          <tr > 
            <td  class="blue">数据类型串</td>
            <td colspan="3"> <input name="dataTypes1" type="text" id="dataTypes1" size="60" maxlength="10" readonly  Class=InputGrey  value="<%=dataTypes1%>"> 
              <input name="dataTypes1Query" type="button" class="b_text"  id="dataTypes1Query" value="查询" onClick="call_dataTypesQuery(6)"></td>
          </tr>
          <tr >
            <td  class="blue">费用类型串</td>
            <td> <input name="feeType1" type="text" id="feeType1" maxlength="10" value="<%=feeType1%>"> 
              <input name="feeType1Query" type="button" class="b_text"  id="feeType1Query" value="查询" onClick="call_feeTypeQuery(7)"></td>           
            <td  class="blue">优惠条件</td>
            <td> <select name="favCondType1" id="favCondType1">
                <%
        	for(int i=0;i<favCondTypeData.length; i++){
			out.println("<option class='button' class='b_text' value='"+favCondTypeData[i][0]+"'>"+favCondTypeData[i][1]+"</option>");
			}
		  %>
              </select></td>

          </tr>
          <tr > 
            <td height="16%"  class="blue">优惠方式</td>
            <td height="34%"> <select name="favourType1" id="favourType1" onchange="chg_favourType()">
                <%
        	for(int i=0;i<favourTypeData.length; i++){
			out.println("<option class='button' class='b_text' value='"+favourTypeData[i][0]+"'>"+favourTypeData[i][1]+"</option>");
			}
		  %>
              </select></td>
            <td height="16%" class="blue">送费模式</td>
            <td height="34%"> <select name="typeMode" id="typeMode" >
                <%
        	for(int i=0;i<typeModeData.length; i++){
			out.println("<option class='button' class='b_text' value='"+typeModeData[i][0]+"'>"+typeModeData[i][1]+"</option>");
			}
		  %>
              </select></td>
          </tr>
          <tr > 
            <td height="16%"  class="blue">周期单位</td>
            <td height="34%"> <input name="favourCycle" type="text" id="favourCycle" maxlength="5" value="<%=favourCycle%>"></td>
            <td height="16%" class="blue">优惠周期</td>
            <td height="34%"> <select name="cycleUnit" id="cycleUnit" >
                <%
        	for(int i=0;i<cycleUnitData.length; i++){
			out.println("<option class='button' class='b_text' value='"+cycleUnitData[i][0]+"'>"+cycleUnitData[i][1]+"</option>");
			}
		  %>
              </select></td>
          </tr>
          <tr > 
            <td height="16%"  class="blue">阀值1</td>
            <td height="34%"> <input name="stepVal1" type="text" id="stepVal1" maxlength="15" value="<%=stepVal1%>"></td>
            <td height="16%" class="blue">优惠值1</td>
            <td height="34%"> <input name="favoure1" type="text" id="favoure1" maxlength="15" value="<%=favoure1%>"></td>
          </tr>
          <tr > 
            <td height="16%"  class="blue">阀值2</td>
            <td height="34%"> <input name="stepVal2" type="text" id="stepVal2" maxlength="15" value="<%=stepVal2%>"></td>
            <td height="16%" class="blue">优惠值2</td>
            <td height="34%"> <input name="favoure2" type="text" id="favoure2" maxlength="15" value="<%=favoure2%>"></td>
          </tr>
          <tr > 
            <td height="16%" class="blue">阀值3</td>
            <td height="34%" > <input name="stepVal3" type="text" id="stepVal3" maxlength="15" value="<%=stepVal3%>"></td>
            <td height="16%" class="blue">优惠值3</td>
            <td height="34%"> <input name="favoure3" type="text" id="favoure3" maxlength="15" value="<%=favoure3%>"></td>
          </tr>
          <tr id="showID1" bgcolor="F5F5F5"> 
            <td colspan="4"> 
              <input name="queryAllDetail" type="button" class="b_text" id="queryAllDetail" value="查询细项" onClick="queryAllDetailRpc()" >
            </td>
          </tr>            
          <tr> 
            <td colspan="4"  class="blue">条件</td>
          </tr>
          <tr > 
            <td  class="blue">对端类型串</td>
            <td colspan="3"> <input name="chatType2" type="text" id="chatType2" size="60" maxlength="200" readonly  Class=InputGrey > 
              <input name="chatType2Query" type="button" class="b_text"  id="chatType2Query" value="查询" onClick="call_chatTypeQuery(10)"> 
            </td>
          </tr>
          <tr > 
            <td  class="blue">呼叫类型串</td>
            <td colspan="3"> <input name="callType2" type="text" id="callType2" size="60" maxlength="50" readonly  Class=InputGrey > 
              <input name="callType2Query" type="button" class="b_text"  id="callType2Query" value="查询" onClick="call_callTypeQuery(11)"></td>
          </tr>
          <tr > 
            <td  class="blue">漫游类型串</td>
            <td colspan="3"> <input name="roamType2" type="text" id="roamType2" size="60" maxlength="20" readonly  Class=InputGrey > 
              <input name="roamType2Query" type="button" class="b_text"  id="roamType2Query" value="查询" onClick="call_roamTypeQuery(12)"> 
            </td>
          </tr>
          <tr > 
            <td  class="blue">长途类型串</td>
            <td colspan="3"> <input name="tollType2" type="text" id="tollType2" size="60" maxlength="20" readonly  Class=InputGrey > 
              <input name="tollType2Query" type="button" class="b_text"  id="tollType2Query" value="查询" onClick="call_tollTypeQuery(13)"></td>
          </tr>
          <tr > 
            <td  class="blue">批价代码串</td>
            <td colspan="3"> <input name="rateCodes2" type="text" id="rateCodes2" size="60" maxlength="200" readonly  Class=InputGrey > 
              <input name="rateCodes2Query" type="button" class="b_text"  id="rateCodes2Query" value="查询" onClick="call_rateCodesQuery(14)"> 
            </td>
          </tr>
          <tr > 
            <td  class="blue">对端同城串</td>
            <td colspan="3"> <input name="cityTypes2" type="text" id="cityTypes2" size="60" maxlength="2" readonly  Class=InputGrey > 
              <input name="cityTypes2Query" type="button" class="b_text"  id="cityTypes2Query" value="查询" onClick="call_cityTypesQuery(15)"></td>
          </tr>
          <tr > 
            <td  class="blue">数据类型串</td>
            <td colspan="3"> <input name="dataTypes2" type="text" id="dataTypes2" size="60" maxlength="10" readonly  Class=InputGrey > 
              <input name="dataTypes2Query" type="button" class="b_text"  id="dataTypes2Query" value="查询" onClick="call_dataTypesQuery(16)"></td>
          </tr>
          <tr >
            <td  class="blue">费用类型串</td>
            <td> <input name="feeType2" type="text" id="feeType2" maxlength="10"> 
              <input name="feeType2Query" type="button" class="b_text"  id="feeType2Query" value="查询" onClick="call_feeTypeQuery(17)"></td>           
            <td  class="blue">优惠条件</td>
            <td> <select name="favCondType2" id="favCondType2">
                <%
        	for(int i=0;i<favCondTypeData.length; i++){
			out.println("<option class='button' class='b_text' value='"+favCondTypeData[i][0]+"'>"+favCondTypeData[i][1]+"</option>");
			}
		  %>
              </select></td>
          </tr>
          <tr > 
            <td height="16%"  class="blue">优惠方式</td>
            <td height="34%"> <select name="favourType2" id="favourType2" >
                <%
        	for(int i=0;i<favourTypeData.length; i++){
			out.println("<option class='button' class='b_text' value='"+favourTypeData[i][0]+"'>"+favourTypeData[i][1]+"</option>");
			}
		  %>
              </select></td>
            <td height="16%">&nbsp;</td>
            <td height="34%">&nbsp; </td>
          </tr>
          <tr > 
            <td height="16%" class="blue">关系表达式</td>
            <td height="34%" > <select name="relationExpr" id="relationExpr">
                <option value=">">></option>
                <option value=">=">>=</option>
                <option value="=">=</option>
                <option value="<"><</option>
                <option value="<="><=</option>
                <option value="!=">!=</option>
              </select></td>
            <td height="16%" class="blue">优惠条件阀值</td>
            <td height="34%"> <input name="conditionStep" type="text" id="conditionStep" maxlength="15"></td>
          </tr>
          <tr > 
            <td height="16%"  class="blue">逻辑 关系</td>
            <td height="34%"> <select name="localExpr" id="localExpr">
                <option value="AND">AND</option>
                <option value="OR">OR</option>
              </select></td>
            <td height="16%"> <input name="addCondConfirm" type="button" class="b_text"  id="addCondConfirm" onClick="dynAddRow()" value="增加条件"></td>
            <td height="34%">&nbsp;</td>
          </tr>
         </table>
            	
              <table width="100%"  id="dyntb">
                <tr> 
                  <th  >删除</th>
                  <th  >顺序</th>
                  <th  >对端类型串</th>
                  <th  >呼叫类型串</th>
                  <th  >漫游类型串</th>
                  <th  >长途类型串</th>
                  <th  >批价代码串</th>
                  <th  >对端同城串</th>                  
                  <th  >数据类型串</th>
                  <th  >费用类型串</th>                   
                  <th  >优惠条件</th>                  
                  <th  >优惠方式</th>                   
                  <th  >关系表达式</th> 
                  <th  >阀值</th>  
                  <th  >逻辑关系</th>                                                     
                </tr>
              </table>
          <table>
          <tr > 
            <td  class="blue">系统备注</td>
            <td colspan="3"> <input name="sysNote" type="text" id="sysNote" size="60" maxlength="60">
            	<input name="opNote" type="hidden" id="opNote" size="60" maxlength="60"></td>
          </tr>
  
          <tr > 
            <td colspan="4" id="footer"> <div align="center"> 
                 
                <input name="back" onClick="window.close()" type="button"  value="关 闭" class="b_foot">
                &nbsp; </div></td>
          </tr>
        </table>




  	<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
  	<input type="hidden" name="loginName" id="loginName" value="">
  	<input type="hidden" name="opCode" id="opCode" value="">
  	<input type="hidden" name="orgCode" id="orgCode" value="">
  	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
  	<input type="hidden" name="region_code" id="region_code" value="<%=region_code%>">
  	<input type="hidden" name="totalCode" id="totalCode" value="<%=totalCode%>">
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
   	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
