<%
/********************
 version v2.0
������: si-tech
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
	        rdShowMessageDialog("��ѯ�Ŀ�ʼʱ�䲻��Ϊ�գ�");
   			  return false;
	    }
	    if(endtime=="") {
	        rdShowMessageDialog("��ѯ�Ľ���ʱ�䲻��Ϊ�գ�");
   			  return false;
	    }	    
				
	    if(endtime<starttime) {
	        rdShowMessageDialog("��ѯ�Ŀ�ʼʱ�䲻�ܴ��ڲ�ѯ�Ľ���ʱ�䣡");
   			  return false;
	    }
	    
	     var bmon=starttime;
 var emon=endtime;
 var panduan=endtime;

 
 if(emon.substring(4,6)>12 || bmon.substring(4,6)>12) {
 		rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
		return false;
 }
   if(bmon.substring(6,8)>31) {
   rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
  return false;
 }
    if(emon.substring(6,8)>31) {
   rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
  return false;
 }
 
 
 if(bmon.substring(0,4)==emon.substring(0,4) && bmon.substring(0,4)==panduan.substring(0,4) && emon.substring(0,4)==panduan.substring(0,4)) {
 if(panduan.substring(4,6)-bmon.substring(4,6)>5) {
 
  rdShowMessageDialog("ֻ�ܲ�ѯ���Ϊ6���µļ�¼��");
  return false;
 }
 if(emon.substring(4,6)>panduan.substring(4,6)) {
   rdShowMessageDialog("�����·ݲ��ܴ��ڵ�ǰ�·ݣ�");
  return false;
 }
  if(bmon.substring(4,6)>emon.substring(4,6)) {
   rdShowMessageDialog("�����·ݱ�����ڿ�ʼ�·ݣ�");
  return false;
 }
  if(emon.substring(6,8)>panduan.substring(6,8)) {
   rdShowMessageDialog("�����������ܴ��ڵ�ǰ������");
  return false;
 }
 }
  else if(bmon.substring(0,4)!=emon.substring(0,4) && bmon.substring(0,4)!=panduan.substring(0,4) && emon.substring(0,4)==panduan.substring(0,4) && Number(panduan.substring(0,4))-Number(bmon.substring(0,4))==1) {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("ֻ�ܲ�ѯ���Ϊ6���µļ�¼��");
  return false;
 }
 if(emon.substring(4,6)>panduan.substring(4,6)) {
   rdShowMessageDialog("�����·ݲ��ܴ��ڵ�ǰ�·ݣ�");
  return false;
 }
   if(emon.substring(6,8)>panduan.substring(6,8)) {
   rdShowMessageDialog("�����������ܴ��ڵ�ǰ������");
  return false;
 }

 }
  else if(bmon.substring(0,4)==emon.substring(0,4) && bmon.substring(0,4)!=panduan.substring(0,4) && emon.substring(0,4)!=panduan.substring(0,4)&& Number(panduan.substring(0,4))-Number(bmon.substring(0,4))==1) {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("ֻ�ܲ�ѯ���Ϊ6���µļ�¼��");
  return false;
 }

 }
   else if(bmon=="" || emon=="") {
 if((Number(panduan.substring(4,6))+(12-bmon.substring(4,6)))>5) { 
  rdShowMessageDialog("��ʼ���»�������²���Ϊ�գ�");
  return false;
 }

 }
 else {
 	 rdShowMessageDialog("ֻ�ܲ�ѯ���Ϊ6���µļ�¼��");
  return false;
 	}
 	
/*
  				var rb = starttime.replace(/\D/g, "");
  				var re = endtime.replace(/\D/g, "");
  				alert(parseFloat(rb));
  				alert(parseFloat(re));
  				alert(parseFloat(re)-parseFloat(rb));
  				if(rb && re && (parseFloat(re) - parseFloat(rb) > 600000000)) {
  					rdShowMessageDialog("��ʼʱ�������ʱ���Ȳ��ܳ���������,����������!");
  	        return false;
  				}
	*/  
	  
	var myPacket = new AJAXPacket("fm217_qry.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
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
				//�ҵ���ӱ���div
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
              <div align="left" class="blue">�ֻ�����</div>
            </td>
            <td > 
            <div align="left"> 
                <input   type="text"   name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone"   maxlength="11"  onBlur="checkElement(this)">
                </div>
            </td>  
            <td class='blue'>��������</td>
					        <td>
								<input type="text" name="work_nos" id="work_nos" value="" maxlength="10" />
					        </td>    
         </tr>
            <TR  > 
	          <TD width="16%" class="blue">ҵ�����</TD>
              <TD colspan="3">
							<select id="banlitype" name="banlitype" >
						<option value="">ȫ��</option>
						<option value="42">�ֻ��Ķ�</option>
						<option value="57">�ֻ���Ϸ</option>
						<option value="72">��������</option>
            <option value="95">�ֻ�����</option>
            <option value="82">�ֻ���Ƶ</option>
            <option value="41">MobileMarket</option>
            <option value="99">MDO��ѯ</option>
							</select>
	          </TD>
	        
         </TR> 
       		<tr id="chaxun">
			<td class="blue" width="15%">��ʼʱ��</td>
			<td><input type="text" name="workRulestarttime" id="workRulestarttime"  value="<%=morent_timeNAME1%>"  onclick="WdatePicker({el:'workRulestarttime',startDate:'%y%M0100',dateFmt:'yyyyMMdd HH:mm:ss',alwaysUseStartDate:true})"  maxlength="14" readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRulestarttime',startDate:'%y%M0100',dateFmt:'yyyyMMdd HH:mm:ss',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='ʱ���ʽ:YYYYMMDD HH:24Mi:SS'><font class='orange' style='display:none'>&nbsp;ʱ���ʽ:YYYYMMDD HH:24Mi:SS</font>	
				<font class="orange">��ʽ��YYYYMMDD HH:24Mi:SS</font>   
			</td>
						<td class="blue" width="15%">����ʱ��</td>
						<td><input type="text" name="workRuleendtime" id="workRuleendtime"  value="<%=morent_timeNAME2%>" onclick="WdatePicker({el:'workRuleendtime',startDate:'%y%M0100',dateFmt:'yyyyMMdd HH:mm:ss',alwaysUseStartDate:true})"   maxlength="14" readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRuleendtime',startDate:'%y%M0100',dateFmt:'yyyyMMdd HH:mm:ss',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='ʱ���ʽ:YYYYMMDD HH:24Mi:SS'><font class='orange' style='display:none'>&nbsp;ʱ���ʽ:YYYYMMDD HH:24Mi:SS</font>	
				<font class="orange">��ʽ��YYYYMMDD HH:24Mi:SS</font>   
			</td>
		</tr>



	</table>

	
	

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input class="b_foot" type=button name="confirm" value="��ѯ" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="���" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
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