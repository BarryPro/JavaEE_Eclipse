 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-20 ҳ�����,�޸���ʽ
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
	<%@ include file="/npage/client4A/connect4A.jsp" %>
<%@ include file="/npage/client4A/XMLHelper.jsp" %>
<%@ include file="/npage/client4A/BASE64Crypt.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
	<%@ page import="com.sitech.common.*" %>

<%
	String opCode = "2204";	
	String opName = "�������ò���";	//header.jsp��Ҫ�Ĳ���   
	String regionCode = (String)session.getAttribute("regCode");       
	
	String workno=(String)session.getAttribute("workNo");    //���� 
	String workname =(String)session.getAttribute("workName");//��������  	        
	String orgcode = (String)session.getAttribute("orgCode");  
	
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),(Integer.parseInt(dateStr.substring(4,6))-1),Integer.parseInt(dateStr.substring(6,8)));
	String mon = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
	
	Date date = new Date();
  DateFormat df = new SimpleDateFormat("yyyyMMdd");   
	String now = df.format(date);
	
	    		/* ����ʱ�� requestTime�ڵ� */
	String currTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date());
	/* ��ȡ�������ݺ����в��� */
	String readPath = request.getRealPath("npage/properties")+"/treasury.properties";
	/* ��ԴID */
	String appId = readValue("treasury",opCode,"appId",readPath);
	/* ��Դ���� */
	String appName = readValue("treasury",opCode,"appName",readPath);
	/* ����ID sceneId */
	String sceneId = readValue("treasury",opCode,"sceneId",readPath);
	/* �����ó���ID������ɾ�� by zhangyta at 20120824*/
	/*sceneId = "ff808081395641c901395641c9220000";*/
	/* �������� sceneName */
	String sceneName = readValue("treasury",opCode,"sceneName",readPath);
	String ipAddr = (String)session.getAttribute("ipAddr");
	String flag4A = (String)session.getAttribute("flag4A");
	String appSessionId = (String)session.getAttribute("appSessionId");
	if(flag4A == null){
		flag4A = "0";
	}
	if(appSessionId == null){
		appSessionId = "0";
	}
	
%>
 
	
<HTML>
	<HEAD>
		<TITLE>������BOSS-�������ò���</TITLE>
		<script language="JavaScript">
			<!--
			function form_load()
				{
				//form.sure.disabled=true;
				}
				function dosubmit() {
					getAfterPrompt();
					var billym=document.form.bill_month.value;
					//alert("billym is "+billym);
					var SBillItem=document.form.SBillItem.value;
					if (billym==""){
					rdShowMessageDialog("��Ϣ�����´������������롣");
					document.form.bill_month.focus();
					return false;
				}
				/*else if( billym.substring(0,4)<"1990"||billym.substring(0,4)>"2010") {
					rdShowMessageDialog("\�������ݴ������������� !!")
					document.form.bill_month.focus();
					return false;
				}*/
				else if( billym.substring(4)<"01"||billym.substring(4)>"12") {
					rdShowMessageDialog("\������·ݴ������������� !!")
					document.form.bill_month.focus();
					return false;
				}
				else if(form.feefile.value.length<1)
				{rdShowMessageDialog("�����ļ�����������ѡ�������ļ���");
					document.form.feefile.focus();
					return false;
					}
				else {
					var billym=document.form.bill_month.value;
				var SBillItem=document.form.SBillItem.value;
				document.form.action="s2204_2.jsp?billym="+billym+"&SBillItem="+SBillItem+"&remark="+document.form.remark.value;
				document.form.submit();
				document.form.sure.disabled=true;
				document.form.reset.disabled=true;
	      
					}
				}
