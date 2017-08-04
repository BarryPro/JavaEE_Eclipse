<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
  String opCode =WtcUtil.repNull(request.getParameter("opCode"));//操作代码
  String qryFlag = WtcUtil.repNull(request.getParameter("qryFlag"));//查询类型(0,查询;1高级检索)
  String servId = WtcUtil.repNull(request.getParameter("servId"));//用户IDNO
  String offerId = WtcUtil.repNull(request.getParameter("offerId"));//用户原来的基本销售品标识
  String loginNo = (String)session.getAttribute("workNo");//操作员登录工号
  String flag = WtcUtil.repNull(request.getParameter("flag"));//是否省级工号标识: Y,是;N否  不填默认为N
  String groupId=(String)session.getAttribute("groupId");//区域标识
    System.out.println("############################ajax_qryBySecRentMac##########################groupId=="+groupId);
  String offerCode = WtcUtil.repNull(request.getParameter("offerCode"));//销售品编码 
  String offerName =WtcUtil.repNull(request.getParameter("offerName"));//销售品名称
  String offerType =WtcUtil.repNull(request.getParameter("offerType"));//销售品类型
  String offerAttrSeq =WtcUtil.repNull(request.getParameter("offerAttrSeq"));//销售品属性标识
  String offerAttrType =WtcUtil.repNull(request.getParameter("offerAttrType"));//销售品分类标识 
  String userRange =WtcUtil.repNull(request.getParameter("userRange"));//使用限制
  String custGroupId =WtcUtil.repNull(request.getParameter("custGroupId"));//客户群标识
  String channelSegment =WtcUtil.repNull(request.getParameter("channelSegment"));//渠道类型标识
  String reginCode =(String)session.getAttribute("bureauId");;//区域标识
  String saleMode =WtcUtil.repNull(request.getParameter("sale_mode"));//模板Id
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
						<th>选择</th>
						<th>销售品代码</th>
						<th>销售品名称</th>
						<th>生效时间</th>
						<th>销售品描述</th>
						<th>定价计划</th>	


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
						<td><input type="button" class="b_text" value="查看" onclick="window.showModalDialog('showPrice.jsp?OFFER_ID=<%=productInfo[i][0]%>','dialogHeight=300px','dialogWidth=650px','help=no','status=no')" /></td>
					</tr>
<%
						}
				}else{
%>				
  <script language="javascript">
  	rdShowMessageDialog("没有查到对应数据，请重新输入串号");
	</script>
<%
				}
%>
			</table>