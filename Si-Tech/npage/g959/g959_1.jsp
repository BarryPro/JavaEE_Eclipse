<%
  /*
   * ����:��ɧ�ŵ绰�û����������ر���������
   * �汾: 1.0
   * ����: 2010/07/13
   * ����: sungq
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "g959";
	String opName = "���г�ֵ����ת��ǰ̨����";   
	String regionCode = (String)session.getAttribute("regCode");       
	System.out.println("--------------------regionCode-------------------"+regionCode);
	String workno=(String)session.getAttribute("workNo");    //���� 
	String workname =(String)session.getAttribute("workName");//��������  	        
	String orgcode = (String)session.getAttribute("orgCode");  

	String sysAccept = "";
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%   
    sysAccept = sLoginAccept;
    System.out.println("#           - ��ˮ��"+sysAccept);
%>

<HTML>
	<HEAD>
		<TITLE>������BOSS-���г�ֵ����ת��ǰ̨����</TITLE>
		<script language="JavaScript">
			<!--
			function form_load()
			{
				init();
				}
				function dosubmit() {
					getAfterPrompt();
				if(form.feefile.value.length<1)
				{
					rdShowMessageDialog("�����ļ�����������ѡ�������ļ���");
					document.form.feefile.focus();
					return false;
				}
				else 
				{
					setOpNote();
					//alert(document.all.remark.value);
					var seled = $("#seled").val();
					document.form.action="g959_cfm1.jsp?remark="+document.form.remark.value+"&regCode="+"<%=regionCode%>"+"&sysAccept="+"<%=sysAccept%>"+"&seled="+seled+"&agt_phone="+document.all.agt_phone.value;
					document.form.submit();
					document.form.sure.disabled=true;
					document.form.reset.disabled=true;
					return true;
				}
			}
			function setOpNote()
			{
				if(document.all.remark.value=="")
				{
				  document.all.remark.value = "����Ա��"+document.all.loginNo.value+"�����˿��г�ֵ��Ϣ��������"; 
				}
				return true;
			}	
			
			//-->
		function returnBefo() {
		  window.location.href = "finner_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
		}
		
		function init()
		{
				$("#seled").empty();
				$("#seled").append("<option value='03' selected>�ٱ�����</option><option value='02'>ʡ�ڼ��</option>");
				document.getElementById("do_check").disabled=true;
				document.getElementById("dcon_pre").style.display="none";
		}
		function do_checks()
		{
			 
			var agt_phone= document.all.agt_phone.value;
			if(agt_phone=="")
			{
				rdShowMessageDialog("��������г�ֵ�������ֻ����룡");
				document.all.agt_phone.focus();
				return false;
			}
			else
			{
				var myPacket = new AJAXPacket("g959_check.jsp","���ڲ�ѯ�ͻ������Ժ�......");
				myPacket.data.add("agt_phone",(document.all.agt_phone.value).trim());
				core.ajax.sendPacket(myPacket,doCheckAgt);
				myPacket=null;
			}
		}
		function doCheckAgt(packet)
		{
			var retResult=packet.data.findValueByName("retResult");
			var retResult1=packet.data.findValueByName("retResult1");
			//alert("retResult is "+retResult+" retResult1 is "+retResult1);
			if(retResult!="0")
            {
				if(retResult=="1")
				{
					rdShowMessageDialog("�ú��벻�ǿ��г�ֵ�����̺��룬����������!");
					return false;
				}
				else if(retResult=="2")
				{
					rdShowMessageDialog("�ú��벻���ڣ�����������!");
					return false;
				}
				else
                {
					rdShowMessageDialog("�û���Ϣ������!");
					return false;
				}
			}
			else
			{
				document.getElementById("do_check").disabled=false;
				document.all.agt_phone.readOnly = true;;
			}
		}
		function do_querys()
		{
			//alert("2");
			var agt_phone= document.all.agt_phone.value;
			if(agt_phone=="")
			{
				rdShowMessageDialog("��������г�ֵ�������ֻ����룡");
				document.all.agt_phone.focus();
				return false;
			}
			else
			{
				//alert("3");
				var myPacket1 = new AJAXPacket("g959_query.jsp","���ڲ�ѯ�ͻ������Ժ�......");
				//alert("4");
				myPacket1.data.add("agt_phone",(document.all.agt_phone.value).trim());
				//alert("5");
				core.ajax.sendPacket(myPacket1,doGetQuery);
				//alert("6");
				myPacket1 =null;
			}
		}
		function doGetQuery(packet2)
		{
			//alert("3");
			var retResult=packet2.data.findValueByName("retResult");
			//alert("1��"+retResult);
			var s_sum = packet2.data.findValueByName("s_sum");
			//alert("2");
			var ret_msg=packet2.data.findValueByName("ret_msg");
			//alert("retResult is "+retResult+" and ret_msg is "+ret_msg);
			if(retResult==0)
			{
				document.getElementById("dcon_pre").style.display="block";
				document.getElementById("pre").value=s_sum;
			}	
			else
			{
				rdShowMessageDialog("���벻�ǿ��г�ֵ�����̺��룬��˶Ժ���������!");
			}
		}
		</script>
	</HEAD>
	<BODY  onLoad="form_load();">
		<FORM action="g959_cfm1.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">������Ϣ����---���г�ֵ����ת��ǰ̨����</div>
			</div> 
			
			<table cellspacing="0">
			  <tr>
				<td class="blue" align=center width="20%">���г�ֵ�����̺���&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="agt_phone" maxlength="11"></td>
				<td class="blue" align=left width="20%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_foot" name="check" value="У��" onclick="do_checks()">
				
				&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_foot" name="do_query" value="�˻���ת����ѯ" onclick="do_querys()"></td>
			  </tr>
            </table>
			<div id="dcon_pre">
				<table cellspacing="0">
					<td class="blue" align=center width="20%">���г�ֵ�������ʺſ�ת���</td>
					<td class="blue" align=center width="20%"><input type="text" id="pre" readonly>(Ԫ)</td>
				</table>
			</div>
			<table cellspacing="0">
		              
					  
					  <tbody> 
			              
						  <tr> 
				                <td class="blue" align=center width="20%">��������</td>
				                <td width="30%" colspan="2">
					                    <input type="text" size="30" class="InputGrey" readonly value="���г�ֵ����ת��ǰ̨��������">
				                </td>				               		              
			                <td class="blue" align=center width="20%">�����ļ�</td>
			                <td width="30%" colspan="2"> 
			                  <input type="file" name="feefile">
			                </td>
		              	</tr>
		        </tbody> 
	    		</table>
		       <table  cellspacing="0">
		              <tbody> 
					  <!--
		              	 <TR id="bltys"  > 
						          <TD class="blue" align=center width="20%">������Դ</TD>
					              <TD >
					                 <select id="seled"  style="width:100px;">
														</select>
					
						          </TD>
						          </TR> 
						-->
			              <tr> 
				                <td class="blue" align=center width="20%">������ע</td>
				                <td colspan="2"> 
				                  	<input name=remark size=60 maxlength="60" >
				                </td>
			              </tr>
			              <tr> 
				                <td colspan="3">˵����<br>
				        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">�����ļ�ΪTXT�ļ�</font>��<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">ע��������ȷ�ԣ����������޷���ֵ���ָ���Ϊ"|"��</font><br>
					 
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����ֵ�ֻ�����|��ֵ���  �س�<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�磺 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;15004675829|1<br> 
				                </td>
			              </tr>   
		              </tbody> 
		      </table>
		      <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td id="footer" > 
				                  <input class="b_foot" name=sure type=button value=ȷ�� id="do_check" onClick="dosubmit()">
				                  &nbsp;
				                 <input type="button" name="rets" class="b_foot" value="����" onClick="returnBefo()"/>
				                  &nbsp;			                  
				                  <input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
				                  &nbsp; 
				                 </td>
			              </tr>
		              </tbody> 	            
		   </table>	
		  
		   <input type="hidden" name="regCode" value="01" >
		   <input type="hidden" name="sysAccept" value="1234" >  
		   <input type="hidden" name="loginNo" value="<%=workno%>">
		   <input type="hidden" name="op_code" value="<%=opCode%>">
		   <input type="hidden" name="inputFile" value="">
		   
		   
		    <%@ include file="/npage/include/footer.jsp" %>     	
	</FORM>
	</BODY>
</HTML>

