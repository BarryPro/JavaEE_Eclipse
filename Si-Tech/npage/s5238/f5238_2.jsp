<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-18
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "个人产品配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	

<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<%
	String workNo   = (String)session.getAttribute("workNo");                //工号
	String nopass  = (String)session.getAttribute("password");                    	//登陆密码
	String regionCode = (String)session.getAttribute("regCode");
	
	Logger logger = Logger.getLogger("f5238_2.jsp");
	
	//获取从上页得到的信息
	String page_flag = request.getParameter("page_flag");
	String login_accept = request.getParameter("login_accept");							
	String region_code = request.getParameter("region_code");							
	String sm_code = request.getParameter("sm_code");									
	String mode_code = request.getParameter("mode_code");								
	String mode_name = request.getParameter("mode_name");								
	String mode_flag = request.getParameter("mode_flag");								
	String begin_time = request.getParameter("begin_time");								
	String end_time = request.getParameter("end_time");	
	String note = request.getParameter("note");
	String mode_use = request.getParameter("mode_use");
	String year_flag = request.getParameter("year_flag");
	String next_mode = request.getParameter("next_mode");
	String mode_type = request.getParameter("mode_type");
	String power_right = request.getParameter("power_right");
	String op_code = request.getParameter("op_code")==null?"":request.getParameter("op_code");
	if(op_code.equals(""))  op_code="5238";
	
	
	DateFormat df = new SimpleDateFormat("yyyyMMdd");
	Date d1=new Date();
	String sysdate=df.format(d1);
 
	String errCode="";
    String errMsg="";  

    String[][] result  = new String[][]{};
    

    	String paramsIn[] = new String[18];
    	paramsIn[0] = workNo;				//工号
    	paramsIn[1] = nopass;				//密码
    	paramsIn[2] = op_code;				//OP_CODE
    	paramsIn[3] = "";					 
    	paramsIn[4] = login_accept;			
    	paramsIn[5] = region_code;			
    	paramsIn[6] = sm_code;						
    	paramsIn[7] = mode_code;			
    	paramsIn[8] = mode_name;			
    	paramsIn[9] = mode_flag;			
    	paramsIn[10] = begin_time;		
    	paramsIn[11] = end_time;		
    	paramsIn[12] = note;
    	paramsIn[13] = mode_use;
		paramsIn[14] = year_flag;
		paramsIn[15] = next_mode;
		paramsIn[16] = mode_type;
		paramsIn[17] = power_right;
    	
    	
    	    	String paramsIn1[] = new String[4];
    	paramsIn1[0] = workNo;				//工号
    	paramsIn1[1] = nopass;				//密码
    	paramsIn1[2] = "5238";				//OP_CODE
    	paramsIn1[3] = login_accept;			
    	
		//acceptList = impl.callFXService("s5238_2Int",paramsIn,"12");
		
		//acceptList = impl.callFXService("s5238_1Cfm",paramsIn,"12");
%>

    <wtc:service name="s5238_1Cfm" outnum="12" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />
			<wtc:param value="<%=paramsIn[6]%>" />				
			<wtc:param value="<%=paramsIn[7]%>" />		
			<wtc:param value="<%=paramsIn[8]%>" />	
			<wtc:param value="<%=paramsIn[9]%>" />	
			<wtc:param value="<%=paramsIn[10]%>" />	
			<wtc:param value="<%=paramsIn[11]%>" />	
			<wtc:param value="<%=paramsIn[12]%>" />	
			<wtc:param value="<%=paramsIn[13]%>" />	
			<wtc:param value="<%=paramsIn[14]%>" />	
			<wtc:param value="<%=paramsIn[15]%>" />	
			<wtc:param value="<%=paramsIn[16]%>" />
			<wtc:param value="<%=paramsIn[17]%>" />
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />
 
		
	  <wtc:service name="s5238_2Int" outnum="12" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn1[0]%>" />
			<wtc:param value="<%=paramsIn1[1]%>" />
			<wtc:param value="<%=paramsIn1[2]%>" />
			<wtc:param value="<%=paramsIn1[3]%>" />			
		</wtc:service>
		<wtc:array id="result_t1" scope="end" />
		
		<%
 
	
	if(page_flag.equals("0"))
	{
	result = result_t;
	 errCode=code;
   errMsg=msg;  
	}
