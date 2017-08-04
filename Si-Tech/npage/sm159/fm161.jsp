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
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
  onload=function()
  {

  }
  

 function doCfm(){
 		
 			if(document.all.srv_no.value.trim()=="" && $("#work_no").val().trim()=="") {
 					rdShowMessageDialog("请输入要查询的手机号或者工号！");
   			  return false;
 			}
			
			if(document.all.srv_no.value.trim()!="") {
	    	if(!checkElement(document.all.srv_no)){
						return false;
					}   
			} 
	     
      var starttime = $("#workRulestarttime").val();
		  var endtime =$("#workRuleendtime").val();      	    
	    var work_no =$("#work_no").val();
	    
	    
	    if(work_no.trim()!="")  {
	    if(starttime=="") {
	        rdShowMessageDialog("查询的开始时间不能为空！");
   			  return false;
	    }
	    if(endtime=="") {
	        rdShowMessageDialog("查询的结束时间不能为空！");
   			  return false;
	    }
	    if(endtime<starttime) {
	        rdShowMessageDialog("查询的结束时间不能小于查询的开始时间！");
   			  return false;
	    }	  
	      
		if(starttime.substring(0,4)==endtime.substring(0,4) ) {
		  if(starttime.substring(4,6)!=endtime.substring(4,6)) {
		   rdShowMessageDialog("不能跨自然月查询！");
		   return false;
		  }
		 
	   } else {
	    rdShowMessageDialog("不能跨自然月查询！");
	    return false;
	   }
	}
	  
	var myPacket = new AJAXPacket("fm161Qry.jsp","正在查询信息，请稍候......");
	myPacket.data.add("phone_no",$("#srv_no").val());
	myPacket.data.add("starttimes",starttime);
	myPacket.data.add("endtimes",endtime);
	myPacket.data.add("work_no",work_no);
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
 		window.location.href = "fm161.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
              <div align="left" class="blue">手机号码</div>
            </td>
            <td colspan="3"> 
            <div align="left"> 
                <input   type="text"  name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone"   maxlength="11"  value ="" onBlur="checkElement(this)">
                </div>
            </td>
         
       
         </tr>
         
          <tr> 
            <td width="16%"  > 
              <div align="left" class="blue">操作工号</div>
            </td>
            <td colspan="3"> 
            <div align="left"> 
                <input   type="text" size="12" name="work_no" id="work_no"   maxlength="6"  value ="" >
               </div>
            </td>
         
       
         </tr>        

		<tr id="chaxun">
			<td class="blue" width="15%">开始时间</td>
			<td><input type="text" name="workRulestarttime" id="workRulestarttime"     maxlength="8" />
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRulestarttime',startDate:'%y%M0100',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='时间格式:YYYYMMDD'><font class='orange' style='display:none'>&nbsp;时间格式:YYYYMMDD</font>	
				<font class="orange">格式：YYYYMMDD</font>   
			</td>
						<td class="blue" width="15%">结束时间</td>
						<td><input type="text" name="workRuleendtime" id="workRuleendtime"   maxlength="8" />
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRuleendtime',startDate:'%y%M0100',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='时间格式:YYYYMMDD'><font class='orange' style='display:none'>&nbsp;时间格式:YYYYMMDD</font>	
				<font class="orange">格式：YYYYMMDD</font>   
			</td>
		</tr>

	</table>

	<div id="showTab" ></div>
	

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
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>