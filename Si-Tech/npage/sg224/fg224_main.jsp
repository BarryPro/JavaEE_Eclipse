<%
    /*************************************
    * ��  ��: ���ų�Ա�첽�ӿڽ���״̬��ѯ g224
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-10-17
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
		String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
%>  

<HTML> 
<HEAD>
    <TITLE>���Ų�Ʒ�첽�ӿڽ���״̬��ѯ</TITLE>
</HEAD>
<body>
<SCRIPT language="JavaScript">
  
  var cuPageNum = 1; //��ǰҳ��
	var pageRNum = 10; //ÿҳ��ʾ��¼��
	var beginNum = 1;  //��ʼ��¼��
	var endNum = 10;   //������¼��
	var sumNum = 10;   //�ܼ�¼�� ��ʼ��Ϊ20
	var sumPageNum = 1;//��ҳ��
	
  $(document).ready(function(){
  		$('#memberListDiv').css("display","none");
	}); 	
  
  //���ù������棬���м��ſͻ�ѡ��
function getInfo_Cust()
{
    var pageTitle = "���ſͻ�ѡ��";
    var fieldName = "֤������|�ͻ�ID|�ͻ�����|�û�ID|�û���� |�û�����|��Ʒ����|��Ʒ����|����ID|�����ʻ�|Ʒ������|Ʒ�ƴ���|APN���|";
	  var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "13|0|1|2|3|4|5|6|7|8|9|10|11|12|";
    var retToField = "iccid|cust_id|cust_name|grp_id|user_no|grp_name|product_code|product_name|unit_id|account_id|sm_name|sm_code|apn_no|";
    var cust_id = document.frm.cust_id.value;
    if(document.frm.iccid.value == "" &&
       document.frm.cust_id.value == "" &&
       document.frm.unit_id.value == "" &&
       document.frm.user_no.value == "")
    {
        rdShowMessageDialog("������֤�����롢���ſͻ�ID�����ű�Ż����û���Ž��в�ѯ��",0);
        document.frm.iccid.focus();
        return false;
    }

    if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("���������֣�",0);
    	return false;
    }

    if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
        rdShowMessageDialog("���������֣�",0);
    	return false;
    }

    if(document.frm.user_no.value == "0")
    {
    	frm.user_no.value = "";
        rdShowMessageDialog("�����û���Ų���Ϊ0��",0);
    	return false;
    }

    PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "fpubgrpusr_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
    path = path + "&cust_id=" + document.all.cust_id.value;
    path = path + "&unit_id=" + document.all.unit_id.value;
    path = path + "&user_no=" + document.all.user_no.value;
    path = path + "&op_code=" + document.all.op_code.value;
    path = path + "&opCode=" + document.all.opCode.value;
    path = path + "&opName=" + document.all.opName.value;

    retInfo = window.open(path,"newwindow","height=550, width=1000,top=0,left=0,scrollbars=yes, resizable=no,location=no, status=yes");
	  return true;
}

function getvaluecust(retInfo)
{
  var retToField = "iccid|cust_id|cust_name|grp_id|user_no|grp_name|product_code|product_name|unit_id|account_id|sm_name|";
  if(retInfo ==undefined)      
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
        //alert(obj+"="+valueStr);
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
   

}
    
    function getMemberList(opType){
  		if(opType=='0'){
  			$("#opNote").val("��ѯ"+$("#GRPID").val()+$("#GRPNAME").val()+"��Ա�б�");
  		}
  		$('#memberListDiv').css("display","none");
   		var memberList_Packet = new AJAXPacket("fg224_ajax_queryInfo.jsp","��ѯ��Ա�б����Ժ�......");
   		memberList_Packet.data.add("opCode","<%=opCode%>");
   		memberList_Packet.data.add("grp_id",$("#grp_id").val());
   		memberList_Packet.data.add("beginNum",beginNum);
   		memberList_Packet.data.add("endNum",endNum);
  		core.ajax.sendPacket(memberList_Packet,doGetMemberList,false);
  		memberList_Packet=null;	
  	}
  	
  	function doGetMemberList(packet){
  		var returnCode = packet.data.findValueByName("returnCode"); 
  		var returnMessage = packet.data.findValueByName("returnMessage"); 
  		var resultArray = packet.data.findValueByName("resultArray");
  		var resultCnt = packet.data.findValueByName("resultCnt");
  		if(returnCode=="000000"){
  			$("#memberList tr:gt(0)").remove();
  			if(resultArray.length>0){				
  				sumNum = resultCnt;
  				sumPageNum = sumNum/pageRNum;
  				if((sumPageNum+"").indexOf(".")!=-1){
  					sumPageNum = (sumPageNum+"").substring(0,(sumPageNum+"").indexOf("."));
  					sumPageNum = parseInt(sumPageNum)+1;
  				}
  			}else if(resultArray.length==0){
  				sumPageNum = 1;
  				cuPageNum = 1;
  			}
  			setShowPage(sumPageNum,cuPageNum);
  			$('#memberListDiv').css("display","");
  			for(var i=0;i<resultArray.length;i++){
  			    //alert(resultArray[i][5]);
  			    //alert(resultArray[i][6]);
  			    //alert(resultArray[i][7]);
  			    //alert(resultArray[i][8]);
  				trObj ="<tr>"+
  				 //"<td>"+i+"</td>"+
  				 "<td>"+resultArray[i][0]+"</td>"+
  				 "<td>"+resultArray[i][3]+"</td>"+
  				 "<td>"+resultArray[i][4]+"</td>"+
  				 "<td>"+resultArray[i][1]+"</td>"+
  				 "<td>"+resultArray[i][2]+"</td>"+
  		     "<td>"+resultArray[i][5]+"</td>"+   
  		     "<td>"+resultArray[i][6]+"</td>"+
  			 "</tr>";
  				$("#memberList").append(trObj);			 
  			}
  		}else{
  			rdShowMessageDialog("��ѯ����["+returnCode+"��"+returnMessage+"]");
  		} 
  	}
  	
  	function changePage(pFlag){
    	//alert("��ǰҳ��|"+cuPageNum+"\nÿҳ��ʾ��¼��|"+pageRNum+"\n��ʼ��¼��|"+beginNum+"\n������¼��"+endNum+"\n�ܼ�¼��"+sumNum+"\n��ҳ��"+sumPageNum);
  	  if(pFlag=="S"){  																			//�����ҳ
  			beginNum = 1;   
  			endNum = pageRNum;     
  			cuPageNum = 1;                             
  		}else	if(pFlag=="E"){                                 //���βҳ
  			beginNum = (sumPageNum-1)*pageRNum+1;
  			endNum = sumNum;
  			cuPageNum = sumPageNum;
  		}else if(pFlag=="P"){                                 //��һҳ
  			if(beginNum-pageRNum<=1){
  				changePage("S");	//��һҳΪ��ҳ
  			}else{
  				beginNum = beginNum - pageRNum+1;
  				if(beginNum==0) beginNum = 1;
  				endNum = beginNum + pageRNum;	
  				cuPageNum = cuPageNum-1;
  			}	
  		}else if(pFlag=="N"){																	//��һҳ
  			if(endNum+pageRNum>sumNum){
  				changePage("E");	//��һҳΪβҳ	
  			}else{
  				endNum = endNum + pageRNum;
  				beginNum = endNum - pageRNum+1; 
  				if(beginNum==0) beginNum = 1;
  				cuPageNum = cuPageNum+1;
  			}
  		}	
  		//alert("beginNum|"+beginNum+"\n"+"endNum|"+endNum);
  		getMemberList('1');
  		setShowPage(sumPageNum,cuPageNum);
  	}
  	
  	function gotoPage(page){
  		if(!checkElement(document.all.gotoPageNum)) return false;
  		cuPageNum = $('#gotoPageNum').val();
  		beginNum = (cuPageNum-1)*pageRNum + 1;
  		endNum = beginNum + pageRNum-1;
  		//alert("beginNum="+beginNum);
  		//alert("endNum="+endNum);
  		getMemberList('1');
  	}
    
    function setShowPage(num1,num2){
  		$("#sumPageSpan").text(num1);
  		$("#cuPageSpan").text(num2);
  		$("#gotoPageNum").attr("v_maxvalue",num1);
  	}
 
</SCRIPT>
<form name="frm" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
         	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
         	<input type="hidden" name="op_code"  value="<%=opCode%>">
         	<input type="hidden" id="cust_name" name="cust_name"  value="" />
         	<input type="hidden" id="grp_id" name="grp_id"  value="" />
         	<input type="hidden" id="grp_name" name="grp_name"  value="" />
         	<input type="hidden" id="product_code" name="product_code"  value="" />
         	<input type="hidden" id="product_name" name="product_name"  value="" />
         	<input type="hidden" id="account_id" name="account_id"  value="" />
         	<input type="hidden" id="sm_name" name="sm_name"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
		        <div id="title_zi">��ѯ����</div>
	        </div>
            <table cellspacing="0">
            	<TR>
           <TD class="blue">
              <div align="left">֤������</div>
            </TD>
            <TD>
                <input name=iccid  id="iccid" maxlength="18" v_type="string" v_must=1 v_name="֤������" index="1">
                <input name=custQuery type=button id="custQuery" class="b_text"  onClick="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursorhand" value=��ѯ>
                <font class="orange">*</font>
            </TD>
            <TD class="blue">���ſͻ�ID</TD>
            <TD>
              <input  type="text" name="cust_id" size="20" maxlength="18" v_type="0_9" v_must=1 v_name="�ͻ�ID" index="2">
              <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class="blue">
               <div align="left">���ű��</div>
            </TD>
            <TD>
		    <input name=unit_id  id="unit_id"  maxlength="10" v_type="0_9" v_must=1 v_name="���ű��" index="3">
            <font class="orange">*</font>
            </TD>
            <TD class="blue">�����û����</TD>
            <TD>
              <input  name="user_no" id="user_no" size="20" v_must=1 v_type=string v_name="���Ų�Ʒ���" index="4">
              <font class="orange">*</font>
            </TD>
          </TR>
            	 <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="queryBtn" name="queryBtn" class="b_foot" value="��ѯ" onClick="getMemberList('0')" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="�ر�" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
            <div id="memberListDiv" >
        			<table>
        				<div  style="font-size:12px" align="center">
        					<a href="#" onClick="changePage('S')"> ��ҳ </a>
        					<a href="#" onClick="changePage('P')"> ��һҳ </a>
        					<a href="#" onClick="changePage('N')"> ��һҳ </a>
        					<a href="#" onClick="changePage('E')"> βҳ </a>
        					&nbsp;&nbsp;��<span id="sumPageSpan"></span>ҳ&nbsp;&nbsp;&nbsp;
        					&nbsp;&nbsp;&nbsp;��ǰ��<span id="cuPageSpan"></span>ҳ&nbsp;&nbsp;&nbsp;
        					&nbsp;&nbsp;&nbsp;
        					<input name="gotoPageBtn" type="button"  id="gotoPageBtn" onClick="gotoPage();" class="b_text" value="GOTO">
        					<input name="gotoPageNum" type="text"  id="gotoPageNum"  v_must=1 v_type=0_9 v_minvalue=1  size="6"/> 
        				</div>
        			</table>
        			<table cellspacing=0 id="memberList">
      				<tr>
      					<th>�ֻ���</th>
      					<th>״̬</th>
      					<th>��������</th>
      					<th>����ʱ��</th>
      					<th>�������ʱ��</th>
                <th>���ش���</th>
                <th>������Ϣ</th>
      				<tr>
      			</table>
            <table>
              <tr> 
                <td colspan="4" id="footer"> <div align="center"> &nbsp; </td>
              </tr>
            </table>
        	</div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
</BODY>
</HTML>

