<%
    /********************
     * @ OpCode    :  7421
     * @ OpName    :  动力100业务包订购
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
    String opName = "动力100业务包订购";
    
    String regionCode   = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String workNo       = WtcUtil.repNull((String)session.getAttribute("workNo"));   //工号	
    String workName     = WtcUtil.repNull((String)session.getAttribute("workName"));
    
    /* 取操作流水 */
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
		
		var nztFlag = "Y"; /*diling add for 关于开发集团产品整合营销包需求*/
		
    /* 查询集团信息 */
    function getInfo_Cust(){
        var pageTitle = "动力100集团客户选择";
        var fieldName = "证件号码|客户ID|客户名称|集团编码|集团名称|归属地|group_id|";
        var sqlStr = "";
        var selType = "S";    //'S'单选；'M'多选
        var retQuence = "7|0|1|2|3|4|5|6|";
        var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|group_id|";
        var cust_id = document.frm.cust_id.value;
        
        if(document.frm.iccid.value == "" &&
        document.frm.cust_id.value == "" &&
        document.frm.unit_id.value == ""){
            rdShowMessageDialog("请输入证件号码、集团客户ID或集团编码进行查询！",0);
            document.frm.iccid.focus();
            return false;
        }
        var iccid=document.frm.iccid.value;
        result=cust_id.match(/^\d{10,14}$/g);
        if(document.frm.cust_id.value != "" && result==null){
            document.frm.cust_id.value = "";
            document.frm.cust_id.focus();
            rdShowMessageDialog("集团客户ID必须是[10-14]位的数字！",0);
            return false;
        }
        var unit_id=document.frm.unit_id.value;
        result=unit_id.match(/^\d{10,14}$/g);
        if(document.frm.unit_id.value != "" && result==null){
            document.frm.unit_id.value = "";
            document.frm.unit_id.focus();
            rdShowMessageDialog("集团编码必须是[10-14]位的数字！",0);
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
        
        var packet = new AJAXPacket("custCheck.jsp","请稍后...");
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
                rdShowMessageDialog("该客户已经订购了动力100产品还处于有效期，不能再次办理！",0);
                window.location.href="f7412_1.jsp";
            }
        }else{
            rdShowMessageDialog("错误代码："+errCode+",错误信息："+errMsg,0);
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
    /*chendx update 如果DL100包内的全网业务是走包前订购，其标记方式跟本地业务一样*/
    function set_Attribute(retArr,motive_code){
        var vSmCodeList = $("#product_type").val() + "~";
        var vSmNameList = "动力100" + "~";
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
        
        var packet = new AJAXPacket("splitDL100.jsp","请稍后...");
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
            rdShowMessageDialog("错误代码："+errCode+"<br/>错误信息："+errMsg,0);
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
                rdShowMessageDialog("动力100包配置不完整，不能做订购！",0);
                window.location = "f7412_1.jsp";
                return false;
            }
            
            /*diling add for 关于开发集团产品整合营销包需求 */
            judgeForNzt(vSmCodeList,vProCodeList);
            
            if(nztFlag=="N"){
               rdShowMessageDialog("该用户没有订购农政通业务！不能订购此业务！",0);
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
                          + "动力100"
                          + "</td>"
                          + "<td>"
                          + $("#motive_code").val()
                          + "</td>"
                          + "<td>"
                          + $("#motive_name").val()
                          + "</td>"
                          + "<td>"
                          + "待选择"
                          + "</td>"
                          + "<td>"
                          + "待选择"
                          + "</td>"
                          + "<td>"
                          + "<input type='button' id='taskBtn0' name='taskBtn0' class='b_text' value='接收' onClick='toReceive(\"N\",\"taskBtn0\",\""+$("#product_type").val()+"\",\"\",\""+vLoginAcceptArr[0]+"\",\""+vChildAcceptArr[0]+"\",\"&sm_code="+$("#product_type").val()+"&in_productCode="+$("#motive_code").val()+"&in_productName="+$("#motive_name").val()+"&in_bizCode="+$("#pkg_code").val()+"&in_bizName="+$("#pkg_name").val()+"&in_loginAccept="+vLoginAcceptArr[0]+"&in_childAccept="+vChildAcceptArr[0]+"&in_count="+vSmCodeArr.length+"&catalog_item_id="+$("#catalog_item_id").val()+"\")'/>"
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
                          productCodeInfo = "待选择";
                      }
                      
                      var productNameInfo = "";
                      if(vSmCodeArr[i] == 'AD' || vSmCodeArr[i] == 'ML' || vBbossFlagArr[i] == 'Y'){
                          productNameInfo = vProNameArr[i];
                      }else{
                          productNameInfo = "待选择";
                      }
                      
                      var strTemp2 = "<tr>"
                                  + "<td class='"+tdClass+"'>"
                                  + vSmNameArr[i]
                                  + "</td>"
                                  + "<td class='"+tdClass+"'>"
                                  + "待选择"
                                  + "</td>"
                                  + "<td class='"+tdClass+"'>"
                                  + "待选择"
                                  + "</td>"
                                  + "<td class='"+tdClass+"'>"
                                  + productCodeInfo
                                  + "</td>"
                                  + "<td class='"+tdClass+"'>"
                                  + productNameInfo
                                  + "</td>"
                                  + "<td class='"+tdClass+"'>"
                                  + "<input type='button' id='taskBtn"+i+"' name='taskBtn"+i+"' class='b_text' value='接收' onClick='toReceive(\""+vBbossFlagArr[i]+"\",\"taskBtn"+i+"\",\""+vSmCodeArr[i]+"\",\""+productCodeInfo+"\",\""+vLoginAcceptArr[i]+"\",\""+vChildAcceptArr[i]+"\",\"&sm_code="+vSmCodeArr[i]+"&in_productCode=&in_productName=&in_bizCode="+productCodeInfo+"&in_bizName="+productNameInfo+"&in_loginAccept="+vLoginAcceptArr[i]+"&in_childAccept="+vChildAcceptArr[i]+"&in_count="+vSmCodeArr.length+"&catalog_item_id=\")'/>"
                                  + "</td>"
                                  + "</tr>" ;
                      $("#taskList").append(strTemp2);
                  }
              }
        }
    }
    
    /***begin add by diling for 关于开发集团产品整合营销包需求***/
    function judgeForNzt(vSmCodeList,vProCodeList){
      var unit_id = $("#unit_id").val();
      var packet = new AJAXPacket("f7412_ajax_judgeForNzt.jsp","请稍后...");
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
    
     /***end add by diling for 关于开发集团产品整合营销包需求***/

    /* 点击接收时触发,参数信息(当前接收按钮ID,品牌,业务代码,URL) */
    function toReceive(bBossFlag,taskBtnId,taskSmCode,taskBizCode,pLoginAccept,pChildAccept,taskUrl){	
    	  $("#"+taskBtnId).attr("disabled",true);//yuanqs add 2010-9-1 15:04:19 
        var vCustId = $("#cust_id").val();
        $("#task_url").val(taskUrl);
        
        var packet = new AJAXPacket("custCount.jsp","请稍后...");
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
    
    /* 处理AJAX函数toReceive() */
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
            			if(vCustCnt == "0"){ /* 集团下没有移动400的客户信息 */
										rdShowMessageDialog("请包前订购移动400业务！",0);
										return false;
                	}else{ /* 集团下存在移动400的客户信息 */
                    selectCust(vSmCode,vBizCode,vBtnId,vLoginAccept,vChildAccept,vBbossFlag);
                	 }
								}else if(vCustCnt == "0"){
                    var taskUrl = "../s3690/f3690_1.jsp?openFlag=DL100&inIccid="+$("#iccid").val()+"&inCustId="+$("#cust_id").val()+"&inUnitId="+$("#unit_id").val()+"&inCustName="+$("#cust_name").val()+"&inBelongCode="+$("#belong_code").val()+"&btn_id="+vBtnId+vUrl; //yuanqs add btn_id参数 2010/9/6 10:30:15 
                    //javascript:topage('1111','000','1','任务接收',taskUrl);
                    window.open(taskUrl,'_blank','height=600,width=900,left=10,top=10,resizable=yes,scrollbars=yes');
                    $("#task_url").val("");
                }else{ /* 集团下存在该品牌的客户信息 */
                    selectCust(vSmCode,vBizCode,vBtnId,vLoginAccept,vChildAccept,vBbossFlag);
                }
            }else{         		
                var taskUrl = "s2002/f2029_1.jsp?openFlag=DL100&inIccid="+$("#iccid").val()+"&inCustId="+$("#cust_id").val()+"&inUnitId="+$("#unit_id").val()+"&inCustName="+$("#cust_name").val()+"&inBelongCode="+$("#belong_code").val()+"&btn_id="+vBtnId+vUrl;
                javascript:topage('2029','000','1','商品订单订购关系管理 ',taskUrl);
                $("#task_url").val("");
                document.getElementById(vBtnId).value = "成功";
                document.getElementById(vBtnId).disabled = true;
             }       
        }else{
            rdShowMessageDialog("取客户信息失败！",0);
            return false;
        }
    }
    
    /* 选择客户*/
    /*chendx 20100525为分辨是否为全网业务，添加一个pBbossFlag参数,如果是全网业务，需要传入unit_id */
    function selectCust(pSmCode,pBizCode,pBtnId,pLoginAccept,pChildAccept,pBbossFlag){
        var iCustId = $("#cust_id").val();
        var iUnitId = $("#unit_id").val();
        var targetUrl = "custSelect.jsp?custId="+iCustId+"&unitId="+iUnitId+"&smCode="+pSmCode+"&bizCode="+pBizCode+"&btnId="+pBtnId+"&loginAccept="+pLoginAccept+"&childAccept="+pChildAccept+"&BbossFlag="+pBbossFlag+"&btnId="+btnId; 
        window.open(targetUrl,'_blank','height=500,width=700,scrollbars=yes');
    }
    
    /* 选择客户后进行处理,custSelect.jsp页面调用 */
    function doSelectCust(pResultFlag,pBtnId,pIdNo,pLoginAccept,pChildAccept){
        if(pResultFlag == "Y"){
            custCfm(pIdNo,pLoginAccept,pChildAccept,pBtnId);
        }else{
            
        }
    }
    
    /* 对选择的客户进行处理 */
    function custCfm(pIdNo,pLoginAccept,pChildAccept,pBtnId){
        var packet = new AJAXPacket("custCfm.jsp","请稍后...");
        packet.data.add("idNo",pIdNo);
        packet.data.add("loginAccept",pLoginAccept);
        packet.data.add("childAccept",pChildAccept);
        packet.data.add("btnId",pBtnId);
        core.ajax.sendPacket(packet,doCustCfm,true);
        packet =null;
    }
    
    /* 处理AJAX函数custCfm() */
    function doCustCfm(packet){
        var retCode     = packet.data.findValueByName("retCode"); 
        var retMsg      = packet.data.findValueByName("retMsg"); 
        var vBtnId      = packet.data.findValueByName("btnId");
        
        if(retCode == "000000"){
            rdShowMessageDialog("集团用户选择成功！",2);
            document.getElementById(vBtnId).value = "成功";
            document.getElementById(vBtnId).disabled = true;
        }else{
            rdShowMessageDialog("错误代码："+retCode+"<br/>错误信息："+retMsg,0);
            // window.location = "f7412_1.jsp";
        }
    }
    
    /* 弹出目录树，选择子产品信息 */
    function query_spbiz()
    {
        var vIccid = $("#iccid").val();
        var vCustId = $("#cust_id").val();
        var vUnitId = $("#unit_id").val();
        var vCustName = $("#cust_name").val();
        
        if(vIccid == ''){
            rdShowMessageDialog("证件号码不能为空！",0);
            $("#iccid").focus();
            return false;
        }
        
        if(vCustId == ''){
            rdShowMessageDialog("客户ID不能为空！",0);
            $("#cust_id").focus();
            return false;
        }
        
        if(vUnitId == ''){
            rdShowMessageDialog("集团编码不能为空！",0);
            $("#unit_id").focus();
            return false;
        }
        
        if(vCustName == ''){
            rdShowMessageDialog("集团客户名称不能为空！",0);
            $("#cust_name").focus();
            return false;
        }
        
        /*
        var temp1=document.all.ProdType.value ;    //[S][]  //产品类型
        var temp2=document.all.product_type.value ;    //[T][]  //品牌  
        var targeturl="bizModeTree.jsp?ProdType="+temp1+"&sm_code="+temp2;
        win=window.open(targeturl,'_blank','height=500,width=400,scrollbars=yes');
        */
        
        var vSmCode = document.frm.product_type.value;
        if(vSmCode == "")
        {
            rdShowMessageDialog("请首先选择服务品牌！",0);
            $("#product_type").focus();
            return false;
        }
        
        var pageTitle = "集团产品选择";
        var fieldName = "";
        var retQuence = "";
        var retToField = "";

        fieldName = "产品代码|产品名称|业务包代码|业务包名称|";
        retQuence = "5|3|4|15|16|17|";
        retToField = "motive_code|motive_name|pkg_code|pkg_name|catalog_item_id|";

    	var sqlStr = "";
        var selType = "S";    //'S'单选；'M'多选
    
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
        var checkPwd_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s3690/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
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
        
        if(retType == "checkPwd"){ //集团客户密码校验
            if(retCode == "000000"){
                var retResult = packet.data.findValueByName("retResult");
                if (retResult == "false"){
                    rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
                    $("#qry_spbiz").attr("disabled",true);
                    frm.custPwd.value = "";
                    frm.custPwd.focus();
                    return false;
                }else{
                    rdShowMessageDialog("客户密码校验成功！",2);
                    $("#qry_spbiz").attr("disabled",false);
                }
            }
            else{
                rdShowMessageDialog("客户密码校验出错，请重新校验！",0);
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
    <div id="title_zi">集团信息</div>
</div>  
<table cellspacing="0" border="0" cellpadding="0">
    <tr id="config_search">
        <td nowrap class="blue">证件号码</td>
        <td>  
            <input  type="text"  name="iccid" size=24 maxlength="18" id="iccid" v_must="1" v_type="String" v_maxlength="18" v_minlength="15"  maxlength="18" >
            <font class="orange">*</font>
            <input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=查询>
        </td>    
        <td   nowrap class="blue">集团客户ID</td> 
        <td>
            <input  type="text"  name="cust_id" size=24 maxlength="14" id="cust_id" v_must="1" v_type="int" v_maxlength="14" v_minlength="10"  maxlength="14" >
            <font class="orange">*</font>
        </td>    
    </tr>
    <tr>
        <td nowrap class="blue">集团编码</td>	
        <td>
            <input  type="text"  name="unit_id" size=24 maxlength="14" id="unit_id" v_must="1" v_type="int" v_maxlength="14" v_minlength="10"  maxlength="14" >
            <font class="orange">*</font>     				
        </td>	
        <td nowrap class="blue">集团客户名称</td>	
        <td>
            <input  type="text"  name="cust_name" size=24 maxlength="24" id="cust_name" v_must="1" v_type="String" v_maxlength="24" v_minlength="10"  maxlength="24" >      		 
            <font class="orange">*</font> 
        </td> 
    </tr>
    <tr style="display:none">
        <TD class=blue>集团产品类型</TD>
        <TD colspan='3'>
            <select name="ProdType" id="ProdType">
                <option  value='1' >包订购业务</option>
            </select>
        </TD>
    </tr>
    <tr>
        <td nowrap class="blue">产品品牌</td>
        <td>
            <select name="product_type" id="product_type" v_must=1 v_type="string"  > 		  			
                <wtc:qoption name="sPubSelect" outnum="2">
                    <wtc:sql>select distinct sm_code, sm_code||'-->'||sm_name from SMOTIVETYPECFG  </wtc:sql>
                </wtc:qoption>		  			
            </select>
            <font class="orange">*</font>
        </td>
        <td nowrap class="blue">业务大类</td>
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
        <TD class=blue>集团客户密码</TD>
        <TD>
     
            <jsp:include page="/npage/common/pwd_1.jsp">
                <jsp:param name="width1" value="16%"  />
                <jsp:param name="width2" value="34%"  />
                <jsp:param name="pname" value="custPwd"  />
                <jsp:param name="pwd" value="<%=123%>"  />
            </jsp:include> 
            <input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass2" value=校验>
            <font class="orange">*</font>
        </TD>
        <td nowrap class="blue">业务包产品</td>
        <td>
            <input  type="text"  name="motive_info"  readonly size=24 maxlength="60" id="motive_info" readonly v_must="0" v_type="string" v_maxlength="60" v_minlength="1"  maxlength="60" value="" >
            <input  type="hidden"  name="motive_code"  size=24 maxlength="60" id="motive_code" readonly v_must="0" v_type="0_9" v_maxlength="60" v_minlength="1"  maxlength="60" value="" >	
            <input  type="hidden"  name="motive_name"  readonly size=24 maxlength="60" id="motive_name" readonly v_must="0" v_type="string" v_maxlength="60" v_minlength="1"  maxlength="60" value="" >
            <input name=qry_spbiz type=button id="qry_spbiz" class="b_text" onMouseUp="query_spbiz();" onKeyUp="if(event.keyCode==13)query_spbiz();" style="cursor:hand" disabled value=查询>
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
        <div id="title_zi">任务列表</div>
    </div>
    <table cellspacing=0>
    <tr>
        <th>产品品牌</th>
        <th>产品代码</th>
        <th>产品名称</th>
        <th>业务代码</th>
        <th>业务名称</th>
        <th>操作</th>
    </tr>
    <tbody id="taskList" name="taskList">
    
    </tbody>
    </table>
</span>
<table cellspacing="0" border="0" cellpadding="0" style='display:'>
    <tr>
        <td id="footer" align="center" colspan="4">         	 	
            <input class="b_foot" type=button name="b_back" id="b_back" value="重置" onClick="window.location='f7412_1.jsp'" >                
            <input class="b_foot" type=button name="b_close" id="b_close" value="关闭" onClick="removeCurrentTab()" >
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
<input type="hidden" name="login_accept"  value="0"> <!-- 操作流水号-->
<input type="hidden" name="tonote" id="tonote" value="">
<input type='hidden' id='task_url' name='task_url' />
<input type='hidden' id='catalog_item_id' name='catalog_item_id' value='' />
<input type='hidden' id='op_code' name='op_code' value='<%=opCode%>' />
<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html> 
