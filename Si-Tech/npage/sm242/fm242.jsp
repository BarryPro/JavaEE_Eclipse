 <%
	/********************
	 version v2.0
	������: si-tech
	update:2015/2/13 ������ ���� 1:55:12 ningtn
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode=request.getParameter("opCode");	
		String opName=request.getParameter("opName");

	String workno = (String)session.getAttribute("workNo");
	String regioncode=(String)session.getAttribute("regCode");
	String noPass = (String)session.getAttribute("password");
	String orgcode = (String)session.getAttribute("orgCode");
  String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  String regionCode= (String)session.getAttribute("regCode");


%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regioncode%>"  id="sysAccept" />
	
<HEAD>
		<TITLE><%=opName%></TITLE>
		<script language="JavaScript">
			$(document).ready(function(){
				
				
				
				//�ύ����
				$("#quchoose").click(function(){
					if(!checkForm()){
						return false;
					}
					
					//У��
					var phoneNo = $.trim($("#phone").val());
					var cardNo = $.trim($("#oldCardId").val());
	        var packet = new AJAXPacket("../sm241/fm241Check.jsp","���ڻ�����ݣ����Ժ�......");
	      	packet.data.add("cardNo",cardNo);
	      	packet.data.add("phoneNo",phoneNo);
	      	packet.data.add("opCode","m241");
	      	packet.data.add("opName","�мۿ��Ǽ�");
	      	
	      	core.ajax.sendPacket(packet,dogetOfferInfo);
	      	packet = null;   
					
					
					if($("#oldCardStatys").val() == "0"){
						return false;
					}
					
					//��ѯ����
					var selectSql = "select  card_money  from dchncardres  where card_no = :iOld_Card_no";
					var params = "iOld_Card_no=" + $("#oldCardId").val();
					var getUnitId_Packet = new AJAXPacket("/npage/public/pubSelectBySql.jsp","����У�����Ժ�......");
					getUnitId_Packet.data.add("selectSql",selectSql);
					getUnitId_Packet.data.add("params",params);
					getUnitId_Packet.data.add("wtcOutNum","1");
					core.ajax.sendPacket(getUnitId_Packet,doOldBack);
					getEncryptPwd_Packet = null;
					if($("#unitIdFlag").val() == "0"){
						return false;
					}
					//��ѯ����
					var selectSql = "select  card_money  from dchncardres  where card_no = :iOld_Card_no";
					var params = "iOld_Card_no=" + $("#newCardId").val();
					var getUnitId_Packet = new AJAXPacket("/npage/public/pubSelectBySql.jsp","����У�����Ժ�......");
					getUnitId_Packet.data.add("selectSql",selectSql);
					getUnitId_Packet.data.add("params",params);
					getUnitId_Packet.data.add("wtcOutNum","1");
					core.ajax.sendPacket(getUnitId_Packet,doNewBack);
					getEncryptPwd_Packet = null;
					
					if($("#unitIdFlag").val() == "0"){
						return false;
					}
					//�ύ
					
					if($("#oldCardPrice").val() != $("#newCardPrice").val()){
						rdShowMessageDialog("�¾ɿ���ֵ��һ��" + retmsg,0);
						return false;
					}
					
					var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
			if(typeof(ret)!="undefined")
			  {
			    if((ret=="confirm"))
			    {
			      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
			      {
				   		formConfirm();
			      }
					}
				if(ret=="continueSub")
				{
			      if(rdShowConfirmDialog('ȷ���ύ��Ϣô��')==1)
			      {
				    	formConfirm();
			      }
				}
			  }
			else
			  {
			     if(rdShowConfirmDialog('ȷ���ύ��Ϣô��')==1)
			     {
				     formConfirm();
			     }
			  }
					
					
				});
			});
			
			function formConfirm(){
				
				/*�����ύ����*/
				var getdataPacket = new AJAXPacket("/npage/sm242/fm242Cfm.jsp","���ڻ�����ݣ����Ժ�......");
				getdataPacket.data.add("serviceName","sm242Cfm");
				getdataPacket.data.add("outnum","0");
				getdataPacket.data.add("inputParamsLength","13");
				getdataPacket.data.add("inParams0",$("#sysAccept").val());
				getdataPacket.data.add("inParams1","01");
				getdataPacket.data.add("inParams2","<%=opCode%>");
				getdataPacket.data.add("inParams3","<%=workno%>");
				getdataPacket.data.add("inParams4","<%=noPass%>");
				getdataPacket.data.add("inParams5",$("#phone").val());
				getdataPacket.data.add("inParams6","");
				/*�ɿ�*/
				getdataPacket.data.add("inParams7",$("#oldCardId").val());
				/*�¿�*/
				getdataPacket.data.add("inParams8",$("#newCardId").val());
				/*�ֿ�������*/
				getdataPacket.data.add("inParams9",$("#username").val());
				/*֤������*/
				getdataPacket.data.add("inParams10",$("#idType").val());
				/*֤������*/
				getdataPacket.data.add("inParams11",$("#idIccid").val());
				/*֤����ע*/
				getdataPacket.data.add("inParams12",$("#remark").val());
				core.ajax.sendPacket(getdataPacket,doCfmBack);
				getdataPacket = null;
			}
			
			function doCfmBack(packet){
	      var retcode = packet.data.findValueByName("retcode");
	      var retmsg = packet.data.findValueByName("retmsg");
	      if(retcode == "000000"){
	        rdShowMessageDialog("�����ɹ�",2);
	      }else if(retcode == "000001"){
	        rdShowMessageDialog("�����ɹ����˺���Ϊ��غ��룡",2);
	      }else{
	      	rdShowMessageDialog("�ύʧ�ܣ�������룺" + retcode + "��������Ϣ��" + retmsg,0);
	      }
	      doclear();
	    }
	    
	    function doclear(){
		  	window.location.href = "fm242.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			}
		
			
			function checkForm(){
				if(!check(document.frm)){
					return false;
				}
				
				//�ɿ�У�����ݣ� a�����кŵ�5λΪ��7������6��7λΪ��08����ϵͳ�жϣ�
				var oldCardId = $("#oldCardId").val();
				var oldCard5Num = oldCardId.substring(4,5);
				if(oldCard5Num != "7"){
					rdShowMessageDialog("У��ɿ���ʧ�ܣ�,��5λӦΪ��7��",0);
					return false;
				}
				var oldCard67Num = oldCardId.substring(5,7);
				if(oldCard67Num != "08"){
					rdShowMessageDialog("У��ɿ���ʧ�ܣ�,��6��7λӦΪ��08��",0);
					return false;
				}
				//�¿���5λ��Ϊ7
				var newCardId = $("#newCardId").val();
				var newCard5Num = newCardId.substring(4,5);
				if(newCard5Num == "7"){
					rdShowMessageDialog("У���¿���ʧ�ܣ�,��5λ��ӦΪ��7��",0);
					return false;
				}

				return true;
			}
						
			function doOldBack(packet){
				var retcode = packet.data.findValueByName("retcode");
				var retmsg = packet.data.findValueByName("retmsg");
				var result = packet.data.findValueByName("result");
				if(retcode != "000000"){
					$("#unitIdFlag").val("0");
					rdShowMessageDialog(retmsg,0);
				}else{
					var countNum = result[0][0];
					$("#oldCardPrice").val(countNum);
					$("#unitIdFlag").val("1");
				}
			}
			
			function doNewBack(packet){
				var retcode = packet.data.findValueByName("retcode");
				var retmsg = packet.data.findValueByName("retmsg");
				var result = packet.data.findValueByName("result");
				if(retcode != "000000"){
					$("#unitIdFlag").val("0");
					rdShowMessageDialog(retmsg,0);
				}else{
					var countNum = result[0][0];
					$("#newCardPrice").val(countNum);
					$("#unitIdFlag").val("1");
				}
			}
			
			function dogetOfferInfo(packet){
	      var retcode = packet.data.findValueByName("retcode");
	      var retmsg = packet.data.findValueByName("retmsg");
	      var cardStatus = packet.data.findValueByName("cardStatus");
	      if(retcode != "000000"){
	        rdShowMessageDialog("У�鿨��ʧ�ܣ�������룺" + retcode + "��������Ϣ��" + retmsg,0);
	      }else{
	      	if(cardStatus != "��Ч"){
	      		$("#oldCardStatys").val("0");
	      		rdShowMessageDialog("ֻ����Ч�Ŀ����԰���",0);
	      	}else{
	      		$("#oldCardStatys").val("1");
	      	}
	      }
	    }
	    
	    function showPrtDlg(printType,DlgMessage,submitCfm)
		  {  //��ʾ��ӡ�Ի���
			var pType="print";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
		  var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
			var sysAccept ="<%=sysAccept%>";                       // ��ˮ��
			var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
			var mode_code=null;                        //�ʷѴ���
			var fav_code=null;                         //�ط�����
			var area_code=null;                    //С������
			var opCode =   "<%=opCode%>";                         //��������
			var phoneNo = "";                           //�ͻ��绰

		   	var h=200;
		   	var w=400;
		   	var t=screen.availHeight/2-h/2;
		   	var l=screen.availWidth/2-w/2;

		   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
		  }

		  function printInfo(printType)
		  {
		  	
        var cust_info=""; //�ͻ���Ϣ
      	var opr_info=""; //������Ϣ
      	var retInfo = "";  //��ӡ����
      	var note_info1=""; //��ע1
      	var note_info2=""; //��ע2
      	var note_info3=""; //��ע3
      	var note_info4=""; //��ע4

				cust_info += " |";
				opr_info+="�ͻ�����:"+$("#username").val()+"            �ֻ�����:"+$("#phone").val()+"|";
				opr_info+="֤������:" + $("#idIccid").val() +"|";
				opr_info+="����ҵ�񣺳�ֵ���������|";
				opr_info+="ҵ����ˮ��<%=sysAccept%>      ��ֵ�������ѣ�0"+"|";
				opr_info+="ԭ��ֵ���ţ�"+$("#oldCardId").val()+"  ԭ��ֵ����ֵ��"+$("#oldCardPrice").val()+"Ԫ|";
				opr_info+="�³�ֵ���ţ�"+$("#newCardId").val()+"  �³�ֵ����ֵ��"+$("#newCardPrice").val()+"Ԫ|";
				
				note_info1+="��ע��Ϊ�������ĳ�ֵ������ʹ�ã�������Ӫҵ���ֳ����г�ֵ��������ֵ��������Ӫҵ��Ա����|";
				note_info1+="�𾴵Ŀͻ����ã������������ĳ�ֵ��������������ĳ�ֵ��Ϳ����δ�ο����ѳ�ֵ�����ڱ����˵��õĿ��ܣ��ҹ�˾��������򹫰����ر����������������������Ϣ�Ա���ϵ��飬лл��|";
					
				retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

	    	    return retInfo;
		  }
			
		</script>
</HEAD>
<BODY >
	<FORM action="" method=post name="frm" ENCTYPE="multipart/form-data">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="sysAccept" id="sysAccept" value="<%=sysAccept%>"> 
	<input type="hidden" id="oldCardStatys" value="0"/>
	<input type="hidden" id="unitIdFlag" value="0"/>
	<input type="hidden" id="newCardPrice"  />
	<input type="hidden" id="oldCardPrice"  />
	
	<table cellspacing="0">
		<tr>
			<td class="blue">�ɿ����к�</td>
			<td>
				<input type="text" id="oldCardId" maxlength="30" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
			<td class="blue">�¿����к�</td>
			<td>
				<input type="text" id="newCardId" maxlength="30" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
		</tr>
		
		<tr>
			<td class="blue">�ֿ�������</td>
			<td>
				<input type="text" id="username" maxlength="10" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
			<td class="blue">�ֿ�����ϵ�绰</td>
			<td>
				<input type="text" id="phone" maxlength="11" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
		</tr>
		
		<tr>
			<td class="blue">֤������</td>
			<td>
				<SELECT  id="idType" name="idType"> 
					<OPTION selected value="0">���֤</OPTION> 
					<OPTION value="1">����֤</OPTION> 
					<OPTION value=2>���ڲ�</OPTION> 
					<OPTION value=3>�۰�ͨ��֤</OPTION> 
					<OPTION value=4>����֤</OPTION> 
					<OPTION value=5>̨��ͨ��֤</OPTION> 
					<OPTION value=6>���������</OPTION>
				</SELECT>
			</td>
			<td class="blue">֤������</td>
			<td>
				<input type="text"  id="idIccid" maxlength="20" v_must="1" v_type="string" onblur="checkElement(this)" />
				<font class=orange>*</font>
			</td>
		</tr>
		
		<tr>
			<td class="blue">��ע</td>
			<td colspan="3">
				<input type="text"  id="remark" maxlength="100" size="80"/>
			</td>
		</tr>
		
		<tr>
			<td id="footer" colspan="4">
			<input  name="quchoose" id="quchoose" class="b_foot" type="button" value="ȷ��&��ӡ">
			&nbsp;
			<input  name="clear" class="b_foot" type=reset value="����" />
			&nbsp;                  			
			</td>
		</tr>
	</table>
	
	
	<%@ include file="/npage/include/footer.jsp" %>
	</FORM>
</BODY>
</HTML>