 <%
	/********************
	 version v2.0
	������: si-tech
	update:2015/02/12 12:54:23 gaopeng
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

<HTML>
	<HEAD>
		<TITLE><%=opName%></TITLE>
		<script language="JavaScript">
		$(document).ready(function(){
			var radioFlag = $("input[name='opType'][checked]").val();
			if(radioFlag == "simple"){
				$("#isgua option[value='1']").remove();
				$("#simpleEx").show();
			}
			changeType();			
		
		});
		function doCommit()
		{
			var radioFlag = $("input[name='opType'][checked]").val();
			if(radioFlag == "simple"){
				if(!checkElement(document.all.cardNo)){
					return false;
				}
				if(!checkElement(document.all.phoneNo)){
					return false;
				}
				if(!checkElement(document.all.custName)){
					return false;
				}
				if(!checkElement(document.all.idIccid)){
					return false;
				}
			}else if(radioFlag == "piliang"){
				
				if(!checkElement(document.all.phoneNo)){
					return false;
				}
				if(!checkElement(document.all.custName)){
					return false;
				}
				if(!checkElement(document.all.idIccid)){
					return false;
				}
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
			  return true;
			}
		
		function formConfirm(){
			
			var phoneNo = $.trim($("#phoneNo").val());
			var radioFlag = $("input[name='opType'][checked]").val();
			var iImp_flag = "";
			var iCard_no = "";
			var iCard_static ="";
			if(radioFlag == "simple"){
				iImp_flag="0";
				iCard_no = $.trim($("#cardNo").val());
				/*�мۿ�״̬*/
				iCard_static = $.trim($("#cardStatus").val());
			}else if(radioFlag == "piliang"){
				iImp_flag="1";
				iCard_no = $("input[name='serviceFileName']").val();
				/*�мۿ�״̬*/
				iCard_static = "";
			}
			
			/*�Ƿ�ο�*/
			var iUse_flag = $("select[name='isgua']").find("option:selected").val();
			/*�Ƿ��ֵ*/
			var iPre_flag = $("select[name='ischong']").find("option:selected").val();
			/*�ͻ�����*/
			var iCust_name = $.trim($("#custName").val());
			/*֤������*/
			var iId_type = $("select[name='idType']").find("option:selected").val();
			/*֤������*/
			var idIccid = $.trim($("#idIccid").val());
			/*��ע*/
			var iNote = $.trim($("#reply_content").text());
			if(iNote.length > 500){
				rdShowMessageDialog("��ע��Ϣ������500�����ڣ�",1);
				return false;
			}
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm241/fm241Cfm.jsp","���ڻ�����ݣ����Ժ�......");
			
			var iLoginAccept = "<%=sysAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=workno%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = phoneNo;
			var iUserPwd = "";
			
			
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			getdataPacket.data.add("iImp_flag",iImp_flag);
			getdataPacket.data.add("iCard_no",iCard_no);
			getdataPacket.data.add("iUse_flag",iUse_flag);
			
			getdataPacket.data.add("iPre_flag",iPre_flag);
			getdataPacket.data.add("iCust_name",iCust_name);
			getdataPacket.data.add("iId_type",iId_type);
			getdataPacket.data.add("iId_iccid",idIccid);
			getdataPacket.data.add("iCard_static",iCard_static);
			getdataPacket.data.add("iNote",iNote);
			
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			
			
			
			
			if(retCode == "000000"){
				
				rdShowMessageDialog("�����ɹ���",2);
				doclear();
				
			}else if(retCode == "000001"){
				
				rdShowMessageDialog("�����ɹ����˺���Ϊ��غ��룡",2);
				doclear();
				
			}else{
				
				rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
				doclear();
				
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

		   	var h=300;
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
		  	
		  	var phoneNo = $.trim($("#phoneNo").val());
				var radioFlag = $("input[name='opType'][checked]").val();
				var iImp_flag = "";
				var iCard_no = "";
				var iCard_static ="";
				if(radioFlag == "simple"){
					iImp_flag="0";
					iCard_no = $.trim($("#cardNo").val());
					/*�мۿ�״̬*/
					iCard_static = $.trim($("#cardStatus").val());
				}else if(radioFlag == "piliang"){
					iImp_flag="1";
					iCard_no = $("input[name='serviceFileName']").val();
					/*�мۿ�״̬*/
					iCard_static = "";
				}
				
				/*�Ƿ�ο�*/
				var iUse_flag = $("select[name='isgua']").find("option:selected").html();
				/*�Ƿ��ֵ*/
				var iPre_flag = $("select[name='ischong']").find("option:selected").html();
				/*�ͻ�����*/
				var iCust_name = $.trim($("#custName").val());
				/*֤������*/
				var iId_type = $("select[name='idType']").find("option:selected").html();
				/*֤������*/
				var idIccid = $.trim($("#idIccid").val());
				/*��ע*/
				var iNote = $.trim($("#reply_content").text());
			    
			         		
        var cust_info=""; //�ͻ���Ϣ
      	var opr_info=""; //������Ϣ
      	var retInfo = "";  //��ӡ����
      	var note_info1=""; //��ע1
      	var note_info2=""; //��ע2
      	var note_info3=""; //��ע3
      	var note_info4=""; //��ע4

				cust_info+=" "+"|";
				if(radioFlag == "simple"){
					opr_info+="�ͻ�����:"+iCust_name+"            �ֻ�����:"+phoneNo+"|";
					opr_info+="֤������:" + $("#idIccid").val() +"             ԭ��ֵ������:"+iCard_no+"|";
					
				}else if(radioFlag == "piliang"){
					opr_info+="�ͻ�����:"+iCust_name+"            �ֻ�����:"+phoneNo+"|";
				}
				opr_info+="ҵ������:<%=opName%>            ҵ����ˮ��<%=sysAccept%>"+"|";
				var radioFlag = $("input[name='opType'][checked]").val();
				
				if($("#isgua").val() == "1" && $("#ischong").val() == "2"){
					note_info1+="�𾴵Ŀͻ����ã������������ĳ�ֵ��������������ĳ�ֵ��Ϳ����δ�ο����ѳ�ֵ�����ڱ����˵��õĿ��ܣ��ҹ�˾��������򹫰����ر����������������������Ϣ�Ա���ϵ��飬лл��|";
				}else if($("#isgua").val() == "0" && $("#ischong").val() == "3"){
					note_info1+="�𾴵Ŀͻ����ã������ҹ�˾ϵͳ�������������ĳ�ֵ��δ�ܳ�ֵ��Ϳ���ѹο�����������ɴ˸��������Ĳ��㣬�����½⡣�����������������Ϣ��лл��|";
				}else if($("#isgua").val() == "1" && $("#ischong").val() == "3"){
					note_info1+="�𾴵Ŀͻ����ã������ҹ�˾ϵͳ�������������ĳ�ֵ��δ�ܳ�ֵ��Ϳ��δ�ο�����������ɴ˸��������Ĳ��㣬�����½⡣�����������������Ϣ��лл��|";
				}else if($("#isgua").val() == "0" && $("#ischong").val() == "2"){
					note_info1+="�𾴵Ŀͻ����ã����ĳ�ֵ��Ϳ���ѹο����ѳ�ֵ�����ֵ��Ϊ����������ɲ������������������������ر�����ͬʱ���ҹ�˾Ҳ��Э����ϵ��顣�����������������Ϣ��|";
				}
				note_info1+="������ʵ���������Ϣ���ݣ���ȷ��������ǩ��ȷ�ϡ�|";
					
				retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

	    	    return retInfo;
		  }

	


		function doclear()
		{
		        window.location.href = "fm241.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
		
function changeType(opCode){
	
	var radioFlag = $("input[name='opType'][checked]").val();
	if(radioFlag == "simple"){
		$("#dyntb").show();
		$("#mutiConstants").hide();
		$("#isgua option[value='1']").remove();
		$("#simpleEx").show();
	}else if(radioFlag == "piliang"){
		$("#dyntb").hide();
		$("#mutiConstants").show();
		$("#isgua").append("<option value='1'>δ��</option>");
		$("#simpleEx").hide();
	}
	
}

function checkcards() {
			
			
			var radio1 = document.getElementsByName("opType");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								  if(opFlag=="simple")
								{	
									
									if(!checkElement(document.all.cardNo)){
										return false;
									}
									
									var phoneNo = $.trim($("#phoneNo").val());
									var cardNo = $.trim($("#cardNo").val());
					        var packet = new AJAXPacket("fm241Check.jsp","���ڻ�����ݣ����Ժ�......");
					      	packet.data.add("cardNo",cardNo);
					      	packet.data.add("phoneNo",phoneNo);
					      	packet.data.add("opCode","<%=opCode%>");
					      	packet.data.add("opName","<%=opName%>");
					      	
					      	core.ajax.sendPacket(packet,dogetOfferInfo);
					      	packet = null;     		    

						    }
						    else {
						     			 	
						    						    	
						    }
				    }
		     }
		
}
	
	/*�ϴ�txt�ļ��ķ���*/
		function uploadBroad(){
			if($("#workNoList").val() == ""){
				rdShowMessageDialog("���ϴ��мۿ���Ϣ�ļ���");
				$("#workNoList").focus();
				return false;
			}
			var formFile=frm.workNoList.value.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=frm.workNoList.value.length;
			formFile=frm.workNoList.value.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("�ϴ��ļ���ʽֻ����txt��������ѡ���мۿ���Ϣ�ļ���",1);
				document.frm.workNoList.focus();
				return false;
			}
			else
				{
					/*׼���ϴ�*/
					document.frm.target="hidden_frame";
			    document.frm.encoding="multipart/form-data";
			    document.frm.action="/npage/sm241/fm241Upload.jsp";
			    document.frm.method="post";
			    document.frm.submit();
					return true;
				}
			
		}
		/*�ϴ��ɹ���Ҫ�����¶�*/
		function doSetFileName(oldFileName,newFileName,newFilePath){
			rdShowMessageDialog("�ϴ��ļ�"+oldFileName+"�ɹ���",2);
			$("input[name='serviceFileName']").val(newFileName);
			$("input[name='serviceFilePath']").val(newFilePath);
			/*�ϴ�����Ч*/
			$("#uploadFile").attr("disabled","disabled");
			/*�ύ����Ч*/
			$("#quchoose").attr("disabled","");
			/*��ѡ��ť����Ч*/
			$("input[name='opType']").each(function(){
				$(this).attr("disabled","disabled");
			});
		}
		/*�ϴ�ʧ�ܺ�Ҫ�����¶�*/
		function showUploadError(errorInfo){
			rdShowMessageDialog(errorInfo,1);
			window.location.href='/npage/sm241/fm241Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
			
		}
		
	function dogetOfferInfo(packet){
      var retcode = packet.data.findValueByName("retcode");
      var retmsg = packet.data.findValueByName("retmsg");
      var cardStatus = packet.data.findValueByName("cardStatus");
      if(retcode != "000000"){
        rdShowMessageDialog("У�鿨��ʧ�ܣ�������룺" + retcode + "��������Ϣ��" + retmsg,0);
        document.all.quchoose.disabled=true;
      }else{
      	/*
      	if(cardStatus != "����"){
      		rdShowMessageDialog("ֻ�����۵Ŀ����԰���",0);
      		$("#quchoose").attr("disabled","disabled");
      	}else{
      	*/
	     		rdShowMessageDialog("У�鿨�ųɹ�",2);
	     		$("#cardStatus").val(cardStatus);
	     		$("#quchoose").attr("disabled","");
	     		
		     	$("#cardNo").attr("readonly","readonly");
					$("#cardNo").attr("class","InputGrey");
					
					/*��ѡ��ť����Ч*/
					$("input[name='opType']").each(function(){
						$(this).attr("disabled","disabled");
					});
					$("#compBtn").attr("disabled","disabled");
	     	/*
     		}
     		*/
     		
 				
      }
    }	
    
   function tellMore1000(){
			rdShowMessageDialog("���ֻ���ϴ�1000�����ݣ���������ѡ���ļ�",1);
			return false;
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
	<input type="hidden" name="sysAccept" value="<%=sysAccept%>"> 
	<input type="hidden" name="opflag" value="0">

        <table id=""  cellspacing="0">      	
        	  <tr>

			        		<td width=16% class="blue">��������</td>

			        		<td width=84% colspan="3">

			        			<input type="radio" name="opType"	value="simple"   onclick="changeType(this.value);" checked/>����¼�� &nbsp;&nbsp;

			        			<input type="radio" name="opType"	value="piliang"  onclick="changeType(this.value);"/>�������� &nbsp;&nbsp;

			        		</td>

        				</tr>
       </table>
       
       <table   cellspacing="0" style="display:block">
       	        	  <tr id="dyntb">

			        		<td width=16% class="blue">����</td>

			        		<td width=34% >
                       <input type="text" name="cardNo" id="cardNo" value="" v_must="1" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
			        				 &nbsp;&nbsp;<input  name="compBtn" id="compBtn" class="b_foot" type="button" value="��֤" onclick="checkcards()">
			        		</td>
			        		<td width=16% class="blue">
			        				��״̬
			        		</td>
									
			        		<td width=34% >
                       <input type="text" name="cardStatus" id="cardStatus" value="" readOnly class="InputGrey">
			        		</td>
			        		

        				</tr>
        				
        				  <tr>

			        		<td width=16% class="blue">�Ƿ�ο�</td>

			        		<td width=34% >
                       <select id="isgua" name="isgua">
                       	<option value="0">�ѹ�</option>
                       	<option value="1">δ��</option>
                       </select>
			        		</td>
			        		<td width=16% class="blue">�Ƿ��ֵ</td>

			        		<td width=34% >
                       <select id="ischong" name="ischong">
                       	<option value="2">�ѳ�</option>
                       	<option value="3">δ��</option>
                       </select>
			        		</td>
			        		
        				</tr>
        				
        				 <tr>

			        		<td width=16% class="blue">�ֻ�����</td>

			        		<td width=34% >
                       <input type="text" name="phoneNo" id="phoneNo" value="" v_type="mobphone"   v_must="1">
			        		</td>
			        		<td width=16% class="blue">�ͻ�����</td>

			        		<td width=34% >
                       <input type="text" name="custName"  id="custName" value="" v_must="1">&nbsp;&nbsp;&nbsp;&nbsp;
              
			        		</td>

        				</tr>
        				 <tr>
                  <td width="16%" class="blue"> ֤������</td>
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
                  <td width="16%" class="blue"> ֤������ </td>
                  <td>
                      <input type="text"  id="idIccid" name="idIccid" v_must="1">
                  </td>
         					<tr>
                  <td width="16%" class="blue"> ��ע</td>
                  <td colspan="3"> 
                    <textarea id="reply_content" style="width:100%;word-break:break-all"  name="reply_content" rows=4 cols="60" width="%100" ></textarea>
                  </td>
                </tr>
                <tr id="simpleEx">
                	<td colspan='4'>
                			<font color="red">
                				<b>ע�⣺</b><br>
                				1�������ֵ��Ϊδ�ο���δ��ֵ��������뵽��m240���ض��мۿ����� �����а���<br>
                				2�������ֵ��Ϊδ�ο����ѳ�ֵ��������뵽��m242��δ�ο��ѳ�ֵ�ĳ�ֵ�����������а���
                			</font>
                		
                	</td>
                </tr>
        				
              </table>

        				
  <div id="mutiConstants" >
			<table>
				<tr>
					<td width="20%" class="blue">
						������Ϣ����
					</td>
					<td>
						<input type="file" name="workNoList" id="workNoList" class="button"
						style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
						&nbsp;&nbsp;
						<input type="button" name="uploadFile" id="uploadFile" class="b_text" value="�ϴ�" onclick="uploadBroad();"/>
					</td>
				</tr>
				<tr>
					<td class="blue">
						�ļ���ʽ˵��
					</td>
		      <td> 
		          �ϴ��ļ��ı���ʽΪ��20150212777706300����ʾ�����£�<br>
		          <font class='orange'>
		          	&nbsp;&nbsp; 20150212777706300<br/>
		          	&nbsp;&nbsp; 20150212777706301<br/>
		          	&nbsp;&nbsp; 20150212777706302<br/>
		          	&nbsp;&nbsp; 20150212777706303<br/>
		          	&nbsp;&nbsp; 20150212777706304<br/>
		          	&nbsp;&nbsp; 20150212777706305<br/>
		          	&nbsp;&nbsp; 20150212777706306<br/>
		          	&nbsp;&nbsp; 20150212777706307<br/>
		          	&nbsp;&nbsp; 20150212777706308
		          </font>
		          <b>
		          <br>&nbsp;&nbsp; ע����ʽ�е�ÿһ�����������ڿո�,��ÿ����Ϣ����Ҫ�س����С�
		          </b> 
		      </td>
		    </tr>
			</table>
		</div>

        				       	
     
             <table cellspacing="0">
              	<tbody>
              		<tr>
                		<td id="footer">
                                    <input  name="quchoose" id="quchoose" class="b_foot" type="button" value="ȷ��&��ӡ"  onclick="doCommit();" disabled="disabled">
                                    &nbsp;
                                  	<input  name="clear" class="b_foot" type=reset value="����" onclick="doclear()">
                                  	&nbsp;                  			

                		</td>
              		</tr>
              </tbody>
            </table>
      <!--��ˮ�� -->
			<input type="hidden" name="printAccept" value="<%=sysAccept%>">
			<!-- �������� -->
			<input type="hidden" name="opCode" value="<%=opCode%>">		
			<!-- �������� -->
			<input type="hidden" name="opName" value="<%=opName%>">		
			<!--�ϴ��ļ��� -->	
			<input type="hidden" name="serviceFileName" value=""/>
			<!--�ϴ��ļ�ȫ·���� -->	
			<input type="hidden" name="serviceFilePath" value=""/>
			<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
	     <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

