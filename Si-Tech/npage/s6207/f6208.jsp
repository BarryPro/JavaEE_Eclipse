<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.25
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%
	String opCode = request.getParameter("opCode");
 	String opName = request.getParameter("opName");

    //�ڴ˴���ȡsession��Ϣ
    
    String work_no   = (String)session.getAttribute("workNo");
    String group_id = (String)session.getAttribute("groupId");
    //String group_id = "10014"; //����ʡ������Ա
    String regionCode = (String)session.getAttribute("regCode");

    
    if( "10014".equals(group_id) )
    {
        regionCode = "99";
    }
    
    String sql = "select count(*) from shighlogin where login_no='" +work_no+"' and op_code='6208'";
    //ArrayList resultArr = callView1.view_spubqry32("1",sql);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultCount" scope="end" />
<%
   
    if(resultCount.length==0) 
    {
%>
<script language="javascript" >
	rdShowMessageDialog("�˹����޲�����ҳ��Ȩ��",0);
	removeCurrentTab();
</script>
<%
    }

    String  retCode =request.getParameter("retCode");
    
    if("1".equals(retCode))
    {
%>
<script language="javascript" >
	rdShowMessageDialog("�����ʷѵ�����Ϣ�����ɹ���",2);
</script>
<%
    }
    if("2".equals(retCode))
    {
%>
<script language="javascript" >
	rdShowMessageDialog("�޸��ʷѵ�����Ϣ�����ɹ���",2);
</script>
<%
    }
    if("3".equals(retCode))
    {
%>
<script language="javascript" >
	rdShowMessageDialog("ɾ���ʷѵ�����Ϣ�����ɹ���",2);
</script>
<%
    }
%>

<HEAD>
<TITLE>�ʷѵ����ײ�����</TITLE>
<!---------------------------------����JS--����ҳ������ʽ��----------------------------->

</HEAD>
<script language=javascript>
function showtbs1(){    
        tbs1.style.display="";
        tbs2.style.display="none";
        tbs3.style.display="none";
        document.all.font1.color='222222';
        document.all.font2.color='999999';
        document.all.font3.color='999999';
        document.all.form_select.value="frm1";
}

function showtbs2(){    
        tbs1.style.display="none";
        tbs2.style.display="";
        tbs3.style.display="none";
        document.all.font1.color='999999';
        document.all.font2.color='222222';
        document.all.font3.color='999999';
        document.all.form_select.value="frm2";
    }
function showtbs3(){    
        tbs1.style.display="none";
        tbs2.style.display="none";
        tbs3.style.display="";
        document.all.font1.color='999999';
        document.all.font2.color='999999';
        document.all.font3.color='222222';
        document.all.form_select.value="frm3";
    }
function showGrade(form_name)
{
    var form = document.getElementById(form_name); 
    var guide_code1 = form.guide_code1.value;
    
   if(form==frm1)
   {
    		if(guide_code1=="1000")
    		{ 
    			grade1.style.display="none";
    			grade2.style.display="none";
    			document.all.oldTd.colSpan="3";
    		}
    		else
    		{
    			grade1.style.display="";
    			grade2.style.display="";
    			document.all.oldTd.colSpan="1";
    		}
   }
   if(form==frm2)
   {
    		if(guide_code1=="1000")
    		{
    			grade3.style.display="none";
    			grade4.style.display="none";
    			document.all.oldTd2.colSpan="3";
    		}
    		else
    		{
    			grade3.style.display="";
    			grade4.style.display="";
    			document.all.oldTd2.colSpan="1";
    		}
   }
   if(form==frm3)
   {
    		if(guide_code1=="1000")
    		{
    			grade5.style.display="none";
    			grade6.style.display="none";
    			document.all.oldTd3.colSpan="3";
    		}
    		else
    		{
    			grade5.style.display="";
    			grade6.style.display="";
    			document.all.oldTd3.colSpan="1";
    		}
   }
   
}
</script>
<!----------------------------------ҳͷ��ʾ����----------------------------------------->

