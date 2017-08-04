<%
    /*************************************
    * ��  ��: Ӫ���������� g366
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-12-24
    **************************************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String opCode = "g366";
	String opName = "Ӫ����������";
	String chargeNo = WtcUtil.repNull((String)request.getParameter("chargeNo"));//�ʷѴ���
	String chargeName = WtcUtil.repNull((String)request.getParameter("chargeName"));//�ʷ�����
  String regCode = (String)session.getAttribute("regCode");
  
  String  inParams [] = new String[2];
  inParams[0] =  "SELECT offer_id,offer_name,to_char(eff_date,'YYYYMMDD HH24:MI:SS'),to_char(exp_date,'YYYYMMDD HH24:MI:SS') "
                +" FROM product_offer "
                +" WHERE SYSDATE > eff_date "
                +" AND SYSDATE < exp_date "
                +" and offer_name like '%"+chargeName+"%'"
                +" and offer_type = '10' ";
                
  if(!"".equals(chargeNo)){
    inParams[0] = inParams[0]+" and offer_id=:chargeno ";
  }
                
  if(!"".equals(chargeNo)){
    inParams[1] = "chargeno="+chargeNo;
  }
  System.out.println("----------diling------chargeNo="+chargeNo);
  System.out.println("----------diling------inParams[0]="+inParams[0]);
  System.out.println("----------diling------inParams[1]="+inParams[1]);
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
  if(!"000000".equals(retCode1)){
%>
    <SCRIPT type=text/javascript>
      rdShowMessageDialog("������룺<%=retCode1%><br>������Ϣ��<%=retMsg1%>",0);
      window.close();
    </SCRIPT>
<%
    }else{
%>
<HTML>
<HEAD>
<TITLE>Ӫ����������</TITLE>
<script language="javascript" type="text/javascript" src="../fe743_mainScript.js"></script>
<SCRIPT type=text/javascript>
	$(function() {
		$('#custSubmitBtn').click(function(){
		  var s=''; 
      $('input[name="chkQry"]:checked').each(function(){ 
        s+=$(this).attr('v_offerId')+'|'+$(this).attr('v_offerName')+'|'+$(this).attr('v_beginTime')+'|'+$(this).attr('v_endTime')+','; 
      }); 
      if (s.length > 0){ 
        //�õ�ѡ�е�checkboxֵ���� 
        //s = s.substring(0,s.length - 1); 
      }else{
        rdShowMessageDialog("��ѡ�����ݣ�",1);
        return false;
      }
			window.opener.doSeleQueryInfo(s);
			window.close();
		});
	});
</SCRIPT>
</HEAD>
<BODY>
<FORM method=post name="">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" id="data" name="data" value="" />
	<input type="hidden" id="productOfferIdHiden" name="productOfferIdHiden" value="" />
	<input type="hidden" id="v_chkCharacterNumberFlag" name="v_chkCharacterNumberFlag" value="" />
		<div class="title" style="margin-top:20px;">
			<div id="title_zi">Ӫ���������ò�ѯ���</div>
		</div>
	<div id="prodDiv" style="height:250px; border:0px;padding:3px; PADDING:0px; OVERFLOW: auto; ">
		<table style="width:96.8%" vColorTr='set' >
			<tr align="center">
			  <th></th>
				<th>�ʷѴ���</th>
				<th>�ʷ�����</th>
			</tr>
			<%
				if(ret.length==0){
				/*
				out.println("<tr height='25' align='center'><td colspan='3'>");
					out.println("û���κμ�¼��");
					out.println("</td></tr>");
					*/
		  %>
		      <SCRIPT type=text/javascript>
  					rdShowMessageDialog("û�в�ѯ�����",1);
  					window.close();
					</SCRIPT>
		  <%
				}else if(ret.length>0){
  					for(int i=0;i<ret.length;i++){
  %>
  					<tr align="center" id="row_<%=i%>">
  					  <td ><input type="checkbox" id="chkQry0" name="chkQry" value="" v_offerId="<%=ret[i][0]%>" v_offerName="<%=ret[i][1]%>" v_beginTime="<%=ret[i][2]%>"  v_endTime="<%=ret[i][3]%>"/></td>
  						<td ><%=ret[i][0]%></td>
  						<td ><%=ret[i][1]%></td>
  						<input type="hidden" id="beginTime" name="beginTime" value="<%=ret[i][2]%>"  />
  						<input type="hidden" id="endTime" name="endTime" value="<%=ret[i][3]%>"  />
  					</tr>
  <%
         
  					} 
				}
%>
		</table>
	</div>
		<table style="width:96.8%">
			<TR id="footer">
				<TD align=center>
					<input type="button" class="b_foot" id="custSubmitBtn" value="ȷ��">
					<input type="button" class="b_foot" onclick="window.close()" value="����">
				</TD>
			</TR>
		</table>

	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<%
}
%>