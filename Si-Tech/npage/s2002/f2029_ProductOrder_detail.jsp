<%
   /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��10��25��
�� * ����: piaoyi
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/public/pubSASql.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  String opCode="";
  String opName="��Ʒ����������Ϣ";
  String sqlStr="";
  String workNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String dataConsult = request.getParameter("dataConsult");//wangzn 090927
  String idRadio = request.getParameter("idRadio");
 // out.print(dataConsult);
 // String p_BusinessMode = (String)session.getAttribute("p_BusinessMode_f2029_1.jsp"); //add by wangzn  for test
 // String p_OperType = (String)session.getAttribute("p_OperType_f2029_1.jsp"); //add by wangzn for test
 // out.println(p_BusinessMode+"----"+p_OperType); //add by wangzn for test
  
    /* add by qidp @ 2009-12-15 */
    String inputFlag = WtcUtil.repNull((String)request.getParameter("inputFlag"));
    
    /* end of add */
    String p_OperType = WtcUtil.repNull((String)request.getParameter("p_OperType"));
    String org_code = (String)session.getAttribute("orgCode");
    String regionCode=org_code.substring(0,2);
    String sProductOrderNumber = WtcUtil.repNull((String)request.getParameter("sProductOrderNumber"));
    String in_productspec_number  = WtcUtil.repNull((String)request.getParameter("in_productspec_number"));
    String in_ChanceId = WtcUtil.repNull((String)request.getParameter("in_ChanceId"));
    System.out.println("====wanghfa==== in_ChanceId = " + in_ChanceId);
    String in_BatchNo = WtcUtil.repNull((String)request.getParameter("in_BatchNo"));
    String poorder_type = WtcUtil.repNull((String)request.getParameter("poorder_type"));
    String busi_req_type = "";
    String operatorCode = "";
    
    //wangzn 2010-5-7 15:39:33
    String sysAccept = "";
    %>
        <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
    <%
    sysAccept = seq;
    if(!"".equals(in_ChanceId)){
     String SqlBUSI = "SELECT BUSI_REQ_TYPE FROM DBSALESADM.DMKTCHANCE WHERE CHANCE_ID = '"+in_ChanceId+"'";    
     %>
     <wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
		 <wtc:sql><%=SqlBUSI%></wtc:sql>
	   </wtc:pubselect>
	   <wtc:array id="resultBUSI" scope="end"/>
     <%
     busi_req_type = resultBUSI[0][0];
     System.out.println("busi_req_type="+busi_req_type+"");
     
     }
%>
<HEAD>
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<div id="Main">
<DIV id="Operation_Table">


<div class="title"><div id="title_zi">��Ʒ����������Ϣ</div></div>
<input type="hidden" id="p_POOrderNumber" value="">
<input type='hidden' id='input_flag' name='input_flag' value='<%=inputFlag%>' /><!-- add by qidp @ 2009-12-15 -->
<input type="hidden" id="p_POSpecNumber" value="">
<input type="hidden" id="p_AcceptID" value="">
<input type="hidden" id="product_OperType" value="">
<input type="hidden" id="p_OperType" value="">
<input type="hidden" id="action_flag" value="">
<input type="hidden" id="p_Operation" value="">
<input type="hidden" id="is_add" value="">
<input type='hidden' id='fee_list' name='fee_list' value='' />
<input type='hidden' id='biz_flag' name='biz_flag' value='N' />
<input type='hidden' id='biz_display_flag' name='biz_display_flag' value='N' />
<input type='hidden' id='PlanCount_flag' name='PlanCount_flag' value='1' />
<table>
  <tr>
   <td>��Ʒ������
   </td>
   <td>
   	   <input id="p_ProductOrderNumber" type="string" size="20" maxlength="20"  v_must="1" readOnly >
   	   <input name="POOrderNumberQueryDiv" type="button" class="b_text" onclick="getUserId()" id="POOrderNumberQueryDiv" value="���">               
   </td>
   <td>��Ʒ������ϵID
   </td>
   <td>
   	   <input id="p_ProductID" type="string" size="20" maxlength="20" readOnly>
   </td>
 	</tr>
  <tr>
   <td>��Ʒ�����
   </td>
   <td>
   	   <input id="p_ProductSpecNumber" type="string" size="20" maxlength="20" v_must="1" readOnly>
   	   <input id="getProductNumber" type="button" class="b_text" onclick="getProductNumber()" value="��ѯ">
   </td>
   <td>��Ʒ�ؼ�����
   </td>
   <td>
   	   <input id="p_AccessNumber" type="string" size="20" maxlength="20">
   </td>
 	</tr>
  <tr>
   <td>��Ʒ��������
   </td>
   <td>
   	   <input id="p_PriAccessNumber" type="string" size="20" maxlength="20">
   </td>
   <td>��ϵ��
   </td>
   <td>
   	   <input id="p_Linkman" type="string" size="20" maxlength="20">
   </td>
 	</tr>
  <tr>
   <td>��ϵ�绰
   </td>
   <td>
   	   <input id="p_ContactPhone" type="0_9" size="20" maxlength="20">

   </td>
   <td>��Ʒ����
   </td>
   <td>
   	   <input id="p_Description" type="string" size="20" maxlength="20">
   </td>
 	</tr>
  <tr>
   <td>����ͨ�ȼ�ID
   </td>
   <td>
   	   <input id="p_ServiceLevelID" type="string" size="20" maxlength="20">
   </td>  
   <td>��Ʒ״̬
   </td>
   <td>
   	   <input id="p_ProductStatus" type="string" size="20" maxlength="20" readOnly>
   </td>
  </tr>
  <tr id="selSalesTr" style="display:none">
      <td>���۴�����</td>
      <td colspan="3">
        <input type='text' id='selSales' name='selSales' maxlength='128' size='20' readOnly value="">&nbsp;
        <input type='button' class='b_text' id='selSalesBtn' name='selSalesBtn' value='��ѯ' onClick='selSales()' >
      </td>
      <!-- liujian 2012-8-27 10:42:35 ������ begin-->
      <input type="hidden" id="bargain" name="bargain" />
      <!-- liujian 2012-8-27 10:42:35 ������ end-->
  </tr>
    <tr id="BIZ">
   <td>ҵ�����
   </td>
   <td>
   	   <input id="p_BIZCODE" type="string" size="20" maxlength="10">
   	   <input name="getBiZ" type="button" class="b_text" onclick="getBIZ()" id="getBIZ" value="��ø��ѷ�ʽ">
   </td>  
   <td id="feeflag">���ѱ�־
   </td>
   <td>
   	   <select name="p_BillType" id=p_BillType>
       <option value="0">���Ÿ���</option>
       <option value="1">���˸���</option>
      </select>
   </td>
  </tr>
<tbody id="feeInfo" style="display:none;">
    
</tbody>
   <tr id="fee">
   <td>һ���Է���</td>
   <td><input id="p_OneTimeFee" type="string" size="20" maxlength="20"> </td>  
   <td>&nbsp;</td>
   <td>&nbsp;</td>
  </tr>
</table>

<br>


<DIV id="div4_show"   class="groupItem">
   <DIV class="title">
   	  <DIV id="zi0">��Ʒ��ҵ������б�</DIV>
   </DIV>