<body>
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		
    <table cellSpacing="0">
    	<tr>
       <td><a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs1()" value="frm1">&nbsp;&nbsp;<font id="font1" color='222222'>����&nbsp;&nbsp;</font></a></TD>
       <td><a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs2()" value="frm2">&nbsp;&nbsp;<font id="font2" >�޸�&nbsp;&nbsp;</font></a></TD>
       <td><a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs3()" value="frm3">&nbsp;&nbsp;<font id="font3" >ɾ��&nbsp;&nbsp;</font></a></TD>
       <td width="80%"></td> 
    	</tr>
    </table>
   
        <input type="hidden"  name="region_code" value="<%=regionCode%>" >
        <input type="hidden"  name="form_select" value="frm1" >

   <div id=tbs1 style="display:''">
    <form name="frm1" method="post" action="">
        <input type="hidden"  name="request_privs" value="1" >
        <input type="hidden"  name="faq_id" value="" >
         <input type="hidden"  name="grade_id" value="" >
         <input type="hidden"  name="grade_name" value="" >
         <input type="hidden"  name="range_name" value="" >
         
     <table cellSpacing="0">
         <tr> 
           <td class="blue">�����</td>
           <td id="oldTd"> 
                <select  name="guide_code1" index="1" onchange="chgNewSm()"> 
                    <option  value="">-��ѡ��-</option>
                    <option  value="1000">25������</option>
                    <option  value="1001">25������</option>
                </select>
                <font color="orange">*</font>
           </td>
          
           <TD  class="blue" id=grade1><div>���ѵ���</div></TD>
           <td id=grade2>
           		<div>
                    <select  name="mode_grade" >
                     </select>
                <font color="orange">*</font>  
                </div>
          </td> 
          
         </tr>
          <tr> 
            <td class="blue">ҵ��Ʒ��</td>
             <td nowrap> 
              <input type="text" name="sm_name" maxlength="30" value="" readonly />
              <input type="hidden" name="sm_code"  value="" >
              <font color="orange">*</font>&nbsp;    
             <input type="button" value="��ѯ" class="b_text" onclick="getModeOrder('frm1')" >
             </td>
             <td class="blue">����</td>
             <td >
                  <input type="text" name="district_name" maxlength="30" value="" class="InputGrey" readonly>
                  <input type="hidden" name="guide_code2"  value="" >
               </td>
         </tr>

         <TR> 
<%
    if("99".equals(regionCode))
    {  
%>
	          <TD class="blue">�ʷ�ѡ��</TD>
	          <TD>
	                <input type="button" value="��ѯ" class="b_text" onClick="getModeCode3('frm1')">
	                <input type="hidden" name="mode_code" maxlength="30" value="00000000" >
	          </TD>                  
<%
    }
    else
    {
%>    
              <TD class="blue">�ʷѴ���</TD>
              <TD colspan="3">
                    <input type="text" name="mode_code" maxlength="30" value="" readonly>&nbsp;
                    <font color="orange">*</font>&nbsp;               
                    
                    <input type="button" value="��ѯ" class="b_text" onClick="getModeCode('frm1')">
              </TD>
<%
    }
