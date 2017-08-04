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
    
    String morent_timeNAME1=current_timeNAME+" 00:00:00";
    String morent_timeNAME2=current_timeNAME+" 23:59:59";
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
  onload=function()
  {

  }
  

 function doCfm(){
 		
			
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
	        rdShowMessageDialog("查询的结束时间不能为空！");
   			  return false;
	    }	    
				
	    if(endtime<starttime) {
	        rdShowMessageDialog("查询的开始时间不能大于查询的结束时间！");
   			  return false;
	    }
	    
	     var bmon=starttime;
 var emon=endtime;
 var panduan=endtime;

 
 if(emon.substring(4,6)>12 || bmon.substring(4,6)>12) {
 		rdShowMessageDialog("请输入正确的查询条件！");
		return false;
 }
   if(bmon.substring(6,8)>31) {
   rdShowMessageDialog("请输入正确的查询条件！");
  return false;
 }
    if(emon.substring(6,8)>31) {
   rdShowMessageDialog("请输入正确的查询条件！");
  return false;
 }
 
 
 if(bmon.substring(0,4)==emon.substring(0,4) && bmon.substring(0,4)==panduan.substring(0,4) && emon.substring(0,4)==panduan.substring(0,4)) {
 if(panduan.substring(4,6)-bmon.substring(4,6)>5) {
 
  rdShowMessageDialog("只能查询跨度为6个月的记录！");
  return false;
 }
 if(emon.substring(4,6)>panduan.substring(4,6)) {
   rdShowMessageDialog("结束月份不能大于当前月份！");
  return false;
 }
  if(bmon.substring(4,6)>emon.substring(4,6)) {
   rdShowMessageDialog("结束月份必须大于开始月份！");
  return false;
 }
  if(emon.substring(6,8)>panduan.substring(6,8)) {
   rdShowMessageDialog("结束天数不能大于当前天数！");
  return false;
 }
 }
  else if(bmon.substring(0,4)!=emon.substring(0,4) && bmon.substring(0,4)!=panduan.substring(0,4) && emon.substring(0,4)==panduan.substring(0,4) && Number(panduan.substring(0,4))-Number(bmon.substring(0,4))==1) {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("只能查询跨度为6个月的记录！");
  return false;
 }
 if(emon.substring(4,6)>panduan.substring(4,6)) {
   rdShowMessageDialog("结束月份不能大于当前月份！");
  return false;
 }
   if(emon.substring(6,8)>panduan.substring(6,8)) {
   rdShowMessageDialog("结束天数不能大于当前天数！");
  return false;
 }

 }
  else if(bmon.substring(0,4)==emon.substring(0,4) && bmon.substring(0,4)!=panduan.substring(0,4) && emon.substring(0,4)!=panduan.substring(0,4)&& Number(panduan.substring(0,4))-Number(bmon.substring(0,4))==1) {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("只能查询跨度为6个月的记录！");
  return false;
 }

 }
   else if(bmon=="" || emon=="") {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("开始年月或结束年月不能为空！");
  return false;
 }

 }
 else {
 	 rdShowMessageDialog("只能查询跨度为6个月的记录！");
  return false;
 	}
 	
/*
  				var rb = starttime.replace(/\D/g, "");
  				var re = endtime.replace(/\D/g, "");
  				alert(parseFloat(rb));
  				alert(parseFloat(re));
  				alert(parseFloat(re)-parseFloat(rb));
  				if(rb && re && (parseFloat(re) - parseFloat(rb) > 600000000)) {
  					rdShowMessageDialog("开始时间与结束时间跨度不能超过六个月,请重新输入!");
  	        return false;
  				}
	*/  
	  
	var myPacket = new AJAXPacket("fm217_qry.jsp","正在查询信息，请稍候......");
	myPacket.data.add("phone_no",$("#srv_no").val());
	myPacket.data.add("work_nos",$("#work_nos").val());
	myPacket.data.add("banlitype",banlitype);
	myPacket.data.add("starttime",starttime);
	myPacket.data.add("endtime",endtime);
	myPacket.data.add("opCode","<%=opCode%>");

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
 		window.location.href = "fm217.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
            <td > 
            <div align="left"> 
                <input   type="text"   name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone"   maxlength="11"  onBlur="checkElement(this)">
                </div>
            </td>  
            <td class='blue'>操作工号</td>
					        <td>
								<input type="text" name="work_nos" id="work_nos" value="" maxlength="10" />
					        </td>    
         </tr>
            <TR  > 
	          <TD width="16%" class="blue">业务类别</TD>
              <TD colspan="3">
							<select id="banlitype" name="banlitype" >
						<option value="">全部</option>
						<option value="42">手机阅读</option>
						<option value="57">手机游戏</option>
						<option value="72">无线音乐</option>
            <option value="95">手机动漫</option>
            <option value="82">手机视频</option>
            <option value="41">MobileMarket</option>
            <option value="99">MDO查询</option>
							</select>
	          </TD>
	        
         </TR> 
       		<tr id="chaxun">
			<td class="blue" width="15%">开始时间</td>
			<td><input type="text" name="workRulestarttime" id="workRulestarttime"  value="<%=morent_timeNAME1%>"  onclick="WdatePicker({el:'workRulestarttime',startDate:'%y%M0100',dateFmt:'yyyyMMdd HH:mm:ss',alwaysUseStartDate:true})"  maxlength="14" readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRulestarttime',startDate:'%y%M0100',dateFmt:'yyyyMMdd HH:mm:ss',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='时间格式:YYYYMMDD HH:24Mi:SS'><font class='orange' style='display:none'>&nbsp;时间格式:YYYYMMDD HH:24Mi:SS</font>	
				<font class="orange">格式：YYYYMMDD HH:24Mi:SS</font>   
			</td>
						<td class="blue" width="15%">结束时间</td>
						<td><input type="text" name="workRuleendtime" id="workRuleendtime"  value="<%=morent_timeNAME2%>" onclick="WdatePicker({el:'workRuleendtime',startDate:'%y%M0100',dateFmt:'yyyyMMdd HH:mm:ss',alwaysUseStartDate:true})"   maxlength="14" readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRuleendtime',startDate:'%y%M0100',dateFmt:'yyyyMMdd HH:mm:ss',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='时间格式:YYYYMMDD HH:24Mi:SS'><font class='orange' style='display:none'>&nbsp;时间格式:YYYYMMDD HH:24Mi:SS</font>	
				<font class="orange">格式：YYYYMMDD HH:24Mi:SS</font>   
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