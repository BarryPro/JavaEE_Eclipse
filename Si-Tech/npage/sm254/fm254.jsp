 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-12 ҳ�����,�޸���ʽ
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
	String orgcode = (String)session.getAttribute("orgCode");
  String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  String regionCode= (String)session.getAttribute("regCode");


%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regioncode%>"  id="sysAccept" />

<HTML>
	<HEAD>
		<TITLE><%=opName%></TITLE>
		<script language="javascript" type="text/javascript" src="cardNumIndex.js"></script>
		<script language="JavaScript">
    var quanjusum=0;
    
    $(document).ready(function(){ 
    	document.all.opType[1].checked=true;
    	changeType("piliang");
    	});
    
		function doCommit()
		{
	

				var phone_nos   = $("#phone_no").val();
			  if(phone_nos.trim() ==""){
			  rdShowMessageDialog("�������ֻ����룡",1);
			  return false;
			  }
	
				var custnamess  = $("#custnames").val();
			  if(custnamess.trim() ==""){
			  rdShowMessageDialog("������ͻ�������",1);
			  return false;
			  }	
				var iccidhaos  = $("#iccidhao").val();
			  if(iccidhaos.trim() ==""){
			  rdShowMessageDialog("������֤�����룡",1);
			  return false;
			  }	
				var isyouji  = $("#isyouji").val();
			  if(isyouji.trim() =="zz"){
			  rdShowMessageDialog("��ѡ���Ƿ��ʼģ�",1);
			  return false;
			  }					  			  		  
			  
			var radio1 = document.getElementsByName("opType");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								  if(opFlag=="simple")
								{	
							
						$("#opflag").val("1");     
						$("#duiduansheng").val($("#suoshushengfen").val()); 							
      	
				  var  ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
		    
		     if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
            		document.form1.action="fm254Cfm.jsp";
		            document.form1.submit();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
            		document.form1.action="fm254Cfm.jsp";
		            document.form1.submit();
          }
        }
      }else{
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
            		document.form1.action="fm254Cfm.jsp";
		            document.form1.submit();
        }
      }
       		    

						    }
						    else {
						    	$("#opflag").val("2");

						    	var checkonecol=0;
						    	var checkonecol1=0;
						    	var checkonecol2=0;
						    	var kahaoss="";
						    	var qianshuss="";
						    	var zongqianshuxianshi=0;
						    	var shuliangss=0;
						    	var duiduanshengss="";
						    	var kami="";
						    	var checkonecol3=0;

						    	  $("#dyntb2 tr").each(
									    function(){
												//alert($(this).find("td:eq(1) input").val());
												if($(this).find("td:eq(1) input").val()!=undefined) {
																			
													if($(this).find("td:eq(1) input").val().trim()=="") {
														checkonecol++;
														return false;
													}
													if($(this).find("td:eq(1) input").val().trim().length !=17) {
														checkonecol1++;
														return false;
													}
													if($(this).find("td:eq(3) input").val().trim()=="") {
														checkonecol2++;
														return false;
													}
													if($(this).find("td:eq(5) select").val().trim()=="zz") {
														checkonecol3++;
														return false;
													}													
													
													duiduanshengss=$(this).find("td:eq(7) input").val().trim();
													kami=kami+""+$(this).find("td:eq(3) input").val().trim()+"|";		
													
													kahaoss=kahaoss+""+$(this).find("td:eq(1) input").val().trim()+"|";		
													qianshuss=qianshuss+""+$(this).find("td:eq(5) select").val().trim()+"|";			
													zongqianshuxianshi= zongqianshuxianshi+parseFloat($(this).find("td:eq(5) select").val().trim());		
													shuliangss++;	
												}
										  }
							     );
							     
							 if(checkonecol!=0)   {
								rdShowMessageDialog("��������мۿ����ţ�",1);
			          return false;						 	
							 	}
							 if(checkonecol1!=0)   {
								rdShowMessageDialog("����Ϊ17λ��Ч���֣�",1);
				        return false;							 	
							 	}
							 if(checkonecol2!=0)   {
								rdShowMessageDialog("��������мۿ����ܣ�",1);
			          return false;						 	
							 	}
								 if(checkonecol3!=0)   {
								rdShowMessageDialog("��ѡ���мۿ���",1);
			          return false;						 	
							 	}								 	
							 	
							     
							if(hasRepeat()!="0" && hasRepeat()!=undefined) {
						  rdShowMessageDialog("���ظ��Ŀ�������"+hasRepeat()+"����ȷ�ϣ�",1);
					     return false;								
							}
							
     		var zongmoney=zongqianshuxianshi;
     		$("#infilling_number").val(shuliangss);
     		$("#infilling_price").val(zongmoney);
     		$("#duiduansheng").val(duiduanshengss);
     		$("#lisankahao").val(kahaoss);
     		$("#lisanjine").val(qianshuss);
     		$("#kami").val(kami);
     		

     		
     		
				    var  ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
		    
		     if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
            		document.form1.action="fm254Cfm.jsp";
		            document.form1.submit();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
            		document.form1.action="fm254Cfm.jsp";
		            document.form1.submit();
          }
        }
      }else{
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
            		document.form1.action="fm254Cfm.jsp";
		            document.form1.submit();
        }
      }
      
							     						    						    	
						    }
    
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

		   	var h=150;
		   	var w=350;
		   	var t=screen.availHeight/2-h/2;
		   	var l=screen.availWidth/2-w/2;

		   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
		  }

		  function printInfo(printType)
		  {
			    var count=$("#infilling_number").val();
			    var count1=$("#infilling_price").val();
			         		
		        var cust_info=""; //�ͻ���Ϣ
		      	var opr_info=""; //������Ϣ
		      	var retInfo = "";  //��ӡ����
		      	var note_info1=""; //��ע1
		      	var note_info2=""; //��ע2
		      	var note_info3=""; //��ע3
		      	var note_info4=""; //��ע4

						 cust_info+="�ֻ����룺   "+$("#phone_no").val()+"|";
			       cust_info+="�ͻ�������   "+$("#custnames").val()+"|";
			       cust_info+="֤�����룺   "+$("#iccidhao").val()+"|";
			       
			var radio1 = document.getElementsByName("opType");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								  if(opFlag=="simple")//��������<1000
								{
									
									if(parseFloat(count1)<1000) {
                    opr_info+="Ͷ����ˮ�ţ�"+$("#tousudanhao").val()+"|";
                    opr_info+="�Ƿ�ο���"+$("#isgua").find('option:selected').text()+"|";
                    opr_info+="����ҵ��ǧԪ������ʡ��ֵ������ʡ����|";
                    opr_info+="������ˮ��<%=sysAccept%>       ��ֵ�������ѣ�0Ԫ|";
                    opr_info+="ԭ��ʼ���ţ�"+$("#oldbegin").val()+"    ԭ�������ţ�"+$("#oldend").val()+"    ����ʡ�ݣ�"+$("#suoshushengfen").val()+"    ������"+$("#danzhangmiane").val()+"Ԫ|";
                    opr_info+="�мۿ�����:"+count+"            �ܽ�"+count1+"|";
										opr_info+="��ע��ԭ��ֵ��������Ӫҵ��Ա����"+"|";

									}else {//>=1000
                    opr_info+="Ͷ����ˮ�ţ�"+$("#tousudanhao").val()+"|";
                    opr_info+="�Ƿ�ο���"+$("#isgua").find('option:selected').text()+"|";
                    opr_info+="����ҵ��ǧԪ������ʡ��ֵ������ʡ�տ��ʼ�|";
                    opr_info+="������ˮ��<%=sysAccept%>       ��ֵ�������ѣ�0Ԫ|";
                    opr_info+="ԭ��ʼ���ţ�"+$("#oldbegin").val()+"    ԭ�������ţ�"+$("#oldend").val()+"    ����ʡ�ݣ�"+$("#suoshushengfen").val()+"    ������"+$("#danzhangmiane").val()+"Ԫ|";
                    opr_info+="�мۿ�����:"+count+"            �ܽ�"+count1+"|";
										opr_info+="��ע���ͻ�����ֵ�����ں������ƶ����ɺ������ƶ�����ֵ�������������Ϣ������������˾�����ɷ�����˾���������˾������ֵ���Ƿ񾭹���ֵ�����У�����δ������ֵ�ģ�������˾����������ֵ���ĵ�ֵ����ֵ������������˾��"+"|";
																				
									}
								}else {		
									
			
										if(parseFloat(count1)<1000) {
                    opr_info+="Ͷ����ˮ�ţ�"+$("#tousudanhao").val()+"|";
                    opr_info+="�Ƿ�ο���"+$("#isgua").find('option:selected').text()+"|";
                    opr_info+="����ҵ��ǧԪ������ʡ��ֵ������ʡ����|";
                    opr_info+="������ˮ��<%=sysAccept%>       ��ֵ�������ѣ�0Ԫ|";
				           
									  $("#dyntb2 tr").each(
									    function(){
												//alert($(this).find("td:eq(1) input").val());
												if($(this).find("td:eq(1) input").val()!=undefined) {
													
													opr_info+="ԭ��ֵ���ţ�"+$(this).find("td:eq(1) input").val()+"    ����ʡ�ݣ�"+$(this).find("td:eq(7) input").val()+"    ԭ��ֵ����ֵ��"+$(this).find("td:eq(5) select").val()+"Ԫ|";
													
												}
										  }
							     );
                    
                    opr_info+="�мۿ�����:"+count+"            �ܽ�"+count1+"|";
										opr_info+="��ע��ԭ��ֵ��������Ӫҵ��Ա����"+"|";

									}else {//>=1000
                    opr_info+="Ͷ����ˮ�ţ�"+$("#tousudanhao").val()+"|";
                    opr_info+="�Ƿ�ο���"+$("#isgua").find('option:selected').text()+"|";
                    opr_info+="����ҵ��ǧԪ������ʡ��ֵ������ʡ�տ��ʼ�|";
                    opr_info+="������ˮ��<%=sysAccept%>       ��ֵ�������ѣ�0Ԫ|";
                    
                    	$("#dyntb2 tr").each(
									    function(){
												//alert($(this).find("td:eq(1) input").val());
												if($(this).find("td:eq(1) input").val()!=undefined) {
													
													opr_info+="ԭ��ֵ���ţ�"+$(this).find("td:eq(1) input").val()+"    ����ʡ�ݣ�"+$(this).find("td:eq(7) input").val()+"    ԭ��ֵ����ֵ��"+$(this).find("td:eq(5) select").val()+"Ԫ|";
													
												}
										  }
							     );
							     
                    opr_info+="�мۿ�����:"+count+"            �ܽ�"+count1+"|";
										opr_info+="��ע���ͻ�����ֵ�����ں������ƶ����ɺ������ƶ�����ֵ�������������Ϣ������������˾�����ɷ�����˾���������˾������ֵ���Ƿ񾭹���ֵ�����У�����δ������ֵ�ģ�������˾����������ֵ���ĵ�ֵ����ֵ������������˾��"+"|";
																				
									}
									
								}
							}
						}


				retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

	    	    return retInfo;
		  }

	


		function doclear()
		{
		        window.location.href = "fm254.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
		
function changeType(opCode){
	document.all.comp.disabled=false;
	document.all.quchoose.disabled=true;
	if(opCode == "simple"){
		
	$("#dyntb").show();
	$("#dyntb2").hide();
 	
		$("#infilling_number").val("0");
    $("#infilling_price").val("0");
    $("#squerys").empty();    
    $("#oldbeginjiu").val("");
    $("#miane").val("");
    $("#ssshengfen").val("");   
    document.all.addyjk.disabled=false;
	}
	if(opCode == "piliang"){
	$("#dyntb").hide();
	$("#dyntb2").show();
	
 	  $('#oldbegin').attr("readonly","");
    $('#oldend').attr("readonly","");    
		$("#oldbegin").val("");
		$("#oldend").val("");
		$("#infilling_number").val("0");
    $("#infilling_price").val("0");
    $("#suoshushengfen").val("");
   	    
	}	
}

function checkcards() {
	
				var phone_nos   = $("#phone_no").val();
			  if(phone_nos.trim() ==""){
			  rdShowMessageDialog("�������ֻ����룡",1);
			  return false;
			  }
	
				var custnamess  = $("#custnames").val();
			  if(custnamess.trim() ==""){
			  rdShowMessageDialog("������ͻ�������",1);
			  return false;
			  }	
				var iccidhaos  = $("#iccidhao").val();
			  if(iccidhaos.trim() ==""){
			  rdShowMessageDialog("������֤�����룡",1);
			  return false;
			  }		
				var isyouji  = $("#isyouji").val();
			  if(isyouji.trim() =="zz"){
			  rdShowMessageDialog("��ѡ���Ƿ��ʼģ�",1);
			  return false;
			  }				  
			  		  		  
			  
			var radio1 = document.getElementsByName("opType");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								  if(opFlag=="simple")
								{	
									

		     var oldbegin = $("#oldbegin").val();
		     var oldend   = $("#oldend").val();
			  if(oldbegin.trim() ==""){
			  rdShowMessageDialog("������ɿ�ʼ���ţ�",1);
			  return false;
			  }
			  if(oldend.trim() ==""){
			  rdShowMessageDialog("������ɽ������ţ�",1);
			  return false;
			  }	
			  if(oldbegin.trim().length !=17 ){
			  rdShowMessageDialog("����Ϊ17λ��Ч���֣�",1);
			  return false;
			  }	 
			  if(oldend.trim().length !=17 ){
			  rdShowMessageDialog("����Ϊ17λ��Ч���֣�",1);
			  return false;
			  }	 			   

        var packet = new AJAXPacket("fm254Check.jsp","���ڻ�����ݣ����Ժ�......");
      	packet.data.add("oldbegin",oldbegin);
      	packet.data.add("oldend",oldend);      	
      	packet.data.add("opFlag","0");
      	
      	core.ajax.sendPacket(packet,dogetOfferInfo);
      	packet = null;     		    

						    }
						    else {

						    	var checkonecol=0;
						    	var checkonecol1=0;
						    	var checkonecol2=0;
						    	var zongqianshuxianshi=0;
						    	var shuliangss=0;
						    	var checkonecol3=0;
						    	  $("#dyntb2 tr").each(
									    function(){
												//alert($(this).find("td:eq(1) input").val());
												if($(this).find("td:eq(1) input").val()!=undefined) {
																			
													if($(this).find("td:eq(1) input").val().trim()=="") {
														checkonecol++;
														return false;
													}
													if($(this).find("td:eq(1) input").val().trim().length !=17) {
														checkonecol1++;
														return false;
													}

													if($(this).find("td:eq(3) input").val().trim()=="") {
														checkonecol2++;
														return false;
													}	
													if($(this).find("td:eq(5) select").val().trim()=="zz") {
														checkonecol3++;
														return false;
													}
																									
		
													zongqianshuxianshi= zongqianshuxianshi+parseFloat($(this).find("td:eq(5) select").val().trim());		
													shuliangss++;	
												}
										  }
							     );
							     
							 if(checkonecol!=0)   {
								rdShowMessageDialog("��������мۿ����ţ�",1);
			          return false;						 	
							 	}
							 if(checkonecol1!=0)   {
								rdShowMessageDialog("����Ϊ17λ��Ч���֣�",1);
				        return false;							 	
							 	}
							 if(checkonecol2!=0)   {
								rdShowMessageDialog("��������мۿ����ܣ�",1);
			          return false;						 	
							 	}
								 if(checkonecol3!=0)   {
								rdShowMessageDialog("��ѡ���мۿ���",1);
			          return false;						 	
							 	}						 	
							 	
							 	
							 //alert(hasRepeat());    
							if(hasRepeat()!="0" && hasRepeat()!=undefined) {
						  rdShowMessageDialog("���ظ��Ŀ�������"+hasRepeat()+"����ȷ�ϣ�",1);
					     return false;								
							}
							
     		var zongmoney=zongqianshuxianshi;
     		$("#infilling_number").val(shuliangss);
     		$("#infilling_price").val(zongmoney);
     		
     		rdShowMessageDialog("У�鿨�ųɹ�",2);
     		document.all.addyjk.disabled=true;
     		document.all.quchoose.disabled=false;
	 			document.all.comp.disabled=true;		
							     						    						    	
						    }
    
				    }
		     }
		
}

