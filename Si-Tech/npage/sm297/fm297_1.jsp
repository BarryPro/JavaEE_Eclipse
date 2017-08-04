<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2015-8-19 13:35:58------------------
 关于7月下旬集团客户部CRM、BOSS系统需求的函--2、BOSS系统根据地市添加、删除成员的需求
 
 
 -------------------------后台人员：haoyy--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%

	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
	
	<wtc:service name="s3596InitEXC" outnum="12" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=workNo%>" />
		<wtc:param value="<%=activePhone%>" />
		<wtc:param value="<%=opCode%>" />
	</wtc:service>
	<wtc:array id="result_t" scope="end" />
<%
	
	String custName = "";
	String runState = "";
	String vregionCode = "";
	String vCustAddresee = "";
	String vIdIccid = "";
	String vSmName = "";
	if("000000".equals(code1)){
		custName     	= result_t[0][0];
		runState     	= result_t[0][1];
		vregionCode  	= result_t[0][2];
		vCustAddresee	= result_t[0][3];
		vIdIccid     	= result_t[0][4];
		vSmName      	= result_t[0][5];	
	}else{
%>
<SCRIPT language=JavaScript>
	rdShowMessageDialog("s3596InitEXC错误：<%=code1%>，<%=msg1%>");
	removeCurrentTab();
</SCRIPT>		
<%		
	}
	
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>
function changeOpFlag(){
	
	$("#extraOption").val("");
	$("#extraOption_hide").val("");
	$("#bizcode").val("");
	
	if(document.all.opFlag.value=="1"){//订购
		$("#tr_offer").show();
	}else if(document.all.opFlag.value=="2"){//取消订购
		$("#tr_offer").hide();
	}
} 

function getInfo_Mode(){
		if($("#bizcode").val()==""){
			rdShowMessageDialog("请选择业务名称");
			return;
		}
		var path = "fm297_2.jsp?p_id="+$("#bizcode").val()+"&opCode=<%=opCode%>";
    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
		return true;
}
function getmebProdCode(offer_id,offer_name){
	$("#extraOption").val(offer_id+"->"+offer_name);
	$("#extraOption_hide").val(offer_id);
	get_offer_comments(offer_id);
}

		

//取消订购时，选择业务名称后，判断手机号码是否办理了选择和交通业务：
function get_offer_comments(offer_id){
		var packet = new AJAXPacket("fm297_5.jsp","请稍后...");
        packet.data.add("offer_id",offer_id);
	    core.ajax.sendPacket(packet,doGet_offer_comments);
	    packet =null;
} 
function doGet_offer_comments(packet){
	  var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){ 
      rdShowMessageDialog(error_code+":"+error_msg,0);
	    return;
    }else{
    	var offer_comments =  packet.data.findValueByName("offer_comments");
    	$("#offer_comments").val(offer_comments);
    }		
}

    

//取消订购时，选择业务名称后，判断手机号码是否办理了选择和交通业务：
function changeBizcode(){
	//alert("document.all.opFlag.value = "+document.all.opFlag.value);
	if(document.all.opFlag.value=="2"&&$("#bizcode").val()!=""){//只有取消需要校验
		var packet = new AJAXPacket("fm297_4.jsp","请稍后...");
    		packet.data.add("phoneNo","<%=activePhone%>");
        packet.data.add("bizcode",$("#bizcode").val());
	    core.ajax.sendPacket(packet,doChangeBizcode);
	    packet =null;
  }
} 
function doChangeBizcode(packet){
	  var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){ 
      rdShowMessageDialog(error_code+":"+error_msg,0);
	    return;
    }else{ 
    	 var count_result =  packet.data.findValueByName("count_result");//返回信息
    	 
    	 //查询的退订可选资费数据
    	 var q_offer_id =  packet.data.findValueByName("q_offer_id");//返回信息
    	 var q_offer_name =  packet.data.findValueByName("q_offer_name");//返回信息
    	 var q_offer_comments =  packet.data.findValueByName("q_offer_comments");//返回信息
    	 
    	 $("#q_offer_id").val(q_offer_id);
    	 $("#q_offer_name").val(q_offer_name);
    	 $("#q_offer_comments").val(q_offer_comments);
    	 

    	 if("0"==count_result){
    	 	rdShowMessageDialog("该用户未办理选择的和交通业务");
    	 	$("#opFlag").val("");
    	 	$("#bizcode").val("");
    	 	$("#tr_offer").hide();
    	 }
    }
}



function printInfo(printType){
  
	 	var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  
	  
    
    cust_info+="手机号码：<%=activePhone%>"+"|";
    cust_info+="客户姓名：<%=custName%>" +"|";
  
    opr_info="业务受理时间: <%=currentDate%>"+" 用户品牌:<%=vSmName%>"+"|";
    opr_info+="业务类型: "+$("#opFlag option[checked=true]").text()+$("#bizcode option[checked=true]").text()+"流水：<%=sysAcceptl%>|";
    
     
     if(document.all.opFlag.value=="1"){//订购
	     opr_info+="本次申请可选套餐: "+$("#extraOption").val()+"|";
	     opr_info+="本次取消可选套餐: "+"|";
   	 }else if(document.all.opFlag.value=="2"){//取消订购
   	 		opr_info+="本次申请可选套餐: "+"|";
	      opr_info+="本次取消可选套餐: "+$("#q_offer_id").val()+"->"+$("#q_offer_name").val()+"|";
   	 }

			opr_info+="备注: "+"工号[<%=workNo%>]"+"办理"+document.all.opFlag.options[document.all.opFlag.selectedIndex].text+document.all.bizcode.options[document.all.bizcode.selectedIndex].text+"|";
			
    
   	if(document.all.opFlag.value=="1"){//订购
    	opr_info+="可选资费描述: "+$("#offer_comments").val()+"|";
    }else if(document.all.opFlag.value=="2"){//取消订购
    	opr_info+="可选资费描述: "+$("#q_offer_comments").val()+"|";
    }
    
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;

    
}

function showPrtdlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
	　var h=210;
	　var w=400;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
    
    // //var printStr = printInfo(printType);
    
     var pType="subprint";             
	   var billType="1";     
	   var sysAccept="<%=sysAcceptl%>";  
	   //alert(  sysAccept);
	   var printStr = printInfo(printType);            
	   var mode_code=null;              
	   var fav_code=null;                 
	   var area_code=null;            
     var opCode="<%=opCode%>"; 
     var phoneNo="<%=activePhone%>";
     
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_dz.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + "" + "&accInfoStr="+"";
   var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);

 
 
	 return ret;
}
function goSubmit(){
	
	  if(document.all.opFlag.value=="1"){//订购
	  	if($("#extraOption_hide").val()==""){
	  		rdShowConfirmDialog("请选择资费");
    		return;
	  	}
    }else if(document.all.opFlag.value=="2"){//取消订购
    	if($("#bizcode").val()==""){
	  		rdShowConfirmDialog("请选择业务名称");
    		return;
	  	}
    }else{
    	rdShowConfirmDialog("请选择操作类型");
    	return;
    }
	var ret = showPrtdlg("Detail","确实要进行电子免填单打印吗？","Yes");
  if(typeof(ret)!="undefined")
     {
        if((ret=="confirm"))
        {
          if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
          {
	          frmCfm();
          }
	      }
	      if(ret=="continueSub")
	      {
          if(rdShowConfirmDialog('确认要提交信息吗？')==1)
          {
	          frmCfm();
          }
	      }
   }
   else
   {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
	       frmCfm();
       }
    }
}


function frmCfm(){
		$("#sub_btn").attr("disabled",true);
    var packet = new AJAXPacket("fm297_3.jsp","请稍后...");
    
    		packet.data.add("sysAcceptl","<%=sysAcceptl%>");
    		packet.data.add("opCode","<%=opCode%>");
    		packet.data.add("phoneNo","<%=activePhone%>");
        packet.data.add("offerId",$("#extraOption_hide").val());
        packet.data.add("opFlag",$("#opFlag").val());
        packet.data.add("bizcode",$("#bizcode").val());
    core.ajax.sendPacket(packet,doCfm);
    packet =null;
}
//查询客户基础信息回调
function doCfm(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//操作成功
      rdShowMessageDialog(error_code+":"+error_msg,0);
	    return;
    }else{//调用服务失败
    	rdShowMessageDialog("操作成功",2);
    	removeCurrentTab();
    }
}

function reSetThis(){
	location = location ;
}
$(document).ready(function(){
		$("#tr_offer").hide();
});
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
	<input id="extraOption_hide" type="hidden" value="">
	<input id="offer_comments" type="hidden" value="">
    	 
	<input id="q_offer_id" type="hidden" value="">
	<input id="q_offer_name" type="hidden" value="">
	<input id="q_offer_comments" type="hidden" value="">
	
<div class="title"><div id="title_zi">和交通业务受理</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">手机号码</td>
		  <td colspan="3">
			    <%=activePhone%>
		  </td>
	</tr>
	<tr>
	    <td class="blue"  width="15%">客户名称</td>
		  <td width="35%">
			    <%=custName%>
		  </td>
		  <td class="blue" width="15%" >运行状态</td>
		  <td>
			    <%=runState%>
		  </td>
	</tr>
	
	<tr>
	    <td class="blue" >操作类型 </td>
		  <td>
		  	<SELECT name="opFlag"  id="opFlag"  onChange="changeOpFlag()">
		  		<option value="" >--请选择--</option>  
					<wtc:qoption name="sPubSelect" outnum="2">
						<wtc:sql>
						  SELECT FIELD_CODE3, FIELD_CODE3||'-->'|| FIELD_CODE4
						    FROM DBVIPADM.SCOMMONCODE
						   WHERE COMMON_CODE IN ('1012', '1013', '1014', '1015', '1016')
						     AND OP_CODE = '<%=opCode%>' order by FIELD_CODE3 asc
						</wtc:sql>
					</wtc:qoption>
				</SELECT>
		  </td>
		  <td class="blue" >业务名称</td>
		  <td>
		  	<select name="bizcode" id="bizcode" v_must="1" onChange="changeBizcode()"  >
					  <option value="" >--请选择--</option>  
						<wtc:qoption name="sPubSelect" outnum="2">
								<wtc:sql>
										SELECT b.id_no,b.user_name 
										FROM dcustmsg a,dgrpusermsg b
										WHERE substr(a.belong_code,1,2)=b.region_code
										AND b.sm_code='JT' AND b.run_code='A'
										AND a.phone_no='<%=activePhone%>'
								</wtc:sql>
						</wtc:qoption>
				</select>
		  </td>
	</tr>
	
		<tr id="tr_offer">
	    <td class="blue" >附加套餐 </td>
		  <td colspan="3">
		  		<input name="extraOption"  id="extraOption" size="54" maxlength="18" v_type="string"  v_name="附加套餐" index="1" value="" readonly >
					<input name=modeQuery type=button id="modeQuery" class="b_text" onClick="getInfo_Mode();"  value=选择 >
		  </td>
		</tr>
	
</table>
 

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确认" onclick="goSubmit()"    id="sub_btn"       />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>