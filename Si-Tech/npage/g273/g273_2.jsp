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
	String opCode = "g273";
	String opName = "�����һͶ�ߺ���¼��";   
	String regionCode = (String)session.getAttribute("regCode");       
	System.out.println("--------------------regionCode-------------------"+regionCode);
	String workno=(String)session.getAttribute("workNo");    //���� 
	String workname =(String)session.getAttribute("workName");//��������  	        
	String orgcode = (String)session.getAttribute("orgCode");  

	String sysAccept = "";
	// xl add ÿ�����һ�첻���԰���
	String date_end="select to_char(last_day(sysdate),'YYYYMMDD') from dual";
	String date_now="select to_char(sysdate,'YYYYMMDD') from dual";
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%   
    sysAccept = sLoginAccept;
    System.out.println("#           - ��ˮ��"+sysAccept);
%>

<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=date_end%>"/>
	</wtc:service>
<wtc:array id="ret_val_dt" scope="end" />

<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=date_now%>"/>
	</wtc:service>
<wtc:array id="ret_val_now" scope="end" />

<script type="text/javascript" src="../../js/selectDateNew.js" charset="utf-8"></script>
<HTML>
	<HEAD>
		<TITLE>������BOSS-�����һͶ�ߺ���¼��</TITLE>
		<script language="JavaScript">
			function sel1() {
 		window.location.href='g273_1.jsp';
			 }

			 function sel2(){
				window.location.href='g273_2.jsp';
			 }

			
			<!--
			function form_load()
			{
				//init();
				}
				function dosubmit() {
				var new_date = document.all.beginDate.value;
				var phone_new = document.all.phones.value;
				//alert("phone_new is "+phone_new);
				var dt_end="<%=ret_val_dt[0][0]%>";
				var dt_now="<%=ret_val_now[0][0]%>";
				//var dt_now="20121130";
				//alert("test dt_end is "+dt_end+" and dt_now is "+dt_now);
				if(dt_end==dt_now)
				{
					rdShowMessageDialog("ÿ�������һ�첻����¼�������");
					return false;
				}
				
				if(new_date=="")
				{
					rdShowMessageDialog("��ѡ�����ڣ�");
					return false;
				}
				else if(phone_new=="")
				{
					rdShowMessageDialog("�������ֻ����룡");
					return false;
				}	
				else 
				{
					setOpNote();
					//alert(document.all.remark.value);
					
					document.form.action="g273_cfm2.jsp?remark="+document.form.remark.value+"&regCode="+"<%=regionCode%>"+"&sysAccept="+"<%=sysAccept%>"+"&phones="+phone_new+"&beginDate="+new_date+"&sSaveName=0";
					document.form.submit();
					 
					return true;
				}
			}
			function setOpNote()
			{
				if(document.all.remark.value=="")
				{
				  document.all.remark.value = "����Ա��"+document.all.loginNo.value+"�����˶����һͶ�ߺ���ǰ̨������Ϣ¼��"; 
				}
				return true;
			}	
			
			//-->
		 
		
		function init()
		{
				$("#seled").empty();
				$("#seled").append("<option value='03' selected>�ٱ�����</option><option value='02'>ʡ�ڼ��</option>");
		}
		</script>
	</HEAD>
	<BODY  onLoad="form_load();">
		<FORM action="g273_cfm2.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">������Ϣ����---�����һͶ�ߺ���������Ϣ¼��</div>
			</div> 
			<table cellspacing="0">
		              <tbody> 
			             <tr> 
        <td class="blue" width="15%" align=center>¼�뷽ʽ</td>
        <td colspan="4"> 
          <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" >�ļ��ϴ� 
         
          <input name="busyType2" type="radio" onClick="sel2()" value="2" checked> ҳ��¼�� 
          
				</td>
     </tr>
					<!--
					  <tr> 
				                <td class="blue" align=center width="20%">��������</td>
				                <td width="60%">
					                    <input type="text" size="40" class="InputGrey" readonly value="�����һͶ�ߺ���������Ϣǰ̨¼��"> ѡ������ <input name="beginDate" type="text" id="bdate"  readonly onclick="selectDateNew(beginDate)" > 
								</td>
		              	</tr>
					--><input type="hidden"  name="beginDate" value="20120807">
						
						<tr>
							 <td class="blue" align=center width="20%">�������ֻ����룬����ֻ�������|�ָ¼��ĺ���Ϊ2012��8��7��֮ǰ��������8��7�գ�����Ķ����һ���롣</td>
							<td><textarea name="phones" rows="12" cols="68"></textarea></td>
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
				                <td width="60%"> 
				                  	<input name=remark size=60 maxlength="60" >
				                </td>
			              </tr>
			                
		              </tbody> 
		      </table>
		      <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td id="footer" > 
				                  <input class="b_foot" name=sure type=button value=ȷ�� onClick="dosubmit()">
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
		   <!--xl add for ҳ��¼��ʱ  �ϴ���ֵΪ0-->
		   <input type="hidden" name="sSaveName" value="0">
		   
		    <%@ include file="/npage/include/footer.jsp" %>     	
	</FORM>
	</BODY>
</HTML>

