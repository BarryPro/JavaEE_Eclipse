<%
    /*************************************
    * 功  能: 集团客户密码变更 e801
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-4-26
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%

	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
  String opCode = "e801";
	String opName = "集团客户密码变更";
	
	String unitId = request.getParameter("unitId");//查询条件
	 System.out.println("--------------e801-----unitId="+unitId);
%>

	<wtc:service name="sGrpInfoQry"  outnum="16" retcode="errcode" retmsg="errmsg" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="0" />
	<wtc:param value="01" />
	<wtc:param value="e801" />
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="<%=unitId%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
		

	<wtc:service name="s5082ListEXC"  outnum="20" retcode="errcode1" retmsg="errmsg1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="0" />
	<wtc:param value="01" />
	<wtc:param value="e801" />
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="<%=unitId%>" />
	</wtc:service>
	<wtc:array id="result3" start="0" length="20" scope="end"/>
<%
	System.out.println("result3.length: "+result3.length);
	System.out.println("errcode: "+errcode);
	
%>
<HEAD>
  <TITLE>集团信息查询</TITLE>
</HEAD>
<script>
	function goBack(){
	  window.location.href="fe801_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
</script>
<% if (!"000000".equals(errcode) || result1[0][0].trim().equals("")) {%>
    <script language="javascript">
    	rdShowMessageDialog("没有找到任何数据");
    	window.location.href="fe801_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    </script>
<%}else{%>
<body>
<FORM method=post name="frme801_query">
<%@ include file="/npage/include/header.jsp" %>
<div id="Operation_Table">
  <div class="title">
  	<div id="title_zi">集团信息查询</div>
  </div>
  <table cellspacing="0">
    <tr>
      <th></th>
      <th>客户名称</th>
	    <th>产品名称</th>
      <th>集团编号（BOSS侧unit_id）</th>
      <th>产品账号</th>
      <th>产品号码</th>
      <th>客户经理</th>
      <th>产品资费名称</th>
    </tr>
  <%
	for(int y=0;y<result3.length;y++){
    String tdClass = "";
    if (y%2==0){
        tdClass = "Grey";
    }
  %>
	  <tr>
	    <td class="<%=tdClass%>"><input type="radio" id="queryRadio" name="queryRadio" value=""  v_idNo="<%=result3[y][1]%>" onclick="seleQryInfo(this)"  /></td>
	    <td class="<%=tdClass%>"><%=result1[0][1].equals("")?"&nbsp;":result1[0][1]%></td>
	    <td class="<%=tdClass%>"><%=result3[y][3].equals("")?"&nbsp;":result3[y][3]%></td>
	    <td class="<%=tdClass%>"><%=result1[0][0].equals("")?"&nbsp;":result1[0][0]%></td>
	    <td class="<%=tdClass%>"><%=result3[y][1].equals("")?"&nbsp;":result3[y][1]%></td>
	    <td class="<%=tdClass%>"><%=result3[y][2].equals("")?"&nbsp;":result3[y][2]%></td>
	    <td class="<%=tdClass%>"><%=result1[0][3].equals("")?"&nbsp;":result1[0][3]%></td>
	    <td class="<%=tdClass%>"><%=result3[y][10].equals("")?"&nbsp;":result3[y][10]%></td>
	   </tr>
  <%
    }
  %>
  </table>
</div>
<div>
  <div class="title">
    <div id="title_zi">选择操作类型</div>
  </div>
  <TABLE cellSpacing=0>
    <TR> 
        <td class="blue">操作类型</td>
        <td colspan="3">
            <input type="radio" name="operType" id="operTypeUpt" index="0" value="0"  onclick="changeType('0');" checked />修改密码
            <input type="radio" name="operType" id="operTypeCover" index="1" value="1"  onclick="changeType('1');" />重置密码
        </td>
    </TR>
    <TR> 
      <td class="blue">变更范围</td>
      <td>
        <select name="identityType" id="identityType" index="15" style="width:285px" onchange="cleanPass()" >
          <option value="00" selected >*请选择*</option>
          <option value="01">只修改集团客户密码</option>
          <option value="02">只修改集团用户密码</option>
          <option value="03">修改集团客户密码(包含集团和集团下所有产品密码)</option>
        </select>
        <font class="orange">*</font>
      </td>
      <td  class="blue">原密码</td>
      <td>
        <jsp:include page="/npage/common/pwd_8.jsp">
            <jsp:param name="width1" value="16%"  />
            <jsp:param name="width2" value="34%"  />
            <jsp:param name="pname" value="oldPassword"  />
            <jsp:param name="pwd" value=""  />
        </jsp:include>
        <input type='button' class='b_text' id='chkPass' name='chkPass' onClick='check_HidPwd()' value='校验' />
        <font class="orange">*</font>
      </td>
    </TR>
    <TR id="newPassTr"> 
      <td  class="blue">新密码</td>
      <td>
         <input name="newPassword1" type="password"  id="newPassword1" v_type="0_9"  value=""  />
      </td>
      <td  class="blue">新密码确认</td>
      <td>
         <input name="newPassword2" type="password"  id="newPassword2" v_type="0_9"  value=""  />
      </td>
    </TR>
  </TABLE>
  <table cellspacing=0>
    <tr id="footer"> 
      <td>
        <input class="b_foot" name="subUptBtn" id="subUptBtn" onClick="subUptPass()" type="button" value="确认" />
        <input class="b_foot" name="back" onClick="goBack()" type="button" value="返回" />
        <input class="b_foot" name="back" onClick="removeCurrentTab()" type="button" value="关闭" />
      </td>
    </tr>
  </table>
</div>
<jsp:include page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script language="javascript">
  window.onload=function(){
    $("#subUptBtn").attr("disabled","true");
  }
  
  /*校验原密码*/
  function check_HidPwd(){
    var cust_id = "<%=result1[0][10]%>";
    var oldPassword = $("input[name='oldPassword']").val();
    
    var identityTypes = document.getElementById("identityType");
    var identityTypeVal;
    for(i=0;i<identityTypes.length;i++){            
      if(identityTypes[i].selected==true){             
        identityTypeVal = identityTypes[i].value;               
      }   
    }
    
    if(oldPassword==""){
      rdShowMessageDialog("请输入原密码！",1);
  	  return false;
    }
    if(identityTypeVal=="00"){
      rdShowMessageDialog("请选择变更范围！",1);
      return false;
    }
    
    /*校验集团客户密码*/
    if((identityTypeVal=="01")||(identityTypeVal=="03")){ 
      var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
      checkPwd_Packet.data.add("custType","02");				//01:手机号码 02 客户密码校验 03帐户密码校验
      checkPwd_Packet.data.add("phoneNo",cust_id);	    //移动号码,客户id,帐户id
      checkPwd_Packet.data.add("custPaswd",oldPassword);	      //用户/客户/帐户密码
  		checkPwd_Packet.data.add("idType","un");					        //en 密码为密文，其它情况 密码为明文
  		checkPwd_Packet.data.add("idNum","");						          //传空
  		checkPwd_Packet.data.add("loginNo","<%=workNo%>");		    //工号
  		core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
  		checkPwd_Packet=null;
    }
    /*校验集团用户密码*/
    else if(identityTypeVal=="02"){     
      if(isSeleQryFlay=="N"){
        rdShowMessageDialog("请选择列表中的集团用户！",1);
			  return false;
      }              
      var v_idNo = $("input[@name=queryRadio][@checked]").attr("v_idNo"); 
      var checkPwd_Packet = new AJAXPacket("/npage/s3691/pubCheckPwdIDC.jsp","正在进行密码校验，请稍候......");
      checkPwd_Packet.data.add("retType","checkPwd");
      checkPwd_Packet.data.add("idNo",v_idNo);
      checkPwd_Packet.data.add("Pwd1",oldPassword);
      core.ajax.sendPacket(checkPwd_Packet,doCheckUserPwd);
    }
  }
  
  var passValidateFlag = "N";
  function doCheckPwd(packet) {
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			rdShowMessageDialog(msg);
			return false;
		}else{
		  rdShowMessageDialog("校验成功！",2);
		  passValidateFlag = "Y";
		  $("#subUptBtn").attr("disabled","");
		}
	}
	
	function doCheckUserPwd(packet){
	  var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    if(retType == "checkPwd") //集团客户密码校验
    {
      if(retCode == "000000")
      {
        var retResult = packet.data.findValueByName("retResult");
        if(retResult == "false"){
        	rdShowMessageDialog("用户密码校验失败，请重新输入！",0);
        	return false;	        	
        }else{
          rdShowMessageDialog("用户密码校验成功！",2);
          passValidateFlag = "Y";
          $("#subUptBtn").attr("disabled","");
        }
      }
      else{
        rdShowMessageDialog("用户密码校验出错，请重新校验！",0);
  	    return false;
      }
    }
	}
	
	/*清空原密码*/
	function cleanPass(){
	  $("input[name='oldPassword']").val("");
	}
  
  function changeType(obj){
    if(obj=="0"){ //修改
      $("#newPassTr").css("display","");
       $("input[name='oldPassword']").val("");
       $("input[name='oldPassword']").attr("disabled","");
      $("#chkPass").attr("disabled","");
      $("#subUptBtn").attr("disabled","true");
    }else if(obj=="1"){ //重置
      $("#newPassTr").css("display","none");
      $("input[name='oldPassword']").val("");
      $("input[name='oldPassword']").attr("disabled","true");
      $("#chkPass").attr("disabled","true");
      $("#subUptBtn").attr("disabled","");
    }
  }
  
  var isSeleQryFlay = "N";
  /*选择需修改密码的产品*/
  function seleQryInfo(obj){
    isSeleQryFlay = "Y";
  }
  
  /*提交修改密码*/
  function subUptPass(){
    var newPassword1 = $("#newPassword1").val();
    var newPassword2 = $("#newPassword2").val();
    var slecOperType = $("input[@name=operType][@checked]").val();  //操作类型
    var oldPassword;
    var idNo;//选中产品id
    var updateType; //修改类型（01-密码修改，02-密码重置）
    
    var identityTypes = document.getElementById("identityType");
    var identityTypeVal;
    for(i=0;i<identityTypes.length;i++){            
      if(identityTypes[i].selected==true){             
        identityTypeVal = identityTypes[i].value;               
      }   
    }
    if(identityTypeVal=="00"){
      rdShowMessageDialog("请选择变更范围！",1);
      return false;
    }
    if(slecOperType=="0"){ //修改密码
      oldPassword = $("input[name='oldPassword']").val();
      updateType = "01";
      if(passValidateFlag=="Y"){//旧密码验证通过
        if(!checkElement(document.getElementById("newPassword1"))) return false;
        if(!checkElement(document.getElementById("newPassword2"))) return false;
        
        if(newPassword1==""||newPassword2==""){
          rdShowMessageDialog("请输入新密码！",1);
          return false;
        }
        if(newPassword1!=newPassword2){
          rdShowMessageDialog("两次密码不一致！请您重新输入！",1);
          return false;
        }
      }
    }else if(slecOperType=="1"){ //重置密码
      oldPassword = "";
      updateType = "02";
      newPassword1="123123";
    }
    
     
    /*校验集团客户密码*/
    if((identityTypeVal=="01")||(identityTypeVal=="03")){ 
      idNo = "";
    }
    /*校验集团用户密码*/
    else if(identityTypeVal=="02"){
      if(isSeleQryFlay=="N"){
        rdShowMessageDialog("请选择列表中的集团用户！",1);
			  return false;
      }
      idNo = $("input[@name=queryRadio][@checked]").attr("v_idNo"); 
    }
    var packet = new AJAXPacket("/npage/se801/fe801_ajax_subUptPass.jsp","正在进行密码校验，请稍候......");
    packet.data.add("opCode","<%=opCode%>");	
		packet.data.add("updateType",updateType);		  
		packet.data.add("identityTypeVal",identityTypeVal);	
		packet.data.add("custId","<%=result1[0][10]%>");	
		packet.data.add("idNo",idNo);	
		packet.data.add("oldPassword",oldPassword);	
		packet.data.add("newPassword1",newPassword1);
		packet.data.add("slecOperType",slecOperType);
		core.ajax.sendPacket(packet, doSubUptPass);
		checkPwd_Packet=null;
  }
  
  function doSubUptPass(packet){
    var retCode = packet.data.findValueByName("retcode");
    var retMsg = packet.data.findValueByName("retmsg");
    var slecOperType = packet.data.findValueByName("slecOperType");
    if(retCode!="000000"){
      rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
      window.location.href="fe801_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    }else{
      if(slecOperType=="0"){ //修改密码
        rdShowMessageDialog("密码修改成功！",2);
        window.location.href="fe801_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
      }else{  //重置密码
        rdShowMessageDialog("密码重置成功！<br>密码为123123.",2);
        window.location.href="fe801_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
      }
    }
  }
</script>
</BODY>
</HTML>
<%}%>