else
	{
	result_t = result_t1;
		 errCode=code1;
   errMsg=msg1;  
	}
	
	
	if(!errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	 rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	        history.go(-1);
        </script>
<%	}
 										
%>

<html>
<head>
<base target="_self">
<title>个人产品配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
onload=function()
{
	self.status="";
}

//处理rpc返回结果
  function doProcess(packet) {
		self.status="";
		var qryType=packet.data.findValueByName("rpcType");
		var errCode=packet.data.findValueByName("errCode");
		var errMsg=packet.data.findValueByName("errMsg");
		if(parseInt(errCode)!=0){
			rdShowMessageDialog("错误信息"+errMsg + "<br>错误代码"+errCode, 0);
			return false;
		}
		
		if(qryType=="getDetailCode")
		{
				var detailCode = packet.data.findValueByName("detailCode");

				var checkBoxObj = document.getElementsByName("checkBox1");
				var detailTypeObj = document.getElementsByName("detail_types");
				var detailCodeObj = document.getElementsByName("detail_codes");
				var detail_type = document.form1.detail_type.value;

                var maxCode = StrAdd(1,detailCode,1);
				var temp=0;
                /*判断该最大代码是否已经存在,如存在则在当前页面取最大值*/
				while(temp==0)
			    {
						if(checkBoxObj.length==0) temp=1;
					
				    for(var i=0;i<checkBoxObj.length;i++)
					{			
						 //alert(detail_type + "->" + detailTypeObj[i].value + "|||" + maxCode + "->" + detailCodeObj[i].value);			
					  /* 特殊处理 1->9  2->b */ 
					  var tmpDetailType = detailTypeObj[i].value;
					  
					  if((detail_type== "1" || detail_type== "9") && (tmpDetailType== "1" || tmpDetailType== "9")){
					  	tmpDetailType = detail_type;
					  }
					  
					  if((detail_type== "2" || detail_type== "b") && (tmpDetailType== "2" || tmpDetailType== "b")){
					  	tmpDetailType = detail_type;
					  }
					  
					  
					  if(detail_type==tmpDetailType && maxCode==detailCodeObj[i].value)
						{
							maxCode = StrAdd(1,detailCodeObj[i].value,1);
							temp=0;
							break;
						}
	
						
						if(i==(checkBoxObj.length-1)) 
						{
						    temp=1;
						}
					}					
				}       
				
				document.form1.detail_code.value=maxCode;
				return;
		}	
		else if(qryType=="checkDetailCode")
		{
				var existNum = packet.data.findValueByName("existNum");

				if(parseInt(existNum)==0)
			    {
				   togetherMode();
				}else
			    {
					 rdShowMessageDialog("此优惠代码已经存在，请重新输入",0);
					 return;
				}

				return;
		}	
 }	


//判断输入的是否为中文	
function ischinese()
{
 	var ret=false;
 	var s=document.all.detail_code.value;
 	for(var i=0;i<s.length;i++)
 	{
 	 	ret=(s.charCodeAt(i)>=10000);
 	 	if(ret==true)
 	 	{
 	 		rdShowMessageDialog("请勿在优惠代码框中输入中文！",0);
 	 		document.all.detail_code.focus();
 	 		return;
 	 	}
 	}
}  

//当优惠类型修改时优惠代码为空
function ChangeDetailType()
{
	document.form1.detail_code.value="";
}