<table cellSpacing=0>
  <tr id="div4_1_show">
    <td class="blue" width="25%">
    	<input type="radio" name="OperationSubTypeIDRadio" value="A" onclick="doClickRadio(this)">
      ��ƷԤ��
    </td class="blue">   	
    <td class="blue" width="25%">
    	<input type="radio" name="OperationSubTypeIDRadio" value="3" onclick="doClickRadio(this)">
      ��Ʒ��ͣ
    </td class="blue">
    <td class="blue" width="25%">
    	<input type="radio" name="OperationSubTypeIDRadio" value="4" onclick="doClickRadio(this)">
      ��Ʒ�ָ�
    </td class="blue">   
    <td class="blue" width="25%" >
    	<input type="radio" id="dis" name="OperationSubTypeIDRadio" value="2" onclick="doClickRadio(this)" >
      <font id="dis">��Ʒ</font>
    </td class="blue">
    <td class="blue" width="25%" id="dis">
    	<input type="radio" id="dis" name="OperationSubTypeIDRadio" value="1" onclick="doClickRadio(this)">
      <font id="dis">��Ʒ</font>
    </td class="blue">
  </tr>
    <tr id="div5_show"   class="groupItem">
    <td class="blue" width="25%">
    	<input type="radio" name="OperationSubTypeIDRadio" value="A" onclick="doClickRadio(this)">
      ��ƷԤ��
    </td class="blue">
    <td class="blue" width="25%">
    	<input type="radio" name="OperationSubTypeIDRadio" value="2" onclick="doClickRadio(this)">
      ��Ʒ����
    </td class="blue">
    <!-- yuanqs add 100819 �����·��ƶ�400ҵ���Ż�ҵ��֧��ϵͳʵʩ������֪ͨ begin -->
    <td class="blue" width="25%">
    	<input type="radio" name="OperationSubTypeIDRadio" value="11" onclick="doClickRadio(this)">
      Ԥȡ����Ʒ����
    </td class="blue">
    <td class="blue" width="25%">
    	<input type="radio" name="OperationSubTypeIDRadio" value="12" onclick="doClickRadio(this)">
      �䶳�ڻָ���Ʒ����
    </td class="blue">
    <!-- yuanqs add 100819 �����·��ƶ�400ҵ���Ż�ҵ��֧��ϵͳʵʩ������֪ͨ end -->
    <td class="blue" width="25%" id="dis">
    	<input type="radio" id="dis" name="OperationSubTypeIDRadio" value="10" onclick="doClickRadio(this)" >
      <font id="dis">��Ʒ</font>
    </td class="blue">
    <td class="blue" width="25%" id="dis">
    	<input type="radio" id="dis" name="OperationSubTypeIDRadio" value="7" onclick="doClickRadio(this)">
      <font id="dis">��Ʒ</font>
    </td class="blue">
    
  </tr>
  <tr id="div4_2_show">
    <td class="blue" width="25%">
    	<input type="checkbox" name="OperationSubTypeIDChkBox" value="5" onclick="doClickChkBox(this)">
      �޸Ĳ�Ʒ�ʷ�
    </td class="blue">
    <td class="blue" width="25%">
    	<input type="checkbox" name="OperationSubTypeIDChkBox" value="9" onclick="doClickChkBox(this)">
      �޸Ķ�����Ʒ����
    </td class="blue">   
    <td class="blue" width="25%">
    	<input id="dis" type="checkbox" name="OperationSubTypeIDChkBox" value="8" onclick="doClickChkBox(this)">
      <font id="dis">�޸Ľɷѹ�ϵ(����)</font>
    </td class="blue">
    <td class="blue" width="25%">
    	<input id="dis" type="checkbox" name="OperationSubTypeIDChkBox" value="6" onclick="doClickChkBox(this)">
      <font id="dis">�����Ա</font>
    </td class="blue">
    
  </tr>
  <tr id="div10_show">
  	<td class="blue" width="25%">
    	<input type="checkbox" name="OperationSubTypeIDChkBox" value="10" onclick="doClickChkBox(this)">
      ��ƷԤ����
    </td class="blue">
    <td class="blue" width="25%">
    	<input type="checkbox" name="OperationSubTypeIDChkBox" value="1" onclick="doClickChkBox(this)">
      ��Ʒ����
    </td>
    <td class="blue">
    	<input type="checkbox" name="OperationSubTypeIDChkBox" value="13" onclick="doClickChkBox(this)">
      ҵ�����ʡ������ɾ��
    </td>
    <td>&nbsp;</td>
    
  </tr>

</table>
</DIV>

<%if("6".equals(p_OperType)){%>
<wtc:service name="s9104ManQry" outnum="4" routerKey="region" routerValue="<%=regionCode%>">		
	<wtc:param value="<%=sProductOrderNumber%>"/>
</wtc:service>
<wtc:array id="result" start="0" length="3" scope="end" />
<wtc:array id="result1" start="3" length="1" scope="end" />
<%  
operatorCode = result1[0][0];
%>
<wtc:service name="s9104MaChaQry" outnum="5" routerKey="region" routerValue="<%=regionCode%>">		
	<wtc:param value="<%=sProductOrderNumber%>"/>
	<wtc:param value="<%=operatorCode%>"/>
</wtc:service>
<wtc:array id="result2" start="0" length="5" scope="end" />

<DIV id="div6_show"   class="groupItem">
   <DIV class="title">
   	  <DIV id="zi0">BBOSS�·�����ڵ�</DIV>
   </DIV>
   <table cellSpacing=0>
   	<tr><th>����id</th><th>��������</th><th>����ֵ</th>
    </tr>
    <%for(int tempInt = 0;tempInt<result.length;tempInt++){%>
   	<tr>   
    <td class="blue"><%=result[tempInt][0]%></td>
    <td class="blue"><%=result[tempInt][1]%></td>
    <td class="blue"><%=result[tempInt][2]%></td>
    </tr>
    <%}%>
   </table>
   <br/>
    <DIV class="title">
   	  <DIV id="zi0">BOSS�ϴ�����ڵ�</DIV>
    </DIV>
    <table cellSpacing=0>
   	<tr>  		
   		<th>����id</th><th>��������</th><th>����ֵ</th>
    </tr>
    <%for(int tempInt = 0;tempInt<result2.length;tempInt++){%>
   	<tr class="ProductOrder_ManageCharacter" 
   		a_OperateCode="<%=result2[tempInt][4]%>"
   		a_CharacterID="<%=result2[tempInt][0]%>"
   		a_CharacterName="<%=result2[tempInt][1]%>"
   		a_CharacterValue=" " 
   		a_CharacterDesc="<%=result2[tempInt][3]%> "
   		>   
    <td class="blue"><%=result2[tempInt][0]%></td>
    <td class="blue"><%=result2[tempInt][1]%></td>
    <%if("".equals(result2[tempInt][2])){%>
         <td><input type=text id='<%=result2[tempInt][0]%>' name='<%=result2[tempInt][0]%>' onPropertyChange="setManaCharVal(this);"  maxlength="1000" ></td><!--wuxy alter 20110530�淶�����������1000,��ǰ̨�ﲻ�� -->
    <%}else{
    	String[] characterValues = result2[tempInt][2].split(",");
    	%>
         <td>
         	 <select onchange='selManaCharVal(this)' name='sel<%=result2[tempInt][0]%>'>
         	   <%for(int tempInt2 = 0;tempInt2<characterValues.length;tempInt2++){%>
         	         <option value='<%=characterValues[tempInt2]%>'><%=characterValues[tempInt2]%></option>
         	   <%}%>
         	 </select>
         	 <input type=hidden id='<%=result2[tempInt][0]%>' name='<%=result2[tempInt][0]%>' onPropertyChange="setManaCharVal(this);" maxlength="1000" ><!--wuxy alter 20110530�淶�����������1000,��ǰ̨�ﲻ�� -->
         </td>
    <%}%>
    </tr>
    <%}%>
   </table>
</DIV> 
<%}else if ("8".equals(p_OperType)){%>
<DIV id="div8_show"   class="groupItem">	
	<DIV class="title">
   	  <DIV id="zi0">����</DIV>
	</DIV>
	<table cellSpacing=0>
   	<tr>
   		<td  class="blue">�������</td>
   		<td  class="blue"><input type=text id='examine_content' name='examine_content' onPropertyChange="" size=70 /></td>
	</tr>
	<tr>
   		<td  class="blue">�Ƿ�ͨ��</td>
   		<td  class="blue"><select id='examine_result'><option value='Y'>ͨ��</option><option value='N'>��ͨ��</option></select></td>
	</tr>
</table>
</DIV>
<%}%>
<DIV id="div0_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div0_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">��Ʒ���ʷ��б�</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv0">
	 	  <DIV id="wait0"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>

<DIV id="div1_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div1_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">֧��ʡ�б�</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv1">
	 	  <DIV id="wait0"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>

<DIV id="div2_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div2_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">��Ʒ����ֵ�б�</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv2">
	 	  <DIV id="wait2"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>

<table>
  <tr>
    <td align="center" id="footer" colspan="4">
    	<input class="b_foot" id=confirm type=button value="ȷ��" onClick="">
      <input class="b_foot" id=closebtn type=button value="�ر�" onClick="window.close()">
    </td>
  </tr>
</table>
</div>
</div>
<script>
var ProductOrder;
var dataConsult = '<%=dataConsult%>' ; //wangzn 090927
var _jspPage =
{"div0_switch":["mydiv0","f2029_ProductOrderRatePlans_list.jsp","f"]
,"div1_switch":["mydiv1","f2029_PayCompanys_list.jsp","f"]
,"div2_switch":["mydiv2","f2029_ProductOrderCharacters_list.jsp","f"]
};
var resultLen;
var fieldCodeArr;
var fieldNameArr;
var fieldTypeArr;
var fieldLengthArr;
var ctrlInfoArr;
var fieldDefValueArr;
var queRen = 0;
function hiddenSpider()
{
	document.getElementById("mydiv0").style.display='none';
	document.getElementById("mydiv1").style.display='none';
	document.getElementById("mydiv2").style.display='none';
}

