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
 		
 			if(document.all.zr_phone.value.trim()=="" && document.all.sr_phone.value.trim()=="" && document.all.jyls.value.trim()=="") {
 					rdShowMessageDialog("ת�����ֻ�������������ֻ�������Ż���ƽ̨������ˮ�ű�������һ����");
   			  return false;
 			}
			

	     
      var starttime = $("#workRulestarttime").val();
		  var endtime =$("#workRuleendtime").val();      	    
	    

	    if(starttime=="") {
	        rdShowMessageDialog("��ѯ�Ŀ�ʼʱ�䲻��Ϊ�գ�");
   			  return false;
	    }
	    if(endtime=="") {
	        rdShowMessageDialog("��ѯ�Ľ�ֹʱ�䲻��Ϊ�գ�");
   			  return false;
	    }	    
				
	    if(endtime<starttime) {
	        rdShowMessageDialog("��ѯ�Ŀ�ʼʱ�䲻��С�ڲ�ѯ�Ľ�ֹʱ�䣡");
   			  return false;
	    }
	  
	  
	var myPacket = new AJAXPacket("fm186Qry.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
	myPacket.data.add("zr_phone",$("#zr_phone").val());
	myPacket.data.add("sr_phone",$("#sr_phone").val());
	myPacket.data.add("jyls",$("#jyls").val());
	myPacket.data.add("starttime",starttime);
	myPacket.data.add("endtime",endtime);

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
 		window.location.href = "fm186.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
              <div align="left" class="blue">ת�����ֻ�����</div>
            </td>
            <td > 
            <div align="left"> 
                <input type="text" name="zr_phone" id="zr_phone" v_must="1" v_type="mobphone" value=""  maxlength=11   />
                </div>
            </td>
                     <td width="16%"  > 
              <div align="left" class="blue">���Ż���ƽ̨������ˮ��</div>
            </td>
            <td > 
            <div align="left"> 
                <input type="text" name="jyls" id="jyls"  v_type="mobphone" value=""  maxlength=40   />
                </div>
            </td>
       
         </tr>
                  <tr> 
            <td width="16%"  > 
              <div align="left" class="blue">�������ֻ�����</div>
            </td>
            <td colspan="3"> 
            <div align="left"> 
                <input   type="text"  name="sr_phone" id="sr_phone" v_minlength=1 v_maxlength=16 v_type="mobphone"  maxlength="11"  value =""  >
                </div>
            </td>
                     
       
         </tr>
       		<tr id="chaxun">
			<td class="blue" width="15%">��ѯ��ʼʱ��</td>
			<td><input type="text" name="workRulestarttime" id="workRulestarttime"  value="<%=current_timeNAME%>"   maxlength="14" readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRulestarttime',startDate:'%y%M0100',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='ʱ���ʽ:YYYYMMDDHH24MiSS'><font class='orange' style='display:none'>&nbsp;ʱ���ʽ:YYYYMMDDHH24MiSS</font>	
				<font class="orange">��ʽ��YYYYMMDDHH24MiSS</font>   
			</td>
						<td class="blue" width="15%">��ѯ��ֹʱ��</td>
						<td><input type="text" name="workRuleendtime" id="workRuleendtime"  value="<%=current_timeNAME%>"   maxlength="14" readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRuleendtime',startDate:'%y%M0100',dateFmt:'yyyyMMddHHmmss',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='ʱ���ʽ:YYYYMMDDHH24MiSS'><font class='orange' style='display:none'>&nbsp;ʱ���ʽ:YYYYMMDDHH24MiSS</font>	
				<font class="orange">��ʽ��YYYYMMDDHH24MiSS</font>   
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