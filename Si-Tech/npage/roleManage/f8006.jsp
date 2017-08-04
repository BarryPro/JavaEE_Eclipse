 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-09 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	String opCode = "8006";	
	String opName = "复位工号密码";	//header.jsp需要的参数  
	
	String password = (String)session.getAttribute("password");
	String workNo = (String)session.getAttribute("workNo");	
%>

<HTML>
	<HEAD>
	<TITLE>复位工号密码</TITLE>
	<script language=javascript>
		onload=function(){		
		}
		function submitt(){
			if(document.frm.loginNo.value.length==0){
				rdShowMessageDialog("请输入要复位的工号！");
				return false;
			}else{
				document.frm.submit.disabled =true;
				var myPacket = new AJAXPacket("resetPassCfm.jsp","正在提交，请稍候......");
				myPacket.data.add("work_no",document.frm.work_no.value);
				myPacket.data.add("nopass",document.frm.nopass.value);
				myPacket.data.add("op_code",document.frm.op_code.value);
				myPacket.data.add("login_no",document.frm.loginNo.value);
		    		core.ajax.sendPacket(myPacket);
		    		myPacket=null;
			}
		}
		function doProcess(packet){
			var backGroupInfo = packet.data.findValueByName("backGroupInfo");	
			if(backGroupInfo=="操作已成功！"){
				rdShowMessageDialog(backGroupInfo,2);
			}else{
				rdShowMessageDialog(backGroupInfo,0);
			}
			
			document.frm.submit.disabled =false;
			document.frm.loginNo.value ="";
		}
		
		function check(){
			return false;
		}	
	</script>
</HEAD>
<body>      
	<FORM  name="frm" action="" method=post onSubmit="return check()">
		<%@ include file="/npage/include/header.jsp" %>  
		<div class="title">
			<div id="title_zi">复位工号密码</div>
		</div>	
	        <table id="tbs9" cellspacing="0">
		        <tr>
		              <td class="blue" width="16%">复位工号</td>
		              <td>
		 			<input  id=Text2 type=text size=12 name=loginNo maxlength=6 />
		              </td>          
		        </tr>
	        </TABLE>     
	       <table  cellspacing="0" >	         
		            <TR>
		              		<TD id="footer">
			              		<input class="b_foot" name=submit  type=button value="确认" onclick="submitt()" id=Button1>&nbsp;&nbsp;
			                	<input class="b_foot" name=back  type=button value="清除"  onclick="document.frm.loginNo.value='';">&nbsp;&nbsp;
			                	<input class="b_foot" name=back1  type=button value="关闭"  onclick="removeCurrentTab()">
		                	</TD>
		            </TR>	          
	        </TABLE>
  		
	  	<input type=hidden name=nopass value="<%=password%>">
	  	<input type=hidden name=op_code value="8006">
	  	<input type=hidden name=work_no value="<%=workNo%>">
		<%@ include file="/npage/include/footer.jsp" %>	
	</FORM>
</BODY>
</HTML>

                                            