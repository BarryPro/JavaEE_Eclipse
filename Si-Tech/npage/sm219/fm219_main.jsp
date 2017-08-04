<%
  /*
   * 功能: m219·集团客户购充值卡冲正
   * 版本: 1.0
   * 日期: 2015/1/8 
   * 作者: diling
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");  
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String workno = (String)session.getAttribute("workNo");
	String org_code = ((String)session.getAttribute("orgCode")).substring(0,7);
	String nopass  =(String)session.getAttribute("password"); 
	String Department = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String districtCode = Department.substring(2,4);
	String powerRight = (String)session.getAttribute("powerRight"); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<TITLE><%=opName%></TITLE>	
			<SCRIPT type=text/javascript>	
				function qryInfo(){
					var cardBeginNo = $("#cardBeginNo").val();
					var cardEndNo = $("#cardEndNo").val();
					
					if(!check(frm)){
						return false;
					}
					var markDiv=$("#intablediv"); 
          markDiv.empty();
					
					var packet = new AJAXPacket("fm219_ajax_qryCardInfo.jsp","正在获得数据，请稍候......");
	        packet.data.add("opCode","<%=opCode%>");
	        packet.data.add("cardBeginNo",cardBeginNo);
	        packet.data.add("cardEndNo",cardEndNo);
	        core.ajax.sendPacketHtml(packet,doQryCardInfo);
				}
				
				function doQryCardInfo(data){
					//找到添加表格的div
					var markDiv=$("#intablediv"); 
					markDiv.empty();
					markDiv.append(data);
					var retCode = $("#retCode").val();
					var retMsg = $("#retMsg").val();
					if(retCode!="000000"){
					 rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
					 window.location.href="fm219_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
					}
				}
				
				function subInfo(submitBtn){
          if(rdShowConfirmDialog("确认要提交吗？")!=1){
          	return false;
          }else{
          	 /* 按钮延迟 */
    				controlButt(submitBtn);
						var cardBeginNo = $("#cardBeginNo").val();
            var cardEndNo = $("#cardEndNo").val();
            var card_num = $("#card_num").val();
            var sale_price = $("#sale_price").val();
            var real_salePrice = $("#real_salePrice").val();
            var res_code = $("#res_code").val();
            var login_accept = $("#login_accept").val();
            
            var packet = new AJAXPacket("fm219_ajax_subInfo.jsp","正在获得数据，请稍候......");
          	packet.data.add("opCode","<%=opCode%>");
          	packet.data.add("cardBeginNo",cardBeginNo);
          	packet.data.add("cardEndNo",cardEndNo);
          	packet.data.add("card_num",card_num);
          	packet.data.add("sale_price",sale_price);
          	packet.data.add("real_salePrice",real_salePrice);
          	packet.data.add("res_code",res_code);
          	packet.data.add("login_accept",login_accept);
          	core.ajax.sendPacket(packet,doSubInfo);
          	packet = null;
          }
				}
				
				function doSubInfo(packet){
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					if(retCode!="000000"){
						rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
						window.location.href="fm219_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
					}else{
						rdShowMessageDialog("提交成功！",2);
						window.location.href="fm219_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
					}
        }
			</script>
	</HEAD>
	<BODY>
		<FORM action="" method="post" name="frm" >
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi"><%=opName%></div>
			</div>	
	    <TABLE  cellSpacing=0>
	      <TR>
	        <TD width="18%" class="blue">充值卡开始序列号</TD>
	        <TD width="32%">
	          <input type="text" name="cardBeginNo"  id="cardBeginNo" size="20" v_type="0_9" maxlength="40" v_must="1" value="" />
	        	<font class="orange">*</font>
	        </TD>
	        <TD width="18%" class="blue">充值卡结束序列号</TD>
	        <TD width="32%">
	         	<input type="text" name="cardEndNo" id="cardEndNo" size="20" v_type="0_9" maxlength="40" v_must="1" value="" />
	        	<font class="orange">*</font>
	        </TD>
	      </TR>
	      <TR>
	      	<TD id="footer" colspan="4"> &nbsp;
				  	<input name="next" id="next"  type="button" class="b_foot" value="查询" onclick="qryInfo()" />
        		&nbsp; 
        		<input  name="back"  class="b_foot" type=button value="清除" onclick="window.location='fm219_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>'">
						&nbsp;
	          <input  name="closeBtn"  class="b_foot" onClick="removeCurrentTab()" type="button" value="关闭" />
	        </TD>
	      </TR>	
	    </TABLE>
	    <!-------------隐藏域--------------->
			<input type="hidden" name="qryFlag"   value="" />
			<input type="hidden" name="iccid"   value="" />
			<input type="hidden" name="cust_id"   value="" />
			<input type="hidden" name="user_no"   value="" />
			<input type="hidden" name="grpIdNo"   value="" />
			<input type="hidden" name="grp_name"   value="" />
			<input type="hidden" name="sm_name"   value="" />
			<input type="hidden" name="sm_code"   value="" />
			<!-------------隐藏域--------------->
			<div id="intablediv"></div>
			<%@ include file="/npage/include/footer.jsp" %>  
		</FORM>
	</BODY>
</HTML>
