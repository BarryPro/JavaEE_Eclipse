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
		String regionCode= (String)session.getAttribute("regCode");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
  onload=function()
  {
  
  }

 function doCfm(){

 				
	    	if(!checkElement(document.all.sr_phone)){
						return false;
					}    
	     
	      	 var banlitype = $("#banlitype").val();	
 
	     if(banlitype=="01")   {//����

	 			var sr_phones = $("#sr_phone").val();				
				if(sr_phones.trim()=="") {
	        rdShowMessageDialog("�������ֻ����벻��Ϊ�գ�");
   			  return false;					
				}
					 	
	 					var sr_cardno = $("#sr_cardno").val();				
				if(sr_cardno.trim()=="") {
	       // rdShowMessageDialog("������֤�����벻��Ϊ�գ�");
   			 // return false;					
				}
	 			
	    }
	     
	     else if(banlitype=="02")   {//tihuan

	 			var sr_phones = $("#sr_phone").val();				
				if(sr_phones.trim()=="") {
	        rdShowMessageDialog("�������ֻ����벻��Ϊ�գ�");
   			  return false;					
				}
					 	
	 					var sr_cardno = $("#sr_cardno").val();				
				if(sr_cardno.trim()=="") {
	       // rdShowMessageDialog("������֤�����벻��Ϊ�գ�");
   			 // return false;					
				}
	 			
	    }
	    else if(banlitype=="03")   {//xiugai
				 	
	 				var sr_cardno = $("#sr_cardno").val();				
				if(sr_cardno.trim()=="") {
	       // rdShowMessageDialog("������֤�����벻��Ϊ�գ�");
   			  //return false;					
				}
	 			
	    }
	    
	    if(banlitype!="01")   {//����
	    	var xuanzhongsrephone = $("#srephonenumber").val();	
	    	if(xuanzhongsrephone=="") {
	    		rdShowMessageDialog("��ѡ��Ҫ�����������˺��룡");
   			  return false;			
	    		}
	    	}
	    		
				document.form1.confirm.disabled=true;
	     
				document.form1.action = "fm181Cfm.jsp";
   			document.form1.submit();
   		
 }
 
		
		function listtype()
{
		var phoneNo = $("#sr_phone").val();
		
		if(!checkElement(document.all.sr_phone)){
			return false;
		}

		if(phoneNo.trim()!="") {
    var myPacket = new AJAXPacket("queryCustname.jsp", "���ڲ�ѯ�ͻ���Ϣ�����Ժ�......");
    myPacket.data.add("phoneNo", phoneNo);
    core.ajax.sendPacket(myPacket,doShowName);
    myPacket = null;
    }
}

function doShowName(packet){
  var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
  var custname = packet.data.findValueByName("custname");
  if(retCode!="000000"){
    rdShowMessageDialog("ȡ�û�������������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    return false;
  }else{			
			$("#sr_name").val(custname);
  }
}

function returnvalues(srephonenumber) {
	
	$("#srephonenumber").val(srephonenumber);	
		
}

 	function resetPage(){
 		window.location.href = "fm181.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
	}
	
	function opchange(){
		
 	 var banlitype = $("#banlitype").val();	
 
	 if(banlitype=="01")   {
	 	
 				var markDiv=$("#showTab"); 
				markDiv.empty();
				
				$("#shourangreninfo").show();
				$("#srephonenumber").val("");	
				$("#zhengjianleide").show();

				
	}else {
			if(banlitype=="02")   {
				$("#shourangreninfo").show();
			}else {
				$("#shourangreninfo").hide();
			}
			
			if(banlitype=="04" || banlitype=="05") {
				$("#zhengjianleide").hide();
			}else {
				$("#zhengjianleide").show();
			}
			
			
			
			$("#srephonenumber").val("");
	var myPacket = new AJAXPacket("fm181Qry.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
	myPacket.data.add("phone_no",$("#zr_phone").val());
	myPacket.data.add("banlitype","00");

	core.ajax.sendPacketHtml(myPacket,querinfo,true);
	getdataPacket = null;
	
	}   

 }
 
  				function querinfo(data){
				//�ҵ���ӱ���div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}
		
function relatLink_m185(){
		parent.parent.parent.L('2','m185','����ת��','sm181/fm185.jsp','1');
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
            <td colspan="3"> 
            <div align="left"> 
                <input class="InputGrey" type="text" name="zr_phone" id="zr_phone" v_must="1" v_type="mobphone" v_must=1 value="<%=activePhone%>"  maxlength=11 index="3" readonly />
                </div>
            </td>
         
       
         </tr>
                  <tr id="shourangreninfo" > 
            <td width="16%"  > 
              <div align="left" class="blue">�������ֻ�����</div>
            </td>
            <td > 
            <div align="left"> 
                <input   type="text"  name="sr_phone" id="sr_phone" v_minlength=1 v_maxlength=16 v_type="mobphone"   maxlength="11"  value =""  onBlur="listtype()">
                <font class='orange'>*</font>
                </div>
            </td>
                     <td width="16%"  > 
              <div align="left" class="blue">����������</div>
            </td>
            <td > 
            <div align="left"> 
                <input class="InputGrey" type="text" name="sr_name" id="sr_name"  readOnly />
                </div>
            </td>
       
         </tr>
         		       <TR  id='zhengjianleide'> 
	          <TD width="16%" class="blue">������֤������</TD>
              <TD >
							<select id="sr_zjlx" name="sr_zjlx"  style="width:180px;">
						<option value="01">���֤��</option>
						<option value="02">����</option>
						<option value="03">�й������ž����˱��Ͽ�</option>
						<option value="04">����֤</option>
						<option value="05">�侯����֤</option>
						<option value="06">ʿ��֤</option>
						<option value="07">����ѧԱ֤</option>
						<option value="08">������ְ�ɲ�֤</option>
						<option value="09">���������ݸɲ�֤</option>
						<option value="10">�۰ľ��������ڵ�ͨ��֤</option>
						<option value="11">�л����񹲺͹������۰�ͨ��֤</option>
						<option value="12">̨�����������½ͨ��֤</option>
						<option value="13">��½��������̨��ͨѶ֤</option>
						<option value="14">����˾���֤</option>
						<option value="15">����˳��뾳֤</option>
						<option value="16">�⽻��֤</option>
						<option value="17">���¹�֤</option>
						<option value="18">��Ա֤</option>
						<option value="19">�⽻�����ߵ���������֤��</option>

							</select>
	          </TD>
	                             <td width="16%"  > 
              <div align="left" class="blue">������֤������</div>
            </td>
            <td > 
            <div align="left"> 
                <input  type="text" name="sr_cardno" id="sr_cardno"  value="" />
                <font class='orange'></font>
                </div>
            </td>
         </TR> 

		       <TR  > 
	          <TD width="16%" class="blue">��������</TD>
              <TD colspan="3">
							<select id="banlitype" name="banlitype" onChange="opchange()">
						<option value="01">����</option>
						<option value="02">�滻</option>
						<option value="03">�޸�</option>
						<option value="04">ͣ��</option>
						<option value="05">����</option>

							</select>
	          </TD>
	        
         </TR> 
	</table>

	<div id="showTab" ></div>
	

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="���" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
      <input type="hidden" name="srephonenumber" id="srephonenumber" />
      <input type="hidden" name="loginAccept" id="loginAccept" value="<%=loginAccept%>" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
       <div class="relative_link">
					<span>������ӣ�</span><a href="#" onclick="relatLink_m185()">m185������ת�� </a>
				</div>
   </form>
</body>
</html>