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
 					rdShowMessageDialog("������Ҫ��ѯ���ֻ��Ż��߹��ţ�");
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
	        rdShowMessageDialog("��ѯ�Ŀ�ʼʱ�䲻��Ϊ�գ�");
   			  return false;
	    }
	    if(endtime=="") {
	        rdShowMessageDialog("��ѯ�Ľ���ʱ�䲻��Ϊ�գ�");
   			  return false;
	    }
	    if(endtime<starttime) {
	        rdShowMessageDialog("��ѯ�Ľ���ʱ�䲻��С�ڲ�ѯ�Ŀ�ʼʱ�䣡");
   			  return false;
	    }	  
	      
		if(starttime.substring(0,4)==endtime.substring(0,4) ) {
		  if(starttime.substring(4,6)!=endtime.substring(4,6)) {
		   rdShowMessageDialog("���ܿ���Ȼ�²�ѯ��");
		   return false;
		  }
		 
	   } else {
	    rdShowMessageDialog("���ܿ���Ȼ�²�ѯ��");
	    return false;
	   }
	}
	  
	var myPacket = new AJAXPacket("fm161Qry.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
	myPacket.data.add("phone_no",$("#srv_no").val());
	myPacket.data.add("starttimes",starttime);
	myPacket.data.add("endtimes",endtime);
	myPacket.data.add("work_no",work_no);
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
              <div align="left" class="blue">�ֻ�����</div>
            </td>
            <td colspan="3"> 
            <div align="left"> 
                <input   type="text"  name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone"   maxlength="11"  value ="" onBlur="checkElement(this)">
                </div>
            </td>
         
       
         </tr>
         
          <tr> 
            <td width="16%"  > 
              <div align="left" class="blue">��������</div>
            </td>
            <td colspan="3"> 
            <div align="left"> 
                <input   type="text" size="12" name="work_no" id="work_no"   maxlength="6"  value ="" >
               </div>
            </td>
         
       
         </tr>        

		<tr id="chaxun">
			<td class="blue" width="15%">��ʼʱ��</td>
			<td><input type="text" name="workRulestarttime" id="workRulestarttime"     maxlength="8" />
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRulestarttime',startDate:'%y%M0100',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='ʱ���ʽ:YYYYMMDD'><font class='orange' style='display:none'>&nbsp;ʱ���ʽ:YYYYMMDD</font>	
				<font class="orange">��ʽ��YYYYMMDD</font>   
			</td>
						<td class="blue" width="15%">����ʱ��</td>
						<td><input type="text" name="workRuleendtime" id="workRuleendtime"   maxlength="8" />
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRuleendtime',startDate:'%y%M0100',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='ʱ���ʽ:YYYYMMDD'><font class='orange' style='display:none'>&nbsp;ʱ���ʽ:YYYYMMDD</font>	
				<font class="orange">��ʽ��YYYYMMDD</font>   
			</td>
		</tr>

	</table>

	<div id="showTab" ></div>
	

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
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>