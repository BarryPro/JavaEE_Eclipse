<%
    /*************************************
    * 功  能: 4A白名单录入 e267 
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-9-16
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> 4A白名单录入 </title>
<%
    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
%>
  </script>
<script language="javascript">
    function doCfm(subButton)
    {
        controlButt(subButton);			//延时控制按钮的可用性
        var radio1 = document.getElementsByName("opFlag");
        for(var i=0;i<radio1.length;i++)
        {
        	if(radio1[i].checked)
        	{
        		var opFlag = radio1[i].value;
        		if(opFlag=="one")
        		{
        		    //单个提交
        		    if($("#workNoOperated").val()==""){
        		        rdShowMessageDialog("请输入操作工号！", 0);
        		        return false;
        		    }
        			simpleListInput();
        		}
        	}
        }
    }
    
    function controlButt(subButton){
        subButt2 = subButton;
        subButt2.disabled = true;
        setTimeout("subButt2.disabled = false",3000);
    }
    
    function simpleListInput(){
        var simplePacket = new AJAXPacket ("fe267_ajax_getSimpleInfo.jsp","请等待。。。");
        var workNoOperated = $("#workNoOperated").val();
        simplePacket.data.add("workNoOperated",workNoOperated);
    	core.ajax.sendPacketHtml(simplePacket,showSimpleMsg);
    	simplePacket =null;
    }
    
    function showSimpleMsg(data){
        $("#showSimpleTab").empty().append(data);
        $("#confirm").attr("disabled","");
    }

    function opFlagChange(obj){
	    document.frm.action="fe267_moreListInput.jsp";
		document.all.opcode.value="e267";
		document.frm.submit();
    }
    function resetPage(){
 		window.location.href = "fe267_main.jsp?opCode=e267&opName=4A白名单录入";
	}
	
	function subSimpleInfo(){
         var val = $("#operateWorkNo").val();
	   	 document.frm.action = "fe267_ajax_sunInfo.jsp?val="+val;
		 document.frm.submit();
	}
	
</script>
</head>
<body>
<form name="frm" method="POST">
 	<input type="hidden" name="opcode" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">操作类型</td>
		<td colspan="3">
			<input type="radio" name="opFlag" value="one" checked  />单个工号录入&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="two" onclick="opFlagChange(this)" />多个工号录入
		</td>
	</tr>
	<tr>
		<td class="blue">
			录入白名单工号
		</td>
		<td>
			<input type="text"  id="workNoOperated" name="workNoOperated" vlaue="" v_type="string" maxlength="6" />
     		<font color="orange">*</font>
     		<input class="b_text" type="button" name="query" value="查询" onClick="doCfm(this)" />
     		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     		<span id="showSimpleTab"></span>
		</td>
		
	</tr>
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button id="confirm" name="confirm" value="确定" onClick="subSimpleInfo()" disabled="disabled" index="2" />    
			<input class="b_foot" type=button name=back value="清除" onClick="resetPage()" />
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();" />
		</td>
	</tr>
</table>

    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>