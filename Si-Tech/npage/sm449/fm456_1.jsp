<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)[2017/3/7 星期二 11:17:00]------------------
 
 
 -------------------------后台人员：[liyang]--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");

	System.out.println("-------douming---------opName----------555111115555------>"+opName);
        
  String countTotalSql = "select store_money from sstoretype where substr(store_type,1,1) = 'd' order by store_money asc";
         
%>   

  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=countTotalSql%>" />
	</wtc:service>
	<wtc:array id="result_countTotal" scope="end"    />
		

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>


//重置刷新页面
function reSetThis(){
	  location = location;	
}


function go_Cfm(){
 		
		if(!check(msgFORM)) return false;
		
		if($("#ipt_Count").val().trim().length<2){
			  rdShowMessageDialog("购卡数量不能小于10");
			  return;
		}
		
    var packet = new AJAXPacket("fm456_Cfm.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("sel_CountTotal",$("#sel_CountTotal").val());//
        packet.data.add("sel_ChannelType",$("#sel_ChannelType").val());//
        packet.data.add("sel_CardType",$("#sel_CardType").val());//
        packet.data.add("sel_Payment",$("#sel_Payment").val());//
        packet.data.add("ipt_IDValue",$("#ipt_IDValue").val());//
        packet.data.add("ipt_Count",$("#ipt_Count").val());//
        packet.data.add("ipt_Publickey",$("#ipt_Publickey").val());//
        packet.data.add("ipt_Barepublickey",$("#ipt_Barepublickey").val());//
        	
    core.ajax.sendPacket(packet,do_Cfm);
    packet =null;	 	
}

function do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//操作成功
    	rdShowMessageDialog("操作成功，请等待查询结果",2);
    	var res_accept =  packet.data.findValueByName("res_accept");
    	$("#span_accept").text(res_accept);
    	
    	$("#div_qry").hide();
    	$("#div_result").show();
    }
}


function go_QryFiel(){
    var packet = new AJAXPacket("fm456_QryFiel.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("res_accept",$("#span_accept").text().trim());//
        
    core.ajax.sendPacket(packet,do_QryFiel);
    packet =null;	 	
	
}

function do_QryFiel(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//操作成功
    	rdShowMessageDialog("查询成功，点击流水进行下载",2);
    	var j_fileName =  packet.data.findValueByName("fileName");
    	
    	j_fileName = "20170303113638.txt";//写死测试
    	
    	$("#btn_QryFiel").attr("disabled","disabled");
    	var acceptText = $("#span_accept").text().trim();
    	$("#btn_QryFiel").parent().prev().html("<a href='javascript:void(0)' onclick='go_downFile(\""+j_fileName+"\")'>"+acceptText+"</a>");
    }
}

function go_downFile(j_fileName){
	 document.msgFORM.action="fm456_DownFile.jsp?opCode=<%=opCode%>&opName=<%=opName%>&j_fileName="+j_fileName;
 	 document.msgFORM.submit();	
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	


<div id="div_qry" >
<div class="title"><div id="title_zi"><%=opName%></div></div>

<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">用户类型</td>
		  <td width="35%">
			    <select id="sel_ChannelType" name="sel_ChannelType"  >
					    <option value="10">社会代理渠道</option>
					    <option value="11">集团客户渠道</option>
					</select>
		  </td>
		  <td class="blue" width="15%">卡业务种类</td>
		  <td>
			   <select id="sel_CardType" name="sel_CardType"  >
					    <option value="00">话费充值卡</option>
						</select>  
		  </td>
	</tr>

	<tr>
	    <td class="blue" width="15%">面额</td>
		  <td width="35%">
		  	<select id="sel_CountTotal" name="sel_CountTotal" >
<%
					for(int i=0;i<result_countTotal.length;i++){
%>					
						<option value="<%=result_countTotal[i][0]%>"><%=result_countTotal[i][0]%></option>
<%					
					}
%>		  		
				</select>
		  </td>
		  <td class="blue" width="15%">支付方式</td>
		  <td>
			   <select id="sel_Payment" name="sel_Payment"  >
					    <option value="0">现金支付</option>
						</select>  
		  </td>
	</tr>
	
	<tr>
	    <td class="blue" width="15%">购卡手机号码</td>
		  <td width="35%">
			    <input type="text" id="ipt_IDValue" name="ipt_IDValue" value="13704500050"  v_must="1" v_type="mobphone"  maxlength="11" onblur = "checkElement(this)"  />
		  </td>
		  <td class="blue" width="15%">购卡数量</td>
		  <td>
			    <input type="text" id="ipt_Count" name="ipt_Count" value="50"  v_must="1" v_type="0_9"  onblur = "checkElement(this)"  />
		  </td>
	</tr>	
	
		<tr>
	    <td class="blue" width="15%">裸公钥</td>
		  <td colspan="3">
		  	<input type="text" id="ipt_Barepublickey" name="ipt_Barepublickey" v_must="1"   />
		  </td>
		</tr>	
		
		<tr>
	    <td class="blue" width="15%">公钥</td>
		  <td colspan="3">
		  	<input type="text" id="ipt_Publickey"     name="ipt_Publickey"    v_must="1"   />
		  </td>
		</tr>	
			
</table>
</div>

<div id="div_result" style="display:none">
	<div class="title"><div id="title_zi">批量结果查询</div></div>	
	<table cellSpacing="0">
		<tr>
		    <td class="blue" width="25%">操作流水</td>
		    <td width="25%">
		    	<span id="span_accept"></span>
		    </td>	
		    <td id="td_qryFiel" >
		    	<input type="button" class="b_text" value="查询" id="btn_QryFiel" onclick="go_QryFiel()" />
		    </td>
	  </tr>
	</table>
</div>
  	    	
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定" onclick="go_Cfm()"            />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>