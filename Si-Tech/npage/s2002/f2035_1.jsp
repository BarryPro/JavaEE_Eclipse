<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��10��25��
�� * ����: piaoyi
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸����� 2008.12.17     �޸��� leimd     �޸�Ŀ��
 ��*/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String workName = (String)session.getAttribute("workName");
    String ipAddr = (String)session.getAttribute("ipAddr");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String opCode="2035";
	String opName="��ԱǩԼ��ϵ����";  
	String sqlStr="";
%>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<html>
<link href="s2002.css" rel="stylesheet" type="text/css">
<script>
	function getCustomerNumber(){
		var pageTitle = "������Ϣ";
	    var fieldName = "��Ʒ������|������Դ|��Чʱ��|��Ʒ״̬|";
	    var sqlStr = "";
	    var selType = "S";    //'S'��ѡ��'M'��ѡ
	    var retQuence = "4|0|1|2|3|";
	    var flag="";
	    if($("#operType").val()=="5")
	    {
	    	flag="1";
	    }
	    else
	    {
	    	flag="0";
	    }
	    var retToField = "productID|orderSource|p_AccessNumber|p_PriAccessNumber|";
	
	    var path = "<%=request.getContextPath()%>/npage/s2002/f2035_getCustomerNumber.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName="+fieldName;
	    path = path + "&selType="+selType;
	    path = path + "&retQuence="+retQuence;
	    path = path + "&retToField="+retToField;
	    path = path + "&s_OrderSource=" +$("#orderSource").val();
	    path = path + "&s_ProductID=" +$("#productID").val();
	    path = path + "&s_flag="+flag;
	    retInfo = window.open(path,
	                          "newwindow",
	                          "height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	    return true;
		
	}
	
	function toNextPage(){
	    if(check(form1)){
	    	getProduct();
			var operType = document.all.operType.value;
			if(operType=="1"){
				document.form1.action="f2035_2.jsp";
				document.form1.submit();
			}else if(operType=="5"){
				document.form1.action="f2035_5.jsp";
				document.form1.submit();
			}
			else if(operType=="6"){
				document.form1.action="f2035_7.jsp";
				document.form1.submit();
			}
			else{
				document.all.orderSourceName.value = document.getElementById("orderSource").options[document.getElementById("orderSource").selectedIndex].innerText;;
				document.form1.action="f2035_4.jsp";
				document.form1.submit();	
			}
	    }
	}
function getProduct()//��ȡ��Ʒ������
{
    var getProduct_Packet = new AJAXPacket("f2035_getProductSpecNumber.jsp","���ڻ�ȡ��Ʒ�����룬���Ժ�......");
	getProduct_Packet.data.add("retType","getProduct");
    getProduct_Packet.data.add("productId",$("#productID").val());
	core.ajax.sendPacket(getProduct_Packet);
	getProduct_Packet=null;
}
function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");			
	if(retType=="getProduct")
    {
    	if(retCode="000000")
    	{ 
    			var productSpecNum = packet.data.findValueByName("productSpecNum");
    			document.all.productSpecNum.value = productSpecNum;			    			
    	}
    	else
    	{		    	
    		rdShowMessageDialog(retMessage);
    	}
    }			
}		
function setButtonUse() {
		document.all.nextoper.disabled=true;
}
</script>
</head>
<body>
<form name="form1" method="post">
	<input type="hidden" name="pageOpCode" value="<%=opCode%>">
	<input type="hidden" name="pageOpName" value="<%=opName%>">
	<input type="hidden" id="grpIdNo" name="grpIdNo" value="">
	<input type="hidden" name="productSpecNum" value="">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��Ʒ������Ϣ</div>
</div>
<table cellspacing=0>
	<tr>
		<td class="blue" width="15%">
		 	��Ʒ������ϵ����
		</td>
		<td  width="35%">       
			<input name="productID" id="productID" v_type="string"  v_must="1" size="20" maxlength="20" onChange="setButtonUse()">
				<font class="orange">*</font>              
			<input name="CustomerNumberQuery" type="button" class="b_text" onclick="getCustomerNumber()" id="getCustomerNumberBtn" value="��ѯ">                      
		</td>
		<td class="blue"  width="15%">
			������Դ
		</td>
	    <td  width="35%">
	    	<select name="orderSource" id=orderSource>
               <option value='0'>ʡBOSS�ϴ� </option>
	  			<option value='1'>EC�ϴ�</option>
	  			<option value='2'>BBOSS����</option>
      		</select>
      			<input type="hidden" value="" name="orderSourceName">    	           
    		</td>    
	</tr>
    <tr>
    	<td class="blue"  width="15%" >
    		��������
    	</td>
    	<td  width="85%" colspan="3">       
      		<select name="operType" id="operType" width=50>  			
	  			<option value='5'>��ѯ </option>
	  			<option value='1'>���� </option>
	  			<option value='0'>ɾ�� </option>
	  			<!--<option value='2'>�����Ա���� </option>--><!--wuxy alter 20090709 ȥ���ò�������-->
	  			<option value='3'>��ͣ��Ա </option>
	  			<option value='4'>�ָ���Ա </option>
	  			<option value='6'>�޸ĳ�Ա���� </option>
      		</select>
      			<font class="orange">*</font>
		</td>   
	</tr>
	<tr>
    	<td align="center" id="footer" colspan="4">
      		<input class="b_foot" name=next id=nextoper type=button value="��һ��" onclick="toNextPage()" disabled>
      		<input class="b_foot" name=reset type=button value="�ر�" onClick="removeCurrentTab()">
    	</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
