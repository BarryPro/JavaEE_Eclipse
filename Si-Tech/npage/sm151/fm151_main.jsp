<%
    /*************************************
    * 功  能: BOSS垃圾短信平台白名单查询 m151
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2014-8-12
    **************************************/
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=opName%></title>     
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">   
    	<script language="javascript">
	      function query(submitBtn2){
					/* 按钮延迟 */
					controlButt(submitBtn2);
					
					var markDiv=$("#intablediv"); 
					markDiv.empty();
					if(!check(frm)) return false;
					var phoneNo = $("#phoneNo").val();
					var packet = new AJAXPacket("fm151_ajax_query.jsp","正在获得数据，请稍候......");
					packet.data.add("phoneNo",phoneNo);
					packet.data.add("opCode","<%=opCode%>");
					packet.data.add("opName","<%=opName%>");
					core.ajax.sendPacketHtml(packet,doQuery);
					packet = null;
	      }
        	
        function doQuery(data){
          //找到添加表格的div
					var markDiv=$("#intablediv"); 
					markDiv.empty();
      		markDiv.append(data);
          var retCode = $("#retCode").val();
          var retMsg = $("#retMsg").val();
          if(retCode!="000000"){
            rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
            return false;
          }
        }
        
        function subDelInfo(){
					if(rdShowConfirmDialog('确认进行删除吗？')==1){
						var phoneNo = $("#phoneNo").val();
	        	var packet = new AJAXPacket("fm151_ajax_subDelInfo.jsp","正在获得数据，请稍候......");
						packet.data.add("phoneNo",phoneNo);
						packet.data.add("opCode","<%=opCode%>");
						packet.data.add("opName","<%=opName%>");
						core.ajax.sendPacket(packet,doSubDelInfo);
						packet = null;
					}
        }
        
        function doSubDelInfo(packet){
        	var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					if(retCode =="000000"){
            rdShowMessageDialog("删除成功！",2);
            window.location.href="fm151_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
          }else{
          	rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
            window.location.href="fm151_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
          }
        }
        
        //只需要将table增加一个vColorTr='set' 属性就可以隔行变色
        $("table[vColorTr='set']").each(function(){
          $(this).find("tr").each(function(i,n){
            $(this).bind("mouseover",function(){
            	$(this).addClass("even_hig");
            });
            $(this).bind("mouseout",function(){
            	$(this).removeClass("even_hig");
            });
            if(i%2==0){
            	$(this).addClass("even");
            }
          });
        });
    	</script>
    </head>
    <body>
        <form name="frm" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">输入查询条件</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td class="blue">手机号码</td>
                    <td colspan="3">
                        <input type="text" id="phoneNo" name="phoneNo" v_type="mobphone" v_must="1" value="" />
                        <font class="orange">*</font>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="qryBtn" name="qryBtn" class="b_foot" value="查询" onClick="query(this)" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>