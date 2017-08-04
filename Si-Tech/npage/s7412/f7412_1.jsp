<%
    /********************
     * @ OpCode    :  7421
     * @ OpName    :  ����100ҵ�������
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2009-10-28
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.text.*"%>

<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
    
    String opCode = "7421";
    String opName = "����100ҵ�������";
    
    String regionCode   = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String workNo       = WtcUtil.repNull((String)session.getAttribute("workNo"));   //����	
    String workName     = WtcUtil.repNull((String)session.getAttribute("workName"));
    
    /* ȡ������ˮ */
    String loginAccept = "";
    %>
        <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
    <%
    loginAccept = seq;
%>	
<head>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<title><%=opName%></title>
<script  type="text/javascript">
		var btnId = ""; //yuanqs add 2010/9/2 16:33:21
		
		var nztFlag = "Y"; /*diling add for ���ڿ������Ų�Ʒ����Ӫ��������*/
		
    /* ��ѯ������Ϣ */
    function getInfo_Cust(){
        var pageTitle = "����100���ſͻ�ѡ��";
        var fieldName = "֤������|�ͻ�ID|�ͻ�����|���ű���|��������|������|group_id|";
        var sqlStr = "";
        var selType = "S";    //'S'��ѡ��'M'��ѡ
        var retQuence = "7|0|1|2|3|4|5|6|";
        var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|group_id|";
        var cust_id = document.frm.cust_id.value;
        
        if(document.frm.iccid.value == "" &&
        document.frm.cust_id.value == "" &&
        document.frm.unit_id.value == ""){
            rdShowMessageDialog("������֤�����롢���ſͻ�ID���ű�����в�ѯ��",0);
            document.frm.iccid.focus();
            return false;
        }
        var iccid=document.frm.iccid.value;
        result=cust_id.match(/^\d{10,14}$/g);
        if(document.frm.cust_id.value != "" && result==null){
            document.frm.cust_id.value = "";
            document.frm.cust_id.focus();
            rdShowMessageDialog("���ſͻ�ID������[10-14]λ�����֣�",0);
            return false;
        }
        var unit_id=document.frm.unit_id.value;
        result=unit_id.match(/^\d{10,14}$/g);
        if(document.frm.unit_id.value != "" && result==null){
            document.frm.unit_id.value = "";
            document.frm.unit_id.focus();
            rdShowMessageDialog("���ű��������[10-14]λ�����֣�",0);
            return false;
        }
        
        if(PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    }
    
    function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField){
        var path = "<%=request.getContextPath()%>/npage/s7412/fpubcust_sel.jsp";
        path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
        path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
        path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
        path = path + "&cust_id=" + document.all.cust_id.value;
        path = path + "&unit_id=" + document.all.unit_id.value;
        retInfo = window.open(path,"newwindow","height=450, width=850,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
    	return true;
    }  
    
    function getvaluecust(retInfo){
        var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|group_id|";
        if(retInfo ==undefined){
            return false;
        }
        
        var chPos_field = retToField.indexOf("|");
        var chPos_retStr;
        var valueStr;
        var obj;
        while(chPos_field > -1){
            obj = retToField.substring(0,chPos_field);
            chPos_retInfo = retInfo.indexOf("|");
            valueStr = retInfo.substring(0,chPos_retInfo);
            document.all(obj).value = valueStr;
            retToField = retToField.substring(chPos_field + 1);
            retInfo = retInfo.substring(chPos_retInfo + 1);
            chPos_field = retToField.indexOf("|");
        }
        document.all.grp_name.value = document.all.unit_name.value;
        
        checkCust();
    }

    function checkCust(){
        vCustId = $("#cust_id").val();
        
        var packet = new AJAXPacket("custCheck.jsp","���Ժ�...");
        packet.data.add("custId",vCustId);
        core.ajax.sendPacket(packet,doCheckCust,false);
        packet = null;
    }

    function doCheckCust(packet){
        var errCode = packet.data.findValueByName("retCode");
        var errMsg = packet.data.findValueByName("retMsg");
        var cnt = packet.data.findValueByName("cnt");
        
        if(errCode == "000000"){
            if(cnt > 0){
                rdShowMessageDialog("�ÿͻ��Ѿ������˶���100��Ʒ��������Ч�ڣ������ٴΰ���",0);
                window.location.href="f7412_1.jsp";
            }
        }else{
            rdShowMessageDialog("������룺"+errCode+",������Ϣ��"+errMsg,0);
            window.location.href="f7412_1.jsp";
        }
    }

    function oporSubProd(motive_code){
        //win.close();
        var h=480;
        var w=650;
        var t=screen.availHeight/2-h/2;
        var l=screen.availWidth/2-w/2;
        var prop="dialogHeight= "+300+"px; dialogWidth= "+500+"px; dialogLeft= "+l+"px; dialogTop= "+t+"px;toolbar=no; menubar= no; scrollbars yes; resizable no;location no;status no";
        window.open("f7412_list.jsp?motive_code="+motive_code,"_blank","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
    }
    /*chendx update ���DL100���ڵ�ȫ��ҵ�����߰�ǰ���������Ƿ�ʽ������ҵ��һ��*/
    function set_Attribute(retArr,motive_code){
        var vSmCodeList = $("#product_type").val() + "~";
        var vSmNameList = "����100" + "~";
        var vProCodeList = $("#motive_code").val() + "~";
        var vProNameList = $("#motive_name").val() + "~";
        var vLocalFlagList = "N" + "~";
        var vPackageFlagList = "Y" + "~";
        var vBbossFlagList = "N" + "~";
        var vTotalCount = retArr.length;
        if (retArr !=null) {
            for(var i=1;i<retArr.length;i++){
                if(retArr[i]!=null){
                    vSmCodeList = vSmCodeList + retArr[i][1] + '~';
                    vSmNameList = vSmNameList + retArr[i][3] + '~';
                    vProCodeList = vProCodeList + retArr[i][0] + '~';
                    vProNameList = vProNameList  + retArr[i][4] + '~';
                    vPackageFlagList = vPackageFlagList + 'Y' + '~';                  
                    if(retArr[i][2] == 'N'){ 
                        vLocalFlagList = vLocalFlagList + 'Y' + '~';
                        vBbossFlagList = vBbossFlagList + 'N' + '~';
                    }else{
                    	  if(retArr[i][1] == 'M4'){ 	 
                    	  		vLocalFlagList = vLocalFlagList + 'Y' + '~';
                    	  		vBbossFlagList = vBbossFlagList + 'N' + '~';                   	  
                    	  }else{
                        	vLocalFlagList = vLocalFlagList + 'N' + '~';
                        	vBbossFlagList = vBbossFlagList + 'Y' + '~';
                        }
                    }

                }else{
                    vTotalCount--;
                }
            }
        }
        
        var vCustId = $("#cust_id").val();
        
        var packet = new AJAXPacket("splitDL100.jsp","���Ժ�...");
        packet.data.add("loginAccept","<%=loginAccept%>");
        packet.data.add("opCode","<%=opCode%>");
        packet.data.add("totalCount",vTotalCount);
        packet.data.add("smCodeList" ,vSmCodeList);
        packet.data.add("smNameList" ,vSmNameList);
        packet.data.add("proCodeList",vProCodeList);
        packet.data.add("proNameList",vProNameList);
        packet.data.add("packageFlagList",vPackageFlagList);
        packet.data.add("bbossFlagList",vBbossFlagList);
        packet.data.add("localFlagList",vLocalFlagList);
        packet.data.add("custId",vCustId);
        core.ajax.sendPacket(packet,doSetAttribute,true);
        packet = null;
    }

    function doSetAttribute(packet){
        var errCode = packet.data.findValueByName("errCode");
        var errMsg = packet.data.findValueByName("errMsg");
        if(errCode != "000000"){
            rdShowMessageDialog("������룺"+errCode+"<br/>������Ϣ��"+errMsg,0);
            window.location = "f7412_1.jsp";
        }else{
            var vProCodeList = packet.data.findValueByName("proCodeList");
            var vProNameList = packet.data.findValueByName("proNameList");
            var vSmCodeList = packet.data.findValueByName("smCodeList");
            var vSmNameList = packet.data.findValueByName("smNameList");
            var vTotalCount = packet.data.findValueByName("totalCount");
            var vLoginAcceptList = packet.data.findValueByName("loginAcceptList");
            var vChildAcceptList = packet.data.findValueByName("childAcceptList");
            var vBbossFlagList = packet.data.findValueByName("bbossFlagList");
            
            var vProCodeArr = vProCodeList.split("~");
            var vProNameArr = vProNameList.split("~");
            var vSmCodeArr = vSmCodeList.split("~");
            var vSmNameArr = vSmNameList.split("~");
            var vLoginAcceptArr = vLoginAcceptList.split("~");
            var vChildAcceptArr = vChildAcceptList.split("~");
            var vBbossFlagArr = vBbossFlagList.split("~");
             //alert("vSmCodeArr="+vSmCodeArr);
            var vLen = vSmCodeArr.length;
            if(vLen<3){
                rdShowMessageDialog("����100�����ò�������������������",0);
                window.location = "f7412_1.jsp";
                return false;
            }
            
            /*diling add for ���ڿ������Ų�Ʒ����Ӫ�������� */
            judgeForNzt(vSmCodeList,vProCodeList);
            
            if(nztFlag=="N"){
               rdShowMessageDialog("���û�û�ж���ũ��ͨҵ�񣡲��ܶ�����ҵ��",0);
                window.location.href="f7412_1.jsp";
                return false;
            }
              $("#taskListFlag").css("display","");
              //$("#taskListFlag").fadeIn(1000);
              //$("#taskListFlag").slideDown("slow");
              $("#iccid,#cust_id,#unit_id,#cust_name,#motive_info").attr("readOnly",true);
              $("#iccid,#cust_id,#unit_id,#cust_name,#motive_info").addClass("InputGrey");
              $("#qry_spbiz").attr("disabled",true);
              
              var strTemp1 = "<tr>"
                          + "<td>"
                          + "����100"
                          + "</td>"
                          + "<td>"
                          + $("#motive_code").val()
                          + "</td>"
                          + "<td>"
                          + $("#motive_name").val()
                          + "</td>"
                          + "<td>"
                          + "��ѡ��"
                          + "</td>"
                          + "<td>"
                          + "��ѡ��"
                          + "</td>"
                          + "<td>"
                          + "<input type='button' id='taskBtn0' name='taskBtn0' class='b_text' value='����' onClick='toReceive(\"N\",\"taskBtn0\",\""+$("#product_type").val()+"\",\"\",\""+vLoginAcceptArr[0]+"\",\""+vChildAcceptArr[0]+"\",\"&sm_code="+$("#product_type").val()+"&in_productCode="+$("#motive_code").val()+"&in_productName="+$("#motive_name").val()+"&in_bizCode="+$("#pkg_code").val()+"&in_bizName="+$("#pkg_name").val()+"&in_loginAccept="+vLoginAcceptArr[0]+"&in_childAccept="+vChildAcceptArr[0]+"&in_count="+vSmCodeArr.length+"&catalog_item_id="+$("#catalog_item_id").val()+"\")'/>"
                          + "</td>"
                          + "</tr>" ;
              $("#taskList").append(strTemp1);
             
              if (vSmCodeArr !=null) {
                  for(var i=1;i<vSmCodeArr.length-1;i++){
                      var tdClass = "";
                      if (i%2 != 0){
                          tdClass = "Grey";
                      }
                      
                      var productCodeInfo = "";
                      if(vSmCodeArr[i] == 'AD' || vSmCodeArr[i] == 'ML' || vBbossFlagArr[i] == 'Y'){
                          productCodeInfo = vProCodeArr[i];
                      }else{
                          productCodeInfo = "��ѡ��";
                      }
                      
                      var productNameInfo = "";
                      if(vSmCodeArr[i] == 'AD' || vSmCodeArr[i] == 'ML' || vBbossFlagArr[i] == 'Y'){
                          productNameInfo = vProNameArr[i];
                      }else{
                          productNameInfo = "��ѡ��";
                      }
                      
                      var strTemp2 = "<tr>"
                                  + "<td class='"+tdClass+"'>"
                                  + vSmNameArr[i]
                                  + "</td>"
                                  + "<td class='"+tdClass+"'>"
                                  + "��ѡ��"
                                  + "</td>"
                                  + "<td class='"+tdClass+"'>"
                                  + "��ѡ��"
                                  + "</td>"
                                  + "<td class='"+tdClass+"'>"
                                  + productCodeInfo
                                  + "</td>"
                                  + "<td class='"+tdClass+"'>"
                                  + productNameInfo
                                  + "</td>"
                                  + "<td class='"+tdClass+"'>"
                                  + "<input type='button' id='taskBtn"+i+"' name='taskBtn"+i+"' class='b_text' value='����' onClick='toReceive(\""+vBbossFlagArr[i]+"\",\"taskBtn"+i+"\",\""+vSmCodeArr[i]+"\",\""+productCodeInfo+"\",\""+vLoginAcceptArr[i]+"\",\""+vChildAcceptArr[i]+"\",\"&sm_code="+vSmCodeArr[i]+"&in_productCode=&in_productName=&in_bizCode="+productCodeInfo+"&in_bizName="+productNameInfo+"&in_loginAccept="+vLoginAcceptArr[i]+"&in_childAccept="+vChildAcceptArr[i]+"&in_count="+vSmCodeArr.length+"&catalog_item_id=\")'/>"
                                  + "</td>"
                                  + "</tr>" ;
                      $("#taskList").append(strTemp2);
                  }
              }
        }
    }
    
    /***begin add by diling for ���ڿ������Ų�Ʒ����Ӫ��������***/
    function judgeForNzt(vSmCodeList,vProCodeList){
      var unit_id = $("#unit_id").val();
      var packet = new AJAXPacket("f7412_ajax_judgeForNzt.jsp","���Ժ�...");
      packet.data.add("vSmCodeList",vSmCodeList);
      packet.data.add("vProCodeList",vProCodeList);
      packet.data.add("unit_id",unit_id);
      core.ajax.sendPacket(packet,doJudgeForNzt);
      packet =null;
    }
    
    function doJudgeForNzt(packet){
      var nztBussFlag = packet.data.findValueByName("nztBussFlag"); 
      nztFlag = nztBussFlag;
    }
    
     /***end add by diling for ���ڿ������Ų�Ʒ����Ӫ��������***/

    /* �������ʱ����,������Ϣ(��ǰ���հ�ťID,Ʒ��,ҵ�����,URL) */
    function toReceive(bBossFlag,taskBtnId,taskSmCode,taskBizCode,pLoginAccept,pChildAccept,taskUrl){	
    	  $("#"+taskBtnId).attr("disabled",true);//yuanqs add 2010-9-1 15:04:19 
        var vCustId = $("#cust_id").val();
        $("#task_url").val(taskUrl);
        
        var packet = new AJAXPacket("custCount.jsp","���Ժ�...");
        packet.data.add("taskBtnId",taskBtnId);
        packet.data.add("taskSmCode",taskSmCode);
        packet.data.add("taskBizCode",taskBizCode);
        packet.data.add("custId",vCustId);
        packet.data.add("loginAccept",pLoginAccept);
        packet.data.add("childAccept",pChildAccept);
        packet.data.add("bBossFlag",bBossFlag);
        core.ajax.sendPacket(packet,doToReceive,true);
        packet =null;
    }
    
    /* ����AJAX����toReceive() */
    function doToReceive(packet){
        var retCode     = packet.data.findValueByName("retCode"); 
        var retMsg      = packet.data.findValueByName("retMsg"); 
        var vCustCnt    = packet.data.findValueByName("custCnt");
        var vSmCode     = packet.data.findValueByName("taskSmCode");
        var vBtnId      = packet.data.findValueByName("taskBtnId");
        var vBizCode    = packet.data.findValueByName("taskBizCode");
        var vLoginAccept= packet.data.findValueByName("loginAccept");
        var vChildAccept= packet.data.findValueByName("childAccept");
        var vBbossFlag  = packet.data.findValueByName("bBossFlag");
        var vUrl        = $("#task_url").val();
				btnId = vBtnId; //yuanqs add 2010/9/2 16:33:49
        if(retCode == "000000"){
            if(vBbossFlag == 'N'){
            		if(vSmCode == "M4"){
            			if(vCustCnt == "0"){ /* ������û���ƶ�400�Ŀͻ���Ϣ */
										rdShowMessageDialog("���ǰ�����ƶ�400ҵ��",0);
										return false;
                	}else{ /* �����´����ƶ�400�Ŀͻ���Ϣ */
                    selectCust(vSmCode,vBizCode,vBtnId,vLoginAccept,vChildAccept,vBbossFlag);
                	 }
								}else if(vCustCnt == "0"){
                    var taskUrl = "../s3690/f3690_1.jsp?openFlag=DL100&inIccid="+$("#iccid").val()+"&inCustId="+$("#cust_id").val()+"&inUnitId="+$("#unit_id").val()+"&inCustName="+$("#cust_name").val()+"&inBelongCode="+$("#belong_code").val()+"&btn_id="+vBtnId+vUrl; //yuanqs add btn_id���� 2010/9/6 10:30:15 
                    //javascript:topage('1111','000','1','�������',taskUrl);
                    window.open(taskUrl,'_blank','height=600,width=900,left=10,top=10,resizable=yes,scrollbars=yes');
                    $("#task_url").val("");
                }else{ /* �����´��ڸ�Ʒ�ƵĿͻ���Ϣ */
                    selectCust(vSmCode,vBizCode,vBtnId,vLoginAccept,vChildAccept,vBbossFlag);
                }
            }else{         		
                var taskUrl = "s2002/f2029_1.jsp?openFlag=DL100&inIccid="+$("#iccid").val()+"&inCustId="+$("#cust_id").val()+"&inUnitId="+$("#unit_id").val()+"&inCustName="+$("#cust_name").val()+"&inBelongCode="+$("#belong_code").val()+"&btn_id="+vBtnId+vUrl;
                javascript:topage('2029','000','1','��Ʒ����������ϵ���� ',taskUrl);
                $("#task_url").val("");
                document.getElementById(vBtnId).value = "�ɹ�";
                document.getElementById(vBtnId).disabled = true;
             }       
        }else{
            rdShowMessageDialog("ȡ�ͻ���Ϣʧ�ܣ�",0);
            return false;
        }
    }
    
    /* ѡ��ͻ�*/
    /*chendx 20100525Ϊ�ֱ��Ƿ�Ϊȫ��ҵ�����һ��pBbossFlag����,�����ȫ��ҵ����Ҫ����unit_id */
    function selectCust(pSmCode,pBizCode,pBtnId,pLoginAccept,pChildAccept,pBbossFlag){
        var iCustId = $("#cust_id").val();
        var iUnitId = $("#unit_id").val();
        var targetUrl = "custSelect.jsp?custId="+iCustId+"&unitId="+iUnitId+"&smCode="+pSmCode+"&bizCode="+pBizCode+"&btnId="+pBtnId+"&loginAccept="+pLoginAccept+"&childAccept="+pChildAccept+"&BbossFlag="+pBbossFlag+"&btnId="+btnId; 
        window.open(targetUrl,'_blank','height=500,width=700,scrollbars=yes');
    }
    
    /* ѡ��ͻ�����д���,custSelect.jspҳ����� */
    function doSelectCust(pResultFlag,pBtnId,pIdNo,pLoginAccept,pChildAccept){
        if(pResultFlag == "Y"){
            custCfm(pIdNo,pLoginAccept,pChildAccept,pBtnId);
        }else{
            
        }
    }
    
    /* ��ѡ��Ŀͻ����д��� */
    function custCfm(pIdNo,pLoginAccept,pChildAccept,pBtnId){
        var packet = new AJAXPacket("custCfm.jsp","���Ժ�...");
        packet.data.add("idNo",pIdNo);
        packet.data.add("loginAccept",pLoginAccept);
        packet.data.add("childAccept",pChildAccept);
        packet.data.add("btnId",pBtnId);
        core.ajax.sendPacket(packet,doCustCfm,true);
        packet =null;
    }
    
    /* ����AJAX����custCfm() */
    function doCustCfm(packet){
        var retCode     = packet.data.findValueByName("retCode"); 
        var retMsg      = packet.data.findValueByName("retMsg"); 
        var vBtnId      = packet.data.findValueByName("btnId");
        
        if(retCode == "000000"){
            rdShowMessageDialog("�����û�ѡ��ɹ���",2);
            document.getElementById(vBtnId).value = "�ɹ�";
            document.getElementById(vBtnId).disabled = true;
        }else{
            rdShowMessageDialog("������룺"+retCode+"<br/>������Ϣ��"+retMsg,0);
            // window.location = "f7412_1.jsp";
        }
    }
    
    /* ����Ŀ¼����ѡ���Ӳ�Ʒ��Ϣ */
    function query_spbiz()
    {
        var vIccid = $("#iccid").val();
        var vCustId = $("#cust_id").val();
        var vUnitId = $("#unit_id").val();
        var vCustName = $("#cust_name").val();
        
        if(vIccid == ''){
            rdShowMessageDialog("֤�����벻��Ϊ�գ�",0);
            $("#iccid").focus();
            return false;
        }
        
        if(vCustId == ''){
            rdShowMessageDialog("�ͻ�ID����Ϊ�գ�",0);
            $("#cust_id").focus();
            return false;
        }
        
        if(vUnitId == ''){
            rdShowMessageDialog("���ű��벻��Ϊ�գ�",0);
            $("#unit_id").focus();
            return false;
        }
        
        if(vCustName == ''){
            rdShowMessageDialog("���ſͻ����Ʋ���Ϊ�գ�",0);
            $("#cust_name").focus();
            return false;
        }
        
        /*
        var temp1=document.all.ProdType.value ;    //[S][]  //��Ʒ����
        var temp2=document.all.product_type.value ;    //[T][]  //Ʒ��  
        var targeturl="bizModeTree.jsp?ProdType="+temp1+"&sm_code="+temp2;
        win=window.open(targeturl,'_blank','height=500,width=400,scrollbars=yes');
        */
        
        var vSmCode = document.frm.product_type.value;
        if(vSmCode == "")
        {
            rdShowMessageDialog("������ѡ�����Ʒ�ƣ�",0);
            $("#product_type").focus();
            return false;
        }
        
        var pageTitle = "���Ų�Ʒѡ��";
        var fieldName = "";
        var retQuence = "";
        var retToField = "";

        fieldName = "��Ʒ����|��Ʒ����|ҵ�������|ҵ�������|";
        retQuence = "5|3|4|15|16|17|";
        retToField = "motive_code|motive_name|pkg_code|pkg_name|catalog_item_id|";

    	var sqlStr = "";
        var selType = "S";    //'S'��ѡ��'M'��ѡ
    
        if(PubSimpSelProd(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    }
    
    function PubSimpSelProd(pageTitle,fieldName,sqlStr,selType,retQuence,retToField){
        var product_code = document.all.motive_code.value;
    	var path = "<%=request.getContextPath()%>/npage/s7412/fpubprod_sel.jsp";
    	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    	path = path + "&selType=" + selType;
    	path = path + "&showType=" + "Default";
    	path = path + "&op_code=" + document.all.op_code.value;
    	path = path + "&sm_code=" + document.all.product_type.value; 
    	path = path + "&product_code=" + product_code; 
    	path = path + "&grp_id=" ;
    	path = path + "&bizTypeL=" + ($("#bizTypeL").val()==null?'':$("#bizTypeL").val());
    	path = path + "&bizTypeS=" ;
    	path = path + "&biz_code=" ;
    
        retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
    	return true;
    }
    
    function getValueProd2(retInfo, retInfoDetail){
        var retToField = "";
        var vSmCode = document.frm.product_type.value;
        retToField = "motive_code|motive_name|pkg_code|pkg_name|catalog_item_id|";
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
            retToField = retToField.substring(chPos_field + 1);
            retInfo = retInfo.substring(chPos_retInfo + 1);
            chPos_field = retToField.indexOf("|");
        }
        
        vMotiveCode = $("#motive_code").val();
        vMotiveName = $("#motive_name").val();
        $("#motive_info").val(vMotiveCode + "-" + vMotiveName);
        
        vPkgCode = $("#pkg_code").val();
        oporSubProd(vPkgCode);
    }
    
    function check_HidPwd(){
        var cust_id = document.all.cust_id.value;
        var Pwd1 = document.all.custPwd.value;
        var checkPwd_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s3690/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
        checkPwd_Packet.data.add("retType","checkPwd");
        checkPwd_Packet.data.add("cust_id",cust_id);
        checkPwd_Packet.data.add("Pwd1",Pwd1);
        core.ajax.sendPacket(checkPwd_Packet);
        checkPwd_Packet = null;
    }
    
    function doProcess(packet){
        var retType = packet.data.findValueByName("retType");
        var retCode = packet.data.findValueByName("retCode");
        var retMessage=packet.data.findValueByName("retMessage");
        self.status="";
        
        if(retType == "checkPwd"){ //���ſͻ�����У��
            if(retCode == "000000"){
                var retResult = packet.data.findValueByName("retResult");
                if (retResult == "false"){
                    rdShowMessageDialog("�ͻ�����У��ʧ�ܣ����������룡",0);
                    $("#qry_spbiz").attr("disabled",true);
                    frm.custPwd.value = "";
                    frm.custPwd.focus();
                    return false;
                }else{
                    rdShowMessageDialog("�ͻ�����У��ɹ���",2);
                    $("#qry_spbiz").attr("disabled",false);
                }
            }
            else{
                rdShowMessageDialog("�ͻ�����У�����������У�飡",0);
                $("#qry_spbiz").attr("disabled",true);
                return false;
            }
        }
    }
</script>
</head>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">������Ϣ</div>
</div>  
<table cellspacing="0" border="0" cellpadding="0">
    <tr id="config_search">
        <td nowrap class="blue">֤������</td>
        <td>  
            <input  type="text"  name="iccid" size=24 maxlength="18" id="iccid" v_must="1" v_type="String" v_maxlength="18" v_minlength="15"  maxlength="18" >
            <font class="orange">*</font>
            <input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=��ѯ>
        </td>    
        <td   nowrap class="blue">���ſͻ�ID</td> 
        <td>
            <input  type="text"  name="cust_id" size=24 maxlength="14" id="cust_id" v_must="1" v_type="int" v_maxlength="14" v_minlength="10"  maxlength="14" >
            <font class="orange">*</font>
        </td>    
    </tr>
    <tr>
        <td nowrap class="blue">���ű���</td>	
        <td>
            <input  type="text"  name="unit_id" size=24 maxlength="14" id="unit_id" v_must="1" v_type="int" v_maxlength="14" v_minlength="10"  maxlength="14" >
            <font class="orange">*</font>     				
        </td>	
        <td nowrap class="blue">���ſͻ�����</td>	
        <td>
            <input  type="text"  name="cust_name" size=24 maxlength="24" id="cust_name" v_must="1" v_type="String" v_maxlength="24" v_minlength="10"  maxlength="24" >      		 
            <font class="orange">*</font> 
        </td> 
    </tr>
    <tr style="display:none">
        <TD class=blue>���Ų�Ʒ����</TD>
        <TD colspan='3'>
            <select name="ProdType" id="ProdType">
                <option  value='1' >������ҵ��</option>
            </select>
        </TD>
    </tr>
    <tr>
        <td nowrap class="blue">��ƷƷ��</td>
        <td>
            <select name="product_type" id="product_type" v_must=1 v_type="string"  > 		  			
                <wtc:qoption name="sPubSelect" outnum="2">
                    <wtc:sql>select distinct sm_code, sm_code||'-->'||sm_name from SMOTIVETYPECFG  </wtc:sql>
                </wtc:qoption>		  			
            </select>
            <font class="orange">*</font>
        </td>
        <td nowrap class="blue">ҵ�����</td>
        <td>
            <select name="bizTypeL" id="bizTypeL"> 		  			
                <wtc:qoption name="sPubSelect" outnum="2">
                    <wtc:sql>select distinct external_code,external_code||'->'||main_name from sbiztypecode where sm_code='DL' and to_number(external_code)<=800</wtc:sql>
                </wtc:qoption>		  			
            </select>
            <font class="orange">*</font>
        </td>
    </tr>
    <tr>
        <TD class=blue>���ſͻ�����</TD>
        <TD>
     
            <jsp:include page="/npage/common/pwd_1.jsp">
                <jsp:param name="width1" value="16%"  />
                <jsp:param name="width2" value="34%"  />
                <jsp:param name="pname" value="custPwd"  />
                <jsp:param name="pwd" value="<%=123%>"  />
            </jsp:include> 
            <input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass2" value=У��>
            <font class="orange">*</font>
        </TD>
        <td nowrap class="blue">ҵ�����Ʒ</td>
        <td>
            <input  type="text"  name="motive_info"  readonly size=24 maxlength="60" id="motive_info" readonly v_must="0" v_type="string" v_maxlength="60" v_minlength="1"  maxlength="60" value="" >
            <input  type="hidden"  name="motive_code"  size=24 maxlength="60" id="motive_code" readonly v_must="0" v_type="0_9" v_maxlength="60" v_minlength="1"  maxlength="60" value="" >	
            <input  type="hidden"  name="motive_name"  readonly size=24 maxlength="60" id="motive_name" readonly v_must="0" v_type="string" v_maxlength="60" v_minlength="1"  maxlength="60" value="" >
            <input name=qry_spbiz type=button id="qry_spbiz" class="b_text" onMouseUp="query_spbiz();" onKeyUp="if(event.keyCode==13)query_spbiz();" style="cursor:hand" disabled value=��ѯ>
            <input  type="hidden"  name="pkg_code"  size=24 maxlength="60" id="pkg_code" readonly v_must="0" v_type="0_9" v_maxlength="60" v_minlength="1"  maxlength="60" value="" >	
            <input  type="hidden"  name="pkg_name"  readonly size=24 maxlength="60" id="pkg_name" readonly v_must="0" v_type="string" v_maxlength="60" v_minlength="1"  maxlength="60" value="" >
            <font class="orange">*</font>
        </td>
    </tr>
</table>

<span id='taskListFlag' name='taskListFlag' style='display:none'>
    </div>
    <div id="Operation_Table">
    <div class="title">
        <div id="title_zi">�����б�</div>
    </div>
    <table cellspacing=0>
    <tr>
        <th>��ƷƷ��</th>
        <th>��Ʒ����</th>
        <th>��Ʒ����</th>
        <th>ҵ�����</th>
        <th>ҵ������</th>
        <th>����</th>
    </tr>
    <tbody id="taskList" name="taskList">
    
    </tbody>
    </table>
</span>
<table cellspacing="0" border="0" cellpadding="0" style='display:'>
    <tr>
        <td id="footer" align="center" colspan="4">         	 	
            <input class="b_foot" type=button name="b_back" id="b_back" value="����" onClick="window.location='f7412_1.jsp'" >                
            <input class="b_foot" type=button name="b_close" id="b_close" value="�ر�" onClick="removeCurrentTab()" >
        </td>
    </tr>       
</table> 
<input type="hidden" name="unit_name"  value="">
<input type="hidden" name="grp_name"  value="">
<input type="hidden" name="motive_srvcode" value="">
<input type="hidden" name="motive_price"  value="">
<input type="hidden" name="motive_prdcode"  value="">
<input type="hidden" name="motive_prdsrv"  value="">
<input type="hidden" name="motive_prdpric"  value="">
<input type="hidden" name="motive_prdsmd"  value="">
<input type="hidden" name="motive_prodsvrmode" value="">
<input type="hidden" name="grp_no" value="0">
<input type="hidden" name="motive_prod" value="">
<input type="hidden" name="motive_prdsrvname" value="">
<input type="hidden" name="prod_level" value="">
<input type="hidden" name="tmptrysrv" value="">
<input type="hidden" name="belong_code" id="belong_code" value="">
<input type="hidden" name="group_id" value="">
<input type="hidden" name="login_accept"  value="0"> <!-- ������ˮ��-->
<input type="hidden" name="tonote" id="tonote" value="">
<input type='hidden' id='task_url' name='task_url' />
<input type='hidden' id='catalog_item_id' name='catalog_item_id' value='' />
<input type='hidden' id='op_code' name='op_code' value='<%=opCode%>' />
<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html> 