//选择优惠代码
function queryDetailCode()
{
	if(document.form1.detail_type.value!="")
	{
		var retToField = "detail_code|note|";
		if(document.form1.detail_type.value=='0')
		{
			var url = "f5238_queryRateCode.jsp?detail_type="+document.form1.detail_type.value+"&region_code=<%=region_code%>&retToField="+retToField;
			window.open(url,'','height=600,width=500,scrollbars=yes');
		}
		else if(document.form1.detail_type.value=='1')
		{
			var url = "f5238_queryMonthCode.jsp?detail_type="+document.form1.detail_type.value+"&region_code=<%=region_code%>&retToField="+retToField;
			window.open(url,'','height=600,width=500,scrollbars=yes');
		}
		else if(document.form1.detail_type.value=='9')
		{
			var url = "f5238_queryMonthCode.jsp?detail_type="+document.form1.detail_type.value+"&region_code=<%=region_code%>&retToField="+retToField;
			window.open(url,'','height=600,width=500,scrollbars=yes');
		}
		else if(document.form1.detail_type.value=='2')
		{
			var url = "f5238_queryTotCode.jsp?detail_type="+document.form1.detail_type.value+"&region_code=<%=region_code%>&retToField="+retToField;
			window.open(url,'','height=600,width=800,scrollbars=yes');
		}
		else if(document.form1.detail_type.value=='b')
		{
			var url = "f5238_queryTotCode.jsp?detail_type="+document.form1.detail_type.value+"&region_code=<%=region_code%>&retToField="+retToField;
			window.open(url,'','height=600,width=800,scrollbars=yes');
		}
		else if(document.form1.detail_type.value=='4')
		{
			var url = "f5238_queryFuncFav.jsp?detail_type="+document.form1.detail_type.value+"&region_code=<%=region_code%>&retToField="+retToField+"&sm_code="+document.form1.sm_code.value;
			window.open(url,'','height=600,width=500,scrollbars=yes');
		}
		else if(document.form1.detail_type.value=='Y')
		{
			var url = "f5238_queryOneRateCode.jsp?detail_type="+document.form1.detail_type.value+"&region_code=<%=region_code%>&retToField="+retToField;
			window.open(url,'','height=600,width=500,scrollbars=yes');
		}
		else if(document.form1.detail_type.value=='3')
		{
			var url = "f5238_queryBillFav.jsp?detail_type="+document.form1.detail_type.value+"&region_code=<%=region_code%>&retToField="+retToField;
			window.open(url,'','height=600,width=500,scrollbars=yes');
		}
		else if(document.form1.detail_type.value=='a')
		{
			var url = "f5238_queryFuncBind.jsp?detail_type="+document.form1.detail_type.value+"&region_code=<%=region_code%>&retToField="+retToField+"&sm_code=<%=sm_code%>";
			window.open(url,'','height=600,width=480,scrollbars=yes');
		}
	}
	else
	{
		rdShowMessageDialog("请先选择优惠类型！",0);
		document.form1.query_regioncode.focus();
	}
}

//校验优惠明细是否重复
function  checkDetail()
{
	if(document.all.time_cycle.value<0)
	{
		rdShowMessageDialog("计费周期只能输入正整数！",0);
		document.form1.time_cycle.focus();
		return;
	}
	if(!checkElement(document.form1.fav_order)) 
	{
		document.all.fav_order.focus();
		return;
	}
    //校验当前页面是否有重复
	var checkBoxObj = document.getElementsByName("checkBox1");
	var detailCodeObj = document.getElementsByName("detail_codes");
	var detailTypeObj = document.getElementsByName("detail_types");

	var detail_type = document.form1.detail_type.value;
	var detail_code = document.form1.detail_code.value;

	for(var i=0;i<checkBoxObj.length;i++)
	{
	    if(checkBoxObj[i].checked && detail_type==detailTypeObj[i].value && detail_code==detailCodeObj[i].value)
		{
		    rdShowMessageDialog("优惠明细存在重复！",0);
			return false;
		}
	}
 
	
	togetherMode();
}

