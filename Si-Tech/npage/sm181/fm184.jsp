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
    String current_timeNAME=new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
  onload=function()
  {

  }
  

 function doCfm(){
 		
 			if(document.all.srv_no.value.trim()=="" ) {
 					rdShowMessageDialog("请输入要查询的手机号！");
   			  return false;
 			}
			
			if(document.all.srv_no.value.trim()!="") {
	    	if(!checkElement(document.all.srv_no)){
						return false;
					}   
			} 
	      	    

	    
	   var starttime = $("#workRulestarttime").val();
	    var endtime =$("#workRuleendtime").val();
	    var banlitype =$("#banlitype").val();
	    
	    if(starttime=="") {
	        rdShowMessageDialog("查询的开始时间不能为空！");
   			  return false;
	    }
	    if(endtime=="") {
	        rdShowMessageDialog("查询的截止时间不能为空！");
   			  return false;
	    }	    
				
	    if(endtime<starttime) {
	        rdShowMessageDialog("查询的开始时间不能大于查询的截止时间！");
   			  return false;
	    }
	  
	  
	var myPacket = new AJAXPacket("fm184Qry.jsp","正在查询信息，请稍候......");
	myPacket.data.add("phone_no",$("#srv_no").val());
	myPacket.data.add("banlitype",banlitype);
	myPacket.data.add("starttime",starttime);
	myPacket.data.add("endtime",endtime);

	core.ajax.sendPacketHtml(myPacket,querinfo,true);
	getdataPacket = null;
	
	    

 }
 
  				function querinfo(data){
				//找到添加表格的div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}
		
		
 	function resetPage(){
 		window.location.href = "fm184.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
	}

</script>
</head>
<body>
<form name="form1" id="form1" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
      <table cellspacing="0">
         <tr> 
            <td width="16%"  > 
              <div align="left" class="blue">转让人手机号码</div>
            </td>
            <td colspan="3"> 
            <div align="left"> 
                <input   type="text"  class="InputGrey" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone"   maxlength="11"  value ="<%=activePhone%>" onBlur="checkElement(this)">
                </div>
            </td>      
         </tr>
            <TR  > 
	          <TD width="16%" class="blue">受让人状态</TD>
              <TD colspan="3">
							<select id="banlitype" name="banlitype" >
						<option value="00">全部</option>
						<option value="01">已生效</option>
						<option value="02">待生效</option>
						<option value="03">停用</option>
            <option value="04">失效</option>
							</select>
	          </TD>
	        
         </TR> 
       		<tr id="chaxun">
			<td class="blue" width="15%">查询开始时间</td>
			<td><input type="text" name="workRulestarttime" id="workRulestarttime"  value="<%=current_timeNAME%>"   maxlength="14" readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRulestarttime',startDate:'%y%M0100',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='时间格式:YYYYMMDDHH24MiSS'><font class='orange' style='display:none'>&nbsp;时间格式:YYYYMMDDHH24MiSS</font>	
				<font class="orange">格式：YYYYMMDDHH24MiSS</font>   
			</td>
						<td class="blue" width="15%">查询截止时间</td>
						<td><input type="text" name="workRuleendtime" id="workRuleendtime"  value="<%=current_timeNAME%>"   maxlength="14" readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRuleendtime',startDate:'%y%M0100',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='时间格式:YYYYMMDDHH24MiSS'><font class='orange' style='display:none'>&nbsp;时间格式:YYYYMMDDHH24MiSS</font>	
				<font class="orange">格式：YYYYMMDDHH24MiSS</font>   
			</td>
		</tr>



	</table>

	
	

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input class="b_foot" type=button name="confirm" value="查询" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="清除" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
        <div id="showTab" ></div>
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>