%> 
                            
             </TR>
             <TR> 
                    <TD class="blue">�ʷ�����</TD>
                    <TD colspan="3">
                        <input type="text" name="mode_name" v_type="string" v_must="1"
                        	 v_minlength="0" v_maxlength="30"  size="67" maxlength="15" value="" readonly >&nbsp;
                        <font color="orange"> *</font>
                    </TD>                   
             </TR>
             
             <TR> 
                    <TD class="blue"> �ʷ�˵��</TD>
                    <TD colspan="3">
                        <textarea rows="5" cols="69" name="mode_note"  v_must="1"  v_minlength="0"  
                        		v_maxlength="600"  maxlength="300" readonly></textarea>
                    </TD>                   
             </TR>
    		<tr>
		       <td class="blue">�����</td>
                <td >
                       <input type="text" name="month_fee"   v_type="string2" v_must="1" v_minlength="0" v_maxlength="60" size="35" maxlength="30" value="" />
                      <font color="orange"> *</font>
                </td>
		       <td class="blue">������ʾ</td>
                <td>
                    <input type="text" name="call_disp"   v_type="string2"  v_must="1" v_minlength="0" v_maxlength="60" size="35" maxlength="30"  value="" />
                    <font color="orange"> *</font>
                </td>                                   
	     </tr>             
	 
	    <tr>
	       <td class="blue">�µ�������(��ʹ�÷�)</td>
                <td>
                   <input type="text" name="base_line"   v_type="string2"  v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30" value="" />
                   <font color="orange"> *</font>
                </td>
		       <td class="blue"> ���ػ�������</td>
                <td >
                    <input type="text" name="local_call_send"   v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30"  value="" />
                    <font color="orange"> *</font>
                </td>                                   
     	</tr>                
   		 <tr>
       			<td class="blue">���ر���</td>
                <td >
                   <input type="text" name="local_call_recv"   v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30" value="" />
                   <font color="orange"> *</font>
                </td>
		       <td class="blue">�������й��ڳ�;</td>
                <td >
                    <input type="text" name="local_long_send"   v_type="string2" v_must="1" v_minlength="0" v_maxlength="60" v_name="�������й��ڳ�;" size="35" maxlength="30"  value="" />
                    <font color="orange"> *</font>
                </td>                                   
     </tr>               

    <tr>
       <td class="blue"> ʡ����������</td>
                <td >
                       <input type="text" name="province_call_send"  v_type="string2"  v_must="1" v_minlength="0" v_maxlength="60" v_name="ʡ����������" size="35" maxlength="30" value="" />
                       <font color="orange"> *</font>
                </td>
       <td class="blue"> ʡ�����α���</td>
                <td >
                        <input type="text" name="province_call_recv"  v_type="string2"  v_must="1" v_minlength="0" v_maxlength="60" v_name="ʡ�����α���" size="35" maxlength="30"  value="" />
                        <font color="orange"> *</font>
                </td>                                   
     </tr>  

    <tr>
       <td class="blue"> ʡ����������</td>
                <td >
                       <input type="text" name="interprov_call_send"   v_type="string2" v_must="1" v_minlength="0" v_maxlength="60" v_name="ʡ����������" size="35" maxlength="30" value="" />
                       <font color="orange"> *</font>
                </td>
       <td class="blue"> ʡ�����α���</td>
                <td >
                        <input type="text" name="interprov_call_recv"   v_type="string2" v_must="1" v_minlength="0" v_maxlength="60" v_name="ʡ�����α���" size="35" maxlength="30"  value="" />
                        <font color="orange"> *</font>
                </td>                                   
     </tr>

    <tr>
       <td class="blue"> �۰�̨��;</td>
                <td >
                       <input type="text" name="hk_mac_tw_call"  v_type="string2" v_must="1" v_minlength="0" v_maxlength="60" v_name="�۰�̨��;" size="35" maxlength="30" value="" />
                       <font color="orange"> *</font>
                </td>
       <td class="blue"> ���ʳ�;</td>
                <td >
                        <input type="text" name="intl_call"  v_type="string2" v_must="1" v_minlength="0" v_maxlength="60" v_name="���ʳ�;" size="35" maxlength="30"  value="" />
                        <font color="orange"> *</font>
               </td>                                   
     </tr>

    <tr>
       <td class="blue"> ����</td>
                <td >
                       <input type="text" name="short_msg"  v_type="string2" v_must="1" v_minlength="0" v_maxlength="60" v_name="����" size="35" maxlength="30" value="" />
                       <font color="orange"> *</font>
                </td>
       <td class="blue"> ����</td>
                <td >
                        <input type="text" name="color_msg"  v_type="string2" v_must="1" v_minlength="0" v_maxlength="60" v_name="����" size="35" maxlength="30"  value="" />
                        <font color="orange"> *</font>
                </td>                                   
     </tr>

    <tr>
       <td class="blue"> GPRS/WAP</td>
                <td >
                       <input type="text" name="gprs_wap"  v_type="string2" v_must="1" v_minlength="0" v_maxlength="60" v_name="GPRS/WAP" size="35" maxlength="30" value="" />
                       <font color="orange"> *</font>
                </td>
       <td class="blue"> ����ҵ��</td>
                <td >
                        <input type="text" name="present_src"  v_type="string2" v_must="1" v_minlength="0" v_maxlength="100" v_name=" ����ҵ��" size="35" maxlength="50"  value="" />
                        <font color="orange"> *</font>
                </td>                                   
     </tr>
                       
             <tr> 
                <td class="blue">�ʷѿɼ���Χ</td>
                <td colspan="3"> 
                     <input type="radio" name="privs" value="0" onclick="changePrivs('frm1')" > ��½�ͻ�
                     <input type="radio" name="privs" value="1" onclick="changePrivs('frm1')" checked > ����
                     <font color="orange"> *</font>
                 </td>                              
             </tr>
                          
     <!------------------------------------------------------------------>
        <tr>
          <TD colspan="4" id="footer">
             <input class="b_foot" name=submit1 type=button  onclick="doAdd()" value=����>
             <input class="b_foot" name=1111   type=button  onClick="toclean()" value=���>
             <input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
          </TD>
        </TR>
     </table>
    </form>
   </div>
<!-- --------------------div2----------------------------- -->      
   <div id=tbs2 style="display:none">
    <form name="frm2" method="post" action="">
        <input type="hidden" name="mode_id" value="" >
        <input type="hidden"  name="request_privs" value="1" onpropertychange="chgContent('frm2')">
        <input type="hidden"  name="grade_id" value="" >
         <input type="hidden"  name="grade_name" value="" >
         <input type="hidden"  name="range_name" value="" >
        
     <table  cellSpacing="0">
         <tr> 
           <td class="blue">�����</td>
           <td id="oldTd2"> 
                <select  name="guide_code1" index="1" onchange="chgNewSm()"> 
                    <option  value="">-��ѡ��-</option>
                    <option  value="1000">25������</option>
                    <option  value="1001">25������</option>
                </select>
           </td>
           <TD  class="blue" id =grade3><div>���ѵ���</div></TD>
           <td id =grade4>
           	  <div>
                    <select  name="mode_grade"  >
                     </select>
              </div>  
           </td>    
         </tr>
          <tr> 
            <td class="blue">ҵ��Ʒ��</td>
             <td nowrap> 
              <input type="text" name="sm_name" maxlength="30" value="" readonly="readonly" />
              <input type="hidden" name="sm_code"  value="" >
              <input type="button" value="��ѯ" class="b_text" onclick="getModeOrder('frm2')" >     
             </td>
             <td class="blue">����</td>
             <td >
                  <input type="text" name="district_name" maxlength="30" value="" readonly="readonly">
                  <input type="hidden" name="guide_code2"  value="" >
               </td>
         </tr>


             <TR> 
