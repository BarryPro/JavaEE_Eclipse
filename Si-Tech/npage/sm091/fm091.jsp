<%
/********************
 version v2.0
开发商: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
  function queryGroup(){
  	  var win = window.open('fe121_setpdmain.jsp','','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
  }
  function getWorkNo(){
  	var chkPacket = new AJAXPacket ("ajax_getTab.jsp","请等待。。。");
	chkPacket.data.add("groupId" , $("#groupId").val());
	chkPacket.data.add("PageSize" , $("#pageRows").val());
	core.ajax.sendPacketHtml(chkPacket,showMsg,true);
	chkPacket =null;	
  }
  function showMsg(data){
	$("#showTab").empty().append(data);
	$("#pageTr").show();
	/* ningtn */
}
	function getFileName(obj){
		var pos = obj.lastIndexOf("\\");
		return obj.substring(pos+1);
	}
	function getFileExt(obj)
	{
	    var pos = obj.lastIndexOf(".");
	    return obj.substring(pos+1);
	}
 function doCfm(){
 		
 		 var flag = "";
	     var obj = document.getElementsByName("radio") ;
	     for(var t=0;t<obj.length;t++){
		 if(obj[t].checked){
			flag = obj[t].value ;
		   }
	     }
	     $("#flag").val(flag);
	     
			if(flag==0) {
		    
	    var shengxiaoshijian = $("#workRulestarttime").val();
	     var shengxiaoshijian1 ="<%=current_timeNAME%>";
				
	    if(shengxiaoshijian<shengxiaoshijian1) {
	        rdShowMessageDialog("权限生效时间不可以小于当前系统时间！");
   			  return false;
	    }
	    }
			if($("#oaNumber").val()==""){
				rdShowMessageDialog("请输入OA编号！");
				return;
			}
			if($("#oaTitle").val()==""){
				rdShowMessageDialog("请输入OA标题！");
				return;
			}
	     

 			 	if(form1.feefile.value.length<1){
					rdShowMessageDialog("请上传文件!");
					document.form1.feefile.focus();
					return false;
				}
		 		//var fileVal = getFileName($("#feefile").val());
		 		var fileVal = getFileExt($("#feefile").val());
				if("txt" == fileVal){
					//扩展名是txt
				}else{
					rdShowMessageDialog("上传文件的扩展名不正确",0);
					return false;
				}
				document.form1.action = "fm091_sub.jsp?flag=" + document.getElementById("flag").value + "&workRulestarttime="+$("#workRulestarttime").val()+"&workRuleendtime="+$("#workRuleendtime").val()+"&oaNumber="+$("#oaNumber").val()+"&oaTitle="+$("#oaTitle").val();
   			document.form1.submit();
 }
 	function selPage(){
    getWorkNo();	
 	}
 	function resetPage(){
 		window.location.href = "fm091.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
	function checkadd(){
		
	     var obj = document.getElementsByName("radio") ;
	     for(var t=0;t<obj.length;t++){
		 if(obj[t].checked){
				if(obj[t].value=="0") {
					$("#zengjia").show();
					$("#zengjia1").show();
				}else {
					$("#zengjia").hide();
					$("#zengjia1").hide();
				}
		   }
	     }
	}
</script>
</head>
<body>
<form name="form1" id="form1" method="POST" ENCTYPE="multipart/form-data">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
      <table cellspacing="0">

		<tr>
			<td class="blue" width="15%">操作类型</td>
			<td colspan="3"><input type="radio" name="radio" value="0" checked  onclick="checkadd()" />增加
			    <input type="radio" name="radio" value="1" onclick="checkadd()" />删除	
			</td>
		</tr>
		<tr id="zengjia">
			<td class="blue" width="15%">权限生效时间</td>
			<td><input type="text" name="workRulestarttime" id="workRulestarttime"  value="<%=current_timeNAME%>"   maxlength="17" readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRulestarttime',startDate:'%y%M0100',dateFmt:'yyyyMMdd HH:mm:ss',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='时间格式:YYYYMMDD HH:mm:ss'><font class='orange' style='display:none'>&nbsp;时间格式:YYYYMMDD HH:mm:ss</font>	
				<font class="orange">格式：YYYYMMDD HH:mm:ss</font>   
			</td>
						<td class="blue" width="15%">权限失效时间</td>
						<td><input type="text" name="workRuleendtime" id="workRuleendtime"  value="20500101 00:00:00"   maxlength="17" readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRuleendtime',startDate:'%y%M0100',dateFmt:'yyyyMMdd HH:mm:ss',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='时间格式:YYYYMMDD HH:mm:ss'><font class='orange' style='display:none'>&nbsp;时间格式:YYYYMMDD HH:mm:ss</font>	
				<font class="orange">格式：YYYYMMDD HH:mm:ss</font>   
			</td>
		</tr>
		<tr>
			<td class="blue">&nbsp;OA编号</td>
			<td><input type="text" id="oaNumber" name="oaNumber" maxlength="30"/><font color="orange">*</font>
			</td>
			<td class="blue">&nbsp;OA标题</td>
			<td><input type="text" id="oaTitle" name="oaTitle" maxlength="30"/><font color="orange">*</font>
			</td>
		</tr>
		
	</table>

	<div id="showTab" ></div>
	
	<table>
		<tr id="fileUpLoad">
			<td class="blue">
				文件上传
			</td>
			<td>
				<input type="file" name="feefile" id="feefile">
			</td>
			<td class="blue">
				文件上传说明
			</td>
			<td>
				<span>
					数据文件必须为<font color="red">txt</font>格式，每行记录为操作工号|操作代码<br />
					一次最多操作200名工号<br />
					&nbsp;文件中工号组织机构为在操作员工号组织机构归属下<br />
					&nbsp;如：<br />
					&nbsp;&nbsp;&nbsp;aaaaxp|1234|1235|1210<br />
					&nbsp;&nbsp;&nbsp;aaaaxp|1234<br />
					&nbsp;&nbsp;&nbsp;aaaaxp|1234|1235
			</span>
			</td>
		</tr>

      </table>
              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="清除" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="flag" id="flag" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>