//组合产品在下面显示出来
function togetherMode()
{
 
	var hasY=0;
  if(document.all.checkbox1==undefined)
  {
  }
	else if(document.all.checkbox1.length==undefined)
	{
		if(document.all.mode_times.value=="Y")
		{
			hasY=1;
		}
		
		if((document.all.detail_codes.value==document.form1.detail_code.value)&&(document.all.detail_types.value==document.form1.detail_type.value))
		{
			rdShowMessageDialog("相同的优惠类型下优惠代码不能重复！",0);
			document.form1.detail_code.focus();
			return;
		}
		
		if(document.all.fav_orders.value==document.form1.fav_order.value)
		{
			rdShowMessageDialog("优惠顺序不能重复！",0);
			document.form1.fav_order.focus();
			return;
		}
		
	}
	else if(document.all.checkbox1.length>0)
	{
		for(var i=0;i<document.all.checkbox1.length;i++)
		{
				if(document.all.mode_times[i].value=="Y" && document.all.checkbox1[i].checked)
				{
					hasY=1;
				}
				if(document.all.checkbox1[i].checked && (document.all.detail_codes[i].value==document.form1.detail_code.value)&&(document.all.detail_types[i].value==document.form1.detail_type.value))
				{
					rdShowMessageDialog("相同的优惠类型下优惠代码不能重复！",0);
					document.form1.detail_code.focus();
					return;
				}
				if(document.all.fav_orders[i].value==document.form1.fav_order.value)
				{
					rdShowMessageDialog("优惠顺序不能重复！",0);
					document.form1.fav_order.focus();
					return;
				}
		}
	}	
		
	if(document.form1.mode_time.value=="Y"&&hasY==1)
	{
		rdShowMessageDialog("生命周期标志必须有且只能有一个选择【Y】！",0);
		document.form1.mode_time.focus();
		return;
	}


	var rows = document.getElementById("mainFour").rows.length;
	var newrow = document.getElementById("mainFour").insertRow(rows);
	newrow.height="20";
	newrow.align="left";
 
	newrow.insertCell(0).innerHTML ='<input type="checkbox" name="checkbox1" checked onClick="del(this)">';
	newrow.insertCell(1).innerHTML ='<input type="text" name="detail_codes" size="6"  readonly   Class=InputGrey value="'+ document.form1.detail_code.value +'">';
	newrow.insertCell(2).innerHTML ='<input type="text" name="detail_type_names" size="8"  readonly   Class=InputGrey value="'+ document.form1.detail_type.options[document.form1.detail_type.selectedIndex].text +'">'
      +'<input type="hidden" name="detail_begin_times"   value="'+ document.form1.detail_begin_time.value +'">'
      +'<input type="hidden" name="detail_end_times"  value="'+ document.form1.detail_end_time.value +'">';
	newrow.insertCell(3).innerHTML ='<input type="text" name="fav_orders" size="1"  readonly   Class=InputGrey value="'+ document.form1.fav_order.value +'">';
	newrow.insertCell(4).innerHTML ='<input type="text" name="mode_times" size="1"  readonly   Class=InputGrey value="'+ document.form1.mode_time.value +'">';
	newrow.insertCell(5).innerHTML ='<input type="text" name="time_flags" size="1"  readonly   Class=InputGrey value="'+ document.form1.time_flag.value +'">';
	newrow.insertCell(6).innerHTML ='<input type="text" name="time_cycles" size="4"  readonly   Class=InputGrey value="'+ document.form1.time_cycle.value +'">';
	newrow.insertCell(7).innerHTML ='<input type="text" name="time_units" size="1"  readonly   Class=InputGrey value="'+ document.form1.time_unit.value +'">';
	newrow.insertCell(8).innerHTML ='<input type="text" name="notes" size="29"  readonly   Class=InputGrey value="'+ document.form1.note.value 
									+'"><input type="hidden" name="detail_types" value="'+ document.form1.detail_type.value 
									+'"><input type="hidden" name="apply_flags"  value="'+ document.form1.apply_flag.value +'">';


   /*清空相关域*/
   document.form1.detail_code.value="";
   document.form1.fav_order.value="";
   document.form1.note.value="";

   var max = 0;
   max = getMaxFavOrder();/*得到最大的优惠顺序*/
   
   document.form1.fav_order.value =Math.round(max)+1;

}

function getMaxFavOrder()
{
    var fav_orders = new Array();
	var checkBoxObj = document.getElementsByName("checkBox1");
	var favOrderObj = document.getElementsByName("fav_orders"); 

    var i=0,j=0;
	for(i=0;i<checkBoxObj.length;i++)
	{
	    if(checkBoxObj[i].checked)
		{
		    fav_orders[j]=favOrderObj[i].value;
			j++;
		}
	}

    var temp1=0,max=0;
	for(i=0;i<fav_orders.length;i++)
	{
		if(Math.round(temp1)>Math.round(fav_orders[i]))
		{
		}else
		{
		    temp1=fav_orders[i];
		}
	}

	max= temp1;
	return max;
}