function doFileInput(packet){
			var result = packet.data.findValueByName("result");
			result="1";
		   // alert("test result is "+result);
			var resultDesc = packet.data.findValueByName("resultDesc");
			if(result == "1"){
				/**���óɹ� */
				//alert("���óɹ�");
				var billym=document.form.bill_month.value;
				var SBillItem=document.form.SBillItem.value;
				document.form.action="s2204_2.jsp?billym="+billym+"&SBillItem="+SBillItem+"&remark="+document.form.remark.value;
				document.form.submit();
				document.form.sure.disabled=true;
				document.form.reset.disabled=true;
				return true;
			}else{
				/**����ʧ�� */
				//alert("����ʧ��");
				rdShowMessageDialog("ִ��ʧ�ܣ�ʧ��ԭ��" + resultDesc);
				return false;
			}
}
				
				function isKeyNumberdot(ifdot) 
				{       
				    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
					if(ifdot==0)
						if(s_keycode>=48 && s_keycode<=57)
							return true;
						else 
							return false;
				    else
				    {
						if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
						{
						      return true;
						}
						else if(s_keycode==45)
						{
						    rdShowMessageDialog('���������븺ֵ,����������!');
						    return false;
						}
						else
							  return false;
				    }       
				}
				
			 	//  add liuxmc
				function getTKDate(){
					
					var time = document.form.reuturn_time.value;
					if(time == "" || time.length==0){
						alert("���ڲ���Ϊ�գ�");
						return false;
					}
					
					if(time.length != 8){
						alert("�Բ�������������ڸ�ʽ���ԣ��밴����ȷ�ĸ�ʽ(YYYYMMDD)��д!");
						return false;
					}
			
			    if(time.length!=0){    
			       var reg = /^(\d{1,4})(\d{1,2})(\d{1,2})$/;     
			       var r = time.match(reg);     
			       if(r==null){
			         alert("�Բ�������������ڸ�ʽ����ȷ���밴����ȷ�ĸ�ʽ(YYYYMMDD)��д!");
			         return false;
			       }
			     }
			     
					var path = "<%= request.getContextPath()%>/npage/s1300/s1362_selectTK.jsp?time="+time;
					window.showModelessDialog(path);
				}	
				
				//  end  
			//-->
		</script>
	</HEAD>
	<BODY  onLoad="form_load();">
		<FORM action="s2204_2.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">�������ò���</div>
			</div> 
			<table cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td class="blue" width="20%">��������</td>
				                <td width="30%">
					                  <select name = "SOprType" size = "1" >
					                    	<option value = "1" selected> �������ò���</option>
					                  </select>
				                </td>				                
				                <td class="blue" width="10%">����</td>
				                <td width="40%"><%=orgcode%></td>
			              </tr>
		              </tbody> 
	            	</table>
	            	<table id=tbs9  cellspacing="0">
	            	<tbody> 
		             	 <tr> 
		                	<td class="blue" width="20%">��������</td>
			                <td width="30%"> 
			                  <input type="text" class="InputGrey" readonly value="<%=mon%>" name="bill_month" maxlength="6"  onKeyPress="return isKeyNumberdot(1)">
			                </td>
		                	<td class="blue" width="10%">��������</td>
		                	<td width="40%"> 
				               <select name="SBillItem">
							<% 	try{
									ArrayList retArray = new ArrayList();
							      		//String [][] result_dyn = new String[][]{};
							      	    	//ScallSvrViewBean viewBean = new ScallSvrViewBean();
							            	//CallRemoteResultValue callRemoteResultValue = null;
							            	String[] inParas = new String[]{""};
							            	inParas[0] = "select fee_code||'|'||detail_code,fee_code||'-'||detail_code||'-'||detail_name from sFeeCodeDetail where fee_code !='*' order by fee_code,detail_code";
							           	//callRemoteResultValue = viewBean.callService("0", null, "sPubSelect", "2", inParas);
							           	//result_dyn = callRemoteResultValue.getData();
							  	%>
							           	<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
										<wtc:sql><%=inParas[0]%></wtc:sql>
									</wtc:pubselect>
									<wtc:array id="result_dyn" scope="end" />									
							         <%
							           	System.out.println("result_dyn========================="+result_dyn.length);
							           	System.out.println("retCode1========================="+retCode1);
							           	System.out.println("retMsg1========================="+retMsg1);
							            	for(int i=0;i<result_dyn.length;i++){
							        		out.print("<option value='" + result_dyn[i][0] + "'>" + result_dyn[i][1] + "</option>");
							      		}
							     	}catch(Exception e){
							       		System.out.println("=========================���÷���ʧ�ܣ�");
							     	}          
							%>
				                  </select>
		                	</td>
		   		</tr>
		  <!--  add liuxmc-->
		   		<tr>
						<td class="blue">��Ԥ�����Ϣ��ѯ��</td>
						<td class="blue" colspan="3">			
							���ڣ�<input type="text" class="button" name="reuturn_time" value="<%=now%>">��ʽ��YYYYMMDD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input class="b_text"  type=button value="�� ѯ" onClick="getTKDate();">
						</td>
					</tr>		
			<!-- end -->
		              	<tr> 
			                <td class="blue">�����ļ�</td>
			                <td  colspan="4"> 
			                  <input type="file" name="feefile">
			                </td>
		              	</tr>
		        </tbody> 
	    		</table>
		       <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td class="blue" width="20%">������ע</td>
				                <td colspan="2"> 
				                  	<input class="InputGrey" name=remark size=60 maxlength="60"  class="InputGrey">
				                </td>
			              </tr>
			              <tr> 
				                <td colspan="3">˵����<br>
				                  &nbsp;&nbsp;&nbsp;1�������ļ����ļ���ʽΪ��<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������� �ո� �ʺ� �ո� ���� �ո� �ͷ����� �ո� �ͷ���ϸ<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������յ�Ĭ���ʺţ����ʺſ�������Ϊ��<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�磺 <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13512345679 0 5.01 a 0001<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13612345679 0 24.04 b 0002<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13712345679 0 125.83 b 0003
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
		    <%@ include file="/npage/include/footer.jsp" %>
	</FORM>
	</BODY>
</HTML>
