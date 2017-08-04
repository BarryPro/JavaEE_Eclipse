<%
    /*************************************
    * 功  能: 4A白名单录入(多个) e267 
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-9-16
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = "e267";
  String opName = "4A白名单录入";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<script type="text/javascript">
    function queryGroup(){
       window.open("groupTree.jsp","","height=530,width=450,scrollbars=yes");
    }
    
    function getWorkNo(){
        var getPacket = new AJAXPacket ("fe267_ajax_getTab.jsp","请等待。。。");
        getPacket.data.add("groupId" , $("#groupId").val());
        getPacket.data.add("PageSize" , $("#pageRows").val());
        core.ajax.sendPacketHtml(getPacket,showMsg,true);
        getPacket =null;	
    }

    function showMsg(data){
        $("#showTab").empty().append(data);
        $("#pageTr").show();
    }

    function doCfm(){
    	var selectGroupId = $("#groupId").val();
    	//使用选择工号
        var val = "";
    	    var selBoxArr = $('input[name="selBox"]:checked');
    	    if(selBoxArr.length == 0){
    	   		rdShowMessageDialog("无被操作工号！");
    	  	    return;
    	   	}else{
    	   	    for(var j=0;j<selBoxArr.length;j++){
    	   	    	    val=val+selBoxArr[j].v_text + ",";
    	   	    }
    	   	 }
	   	 var groupIdVal = $("#groupId").val();
	   	 document.form1.action = "fe267_ajax_sunInfo.jsp?groupId=" + groupIdVal + "&val="+val;
		 document.form1.submit();
    }

 	function selPage(){
        getWorkNo();	
 	}

 	function resetPage(){
 		window.location.href = "fe267_moreListInput.jsp?opCode=e267&opName=4A白名单录入";
	}
	function toPrevious(){
	    window.location.href = "fe267_main.jsp?opCode=e267&opName=4A白名单录入";
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
            <td class="blue" width="20%">
            	组织节点
            </td>
            <td width="80%">
            	<input type="hidden" name="groupId" id="groupId"  class="InputGrey" readonly />
            	<input type=text name="groupName" id="groupName" class="InputGrey" size="30" readonly />
            	<input class="b_text" type="button" name="" value="选择" onclick="queryGroup();" />
            	<font color="orange">*</font>
            </td>
    </tr>
	</table>
	<div id="showTab" ></div>
	<table>
		<tr id="pageTr" style="display:none">
			<td class="blue" width="10%">显示行数</td>
			<td cplspan="3">
		    <select name="pageRows" id="pageRows" style="width:80px" onchange="selPage();">
					<option value="10">10行</option>
					<option value="20">20行</option>
					<option value="30">30行</option>
					<option value="40">40行</option>
					<option value="50">50行</option>
				</select>	
			</td>
		</tr>
         <tr>
            <td colspan="4" align="center">
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2" />
              <input class="b_foot" type=button name=back value="清除" onClick="resetPage()" />
		      <input class="b_foot" type=button name=qryP value="返回" onClick="toPrevious()" />
           </td>
        </tr>
      </table>
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>