//提交到下一页
function submitAdd()
{
	var detail_codes = new Array();
	var detail_types = new Array();
	var begin_times = new Array();
	var end_times = new Array();
	var mode_times = new Array();
	var time_flags = new Array();
	var time_cycles = new Array();
	var time_units = new Array();
	var notes = new Array();
	var apply_flags = new Array();
	var fav_orders = new Array();
	
	if(document.all.checkbox1==undefined)
	{
		rdShowMessageDialog("没有组成的产品！",0);
		return;
	}
	else if(document.all.checkbox1.length==undefined)
	{
		if(document.all.checkbox1.checked)
		{		  
		  	document.form1.detail_codes_array.value=document.all.detail_codes.value;
		  	document.form1.detail_types_array.value=document.all.detail_types.value;
		  	document.form1.begin_times_array.value=document.all.detail_begin_times.value;
		  	document.form1.end_times_array.value=document.all.detail_end_times.value;
		  	document.form1.mode_times_array.value=document.all.mode_times.value;
		  	document.form1.time_flags_array.value=document.all.time_flags.value;
		  	document.form1.time_cycles_array.value=document.all.time_cycles.value;
		  	document.form1.time_units_array.value=document.all.time_units.value;
		  	document.form1.notes_array.value=document.all.notes.value;
		  	document.form1.apply_flags_array.value=document.all.apply_flags.value;
			document.form1.fav_orders_array.value=document.all.fav_orders.value;
		}
		else
		{
			rdShowMessageDialog("没有组成的产品！",0);
			return;
		}
	}
	else if(document.all.checkbox1.length>0)
	{
		var j=0;
		for(var i=0;i<document.all.checkbox1.length;i++)
		{
			if(document.all.checkbox1[i].checked)
			{	
				detail_codes[j]=document.all.detail_codes[i].value;
				detail_types[j]=document.all.detail_types[i].value;
				begin_times[j]=document.all.detail_begin_times[i].value;
				end_times[j]=document.all.detail_end_times[i].value;
				mode_times[j]=document.all.mode_times[i].value;
				time_flags[j]=document.all.time_flags[i].value;
				time_cycles[j]=document.all.time_cycles[i].value;
				time_units[j]=document.all.time_units[i].value;
				document.all.notes[i].value=document.all.notes[i].value.replace(",","##");
				notes[j]=document.all.notes[i].value;
				apply_flags[j]=document.all.apply_flags[i].value;
				fav_orders[j]=document.all.fav_orders[i].value;
				j++;
			}	
		}
		document.form1.detail_codes_array.value=detail_codes;
		document.form1.detail_types_array.value=detail_types;
		document.form1.begin_times_array.value=begin_times;
		document.form1.end_times_array.value=end_times;
		document.form1.mode_times_array.value=mode_times;
		document.form1.time_flags_array.value=time_flags;
		document.form1.time_cycles_array.value=time_cycles;
		document.form1.time_units_array.value=time_units;
		document.form1.notes_array.value=notes;
		document.form1.apply_flags_array.value=apply_flags;
		document.form1.fav_orders_array.value=fav_orders;
		if(j==0)
		{
			rdShowMessageDialog("没有组成的产品！",0);
			return;
		}
	}
	
	//判断生命周期至少有一个是Y
	var hasY=0;
  if(document.all.checkbox1==undefined)
  {
  }
	else if(document.all.checkbox1.length==undefined)
	{
		if(document.all.mode_times.value=="Y")
		{
			hasY=hasY+1;
		}
	}
	else if(document.all.checkbox1.length>0)
	{
		for(var i=0;i<document.all.checkbox1.length;i++)
		{
				if(document.all.mode_times[i].value=="Y" && document.all.checkbox1[i].checked)
				{
					hasY=hasY+1;
				}
		}
	}	
			
	if(hasY != 1)
	{
		rdShowMessageDialog("优惠明细中的生命周期标志必须有且只能有一个选择【Y】！",0);
		return;
	}


	document.form1.page_flag.value="0";
	document.form1.action="f5238_3.jsp"; 
	document.form1.submit();
}

//优惠代码的获取方式
function doDetailCodeType1()
{
	var detail_type = document.form1.detail_type.value;

	document.form1.detail_code.value="";
	document.form1.detail_code.readOnly=false;
	document.form1.query_detailcode.disabled=true;
	document.form1.apply_flag.value="0";

	if((detail_type!="Y") && (detail_type!="a"))
	{
	  getDetailCode();
	}
}