<%
    if("99".equals(regionCode))
    {  
%>
                  <TD class="blue">�ʷ�ѡ��</TD>
                  <TD>
                        <input type="button" value="��ѯ" class="b_text" onClick="getModeCode4('frm2')">
                        <input type="hidden" name="mode_code" maxlength="30" value="00000000" >
                  </TD>                  
<%
    }
    else
    {
%>    
                  <TD class="blue">�ʷѴ���</TD>
                  <TD colspan="3">
                        <input type="text" name="mode_code" maxlength="30" value="" readonly>&nbsp;<font color="orange">*</font>               
                        <input type="button" value="��ѯ" class="b_text" onClick="getModeCode2('frm2')">
                  </TD>
<%
    }
%> 
                                 
             </TR>
            
             <TR> 
                    <TD class="blue">�ʷ�����</TD>
                    <TD colspan="3">
                        <input type="text" name="mode_name" v_type="string" v_must="1" v_minlength="0"
                        	 v_maxlength="30"  size="67" maxlength="15"  value="" readonly>&nbsp;
                        <font color="orange"> *</font>
                    </TD>                   
             </TR>
             
             <TR> 
                    <TD class="blue"> �ʷ�˵��</TD>
                    <TD colspan="3">
                        <textarea rows="5" cols="69" name="mode_note"  v_minlength="0"  
                        		v_maxlength="600"   maxlength="300" readonly></textarea>
                    </TD>                   
             </TR>
             
    <tr>
       <td class="blue">����</td>
                <td >
                       <input type="text" name="month_fee"   v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30" value="" />
                      <font color="orange"> *</font>
                </td>
       <td class="blue"> ������ʾ</td>
                <td >
                        <input type="text" name="call_disp"    v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30"  value="" />
                        <font color="orange"> *</font>
                </td>                                   
     </tr>             
 
    <tr>
       <td class="blue"> �µ�������(��ʹ�÷�)</td>
                <td >
                       <input type="text" name="base_line"   v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30" value="" />
                       <font color="orange"> *</font>
                </td>
       <td class="blue"> ���ػ�������</td>
                <td >
                        <input type="text" name="local_call_send"   v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30"  value="" />
                        <font color="orange"> *</font>
                </td>                                   
     </tr>                

    <tr>
       <td class="blue"> ���ر���</td>
                <td >
                       <input type="text" name="local_call_recv"   v_type="string2" v_must="1" v_minlength="0" v_maxlength="60" size="35" maxlength="30" value="" />
                       <font color="orange"> *</font>
                </td>
       <td class="blue"> �������й��ڳ�;</td>
                <td >
                        <input type="text" name="local_long_send"   v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30"  value="" />
                        <font color="orange"> *</font>
                </td>                                   
     </tr>               

    <tr>
       <td class="blue"> ʡ����������</td>
                <td >
                       <input type="text" name="province_call_send"   v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30" value="" />
                       <font color="orange"> *</font>
                </td>
       <td class="blue"> ʡ�����α���</td>
                <td >
                        <input type="text" name="province_call_recv"  v_type="string2"  v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30"  value="" />
                        <font color="orange"> *</font>
                </td>                                   
     </tr>  

    <tr>
       <td class="blue"> ʡ����������</td>
                <td >
                       <input type="text" name="interprov_call_send"   v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30" value="" />
                       <font color="orange"> *</font>
                </td>
       <td class="blue"> ʡ�����α���</td>
                <td >
                        <input type="text" name="interprov_call_recv"   v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30"  value="" />
                        <font color="orange"> *</font>
                </td>                                   
     </tr>

    <tr>
       <td class="blue"> �۰�̨��;</td>
                <td >
                       <input type="text" name="hk_mac_tw_call"  v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30" value="" />
                       <font color="orange"> *</font>
                </td>
       <td class="blue"> ���ʳ�;</td>
                <td >
                        <input type="text" name="intl_call"  v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30"  value="" />
                        <font color="orange"> *</font>
               </td>                                   
     </tr>

    <tr>
       <td class="blue"> ����</td>
                <td >
                       <input type="text" name="short_msg"  v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30" value="" />
                       <font color="orange"> *</font>
                </td>
       <td class="blue"> ����</td>
                <td >
                        <input type="text" name="color_msg"  v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30"  value="" />
                        <font color="orange"> *</font>
                </td>                                   
     </tr>

    <tr>
       <td class="blue"> GPRS/WAP</td>
                <td >
                       <input type="text" name="gprs_wap"  v_type="string2" v_must="1" v_minlength="0" v_maxlength="60"  size="35" maxlength="30" value="" />
                       <font color="orange"> *</font>
                </td>
       <td class="blue"> ����ҵ��</td>
                <td >
                        <input type="text" name="present_src"  v_type="string2" v_must="1" v_minlength="0" v_maxlength="100"  size="35" maxlength="50"  value="" />
                        <font color="orange"> *</font>
                </td>                                   
     </tr>
             
             
             <TR> 
                <td class="blue">�ʷѿɼ���Χ</td>
                <td colspan="3"> 
                     <input type="radio" name="privs" value="0" onclick="changePrivs('frm2')" > ��½�ͻ�
                     <input type="radio" name="privs" value="1" onclick="changePrivs('frm2')" > ����
                     <font color="orange"> *</font>
                 </td>                              
             </TR>
     <!------------------------------------------------------------------>
        <tr>
          <TD colspan="4" id="footer">
             <input class="b_foot" name=submit1 type=button  onclick="doModify()"value=�޸�>
             <input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
          </TD>
        </tr>
     </table>
     </form>
    </div>
        
