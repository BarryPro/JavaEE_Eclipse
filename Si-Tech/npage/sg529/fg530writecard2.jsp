<%
    /*************************************
    * ��  ��: ��ȡ����ѡ��SIM�� e964
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-7-6
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
		System.out.println("gaopengSeeLog===============opCode=+"+opCode);
    String opName=request.getParameter("opName");
    String loginNo = (String)session.getAttribute("workNo");
    String password = (String)session.getAttribute("password");
    String work_name =(String)session.getAttribute("workName");
    String workNo = (String)session.getAttribute("workNo");
    
    
    String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String phoneNO = WtcUtil.repNull((String)request.getParameter("phoneNO"));
		String kehuxingming = WtcUtil.repNull((String)request.getParameter("kehuxingming"));
		String zhengjianmingcheng = WtcUtil.repNull((String)request.getParameter("zhengjianmingcheng"));
		String zhengjianhaoma = WtcUtil.repNull((String)request.getParameter("zhengjianhaoma"));
		String simming = WtcUtil.repNull((String)request.getParameter("simming"));
		String dingdanzhuangtai = WtcUtil.repNull((String)request.getParameter("dingdanzhuangtai"));
		String yonghupinpai = WtcUtil.repNull((String)request.getParameter("yonghupinpai"));
		String haomaguishu = WtcUtil.repNull((String)request.getParameter("haomaguishu"));
		String kehudizhi = WtcUtil.repNull((String)request.getParameter("kehudizhi"));

		String simnono = WtcUtil.repNull((String)request.getParameter("simnono"));
		String simstypes = WtcUtil.repNull((String)request.getParameter("simtype"));
		
		String groupids = WtcUtil.repNull((String)request.getParameter("groupids"));
		String yonghubianma = WtcUtil.repNull((String)request.getParameter("yonghubianma"));
		
		String offerids = WtcUtil.repNull((String)request.getParameter("offerids"));
		String offernames = WtcUtil.repNull((String)request.getParameter("offernames"));
		String offfercomments = WtcUtil.repNull((String)request.getParameter("offfercomments"));
		String simResBrandCode ="";
%>  
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
		<wtc:service name="sG842Chk" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
	    <wtc:param value="<%=loginAccept%>"/>
	    <wtc:param value="01"/>
	    <wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=password%>"/>
	 		<wtc:param value="<%=phoneNO%>"/>
			<wtc:param value=""/>
			<wtc:param value="��ѯ�˺����Ƿ��Ѿ�д���ɹ���"/>		
	</wtc:service>				
		<wtc:array id="dcust2s" scope="end" />	
			

<%

String kongkakahao="";
String biaozhiwei="";/*0��д���ɹ�ֱ�ӵ���ȷ�Ϸ��񼴿ɣ�1��δд���ɹ�����Ҫ�������̲���*/
if(retCode2.equals("000000")) {
		if(dcust2s.length>0) {
				biaozhiwei=dcust2s[0][0];
				kongkakahao=dcust2s[0][1];
		}
}
//biaozhiwei="0";
//kongkakahao="0806001650003224";
System.out.println("�Ƿ��Ѿ�д���ɹ�"+biaozhiwei);
System.out.println("�տ�����"+kongkakahao);


	/*2014/05/26 11:10:47 gaopeng ������ʡ������ѡ�š��͡�18Ԫ�׿�ʡ�ڰ桱����SIM������ѡ���ܵ����� ����sql����ѯ����*/
	/*gaopeng 2014/05/26 11:07:39 ������ʡ������ѡ�š��͡�18Ԫ�׿�ʡ�ڰ桱����SIM������ѡ���ܵ����� ��ѯsql �����K06 �ٽ���У��*/
	String simResSql = "select brand_code from srescode where res_code = '"+simstypes+"'";
%>	
	<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCodeRes" retmsg="retMsgRes">
		<wtc:sql><%=simResSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultRes" scope="end"/>

<%
	if(resultRes.length > 0 && "000000".equals(retCodeRes)){
		simResBrandCode = resultRes[0][0];
		System.out.println("gaopengSeeLog===simResBrandCode="+simResBrandCode);
	}
%>

<HTML>
<HEAD>
    <TITLE>�����ۿ�����-д��</TITLE>
