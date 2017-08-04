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
    checkadd();
  }
  


  function showMsg(data){
	$("#showTab").empty().append(data);
	$("#pageTr").show();
	/* ningtn */
}
	function getFileName(obj){
		var pos = obj.lastIndexOf("\\");
		return obj.substring(pos+1);
	}
	function getFileExt(obj)
	{
	    var pos = obj.lastIndexOf(".");
	    return obj.substring(pos+1);
	}
 function doCfm(){
 		
 		 var flag = "";
	     var obj = document.getElementsByName("radio") ;
	     for(var t=0;t<obj.length;t++){
		 if(obj[t].checked){
			flag = obj[t].value ;
		   }
	     }

 
	    	if(!checkElement(document.all.srv_no)){
						return false;
					}    
	     
			if(flag==1) {
		    
	    var starttime = $("#workRulestarttime").val();
	    var endtime =$("#workRuleendtime").val();
	    
	    if(starttime=="") {
	        rdShowMessageDialog("查询的起始日期不能为空！");
   			  return false;
	    }
	    if(endtime=="") {
	        rdShowMessageDialog("查询的终止日期不能为空！");
   			  return false;
	    }	    
				
	    if(endtime<starttime) {
	        rdShowMessageDialog("查询的终止日期不能小于查询的起始日期！");
   			  return false;
	    }
	    
	var myPacket = new AJAXPacket("fm160Qry.jsp","正在查询信息，请稍候......");
	myPacket.data.add("phone_no",$("#srv_no").val());
	myPacket.data.add("starttimes",starttime);
	myPacket.data.add("endtimes",endtime);
	core.ajax.sendPacketHtml(myPacket,querinfo,true);
	getdataPacket = null;
	
	    
	    }else {
	     
				document.form1.action = "fm159Cfm.jsp";
   			document.form1.submit();
   		}
 }
 
 				function querinfo(data){
				//找到添加表格的div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}

 	function resetPage(){
 		window.location.href = "fm159.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
	function checkadd(){
		
	     var obj = document.getElementsByName("radio") ;
	     for(var t=0;t<obj.length;t++){
		 if(obj[t].checked){
				if(obj[t].value=="0") {
					$("#zengjia").show();
					$("#chaxun").hide();
				var markDiv=$("#showTab"); 
				markDiv.empty();
				}else {
					$("#zengjia").hide();
					$("#chaxun").show();
				}
		   }
	     }
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
                <input   type="text"  name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11"  value ="" >
                <font class='orange'>*</font></div>
            </td>
         
       
         </tr>
		<tr>
			<td class="blue" width="15%">操作方式</td>
			<td colspan="3"><input type="radio" name="radio" value="0" checked  onclick="checkadd()"  <%if(opCode.equals("m159")) {%>checked<%}%>/>增加
			    <input type="radio" name="radio" value="1" onclick="checkadd()"  <%if(opCode.equals("m160")) {%>checked<%}%>/>查询	
			</td>
		</tr>
		<tr id="chaxun">
			<td class="blue" width="15%">起始日期</td>
			<td><input type="text" name="workRulestarttime" id="workRulestarttime"  value="<%=current_timeNAME%>"   maxlength="8" readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRulestarttime',startDate:'%y%M0100',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='时间格式:YYYYMMDD'><font class='orange' style='display:none'>&nbsp;时间格式:YYYYMMDD</font>	
				<font class="orange">格式：YYYYMMDD</font>   
			</td>
						<td class="blue" width="15%">终止日期</td>
						<td><input type="text" name="workRuleendtime" id="workRuleendtime"  value="<%=current_timeNAME%>"   maxlength="8" readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRuleendtime',startDate:'%y%M0100',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='时间格式:YYYYMMDD'><font class='orange' style='display:none'>&nbsp;时间格式:YYYYMMDD</font>	
				<font class="orange">格式：YYYYMMDD</font>   
			</td>
		</tr>
		       <TR id="zengjia" > 
	          <TD width="16%" class="blue">操作类型</TD>
              <TD >
							<select id="banlitype" name="banlitype" >
						<option value="01">下发</option>
						<option value="02">补发</option>
						<option value="03">重置</option>
						<option value="04">冻结</option>
						<option value="05">解冻</option>
						<option value="06">启用消费密码</option>
						<option value="07">关闭消费密码</option>n>
							</select>
	          </TD>
	        
         </TR> 
	</table>

	<div id="showTab" ></div>
	

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">
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