<!--  -----------------div3------------------------ -->
   <div id=tbs3 style="display:none">
    <form name="frm3" method="post" action="">
        <input type="hidden" name="mode_id" value="" class="button" >
         <input type="hidden" name="grade_id" value="" class="button" >
         <input type="hidden"  name="grade_name" value="" >
         <input type="hidden"  name="range_name" value="" >
         <input type="hidden"  name="mode_note" value="" >
                
     <table cellSpacing="0">
         <tr> 
           <td class="blue">�����</td>
           <td id=oldTd3> 
                <select  name="guide_code1" index="1" onchange="chgNewSm()"> 
                    <option class="button" value="">-��ѡ��-</option>
                    <option class="button" value="1000">25������</option>
                    <option class="button" value="1001">25������</option>
                </select>
                <font color="orange">*</font>
           </td>
           <TD  class="blue" id =grade5><div>���ѵ���</div></TD>
           <td id =grade6>
           	<div >
                    <select  name="mode_grade" >
                     </select>
                <font color="orange">*</font> 
              </div> 
           </td>    
         </tr>
          <tr> 
            <td class="blue">ҵ��Ʒ��</td>
             <td nowrap> 
              <input type="text" name="sm_name" maxlength="30" value="" readonly />
              <input type="hidden" name="sm_code"  value="" >
              <input type="button" value="��ѯ" class="b_text" onclick="getModeOrder('frm3')" >
             </td>
             <td class="blue">����</td>
             <td >
                  <input type="text" name="district_name" maxlength="30" value="" readonly>
                  <input type="hidden" name="guide_code2"  value="" >
               </td>
         </tr>

             <TR> 
<%
    if("99".equals(regionCode))
    {  
%>
                  <TD class="blue">�ʷ�ѡ��</TD>
                  <TD>
                        <input type="button" value="��ѯ" class="b_text" onClick="getModeCode6('frm3')">
                        <input type="hidden" name="mode_code" maxlength="30" value="00000000" >
                  </TD>                  
<%
    }
    else
    {
%>    
                  <TD class="blue">�ʷѴ���</TD>
                  <TD colspan="3">
                        <input type="text" name="mode_code" maxlength="30" value="" readonly>&nbsp;<font color="orange">*</font>               
                        <input type="button" value="��ѯ" class="b_text" onClick="getModeCode5('frm3')">
                  </TD>
<%
    }
%> 
                                   
             </TR>
            
             <TR> 
                    <TD class="blue">�ʷ�����</TD>
                    <TD colspan="3">
                        <input type="text" name="mode_name" v_type="string" v_must="0" v_minlength="0" 
                        	v_maxlength="15" v_name="�ʷ�����" size="67" maxlength="15" class="button" value="" readonly >&nbsp;
                    </TD>                   
             </TR>

     <!------------------------------------------------------------------>
        <tr>
          <TD colspan="4" id="footer">
             <input class="b_foot" name=submit1 type=button  onclick="doDelete()"value=ɾ��>
             <input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
          </TD>
        </tr>
     </table>
     </form>
    </div>    

 <%@ include file="/npage/include/footer.jsp" %>   

</BODY>
</HTML>
<%/*------------------------javascript��----------------------------*/%>
<script language="javascript">
/*------------------------- public---------------------------*/

function getModeOrder(form_name)
{
    var form = document.getElementById(form_name); 
    var guide_code1 = form.guide_code1.value;
    var mode_grade = form.mode_grade.value;
    
     if (guide_code1=="")
    {
        rdShowMessageDialog("��ѡ������Σ�");
          return false;
    }  
    
    form.mode_note.value="";
    form.mode_name.value="";
   
    var title_name="�����,���ѵ���,ҵ��Ʒ��,���س���";
    var element_name="name,mode_grade,sm_name,district_name";
    var element_return="range_name,grade_name,sm_name,district_name,sm_code,guide_code2,grade_id";
    
    var sql_str="select e.name,b.name,decode(a.sm_code,'gn','ȫ��ͨ','zn','������','dn','���еش�'),decode(a.guide_code2,'c','����','t','����',c.district_name),a.sm_code,a.guide_code2,a.grade_id from dmodeguidegrade a,sModeGuideOption b,sdiscode c,sModeGuideOption e " +
          " where a.region_code = '<%=regionCode%>'  and a.guide_code1=e.code and e.option_type='1'  and b.option_type(+) = '2' and a.mode_grade = b.CODE(+)  and a.region_code = c.region_code(+)   and a.guide_code2 =c.district_code(+)  ";

     if (guide_code1!="")
    {
 		 sql_str=sql_str+" and a.guide_code1 = '"+guide_code1+"'  ";
    }    
    
     if (mode_grade!="")
    {
  		sql_str=sql_str+" and a.mode_grade = '"+mode_grade+"' ";
    }
    else
    	{
    		sql_str=sql_str+" and a.mode_grade = 'N' ";
    	}
       
     sql_str=sql_str+" order by  a.guide_code1,a.mode_grade,a.sm_code,a.mode_order,a.guide_code2";
      
     sql_str = sql_str.replace(/\+/g, '%2B');  
        
    var op_name1="�鿴��¼����Ϣ";
    var request_url = "fpublicQuery.jsp?form_name="+form_name+"&title_num=4&element_num=4&return_num=7&op_name1="+op_name1+"&title_name="+title_name+"&element_name="+element_name+"&element_return="+element_return+"&sql_str="+sql_str;
    window.open(request_url ,"","height=600,width=400,scrollbars=yes");
}

