<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
  String opCode =WtcUtil.repNull(request.getParameter("opCode"));//��������
  String qryFlag = WtcUtil.repNull(request.getParameter("qryFlag"));//��ѯ����(0,��ѯ;1�߼�����)
  String servId = WtcUtil.repNull(request.getParameter("servId"));//�û�IDNO
  String offerId = WtcUtil.repNull(request.getParameter("offerId"));//�û�ԭ���Ļ�������Ʒ��ʶ
  String loginNo = (String)session.getAttribute("workNo");//����Ա��¼����
  String flag = WtcUtil.repNull(request.getParameter("flag"));//�Ƿ�ʡ�����ű�ʶ: Y,��;N��  ����Ĭ��ΪN
  String groupId=(String)session.getAttribute("groupId");//�����ʶ
    System.out.println("############################ajax_qryBySecRentMac##########################groupId=="+groupId);
  String offerCode = WtcUtil.repNull(request.getParameter("offerCode"));//����Ʒ���� 
  String offerName =WtcUtil.repNull(request.getParameter("offerName"));//����Ʒ����
  String offerType =WtcUtil.repNull(request.getParameter("offerType"));//����Ʒ����
  String offerAttrSeq =WtcUtil.repNull(request.getParameter("offerAttrSeq"));//����Ʒ���Ա�ʶ
  String offerAttrType =WtcUtil.repNull(request.getParameter("offerAttrType"));//����Ʒ�����ʶ 
  String userRange =WtcUtil.repNull(request.getParameter("userRange"));//ʹ������
  String custGroupId =WtcUtil.repNull(request.getParameter("custGroupId"));//�ͻ�Ⱥ��ʶ
  String channelSegment =WtcUtil.repNull(request.getParameter("channelSegment"));//�������ͱ�ʶ
  String reginCode =(String)session.getAttribute("bureauId");;//�����ʶ
  String saleMode =WtcUtil.repNull(request.getParameter("sale_mode"));//ģ��Id
  System.out.println("######################################################saleMode=="+saleMode);
  String strArray="var retResult; ";  //must
  String [][] productInfo = null;
%>

<wtc:utype name="sGetZjOffer" id="retVal" scope="end">
	<wtc:uparams name="TOfferMsg" iMaxOccurs="1">
			<wtc:uparam value="<%=opCode%>" type="STRING"/>  
			<wtc:uparam value="<%=qryFlag%>" type="STRING"/>  
			<wtc:uparam value="<%=servId%>" type="LONG"/>
			<wtc:uparam value="<%=offerId%>" type="LONG"/>  
			<wtc:uparam value="<%=loginNo%>" type="STRING"/> 
			<wtc:uparam value="<%=flag%>" type="STRING"/> 
			<wtc:uparam value="<%=groupId%>" type="LONG"/> 
			<wtc:uparam value="<%=offerCode%>" type="STRING"/> 
			<wtc:uparam value="<%=offerName%>" type="STRING"/> 
			<wtc:uparam value="<%=offerType%>" type="LONG"/>
			<wtc:uparam value="<%=offerAttrSeq%>" type="LONG"/>
			<wtc:uparam value="<%=offerAttrType%>" type="STRING"/>
			<wtc:uparam value="<%=userRange%>" type="STRING"/>
			<wtc:uparam value="<%=custGroupId%>" type="LONG"/>
			<wtc:uparam value="<%=channelSegment%>" type="STRING"/>
			<wtc:uparam value="<%=reginCode%>" type="STRING"/>
			<wtc:uparam value="<%=saleMode%>" type="STRING"/>
	</wtc:uparams>
</wtc:utype>
<%
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1);
	 String location = "";
	 if(retCode.equals("0"))
	{
  	int retValNum = retVal.getUtype("2").getSize();
  	productInfo = new String[retValNum][9];
		 for(int i=0;i<retValNum;i++)
		 {
		  location ="2."+i;
		  int n =0;
		  System.out.println("######################################################retVal.getUtype(location)=="+retVal.getUtype(location).getSize());
		
			for(int j=0;j<19;j++){
		  	if(j==0||j==1||j==2||j==3||j==11||j==13||j==14||j==17||j==18){
			    productInfo[i][n]=retVal.getUtype(location).getValue(j);
			    System.out.println("######################################################retResult["+i+"]["+n+"]=="+productInfo[i][n]);
			    n++;
			  }
			}	
		}	
%>

<script type="text/javascript">
    $(document).ready(function(){
     $("#ta tr:even").addClass("double");
    });
</script>
 		<style type="text/css">
			th{
			background: gray;
			color: white;
			}
			td {
			    border-bottom:1px solid #95bce2;
			}
			tr.over td{
			background: #D6E8F8;
			font-weight: bold;
			}
			tr.double td{
			background: #DAF3F1;
			}
   </style>
		<table id="ta">
					<tr>
						<th>ѡ��</th>
						<th>����Ʒ����</th>
						<th>����Ʒ����</th>
						<th>��Чʱ��</th>
						<th>����Ʒ����</th>
						<th>���ۼƻ�</th>	


					</tr>			  
					<%
					for(int i =0;i<productInfo.length;i++){
					%>  		
					<tr>
						<td><input type="radio" name="proRad" value="<%=productInfo[i][0]+","+productInfo[i][1]+","+productInfo[i][2]+","+productInfo[i][4]+","+productInfo[i][5]+","+productInfo[i][6]+","+productInfo[i][7]+","+productInfo[i][8]+","+saleMode+","+productInfo[i][3] %>" ></td>
						<td><%=productInfo[i][0]%></td>
						<td><%=productInfo[i][2]%></td>
						<td><%=productInfo[i][7]%></td>
						<td><span class="text_long"><%=productInfo[i][3]%></spqn></td>
						<td><input type="button" class="b_text" value="�鿴" onclick="window.showModalDialog('showPrice.jsp?OFFER_ID=<%=productInfo[i][0]%>','dialogHeight=300px','dialogWidth=650px','help=no','status=no')" /></td>
					</tr>
<%
						}
				}else{
%>				
  <script language="javascript">
  	rdShowMessageDialog("û�в鵽��Ӧ���ݣ����������봮��");
	</script>
<%
				}
%>
			</table>