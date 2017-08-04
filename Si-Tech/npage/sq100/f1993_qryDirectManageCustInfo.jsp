<%
  /*
   * 功能: 全国直管客户信息查询 1993
   * 版本: 1.0
   * 日期: 2014-10-28
   * 作者: diling
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%
	String opName = "集团客户开户";
	String dWorkNo = (String)session.getAttribute("workNo");		//操作工号
	String dNopass = (String)session.getAttribute("password");	//工号密码
  String custName 	= request.getParameter("custName"); 			//客户名称
  String opCode 	= request.getParameter("opCode");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<SCRIPT type=text/javascript>
			function qryInfo(obj){
				/* 按钮延迟 */
  			controlButt(obj);
  			/* 事后提醒 */
  			//getAfterPrompt();
	
        var markDiv=$("#intablediv"); 
        markDiv.empty();
        
	      var directManageCustNo = $("#directManageCustNo").val();
	      var groupNo = $("#groupNo").val();
	      var institutionName = $("#institutionName").val();
	      var directManageCustName = $("#directManageCustName").val();
	      if(directManageCustNo == "" && groupNo == "" && institutionName == "" && directManageCustName == ""){
	      	rdShowMessageDialog("请至少输入一个查询条件！");
          return false;	
	      }
	      
	      var packet = new AJAXPacket("f1993_ajax_qryDirectManageCustInfo.jsp","正在获得数据，请稍候......");
	    	packet.data.add("directManageCustNo",directManageCustNo);
	    	packet.data.add("groupNo",groupNo);
	    	packet.data.add("institutionName",institutionName);
	    	packet.data.add("directManageCustName",directManageCustName);
	    	packet.data.add("opCode","<%=opCode%>");
	    	core.ajax.sendPacketHtml(packet,doQryInfo);
	    	packet = null;
			}
			
			function doQryInfo(data){
				//找到添加表格的div
				var markDiv=$("#intablediv"); 
				markDiv.empty();
				markDiv.append(data);
				var retCode = $("#retCode").val();
				var retMsg = $("#retMsg").val();
				if(retCode!="000000"){
				   rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
				   //window.returnValue="N";
				   window.close();
				}
			}
		
			function saveToQryInfo(){
				var selDirMageCustVal = $("input[@name=selDirMageCust][@checked]").val();
				if(typeof(selDirMageCustVal) == "undefined"){
					rdShowMessageDialog("请选择一项查询结果进行提交！");
				  return false;
				}
				var v_directManageCustNo = $("input[@name=selDirMageCust][@checked]").attr("v_directManageCustNo");//客户编码 
				var v_directManageCustName = $("input[@name=selDirMageCust][@checked]").attr("v_directManageCustName"); //客户名称
				var v_groupNo = $("input[@name=selDirMageCust][@checked]").attr("v_groupNo"); //组织机构代码
				window.returnValue=v_directManageCustNo+"~"+v_directManageCustName+"~"+v_groupNo;
				window.close(); 
			}
		</SCRIPT>
		<TITLE>全国直管客户信息查询</TITLE>
	</HEAD>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
	<BODY>
		<FORM method=post name="fPubSimpSel">   
		<%@ include file="/npage/include/header_pop.jsp" %>
			<div class="title">
				<div id="title_zi">全国直管客户信息查询</div>
			</div>
			<TABLE cellSpacing=0>
				<tr> 
					<td width=16% class="blue" > 全国直管客户编码</td>
					<td width=34%> 
						<input type="text" name="directManageCustNo"  id="directManageCustNo" value=""  />
					</td>
					<td width=16% class="blue" > 组织机构代码</td>
					<td width=34%> 
						<input type="text" name="groupNo"  id="groupNo" v_must='0'  value="" />
					</td>
				</tr>
				<tr> 
					<td width=16% class="blue" > 总部或分支机构名称</td>
					<td width=34%> 
						<input type="text" name="institutionName"  id="institutionName" value="" />
					</td>
					<td width=16% class="blue" > 直管客户名称</td>
					<td width=34%> 
						<input type="text" name="directManageCustName"  id="directManageCustName" value="<%=custName%>" />
					</td>
				</tr>
				<TR id="footer" > 
					<TD align="center" colspan="4">
						<input class="b_foot" id="commit" name="commit" onClick="qryInfo(this)" style="cursor:hand" type=button value="查询" />
						<input class="b_foot" name=back onClick="window.close();" style="cursor:hand" type=button value="关闭" />        
					</TD>
				</TR>
			</TABLE>
			<div id="intablediv"></div>
		<%@ include file="/npage/include/footer_pop.jsp" %>
		</FORM>
	</BODY>
</HTML>    