function changePrivs(form_name)
{
    var form = document.getElementById(form_name); 
    for(var i=0; i< form.privs.length; i++)
    {
        if(form.privs[i].checked)
        {
            form.request_privs.value=form.privs[i].value;
        }
    }
}
function chgContent(form_name)
{
   var form = document.getElementById(form_name); 
    var i = form.request_privs.value;
    form.privs[i].checked = true;
    
  var i=0;
  for(i=0;i<2;i++)
  {
  form.mode_note.value=form.mode_note.value.replace("<br>","\r\n"); 
    }
}

/*----------------------------����RPC������������------------------------------------------*/


 onload=function(){
        chgNewSm();
 }
function chgNewSm()
{
     var form = document.getElementById(document.all.form_select.value);

     var region_code = document.all.region_code.value;
     var ageRange = form.guide_code1.value; 
     var myPacket = new AJAXPacket("fpublicRPC.jsp","���ڻ�����ѵȼ���Ϣ�����Ժ�......");
       myPacket.data.add("ageRange",ageRange);
       core.ajax.sendPacket(myPacket);
       myPacket=null;
       
       showGrade(document.all.form_select.value);
}

/*-----------------------------RPC������------------------------------------------------*/
function doProcess(packet)
{
   var triListData = packet.data.findValueByName("tri_list"); 
   var form = document.getElementById(document.all.form_select.value); 
   form("mode_grade").length=0;
   
   if(triListData.length>0)
   {
    form("mode_grade").options.length=triListData.length;//triListData[i].length;

      for(j=0;j<triListData.length;j++)
       {
           form("mode_grade").options[j].text=triListData[j][1];
           form("mode_grade").options[j].value=triListData[j][0];
       }
   
  }
  else
    {
           form("mode_grade").options.length=1;
           form("mode_grade").options[0].text="       ";
           form("mode_grade").options[0].value="";  
    }
  
}