$(document).ready(function () {
	//���ؽ�����
	hiddenSpider();
	$('img.closeEl').bind('click', toggleContent);
	$('#nextoper').click(function(){
     nextoper();
  });
    if("<%=idRadio%>" == "A"){
        document.all.OperationSubTypeIDRadio[5].disabled=true;
        document.all.OperationSubTypeIDRadio[5].checked=true;
        document.all.OperationSubTypeIDRadio[6].disabled=true;
        document.all.OperationSubTypeIDRadio[7].disabled=true;//yuanqs add 100819 �����·��ƶ�400ҵ���Ż�ҵ��֧��ϵͳʵʩ������֪ͨ
        document.all.OperationSubTypeIDRadio[8].disabled=true;//yuanqs add 100819 �����·��ƶ�400ҵ���Ż�ҵ��֧��ϵͳʵʩ������֪ͨ
        document.all.OperationSubTypeIDChkBox[4].disabled=true;	//wanghfa wangleic add
        document.all.OperationSubTypeIDChkBox[5].disabled=true;	//wanghfa wangleic add
        document.all.OperationSubTypeIDChkBox[6].disabled=true;	//wanghfa wangleic add
    }else if("<%=idRadio%>" == "2"){
        document.all.OperationSubTypeIDRadio[5].disabled=true;
        document.all.OperationSubTypeIDRadio[6].checked=true;
        document.all.OperationSubTypeIDRadio[6].disabled=true;
        document.all.OperationSubTypeIDRadio[7].disabled=true;//yuanqs add 100819 �����·��ƶ�400ҵ���Ż�ҵ��֧��ϵͳʵʩ������֪ͨ
        document.all.OperationSubTypeIDRadio[8].disabled=true;//yuanqs add 100819 �����·��ƶ�400ҵ���Ż�ҵ��֧��ϵͳʵʩ������֪ͨ
    }else if("<%=idRadio%>" == "10"){	//yuanqs add 100819 �����·��ƶ�400ҵ���Ż�ҵ��֧��ϵͳʵʩ������֪ͨ
        document.all.OperationSubTypeIDRadio[5].disabled=true;
        document.all.OperationSubTypeIDRadio[7].checked=true;
        document.all.OperationSubTypeIDRadio[6].disabled=true;
        document.all.OperationSubTypeIDRadio[7].disabled=true;
        document.all.OperationSubTypeIDRadio[8].disabled=true;
        document.all.OperationSubTypeIDChkBox[4].disabled=true;
        document.all.OperationSubTypeIDChkBox[5].disabled=true;
        //OperationSubTypeIDChkBox
        
    }else if("<%=idRadio%>" == "11"){	//yuanqs add 100819 �����·��ƶ�400ҵ���Ż�ҵ��֧��ϵͳʵʩ������֪ͨ
        document.all.OperationSubTypeIDRadio[5].disabled=true;
        document.all.OperationSubTypeIDRadio[8].checked=true;
        document.all.OperationSubTypeIDRadio[6].disabled=true;
        document.all.OperationSubTypeIDRadio[7].disabled=true;
        document.all.OperationSubTypeIDRadio[8].disabled=true;
        document.all.OperationSubTypeIDChkBox[4].disabled=true;
        document.all.OperationSubTypeIDChkBox[5].disabled=true;
    }

  }
);

var toggleContent = function(e)
{
	var targetContent = $( 'DIV.itemContent',this.parentNode.parentNode.parentNode);
	if (targetContent.css('display') == 'none') {
		   targetContent.slideDown(300);
		   $(this).attr({ src: "../../../nresources/default/images/jian.gif"});
		   //���÷���
		   try{

		   	
		   	/*****   add by lusc ended by ////  ***/
        var proOperTypeRadio=document.getElementsByName("OperationSubTypeIDRadio");
        var proOperTypeChkbox=document.getElementsByName("OperationSubTypeIDChkBox");
        var proOperType="";
        //alert($("#p_ProductSpecNumber").val());

        for(var i=0;i<proOperTypeRadio.length;i++){
				if(proOperTypeRadio[i].checked){
					proOperType=proOperTypeRadio[i].value;
					break;
				}	
		}
		if(proOperType==""){
			for(var i=0;i<proOperTypeChkbox.length;i++){
				if(proOperTypeChkbox[i].checked){
					proOperType=proOperType+proOperTypeChkbox[i].value+"|";
				}	
			}
		}
				
				///////////////////////ended by lusc  ///////////////
			//alert(tmp2[2]+"rrrrrrrrrrrrrrrrrr"+tmp2[1]);
		   	var tmp = $(this).attr('id');
		   	var tmp2 = eval("_jspPage."+tmp);			
		   	if(tmp2[2]=="f"&&tmp2[1]!=''&&tmp2[1]!=undefined)
		   	{
		   		$("#"+tmp2[0]).load(tmp2[1],{sPOOrderNumber:$("#p_POOrderNumber").val()
		   			                          ,sPOSpecNumber:$("#p_POSpecNumber").val()
		   			                          ,sProductOrderNumber:$("#p_ProductOrderNumber").val()
		   			                          ,sCheckFlag1:ProductOrder[17]
		   			                          ,sCheckFlag2:ProductOrder[18]
		   			                          ,sCheckFlag3:ProductOrder[19]
		   			                          ,sProductSpecNumber:$("#p_ProductSpecNumber").val()
		   			                          ,sParAccpetID:$("#p_AcceptID").val()
		   			                          ,p_OperType:$("#p_OperType").val()
		   			                          ,product_OperType:proOperType //lusc add
		   			                          ,product_add_flag: ProductOrder[31]                         // ��Ʒ������Ϊ�޸ĵ�ʱ�� ��Ʒ��������ʶ
		   			                          ,in_ChanceId:'<%=in_ChanceId%>'
		   			                          ,in_BatchNo:'<%=in_BatchNo%>'
		   			                          ,busi_req_type:'<%=busi_req_type%>'
		   			                          ,poorder_type:'<%=poorder_type%>'
		   			                          });
		   	  //wuxy alter 20090923 ����ˢ������ 
		   		tmp2[2]="t";
		   	}
		   }catch(e)
		   {
		   }
	} else {
		targetContent.slideUp(300);
		$(this).attr({ src: "../../../nresources/default/images/jia.gif"});
	}
	return false;
};

