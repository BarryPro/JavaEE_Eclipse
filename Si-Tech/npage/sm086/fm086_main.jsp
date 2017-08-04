<%
    /*************************************
    * 功  能: 实名制审批查询  m086
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2013-4-15
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode =request.getParameter("opCode");
	String opName = request.getParameter("opName");
%>    
<HTML xmlns="http://www.w3.org/1999/xhtml"> 
	<HEAD>
		<TITLE><%=opName%></TITLE>
		<SCRIPT language = "javascript" type = "text/javascript" src = "/npage/public/zalidate.js"></SCRIPT>
		<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	</HEAD>
	<BODY>
		<FORM  NAME = "frm" ACTION = "" METHOD = "POST" >
			<%@ include file="/npage/include/header.jsp" %>	
			<DIV ID = "Operation_Table">
				<DIV ID = "d0" NAME = "d0" STYLE = "display:none">
					<DIV class = "title" >
						<DIV id = "title_zi"><%=opName%></DIV>
					</DIV>
					<table>
						<tr>
							<td>开始时间</td>
							<td>
								<input type = 'text' id = 'tm_b' name = 'tm_b' 
									ch_name = '开始时间' 
									onClick = "WdatePicker({minDate:'%y-{%M-5}-01',maxDate:'%y-%M-01',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})" />   				
							</td>
							
							<td>结束时间</td>
							<td>
								<input type = 'text' id = 'tm_e' name = 'tm_e' 
									ch_name = '结束时间'  			
									onClick = "WdatePicker({minDate:'%y-{%M-5}-01',maxDate:'%y-%M-%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})" />   				
										
							</td>				
						</tr>	
						<tr>
							<td>手机号码</td>
							<td colspan = '3'>
								<input type="text" id="phoneNo" name="phoneNo" v_type="mobphone" value=""   />
							</td>			
						</tr>						
					</table>
					<TABLE>
						<TR>
							<TD COLSPAN = '4' ALIGN = 'CENTER' ID = 'footer'>
								<INPUT TYPE = 'BUTTON' ID = 'b_qry' NAME= '' CLASS = 'b_foot' VALUE = '查询' />
								<INPUT TYPE = 'BUTTON' ID = 'b_ret' NAME= '' CLASS = 'b_foot' VALUE = '重置' />
								<INPUT TYPE = 'BUTTON' ID = 'b_cls' NAME= '' CLASS = 'b_foot' VALUE = '关闭' />
							</TD>				
						</TR>        
					</TABLE>		
				</DIV>
				<INPUT TYPE = 'HIDDEN' ID = 'opCode' NAME = 'opCode' VALUE = '<%=opCode%>'/>
				<INPUT TYPE = 'HIDDEN' ID = 'opName' NAME = 'opName' VALUE = '<%=opName%>'/>	
			</DIV>
			<div id = 'queryDiv'></div>
		<%@ include file="/npage/include/footer_new.jsp" %>
		</FORM>
		<SCRIPT>
			var stepNum = 0;
			$( document ).ready(
				function ()
				{
					$( "#d0" ).show( 500 );
					stepNum = stepNum + 1;
				}
			);
			
			$("#b_qry").click(
				function (){
					if ( fn_notNull ( document.all.tm_b ) ) return ;
					if ( fn_notNull ( document.all.tm_e ) ) return ;
					if($("#phoneNo").val() != "" && $("#phoneNo").val() != null){
						if(!checkElement(document.frm.phoneNo)) return false;
					}
					var getdataPacket = new AJAXPacket("fm086_ajax_query.jsp","正在获得数据，请稍候......");
					getdataPacket.data.add("opCode","<%=opCode%>");
					getdataPacket.data.add("opName","<%=opName%>");
					getdataPacket.data.add("tm_b",$("#tm_b").val());
					getdataPacket.data.add("tm_e",$("#tm_e").val());
					getdataPacket.data.add("phoneNo",$("#phoneNo").val());
					core.ajax.sendPacketHtml(getdataPacket);
					getdataPacket = null;
				}
			);
			
			function doProcess(data){
				//找到添加表格的div
				var markDiv=$("#queryDiv"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
			}
			
			$("#b_ret").click(
				function (){
					document.frm.action = '#';
					document.frm.submit();
				}
			);
			
			$("#b_cls").click(
				function (){
					removeCurrentTab();
				}
			);
			
			$("#tm_b").click(
				function (){
					WdatePicker({startDate:'%y%M%d'
						,dateFmt:'yyyyMMdd'
						,readOnly:true
						,alwaysUseStartDate:true})	
				}
			);
			
			$("#tm_e").click(
				function (){
					WdatePicker({startDate:'%y%M%d'
						,dateFmt:'yyyyMMdd'
						,readOnly:true
						,alwaysUseStartDate:true})	
				}
			);
		</SCRIPT>
	</BODY>
</HTML>