function del(obj,detail_code,type_name)
{
 if(rdShowConfirmDialog("是否删除此组合？")=="1")
	{
	var args=del.arguments[0];
	var objTD =args.parentElement;
	var objTR =objTD.parentElement;
	var currRowIndex = objTR.rowIndex;
	mainFour.deleteRow(currRowIndex);
	}
	else{
	del.arguments[0].checked=true;	
	}
}

function doDetailCodeType2()
{
	document.form1.detail_code.value=""; 
	document.form1.detail_code.readOnly=true;
	document.form1.query_detailcode.disabled=false;
	document.form1.apply_flag.value="Y";
}
function StrAdd(AddType, SrcStr, Value)
{
	//AddType 0值加1， 1:模加1
	var BaseStr ="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	//var BaseStr ="0123456789";
	var S = "";
	var CurPos = 0, PrePos = 0, SrcLen=0,BaseLen=0, Index=0;
	var isCarry = 0;
	
	SrcLen= SrcStr.length;
	BaseLen=BaseStr.length;
	isCarry = Value % BaseLen;
	for(  CurPos = SrcLen - 1; CurPos >= 0; CurPos --)
	{
		if (isCarry != 0)
		{
			Index = BaseStr.indexOf(SrcStr.charAt(CurPos)) + isCarry;
			if (Index < -1)
			{
				return "";
			}
			if (Index > BaseLen - 1)
			{
				isCarry = 1;
				S = BaseStr.charAt(Index - BaseLen) + S;
			}
			else
			{
				isCarry = 0;
				S = SrcStr.substring(0, CurPos) + BaseStr.charAt(Index) + S;
				break;
			}
			if (CurPos == 0 && AddType == 0) S = BaseStr.charAt(0) + S;
		}
		else
		{
			break;
		}
		
	}
	return S;
}
function getDetailCode()
{	
	var myPacket = new AJAXPacket("f5238_getDetailCode_rpc.jsp","正在提交，请稍候......");
	myPacket.data.add("detail_type",document.form1.detail_type.value);
	myPacket.data.add("rpcType","getDetailCode");
	myPacket.data.add("region_code",document.form1.region_code.value);
	myPacket.data.add("sm_code",document.form1.sm_code.value);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}



//返回到上一页
function submitback()
{
	window.location="f5238_1.jsp?login_accept=<%=login_accept%>";
}
</script>
</head>

