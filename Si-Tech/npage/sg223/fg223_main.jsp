<%
    /*************************************
    * 功  能: 集团产品异步接口交易状态查询 g223
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-10-17
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
		String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
%>  

<HTML>
<HEAD>
    <TITLE>集团产品异步接口交易状态查询</TITLE>
</HEAD>
<body>
<SCRIPT language="JavaScript">
    function queryInfo(){
    		var markDiv=$("#intablediv"); 
        markDiv.empty();
        if(!check(frmg223)){
          return false;
        }
        var unitId = $("#unitId").val();
        var myPacket = new AJAXPacket("fg223_ajax_queryInfo.jsp","正在获取信息，请稍候......");
	    	myPacket.data.add("opCode","<%=opCode%>");
	    	myPacket.data.add("opName","<%=opName%>");
	    	myPacket.data.add("unitId",unitId);
	    	core.ajax.sendPacketHtml(myPacket,doQueryInfo);
	    	myPacket=null; 
    }
    
    function doQueryInfo(data){
    		//找到添加表格的div
				var markDiv=$("#intablediv"); 
				markDiv.empty();
    		markDiv.append(data);
        var retCode = $("#retCode").val();
        var retMsg = $("#retMsg").val();
        if(retCode!="000000"){
             rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
             window.location.href="fg223_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
        }
    }
</SCRIPT>
<form name="frmg223" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
		        <div id="title_zi">查询条件</div>
	        </div>
            <table cellspacing="0">
            	<tr>
            		<td class="blue"  nowrap>集团编号</td>
            	    <td colspan="3">
            	    	<input type="text" name="unitId" id="unitId" value="" size="20" v_must="1" />
            	    </td>
            	</tr>
            	 <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="queryBtn" name="queryBtn" class="b_foot" value="查询" onClick="queryInfo()" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
</BODY>
</HTML>