// ��ѯ���۴�����
function selSales(){
    var pageTitle = "���۴����̲�ѯ";
    var fieldName = "�����̴���|����������|";
	  /* ningtn �����Ż����ſͻ�SA������ϵͳ�ĺ�*/
		var sqlStr="90000101";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "1|0|";
    var retToField = "selSales|";
    PubSimpSelSales(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelSales(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
		var params = "<%=pubSAGroupId%>|";
    var path = "/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+ "&params=" + params;  
    retInfo = window.showModalDialog(path);
    if(typeof(retInfo)=="undefined")      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
    }
}

//��ȡ������
function getUserId()
{
	
	//�õ����Ų�ƷID���͸����û�IDһ��
	var packet = new AJAXPacket("f2029_getOrderId.jsp","���Ժ�......");
 	packet.data.add("idType","1");
  core.ajax.sendPacket(packet);
	packet =null;	
    
}

function doProcess(packet)
{
	
		
   var retFlag = packet.data.findValueByName("retFlag");
   var ordernumber=packet.data.findValueByName("ordernumber");
   var sm_code=packet.data.findValueByName("sm_code");
   var billtype=packet.data.findValueByName("billtype");
   var att=packet.data.findValueByName("attached");
   var feetype=packet.data.findValueByName("feetype");
   ProductOrder[28]=att;
		switch(retFlag){
   			case "0":
   						document.all.p_ProductOrderNumber.value=ordernumber;
   	 					document.all.POOrderNumberQueryDiv.disabled=true;
   						break;
   			case "1":
   						rdShowMessageDialog("��ȡ������ʧ��!");
   						break;
   			case "5":
   						var vBizFlag = packet.data.findValueByName("bizFlag");
   						var vBizCode = packet.data.findValueByName("bizCode");
   						var PlanCount = packet.data.findValueByName("PlanCount");
   						document.all.PlanCount_flag.value=PlanCount;
   						if(vBizFlag == "Y"){
   						    $("#p_BIZCODE").val(vBizCode);
   						    $("#BIZ").show();
   						    $("#biz_display_flag").val("Y");
   						}else{
   						    $("#BIZ").hide();
   						}
   						/*
   						if(sm_code=="ML"||sm_code=="AD"||sm_code=="MA"){
   							$("#BIZ").show();
   							//$("#feeflag").hide();
   							//$("#p_BillType").hide();
   							document.getElementById("p_BillType").disabled=true;
   						}
   						*/
   						break;
   			case "6":
   						rdShowMessageDialog("�ò�Ʒ���δ�����ʷ�,�޷�����!");
   						break;
   			case "7":
   						if(billtype!="02"){
   							//document.getElementById("p_BillType").disabled=false;
   							$("#p_BillType").val("0");
   							$("#p_BillType").find("option:not(:selected)").remove();
   						}
   						$("#biz_flag").val("Y");
   						break;
   			case "8":
   						rdShowMessageDialog("��ҵ�������Ч�����ʵ!",0);
   						break;
   			case "9":
   						rdShowMessageDialog("����ѡ��Ĳ�ƷΪ������Ʒ");
   						ProductOrder[27]=att;
   						break;
   			case "10":
   						if(document.all.p_OperType.value=="2"){
	   						rdShowMessageDialog("����ѡ��Ĳ�ƷΪ����Ʒ,����Ԥ������Ʒ���������и�����Ʒ��Ԥ��");
								var msg = "����ѡ��Ĳ�ƷΪ����Ʒ,����Ԥ������Ʒ���������и�����Ʒ��Ԥ����ȷ��Ԥ����";   
								if (rdShowConfirmDialog(msg)==true){
									ProductOrder[27]=att;
								}else{  
									rdShowMessageDialog("��ȡ���˲���");
									ProductOrder[27]="no";
								}   
	   						break;
   						}else if(document.all.p_OperType.value=="4"){
   							ProductOrder[27]="zhu";
   							break;
   						}
   			case "11":
   			            /*
   						if(feetype.trim()=="1"){
   							$("#fee").show();
   						}else{
   							$("#fee").hide();
   						}
   						*/
   						/* add by qidp @ 2009-12-15 for ��̬չʾ������Ϣ */
   						resultLen = packet.data.findValueByName("resultLen");
   						fieldCodeArr = packet.data.findValueByName("fieldCodeArr");
                        fieldNameArr = packet.data.findValueByName("fieldNameArr");
                        fieldTypeArr = packet.data.findValueByName("fieldTypeArr");
                        fieldLengthArr = packet.data.findValueByName("fieldLengthArr");
                        ctrlInfoArr = packet.data.findValueByName("ctrlInfoArr");
                        fieldDefValueArr = packet.data.findValueByName("fieldDefValueArr");
                        
                        if(resultLen>0){
                            var codeTmp = "";
                            for(var ii=0;ii<resultLen;ii++){
                                var colspan = 1;
                                if(ii == resultLen-1 && (resultLen+1)%2!=0){
                                    colspan = 3;
                                }
                                if((ii+1)%2!=0){
                                    codeTmp += "<tr>";
                                }
                                codeTmp += "<td>"+fieldNameArr[ii]+"</td>";
                                codeTmp += "<td colspan='"+colspan+"'>";
                                if(fieldTypeArr[ii] == "13"){   // ���
																	if (fieldCodeArr[ii] == "10354") {
																		codeTmp += "<input type='text' id='F"+fieldCodeArr[ii]+"' name='F"+fieldCodeArr[ii]+"' maxlength='10' value='"+fieldDefValueArr[ii]+"' v_type='cfloat' v_maxlength='7.2' onblur='if(this.value!=\"\" && !forMoney(this)){return false;}'/>";
																	} else {
																		codeTmp += "<input type='text' id='F"+fieldCodeArr[ii]+"' name='F"+fieldCodeArr[ii]+"' maxlength='"+fieldLengthArr+"' value='"+fieldDefValueArr[ii]+"' onblur='if(this.value!=\"\" && !forMoney(this)){return false;}'/>";
																	}
                                }
                                if(ctrlInfoArr[ii] == "N"){
                                    codeTmp += "&nbsp;<font class='orange'>*</font>";
                                }
                                codeTmp += "</td>";
                                if((ii+1)%2==0){
                                    codeTmp += "</tr>";
                                }
                            }
                            $("#feeInfo").html(codeTmp);
                            $("#feeInfo").show();
                        }
                        
                        var vFeeList = $("#fee_list").val();
                        if(vFeeList != ""){
                            var vFeeCodeList = vFeeList.split("|")[0];
                            var vFeeValueList = vFeeList.split("|")[1];
                            var vFeeCodeArr = vFeeCodeList.split("~");
                            var vFeeValueArr = vFeeValueList.split("~");
                            
                            for(var tmp=0;tmp<vFeeCodeArr.length;tmp++){
                                if(vFeeCodeArr[tmp] != ""){
                                    $("#F"+vFeeCodeArr[tmp]).val(vFeeValueArr[tmp]);
                                }
                            }
                        }
                        /* end of add by qidp */
   						break;
   			case "12":
   					var SAFlag = packet.data.findValueByName("SAFlag");
   					if(SAFlag == "Y" ){
	      				$("#selSalesTr").show();
	 				 }else{
	      				$("#selSalesTr").hide();
	  				 }
	  				 break;
   			case "22":
                var PlanCount = packet.data.findValueByName("PlanCount");
                document.all.PlanCount_flag.value=PlanCount;
   			default:
   						
   }
}

function ConfirmCheck(){
    
  if(document.all.p_OperType.value=="1"){
	 	window.close();	
	 	return;
	 }
  if(document.all.p_OperType.value=="2"){
  	//yuanqs add 100825
	  if(!(document.all.OperationSubTypeIDRadio[8].checked)&&!(document.all.OperationSubTypeIDRadio[7].checked)&&!(document.all.OperationSubTypeIDRadio[5].checked)&&!(document.all.OperationSubTypeIDRadio[6].checked))
	  {
	  	rdShowMessageDialog("��ѡ��ҵ�������𣡣�������");
	  	return;
	  }
  }
  
  if(!checkElement(document.all.p_ProductOrderNumber)) return false;
  if(!checkElement(document.all.p_ProductSpecNumber)) return false;
   	
  var checkTmp =""
  
  /*
  ����
  */
  if(document.all.p_OperType.value=="0"){
  	checkTmp="1|";
  	if($("#p_ServiceLevelID").val().length>2)
  	{
  		rdShowMessageDialog("����ͨ�ȼ�ID���Ȳ��ܴ���2");
  		return ; 
  	}
	}
  	else if(document.all.p_OperType.value=="2"){
		if(document.all.OperationSubTypeIDRadio[5].checked)
			checkTmp="A|";
		if(document.all.OperationSubTypeIDRadio[6].checked)
			checkTmp="2|";
		if(checkTmp=="A|"){
			getAttached($("#p_ProductSpecNumber").val(),$("#p_POSpecNumber").val());
		}
		if(document.all.OperationSubTypeIDRadio[7].checked)//yuanqs 2010-8-24 14:45:04
			checkTmp="11|";
		if(document.all.OperationSubTypeIDRadio[8].checked)//yuanqs 2010-8-25
			checkTmp="12|";
	}
	else if(document.all.p_OperType.value=="3"){
	 	checkTmp="B|";
	}
	else 
	{ 	
		$("input[@name='OperationSubTypeIDChkBox']").each(function()
		{
			if($(this).attr("checked")){
				checkTmp=checkTmp+$(this).val()+"|"
		}
		});
		$("input[@name='OperationSubTypeIDRadio']").each(function()
		{
			if($(this).attr("checked")){        	 
				 checkTmp=checkTmp+$(this).val()+"|";
			}
		});
	}
   if(ProductOrder[31]=="1") checkTmp="1|";//addby lusc 09-4-30
	  if(checkTmp==""){
	  	rdShowMessageDialog("��ѡ���Ʒ��ҵ�����!"); 
	  	return; 	
	  }    
  if(document.all.p_OperType.value=="4"&&$("#product_OperType").val()=="A|"){
  	if(checkTmp=="A|"){
	 			getAttached($("#p_ProductSpecNumber").val(),$("#p_POSpecNumber").val());
	 	}
  	 /*�޸Ĳ�����ʱ�򲻿���Ԥ������Ʒ*/
		if(ProductOrder[27]=="zhu"){	  
	  	rdShowMessageDialog("�޸ĵ�ʱ�򲻿���Ԥ������Ʒ������");
	  	window.close();			
		}
  } 
  var vInputFlag = $("#input_flag").val();
  if(vInputFlag == "add" && $("#biz_display_flag").val() == "Y" && $("#biz_flag").val() != "Y"){
      rdShowMessageDialog("������ø��ѷ�ʽ��",0);
      $("#getBIZ").focus();
      return false;
  }
    /* add by qidp @ 2009-12-15 */
    if(vInputFlag == "add" && resultLen > 0){
        var fieldCodeList = "";
        var fieldValueList = "";
        for(var ii=0;ii<resultLen;ii++){
            if($("#F"+fieldCodeArr[ii]).val() == ""){
                if(ctrlInfoArr[ii] == "N"){
                    rdShowMessageDialog(fieldNameArr[ii]+"����Ϊ��!",0);
                    $("#F"+fieldCodeArr[ii]).focus();
                    return false;
                }
            }else{
                if(fieldTypeArr[ii] == "13"){ // ���
                    if(!forMoney(document.getElementById("F"+fieldCodeArr[ii]))){
                        return false;
                    }
                }else{
                    
                }
								if (fieldCodeArr[ii] == "10354") {
									if (!checkElement(document.getElementById("F"+fieldCodeArr[ii]))) {
										rdShowMessageDialog(fieldNameArr[ii]+"����Ϊ�����������������Ϊ7λ��С�����Ϊ2λ��", 0);
										return false;
									} else if (document.getElementById("F"+fieldCodeArr[ii]).value.substr(0, document.getElementById("F"+fieldCodeArr[ii]).value.indexOf(".")).length > 7) {
										rdShowMessageDialog(fieldNameArr[ii]+"����Ϊ�����������������Ϊ7λ��С�����Ϊ2λ��", 0);
										return false;
									}
								}
            }
            
            fieldCodeList += fieldCodeArr[ii] + "~";
            fieldValueList += $("#F"+fieldCodeArr[ii]).val() + "~";
        }
        $("#fee_list").val(fieldCodeList + "|" + fieldValueList +"|");
        /* fee_list ��ʽʾ��:" code1~code2~code3~|value1~value2~value3~| " */
    }
    /* end of add by qidp */
    
  //---------------------------------��������-------------------------------------------------//
  ProductOrder[0]  = $("#p_ProductOrderNumber").val();//0
  ProductOrder[1]  = $("#p_ProductID"         ).val()==null?"":$("#p_ProductID"         ).val();//1
  ProductOrder[2]  = $("#p_ProductSpecNumber" ).val();//2
  ProductOrder[3]  = $("#p_AccessNumber"      ).val();//3
  ProductOrder[4]  = $("#p_PriAccessNumber"   ).val();//4
  ProductOrder[5]  = $("#p_Linkman"           ).val();//5
  ProductOrder[6]  = $("#p_ContactPhone"      ).val();//6
  ProductOrder[7]  = $("#p_Description"       ).val();//7
  ProductOrder[8]  = $("#p_ServiceLevelID"    ).val();//8
  ProductOrder[9]  = $("#p_POOrderNumber"     ).val();//9
  ProductOrder[10] = $("#p_POSpecNumber"      ).val();//10
  ProductOrder[11] = checkTmp;                        //11
  var vSelSales = $("#selSales").val();
  //liujian 2012-8-27 10:12:43 ������
  /*
  if(vSelSales != ""){
     vSelSales = vSelSales + "|";
  }else{
     vSelSales = "";
  }
  */
  var bargain = $('#bargain').val();   
  if(!bargain) {
  	bargain = "";
  }
  if(vSelSales != ""){
     vSelSales = vSelSales + "|" + bargain + "|";
  }else{
     vSelSales = "|" + bargain + "|";
  }
  ProductOrder[12] = vSelSales;//12
  ProductOrder[20] = $("#p_AcceptID").val();          //20
  ProductOrder[21] = $("#p_BIZCODE").val();          //21
  ProductOrder[22] = $("#p_BillType").val();          //22
  //ProductOrder[29] = $("#p_OneTimeFee").val();          //29
  ProductOrder[29] = $("#fee_list").val();          //29
  //alert("�����ֵΪ"+$("#p_OneTimeFee").val());
  var PrdPatePlanListArray = new Array($(".ProductRatePlan_contenttr").size());//�б������ʼ��
  //�б����鸳ֵ
  $(".ProductRatePlan_contenttr").each(function(i)
  {
  	var PrdPatePlan = new Array(13);//�б�ÿ����������
  	PrdPatePlan[0]=$(this).attr("a_RatePlanID");
  	PrdPatePlan[1]=$(this).attr("a_Description");
  	PrdPatePlan[2]=$(this).attr("a_POOrderNumber");
  	PrdPatePlan[3]=$(this).attr("a_POSpecNumber");
  	PrdPatePlan[4]=$(this).attr("a_ProductOrderNumber");
  	PrdPatePlan[5]=$(this).attr("a_ProdcutOrderICBsCheckFlag");
  	PrdPatePlan[6]=$(this).data("a_ProdcutOrderICBsList");
  	PrdPatePlan[8]=$(this).attr("a_OperType");
  	PrdPatePlan[9]=$(this).attr("a_ProductSpecNumber");
  	PrdPatePlan[10]=$(this).attr("a_ParAcceptID");
  	PrdPatePlan[11]=$(this).attr("a_AcceptID");
  	PrdPatePlan[12]=$(this).data("a_ProductCodeICBsList");
    PrdPatePlanListArray[i]=PrdPatePlan;
    
  });
  ProductOrder[13] = PrdPatePlanListArray;//ѹ���б�����
  /*liujian 2012-6-26 13:33:01 ��ʡ������ҵ����� 
  	�������� ����
	��Ʒ����� 01011304
	��Ʒ��ҵ����� Ԥ����
	��Ʒ���ʷѱ������û���ʷ�
  */
    if(ProductOrder[10] == '01011304' && '<%=p_OperType%>' == '6' && '<%=idRadio%>' == '1') {
    	//����ʾѡ���Ʒ���ʷ�
    }
  //wangzn �������Ϸ� �Ĳ�Ʒ���ʷѱ������û���ʷ�
	else if("<%=busi_req_type%>" != "05" && ProductOrder[13].length==0&&document.all.PlanCount_flag.value!="0"&&!(checkTmp=='5|'&&'<%=p_OperType%>'=='6'))
	{
	  	rdShowMessageDialog("��ѡ���Ʒ���ʷ�!"); 
	  	return; 	
	 } 
  var PayCompanyListArray = new Array($(".ProductPayCompany_contenttr").size());//�б������ʼ��
  //�б����鸳ֵ
  $(".ProductPayCompany_contenttr").each(function(i)
  {
  	var PayCompany = new Array(9);//�б�ÿ����������
  	PayCompany[0]=$(this).attr("a_PayCompanyID");
  	PayCompany[1]=$(this).attr("a_PayCompanyName");
  	PayCompany[2]=$(this).attr("a_POOrderNumber");
  	PayCompany[3]=$(this).attr("a_POSpecNumber");
  	PayCompany[4]=$(this).attr("a_ProductOrderNumber");
  	PayCompany[5]=$(this).attr("a_OperType");
  	PayCompany[6]=$(this).attr("a_ProductSpecNumber");
  	PayCompany[7]=$(this).attr("a_ParAcceptID");
  	PayCompany[8]=$(this).attr("a_AcceptID");  	
    PayCompanyListArray[i]=PayCompany;
  });
  ProductOrder[14] = PayCompanyListArray;//ѹ���б�����

  var ProductOrderCharListArray = new Array($(".ProductOrderChar_contenttr").size());//�б������ʼ��
  //�б����鸳ֵ
  $(".ProductOrderChar_contenttr").each(function(i)
  {
  	var ProductOrderChar = new Array(11);//�б�ÿ����������
  	ProductOrderChar[0]=$(this).attr("a_ProductSpecCharacterNumber");
  	ProductOrderChar[1]=$(this).attr("a_Name");
  	ProductOrderChar[2]=$(this).attr("a_CharacterValue");
  	ProductOrderChar[3]=$(this).attr("a_POOrderNumber");
  	ProductOrderChar[4]=$(this).attr("a_POSpecNumber");
  	ProductOrderChar[5]=$(this).attr("a_ProductOrderNumber");
  	ProductOrderChar[6]=$(this).attr("a_OperType");
  	ProductOrderChar[7]=$(this).attr("a_ProductSpecNumber");
  	ProductOrderChar[8]=$(this).attr("a_ParAcceptID");
  	ProductOrderChar[9]=$(this).attr("a_AcceptID");
  	ProductOrderChar[10]=$(this).attr("a_POOrderseriNum");
  	ProductOrderChar[11]=$(this).attr("a_CharacterGroup");
  	//alert("a:"+ProductOrderChar[10]);
  	//alert("a:"+ProductOrderChar[1]);
    ProductOrderCharListArray[i]=ProductOrderChar;
    	/*alert("a:"+$(this).attr("a_ProductSpecCharacterNumber"));
	alert("a:"+$(this).attr("a_POOrderseriNum"));*/
  });
  ProductOrder[15] = ProductOrderCharListArray;//ѹ���б�����

  	if(ProductOrder[15].length==0)
	{	
		//liujian 2012-7-10 16:09:44 ������������Ʒ����ţ�01011304 �����Ʒ����Ϊ��
		if(ProductOrder[10] == '01011304' && '<%=p_OperType%>' == '6') {
			
		}else {
		  	rdShowMessageDialog("��ѡ���Ʒ����!"); 
		  	return; 
		}	
	 } 
	 //����ڵ�
	 
	 var ProductOrder_ManageCharacterArray = new Array($(".ProductOrder_ManageCharacter").size());
	 $(".ProductOrder_ManageCharacter").each(function(i)
  {
  	var ManageCharacter = new Array(7);
  	ManageCharacter[0] = "g";
  	ManageCharacter[1] = $("#p_ProductOrderNumber").val();
  	ManageCharacter[2] = $(this).attr("a_OperateCode");
  	ManageCharacter[3] = $(this).attr("a_CharacterID");
  	ManageCharacter[4] = $(this).attr("a_CharacterValue");
  	ManageCharacter[5] = $(this).attr("a_CharacterName");
  	ManageCharacter[6] = $(this).attr("a_CharacterDesc");
  	ProductOrder_ManageCharacterArray[i] = ManageCharacter;
  });
  ProductOrder[32] = ProductOrder_ManageCharacterArray;//�᲻��Խ�簡��
  
  if("8"=="<%=p_OperType%>"){
	  var ProductOrder_ExamineArray = new Array(1);
	  var ExamineArray = new Array(3);
	  ExamineArray[0] = "s";
	  ExamineArray[1] = $("#examine_content").val();
	  ExamineArray[2] = $("#examine_result").val();
	  ProductOrder_ManageCharacterArray[0] = ExamineArray;
	  ProductOrder[33] = ProductOrder_ManageCharacterArray;
  }
	 
	 
	 
	 
	//ɾ������
 var ProductOrderCharListArrayDel = new Array($("DIV.ProductOrderChara").size());//�б������ʼ��
  //�б����鸳ֵ
  	//alert($("DIV.ProductOrderChara").size());
  	//alert(document.all.d_ProductSpecCharacterNumber_ProOrdChara0.value);
  	
  $("DIV.ProductOrderChara").each(function(i)
  {
  	var ProductOrderChar = new Array(12);//�б�ÿ����������
  	ProductOrderChar[0]=document.getElementById("d_ProductSpecCharacterNumber_ProOrdChara"+i).value;
  	ProductOrderChar[1]=document.getElementById("d_Name_ProOrdChara"+i).value;
  	ProductOrderChar[2]=document.getElementById("d_CharacterValue_ProOrdChara"+i).value;
  	ProductOrderChar[3]=document.getElementById("d_POOrderNumber_ProOrdChara"+i).value;
  	ProductOrderChar[4]=document.getElementById("d_POSpecNumber_ProOrdChara"+i).value;
  	ProductOrderChar[5]=document.getElementById("d_ProductOrderNumber_ProOrdChara"+i).value;
  	ProductOrderChar[6]=$(this).attr("d_OperType");
  	ProductOrderChar[7]=document.getElementById("d_ProductSpecNumber_ProOrdChara"+i).value;
  	ProductOrderChar[8]=document.getElementById("d_ParAcceptID_ProOrdChara"+i).value;
  	ProductOrderChar[9]=document.getElementById("d_AcceptID_ProOrdChara"+i).value;
  	ProductOrderChar[10]=document.getElementById("d_POOrderSeriNum_ProOrdChara"+i).value;
  	ProductOrderChar[11]=document.getElementById("d_CharacterGroup"+i).value;
  	//alert(ProductOrderChar[11]);

  	//alert("d10:"+ProductOrderChar[10]);
  	//alert("d00:"+ProductOrderChar[0]);
    ProductOrderCharListArrayDel[i]=ProductOrderChar;
    
  });
  ProductOrder[30] = ProductOrderCharListArrayDel;//ѹ���б�����
  window.returnValue = "Y";
  queRen = 1;
  window.close();
}
//ҳ��װ��
$(document).ready(function (){
	
	  ProductOrder=window.dialogArguments;
	  //liujian 2012-7-11 15:39:36 ����ڵ�Բ�Ʒ��ҵ������б������⴦��
	  if('<%=p_OperType%>' == '6' && ProductOrder[11]=="9"){
		$("input[@name='OperationSubTypeIDChkBox']").each(function()
		{
			$(this).attr("disabled",true);
		});
		$("input[@name='OperationSubTypeIDRadio']").each(function()
		{
			$(this).attr("disabled",true);
		});
		$("input[@name='OperationSubTypeIDChkBox']").each(function()
		{
			if($(this).val()=="9"){
				$(this).attr("checked",true);
				doClickChkBox(this);
			}
  	    });
	  }
	  //wangzn 2010-4-17 11:41:41 ����ڵ�Բ�Ʒ��ҵ������б������⴦��
	  
	  if(ProductOrder[11]=="10"){
		$("input[@name='OperationSubTypeIDChkBox']").each(function()
		{
			$(this).attr("disabled",true);
		});
		$("input[@name='OperationSubTypeIDRadio']").each(function()
		{
			$(this).attr("disabled",true);
		});
		$("input[@name='OperationSubTypeIDChkBox']").each(function()
		{
			if($(this).val()=="10"){
				$(this).attr("checked",true);
				doClickChkBox(this);
			}
  	    });
	  }
	  else if(ProductOrder[11]=="1"){
		$("input[@name='OperationSubTypeIDChkBox']").each(function()
		{
			$(this).attr("disabled",true);
		});
		$("input[@name='OperationSubTypeIDRadio']").each(function()
		{
			$(this).attr("disabled",true);
		});
		$("input[@name='OperationSubTypeIDChkBox']").each(function()
		{
			if($(this).val()=="1"){
				$(this).attr("checked",true);
				doClickChkBox(this);
			}
		});
	  }
	  
	  
	  $("#p_ProductOrderNumber").val(ProductOrder[0]);
	  $("#p_ProductID"         ).val(ProductOrder[1]);
	  $("#p_ProductSpecNumber" ).val(ProductOrder[2]);
	  $("#p_AcceptID").val('<%=sysAccept%>');
	  $("#p_AccessNumber"      ).val(ProductOrder[3]);
	  $("#p_PriAccessNumber"   ).val(ProductOrder[4]);
	  $("#p_Linkman"           ).val(ProductOrder[5]);
	  $("#p_ContactPhone"      ).val(ProductOrder[6]);
	  $("#p_Description"       ).val(ProductOrder[7]);
	  $("#p_ServiceLevelID"    ).val(ProductOrder[8]);
	  $("#p_POOrderNumber"     ).val(ProductOrder[9]);
	  $("#p_POSpecNumber"      ).val(ProductOrder[10]);
	  $("#p_AcceptID"          ).val(ProductOrder[20]);
	  $("#p_ProductStatus").val(ProductOrder[21]);
	  $("#p_OperType").val(ProductOrder[22]);
	  $("#action_flag").val(ProductOrder[23]);
	  $("#p_BIZCODE").val(ProductOrder[24]);
	  $("#p_BillType").val(ProductOrder[25]);
	  $("#p_Operation").val(ProductOrder[26]);
	  
	 

	  //ע��ȷ��
    $('#confirm').click(function(){
  	   ConfirmCheck();
  	});
  	if($("#p_BIZCODE").val()=="")
	 			$("#BIZ").hide();
	 	$("#fee").hide();
	 	
	 	//alert(document.all.p_OperType.value);
	 	
  	//wuxy add
	 if(document.all.p_OperType.value=="1"){
	 	
	 	$("#div4_show").hide();	
	 	$("#getProductNumber").hide();
	 	$("#POOrderNumberQueryDiv").hide();
	 	document.all.p_ProductOrderNumber.readOnly=true;
	 	document.all.p_ProductID.readOnly=true;
	 	document.all.p_ProductSpecNumber.readOnly=true;
		document.all.p_AccessNumber.readOnly=true;
		document.all.p_PriAccessNumber.readOnly=true;
		document.all.p_Linkman.readOnly=true;
		document.all.p_ContactPhone.readOnly=true;
		document.all.p_Description.readOnly=true;
		document.all.p_ServiceLevelID.readOnly=true;
		document.all.p_ProductStatus.readOnly=true;
		document.all.p_BIZCODE.readOnly=true;
		document.all.p_BillType.readOnly=true;
	 }
	 
	 if(document.all.p_OperType.value=="0"){
	 	/*$("#p_OneTimeFee").val(ProductOrder[29]);*/ //modify by qidp @ 2009-12-15
	 	$("#fee_list").val(ProductOrder[29]);
	 	
	 	getOneTimeFeeStatus($("#p_ProductSpecNumber" ).val())
	 	$("#div4_show").hide();	
	 	$("#POOrderNumberQueryDiv").show();
	 	if($("#p_BIZCODE").val()=="")
	 			$("#BIZ").hide();
	 	
	 } 
	 if(document.all.p_OperType.value=="2")
	 {
	 	//wuxy alter 20090203 
	 	$("#div4_show").show();	
	 	$("#div4_1_show").hide();
	 	$("#div4_2_show").hide()
	 	$("#div5_show").show();	
	 	//alert(document.all.action_flag.value);
	 	//alert(document.all.p_ProductStatus.value);
	 	//add by rendi for ȷ����Ԥ������������ť
	 	if(document.all.p_ProductStatus.value=="����"){
	 		document.all.OperationSubTypeIDRadio[5].disabled=true;
	 		//document.all.OperationSubTypeIDRadio[5].checked=true;
	 		document.all.OperationSubTypeIDRadio[6].disabled=true;
	 	}
	 	if(document.all.p_ProductStatus.value=="ȡ��")
	 	{
	 		document.all.OperationSubTypeIDRadio[5].disabled=true;
	 		//document.all.OperationSubTypeIDRadio[6].checked=true;
	 		document.all.OperationSubTypeIDRadio[6].disabled=true;
	 	}
	 	if(document.all.action_flag.value=="1")
	 	{
			$("#POOrderNumberQueryDiv").hide();
			document.all.OperationSubTypeIDRadio[1].disabled=false;
			$("#getProductNumber").hide();
			document.all.p_AccessNumber.readOnly=true;
			document.all.p_PriAccessNumber.readOnly=true;
			document.all.p_Linkman.readOnly=true;
			document.all.p_ContactPhone.readOnly=true;
			document.all.p_Description.readOnly=true;
			document.all.p_ServiceLevelID.readOnly=true;
			document.all.p_ProductStatus.readOnly=true;
	    }
	    else
	    {
	    	$("#POOrderNumberQueryDiv").show();
	    	document.all.OperationSubTypeIDRadio[1].disabled=false;
	    	$("#getProductNumber").show();
	    	document.all.p_AccessNumber.readOnly=false;
	    	document.all.p_PriAccessNumber.readOnly=false;
	    	document.all.p_Linkman.readOnly=false;
	    	document.all.p_ContactPhone.readOnly=false;
	    	document.all.p_Description.readOnly=false;
	    	document.all.p_ServiceLevelID.readOnly=false;
	    	document.all.p_ProductStatus.readOnly=false;
	    }
	 }
	 if(document.all.p_OperType.value=="3"){
	 	
	 	$("#div4_show").hide();	
	 	$("#getProductNumber").hide();
	 	$("#POOrderNumberQueryDiv").hide();
	 	document.all.p_ProductOrderNumber.readOnly=true;
	 	document.all.p_ProductID.readOnly=true;
	 	document.all.p_ProductSpecNumber.readOnly=true;
		document.all.p_AccessNumber.readOnly=true;
		document.all.p_PriAccessNumber.readOnly=true;
		document.all.p_Linkman.readOnly=true;
		document.all.p_ContactPhone.readOnly=true;
		document.all.p_Description.readOnly=true;
		document.all.p_ServiceLevelID.readOnly=true;
		document.all.p_ProductStatus.readOnly=true;
		document.all.p_BIZCODE.readOnly=true;
		document.all.p_BillType.readOnly=true;
	 }
	 //////add by lusc 2009-4-10
	 if((document.all.p_OperType.value=="4")){

	 	$("#div5_show").hide();	
	 	var optionType=$("#p_Operation").val();
	 	var radios = document.getElementsByName("OperationSubTypeIDRadio");
	 	var chkBoxs = document.getElementsByName("OperationSubTypeIDChkBox");
	 	
		for(var i=0;i<radios.length;i++){
				radios[i].checked = false;
				radios[i].disabled = true;
		}
		
		
		for(var i=0;i<chkBoxs.length;i++){
				chkBoxs[i].checked = false;
				chkBoxs[i].disabled = true;
		}
		/*
		for(var i=0;i<radios.length;i++){
				if(optionType.match(radios[i].value)!=null)
					radios[i].checked=true;
		}
		for(var i=0;i<chkBoxs.length;i++){
				if(optionType.match(chkBoxs[i].value)!=null)
					chkBoxs[i].checked=true;
		}
		*/
		if(ProductOrder[31]!="1"){
			if(optionType == "3|"){
		 		for(var i=0;i<radios.length;i++){
					if(radios[i].value==3){
						radios[i].checked=true;
					}
				}
		 	}
		 	
		 	if(optionType.match("4")!=null){
		 		for(var i=0;i<radios.length;i++){
					if(radios[i].value==4){
						radios[i].checked=true;
					}
				}
		 	}
		 	
		 	if(optionType.match("9")!=null){
		 		for(var i=0;i<chkBoxs.length;i++){
					if(chkBoxs[i].value==9){
						chkBoxs[i].checked=true;
					}
				}
		 	} else if(optionType.match("13")!=null){	//2011/8/25 wanghfa���
		 		for(var i=0;i<chkBoxs.length;i++){
					if(chkBoxs[i].value==13){
						chkBoxs[i].checked=true;
					}
				}
		 	}
		 	//wuxy add 20100330
		 	if(optionType.match("5")!=null){
		 		for(var i=0;i<chkBoxs.length;i++){
					if(chkBoxs[i].value==5){
						chkBoxs[i].checked=true;
					}
				}
		 	}
		 	
		 	
		 	//wuxy alter 20090710 Ҫ���޸���Ʒ��ɹ�ϵ��ֻ������������ȡ��������Ʒ��
		 	if(optionType.match("7")!=null){
		 		//for(var i=0;i<radios.length;i++){
					radios[0].disabled = false;
				//}
				//for(var i=0;i<chkBoxs.length;i++){
				//	chkBoxs[i].disabled = false;
				//}			
		 	}
		}
		else{
			$("#div4_show").hide();
		}
	 
	 	
	 	
	 	
	}
	
	var vSpecNumber = ProductOrder[2];
    if(vSpecNumber != ""){
        var packet = new AJAXPacket("f2029_getPlanCountFlag.jsp","���Ժ�......");
        packet.data.add("productSpecNumber",vSpecNumber);
        packet.data.add("retFlag","22");
        core.ajax.sendPacket(packet,doProcess,true);
        packet =null;
    }
    //wangzn 2010-5-5 16:05:34  
    if(''!='<%=in_ChanceId%>'){
      
      if('02'=='<%=busi_req_type%>'){
      	if('6'==$("#p_OperType").val()){
			$("input[@name='OperationSubTypeIDChkBox']").each(function()
			{
				$(this).attr("disabled",true);
			});
			$("input[@name='OperationSubTypeIDRadio']").each(function()
			{
				$(this).attr("disabled",true);
			});
			$("input[@name='OperationSubTypeIDChkBox']").each(function()
			{
				if($(this).val()=="9"){
					$(this).attr("checked",true);
					doClickChkBox(this);
				}else{
					$(this).attr("checked",false);
				}
			});
      	}
      }
      /*liujian 2012-8-22 19:10:35 7453�������������ǹ�����busi_req_type=06������Ϊ�޸Ĳ�Ʒ�ʷ� begin */
      if('06'=='<%=busi_req_type%>') {
      	if('6'==$("#p_OperType").val()){
			$("input[@name='OperationSubTypeIDChkBox']").each(function()
			{
				$(this).attr("disabled",true);
			});
			$("input[@name='OperationSubTypeIDRadio']").each(function()
			{
				$(this).attr("disabled",true);
			});
			$("input[@name='OperationSubTypeIDChkBox']").each(function()
			{
				if($(this).val()=="5"){
					$(this).attr("checked",true);
					doClickChkBox(this);
				}else{
					$(this).attr("checked",false);
				}
			});
      	}
      }
      /*liujian 2012-8-22 19:10:35 7453�������������ǹ�����busi_req_type=06������Ϊ�޸Ĳ�Ʒ�ʷ� end */
      if(''!=$("#p_OperType").val()){
          
         if(''!='<%=in_productspec_number%>'){
         	    $("#p_ProductSpecNumber").val('<%=in_productspec_number%>');
         	    $("#p_AcceptID").val('<%=sysAccept%>');
         	    $("#getProductNumber").hide();
         	    $("#POOrderNumberQueryDiv").hide();
         	    
         }
         if('5'==$("#p_OperType").val()){
         	     $("#POOrderNumberQueryDiv").click();
  	           $("input[@name='OperationSubTypeIDChkBox']").each(function()
 	             {
               	$(this).attr("disabled",true);
  	           });
  	           $("input[@name='OperationSubTypeIDRadio']").each(function()
               {
                $(this).attr("disabled",true);
               });
               $("input[@name='OperationSubTypeIDChkBox']").each(function()
 	             {
               	if($(this).val()=="10"){
               		 $(this).attr("checked",true);
               	   doClickChkBox(this);
               	}else{
               		 $(this).attr("checked",false);
               	}
  	           });     	
         }
         else if('7'==$("#p_OperType").val()){
         	     //$("#POOrderNumberQueryDiv").click();
  	           $("input[@name='OperationSubTypeIDChkBox']").each(function()
 	             {
               	$(this).attr("disabled",true);
  	           });
  	           $("input[@name='OperationSubTypeIDRadio']").each(function()
               {
                $(this).attr("disabled",true);
               });
               $("input[@name='OperationSubTypeIDChkBox']").each(function()
 	             {
               	if($(this).val()=="1"){
               		 $(this).attr("checked",true);
               	   doClickChkBox(this);
               	}
  	           });     	
         }
      } 
      
		if('01'=='<%=busi_req_type%>'){
		
			$("input[@name='OperationSubTypeIDChkBox']").each(function()
			{
				$(this).attr("disabled",true);
			});
			$("input[@name='OperationSubTypeIDRadio']").each(function()
			{
				$(this).attr("disabled",true);
			});
			$("input[@name='OperationSubTypeIDChkBox']").each(function()
			{
				if($(this).val()=="1"){
					$(this).attr("checked",true);
					doClickChkBox(this);
				}else{
					$(this).attr("checked",false);
				}
			});
			
			//wangan add 2011/6/23 21:49:52
			//ר�߿�ͨ����ʾԤ����ʱ���һ���Է���
			getOneTimeFeeStatus($('#p_ProductSpecNumber').val());
			
			<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
		 			<wtc:sql>SELECT fee_code_list,fee_value_list FROM dautoproddeal WHERE product_order_id= '<%=sProductOrderNumber%>'  AND deal_flag = '0' </wtc:sql>
			</wtc:pubselect>
			<wtc:array id="resultOneTmFee2" scope="end"/>
			<%
			if(resultOneTmFee2.length>0)
			{
				String[] vFeeCodes = resultOneTmFee2[0][0].split("~");
				String[] vFeeVals = resultOneTmFee2[0][1].split("~");
				for(int f_idx = 0;f_idx<vFeeCodes.length;f_idx++){					
			%>
					$('#F<%=vFeeCodes[f_idx]%>').val('<%=vFeeVals[f_idx]%>');
					$('#F<%=vFeeCodes[f_idx]%>').attr('readOnly',true);
			<%
				}
			}else{
				
			}%>
		
		} 
		if('05'=='<%=busi_req_type%>'){
		
			$("input[@name='OperationSubTypeIDChkBox']").each(function()
			{
				$(this).attr("disabled",true);
			});
			$("input[@name='OperationSubTypeIDRadio']").each(function()
			{
				$(this).attr("disabled",true);
			});
			$("input[@name='OperationSubTypeIDChkBox']").each(function()
			{
				if($(this).val()=="10"){
					$(this).attr("checked",true);
				doClickChkBox(this);
				}else{
					$(this).attr("checked",false);
				}
			});
			//wangzn add 2011/6/22 10:35:08
			getOneTimeFeeStatus($('#p_ProductSpecNumber').val());
			//wangzn 2011/6/23 21:13:38 add
			//���ΪԤ����Ĺ����ģ���dAutoProdDeal�����һ���Է�����Ϣȡ������Ϊҳ�渳ֵ�Ҳ��ɸ���
			if('6'==$("#p_OperType").val()){
				<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
		 			<wtc:sql>SELECT fee_code_list,fee_value_list FROM dautoproddeal WHERE product_order_id= '<%=sProductOrderNumber%>'  AND deal_flag = '0' </wtc:sql>
				</wtc:pubselect>
				<wtc:array id="resultOneTmFee" scope="end"/>
				<%
				if(resultOneTmFee.length>0)
				{
					String[] vFeeCodes = resultOneTmFee[0][0].split("~");
					String[] vFeeVals = resultOneTmFee[0][1].split("~");
					for(int f_idx = 0;f_idx<vFeeCodes.length;f_idx++){					
				%>
						$('#F<%=vFeeCodes[f_idx]%>').val('<%=vFeeVals[f_idx]%>');
						$('#F<%=vFeeCodes[f_idx]%>').attr('readOnly',true);
				<%
					}
				}else{
					
				}%>
				
			}
		}
    }
    
    
    
    if("8"==$("#p_OperType").val()){
    
    	$("#POOrderNumberQueryDiv").hide();
    	$("#getProductNumber").hide();
    
		$("input[@name='OperationSubTypeIDChkBox']").each(function()
 	    {
          	$(this).attr("disabled",true);
  	    });
  	    $("input[@name='OperationSubTypeIDRadio']").each(function()
        {
           $(this).attr("disabled",true);
        });
        
  	    $("input[@name='OperationSubTypeIDRadio']").each(function()
 	    {
 	    	//alert($(this).val()+'---'+ProductOrder[11]);
          	if($(this).val()==ProductOrder[11]){
          		 $(this).attr("checked",true);
          	     doClickRadio(this);
          	}else{
          		 $(this).attr("checked",false);
          	}
  	    });
  	    $("input[@name='OperationSubTypeIDChkBox']").each(function()
 	    {
 	    	//alert($(this).val()+'---'+ProductOrder[11]);
          	if($(this).val()==ProductOrder[11]){
          		 $(this).attr("checked",true);
          	     doClickChkBox(this);
          	}else{
          		 $(this).attr("checked",false);
          	}
  	    });
    }
});



function getProductNumber(){
	
	
	  var pageTitle = "";
    var fieldName = "��Ʒ�����|��ˮ|";
    var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|2|";

    var retToField = "p_ProductSpecNumber|p_AcceptID|";

    var path = "<%=request.getContextPath()%>/npage/s2002/f2029_getProduct_list.jsp?";
    path = path + "&fieldName="+fieldName;
    path = path + "&selType="+selType;
    path = path + "&retQuence="+retQuence;
    path = path + "&retToField="+retToField;
    path = path + "&sPOSpecNumber=" +$("#p_POSpecNumber").val();  
    path = path + "&sp_OperType="+$("#p_OperType").val();       //wuxy add 
    path = path + "&sp_ProductSpecNumber="+$("#p_ProductSpecNumber").val();
    path = path + "&workNo=<%=workNo%>";
    path = path + "&orgCode=<%=orgCode%>";
    retInfo = window.open(path,
                          "",
                          "height=400, width=700,top=300,left=350,scrollbars=yes, resizable=no,location=no, status=yes");
    
    return true;
}
function getOneTimeFeeStatus(product_id){
	var packet = new AJAXPacket("f2029_getOneTimeFeeStatus.jsp","���Ժ�......");
 	packet.data.add("producrOrderId",product_id);
  core.ajax.sendPacket(packet);
	packet =null;	
	
}

function getSAStatus(product_id){	
	
	var packet = new AJAXPacket("f2029_getSAStatus.jsp","���Ժ�......");
 	packet.data.add("producrOrderId",product_id); 	
  core.ajax.sendPacket(packet);  
	packet =null;	
	
}

function getProductNumberRtn(retInfo)
{
	
    var retToField = "p_ProductSpecNumber|p_AcceptID|";
    
    if (retInfo == undefined)
    {
        return false;
    }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while (chPos_field > -1)
    {
        obj = retToField.substring(0, chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0, chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
    }
	
    productBiz($("#p_ProductSpecNumber").val(),$("#p_POSpecNumber").val());
   
    $("div.itemContent").slideUp(30);
	$("img.closeEl").attr({ src: "../../../nresources/default/images/jia.gif"});
	//yanpx 20151126 ����޸�  ��ѯ���Ʒ����ź�����ˢ�±�־��
	_jspPage.div0_switch[2]='f';
	
	
}

/**�����ѡ���ʱ����õĺ���**/
function doClickChkBox(chkbox){
	var radios = document.getElementsByName("OperationSubTypeIDRadio");
	
	for(var i=0;i<radios.length;i++){
		if(radios[i].checked){
			radios[i].checked = false;
		}	
	}
	
	/*8  add by lusc   ///ended by //////////////*/
	var chkBoxs = document.getElementsByName("OperationSubTypeIDChkBox");
	$("#buttontr1").hide();	
	$("#buttontr2").hide();
	$("#buttontr3").hide();
	$("#product_OperType").val("");	
	for(var i=0;i<chkBoxs.length;i++){
		if(chkBoxs[i].checked){
			  $("#product_OperType").val($("#product_OperType").val()+chkBoxs[i].value+"|");//modify 2009-04-09
				if(chkBoxs[i].value=="5"){
					$("#buttontr1").show();	
				}
				if(chkBoxs[i].value=="9"||chkBoxs[i].value=="10"){
					$("#buttontr3").show();	
				}
			}	
	}
	////////////////////////////////////////
}

/**�����ѡ���ʱ����õĺ���**/
function doClickRadio(radio)
{
	var chkBoxs = document.getElementsByName("OperationSubTypeIDChkBox");
	
	//�������е�checkbox,��ѡȡ���һ��radio��ʱ��,ȡ��ѡ�����е�checkbox
	for(var i=0;i<chkBoxs.length;i++){
		if(chkBoxs[i].checked){
			chkBoxs[i].checked = false;
		}	
	}
	$("#product_OperType").val("");	
	var radios = document.getElementsByName("OperationSubTypeIDRadio");
	
	for(var i=0;i<radios.length;i++){
		if(radios[i].checked){
			$("#product_OperType").val(radios[i].value+"|");
		}	
	}
	
}
function productBiz(s1,s2)
{
	
	//�õ���ѡ��Ʒ������Ʒ����Ӧ��Ʒ�ƴ���
	var packet = new AJAXPacket("f2029_productBiz.jsp","���Ժ�......");
 	packet.data.add("ProductSpecNumber",s1);
 	packet.data.add("POSpecNumber",s2);
    core.ajax.sendPacket(packet,doProcess,true);
	packet =null;	
    
    
}
function getBIZ()
{
	if($("#p_BIZCODE").val()==""){
  		rdShowMessageDialog("����дҵ�����!"); 
  		return; 	
	}
	
	//�õ����ѷ�ʽ
	var packet = new AJAXPacket("f2029_getBIZ.jsp","���Ժ�......");
 	packet.data.add("bizCode",$("#p_BIZCODE").val());
    core.ajax.sendPacket(packet);
	packet =null;	
}

/*this function is add by lusc to query the main product 
and it's attached product 2009-4-13   */

function getAttached(num1,num2){
	//����Ʒ����ź���Ʒ��� ������һ��ҳ��  ��ѯ��Ʒ��������Ʒ
	var packet = new AJAXPacket("f2029_getProductAttached.jsp","���Ժ�......");
 	packet.data.add("ProductSpecNumber",num1);
 	packet.data.add("POSpecNumber",num2);
  core.ajax.sendPacket(packet);
	packet =null;	
}

function showConsult(obj){
	ProductOrder=window.dialogArguments;
	var openobj = ProductOrder[33];

	openobj.open("<%=request.getContextPath()%>/npage/s2002/f2029_showConsultPage.jsp?dataConsult="+dataConsult,"","toolbar = 0");
	//var dataConsult=obj.toString();
	//window.open("<%=request.getContextPath()%>/npage/s2002/f2029_showConsultPage.jsp?dataConsult="+dataConsult,"","toolbar = 0");
}

function selManaCharVal(obj){
var val = obj.options[obj.selectedIndex].value;
document.getElementById(obj.name.substring(3)).value=val;
}

function setManaCharVal(obj){
var parentTr = $(obj).parent().parent();
$(parentTr).attr("a_CharacterValue",$(obj).val());
//alert($(parentTr).attr("a_CharacterValue"));
}
window.onbeforeunload = function(){       
      
}
window.onunload=function(){  
      if(queRen==0){
         return false;
      }     
}
window.attachEvent('onunload',function(){
      
});
</script>
</BODY>
</HTML>