function hasRepeat(){ 
			var arr = []; 
			$("#dyntb2 tr").each(function(){ 
			//alert($("td:eq(1) input",this).val());
    if($("td:eq(1) input",this).val()!=undefined) {
			arr.push($("td:eq(1) input",this).val());  
		}					    
			}); 

			var nary=arr.sort();
			for(var i=0;i<arr.length;i++){		
			if (nary[i]==nary[i+1]){			
			return nary[i];			
			}	
			}
} 
		
	function dogetOfferInfo(packet){
      var retcode = packet.data.findValueByName("errCode");
      var retmsg = packet.data.findValueByName("errMsg");
      var scounts = packet.data.findValueByName("scounts");
           
      if(retcode != "000000"){
        rdShowMessageDialog("У�鿨��ʧ�ܣ�������룺" + retcode + "��������Ϣ��" + retmsg,0);
        document.all.quchoose.disabled=true;
      }else{
      	if(scounts<=0) {
        rdShowMessageDialog("У�鿨��ʧ�ܣ�",0);
        document.all.quchoose.disabled=true;
 			 }else {
 	     		rdShowMessageDialog("У�鿨�ųɹ�",2);
	     		var danmoney = $("#danzhangmiane").val();
	     		var zongmoney=parseFloat(danmoney)*parseFloat(scounts).toFixed(2);;
	     		$("#infilling_number").val(scounts);
	     		$("#infilling_price").val(zongmoney);
	     		$('#oldbegin').attr("readonly","readonly");
	     		$('#oldend').attr("readonly","readonly");
	     		
	 				document.all.quchoose.disabled=false;
	 				document.all.comp.disabled=true;			 	
 			 }
      }
    }
    
     function changemoneys() {
        var danmoney = $("#danzhangmiane").val();
        var conutss=$("#infilling_number").val();
     		var zongmoney=parseFloat(danmoney)*parseFloat(conutss);;     		
     		$("#infilling_price").val(zongmoney);
     	}
    	
    
    function addcardinput() {
    	
			var scount=0;		   	
		  $("#dyntb2 tr").each(
		    function(){
		    	scount++;
			}
	    );
				
			if(scount==31) {
				alert("���ֻ����д30�ſ�����Ϣ��");
				return;
			}
			
    										var tr_str='';  
									         tr_str+="<tr><td  class='blue'>���мۿ�����</td><td ><input type='text' name='oldbegin"+quanjusum+"' id='oldbegin"+quanjusum+"'  v_must ='1'  onkeyup=this.value=this.value.replace(/\D/g,'') onafterpaste=this.value=this.value.replace(/\D/g,'') onBlur=setTdVals(this.value,'ssshengfen"+quanjusum+"')><font class='orange'>*</font></td>";  
									         tr_str+="<td  class='blue'>����</td><td ><input type='text' name='kami"+quanjusum+"' id='kami"+quanjusum+"' value='' size='19' v_must ='1'  /><font class='orange'>*</font></td><td class='blue'>��Ԫ��</td><td><select id='miane' name='miane' ><option value='zz'>--��ѡ��--</option><option value='10'>10</option><option value='20'>20</option><option value='30'>30</option><option value='50'>50</option><option value='100'>100</option><option value='200'>200</option><option value='300'>300</option><option value='500'>500</option></select><font class='orange'>*</font></td>";  
									         
									         tr_str+="<td  class='blue'> ����ʡ��</td><td><input type='text' readonly id='ssshengfen"+quanjusum+"' name='ssshengfen"+quanjusum+"' size='14' class=InputGrey >";  
									         tr_str+="&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' value='ɾ��' class='b_text' onClick='deletzhka(this)'></td></tr>";    
									         tr_str+="</tr>";  
									         $("#squerys").append(tr_str);  
									         quanjusum++; 
                
    }
    
     function deletzhka(k) {
 	  $(k).parent().parent().remove();  
 }
 
 
 function clearNoNum(obj){   obj.value = obj.value.replace(/[^\d.]/g,"");  //��������֡��͡�.��������ַ�  

 obj.value = obj.value.replace(/^\./g,"");  //��֤��һ���ַ������ֶ�����. 

  obj.value = obj.value.replace(/\.{2,}/g,"."); //ֻ������һ��. ��������.   

obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");

}  
		
	</script>
