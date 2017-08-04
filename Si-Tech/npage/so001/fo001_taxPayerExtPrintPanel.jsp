<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
    String FRAME_PRINT_FLAG = (String)request.getParameter("FRAME_PRINT_FLAG");
    String PUB_SESSIONID = (String)request.getParameter("sessionId");
    String loginNo = (String)session.getAttribute("login_no"); 
    String optiondate = new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());
%>
<div class="title">
	<div class="text">纳税人资格认证材料</div>
</div>
	<div class="box" style="height:auto;" id="shoppingCartDiv">
		<div class="input">	
		 	<table>                    	    
				<tr>
					<th>认证附件：</th>
							<td> 
								<iframe frameborder="0" id="busiFileUpLoadIF" name="busiFileUpLoadIF" width="100%" style="overflow:hidden;border:0;height:33px" src="fo001_busiFile.jsp"></iframe>
								<div id='showFileDiv'></div>
								<input type="hidden" name="VISIT_INFO_PATH_BUSI" id="VISIT_INFO_PATH_BUSI"/>
 						 	</td>
				</tr>
			</table>		
		</div>
        <div id="shoppingCarErrDiv"></div>
        <%@ include file="./idCardScan/idCardScan.jsp"%>
	</div>