<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
 
	  <form name="form1"  method="post">
	  	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">个人产品配置-配置产品明细</div>
	</div>

	  	<input type="hidden" name="login_accept" value="<%=login_accept%>">
	  	<input type="hidden" name="mode_code" value="<%=mode_code%>">
	  	<input type="hidden" name="mode_name" value="<%=mode_name%>">
	  	<input type="hidden" name="region_code" value="<%=region_code%>">
	  	<input type="hidden" name="sm_code" value="<%=sm_code%>">
	  	<input type="hidden" name="begin_time" value="<%=begin_time%>">
	  	<input type="hidden" name="end_time" value="<%=end_time%>">
	  	<input type="hidden" name="detail_codes_array" >
	  	<input type="hidden" name="detail_types_array" >
	  	<input type="hidden" name="begin_times_array" >
	  	<input type="hidden" name="end_times_array" >
		<input type="hidden" name="fav_orders_array" >
	  	<input type="hidden" name="mode_times_array" >
	  	<input type="hidden" name="time_flags_array" >
	  	<input type="hidden" name="time_cycles_array" >
	  	<input type="hidden" name="time_units_array" >
	  	<input type="hidden" name="notes_array" >
	  	<input type="hidden" name="apply_flags_array" >
	  	<input type="hidden" name="page_flag" value="">
	  		  	<TABLE id="mainOne" cellspacing="0" >
	            <TBODY>
 
	  	        	<TR  >
	  					<TD width="23%" valign="top" rowspan="2">
	  						<table    id="mainTwo"  cellspacing="0" >
	  							<tr  height="25">
	  								<TD >&nbsp;&nbsp;&nbsp;&nbsp;产品配置步骤</b></TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;1.配置产品代码</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;<font class="orange">2.配置产品明细</font></TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;3.资费规则配置</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;4.开关机配置</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;5.产品关系配置</TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD>&nbsp;&nbsp;&nbsp;&nbsp;6.完成</TD>
	  							</tr>
	  						</table>
	  					</TD>
	  					<TD width="77%">
	  						<table id="mainThree"  cellspacing="0"  >
	  							<tr  height="22">
	  								<TD width="30%" class="blue">&nbsp;&nbsp;当前配置流水号</TD>
	  								<TD width="67%"><font class="orange"><%=login_accept%></font></TD>
	  							</tr>
	  							<tr  height="22">
	  								<TD class="blue">&nbsp;&nbsp;产品代码</TD>
	  								<TD>
	  									<%=mode_code%>
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;优惠类型</TD>
	  								<TD>
	  									<select name="detail_type" v_name="优惠类型" onChange="ChangeDetailType()">
	  									<%
											//获取优惠类型
 											ArrayList retList1 = new ArrayList();  
											String sqlStr1="";
 											//sqlStr1 ="SELECT detail_type,type_name FROM sbilldetname where detail_type in('0','1','2','4','3','Y','a')";
 											sqlStr1 ="SELECT detail_type,detail_type||'->'||trim(type_name) FROM sbilldetname  order by detail_type ";

 											//retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
 											%>
 	 <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>		
 											
 											
 											<%
 											String[][] retListString1 = new String[][]{};
 											if(result_t3.length>0&&code2.equals("000000"))
 											retListString1 = result_t3;
											for(int i=0;i < retListString1.length;i ++)
											{
										%>
    		          							<option value='<%=retListString1[i][0]%>'><%=retListString1[i][1]%></option>
										<%		
											}
										%>
	  									</select>
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;优惠代码</TD>
	  								<TD>
	  									<input type=text  v_type="string"  v_must=1 v_minlength=4 v_maxlength=4 v_name="优惠代码"  name=detail_code maxlength=4 onblur="ischinese()">
										<input  type="button" class="b_text" name="query_detailcode" onclick="queryDetailCode()" value="选择" disabled>
										<input type="radio" name="detail_code_type" value="0" checked onClick="doDetailCodeType1()">输入
	  									<input type="radio" name="detail_code_type" value="Y" onClick="doDetailCodeType2()">选择
	  									<input type="hidden" name="apply_flag" value="0">
	  								</TD>
	  							</tr>
	  							<tr  style="display:none">
	  								<TD class="blue">&nbsp;&nbsp;开始时间</TD>
	  								<TD>
	  									<input type=text  v_type="date" v_must=1 v_minlength=1 v_maxlength=8   name=detail_begin_time maxlength=8 value="20070101" v_format="yyMMdd"></input>&nbsp;形式YYYYMMDD
	  								</TD>
	  							</tr>
	  							<tr  style="display:none">
	  								<TD class="blue">&nbsp;&nbsp;结束时间</TD>
	  								<TD>
	  									<input type=text  v_type="date" v_must=1 v_minlength=1 v_maxlength=8  name=detail_end_time maxlength=8 value="20500101" v_format="yyMMdd"></input>&nbsp;形式YYYYMMDD
	  								</TD>
	  							</tr>
								<tr >
	  								<TD class="blue">&nbsp;&nbsp;优惠顺序</TD>
	  								<TD>
	  									<input type=text  v_type="int"  v_must=1 v_minlength=0 v_maxlength=3    name=fav_order maxlength=3 value=""></input>			
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;生命周期标志</TD>
	  								<TD>
	  									<select name="mode_time" v_name="生命周期标志">
	  										<option value='N'>N->否</option>
	  										<option value='Y'>Y->是</option>	  										
	  									</select>
	  								</TD> 
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;计费时间标志</TD>
	  								<TD>
	  									<select name="time_flag" v_name="计费时间标志">
	  										<option value='0'>0->绝对时间</option>
	  										<option value='1'>1->相对结束</option>
	  									</select>
	  								</TD>
	  							</tr>
	  								<tr >
	  								<TD class="blue">&nbsp;&nbsp;计费单位</TD>
	  								<TD>
	  									<select name="time_unit" v_name="计费单位">
	  										<option value='0'>0->天</option>
	  										<option value='1'>1->月</option>
	  										<option value='2'>2->年</option>
	  									</select>
	  								</TD>
	  							</tr>
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;计费周期</TD>
	  								<TD>
	  									<input type=text  v_type="int"  v_must=1 v_minlength=0 v_maxlength=5 v_name="计费周期"  name=time_cycle maxlength=5 value="0"></input>
	  									<font class="orange">正整数</font>
	  								</TD>
	  							</tr>

	  							
	  							<tr >
	  								<TD class="blue">&nbsp;&nbsp;优惠描述</TD>
	  								<TD>
	  									<input type=text  v_type="string2" v_must=1 v_minlength=0 v_maxlength=60 v_name="优惠描述" name=note maxlength=60></input>
	  								</TD>
	  							</tr>
	  							<TR >
	  								<TD height="30" align="center" colspan="2">
	          					 	    <input name="lastButton" class="b_text"  type="button"  value="组成产品" onClick="if (check(form1)) checkDetail()">
	          					 	    &nbsp;
	          					 	    <input name="nextButton" class="b_text"  type="button"  value="清除" onClick="reset()" >
	          					 	    &nbsp;
	  								</TD>
	  							</TR>
	  						</table>
	  					</TD>
	  	        	</TR> 
	            </TBODY>
	          	</TABLE>
	          	<table id="mainFour"  cellspacing="0" >
	  				<tr  height="22">
	  					<Th width="4%">选择</Th>
	  					<Th width="8%">优惠代码</Th>
	  					<Th width="8%">优惠类型</Th>
	  				<!--	<TD width="8%">开始时间</TD>
	  					<TD width="8%">结束时间</TD>
					-->
						<Th width="8%">优惠顺序</Th>
	  					<Th width="8%">生命周期标志</Th>
	  					<Th width="8%">计费时间标志</Th>
	  					<Th width="8%">计费周期</Th>
	  					<Th width="8%">计费单位</Th>
	  					<Th width="28%">优惠描述</Th>	
	  				</tr>
	  				<%
	  					for(int i=0;i<result.length;i++)
						{
					%> 
						<tr height="20"> 
							<td height="20"><input type="checkbox" name="checkbox1" checked onClick="del(this)"></td>
                			<td height="20"><input type="text" name="detail_codes" size="6"  readonly   Class=InputGrey value="<%=result[i][0]%>"></td>
                			<td height="20"><input type="text" name="detail_type_names" size="8"  readonly   Class=InputGrey value="<%=result[i][2]%>">
							<input type="hidden" name="detail_begin_times"  value="<%=result[i][9]%>">
							<input type="hidden" name="detail_end_times"  value="<%=result[i][10]%>"></td>
							<td height="20"><input type="text" name="fav_orders" size="2"  readonly   Class=InputGrey value="<%=result[i][3]%>">
                			<td height="20"><input type="text" name="mode_times" size="2"  readonly   Class=InputGrey value="<%=result[i][4]%>"></td>
                			<td height="20"><input type="text" name="time_flags" size="2"  readonly   Class=InputGrey value="<%=result[i][5]%>"></td>
                			<td height="20"><input type="text" name="time_cycles" size="7"  readonly   Class=InputGrey value="<%=result[i][6]%>"></td>
                			<td height="20"><input type="text" name="time_units" size="2"  readonly   Class=InputGrey value="<%=result[i][7]%>"></td>
                			<td height="20"><input type="text" name="notes" size="29"  readonly   Class=InputGrey value="<%=result[i][8]%>">
                							<input type="hidden" name="detail_types" size="30"  readonly   Class=InputGrey value="<%=result[i][1]%>">
                							<input type="hidden" name="apply_flags" size="30"  readonly   Class=InputGrey value="<%=result[i][11]%>"></td>	
			    		</tr>
			    	<%
						}	
					%>
	  			</table>
	          	<TABLE cellSpacing="0" >
	  			  <TR >
	  				<TD height="30" align="center" id="footer"> 
	          	 	    <input name="lastButton" type="button" class="b_foot" value="上一步" onClick="submitback()">
	          	 	    &nbsp;
	          	 	    <input name="nextButton" type="button" class="b_foot"  value="下一步" onClick="submitAdd()" >
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  			<BR>
	  			<BR>		
	  		</TD>
	  	</TR>
	  	<%@ include file="/npage/include/footer.jsp" %>
	  </form>
	  </TABLE>
	</TD>
  </TR>
</TABLE>
</body>
</html>

