<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 添加家庭成员
   * 版本: 1.0
   * 日期: 2013-4-28 13:42:44
   * 作者: hejwa
   * 版权: si-tech
   * update:
  */
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>  
<script type="text/javascript" src="/njs/jquery/interface.js"></script>
<head>
	<title>添加家庭成员</title>
</head>	
<%
	String phoneNo    = request.getParameter("memPhone");
	String custId     = request.getParameter("custId");
	String opCode     = request.getParameter("opCode");
	String opName     = request.getParameter("opName");
	String workNo     = (String)session.getAttribute("workNo");
	String passWord   = (String)session.getAttribute("passWord");
	String groupId    = (String)session.getAttribute("groupId");
	String regionCode = (String)session.getAttribute("regCode");
%>
 
<script language=javascript>
       
function submitFunc(){
	 if(rdShowConfirmDialog('确认要提交家庭成员信息吗？')!=1){
	 		return;
   }
   	var packet = new AJAXPacket("addMemberPhoneCfm.jsp","请稍后...");
		packet.data.add("opCode","<%=opCode%>");
		packet.data.add("opName","<%=opName%>");
		packet.data.add("masterFlag",$("#masterFlag").val());
		packet.data.add("userId",$("#userId").val());
		packet.data.add("custId",$("#custId").val());
		packet.data.add("phoneNo",$("#phoneNo").val());
		core.ajax.sendPacket(packet,doSubmitFunc);
		packet =null;
}
function doSubmitFunc(packet){
		var retCode   = packet.data.findValueByName("retCode");
		var retMsg    = packet.data.findValueByName("retMsg");
		if(retCode=="000000"){
			rdShowMessageDialog("添加成功",2);
			window.returnValue="1";
			window.close();
		}else{
			rdShowMessageDialog("添加失败"+retMsg,0);
		}
} 

function checkPwd(){
   if(document.all.passWord.value.length < 6){
		 rdShowMessageDialog("密码不能少于6位！");
		 document.all.passWord.focus();
	 	 return false;
	 }
   var passWord = document.frm.passWord.value;
   var checkPwd_Packet = new AJAXPacket("/npage/s4116/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
   checkPwd_Packet.data.add("retType","checkPwd");
   checkPwd_Packet.data.add("Pwd1",passWord);
   checkPwd_Packet.data.add("phone_no",document.frm.phoneNo.value);
   core.ajax.sendPacket(checkPwd_Packet,doCheckPwd,true);
   checkPwd_Packet = null;
}
  
function doCheckPwd(packet){
   var retType = packet.data.findValueByName("retType");
   var retCode = packet.data.findValueByName("retCode");
   var retMessage=packet.data.findValueByName("retMessage");
   if(retType == "checkPwd"){ //密码校验
		  if(retCode == "000000"){
		      var retResult = packet.data.findValueByName("retResult");
		      if(retResult == "false") {
		    	    rdShowMessageDialog("密码校验失败，请重新输入！",0);
		    	    frm.passWord.value = "";
		    	    return false;	        	
		      }else{
				    rdShowMessageDialog("密码校验成功！",2);
				    document.frm.b_submit.disabled = false;
		     }
		  }else{
		    rdShowMessageDialog("密码校验出错，请重新校验！",0);
			  return false;
		 }
	 } 
}	
</script>
<wtc:service name="sG645QryMemInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="5">
	  <wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="retList"  scope="end"/>
<%
    if("000000".equals(retCode1)){
        if(retList.length > 0) {
%>
<form  name="frm" method="POST">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">添加成员</div>
	</div>
<input type="hidden" id="opCode" name ="opCode" value="<%=opCode%>" />
<input type="hidden" id="opName" name ="opName" value="<%=opName%>" />
<input type="hidden" id="masterFlag" name="masterFlag" value="<%=retList[0][3]%>" />
<input type="hidden" id="userId" name ="userId" value="<%=retList[0][4]%>" />
<input type="hidden" id="custId" name ="custId" value="<%=custId%>" />
<table cellspacing="0">
	   
     <tr>
     	    <td class="blue"> 
               <div align="left">成员名称：</div>
          </td>
          <td> 
               <input id="custName"  name="custName" value="<%=retList[0][0]%>" readonly />
          </td>
          
          <td class="blue"> 
               <div align="left">家庭角色：</div>
          </td>
          <td> 
               <input id="homeRole" name="homeRole" value="<%if ("0".equals(retList[0][3])) {%>成员<%} else {%>责任人<%}%>" readonly />
          </td>
     	    
     </tr>
     <tr>
     			<td class="blue"> 
               <div align="left">成员号码：</div>
          </td>
          <td> 
               <input id="phoneNo"  name="phoneNo" value="<%=retList[0][2]%>" readonly />
          </td>
          <td class="blue"> 
               <div align="left">号码密码：</div>
          </td>
          <td> 
            <jsp:include page="/npage/common/pwd_1.jsp">
		          <jsp:param name="width1" value="16%"  />
		          <jsp:param name="width2" value="34%"  />
		          <jsp:param name="pname" value="passWord"  />
		          <jsp:param name="pwd" value="accountPasswd"  />
	            </jsp:include>
	        <input name="chkPass" type="button" onClick="checkPwd();" class="b_text" style="cursor:hand" id="chkPass" value=校验>
          <font class="orange">*</font>
          </td>
     	</tr>
     <tr>
     	    <td class="blue"> 
               <div align="left">号码品牌：</div>
          </td>
          <td> 
          	   <select id="smCode" name="smCode" disabled="disabled">
                  <wtc:pubselect name="sPubSelect" outnum="2" retcode="ret" retmsg="retm" routerKey="region" routerValue="<%=regionCode%>">
                          <wtc:sql>select distinct(SM_CODE),trim(SM_NAME) from sSmCode order by SM_CODE</wtc:sql>
                  </wtc:pubselect>
                  <wtc:iter id="rows" indexId="i">
                          <%if (rows[0].equals(retList[0][1])) {%>
                                <option selected="selected" value="<%=rows[0]%>">
                                	    <%=rows[0]%>---><%=rows[1]%>
                                </option>
                         <%} else {%>
                                 <option value="<%=rows[0]%>">
                                 	     <%=rows[0]%>--><%=rows[1]%>
                                 </option>
                         <%}%>
                  </wtc:iter>
               </select>
          </td>
     	     <td>&nbsp;</td>
     	     <td>&nbsp;</td>
     </tr>
     <table cellSpacing="0">
        <tr> 
          <td id="footer" >
              <input class="b_foot"  name="b_submit"   onclick="submitFunc();" type="button" value="提交" disabled />
			        <input class="b_foot"  name="b_close"    onclick="javascript:window.close();" type="button" value="关闭" />
			    </td>
        </tr>
    </table>
</table>
<%@ include file="/npage/include/footer.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
</form>
<%}else{
%>
<script>
	rdShowMessageDialog("错误代码："+retCode1+"<br>错误信息："+retMsg1,0);
	window.returnValue="0";
	window.close();
</script>
<%	
}
}else{
%>
<script>
	rdShowMessageDialog("没有查到相关记录",0);
	window.returnValue="0";
	window.close();
</script>
<%	
}
%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode1%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg1%>" />
