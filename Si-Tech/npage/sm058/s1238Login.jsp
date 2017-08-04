<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-09 页面改造,修改样式
     *废弃了页面密码验证功能
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
  	request.setCharacterEncoding("GBK");

	  HashMap hm=new HashMap();
	  hm.put("1","没有客户ID！");
	  hm.put("3","密码错误！");
	  hm.put("4","手续费不确定，您不能进行任何操作！");
	  ///////
	  //  孙振兴添加 START
	  hm.put("5","对不起，此号码为特殊特殊号码，您的工号权限不足！");
	  hm.put("6","对不起，此号码办理过“邮寄帐单”业务，请先取消！");
	  hm.put("7","对不起，此号码办理过“电子帐单”业务，请先取消！");
	  hm.put("8","对不起，此号码办理过“邮寄帐单”和“电子帐单”业务，请先取消！");
	  hm.put("9","未能取得用户完整的基本信息!");
	  ///////
	  //  孙振兴添加 END
	  hm.put("2", "用户资料不存在1，请核查数据或咨询系统管理员！");
	  hm.put("10","用户资料不存在2，请核查数据或咨询系统管理员！");
	  hm.put("11","用户资料不存在3，请核查数据或咨询系统管理员！");
	  hm.put("12","用户资料不存在4，请核查数据或咨询系统管理员！");
	  hm.put("13","用户资料不存在5，请核查数据或咨询系统管理员！");
	  hm.put("14","用户资料不存在6，请核查数据或咨询系统管理员！");
	  hm.put("15","对不起，此号码办理过“亲情通业务”业务，请先取消！");
	  hm.put("30","此用户为异地用户，不能进行实名登记！");
	  hm.put("31","省内携号用户，只能在原归属地进行实名登记！");
%>
<%
		String opCode = WtcUtil.repNull(request.getParameter("opCode"))==""?"m058":WtcUtil.repNull(request.getParameter("opCode"));
		String opName = WtcUtil.repNull(request.getParameter("opName"))==""?"实名登记":WtcUtil.repNull(request.getParameter("opName"));
		String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
		System.out.println("#############ReqPageName->"+ReqPageName);
		String accept = WtcUtil.repNull(request.getParameter("accept"));
		String work_no = (String)session.getAttribute("workNo");
		String activePhone1=WtcUtil.repNull(request.getParameter("activePhone"));
		
		//2011/6/23 wanghfa添加 对密码权限整改 start
  boolean pwrf=false;
	String pubOpCode = opCode;
	String pubWorkNo = work_no;
	int favFlag = 0 ;/*0没有免密权限1有免密权限*/
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
 
	//2011/6/23 wanghfa添加 对密码权限整改 end
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>实名登记</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
 var isValidateFlag = false;
 onload=function()
 {
 		self.status="";
 		<%
 		if(accept.equals("")) {
 		%>
 		//document.all.cus_pass.disabled = false;
 		<%
 	}
 	%>
		<%
			if(ReqPageName.equals("s1238Main"))
			{
			  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));			 
		 	  if(!retMsg.equals("100") && !retMsg.equals("101"))
			  {
		%>
			    rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");
		<%
			  }
			  else if(retMsg.equals("100"))
			  {
		%>
				rdShowMessageDialog('帐户<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>已欠费，不能办理业务！');

		<%
			  }
		      else if(retMsg.equals("101"))
			  {
		%>
		rdShowMessageDialog('错误<%=WtcUtil.repNull(request.getParameter("errCode"))%>：<%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>');
		       		<%
			  }
			}
		%>

  }

