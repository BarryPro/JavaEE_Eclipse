<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)[2017/3/7 ���ڶ� 11:17:00]------------------
 
 
 -------------------------��̨��Ա��[liyang]--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");

	System.out.println("-------douming---------opName----------555111115555------>"+opName);
        
  String countTotalSql = "select store_money from sstoretype where substr(store_type,1,1) = 'd' order by store_money asc";
         
%>   

  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=countTotalSql%>" />
	</wtc:service>
	<wtc:array id="result_countTotal" scope="end"    />
		

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>


//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}


function go_Cfm(){
 		
		if(!check(msgFORM)) return false;
		
		if($("#ipt_Count").val().trim().length<2){
			  rdShowMessageDialog("������������С��10");
			  return;
		}
		
    var packet = new AJAXPacket("fm456_Cfm.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("sel_CountTotal",$("#sel_CountTotal").val());//
        packet.data.add("sel_ChannelType",$("#sel_ChannelType").val());//
        packet.data.add("sel_CardType",$("#sel_CardType").val());//
        packet.data.add("sel_Payment",$("#sel_Payment").val());//
        packet.data.add("ipt_IDValue",$("#ipt_IDValue").val());//
        packet.data.add("ipt_Count",$("#ipt_Count").val());//
        packet.data.add("ipt_Publickey",$("#ipt_Publickey").val());//
        packet.data.add("ipt_Barepublickey",$("#ipt_Barepublickey").val());//
        	
    core.ajax.sendPacket(packet,do_Cfm);
    packet =null;	 	
}

function do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//�����ɹ�
    	rdShowMessageDialog("�����ɹ�����ȴ���ѯ���",2);
    	var res_accept =  packet.data.findValueByName("res_accept");
    	$("#span_accept").text(res_accept);
    	
    	$("#div_qry").hide();
    	$("#div_result").show();
    }
}


function go_QryFiel(){
    var packet = new AJAXPacket("fm456_QryFiel.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("res_accept",$("#span_accept").text().trim());//
        
    core.ajax.sendPacket(packet,do_QryFiel);
    packet =null;	 	
	
}

function do_QryFiel(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//�����ɹ�
    	rdShowMessageDialog("��ѯ�ɹ��������ˮ��������",2);
    	var j_fileName =  packet.data.findValueByName("fileName");
    	
    	j_fileName = "20170303113638.txt";//д������
    	
    	$("#btn_QryFiel").attr("disabled","disabled");
    	var acceptText = $("#span_accept").text().trim();
    	$("#btn_QryFiel").parent().prev().html("<a href='javascript:void(0)' onclick='go_downFile(\""+j_fileName+"\")'>"+acceptText+"</a>");
    }
}

function go_downFile(j_fileName){
	 document.msgFORM.action="fm456_DownFile.jsp?opCode=<%=opCode%>&opName=<%=opName%>&j_fileName="+j_fileName;
 	 document.msgFORM.submit();	
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	


<div id="div_qry" >
<div class="title"><div id="title_zi"><%=opName%></div></div>

<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">�û�����</td>
		  <td width="35%">
			    <select id="sel_ChannelType" name="sel_ChannelType"  >
					    <option value="10">����������</option>
					    <option value="11">���ſͻ�����</option>
					</select>
		  </td>
		  <td class="blue" width="15%">��ҵ������</td>
		  <td>
			   <select id="sel_CardType" name="sel_CardType"  >
					    <option value="00">���ѳ�ֵ��</option>
						</select>  
		  </td>
	</tr>

	<tr>
	    <td class="blue" width="15%">���</td>
		  <td width="35%">
		  	<select id="sel_CountTotal" name="sel_CountTotal" >
<%
					for(int i=0;i<result_countTotal.length;i++){
%>					
						<option value="<%=result_countTotal[i][0]%>"><%=result_countTotal[i][0]%></option>
<%					
					}
%>		  		
				</select>
		  </td>
		  <td class="blue" width="15%">֧����ʽ</td>
		  <td>
			   <select id="sel_Payment" name="sel_Payment"  >
					    <option value="0">�ֽ�֧��</option>
						</select>  
		  </td>
	</tr>
	
	<tr>
	    <td class="blue" width="15%">�����ֻ�����</td>
		  <td width="35%">
			    <input type="text" id="ipt_IDValue" name="ipt_IDValue" value="13704500050"  v_must="1" v_type="mobphone"  maxlength="11" onblur = "checkElement(this)"  />
		  </td>
		  <td class="blue" width="15%">��������</td>
		  <td>
			    <input type="text" id="ipt_Count" name="ipt_Count" value="50"  v_must="1" v_type="0_9"  onblur = "checkElement(this)"  />
		  </td>
	</tr>	
	
		<tr>
	    <td class="blue" width="15%">�㹫Կ</td>
		  <td colspan="3">
		  	<input type="text" id="ipt_Barepublickey" name="ipt_Barepublickey" v_must="1"   />
		  </td>
		</tr>	
		
		<tr>
	    <td class="blue" width="15%">��Կ</td>
		  <td colspan="3">
		  	<input type="text" id="ipt_Publickey"     name="ipt_Publickey"    v_must="1"   />
		  </td>
		</tr>	
			
</table>
</div>

<div id="div_result" style="display:none">
	<div class="title"><div id="title_zi">���������ѯ</div></div>	
	<table cellSpacing="0">
		<tr>
		    <td class="blue" width="25%">������ˮ</td>
		    <td width="25%">
		    	<span id="span_accept"></span>
		    </td>	
		    <td id="td_qryFiel" >
		    	<input type="button" class="b_text" value="��ѯ" id="btn_QryFiel" onclick="go_QryFiel()" />
		    </td>
	  </tr>
	</table>
</div>
  	    	
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="go_Cfm()"            />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>