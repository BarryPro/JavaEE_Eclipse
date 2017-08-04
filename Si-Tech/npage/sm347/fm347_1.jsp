<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2015-12-14 9:45:39------------------
 关于进行一卡多号二期网状网接口联调相关需求
 
 
 -------------------------后台人员：jingang--------------------------------------------
 
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
	
	String cust_name = "";
  String cust_name_sql = " select b.cust_name "+
  											 " from dcustdoc b "+
 												 " where b.cust_id = "+
       									 " (select a.cust_id from dcustmsg a where a.phone_no = :phone_no) ";
	String cust_name_sql_param = "phone_no="+activePhone;       									 
	
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
		
		
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=cust_name_sql%>" />
		<wtc:param value="<%=cust_name_sql_param%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end"/>
		
<%
	if(result_t.length>0){
		cust_name = result_t[0][0];
	}
%>
	
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
	
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>


//重置刷新页面
function reSetThis(){
	  location = location;	
}

function show_iSubPhoneNo(){
	if($("#iCategory").val()=="1"){
		$("#iSubPhoneNo").removeAttr("readOnly");
		$("#iSubPhoneNo").removeClass("InputGrey");
	}else{
		$("#iSubPhoneNo").val("");
		$("#iSubPhoneNo").attr("readOnly","readOnly");
		$("#iSubPhoneNo").addClass("InputGrey");
	}
}

function get_iCategory(){
	  var packet = new AJAXPacket("fm347_2.jsp","请稍后...");
        packet.data.add("iChrgType",$("#iChrgType").val());
    core.ajax.sendPacket(packet,do_get_iCategory);
    packet =null;
}
function do_get_iCategory(packet){
	 var retArray = packet.data.findValueByName("retArray");//返回代码
	 $("#bizcode option[index!='0']").remove(); 
   for(var i=0;i<retArray.length;i++){
   		$("#bizcode").append("<option value='"+retArray[i][0]+"'>"+retArray[i][1]+"</option>"); 
   }
}

function go_cfm(){
	
	if($("#iCategory").val()=="1"&&$("#iSubPhoneNo").val().trim()==""){
		rdShowMessageDialog("请输入实体副号的手机号码");
		$("#iSubPhoneNo").focus();
		return;
	}else{
		if($("#iSubPhoneNo").val()=="<%=activePhone%>"){
			rdShowMessageDialog("副卡号码不能与主卡一致");
			$("#iSubPhoneNo").val("");
			$("#iSubPhoneNo").focus();
			return;
		}
	}
	
	
	
	if($("#iChrgType").val()==""){
		rdShowMessageDialog("请选择计费类型");
		return;
	}
	
	if($("#bizcode").val()==""){
		rdShowMessageDialog("请选择产品名称");
		return;
	}
	
	if(!check(msgFORM)) return false;
	
	    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
      if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
            frmCfm();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
            frmCfm();
          }
        }
      }else{
        if(rdShowConfirmDialog('确认要提交信息吗？')==1){
          frmCfm();
        }
      }
}

function frmCfm(){
	var packet = new AJAXPacket("fm347_3.jsp","请稍后...");
			packet.data.add("loginAccept","<%=loginAccept%>");
			packet.data.add("iPhoneNo","<%=activePhone%>");
			packet.data.add("opCode","<%=opCode%>");
      packet.data.add("iCategory",$("#iCategory").val());
      packet.data.add("iSubPhoneNo",$("#iSubPhoneNo").val());
      packet.data.add("iChrgType",$("#iChrgType").val());
      packet.data.add("bizcode",$("#bizcode").val());
      packet.data.add("opnote","BOSS系统发起虚拟副号申请："+$("#iCategory option:selected").text());
      
	    core.ajax.sendPacket(packet,do_frmCfm);
	    packet =null;
}
function do_frmCfm(packet){
	  var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code=="000000"){//操作成功
			rdShowMessageDialog("操作成功",2);      
			location = location;
	    return;
    }else{//调用服务失败
	    rdShowMessageDialog(error_code+":"+error_msg);
    }
}


    function showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
      var h=180;
      var w=350;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;		   	   
      var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
      var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
      var sysAccept =<%=loginAccept%>;             	//流水号
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
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
      cust_info+="客户姓名：   "+"<%=cust_name%>"+"|";
      
      opr_info +="业务名称：一卡多号主号申请副号    操作流水: "+"<%=loginAccept%>" +"|";
      
      
    	opr_info +="副号类型："+$("#iCategory option:selected").text();
    	opr_info +="    副号手机号码："+$("#iSubPhoneNo").val()+"|";
     
      opr_info +="计费类型："+$("#iChrgType option:selected").text()+"|";
      opr_info +="产品名称："+$("#bizcode option:selected").text()+"|";
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">业务数据</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">手机号码</td>
		  <td width="35%">
			     <%=activePhone%>
		  </td>
		  
		  <td class="blue" width="15%">客户姓名</td>
		  <td width="35%">
			    <%=cust_name%>
		  </td>
	</tr>
	
	<tr>
	    <td class="blue" width="15%">副号类型</td>
		  <td width="35%">
			    <select id="iCategory" onchange="show_iSubPhoneNo()" style="width:180px">
			    	<option value="1" selected>实体副号</option>
			    	<option value="0"         >虚拟副号</option>
			    </select>
		  </td>
		  
		  <td class="blue" width="15%">实体副号手机号码</td>
		  <td width="35%">
			    <input type="text" v_type="mobphone" maxlength="11" id="iSubPhoneNo" onblur="checkElement(this)" /><font class="orange">*</font> 
		  </td>
	</tr>
	
	<tr>
	  <td class="blue" width="15%">计费类型</td>
		  <td width="35%">
			    <select id="iChrgType" onchange="get_iCategory()" style="width:180px">
			    	<option value="" >--请选择--</option>
			    	<option value="0" >免费</option>
			    	<option value="1" >按次</option>
			    	<option value="2" >包月</option>
			    </select>
		  </td>
		  
		  <td class="blue" width="15%">产品名称</td>
		  <td width="35%">
			    <select id="bizcode" style="width:180px">
			    	<option value="" >--请选择--</option>
			    </select>
		  </td>
	</tr>
	
	
</table>

 

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定&打印" onclick="go_cfm()"            />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>