var passflag="no";
	//验证及提交函数
	function doCfm()
	{
		
	<%
		if(accept.equals("")) {
		%>
		
			if(checkElement(document.frm.srv_no)==false) {
				 return false;
				}
				
				//var jiamiqianmima= document.all.cus_pass.value;		
				var phones_no= $("#srv_no").val();	
				
				
				if(phones_no.trim()=="") {
				 rdShowMessageDialog("手机号码不能为空！");
				 return false;
				}
				
				chkIsValidateSpecial("1",phones_no,"<%=opCode%>");
				
				//if(isValidateFlag==false) {
				if(false){//为测试写死
					
					var path = "<%=request.getContextPath()%>/npage/public/publicValidate.jsp";
					path =  path + "?valideVal=1";
					path =  path + "&titleName=<%=opName%>";
					path =  path + "&activePhone=" + $("#srv_no").val();
					path =  path + "&opCode=<%=opCode%>";
					path =  path + "&nowTimeee=" + Math.random();
					var validateResult = window.showModalDialog(path,"","dialogWidth=450px;dialogHeight=250px");
					if((validateResult=="undefined")||(validateResult!="1")){
						return;
					}
				}
			 
	 <%
		}	
		%>	
		
		
			
    frm.action="s1238Main.jsp";
    frm.submit();
	}
	
	function chkIsValidateSpecial(validateVal,activePhone,opcode)
	{
	  	isValidateFlag = false;
	  	var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/public/chkIsValidateSpecial.jsp","正在进行用户有效性验证,请稍候...");

	    chkInfoPacket.data.add("retType" ,     "chkIsValidate"  );
	    chkInfoPacket.data.add("verifyVal" ,  validateVal);
	    chkInfoPacket.data.add("phoneNo" ,  activePhone);
	    chkInfoPacket.data.add("opCode" ,  opcode);
	    chkInfoPacket.data.add("nowTime" ,  Math.random());
	    core.ajax.sendPacket(chkInfoPacket,doProcesspwd);
	    chkInfoPacket =null;
	}
	
    function doProcesspwd(packet)
	{
	    var retType = packet.data.findValueByName("retType");

	    if(retType=="chkIsValidate")
      {
      	var retCode = packet.data.findValueByName("retCode");
      	if(retCode=="000000")
      	 {
	         isValidateFlag = true;
      	 }
      }
      
       if(retType=="timeValidate")
      {
        var retCode   = packet.data.findValueByName("retCode");
        var timestamp = packet.data.findValueByName("timestamp");
        var targetUrl = packet.data.findValueByName("targetUrl");
        if(retCode=="000000")
         {
         	   if(targetUrl.indexOf("chncard") != -1){
         	   	   //alert('chncard');
         	   	   oldjumpurl=targetUrl;
         	  }else{
         	    targetUrl=targetUrl.substring(0,targetUrl.indexOf("#"));
         	    oldjumpurl=targetUrl+"&v99="+timestamp+"#";
         	      //alert(oldjumpurl);
         	   }
              return true;
         }else{
         	    
         	    alert("时间加密失败");
         	    return false;
        }
      }
	}
	
 
</script>
</head>
	<body>
		<form name="frm" method="POST">
 			<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1238Login">
 			<input type="hidden" name="accept" value="<%=accept%>"/>
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">实名登记</div>
			</div>
	    <table cellspacing="0">
          <tr>
            <td width="16%" class="blue">服务号码</td>
      			<td width="34%">
                <input type="text" size="17" maxLength="20" name="srv_no" id="srv_no"   maxlength="11" value="<%=activePhone1%>"  <%if(!activePhone1.equals("")){out.print(" readOnly");}%>>
      			</td>
      			
      			<!--
      			    <td width="16%" class="blue">用户密码</td>
    <td>
        <jsp:include page="/npage/common/pwd_one_new.jsp">
            <jsp:param name="width1" value="16%"/>
            <jsp:param name="width2" value="34%"/>
            <jsp:param name="pname" value="cus_pass"/>
            <jsp:param name="pwd" value="12345"/>
        </jsp:include>
    </td>
    -->
      		</tr>
          <tr>
            <td id="footer" colspan="2">
			          <input class="b_foot" type=button name=qryPage value="确认" onClick="doCfm()">
					  		<input class="b_foot" type=button name=qryP value="关闭" onClick="parent.removeTab('<%=opCode%>')">
      			</td>
    			</tr>
  			</table>
  			 <input type="hidden" name="jiamipassword" id="jiamipassword"  >
	<%@ include file="/npage/include/footer_simple.jsp"%>
		<%@ include file="/npage/common/pwd_comm.jsp" %>
   </form>
</body>
</html>