<!-- ---------- for div1------------>
function toclean()
{
   document.frm1.mode_name.value="";
   document.frm1.mode_note.value="";
   document.frm1.month_fee.value="";
   document.frm1.call_disp.value="";
   document.frm1.base_line.value="";
   document.frm1.local_call_send.value="";
   document.frm1.local_call_recv.value="";
   document.frm1.local_long_send.value="";
   document.frm1.province_call_send.value="";
   document.frm1.province_call_recv.value="";
   document.frm1.interprov_call_send.value="";
   document.frm1.interprov_call_recv.value="";
   document.frm1.hk_mac_tw_call.value="";
   document.frm1.intl_call.value="";
   document.frm1.short_msg.value="";
   document.frm1.color_msg.value="";
   document.frm1.gprs_wap.value="";
   document.frm1.present_src.value="";
}
function doAdd()
{   
    getAfterPrompt();
     if (document.frm1.grade_id.value == "") 
    {
        rdShowMessageDialog("��ѡ���ʷѵȼ���");
          return false;
    }
    else if (document.frm1.faq_id.value == "") 
    {
        rdShowMessageDialog("���ѯ��Ҫ���õ��ʷѣ�");
          return false;
    }    
    else if (document.frm1.mode_code.value == "") 
    {
        rdShowMessageDialog("�ʷѴ��벻��Ϊ��!");
          return false;
    }
    else if (!check(frm1)) 
    {
          return false;
    }
    else if (document.frm1.mode_note.value=="") 
    {
        rdShowMessageDialog("�ʷ�˵������Ϊ�գ�");
          return false;
    }
    /*
    else if (document.frm1.mode_note.value.length>300) 
    {
        rdShowMessageDialog("�ʷ�˵�����ȴ���300���ַ���");
          return false;
    }*/
    else
    {
          document.frm1.action="f6208_1.jsp";
          document.frm1.submit();
    }
}
function getModeCode(form_name)
{   
    var sm_code = document.frm1.sm_code.value;
    var region_code= document.all.region_code.value;
    var range_code = document.frm1.guide_code1.value;
    var grade_code = document.frm1.mode_grade.value;
    var dis_code = document.frm1.guide_code2.value;
    
    if(sm_code=="")
    {
        rdShowMessageDialog("��ѡ���ʷѵ����ȼ���");
          return false;     
    }
    
    if(grade_code=="")
    {
    	  grade_code='N';
    }
    
    
    sm_code = replaceSpacialCharacter(sm_code);
    var title_name="�ʷѴ���,�ʷ�����";
    var element_name="mode_code,mode_name";
    var element_return="mode_code,mode_name,mode_note,faq_id";
    
    //var sql_str="select c.mode_code,c.mode_name,c.note,a.faq_id from dfaqmodecode a, sfaqmodecode b, sbillmodecode c where a.faq_id=b.faq_id and b.region_code=c.region_code and b.mode_code=c.mode_code and a.manage_region='"+region_code+"' and a.show_type='0' and a.REQUEST_PRIVS<=8 and sysdate between a.start_time and a.end_time and a.valid_flag='1' and c.SM_CODE='"+sm_code+"' "
                         //+"  and not exists ( select 1 from dmodeguidedetail d, dmodeguidegrade e where d.grade_id=e.grade_id and d.mode_code = b.mode_code and e.region_code ='"+region_code+"' and  e.guide_code1='"+range_code+"' and e.mode_grade = '"+grade_code+"' and e.sm_code = '"+sm_code+"'  and e.guide_code2= '"+dis_code+"' ) order by mode_code";
	var sql_str="select c.offer_id, c.offer_name, c.offer_comments, a.faq_id from dfaqmodecode a, sfaqmodecode b, product_offer c ,band d where a.faq_id=b.faq_id and  to_number(b.mode_code) = c.offer_id and c.band_id = d.band_id and a.manage_region='"+region_code+"' and a.show_type='0' and a.REQUEST_PRIVS<=8 and sysdate between a.start_time and a.end_time and a.valid_flag='1' and d.SM_CODE='"+sm_code+"' "
                         +"  and not exists ( select 1 from dmodeguidedetail d, dmodeguidegrade e where d.grade_id=e.grade_id and d.mode_code = b.mode_code and e.region_code ='"+region_code+"' and  e.guide_code1='"+range_code+"' and e.mode_grade = '"+grade_code+"' and e.sm_code = '"+sm_code+"'  and e.guide_code2= '"+dis_code+"' ) order by c.offer_id";    
    var op_name1="�ʷѴ���ѡ��";
    var request_url = "fpublicQuery.jsp?form_name="+form_name+"&title_num=2&element_num=2&return_num=4&op_name1="+op_name1+"&title_name="+title_name+"&element_name="+element_name+"&element_return="+element_return+"&sql_str="+sql_str;
    window.open(request_url ,"","height=600,width=400,scrollbars=yes");
}
/**����Դ��js/common/common_util.js**/
function replaceSpacialCharacter(source)
{
	source = source.replace("#","%23");
	source = source.replace("&","%26");
	source = source.replace("+","%2b");
	source = source.replace("?","%3f");
	source = source.replace("_","%5f");
	source = source.replace('"',"%22");
	source = source.replace("'","%27");
	return source;
}
function getModeCode3(form_name)
{   
    var sm_code = document.frm1.sm_code.value;
    
    sm_code = replaceSpacialCharacter(sm_code);
    var title_name="���,�ʷ�����";
    var element_name="mode_name";
    var element_return="mode_name,faq_id";
    
    var sql_str="select mode_name,faq_id  from dfaqmodecode where manage_region='99' and show_type='0' and REQUEST_PRIVS<=8 and sysdate between start_time and end_time and valid_flag='1'";
    
    var op_name1="�ʷ�ѡ��";
    var request_url = "fpublicQuery.jsp?form_name="+form_name+"&title_num=2&element_num=1&return_num=2&op_name1="+op_name1+"&title_name="+title_name+"&element_name="+element_name+"&element_return="+element_return+"&sql_str="+sql_str;
    window.open(request_url ,"","height=600,width=400,scrollbars=yes");
}