</HEAD>
<BODY >
	<FORM action="" method=post name="form1" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="loginAccept" id="loginAccept" value="<%=sysAccept%>"> 
	<input type="hidden" name="opflag" id="opflag">
	<input type="hidden" name="duiduansheng" id="duiduansheng">
	<input type="hidden" name="lisankahao" id="lisankahao">
	<input type="hidden" name="lisanjine" id="lisanjine">
	<input type="hidden" name="kami" id="kami">
	

        <table id=""  cellspacing="0" style="display:none">  	
        	  <tr>

			        		<td width=16% class="blue">��������</td>

			        		<td width=84% colspan="3">

			        			<input style="display:none" type="radio" name="opType"	value="simple"   onclick="changeType(this.value);" checked/>�������� &nbsp;&nbsp;

			        			<input type="radio" name="opType"	value="piliang"  onclick="changeType(this.value);"/>��ɢ���� &nbsp;&nbsp;

			        		</td>

        				</tr>
       </table>
       
       <table   cellspacing="0" >
       	<tr>
					        <td class='blue'>�ֻ�����</td>
					        <td>
								<input type="text" value="" name="phone_no" id="phone_no"    v_must ='1'/>
								<font class="orange">*</font>
					        </td>
					        <td class='blue'>�ͻ�����</td>
					        <td>
					        	<input type="text" value="" name="custnames" id="custnames" maxlength="30" v_must ='1' onblur="checkElement(this)"/>
					        	<font class="orange">*</font>
					        	</td>
					        </tr>
       	        	  <tr>
       	<tr>
					        <td class='blue'>֤������</td>
					        <td>
								<input type="text" value="" name="iccidhao" id="iccidhao"   v_must ='1'  onblur = "checkElement(this)"/>
								<font class="orange">*</font>
					        </td>
					        <td class='blue'>Ͷ�ߵ���</td>
					        <td>
					        	<input type="text" value="" name="tousudanhao" id="tousudanhao" maxlength="100"  onblur="checkElement(this)"/>
					        	</td>
					        </tr>

        				
        				  <tr>

			        		<td width=16% class="blue">�Ƿ�ο�</td>

			        		<td width=34% >
                       <select id="isgua" name="isgua">
                       	<option value="0">δ��</option>
                       	<option value="1">�ѹ�</option>
                       </select>
			        		</td>
			        		<td width=16% class="blue">�Ƿ��ʼ�</td>

			        		<td width=34% >
                       <select id="isyouji" name="isyouji">
                       	<option value="zz">--��ѡ��--</option>
                       	<option value="1">��</option>
                       	<option value="0">��</option>
                       </select>
                       <font class="orange">*</font>
			        		</td>
			        		
        				</tr>
        				 </table>
        				  <table id="dyntb" style="display:block">
        				       	        	  <tr>       	        	  	

			        		<td width=16% class="blue">�ɿ�ʼ����</td>

			        		<td width=34% >
                       <input type="text" name="oldbegin" id="oldbegin" value="" v_must ='1'  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onBlur="setTdVals(this.value,'suoshushengfen')">
                       <font class="orange">*</font>
			        		</td>
			        		<td width=16% class="blue">�ɽ�������</td>

			        		<td width=34% >
                       <input type="text" name="oldend" id="oldend" value="" v_must ='1' onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onBlur="setTdVals(this.value,'suoshushengfen')">
                       <font class="orange">*</font>
			        		</td>
			        		

        				</tr>
  
          				
        				 <tr>
                  <td width="16%" class="blue"> ������Ԫ��</td>
                  <td>
                    
                       <select id="danzhangmiane" name="danzhangmiane" onChange="changemoneys()">
                       	<option value="zz">--��ѡ��--</option>
                       	<option value="10">10</option>
                       	<option value="20">20</option>
                       	<option value="30">30</option>
                       	<option value="50">50</option>
                       	<option value="100">100</option>
                       	<option value="200">200</option>
                       	<option value="300">300</option>
                       	<option value="500">500</option>
                       </select>
                  </td>
                  <td width="16%" class="blue"> ����ʡ��</td>
                  <td>
  										<input type="text" readonly id="suoshushengfen" name="suoshushengfen" size="14" class=InputGrey >
                  </td>
         

                </tr>      				
        			
        				
              </table>

        				
   <table id="dyntb2"  cellspacing="0" style="display:none">
						   	<tr>
						   			<td  colspan="8"><input  name="addyjk" id="addyjk"  class="b_text" type=button value="���Ӿ��мۿ�����" onclick="addcardinput()"></td>
						   	</tr>
								<tr>
			        		<td  class="blue">���мۿ�����</td>

			        		<td >
                       <input type="text" name="oldbeginjiu" id="oldbeginjiu" value="" size="19" v_must ='1'  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onBlur="setTdVals(this.value,'ssshengfen')" />
                       <font class="orange">*</font>
			        		</td>
			        		<td  class="blue">����</td>
			        		<td >
                       <input type="text" name="kamiss" id="kamiss" value="" size="19" v_must ='1'  />
                       <font class="orange">*</font>
			        		</td>
			        		<td class="blue">��Ԫ��</td>

			        		<td>                   
                   		  <select id="miane" name="miane" >
                   		 <option value="zz">--��ѡ��--</option>
                       	<option value="10">10</option>
                       	<option value="20">20</option>
                       	<option value="30">30</option>
                       	<option value="50">50</option>
                       	<option value="100">100</option>
                       	<option value="200">200</option>
                       	<option value="300">300</option>
                       	<option value="500">500</option>
                       </select><font class="orange">*</font>
			        		</td>
			        		

                  <td width="16%" class="blue"> ����ʡ��</td>
                  <td >
  										<input type="text" readonly id="ssshengfen" name="ssshengfen" size="19" class=InputGrey />
                  </td>
         

                </tr>      				
        				
									<tbody id="squerys">
	                </tbody>
         

      </table>
      <table   cellspacing="0" >
              				  <tr>
                  <td width="16%" class="blue"> �мۿ�����</td>
                  <td>
                     <input type="text" readonly id="infilling_number" name="infilling_number" size="14" value="0" class=InputGrey />
                  </td>
                  <td width="16%" class="blue"> �ܽ�� </td>
                  <td colspan="3">
                      <input type="text"  id="infilling_price" name="infilling_price" size="14" value="0" class=InputGrey />
                  </td>
                  </tr> 

        </table>				       	
     
             <table cellspacing="0">
              	<tbody>
              		<tr>
                		<td id="footer">
                			              <input  name="comp" class="b_foot" type=button value=��֤ onclick="checkcards()" />
                                    <input  name="quchoose" id="quchoose" class="b_foot" type=button value=ȷ��&��ӡ  onclick="doCommit()" disabled>
                                    &nbsp;
                                  	<input  name="clear" class="b_foot" type=reset value=��� onclick="doclear()">
                                  	&nbsp;                  			

                		</td>
              		</tr>
              </tbody>
            </table>
	     <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

