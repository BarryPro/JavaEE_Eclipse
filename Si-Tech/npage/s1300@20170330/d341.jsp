<%
/********************
 version v2.0
������: si-tech
*
*update:liutong@2008-8-15
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>



<%
		/**ArrayList arr = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfo = (String[][])arr.get(0);
		String workno = baseInfo[0][2];
		String workname = baseInfo[0][3];
		String org_code = baseInfo[0][16];
		String belongName = baseInfo[0][16];
		String[][] password = (String[][])arr.get(4);//��ȡ�������� 
		String pass = password[0][0];
		String[][] info1 = (String[][])arr.get(1);
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		**/
		String opCode = "d341";
		String opName = "���Žɷѳ�Ա��ϸ��ѯ";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		
		
%>
<HTML><HEAD>

<script language="JavaScript">
<!--	
  
   function doProcess(packet)
  {
     if(document.frm.contractno.value=="")
      {
			rdShowMessageDialog("�������ʻ�����!");
			document.frm.contractno.focus();
			return false;
     }
    var retResult=packet.data.findValueByName("retResult");
	if(retResult == "false")
	  {
	rdShowMessageDialog("�ͻ�������ڼ�,���޸����룡");
      }
    docheck(); 
  }
  function getpasswd(){
  	if(document.all.contractno.value.trim().len()==0){
  		rdShowMessageDialog("�ʻ����벻��Ϊ��!");
  		return false;
  	}
  	 
   	var myPacket = new AJAXPacket("getpasswd_group.jsp","���ڲ�ѯ�ͻ������Ժ�......");
		myPacket.data.add("contractNo",(document.all.contractno.value).trim());
		myPacket.data.add("busyType",(document.all.busy_type.value).trim());
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	//xl ��������Ҫ�󣬵�������ѯ���󣬽�����ѯ����Ϊ����ѡ״̬��
	 
	document.frm.query.disabled = true;
  }
  
  

 function init()
 {
    document.frm.contractno.focus();   
 }
 function doclear() {
 		frm.reset();
 }
-->
 </script> 
 
<title>������BOSS-�����˺Žɷ�</title>
</head>
<BODY  onLoad="init()" >
<FORM action="" method="post" name="frm"  >
<input type="hidden" name="busy_type"  value="2">
<input type="hidden" name="op_code"  value="d340">
<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
<input type="hidden" name="billdate"  value="<%=dateStr.substring(0,6)%>">
<input type="hidden" name="water_number"  >
<input type="hidden" name="phoneNo"  value="" >
    
 <%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">���ų�Ա��ϸ</div>
		</div>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td class="blue" width="15%">��ѯ��ʽ</td>
                  <td colspan="3"> 
                    
                    <input name="busyType1" type="radio"   value="2"  checked>
                    �ʻ����� 
                    
					</td>
                 </tr>   
                </tbody> 
              </table>
              <table cellspacing="0" >
                <tr> 
                  <td  class="blue" width="15%">�ʻ�����</td>
                  <td> 
                    <input type="text" name="contractno" size="20" maxlength="20" style="ime-mode:disabled"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) getpasswd();" index="5">
                  </td>
                  <td nowrap> </td>
                  <td> 
                   </td>
 				</tr>
              </table>
         
        <TABLE cellSpacing="0">
          <TR > 
            <TD noWrap colspan="6" id="footer"> 
              <div align="center"> 
                <input type="button" name="query"  class="b_foot" value="��ѯ" onclick="getpasswd()"  >
                &nbsp;
                <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
             
                &nbsp;
               <input type="button" name="return2" class="b_foot" value="�ر�" onClick="parent.removeTab('<%=opCode%>');"  >
              </div>
            </TD>
          </TR>
        </TABLE>
      
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
  
</FORM>
<SCRIPT LANGUAGE="JavaScript">
<!--
var h=480;
var w=650;
var t=screen.availHeight/2-h/2;
var l=screen.availWidth/2-w/2;
var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";


 

 

 
 function docheck()
 {
	document.frm.action="sd341Qry.jsp";
    document.frm.submit();
}

//-->
</SCRIPT>

</BODY>
</HTML>