<!-- -----------for div2---------->
function doModify()
{
	getAfterPrompt();
    if (document.frm2.mode_id.value == "") 
    {
        rdShowMessageDialog("��ѡ��Ҫ�޸ĵ��ʷѣ�");
          return false;
    }
    else if (!check(frm2)) 
    {
          return false;
    }
    else if (document.frm2.mode_note.value=="") 
    {
        rdShowMessageDialog("�ʷ�˵������Ϊ�գ�");
          return false;
    }
    /*
   else if (document.frm2.mode_note.value.length>300) 
    {
        rdShowMessageDialog("�ʷ�˵�����ȴ���300���ַ���");
          return false;
    }*/
    else if (document.frm2.request_privs.value == "") 
    {
        rdShowMessageDialog("�ʷѿɼ���Χ����Ϊ�գ����������룡");
          return false;
    }    
    else
    {
    document.frm2.action="f6208_2.jsp";
    document.frm2.submit();
    }
}
function getModeCode2(form_name)
{   
    
    var form = document.getElementById(form_name); 
    var grade_id = form.grade_id.value;

    grade_id = replaceSpacialCharacter(grade_id);
    var title_name="�ʷѴ���,�ʷ�����";
    var element_name="mode_code,mode_name";
    var element_return="mode_code,mode_name,mode_note,mode_id,request_privs,month_fee,call_disp,base_line,local_call_send,"
                                          +"local_call_recv,local_long_send,province_call_send,province_call_recv,interprov_call_send,interprov_call_recv,"
                                           +"hk_mac_tw_call,intl_call,short_msg,color_msg,gprs_wap,present_src";
                                           
    var sql_str="select mode_code,mode_name,mode_note,mode_id,disp_flag,month_fee,call_disp,base_line,local_call_send,  "
                         +"local_call_recv,local_long_send,province_call_send,province_call_recv,interprov_call_send,interprov_call_recv,"
                           +"hk_mac_tw_call,intl_call,short_msg,color_msg,gprs_wap,present_src "
                           +" from dModeGuideDetail  where grade_id = '"+grade_id+"'";
    
    var op_name1="�ʷѴ���ѡ��";
    var request_url = "fpublicQuery.jsp?form_name="+form_name+"&title_num=2&element_num=2&return_num=21&op_name1="+op_name1+"&title_name="+title_name+"&element_name="+element_name+"&element_return="+element_return+"&sql_str="+sql_str;
    window.open(request_url ,"","height=600,width=400,scrollbars=yes");

}
function getModeCode4(form_name)
{   
    
    var form = document.getElementById(form_name); 
    var grade_id = form.grade_id.value;

    grade_id = replaceSpacialCharacter(grade_id);
    var title_name="���,�ʷ�����";
    var element_name="mode_name";
    
    var element_return="mode_name,mode_note,mode_id,request_privs,month_fee,call_disp,base_line,local_call_send,"
                                          +"local_call_recv,local_long_send,province_call_send,province_call_recv,interprov_call_send,interprov_call_recv,"
                                           +"hk_mac_tw_call,intl_call,short_msg,color_msg,gprs_wap,present_src";
                                           
    var sql_str="select mode_name,mode_note,mode_id,disp_flag,month_fee,call_disp,base_line,local_call_send,  "
                         +"local_call_recv,local_long_send,province_call_send,province_call_recv,interprov_call_send,interprov_call_recv,"
                           +"hk_mac_tw_call,intl_call,short_msg,color_msg,gprs_wap,present_src "
                           +" from dModeGuideDetail  where grade_id = '"+grade_id+"'";



    var op_name1="�ʷѴ���ѡ��";
    var request_url = "fpublicQuery.jsp?form_name="+form_name+"&title_num=2&element_num=1&return_num=20&op_name1="+op_name1+"&title_name="+title_name+"&element_name="+element_name+"&element_return="+element_return+"&sql_str="+sql_str;
    window.open(request_url ,"","height=600,width=400,scrollbars=yes");
}
<!-- -----------for div3---------->
function doDelete()
{   
	getAfterPrompt();
    if (document.frm3.mode_id.value == "")
    {
        rdShowMessageDialog("��ѡ��Ҫɾ���ļ�¼��");
        return false;
    }
    else if (rdShowConfirmDialog("ȷ��ɾ���˼�¼��")==1)
    {
        document.frm3.action="f6208_3.jsp";
        document.frm3.submit();
    }
    else
    {
        return;
    }
}
function getModeCode5(form_name)
{   
    
    var form = document.getElementById(form_name); 
    var grade_id = form.grade_id.value;

    grade_id = replaceSpacialCharacter(grade_id);
    var title_name="�ʷѴ���,�ʷ�����";
    var element_name="mode_code,mode_name";
    var element_return="mode_code,mode_name,mode_id";
                                           
    var sql_str="select mode_code,mode_name,mode_id  from dModeGuideDetail  where grade_id = '"+grade_id+"'";
    
    var op_name1="�ʷѴ���ѡ��";
    var request_url = "fpublicQuery.jsp?form_name="+form_name+"&title_num=2&element_num=2&return_num=3&op_name1="+op_name1+"&title_name="+title_name+"&element_name="+element_name+"&element_return="+element_return+"&sql_str="+sql_str;
    window.open(request_url ,"","height=600,width=400,scrollbars=yes");

}
function getModeCode6(form_name)
{   
    
    var form = document.getElementById(form_name); 
    var grade_id = form.grade_id.value;

    grade_id = replaceSpacialCharacter(grade_id);
    var title_name="���,�ʷ�����";
    var element_name="mode_name";
    var element_return="mode_name,mode_id";
                                           
    var sql_str="select mode_name,mode_id  from dModeGuideDetail  where grade_id = '"+grade_id+"'";
    
    var op_name1="�ʷѴ���ѡ��";
    var request_url = "fpublicQuery.jsp?form_name="+form_name+"&title_num=2&element_num=1&return_num=2&op_name1="+op_name1+"&title_name="+title_name+"&element_name="+element_name+"&element_return="+element_return+"&sql_str="+sql_str;
    window.open(request_url ,"","height=600,width=400,scrollbars=yes");

}
</script>
