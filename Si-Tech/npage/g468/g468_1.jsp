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
	String opCode = "g468";
	String opName = "�ն�ˢ��/���������Ͽɳ�ֵ";   
	String regionCode = (String)session.getAttribute("regCode");       
	System.out.println("--------------------regionCode-------------------"+regionCode);
	String workno=(String)session.getAttribute("workNo");    //���� 
	String workname =(String)session.getAttribute("workName");//��������  	        
	String orgcode = (String)session.getAttribute("orgCode");  

	String sysAccept = "";
	//ʱ���ѯ
	String time_sql="select to_char(sysdate,'hh24') from dual";
	String time_now="";
%>
	<wtc:service name="TlsPubSelBoss" retcode="retCode0" retmsg="retMsg0" outnum="1">
			<wtc:param value="<%=time_sql%>"/>
	</wtc:service>
	<wtc:array id="ret_time" scope="end" />
<%
	if(ret_time.length>0)
	{
		time_now=ret_time[0][0];
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("��ѯ��ǰʱ�����");
				return false;
			</script>
		<%
	}
%>	
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%   
    sysAccept = sLoginAccept;
    System.out.println("#           - ��ˮ��"+sysAccept);
%>

 

<script type="text/javascript" src="../../js/selectDateNew.js" charset="utf-8"></script>
<HTML>
	<HEAD>
		<TITLE>������BOSS-�ն�ˢ��/���������Ͽɳ�ֵ</TITLE>
		<script language="JavaScript">
			function sel1() {
 				window.location.href='g468_1.jsp';
			 }

			 function sel2(){
				window.location.href='g468_2.jsp';
			 }
			 function sel3(){
				window.location.href='g468show.jsp';
			 }
			
			<!--
			function form_load()
			{
				//init();
				}
				function dosubmit() {
					getAfterPrompt();
				//xl add for 18:00-0:00������¼��
				//alert("time_now is "+"<%=time_now%>");
				if("<%=time_now%>">=18 && "<%=time_now%>"<=24)
				//if("<%=time_now%>">=09 && "<%=time_now%>"<=10)
				{
					rdShowMessageDialog("ÿ��18:00-0:00������¼�룡");
					return false;
				}

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
					 
					document.form.action="g468_cfm1.jsp?remark="+document.form.remark.value+"&regCode="+"<%=regionCode%>"+"&sysAccept="+"<%=sysAccept%>"+"&phones=0" ;
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
				  document.all.remark.value = "����Ա��"+document.all.loginNo.value+"�����˶����һ����"; 
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
		<FORM action="g273_cfm1.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">������Ϣ����---�ն�ˢ��/���������Ͽɳ�ֵ</div>
			</div> 
			<table cellspacing="0">
		              <tbody> 
			             <tr> 
        <td class="blue" width="15%" align=center>¼�뷽ʽ</td>
        <td colspan="4"> 
          <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" checked>�ļ��ϴ� 
          <!--
          <input name="busyType2" type="radio" onClick="sel2()" value="2"> ҳ��¼�� 
          -->
		  &nbsp;&nbsp;
		  <input name="busyType1" id="busyType3" type="radio" onClick="sel3()" value="3" >���������ѯ
				</td>
     </tr>
						  
						  <tr> 
				                <td class="blue" align=center width="20%">��������</td>
				                <td width="30%" colspan="2">
					                    <input type="text" size="30" class="InputGrey" readonly value="�����һ����">
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
		              	 <tr>
							<td width="30%">
					                    <input type="text" size="40" class="InputGrey" readonly value="�����һͶ�ߺ�����������">
							</td>
							<td width="30%">
					                     ������ڣ�<input name="beginDate" type="text" id="bdate"  readonly onclick="selectDateNew(beginDate)" > (���������ں�ѡ������Ϊͬһ�죬Ҳ�����.)
							</td>		
						</tr>
						-->
						<input type="hidden"  name="beginDate" value="20120807">
			              <tr> 
				                <td class="blue" align=center width="20%">������ע</td>
				                <td colspan="2"> 
				                  	<input name=remark size=60 maxlength="60" >
				                </td>
			              </tr>
			              <tr> 
				                <td colspan="3">˵����<br>
				        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">�����ļ�ΪTXT�ļ�</font>��<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">ÿ��18:00-0:00������¼��</font>��<br>
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; �ļ�����Ϊ:�ֻ�����|���ѽ��|ҵ�����|��������(YYYYMM��ʽ)|��ע  �س� �磺 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;15004678912|100|e232|201302|����<br> 
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;15004678918|100|e232|201302|�ڷ�<br> 
				                </td>
			              </tr>   
		              </tbody> 
		      </table>
		      <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td id="footer" > 
				                  <input class="b_foot" name=sure type=button value=�ļ��ϴ� onClick="dosubmit()">
				                  &nbsp;
				                  		                  
				                  <input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
				                  &nbsp; 
				                 </td>
			              </tr>
		              </tbody> 	            
		   </table>	
		   <!--
		   <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td id="footer" > 
				                  <input class="button" type="text" name="cxrq" >��ѯ����(YYYYMM)
				                  <input class="b_foot" name=sure type=button value=���������ѯ onClick="doquery()">
				                  &nbsp;		                  
				                  
				                 </td>
			              </tr>
		              </tbody> 	            
		   </table>
		   -->
		   <input type="hidden" name="regCode" value="01" >
		   <input type="hidden" name="sysAccept" value="1234" >  
		   <input type="hidden" name="loginNo" value="<%=workno%>">
		   <input type="hidden" name="op_code" value="<%=opCode%>">
		   <input type="hidden" name="inputFile" value="">
		   <!--xl add for �ļ�¼��ʱ �ı���ֵΪ0-->
		   <input type="hidden" name="phones" value="0">
		   
		    <%@ include file="/npage/include/footer.jsp" %>     	
	</FORM>
	</BODY>
</HTML>

<script language="javascript">
	function doquery()
	{
		//alert("123");
	  if(document.all.cxrq.value=="")
	  {
		 rdShowMessageDialog("�������ѯ����!");
		 document.all.cxrq.focus();
		 return false;
	  }
	  else
	  {
		  document.all.action="g468_show.jsp";//?cxrq="+document.all.cxrq.value;
		  document.all.submit();
	  }	
	}
</script>