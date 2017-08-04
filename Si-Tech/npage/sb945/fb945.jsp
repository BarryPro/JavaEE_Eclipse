<%
/********************
 version v2.0
 ������: si-tech
 update wanglm 20101208
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%> 
<%
    System.out.println("-------------fb945.jsp-----------------------------------");
    /*
    String opCode = "b945";
    String opName = "���Ŷ���ȷ����ʱ��Ȩ";
    */
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
	String workNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
  	String regionCode = (String)session.getAttribute("regCode");   
  	
  	String todays  = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  	String today  = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
  	System.out.println("================================================================================   todays  " + todays);
  	
  	String  inParams = "select b.function_code, b.function_code || '-' || b.function_name "
                  +" from shighlogin a, sfunccode b "
                  +" where a.login_no = 'b945' "
                  +" and a.op_code = b.function_code";
%>	
    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2"> 
    <wtc:param value="<%=inParams%>"/>
    </wtc:service>  
    <wtc:array id="operTypeRet"  scope="end"/>

<html>
<head>
<title><%=opName%></title>	
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script type="text/javascript" src="validate_time.js"></script>
<script language=javascript>
   function qryLoginNo(){
   	    if($("#loginNo").val()==""){
   	       	rdShowMessageDialog("�����빤�ţ�");
   	    	return ;
   	    }
   	    var chkPacket = new AJAXPacket("ajax_doJudge.jsp","��ȴ���������");   
   	    chkPacket.data.add("loginNo",$("#loginNo").val());  
		core.ajax.sendPacket(chkPacket,doPro);
		chkPacket =null;
   	}
   	function doPro(packet){
   		var flag = packet.data.findValueByName("flag");
   		var flag1 = packet.data.findValueByName("flag1");
   		var opcode = packet.data.findValueByName("opcode");
   	    var opcode_type = packet.data.findValueByName("opcode_type");
   	    var opname = packet.data.findValueByName("opname");
   	    var role = packet.data.findValueByName("role");
   	    var power = packet.data.findValueByName("power");
   	    var availability = packet.data.findValueByName("availability");
   		if(flag == "false"){
   			$("#frameDiv").hide();
   			$("#confirm").attr("disabled",true);
   			rdShowMessageDialog("�޴˹�����Ϣ��");
   	    	return ;
   		}else{
   			if(flag1 == "false"){
   				$("#confirm").attr("disabled",true);
   			}else{
   			    $("#confirm").attr("disabled",false);
   			}
   	        $("#frameDiv").show();
   	        $("#opcode").val(opcode);
   	        $("#opcode_type").val(opcode_type);
   	        $("#opname").val(opname);
   	        $("#role").val(role);
   	        $("#power").val(power);	
   	        $("#availability").val(availability);
   		}
   	}
   	function doCfm(){
   		//$("#opCount").val;

      if(document.all.operType.value==""){
   		  rdShowMessageDialog("��ѡ���������!",1);
   			return false;
   		}
   		var opCount=$("#opCount").val(opCount);
   		if (opCount=="")
   		{
   			rdShowMessageDialog("��������������д!",0);
   			return false;
   		}
   		if (!forInt(document.frm.opCount))
   		{
   			rdShowMessageDialog("������������������!",0);
   			return false;
   		}
   		
   	   	frm.action="fb945_sub.jsp?opCode=<%=opCode%>&opName=<%=opName%>&operType="+document.all.operType.value;/* diling add for �����������Ͳ���@2012/11/6 */
   	   	frm.submit();
   	}
</script>
</head>
<body>

<form name="frm" method="POST">
	<%@ include file="/npage/include/header.jsp" %>    	
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">    
	<tr>
    <td class="blue">��������</td>
    <td colspan="3">
       <select id="operType" name="operType" index="20" >
        <option value="">---��ѡ��---</option> 
        <%
        if("000000".equals(retCode1)){
          if(operTypeRet.length>0){
            for(int i=0;i<operTypeRet.length;i++){
        %>
              <option value="<%=operTypeRet[i][0]%>"><%=operTypeRet[i][1]%></option> 
        <%
            }
          }
        }
        %>
       </select>
    </td>
  </tr>
	<tr>  
		<td class="blue">����Ȩ����</td>	
		<td>
			<input  id="loginNo" type="text" size=10 name="loginNo" 
				maxlength=6 />&nbsp;&nbsp;&nbsp; 
			<input type="button" value="��ѯ" onclick="qryLoginNo();" class="b_text" />
		</td>
		<td class="blue">�����������</td>	
		<td >
			<input  id="opCount" name="opCount" type="text" size=10 
				maxlength=3 value="0"/>&nbsp;&nbsp;&nbsp; 
		</td>		
	</tr>  
	<tr>
	   <td class="blue">
	       ��Ȩ��ʼʱ��	
	   </td>	
	   <td>
	       	<input id="startTime" type="text"  name="startTime"  v_type="new_date" 
	       		v_must="1" onblur="checkElement1(this)" value="<%=today%>" /> 
	   </td>
	   <td class="blue">
	       ��Ȩ����ʱ��	
	   </td>	
	   <td>
	       	<input id="endTime" type="text"  name="endTime"  v_type="new_date" v_must="1" onblur="checkElement1(this)" value="<%=todays%> 19:00:00"/> 
	   </td>
	</tr>
	<tr> 
		<td colspan="4" id="footer"> 
		<div align="center"> 
			<input class="b_foot" type="button" name="confirm" id="confirm" value="ȷ��" onClick="doCfm();" disabled />   
			<input class="b_foot" type="button" name="back" value="���" onClick="frm.reset();">
			<input class="b_foot" type="button" name="qryP" value="�ر�" onClick="removeCurrentTab();">
		</div>
		</td>
	</tr>
	</table>
	<div id="frameDiv" style="display:none">
	<TABLE cellSpacing=0 >
			<tr>
				<th width="10%" nowrap>����</th>
				<th width="10%" nowrap>��������</th>
				<th width="16%" nowrap>��������</th>
				<th width="18%" nowrap>��ɫ��Ϣ</th>
				<th width="8%" nowrap>Ȩ��ֵ</th>
				<th width="8%" nowrap>��Ч��</th>
			</tr>
			    <td width="8%">
			    	<input type="text" id="opcode" class="InputGrey" /> 
				</td>
				<td width="14%">
					<input type="text" id="opcode_type" class="InputGrey" /> 
				</td>
				<td width="10%">
					<input type="text" id="opname" class="InputGrey" /> 
				</td>
				<td width="30%"><input type="text" id="role" class="InputGrey" size="50"  /> </td>
				<td width="5%"><input type="text" id="power" class="InputGrey" /></td>
				<td width="5%"><input type="text" id="availability" class="InputGrey" /></td>
		</table>
     </div>
<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="opName" value="<%=opName%>" >
 <%@ include file="/npage/include/footer_simple.jsp" %>        
   </form>
</body>
</html>