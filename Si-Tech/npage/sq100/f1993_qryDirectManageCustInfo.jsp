<%
  /*
   * ����: ȫ��ֱ�ܿͻ���Ϣ��ѯ 1993
   * �汾: 1.0
   * ����: 2014-10-28
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%
	String opName = "���ſͻ�����";
	String dWorkNo = (String)session.getAttribute("workNo");		//��������
	String dNopass = (String)session.getAttribute("password");	//��������
  String custName 	= request.getParameter("custName"); 			//�ͻ�����
  String opCode 	= request.getParameter("opCode");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<SCRIPT type=text/javascript>
			function qryInfo(obj){
				/* ��ť�ӳ� */
  			controlButt(obj);
  			/* �º����� */
  			//getAfterPrompt();
	
        var markDiv=$("#intablediv"); 
        markDiv.empty();
        
	      var directManageCustNo = $("#directManageCustNo").val();
	      var groupNo = $("#groupNo").val();
	      var institutionName = $("#institutionName").val();
	      var directManageCustName = $("#directManageCustName").val();
	      if(directManageCustNo == "" && groupNo == "" && institutionName == "" && directManageCustName == ""){
	      	rdShowMessageDialog("����������һ����ѯ������");
          return false;	
	      }
	      
	      var packet = new AJAXPacket("f1993_ajax_qryDirectManageCustInfo.jsp","���ڻ�����ݣ����Ժ�......");
	    	packet.data.add("directManageCustNo",directManageCustNo);
	    	packet.data.add("groupNo",groupNo);
	    	packet.data.add("institutionName",institutionName);
	    	packet.data.add("directManageCustName",directManageCustName);
	    	packet.data.add("opCode","<%=opCode%>");
	    	core.ajax.sendPacketHtml(packet,doQryInfo);
	    	packet = null;
			}
			
			function doQryInfo(data){
				//�ҵ���ӱ���div
				var markDiv=$("#intablediv"); 
				markDiv.empty();
				markDiv.append(data);
				var retCode = $("#retCode").val();
				var retMsg = $("#retMsg").val();
				if(retCode!="000000"){
				   rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
				   //window.returnValue="N";
				   window.close();
				}
			}
		
			function saveToQryInfo(){
				var selDirMageCustVal = $("input[@name=selDirMageCust][@checked]").val();
				if(typeof(selDirMageCustVal) == "undefined"){
					rdShowMessageDialog("��ѡ��һ���ѯ��������ύ��");
				  return false;
				}
				var v_directManageCustNo = $("input[@name=selDirMageCust][@checked]").attr("v_directManageCustNo");//�ͻ����� 
				var v_directManageCustName = $("input[@name=selDirMageCust][@checked]").attr("v_directManageCustName"); //�ͻ�����
				var v_groupNo = $("input[@name=selDirMageCust][@checked]").attr("v_groupNo"); //��֯��������
				window.returnValue=v_directManageCustNo+"~"+v_directManageCustName+"~"+v_groupNo;
				window.close(); 
			}
		</SCRIPT>
		<TITLE>ȫ��ֱ�ܿͻ���Ϣ��ѯ</TITLE>
	</HEAD>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
	<BODY>
		<FORM method=post name="fPubSimpSel">   
		<%@ include file="/npage/include/header_pop.jsp" %>
			<div class="title">
				<div id="title_zi">ȫ��ֱ�ܿͻ���Ϣ��ѯ</div>
			</div>
			<TABLE cellSpacing=0>
				<tr> 
					<td width=16% class="blue" > ȫ��ֱ�ܿͻ�����</td>
					<td width=34%> 
						<input type="text" name="directManageCustNo"  id="directManageCustNo" value=""  />
					</td>
					<td width=16% class="blue" > ��֯��������</td>
					<td width=34%> 
						<input type="text" name="groupNo"  id="groupNo" v_must='0'  value="" />
					</td>
				</tr>
				<tr> 
					<td width=16% class="blue" > �ܲ����֧��������</td>
					<td width=34%> 
						<input type="text" name="institutionName"  id="institutionName" value="" />
					</td>
					<td width=16% class="blue" > ֱ�ܿͻ�����</td>
					<td width=34%> 
						<input type="text" name="directManageCustName"  id="directManageCustName" value="<%=custName%>" />
					</td>
				</tr>
				<TR id="footer" > 
					<TD align="center" colspan="4">
						<input class="b_foot" id="commit" name="commit" onClick="qryInfo(this)" style="cursor:hand" type=button value="��ѯ" />
						<input class="b_foot" name=back onClick="window.close();" style="cursor:hand" type=button value="�ر�" />        
					</TD>
				</TR>
			</TABLE>
			<div id="intablediv"></div>
		<%@ include file="/npage/include/footer_pop.jsp" %>
		</FORM>
	</BODY>
</HTML>    
