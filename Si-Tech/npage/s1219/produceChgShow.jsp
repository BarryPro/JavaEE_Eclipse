<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
		String opCode=WtcUtil.repNull(request.getParameter("opCode"));
		String opName=WtcUtil.repNull(request.getParameter("opName"));
		String prtFlag = request.getParameter("prtFlag"); //�ϴ�/�ִ��־;

		String gCustId=WtcUtil.repNull(request.getParameter("gCustId"));
		String offerSrvId=WtcUtil.repNull(request.getParameter("offerSrvId"));
		String offerId=WtcUtil.repNull(request.getParameter("offerId"));//��URLȡ��
		String offerName=WtcUtil.repNull(request.getParameter("offerName"));//��URLȡ��
		String phoneNo=WtcUtil.repNull(request.getParameter("phoneNo"));
		String orderArrayId=WtcUtil.repNull(request.getParameter("orderArrayId"));
		String custOrderId=WtcUtil.repNull(request.getParameter("custOrderId"));			
		String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));
		String servOrderId=WtcUtil.repNull(request.getParameter("servOrderId"));
		String closeId=WtcUtil.repNull(request.getParameter("closeId"));
		String servBusiId=WtcUtil.repNull(request.getParameter("servBusiId"));
		String productName=WtcUtil.repNull(request.getParameter("productName"));
		
System.out.println("======closeId===="+closeId);	
	//String regionCode = "01";
	String regionCode =(String)session.getAttribute("bureauId");
	if(regionCode!=null&&regionCode.length()>1){
		regionCode=regionCode.substring(0,2);
	}
	

	if(phoneNo.equals(""))
	{ 
	  String sqlStr = "select nvl(b.service_no,a.phone_no) from dcustmsg a,daccountidinfo b where a.id_no="+offerSrvId+" and a.phone_no=b.msisdn(+)";
	%>
	  
	   <wtc:pubselect name="sPubSelect" outnum="1" > 
	   	 <wtc:sql><%=sqlStr%></wtc:sql>
	   </wtc:pubselect>
	   <wtc:array id="rows" scope="end"/>
	<%
	   if(rows.length>0)
	   {
	      phoneNo = rows[0][0];
	   } 
	}
	
	
	String workNo=(String)session.getAttribute("workNo");
	String groupId=(String)session.getAttribute("groupId");//�����ʶ
	System.out.println("############################produceChgShow.jsp################################==groupId="+groupId);
	String cust_id=WtcUtil.repNull(request.getParameter("gCustId"));
	String phone_no= phoneNo;
	%>
		<wtc:pubselect name="sPubSelect" outnum="1">
			<wtc:sql>select  decode(substr(attr_code, 5, 1),'0','0','1','1','2','2','3','3','0')  from  dCustMsg where  phone_no = '<%=phoneNo%>' and substr(run_code, 2, 1) < 'a' </wtc:sql>
		</wtc:pubselect>	
		<wtc:array id="row1" scope="end" />	
		
		<wtc:pubselect name="sPubSelect" outnum="1">
			<wtc:sql>select  nvl(grp_name,'NULL')  from  sGrpBigFlag  where  grp_flag='<%=row1[0][0]%>' </wtc:sql>
		</wtc:pubselect>	
		<wtc:array id="row2" scope="end" />	
	<%
	String servId  = offerSrvId;
	System.out.println("==servId=="+servId);
	String flagShow="false";
	int num2=0;
	String[][] havaProduct=null;
	String custName="";
	String idIccid="";
	String custLevel="";
	String addr="";
%>		
<wtc:utype name="sGetCustOrdMsg" id="retVal" scope="end">
		<wtc:uparam value="<%=cust_id%>" type="long" />
		<wtc:uparam value="<%=workNo%>" type="string"/>
		<wtc:uparam value="<%=groupId%>" type="string"/>	
