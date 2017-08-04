<%
/********************
 * version v2.0
 * ������: si-tech
 * author: huangrong
 * date  : 20101103
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
%>

<%
//******************�õ�����������***************************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);

  //С����Ʒ
 	String subTypeName = " select c.subtype from (select a.subtype subtype  from dbcustadm.TOBMARKCHANGEMSG a,SITEMLOSTCFG b where a.itemid = trim(b.itemid(+)) and  b.itemid is null) c group by c.subtype";

  //������Ʒ
  String itemidType = "select a.itemid,a.itemname,a.subtype  from dbcustadm.TOBMARKCHANGEMSG a,SITEMLOSTCFG b where a.itemid = trim(b.itemid(+)) and  b.itemid is null";
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=subTypeName%></wtc:sql>
</wtc:pubselect>
<wtc:array id="subTypeNameStr" scope="end"/>

<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=itemidType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="itemidTypeStr" scope="end"/>



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���Ż��ֶһ�</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
	var itemidType = new Array();
	var itemidName = new Array();
	var subTypeName = new Array();
	<%
  for(int i=0;i<itemidTypeStr.length;i++)
  {
	out.println("itemidType["+i+"]='"+itemidTypeStr[i][0]+"';\n");
	out.println("itemidName["+i+"]='"+itemidTypeStr[i][1]+"';\n");
	out.println("subTypeName["+i+"]='"+itemidTypeStr[i][2]+"';\n");
  }
  %>
	
/****************����subTypeName��̬����itemidType������************************/
 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values

   myEle = document.createElement("option") ;
   myEle.value = "";
   myEle.text ="--��ѡ��--";
   controlToPopulate.add(myEle) ;
   for ( x = 0 ; x < ItemArray.length  ; x++ )
   {
      if ( GroupArray[x] == control.value )
      {
        myEle = document.createElement("option") ;
        myEle.value = itemidType[x];
        myEle.text = ItemArray[x] ;
        controlToPopulate.add(myEle) ;
        document.all.type_code.value=itemidType[x];
      }
   }
 }
/****************��֤���ύ����************************/ 
function printCommit()
{
		getAfterPrompt();
		with(document.frm){
		if(subtype.value==""){
		  rdShowMessageDialog("��ѡ��С����Ʒ!",1);
	      subtype.focus();
		  return false;
		}
	submit();
  return true;
	}
}
</script>
</head>
<body>
<form name="frm" action="fb881_2.jsp" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">����������Ʒ����</div>
</div>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
    <table cellspacing="0">
     
      <tr>
            <td class="blue">С����Ʒ����</td>
            <td>
								<select id="subtype" name="subtype" v_must=1  onchange="selectChange(this, itemid_type, itemidName, subTypeName);" v_name="�ֻ�������">
						     	<option value ="">--��ѡ��--</option>
			            <%for(int i = 0 ; i < subTypeNameStr.length ; i ++){%>
			            <option value="<%=subTypeNameStr[i][0]%>"><%=subTypeNameStr[i][0]%></option>
			            <%}%>			              
								</select>
			                <font class="orange">*</font>
						  </td>
						  <td class="blue">������Ʒ����</td>
            	<td>
									<select size=1 name="itemid_type" id="itemid_type" v_must=1 v_name="�ֻ��ͺ�">
										<option value ="">--��ѡ��--</option>
								    			<input type="hidden" name="type_code" id="type_code" >
									</select>
						  </td>
			</tr>
      
      
      <tr>
        <td colspan="6" id="footer">
          <div align="center">
          <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="printCommit()" index="2">
          <input class="b_foot" type=button name=back value="���" onClick="frm.reset();">
    			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
          </div>
        </td>
      </tr>
    </table>
<!------------------------>
<input type="hidden" name="printAccept" value="<%=printAccept%>">  
<input type="hidden" name="opcode" value="<%=opCode%>">  
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
