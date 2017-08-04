<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<head>
<title>宽带包年续签</title>
<%
    String opCode = (String)request.getParameter("opCode");
    String opName = (String)request.getParameter("opName");
  
	activePhone = WtcUtil.repNull((String)request.getParameter("activePhone"));
	String broadPhone = WtcUtil.repNull((String)request.getParameter("broadPhone"));
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
	
$(document).ready(function(){
	getPubSmCode("<%=broadPhone%>");
	var opCode = "<%=opCode%>";
	
	var smCode =  $("#pubSmCode").val();
	/*kh品牌的展示 m215-宽带包年续签包月 m216-铁通宽带主资费预约取消*/
	if(smCode == "kh"){
		
		$("input[@name='opFlag']").eq(2).show();
		$("input[@name='opFlag']").eq(3).show();
		$("input[@name='opFlag']").eq(2).next("span").show();
		$("input[@name='opFlag']").eq(3).next("span").show();
		/*e975-宽带包年续签冲正 隐藏*/
		$("input[@name='opFlag']").eq(1).hide();
		$("input[@name='opFlag']").eq(1).next("span").hide();
	}else{
		$("input[@name='opFlag']").eq(2).hide();
		$("input[@name='opFlag']").eq(3).hide();
		$("input[@name='opFlag']").eq(2).next("span").hide();
		$("input[@name='opFlag']").eq(3).next("span").hide();
		if(opCode == "m215" || opCode == "m216"){
			rdShowMessageDialog("该品牌宽带不能进行【宽带包年续签包月】和【铁通宽带主资费预约取消】操作！");
			removeCurrentTab();
		}
	}
	
	if(opCode == "e974"){
		$("input[@name='opFlag']").eq(0).attr("checked","checked");
		
	}else if(opCode == "e975"){
		$("input[@name='opFlag']").eq(1).attr("checked","checked");
		
	}else if(opCode == "m215"){
		$("input[@name='opFlag']").eq(2).attr("checked","checked");
		
	}else if(opCode == "m216"){
		$("input[@name='opFlag']").eq(3).attr("checked","checked");
	}
});

/*2014/04/04 11:02:20 gaopeng 调用公共查询返回品牌sm_code*/
function getPubSmCode(kdNo){
		var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","正在获得数据，请稍候......");
		getdataPacket.data.add("phoneNo","");
		getdataPacket.data.add("kdNo",kdNo);
		core.ajax.sendPacket(getdataPacket,doPubSmCodeBack);
		getdataPacket = null;
}
function doPubSmCodeBack(packet){
	retCode = packet.data.findValueByName("retcode");
	retMsg = packet.data.findValueByName("retmsg");
	smCode = packet.data.findValueByName("smCode");
	if(retCode == "000000"){
		$("#pubSmCode").val(smCode);
	}
}

//----------------验证及提交函数-----------------
function doCfm(subButton){
  if(!check(frm)) return false;
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++){
		if(radio1[i].checked){
			var opFlag = radio1[i].value;
			if(opFlag == "four"){
				frm.action="fe974Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
			}else if(opFlag == "five"){
				frm.action = "fe975Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			}else if(opFlag == "six"){
				/*宽带包年续签包月*/
				frm.action = "fm215Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			}else if(opFlag == "seven"){
				/*铁通宽带主资费预约取消*/
				frm.action = "fm216Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			}
		}
  }
  frm.submit();	
  return true;
}
function turnToOpcode(opCode,opName){
	window.location.href="/npage/se974/fe974.jsp?opCode="+opCode+"&opName="+opName+"&activePhone=<%=activePhone%>&broadPhone=<%=broadPhone%>";
}
</script>
</head>
<body>
	
<form name="frm" method="POST">
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
			
		</div>
		     
      <table cellspacing="0">        
	      <tr> 
          <td class="blue">操作类型</td>
          <td colspan="2">
				   <input type="radio" name="opFlag" value="four" onclick="turnToOpcode('e974','宽带包年续签')"><span>e974-宽带包年续签&nbsp;&nbsp;</span></input>
				 	 <input type="radio" name="opFlag" value="five" onclick="turnToOpcode('e975','宽带包年续签冲正')"><span>e975-宽带包年续签冲正&nbsp;&nbsp;</span></input>
				 	 <input type="radio" name="opFlag" value="six" onclick="turnToOpcode('m215','宽带包年续签包月')"><span>m215-宽带包年续签包月&nbsp;&nbsp;</span></input>
				 	 <input type="radio" name="opFlag" value="seven" onclick="turnToOpcode('m216','铁通宽带主资费预约取消')"><span>m216-铁通宽带主资费预约取消</span></input>				
          </td>
         </tr>
         <tr> 
            <td class="blue">宽带账号</td>
            <td>                
            	<input Class="InputGrey" readonly="readOnly" type="text" size="25" 
            		name="broadPhone" id="broadPhone" value="<%=broadPhone%>" />
							<input type="hidden" size="12" name="srv_no" 
								id="srv_no" value="<%=activePhone%>" />               
            </td>
            <td  class="blue" style="display:none"> 
                <div align="left">用户密码</div>
            </td>                     
			    <input type="hidden" Class="InputGrey" name="cus_pass" size="20" maxlength="8"> 		    				
         </tr>       
         <tr> 
            <td colspan="3"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">&nbsp;&nbsp;&nbsp;
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
              </div>
           </td>
        </tr>
        <input type="hidden" name="pubSmCode" id="pubSmCode" value=""/>
      </table>
    <%@ include file="/npage/include/footer.jsp" %>   
   </form>
</body>
</html>