</wtc:utype>	
<%
	System.out.println("groupId---------------------ffffffffffffffffffffffffffffffff------------"+groupId);
	String retCode0=retVal.getValue(0);
	String retMsg0=retVal.getValue(1);
	System.out.println("==retCode0=="+retCode0+"      "+retMsg0);
	if(retCode0.equals("0"))
	{
		UType userInfo=(UType)retVal.getUtype(2);
		custName=userInfo.getValue(1);
		idIccid=userInfo.getValue(2);
		custLevel=userInfo.getValue(5);
		addr=userInfo.getValue(4);

		if(retVal.getUtype(2)!=null&&retVal.getSize("2")>6&&retVal.getUtype("2.6")!=null){
				String ss="";;
				for(int i=0;i<retVal.getSize("2.6");i++){	 
							ss = retVal.getValue("2.6."+i+".0");
							if(ss!=null&&ss.equals(servId))
							productName = retVal.getValue("2.6."+i+".2");	
				}
		}
		System.out.println("servId----------------------------------------------"+servId);
%>
  <wtc:utype name="sQryUserOffers" id="retVal3" scope="end" >
				<wtc:uparam value="<%=servId%>" type="string" />
				<wtc:uparam value="0" type="string"/>
				<wtc:uparam value="0" type="string"/>	
				<wtc:uparam value="0" type="string"/>	
				<wtc:uparam value="0" type="string"/>
				<wtc:uparam value="0" type="string"/>	
	</wtc:utype>	
<%	
		String  retCode3=retVal3.getValue(0);
		String  retMsg3  =retVal3.getValue(1);
		String oldOfferId="";
		if(retCode3.equals("0"))
		{
				
				num2=retVal3.getSize(2);
				if(num2>0){
				oldOfferId = retVal3.getUtype("2.0").getValue(2);
				}
				havaProduct=new String[num2][24];
				
				for(int i=0;i<num2;i++)
				{
					for(int j=0;j<retVal3.getSize("2."+i);j++)
					{
						havaProduct[i][j]=retVal3.getValue("2."+i+"."+j);
						System.out.println("-------------------havaProduct["+i+"]["+j+"]----------------------"+havaProduct[i][j]);
					}
				}
		}else
		{
%>
		<script>
			rdShowMessageDialog("��ѯ�û���������Ʒ��Ϣ����,"+"<%=retCode3%>"+"<%=retMsg3%>");
			//window.location="customInfo.jsp?gCustId=<%=gCustId%>";
		</script>	
<%		
		}
%>						
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<!-- <link href="<%=request.getContextPath()%>/nresources/default/css_sx/FormText.css" rel="stylesheet"type="text/css"> -->
<title><%=opName%></title>
</head>
<script language="javascript">
	onload=function()
	{
	    
	    var arrClassValue = new Array();
        arrClassValue.push("<%=havaProduct[0][2]%>");
        getMidPrompt("10442",arrClassValue,"offer_name");

		document.all["qry1"].style.display="";
		document.getElementById("qry2").style.display="none";
		
		var offerId = "<%=offerId%>";
		var oldOfferId="<%=oldOfferId%>";
		if(oldOfferId!=offerId){
			document.getElementById("qry1").style.display="none";
			getOfferInfoFromBreak(offerId);
			}
	}
/*add by qidp @ 2009-07-21 for ����Ʒ����*/
    function chkLimit(id,iOprType)
    {
    	var retList="";
    	var phoneNo="<%=offerSrvId%>";
    	var opCode="<%=opCode%>";
    	var senddata={};
    	senddata["opCode"] = opCode;
    	senddata["prodId"] = id;
    	senddata["iOprType"] = iOprType;
    	senddata["vQtype"] = "1";
    	senddata["idNo"] = "<%=offerSrvId%>";
    		$.ajax({
    		  url: 'checkLimit.jsp',
    		  type: 'POST',
    		  data: senddata,
    		  async: false,//ͬ��
    		  error: function(data){
    				if(data.status=="404")
    				{
    				  alert( "�ļ�������!");
    				}
    				else if (data.status=="500")
    				{
    				  alert("�ļ��������!");
    				}
    				else{
    				  alert("ϵͳ����!");  					
    				}
    		  },
    		  success: function(data)
    		  {		   
    		          retList = data;
    		  }
    		});
    		senddata = null;
    		return  retList;
    }
/*end by qidp*/
	function getOfferInfoFromBreak(offerId){
		   var packet = new AJAXPacket("ajax_qryOfferInfoByOfferId.jsp?offerId="+offerId+"");
				packet.data.add("offerId" ,offerId);
				core.ajax.sendPacketHtml(packet,doGetInfoHtml);
				packet =null;
		}
		function doGetInfoHtml(packet){
			$("#proList").html(packet);
			}
	function query()
	{
		document.frm.hid_sale_mode.value="";
		var offerName =document.all.produceName.value;
		if(offerName=="����������Ʒ����")offerName="";
		var packet = new AJAXPacket("product_show_ajax.jsp?QRYFLAG=0&custId=<%=cust_id%>&closeId=<%=closeId%>&opCode=<%=opCode%>"+"&servId=<%=servId%>&opCode=<%=opCode%>&gCustId=<%=gCustId%>&offerSrvId=<%=offerSrvId %>&offerId=<%=offerId%>&phoneNo=<%=phoneNo%>&orderArrayId=<%=orderArrayId%>&custOrderId=<%=custOrderId%>&custOrderNo=<%=custOrderNo%>&servOrderId=<%=servOrderId%>&closeId=<%=closeId%>&servBusiId=<%=servBusiId%>");
		packet.data.add("offerName" ,offerName);
		packet.data.add("servId" ,"<%=servId%>");
		
		core.ajax.sendPacketHtml(packet,doGetHtml);
		packet =null;
	}
	function query2()
	{
		//var param ="123";
		var offerType=document.all.offerType.value;
		var offerCode=document.all.offerCode.value;
		var offerName=document.all.offerName.value;
		var receiveRegion=document.all.receiveRegion.value;
		var packet = new AJAXPacket("product_show_ajax.jsp?QRYFLAG=1&custId=<%=cust_id%>&closeId=<%=closeId%>&opCode=<%=opCode%>"+"&servId=<%=servId%>&opCode=<%=opCode%>&gCustId=<%=gCustId%>&offerSrvId=<%=offerSrvId %>&offerId=<%=offerId%>&phoneNo=<%=phoneNo%>&orderArrayId=<%=orderArrayId%>&custOrderId=<%=custOrderId%>&custOrderNo=<%=custOrderNo%>&servOrderId=<%=servOrderId%>&closeId=<%=closeId%>&servBusiId=<%=servBusiId%>");
		packet.data.add("offerType" ,offerType); 
		packet.data.add("offerCode" ,offerCode);
		packet.data.add("offerName" ,offerName);
		packet.data.add("receiveRegion" ,receiveRegion);
		packet.data.add("smCode" ,document.all.smCode.value);
		packet.data.add("offer_att_type" ,document.all.offer_att_type.value);
		
		core.ajax.sendPacketHtml(packet,doGetHtml);
		packet =null;
	}
	function query3()
	{
		//var offerId=document.all.offerType.value;
		var packet = new AJAXPacket("hot_product_show_ajax.jsp");
		//packet.data.add("offerId" ,offerType);
		core.ajax.sendPacketHtml(packet,doGetHtml2);
		packet =null;
	}
	function doGetHtml(data)
	{
		$("#proList").html(data);
	}
	function doGetHtml2(data)
	{
		$("#proList").html(data);
	}
	function chgblo()
	{
			document.getElementById("qry1").style.display="none";
			document.getElementById("qry2").style.display="block";
			document.getElementById("proList").innerHTML="";
	}
	function chghidd()
	{
			document.getElementById("qry1").style.display="block";
			document.getElementById("qry2").style.display="none";
			document.getElementById("rentMac").style.display="none";
			document.getElementById("proList").innerHTML="";
	}
	//ȡ��ģ������֮���"��ѯ"
		function qryByRentMac(){
			document.getElementById("queryInfo2").disabled=true;
			if(document.frm.imeiNo.value.trim()=="" || document.frm.hid_sale_mode.value.trim()==""){
				rdShowMessageDialog("�ô���û�в鵽��Ӧģ�壬����������");
				return false;
				}else{
					var opCode = "<%=opCode%>";
					var	qryFlag = "0";
					var	servId ="210000306062";
					var	offerId = "<%=offerId%>";
					var	flag = "N";
					var	offerCode = "";
					var	offerName ="";
					var	offerType ="0";
					var	offerAttrSeq ="0";
					var	offerAttrType="";
					var	userRange ="0101010";
					var	custGroupId ="0";
					var	channelSegmen="";
					var sale_mode = document.frm.hid_sale_mode.value;
					var packet = new AJAXPacket("ajax_qryOfferBySecRentInfo.jsp","���Ժ�...");
					packet.data.add("opCode" ,opCode);
					packet.data.add("qryFlag" ,qryFlag);
					packet.data.add("servId" ,servId);
					packet.data.add("offerId" ,offerId);
					packet.data.add("flag" ,flag);
					packet.data.add("offerCode" ,offerCode);
					packet.data.add("offerName" ,offerName);
					packet.data.add("offerType" ,offerType);
					packet.data.add("offerAttrSeq" ,offerAttrSeq);
					packet.data.add("offerAttrType" ,offerAttrType);
					packet.data.add("userRange" ,userRange);
					packet.data.add("custGroupId" ,custGroupId);
					packet.data.add("channelSegmen" ,channelSegmen);
					packet.data.add("sale_mode" ,sale_mode);
					core.ajax.sendPacketHtml(packet,doProductOfferByRentInfo);
					packet =null;
					}
		}       
		function doProductOfferByRentInfo(packet){
			$("#proList").html(packet);//���ݶ������������ѯ������Ʒ�б�
		}
		
	//���ݻ������ŵõ������Ϣ
	var modeCode="";
	function getImei(){	
  	if(document.frm.imeiNo.value.length == 0)
    {
        rdShowMessageDialog("�������������",0);
        return false;
    }
    var imeiNo=document.frm.imeiNo.value;
    var pageTitle = "�ֻ�������Ϣ��ѯ";
    var fieldName = "ģ�����|ģ������|��ͬ����(��)|���ۼ۸�(Ԫ)|��������(��)|Ѻ��(Ԫ)|�������(Ԫ)|Ԥ�滰��(Ԫ)|�����ѵ���(Ԫ)|���ʷ�|���ػ��ѱ���|";
    var sqlStr = "select c.sale_mode,c.mode_name,c.contract_months,c.sale_price,c.exists_months,c.deposit_money,c.contract_money,c.prepay_fee,c.payoff_rate,c.bind_mode,c.inland_rate,c.bind_mode,c.res_price from dChnResMobInfo a,sChnResBindModeItem b,sChnResSaleMode c, schnresstatusswitch d ,sChnResBindMode rb, dchngroupinfo gi where   c.rent_type ='0' and  b.bind_mode=rb.bind_mode and c.is_valid=1 and rb.is_valid=1 and sysdate between c.begin_time and c.end_time and sysdate between rb.begin_time and rb.end_time and trim(a.imei_no)=trim(upper('"+imeiNo+"')) and a.res_code=b.res_code and b.bind_mode=c.bind_mode and c.group_id in(select parent_group_id from dChnGroupInfo where group_id='"+"<%=groupId%>"+"') and c.sale_type = '0' and a.status_code=d.src_status and a.kind_code=d.kind_code and d.func_type='0' and d.func_code='1109' and a.group_id=gi.group_id and gi.parent_group_id='"+"<%=groupId%>"+"'"; 	
    
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "13|0|1|2|3|4|5|6|7|8|9|10|11|12|";
    var retToField = "imeiString|";
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 
		}
		
	function custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
			{
    /*
    ����1(pageTitle)����ѯҳ�����
    ����2(fieldName)�����������ƣ���'|'�ָ��Ĵ�
    ����3(sqlStr)��sql���
    ����4(selType)������1 rediobutton 2 checkbox
    ����5(retQuence)����������Ϣ������������� �������ʶ����'|'�ָ�����"3|0|2|3"��ʾ����3����0��2��3
    ����6(retToField))������ֵ����������,��'|'�ָ�
    */
    var path = "ajax_qryModelByMacNo.jsp";   //����Ϊ*
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    
    var imeiNo=document.all.imeiNo.value;
    path = path + "&imeiNo=" + imeiNo ;
    path = path + "&regionCode=" + "<%=regionCode%>" ;
    path = path + "&phoneNo=" + "<%=phoneNo%>" ;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    
	  var obj33 = frm;
    retInfo = window.showModalDialog(path,obj33,"dialogWidth:50;dialogHeight:40;");
	
    if(typeof(retInfo) == "undefined")     
    {   
    	return false;   
    }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    
    document.frm.contractInfo.value =retInfo;
}
//"�������"��ť
function rentMacSec(){
	document.getElementById("rentMac").style.display="block";
	document.getElementById("qry1").style.display="none";
	}
	//"����"��ť
	function resetInfo(){
		document.getElementById("queryInfo2").disabled=false;
		document.frm.imeiNo.value="";
		document.frm.contractInfo.value="";
		document.frm.rentDeposit.value="";
		document.frm.rentCostPre.value="";
		}
	function midPrompt(vOfferId,obj){
        var arrClassValue = new Array();
        arrClassValue.push(vOfferId);
        getMidPrompt("10442",arrClassValue,"offer_td_"+vOfferId);
    }
    
    
  function setOfferType(){
				var packet = new AJAXPacket("ajax_getOfferType.jsp","���Ժ�...");
    		packet.data.add("smCode" ,document.all.smCode.value);
				core.ajax.sendPacket(packet,dosetOfferType);	
			}	
			
	function 	dosetOfferType(packet){
				var retResult = packet.data.findValueByName("retResult"); 
				var selectObj = document.getElementById("offer_att_type");
			  selectObj.length=0;
				selectObj.options.add(new Option("--��ѡ��--",""));
				for(var i=0;i<retResult.length;i++){
					var reg = /\s/g;     
     			var ss = retResult[i][0].replace(reg,""); 
						if(ss.length!=0){
							selectObj.options.add(new Option(retResult[i][0]+"-->"+retResult[i][1],retResult[i][0]));
						}
					}
			}
</script>	
<body>
<form  name="frm" action="" method="post">
<input type="hidden" name="rightflag" value="1">
<input type="hidden" name="vServ_id" value="<%=servId%>" >
<input type="hidden" name="vofferId" value="" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�ͻ�������Ϣ</div>
</div>
<table cellspacing=0>
        <tr>
        <td class="blue">�ͻ�����</td>
        <td><%=custName%>
        </td>
        <td class="blue">֤������</td>
        <td><%=idIccid%>
        </td>
        <td class="blue">��ͻ���־</td>
        <td> <%=(row1[0][0]+"--"+row2[0][0])%>
        </td>
    </tr>
    <tr>
        <td class="blue">��ַ��Ϣ</td>
        <td colspan="5"><%=addr%>
        </td>
    </tr>
    <tr>
        <td class="blue">��Ʒ����</td>
        <td><%=productName%>
        </td>
        <td class="blue">�������</td>
        <td><%=phone_no%>
        </td>
        <td colspan="2"><a href="#"><input type="button" value="��ϸ��Ϣ" class="b_text" onclick="window.showModalDialog('/npage/common/qcommon/bd_0001.jsp?mytemp=<%=((row1[0][0]+"--"+row2[0][0]))%>&gCustId=<%=gCustId%>&opName=�ͻ���ϸ��Ϣ','dialogHeight=700px','dialogWidth=650px','help=no','status=no')"></a></td>
    </tr>
</table>
				
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">�Ѿ�����������Ʒ</div>
</div>
			<table cellspacing=0>
<%		

			
			String staflag="";
			String staflagClass="";
			String offerIds = "";
			for(int i=0;i<num2;i++)
			{
			offerIds = offerIds+"#"+havaProduct[i][2]+"|"+havaProduct[i][4];
			
				if(havaProduct[i][1].equals("0"))
				{
						staflag="��Ч";
						staflagClass="enabled";
				}else
				{
						staflag="��Ч";
						staflagClass="failure";
				}
				String tim1=havaProduct[i][6];
				String tim2=havaProduct[i][7];
				if(tim1!=null&&tim1.length()>8){ 
					tim1=havaProduct[i][6].substring(0,8);
				}
				if(tim2!=null&&tim2.length()>8){ 
					tim2=havaProduct[i][7].substring(0,8);
				}
				String dis="";
				if(havaProduct[i][21]==null||"0".equals(havaProduct[i][21])||"".equals(havaProduct[i][21])){
					dis="disabled";
				}
				System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%18=="+havaProduct[i][18]);
				System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%19=="+havaProduct[i][19]);
%>				
			<tr>
			<td class=blue nowrap><span class="<%=staflagClass%>"><%=staflag%></span>����</td>
			<% String myTemp=havaProduct[i][2]+"-->"+havaProduct[i][4];
			 %>
			
			<td id='offer_name'><%=myTemp%>
			</td>
			<td class="blue">��ʧЧʱ��</td>
			<td><%=tim1 %>--<%=tim2%>
			</td>
			<td class="blue"><%=havaProduct[i][20]%>->��Ա��</td>
			<td><%=havaProduct[i][21]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" class="b_text" <%=dis %> value="����..." onclick="window.showModalDialog('groupDetInfo.jsp?GroupId=<%=havaProduct[i][18]%>&custId=<%=cust_id%>&opCode=<%=opCode%>','dialogHeight=700px','dialogWidth=650px','help=no','status=no')"/>
			</td>
			</tr>
<%
		}
%>			
			</table>
			</div>
			 <div class="list">
			<div class="input">

</div>
<div id="qry1" name="qry1" style="display:block">
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">�ɸ���������Ʒ</div>
</div>

			
			<table cellspacing=0>
			<tr>
			<td class="blue">�ɸ���������Ʒ</td>
			<td colspan="3"><input type="text" name="produceName" value="����������Ʒ����"   size="35" onfocus='if(this.value=="����������Ʒ����")this.value=""' onblur='if(this.value=="")this.value="����������Ʒ����"'/></td>
			<td colspan="8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_text" value="��ѯ" onClick="query()" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
			<input type="button" class="b_text" value="�߼�����" onclick="chgblo()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<!--input type="button" class="b_text" value="�������" onClick="rentMacSec()"/--></td>
			</tr>
		</table>
		</div>
	</div>
	
<div id="rentMac" style="display:none">
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">���������Ϣ</div>
</div>
	     <table cellspacing=0>
	       <tr>
	        <td class="blue">��������</td>
	        <td><input class="" name="imeiNo" value="" onKeyPress="if(event.keyCode == 13)getImei()">
	           <input type="button" class="b_text"  value="��ѯ" onclick="getImei();">
	        </td>
	        <td class="blue">��ͬ��Ϣ��</td>
	        <td><input class="" name="contractInfo" value="" readonly></td>
	       </tr>
	       <tr>
	        <td class="blue">���Ѻ��</td>
	        <td><input class="" name="rentDeposit" value="" readonly></td>
	        <td class="blue">���Ԥ���</td>
	        <td><input class="" name="rentCostPre" value="" readonly></td>
	       </tr>
	      <tr>
	         <td colspan="4" align="center"><input class="b_foot" id="queryInfo2" type="button" value="��ѯ" onClick="qryByRentMac();"><input class="b_foot" type="button" value="����" onClick="resetInfo();"><input class="b_foot" type="button" value="����" onClick="chghidd()"></td>
	      </tr> 
	     </table>
    </div>
</div>

<div id="qry2" name="qry2" style="display:none">
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">�߼���������</div>
</div>

					<table cellspacing=0>
						<tr>
						<td class="blue">����Ʒ����</td>
						<td>
						<input class="" name="offerName" value="" >
						</td>						
						<td class="blue">����Ʒ����</td>
						<td>
						<input class="" name="offerCode" value="" >
						</td>
						</tr>
						<tr>
							<td class='blue' nowrap>Ʒ��</td>
						<td>
			<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
    		  <wtc:param value="214"/>
    	</wtc:service>
    	<wtc:array id="result_t1" scope="end"/>
			<SELECT name="smCode" id="smCode"  onchange="setOfferType()"> 
				<option value="">--��ѡ��--</option>
    		<%
 				for(int i=0;i<result_t1.length;i++){
 				%>
					<option value="<%=result_t1[i][0]%>"><%=result_t1[i][0]%>--><%=result_t1[i][1]%></option>
			<%}%>
    </SELECT>
						</td>
							<td class='blue' nowrap>����Ʒ����</td>
						<td >
					<SELECT name="offer_att_type" id="offer_att_type"> 
						<option value="">--��ѡ��--</option>
    			</SELECT>
						</td>
						
 </tr>
 
 <tr>
						<td class="blue">��������</td>
						<td colspan=3>
			<SELECT name="receiveRegion" id="receiveRegion"> 
			<option value="">---��ѡ��--- </option>
    	<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
			   <wtc:param value="25"/>
			   <wtc:param value="<%=workNo%>"/>
    	</wtc:service>
    	<wtc:array id="rowsRegion" scope="end"/>
    	<%
		   if(retCode.equals("000000"))
    	   {
    	     StringBuffer sb = new StringBuffer(80);
			 String val="";
			 String val_name="";
    	     for(int i=0;i<rowsRegion.length;i++)
    	     {
				 val=rowsRegion[i][0];
				 val_name=rowsRegion[i][1];
				 if(val==null) val="";
				 if(val_name==null) val_name="";
	        	 sb.append("<option value=\"")
	           .append(val)
	           .append("\">")
	           .append(val+"-->"+val_name)
	           .append("</option>");
           }
           out.println(sb.toString());
    	   }
    	   
    	%>
    	
    </SELECT>
</td>
</tr>
<tr>
<td colspan="4" align="center"><input class="b_foot" type="button" value="��ѯ" onClick="query2()"><input class="b_foot" type="button" value="����" onClick="chghidd()"></td>
</tr>
</table>
			</table>
			</div>
		</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">��ѡ����Ʒ�б�</div>
</div>
<div id="proList">
</div>
		<div id="footer">
		<input type="button"  class="b_foot" value="ȷ��" onclick="next()"  />
		<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()" />
		</div>
<input type="hidden" name ="hid_rentCostPre" value =0.00>   <!--���Ԥ���-->   
<input type="hidden" name ="hid_rentDeposit" value =0.00>   <!--���Ѻ��-->
<input type="hidden" name="hid_sale_mode" value="">	<!---�����ģ��ID-->
<input type="hidden" name="OfferIdUrl" value="">
<input type="hidden" name="sale_price" value=""><!--���ۼ۸�-->
<input type="hidden" name="contract_months" value=""><!--��ͬ����-->
<input type="hidden" name="exists_months" value=""><!--��������-->
<input type="hidden" name="contract_money" value=""><!--�������-->
<input type="hidden" name="payoff_rate" value=""><!--�����ѵ���-->
<input type="hidden" name="offerType" id="offerType" value="10">
<input type="hidden" name="offerIds" id="offerIds" value="<%=offerIds%>"><!-- ��¼����ƷID�ύʱ�������� -->


<%@ include file="/npage/include/footer_new.jsp" %>
	</form>
</body>
</html>
<script language="javascript">
	function shutdown()
{
	window.parent.removeTab("<%=closeId%>");
}
	function checklim(){
				var _id=this.value.split(",")[0];
				var retArr=chkLimit(_id,"1").split("@");
				retCo=retArr[0].trim();
				retMg=retArr[1];
				if(retCo!="0" )
				{
						
						if(retCo=="110001"){
			     	 	if(rdShowConfirmDialog(retMg)!=1) 
			     	 			{
						     	 return false;
			     	 			}
						  	}else{
						  		 rdShowMessageDialog(retMg,1);
						     	 return false;
						    }
				}		
	}
	function next()
	{
	    getAfterPrompt();
		var rad=document.getElementsByName("proRad");
		
		var offerIds = document.all.offerIds.value;
		//alert("offerIds|"+offerIds);
		var offerIdArr = offerIds.split("#");
		//hejwa ���Ӷ�����Ʒ�������� 2009-10-9 15:51
        for(var i=0;i<offerIdArr.length;i++){
        	
					if(offerIdArr[i]!=""){
						
//						alert("offerIdArr["+i+"]|"+offerIdArr[i]);
						var tempOffreArr = offerIdArr[i].split("|");
						
						var _id=tempOffreArr[0];
						var _name = tempOffreArr[1];
						
						//alert("_id|"+_id+"\n"+"_name|"+_name);
						
						var retArr=chkLimit(_id,"0").split("@");
						retCo=retArr[0].trim();
						retMg=retArr[1];
						
						
						if(retCo!="0" )
						{
							var  temph2 = _id+"#"+_name+"	 "+retMg;
						     	if(retCo=="110001"){
								     	 if(rdShowConfirmDialog(temph2)!=1) return false;
								  }else{
								  		 rdShowMessageDialog(temph2);
								  		 return false;
								  	}
						}
					}
				}


		var flag="false";
		if(rad.length>0)
		{
			for(var i=0;i<rad.length;i++)
			{
				if(rad[i].checked)
				{
					var OFFER_ID=rad[i].value;
					flag="true";
					document.frm.vofferId.value=OFFER_ID;
					var sale_mode = document.frm.hid_sale_mode.value;
					var imeiNo=document.all.imeiNo.value;
					var sale_price=document.all.sale_price.value;
					var contract_months = document.all.contract_months.value;
					var exists_months =document.all.exists_months.value;
					var contract_money=document.all.contract_money.value;
					var payoff_rate =document.all.payoff_rate.value;
					var rentCostPre = document.all.hid_rentCostPre.value;
					var rentDeposit = document.all.hid_rentDeposit.value;
					document.frm.action="offerReplace3.jsp?custId=<%=cust_id%>&closeId=<%=closeId%>&opCode=<%=opCode%>&opName=<%=opName%>"+"&servId=<%=servId%>&opCode=<%=opCode%>&gCustId=<%=gCustId%>&offerSrvId=<%=offerSrvId %>&offerId=<%=offerId%>&offerName=<%=offerName%>&phoneNo=<%=phoneNo%>&orderArrayId=<%=orderArrayId%>&custOrderId=<%=custOrderId%>&custOrderNo=<%=custOrderNo%>&servOrderId=<%=servOrderId%>&closeId=<%=closeId%>&servBusiId=<%=servBusiId%>&prtFlag=<%=prtFlag%>&productName=<%=productName%>&sale_mode="+sale_mode+"&imeiNo="+imeiNo+"&contract_months="+contract_months+"&sale_price="+sale_price+"&rentCostPre="+rentCostPre+"&rentDeposit="+rentDeposit+"&exists_months="+exists_months+"&contract_money="+contract_money+"&payoff_rate="+payoff_rate;
					
					document.frm.submit();
				}	
			}
			if(flag=="false")
			{
				rdShowMessageDialog("������ѡ��һ���������Ʒ");
				return false;
			}
		}else
		{
				rdShowMessageDialog("û�п��Ը���������Ʒ��Ϣ");
				return false;
		}
	}
</script>	
<%
}else
{
%>
<script>
	rdShowMessageDialog("��ѯ�û���Ϣ����,"+"<%=retCode0%>"+"<%=retMsg0%>");
	//window.location="produceChgShow.jsp?cust_id=910000027258";
</script>
<%
}
%>