<script language="javascript">
 	function goBack(){
	  window.location.href="fg530writecard.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
</script>
</HEAD>
<body>
<form name="frme964" method="post" >
 	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
 	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
	<%@ include file="/npage/include/header.jsp" %>
  <div class="title">
    <div id="title_zi">�û���Ϣ</div>
  </div>
	<table>
		<tr>
						<td class="blue" width="15%">�ͻ�����</td>
			<td width="15%">
				<%=kehuxingming%>
			</td>
		  <td class="blue" width="15%">�������</td>
			<td>
				<%=phoneNO%>
			</td>
					 <td class="blue" width="15%">�û�Ʒ��</td>
			<td>
				���еش�
			</td>
			<tr>
		  <td class="blue" width="15%">�û�����</td>
			<td>
				<%=yonghubianma%>
			</td>
				<td class="blue" width="15%">֤������</td>
			<td>
				<%=zhengjianmingcheng%>
			</td>
	
		  <td class="blue" width="15%">֤������</td>
			<td>
				<%=zhengjianhaoma%>
			</td>

		</tr>
		<tr>
						<td class="blue" width="15%">sim����</td>
			<td>
				<%=simming%>
			</td>
					  <td class="blue" width="15%">�������</td>
			<td>
				<%=haomaguishu%>
			</td>
		   <td class="blue" width="15%">����״̬</td>
			<td>
			<%if(dingdanzhuangtai.equals("1")) {out.print("����δ֧��");}if(dingdanzhuangtai.equals("2")) {out.print("����֧���ɹ�");}if(dingdanzhuangtai.equals("3")) {out.print("�������ʼ�");}if(dingdanzhuangtai.equals("4")) {out.print("������ʱ");}%>
				
			</td>


		</tr>
		<tr>
			<td class="blue" width="15%">�ͻ���ַ</td>
			<td colspan="6">
				<%=kehudizhi%>
			</td>
		</tr>
		<tr>
      <td colspan="6">
        <hr>
      </td>
    </tr>
    <tr>
			<td class="blue" width="15%">sim����</td>
			<td colspan="6">
			  <div align="left">
			    <%=simnono%>
          <font color="red">*</font>
           <input class="b_text" type="button" name="ducard" value="����" onClick="readcardss()"  index="19"  <%if(biaozhiwei.equals("0")){%> disabled<%}%>/>
           <input class="b_text" type="button" name="b_write" value="д��" onmouseup="writechg(this)" onkeyup="if(event.keyCode==13)writechg()"  index="19"  disabled/>
          <input type="hidden" name="flg_normal" id="flg_normal" value="0">
        </div>
			</td>
		</tr>
		<tr > 
			  <td colspan="6" align="center" id="footer">
			  				<input class="b_foot" name="gengxins" onClick="gengxinsj()" type="button" value="����SIM��Ϣ" disabled/>
			&nbsp;  
						<input class="b_foot" name="resultcommit" onClick="addresult()" type="button" value="ȷ��&��ӡ"   <%if(!biaozhiwei.equals("0")){%> disabled<%}%>/>
			&nbsp; 
			<input class="b_foot" name="back" onClick="goBack()" type="button" value="����" />
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�" />
			&nbsp;
			</td>
		</tr>
	</table>
</div>

<input type="hidden" name="cardNo" id="cardNo" value=""  />


  <%@ include file="/npage/include/footer.jsp" %>
</form>
<script language="javascript">
	var simtypess="";
	function readcardss() {
//document.all.b_write.disabled=false;
  		 var phone = '<%=phoneNO%>';
  		 simtypess="";
  		 /****���������ƹ���ȡSIM������****/
  		 /* 
        * diling update for �޸�Ӫҵϵͳ����Զ��д��ϵͳ�ķ��ʵ�ַ�������ڵ�10.110.0.125��ַ�޸ĳ�10.110.0.100��@2012/6/4
        */
  		 path ="http://10.110.0.100:33000/writecard/writecard/ReadCardInfo.jsp";
  		 var retInfo1 = window.showModalDialog("Trans.html",path,"","dialogWidth:10;dialogHeight:10;"); 
		 if(typeof(retInfo1) == "undefined")     
    	 {	
    		 rdShowMessageDialog("�������ͳ���!");

    		return false;   
    	 }
    	var chPos;
    	chPosn = retInfo1.indexOf("&");
    	if(chPosn < 0)
    	{	
    		rdShowMessageDialog("�������ͳ���!");
    		return false ;	
    	} 
    	retInfo1=retInfo1+"&";
    	var retVal=new Array();   
    	for(i=0;i<4;i++)
    	{   	   
    		var chPos = retInfo1.indexOf("&");
        	valueStr = retInfo1.substring(0,chPos);
        	var chPos1 = valueStr.indexOf("=");
        	valueStr1 = valueStr.substring(chPos1+1);
        	retInfo1 = retInfo1.substring(chPos+1);
        	retVal[i]=valueStr1;
        	
    	} 
    	if(retVal[0]=="0")
    	{
    		var rescode_str=retVal[2]+"|";
    		var rescode_strstr="";
    		var chPosm = rescode_str.indexOf("|");
    		for(i=0;i<4;i++)
    		{   	   
    	
    			var chPos1 = rescode_str.indexOf("|");
        		valueStr = rescode_str.substring(0,chPos1);
        		rescode_str = rescode_str.substring(chPos1+1);
        		if(i==0 && valueStr=="")
        		{
        			rdShowMessageDialog("�������ͳ���!");

    		 		  return false;
        		}
        		if(valueStr!=""){
        			rescode_strstr=rescode_strstr+"'"+valueStr+"'"+",";
        		}
        	
    		} 
    		rescode_strstr=rescode_strstr.substring(0,rescode_strstr.length-1);
    		if(rescode_strstr=="")
    		{
    			rdShowMessageDialog("�������ͳ���!");

    		 	return false;   
    		}
  		}
  		else{
  			 rdShowMessageDialog("�������ͳ���!");

    		 return false;   
    	}
    	simtypess=rescode_strstr.substr(1,rescode_strstr.length-2);
    	 document.all.b_write.disabled=false;
    }
  function writechg(obj){

		if("<%=simResBrandCode%>"=="K06" && "<%=simstypes%>" != simtypess){
			rdShowMessageDialog("��վ�ṩ��sim�����������sim�����Ͳ�ƥ��,������д����",0);
	    return false;   
		}
		
		var phonenos="";
		var simnos="";
		var simtypes="";
		var groupids="";
		var phonesnames="";
		var smssarry= new Array();

		//lert('<%=regionCode%>'+"-"+'<%=simstypes%>'+"-"+'<%=simnono%>'+"-"+'<%=opCode%>'+"-"+'<%=phoneNO%>');
		
    var path = "<%=request.getContextPath()%>/npage/sg529/fg529_fwritecard.jsp";
    path = path + "?regioncode=" + "<%=regionCode%>";
    path = path + "&sim_type=" +simtypess;
    path = path + "&sim_no=" +"<%=simnono%>";
    path = path + "&op_code=" +"<%=opCode%>";
    path = path + "&phone="+"<%=phoneNO%>"+"&pageTitle=" + "д��";
    path = path + "&deleteShowCardNoFlag=" +"isDelCardNo"; 
    var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    
    if(typeof(retInfo) == "undefined"){	
    	rdShowMessageDialog("д��ʧ��",0);
    	 //document.all.b_write.disabled=false;
    	   document.frme964.gengxins.disabled=false;
    	return false;   
    } 
    var retsimcode=oneTok(oneTok(retInfo,"|",1));
    var retsimno=oneTok(oneTok(retInfo,"|",2));
    var cardstatus=oneTok(oneTok(retInfo,"|",3));
    var cardNo=oneTok(oneTok(retInfo,"|",4));
    $("#cardNo").val(cardNo);
   
    /*
    var retsimcode="0";
    var retsimno="89860070089810966258";
    var cardstatus="00";
    var cardNo="0806001650003224";
    
     */
    if(retsimcode=="0"){
      rdShowMessageDialog("д���ɹ�");
  	 document.frme964.resultcommit.disabled=false;
		
    }else{
      
      rdShowMessageDialog("д��ʧ��,0");
      //document.all.b_write.disabled=false;
        document.frme964.gengxins.disabled=false;
    }
  }
  
  function addresult() {
			var cadnos = $("#cardNo").val();
			var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/sg529/fg530writecardsub.jsp","�������д����Ϣ���Ժ�......");
			
			<%
			if(biaozhiwei.equals("0")){
			%> 
			myPacket.data.add("cardNo","<%=kongkakahao%>");
			<%
		  }else {
		  %> 
			myPacket.data.add("cardNo",cadnos);
		  <%			
			}
			%>

		myPacket.data.add("simtypes",'<%=simstypes%>');
		myPacket.data.add("simnos",'<%=simnono%>');
		myPacket.data.add("phonenos",'<%=phoneNO%>');
		myPacket.data.add("opcode",'g530');
		myPacket.data.add("groupids",'<%=groupids%>');
		myPacket.data.add("phonesnames",'<%=kehuxingming%>');
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
		
	}
	
		function gengxinsj() {
		var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/sg603/fg603Update.jsp","���ڸ���sim��Ϣ���Ժ�......");
		myPacket.data.add("phonenos",'<%=phoneNO%>');
		myPacket.data.add("opcode",'g530');
		core.ajax.sendPacket(myPacket,doreturnmsgs);
		myPacket = null;
	}
	
	function doreturnmsgs(packet){
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		if(retcode=="000000"){
			rdShowMessageDialog("���ݸ��³ɹ��������²�����",2);
			goBack();
		}else {
			rdShowMessageDialog("���ݸ���ʧ�ܣ��������"+retcode+"������ԭ��"+retmsg,0);
		}
	}
	
	

				function doSetStsDate(packet){
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		if(retcode=="000000"){
						    var ret =showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
    //return false;
    if(typeof(ret)!="undefined"){
      if((ret=="confirm")){
        if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1){
         // frmCfm();
        }
      }
      if(ret=="continueSub"){
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
        //  frmCfm();
        }
      }
    }else{
      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
       // frmCfm();
      }
    }
		
				 rdShowMessageDialog("����ɹ�����ʼ��ӡ��Ʊ��");
				 var liushui1 = packet.data.findValueByName("liushui");
				 var phonesno = packet.data.findValueByName("phonesno");
				 // alert(liushui1);
				  // alert(phonesno);
				
				 billdeal(phonesno,'<%=kehuxingming%>',liushui1);
				// location = location;
			
		}else {
				 rdShowMessageDialog("����ʧ�ܣ��������"+retcode+"������ԭ��"+retmsg,0);
		}
		//document.all.b_write.disabled=false;//д���ɹ����ύ
	}						  	

		function doreturn(){
			window.location.href = "fg530writecard.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			//location = location;
			
		}
		
		function billdeal(phoneno,phonenames,liushui){
		 var  billArgsObj = new Object();
	 		$(billArgsObj).attr("10001","<%=workNo%>");       //����
	 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	 		$(billArgsObj).attr("10005",phonenames); //�ͻ�����
	 		$(billArgsObj).attr("10006","��ͨ����"); //ҵ�����
	 		$(billArgsObj).attr("10008",phoneno); //�û�����
	 		$(billArgsObj).attr("10015", "50"); //���η�Ʊ���(Сд)��
	 		$(billArgsObj).attr("10016", "50"); //��д���ϼ�
	 		var sumtypes1="*";
	 		$(billArgsObj).attr("10017",sumtypes1); //���νɷ��ֽ�
	 		$(billArgsObj).attr("10025","50"); //Ԥ�滰��
	 		$(billArgsObj).attr("10030",liushui); //��ˮ��--ҵ����ˮ
	 		$(billArgsObj).attr("10036","<%=opCode%>"); //��������
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=ȷʵҪ���з�Ʊ��ӡ��";
			
			
			//��Ʊ��Ŀ�޸�Ϊ��·��
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=ȷʵҪ���з�Ʊ��ӡ��";
	
			var loginAccept = liushui;
			var path = path +"&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
			location="/npage/sg529/fg530writecard.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
}

   
  
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  
  		var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     		var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
		var sysAccept ="<%=loginAccept%>";                       // ��ˮ��
		var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
		var mode_code=null;                        //�ʷѴ���
		var fav_code=null;                         //�ط�����
		var area_code=null;                    //С������
		var opCode =   "<%=opCode%>";                         //��������
		var phoneNo = "<%=phoneNO%>";                         //�ͻ��绰		  
  
	  	//��ʾ��ӡ�Ի���
	    	var h=200;
	    	var w=410;
	     	var t=screen.availHeight/2-h/2;
	     	var l=screen.availWidth/2-w/2;
	     	
	     	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
	   	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);     	
  }
  
  
 
 function printInfo(printType)
{
   
 
	   var retInfo = "";
    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";
    
    cust_info+="�ͻ�������<%=kehuxingming%>	"+"|";
    cust_info+="�ֻ����룺<%=phoneNO%>	"+"|";
    cust_info+="֤�����룺<%=zhengjianhaoma%>"+"|";
    cust_info+="�ͻ���ַ��<%=kehudizhi%>"+"|";
    
			opr_info+="ҵ������ʱ�䣺<%=cccTime%>   "  +"�û�Ʒ��:"+"���еش�"+"|";
			opr_info+="����ҵ����ͨ����"+"  "+"������ˮ��<%=loginAccept%>"+"|";
			
    opr_info+="SIM���ţ�"+"<%=simnono%>"+""+"  SIM���ѣ�0Ԫ"+"|";
    opr_info+="Ԥ��"+"50Ԫ"+"|";
    opr_info+="���ʷѣ�"+"<%=offerids%>-<%=offernames%>"+"|";
    
    note_info1+="���ʷ�������"+"<%=offfercomments%>"+"|";
    note_info1+="��ע������Ա"+"<%=workNo%>"+""+"�Կͻ�"+"<%=phoneNO%>"+"�������������ۿ�д������!"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
		
} 
</script>
</BODY>
</HTML>

