 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-15 ҳ�����,�޸���ʽ
	********************/
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*"%>
<%
	String opCode = "3214";	
	String opName = "�����޸ļ��ų�Ա";	//header.jsp��Ҫ�Ĳ���          
        String  loginNo=(String)session.getAttribute("workNo");    //���� 
        String  loginName =(String)session.getAttribute("workName");//��������  	
        String  powerRight= (String)session.getAttribute("powerRight");          
        String  orgCode = (String)session.getAttribute("orgCode");        
        String  ip_Addr = request.getRemoteAddr();   
        String  regionCode = (String)session.getAttribute("regCode");                
        String  GroupId = (String)session.getAttribute("groupId");        
        String  OrgId = (String)session.getAttribute("orgId");

        int recordNum = 0;
        /*
	        ArrayList retArray = new ArrayList();
	        String[][] result = new String[][]{};
	        SPubCallSvrImpl callView = new SPubCallSvrImpl();
        */
        String[][] result = new String[][]{};
	String dateStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String  insql = "select to_char(last_day(sysdate)+1,'YYYY-MM-DD')  from  dual";
	//retArray = callView.sPubSelect("1",insql);
	//result = (String[][])retArray.get(0);
	
				//ȡ����ǰ��������ʱ---------------------------
				String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd-HH").format(new java.util.Date());
				String strTime[] = new String[4];
		    strTime = dateStr1.split("-");
			
			//ȡ����ǰ��������ʱ---------------------------
	%>
	
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end" />

<%
	result=result1;
	dateStr=result[0][0];
	System.out.println("@@@@@@@@@@@@@"+dateStr);

%>

<%
    int isGetDataFlag = 1;  //0����ȷ,��������. add by yl.
    String errorMsg ="";
    String tmpStr="";
    insql = "";
    StringBuffer sqlBuf = new StringBuffer();//-------------------------------
dataLabel:
    while(1==1){
       sqlBuf.append( "select distinct(trim(a.pkg_code)) pkg,trim(a.pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode a,svpmnpkgcodeconfig b where a.region_code='"+regionCode+"' and stop_time>=sysdate and " + powerRight + " >= power_Right");
    	 sqlBuf.append(" and ( to_number('"+strTime[0]+"')>=to_number(b.start_year) or (b.start_year is null) )");
    	 sqlBuf.append(" and ( to_number('"+strTime[0]+"')<=to_number(b.end_year) or (b.end_year is null) )");
    	 
    	 sqlBuf.append(" and ( to_number('"+strTime[1]+"')>=to_number(b.start_month) or (b.start_month is null) )");
    	 sqlBuf.append(" and ( to_number('"+strTime[1]+"')<=to_number(b.end_month) or (b.end_month is null) )");
    
       sqlBuf.append(" and ( to_number('"+strTime[2]+"')>=to_number(b.start_day) or (b.start_day is null) )");
    	 sqlBuf.append(" and ( to_number('"+strTime[2]+"')<=to_number(b.end_day) or (b.end_day is null) )");
    
       sqlBuf.append(" and ( to_number('"+strTime[3]+"')>=to_number(b.start_hours) or (b.start_hours is null) )");
    	 sqlBuf.append(" and ( to_number('"+strTime[3]+"')<to_number(b.end_hours) or (b.end_hours is null) )");

    	 
    	 sqlBuf.append(" and a.pkg_code = b.pkg_code(+) and a.region_code = b.region_code(+)");
    	 sqlBuf.append(" order by to_number(pkg)");

    //1.SQL �ʷ��ײ�
  //  insql = "select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code='"+regionCode+"' and stop_time>=sysdate and " + powerRight + " >= power_Right order by to_number(pkg_code) ";
  //insql = "select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code='"+regionCode+"' order by to_number(pkg_code) ";

    //retArray = callView.sPubSelect("2",insql);
   // result = (String[][])retArray.get(0);
   %>
   <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
<wtc:sql><%=sqlBuf.toString()%></wtc:sql>
   </wtc:pubselect>
 <wtc:array id="result2" scope="end" />   
   <%
    result = result2;
    recordNum = result.length;
    System.out.println("==================recordNum============="+recordNum);
    if (result[0][0].trim().length() == 0)
        recordNum = 0;

    break;
 }

%>

<html>
	<head>
		<title>�����޸ļ��ų�Ա</title>
<script language="JavaScript">
<!--
    //����Ӧ��ȫ�ֵı���
    var SUCC_CODE   = "0";          //�Լ�Ӧ�ó�����
    var ERROR_CODE  = "1";          //�Լ�Ӧ�ó�����
    var YE_SUCC_CODE = "0000";      //����Ӫҵϵͳ������޸�
    var dynTbIndex=1;               //���ڶ�̬�����ݵ�����λ��,��ʼֵΪ1.���Ǳ�ͷ

    var oprType_Add = "a";
    var oprType_Upd = "u";
    var oprType_Del = "d";
    var oprType_Qry = "q";

    var TOKEN="|";

    //core.loadUnit("debug");
    //core.loadUnit("rpccore");
    onload=function()
    {
        init();
        //core.rpc.onreceive = doProcess;
    }


    function reset_globalVar()
    {
      dynTbIndex=1;
    }

    function init()
    {

        document.frm.CLOSENO1.value = "0";
        document.frm.CLOSENO2.value = "0";
        document.frm.CLOSENO3.value = "0";
        document.frm.CLOSENO4.value = "0";
        document.frm.CLOSENO5.value = "0";

        document.frm.USERPIN1.value = "88888888";
        document.frm.USERPIN2.value = "88888888";	
        document.frm.FLAGS.value = "220000221111000001001020020000000000";
        document.frm.tmpFLAGS.value = document.frm.FLAGS.value;
        document.frm.OUTGRP.value = "0";
        document.frm.MAXOUTNUM.value = "10";
        document.frm.LMTFEE.value = "10000000";

        //document.frm.PKGDAY.value = addDateTime(NowDateTime(),"DAY",1);

        //document.all.addRecordNum.value = document.all.dyntb.rows.length-1;


        //document.all.UserId.style.display="none";
        //document.all.FileId.style.display="none";

        document.frm.GRPID.focus();
		//document.all.tableNo.style.display="";   //������¼��
		//document.all.tableFile.style.display="none";//���ļ�¼��
    }

    function changeDateFormat(sDate)
    {
            year = sDate.substring(0,4);
            month= sDate.substring(4,6);
            day= sDate.substring(6,8);

            return year+"-"+month+"-"+day;

    }

    function readSubStr(srcStr,token,msg)
    {
     var retInfo="";
     var chPos=0;
     var valueStr="";


        retInfo = srcStr;
        
        chPos = retInfo.indexOf(token);

          while(chPos > -1){
            valueStr = retInfo.substring(0,chPos);
            doBackCheck(valueStr,msg);
            //alert("|"+valueStr+"|");
            retInfo = retInfo.substring(chPos + 1);
            chPos = retInfo.indexOf(token);
             if( !(chPos > -1)) break;
          }
        if( retInfo != ""){
            //alert("retInfo="+retInfo+"|");
            valueStr = retInfo;
            doBackCheck(valueStr,msg);
        }
    }

//---------1------RPC������------------------
function doProcess(packet){
    //ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
    error_code = packet.data.findValueByName("errorCode");
    error_msg =  packet.data.findValueByName("errorMsg");
    verifyType = packet.data.findValueByName("verifyType");
		var backArrMsg = packet.data.findValueByName("backArrMsg");
		var backArrMsg1 = packet.data.findValueByName("backArrMsg1");
		var backArrMsg2 = packet.data.findValueByName("backArrMsg2");
	

    self.status="";

    if(verifyType=="confirm"){

        if( parseInt(error_code) == 0 ){
            rdShowMessageDialog("ȷ����Ϣ����,��˲�!!");
            document.frm.FLAGS.disabled = false;
            //document.frm.confirm.disabled=true;   //shengzd@20090818
						succData = backArrMsg;
						failData = backArrMsg1;
		
            var retInfo="";
            var chPos=0;
            var valueStr="";

            //����ɹ�������
            readSubStr(succData,TOKEN,"�ɹ�");
            readSubStr(failData,TOKEN,"ʧ��");
            //window.location.reload();
        }else{
            rdShowMessageDialog("<br>������룺"+error_code+"</br>������Ϣ��"+error_msg);
            //window.location.reload();
            return false;
        }
    	}else  if(verifyType=="UnitId"){						//�õ�UnitId
				if( parseInt(error_code) == 0){
				  tmpObj="unit_id";
				  document.all(tmpObj).options.length=0;
				  document.all(tmpObj).options.length=backArrMsg.length;	
		
		      for(i=0;i<backArrMsg.length;i++)
			    {
					  for(j=0;j<backArrMsg[i].length;j++)
					  {
					    document.all(tmpObj).options[i].text=backArrMsg[i][j];
					    document.all(tmpObj).options[i].value=backArrMsg[i][j];
			 		  }
			    }

			    if(backArrMsg.length==0){
			    	rdShowMessageDialog("û���ҵ�������Ϣ��");
			    	return;
			    }
			    else{
			    	//getPhoneList();
			    }
			    if(backArrMsg2.length==0){
						  	 	rdShowMessageDialog("��ѯ��������Ʒ���ʷѳ���",0);
						  	 	document.all.limitcount.value="";
						  	 	return false;
					}
					else
					{
						   document.all.limitcount.value=backArrMsg2[0][0];
						   		
						   //alert(document.all.limitcount.value);
						   		
					}
			    
			}else{
				rdShowMessageDialog("ȡ��Ϣ����:"+error_msg+"!");
				return;			
			}
		}
		else  if(verifyType=="phoneNo"){
			
			if(parseInt(error_code) == 0){
				
			  var short_no = packet.data.findValueByName("short_no");
			  var phone_no = packet.data.findValueByName("phone_no");
			  var cust_name = packet.data.findValueByName("cust_name");
			  var id_iccid = packet.data.findValueByName("id_iccid");
			  var note = packet.data.findValueByName("note");
			  var run_code = packet.data.findValueByName("run_code");
			  var curpkgtype = packet.data.findValueByName("curpkgtype");
			  var pkg_name = packet.data.findValueByName("pkg_name");
			  var num = packet.data.findValueByName("num");
			  if(num==0){
					rdShowMessageDialog("û���ҵ����ų�Ա��Ϣ��");
					return;
				}

			  for(i=0;i<num;i++){
			  	queryAddAllRow(0,short_no[i],phone_no[i],cust_name[i],id_iccid[i],note[i],run_code[i],curpkgtype[i],pkg_name[i]);
			  }
			  
			  
			}else{
				rdShowMessageDialog("ȡ��Ϣ����:"+error_msg+"!");
				return;			
			}
		}
}

    function doBackCheck(add_no,add_value)
    {  
        var tmp_addNo="";
				var num=document.all.dyntb.rows.length-1;
				if(num>1){
	        for(var a=0 ;a<num; a++)
	        {
	        	tmp_addNo = document.all.R2[a].value;
	        	if((tmp_addNo.trim() == add_no.trim())){
	                document.all.R6[a].value = add_value;
	                break;
	          }
	        }
	      }else{
	      	tmp_addNo = document.all.R2.value;
        	if((tmp_addNo.trim() == add_no.trim())){
                document.all.R6.value = add_value;
          }
	      }
        return true;
    }

    function call_FLAGS()
    {

       	var h=480;
   	var w=800;
  	var t=screen.availHeight/2-h/2;
   	var l=screen.availWidth/2-w/2;
   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

       	var str=window.showModalDialog('user_flags.jsp?flags='+document.frm.FLAGS.value,"",prop);

       	if( typeof(str) != "undefined" ){
            document.frm.FLAGS.value = str;
        }

        return true;

    }

	    function fillSelectUseValue_noArr(fillObject,indValue)
	    {
	            for(var i=0;i<document.all(fillObject).options.length;i++){
	                if(document.all(fillObject).options[i].value == indValue){
	                    document.all(fillObject).options[i].selected = true;
	                    break;
	                }
	            }
	    }

	    function check_phone()
	    {
	
	        var sqlBuf="";
	
	        var myPacket = new AJAXPacket("CallCommONESQL.jsp","������֤�û����룬���Ժ�......");
	
	          if(!checkElement(document.all.PHONENO)) return false;
	          if(!checkElement(document.all.ISDNNO)) return false;
	
	            sqlBuf="select count(*) from dcustmsg a, dconusermsg b where a.id_no = b.id_no and phone_no ='"+document.frm.ISDNNO.value +"'";
	
	            myPacket.data.add("verifyType","phoneno");
	
	            myPacket.data.add("sqlBuf",sqlBuf);
	            myPacket.data.add("recv_number",1);
	            core.ajax.sendPacket(myPacket);
	            myPacket=null;
	            //delete(myPacket);
	
	    }
	 function getUnitId(){
		 	var rows=dyntb.rows.length
			for(i=1;i<rows;i++){
				dyntb.deleteRow(1);
			}
     		var myPacket = new AJAXPacket("f3214_getUnitId.jsp","����ȡunit_id�����Ժ�......");
		var groupNo=document.all.GRPID.value.trim();
		var OrgId=document.all.org_id.value;
	     	myPacket.data.add("verifyType","UnitId");
	     	myPacket.data.add("groupNo",groupNo);
	    	myPacket.data.add("OrgId",OrgId);
	     	core.ajax.sendPacket(myPacket);
	     	myPacket=null;
	     	//delete(myPacket);
	}
	
    function dynAddRow()
    {
        var phone_no="";
        var isdn_no="";
        var user_name="";
        var id_card="";
        var note="";
        var add_no="";

        var tmpStr="";
        var flag=false;

        //var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
        var op_type = oprType_Add;


        if( op_type == oprType_Add)
        {
          phone_no = document.all.PHONENO.value;
          isdn_no = document.all.ISDNNO.value;

          if(!checkElement(document.all.PHONENO)) return false;
          if(!checkElement(document.all.ISDNNO)) return false;


        }

          user_name = document.all.USERNAME.value;
          id_card = document.all.IDCARD.value;
          note = document.all.PCOMMENT.value;


    	  queryAddAllRow(0,phone_no,isdn_no,user_name,id_card,note);

}


    function queryAddAllRow(add_type,phone_no,isdn_no,user_name,id_card,note,pStatus,curpkgtype,pkg_name)
    {
    	var exec_status="";
	    var tr1="";
	    var i=0;
	    tr1=dyntb.insertRow();    //ע�⣺����ı������������һ��,������ɿ���.yl.
	    tr1.id="tr"+dynTbIndex;
	    tr1.insertCell(0).innerHTML = '<div align="center"><input id=R0    type=checkBox size=4 value="'+ phone_no+'"></input></div>';
	    tr1.insertCell(1).innerHTML = '<div align="center"><input id=R1    type=text   size=10 value="'+ phone_no+'" class=InputGrey e></input></div>';
	    tr1.insertCell(2).innerHTML = '<div align="center"><input id=R2    type=text   value="'+ isdn_no+'"  class=InputGrey readonly></input></div>';
	    tr1.insertCell(3).innerHTML = '<div align="center"><input id=R3    type=text   value="'+ curpkgtype+"->"+pkg_name+'" class=InputGrey  readonly></input></div>';
	    //tr1.insertCell(4).innerHTML = '<div align="center"><input id=R4    type=text   value="'+ id_card+'" class=InputGrey readonly ></input></div>';
	    tr1.insertCell(5).innerHTML = '<div align="center"><input id=R5    type=text   value="'+ note+'"  class=InputGrey readonly></input></div>';
	    tr1.insertCell(6).innerHTML = '<div align="center"><input id=R6    type=text  size=8 value="'+ exec_status+'" class=InputGrey readonly ></input></div>';
	    
    }
    
    function allChoose()
    {   //��ѡ��ȫ��ѡ��
        for (i = 0; i < document.frm.elements.length; i++)
        {
            if (document.frm.elements[i].type == "checkbox")
            {    //�ж��Ƿ��ǵ�ѡ��ѡ��
                document.frm.elements[i].checked = true;
            }
        }
    }

    function cancelChoose()
    {   //ȡ����ѡ��ȫ��ѡ��
        for (i = 0; i < document.frm.elements.length; i++)
        {
            if (document.frm.elements[i].type == "checkbox")
            {    //�ж��Ƿ��ǵ�ѡ��ѡ��
                document.frm.elements[i].checked = false;
            }
        }
    }
    
    function dynDelRow()
    {

        for(var a = document.all.dyntb.rows.length-1 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
        {
            if(document.all.R0[a].checked == true)
            {
                document.all.dyntb.deleteRow(a+1);
                break;
            }
        }
        document.all.addRecordNum.value = document.all.dyntb.rows.length-1;

    }


    function dyn_deleteAll()
    {
        //�������ޱ��е����?        for(var a = document.all.dyntb.rows.length-1 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
        {
                document.all.dyntb.deleteRow(a+1);
        }
        document.all.addRecordNum.value = document.all.dyntb.rows.length-1;
    }

    function verifyUnique(phone_no,isdn_no)
    {
        var tmp_phoneNo="";
        var tmp_isdnNo="";
        //var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
        var op_type = oprType_Add;


        for(var a = document.all.dyntb.rows.length-1 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
        {
              tmp_phoneNo = document.all.R1[a].value;
              tmp_isdnNo = document.all.R2[a].value;



            if( op_type == oprType_Add)
            {
              if((phone_no.trim() == tmp_phoneNo.trim())
                || (isdn_no.trim() == tmp_isdnNo.trim())){
                    return false;
                }
            }else{
              if( (isdn_no.trim() == tmp_isdnNo.trim())
              ){
                    return false;
                }

            }

        }

           return true;
    }


    function PubSimpSel_self(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
    {

        var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
        //var path = "../public/fPubSimpSel.jsp";
        path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
        path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
        path = path + "&selType=" + selType;

        retInfo = window.showModalDialog(path);
        if(typeof(retInfo) == "undefined")
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

    function oneTokSelf(str,tok,loc)
   {

   var temStr=str;
   //if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
   //if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);

    var temLoc;
    var temLen;
    for(ii=0;ii<loc-1;ii++)
    {
       temLen=temStr.length;
       temLoc=temStr.indexOf(tok);
       temStr=temStr.substring(temLoc+1,temLen);
    }
    if(temStr.indexOf(tok)==-1)
      return temStr;
    else
      return temStr.substring(0,temStr.indexOf(tok));
  }

    function call_ISDNNOINFO()
    {
        if(!checkElement(document.all.ISDNNO)) return false;

        var path = "f3210_no_infor.jsp";
        path = path + "?loginNo=" + document.frm.loginNo.value + "&phoneNo=" + document.frm.ISDNNO.value;
        path = path + "&opCode=" + "3210" + "&orgCode=" + document.frm.orgCode.value;

        var retInfo = window.showModalDialog(path);
        if(typeof(retInfo) == "undefined")
        {
            document.frm.USERNAME.value = "";
            document.frm.IDCARD.value = ""   ;
        }else{
            document.frm.USERNAME.value = oneTokSelf(retInfo,"|",1);
            document.frm.IDCARD.value = oneTokSelf(retInfo,"|",2);
            var sSmCode = oneTokSelf(retInfo,"|",3);
            if( sSmCode == "cb" )
            {
                rdShowMessageDialog("�������û���������VPMNҵ��");
                document.all.ISDNNO.focus();
                return false;
            }
            var run_code = oneTokSelf(retInfo,"|",6);
            
            if( run_code == "I" || run_code == "J"  )
            {
               
                rdShowMessageDialog("Ԥ��Ԥ���û���������VPMNҵ��");
                document.all.ISDNNO.focus();
                return false;
            }
            
            if( run_code != "A"  )
            {
               
                rdShowMessageDialog("�������û���������VPMNҵ��");
                document.all.ISDNNO.focus();
                return false;
            }
            var sTotalFee = oneTokSelf(retInfo,"|",4);
            if ( parseInt(sTotalFee) > 0 )
            {
                 check_phone();
            }
            else{
                dynAddRow();
            }
        }

    }

    function doValid()
    {
        with(document.frm)
        {
            if(isNullMy("GRPID")){rdShowMessageDialog("���źŲ���Ϊ��!"); return false;}

        }

        return true;
    }

    function judge_valid()
    {
    //var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
    var op_type = oprType_Add;

        //1.��鵥������
        if( !doValid() ) return false;

        if(!checkElement(document.all.GRPID)) return false;
        //if(!checkElement("PHONENO")) return false;
        //if(!checkElement("ISDNNO")) return false;
        if(!checkElement(document.all.CLOSENO1)) return false;
        if(!checkElement(document.all.CLOSENO2)) return false;
        if(!checkElement(document.all.CLOSENO3)) return false;
        if(!checkElement(document.all.CLOSENO4)) return false;
        if(!checkElement(document.all.CLOSENO5)) return false;
        if( document.frm.USERPIN1.value != "" ){
            if(!checkElement(document.all.USERPIN1)) return false;
        }
        if( document.frm.USERPIN2.value != "" ){
            if(!checkElement(document.all.USERPIN2)) return false;
        }

        if(!checkElement(document.all.OUTGRP)) return false;
        if(!checkElement(document.all.MAXOUTNUM)) return false;
        if(!checkElement(document.all.LMTFEE)) return false;


        if(!checkElement(document.all.PKGTYPE)) return false;
        if(!checkElement(document.all.PKGDAY)) return false;

        //2.�ж�������֮��Ĺ�ϵ
        if(document.all.CLOSENO1.value == "0")
        {
            if(document.all.CLOSENO2.value != "0" )
            {
                rdShowMessageDialog("���CLOSENO1Ϊ0����ôCLOSENO2ֻ��Ϊ0��");
                document.all.CLOSENO2.focus();
                document.all.CLOSENO2.select();
                return false;
            }
        }
        if(document.all.CLOSENO2.value == "0")
        {
            if(document.all.CLOSENO3.value != "0" )
            {
                rdShowMessageDialog("���CLOSENO2Ϊ0����ôCLOSENO3ֻ��Ϊ0��");
                document.all.CLOSENO3.focus();
                document.all.CLOSENO3.select();
                return false;
            }
        }
        if(document.all.CLOSENO3.value == "0")
        {
            if(document.all.CLOSENO4.value != "0" )
            {
                rdShowMessageDialog("���CLOSENO3Ϊ0����ôCLOSENO4ֻ��Ϊ0��");
                document.all.CLOSENO4.focus();
                document.all.CLOSENO4.select();
                return false;
            }
        }
        if(document.all.CLOSENO4.value == "0")
        {
            if(document.all.CLOSENO5.value != "0" )
            {
                rdShowMessageDialog("���CLOSENO4Ϊ0����ôCLOSENO5ֻ��Ϊ0��");
                document.all.CLOSENO5.focus();
                document.all.CLOSENO5.select();
                return false;
            }
        }
         if(document.all.USERPIN1.value != document.all.USERPIN2.value)
         {
             rdShowMessageDialog("�������ȷ�����벻�ȣ����������룡");
             return false;
         }

        //�������ڵ�ǰ����
        //checkFlag = dateCompare(NowDateTime(),document.frm.PKGDAY.value);
        /*if( (checkFlag == 1) || (checkFlag == 0) ){
            rdShowMessageDialog("�������ڵ�ǰ����!!");
            document.frm.PKGDAY.select();
            return false;
        }*/

        return true;
    }



    function isNullMy(obj)
    {
        if( document.all(obj).value == "" )
        {
            document.all(obj).focus();
            return true;
        }
        else{
            return false;
            }
    }
	//ѡ��¼�뷽ʽ
	function inputByNo(){
		if(document.frm.byNo.checked == true){
        window.document.frm.byFile.checked = false;
		}
		document.all.tableNo.style.display="";
		document.all.tableFile.style.display="none"; 
	}
	function inputByFile(){
		if(document.frm.byFile.checked == true){
        window.document.frm.byNo.checked = false;
		}
		document.all.tableNo.style.display="none";
		document.all.tableFile.style.display=""; 
	}
    function resetJsp()
    {
    //var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
    var op_type = oprType_Add;

        init();

     with(document.frm)
     {
        GRPID.value         = "";
        //GRPNAME.value     = "";
        DEPT.value          = "";
        USERPIN1.value      = "";
        USERPIN2.value      = "";
        PHONENO.value       = "";
        ISDNNO.value        = "";
        USERNAME.value      = "";
        IDCARD.value        = "";
        PCOMMENT.value      = "";
        //SUCCESSNUM.value  = "";
        //FAILNUM.value     = "";
        //SKIPNUM.value     = "";
        //INEXISTNUM.value  = "";
        opNote.value        = "";
     }

        dyn_deleteAll();
        reset_globalVar();
		document.frm.confirm.disabled=false;
    }

function commitJsp()
{
		var rows=dyntb.rows.length
		if(rows==1){
			rdShowMessageDialog("���Ȳ�ѯ��Ա��Ϣ!!");
			return false;
		}

    var ind1Str ="";
    var ind2Str ="";
    var ind3Str ="";
    var ind4Str ="";
    var ind5Str ="";
		var tmpStr="";
		var op_type = oprType_Upd;
		var procSql = "";
		
		if( !judge_valid() )
		{
			return false;
		}
		var a=0;
		if( document.all.R0.length == undefined){
			if( document.all.R0.checked == false){
				rdShowMessageDialog("����ѡ���ų�Ա!!");
				return false;
			}else{
					ind1Str =ind1Str +document.all.R1.value+"|";
					ind2Str =ind2Str +document.all.R2.value+"|";
					ind3Str =ind3Str +document.all.R3.value+"|";
			}
			a+=1;
		}
		else{
			
			for(var i=0; i<document.all.R0.length ;i++){
				if( document.all.R0[i].checked == true){
					a+=1;
					ind1Str =ind1Str +document.all.R1[i].value+"|";
					ind2Str =ind2Str +document.all.R2[i].value+"|";
					ind3Str =ind3Str +document.all.R3[i].value+"|";
				}
			}
			if(a==0){
				rdShowMessageDialog("����ѡ���ų�Ա!!");
				return false;
			}
		}
		
		if(document.all.PKGTYPE.value=="0"&&document.all.limitcount.value=="1")
		{
			rdShowMessageDialog("�ü������ʷѲ���ʹ�ã���Ϊ���ų�Աѡ������ײ��ʷ�!");
			return false;
		}
		
		document.all.tmpR1.value = ind1Str;
		document.all.tmpR2.value = ind2Str;
		document.all.tmpR3.value = ind3Str;
    		document.all.tmpR4.value = ind4Str;
  		document.all.tmpR5.value = ind5Str;
		document.frm.FLAGS.disabled = false;
		
	 	tmpStr = "�޸� " + "�̺�";
	 	document.frm.opCode.value="3214";
		document.frm.opNote.value =  tmpStr;

		var tmpStatusFlag = 0;
		var tmpFeeFlag = 0;
		if( document.frm.STATUS1.selectedIndex > -1 ) tmpStatusFlag ++;
		if( document.frm.STATUS2.selectedIndex > -1 ) tmpStatusFlag ++;
		if( document.frm.STATUS3.selectedIndex > -1 ) tmpStatusFlag ++;
		
		if( (tmpStatusFlag > 0) && (tmpStatusFlag != 3) ){
			rdShowMessageDialog("״̬��������ÿһ������޸�,����ֻ�޸Ĳ�����!!");
			return false;			
		}
		
		if( document.frm.FEEFLAG1.selectedIndex > -1 ) tmpFeeFlag ++;
		if( document.frm.FEEFLAG2.selectedIndex > -1 ) tmpFeeFlag ++;
		if( document.frm.FEEFLAG3.selectedIndex > -1 ) tmpFeeFlag ++;
		if( document.frm.FEEFLAG4.selectedIndex > -1 ) tmpFeeFlag ++;
		
		if( (tmpFeeFlag > 0) && (tmpFeeFlag != 4) ){
			rdShowMessageDialog("�����޶��־��ÿһ������޸�,����ֻ�޸Ĳ�����!!");
			return false;
		}
		
		document.frm.STATUS.value = document.frm.STATUS1.value +
									document.frm.STATUS2.value +
									document.frm.STATUS3.value ;
		document.frm.FEEFLAG.value = document.frm.FEEFLAG1.value +	
									 document.frm.FEEFLAG2.value +	
									 document.frm.FEEFLAG3.value +	
									 document.frm.FEEFLAG4.value;
		
		var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	    if(typeof(ret)!="undefined")
	     {
	        if((ret=="confirm"))
	        {
	          if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
	          {
	             
						    var myPacket = new AJAXPacket("f3214_rpc_confirm.jsp?op_note="+document.frm.opNote.value+
						    								"&deparment="+document.frm.DEPT.value+
						    								"&user_name="+document.frm.tmpR3.value+
						    								"&id_card="+document.frm.tmpR4.value+
						    								"&p_comment="+document.frm.tmpR5.value+
						    								"&unit_id_id="+document.frm.unit_id.value.substring(0,document.frm.unit_id.value.indexOf("-"))//luxc
						    								,"����ȷ�ϣ����Ժ�......");
							
								myPacket.data.add("verifyType","confirm");	
								myPacket.data.add("opType", oprType_Upd);	
								
						
								//Ĭ��Ϊ�գ��޸�ʱ��
								if( document.frm.USERPIN1.value == "" ){
									document.frm.USERPIN1.value = "";
								}	
								//�û�����Ȩ�޼�Ĭ��Ϊ�գ��û����ı��ʱ��
								var flags_tmp = "";
								flags_tmp = document.frm.FLAGS.value;
								myPacket.data.add("loginNo",document.frm.loginNo.value);
								myPacket.data.add("orgCode",document.frm.orgCode.value);
								myPacket.data.add("opCode",document.frm.opCode.value);
								myPacket.data.add("GRPID",document.frm.GRPID.value);
								myPacket.data.add("CLOSENO1",document.frm.CLOSENO1.value);
								myPacket.data.add("CLOSENO2",document.frm.CLOSENO2.value);
								myPacket.data.add("CLOSENO3",document.frm.CLOSENO3.value);
								myPacket.data.add("CLOSENO4",document.frm.CLOSENO4.value);
								myPacket.data.add("CLOSENO5",document.frm.CLOSENO5.value);
								myPacket.data.add("USERPIN1",document.frm.USERPIN1.value);
								myPacket.data.add("LOCKFLAG",document.frm.LOCKFLAG.value);
								myPacket.data.add("FLAGS", flags_tmp);
								myPacket.data.add("STATUS",document.frm.STATUS.value);
								myPacket.data.add("USERTYPE",document.frm.USERTYPE.value);
								myPacket.data.add("OUTGRP",document.frm.OUTGRP.value);
								myPacket.data.add("MAXOUTNUM",document.frm.MAXOUTNUM.value);
								myPacket.data.add("FEEFLAG",document.frm.FEEFLAG.value);
								myPacket.data.add("LMTFEE",document.frm.LMTFEE.value);
								myPacket.data.add("PKGTYPE",document.frm.PKGTYPE.value);
								myPacket.data.add("FEETYPE","");
								if( document.frm.PKGDAY.value == ""){
									myPacket.data.add("PKGDAY",document.frm.PKGDAY.value);
								}else{
									myPacket.data.add("PKGDAY",document.frm.PKGDAY.value);
								}
								myPacket.data.add("tmpR1",document.frm.tmpR1.value);
								myPacket.data.add("tmpR2",document.frm.tmpR2.value);
								var strType=""
								for(i=0;i<a;i++){
									strType+="1|";
								}
								myPacket.data.add("strType",strType);
						    core.ajax.sendPacket(myPacket);
						    myPacket =null;
						   // delete(myPacket);	
	          }
		      }
		      if(ret=="continueSub")
		      {
	          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
	          {
						    var myPacket = new AJAXPacket("f3214_rpc_confirm.jsp?op_note="+document.frm.opNote.value+
						    								"&deparment="+document.frm.DEPT.value+
						    								"&user_name="+document.frm.tmpR3.value+
						    								"&id_card="+document.frm.tmpR4.value+
						    								"&p_comment="+document.frm.tmpR5.value+
						    								"&unit_id_id="+document.frm.unit_id.value.substring(0,document.frm.unit_id.value.indexOf("-"))//luxc
						    								,"����ȷ�ϣ����Ժ�......");
							
								myPacket.data.add("verifyType","confirm");	
								myPacket.data.add("opType", oprType_Upd);	
								
						
								//Ĭ��Ϊ�գ��޸�ʱ��
								if( document.frm.USERPIN1.value == "" ){
									document.frm.USERPIN1.value = "";
								}	
								//�û�����Ȩ�޼�Ĭ��Ϊ�գ��û����ı��ʱ��
								var flags_tmp = "";
								flags_tmp = document.frm.FLAGS.value;
								myPacket.data.add("loginNo",document.frm.loginNo.value);
								myPacket.data.add("orgCode",document.frm.orgCode.value);
								myPacket.data.add("opCode",document.frm.opCode.value);
								myPacket.data.add("GRPID",document.frm.GRPID.value);
								myPacket.data.add("CLOSENO1",document.frm.CLOSENO1.value);
								myPacket.data.add("CLOSENO2",document.frm.CLOSENO2.value);
								myPacket.data.add("CLOSENO3",document.frm.CLOSENO3.value);
								myPacket.data.add("CLOSENO4",document.frm.CLOSENO4.value);
								myPacket.data.add("CLOSENO5",document.frm.CLOSENO5.value);
								myPacket.data.add("USERPIN1",document.frm.USERPIN1.value);
								myPacket.data.add("LOCKFLAG",document.frm.LOCKFLAG.value);
								myPacket.data.add("FLAGS", flags_tmp);
								myPacket.data.add("STATUS",document.frm.STATUS.value);
								myPacket.data.add("USERTYPE",document.frm.USERTYPE.value);
								myPacket.data.add("OUTGRP",document.frm.OUTGRP.value);
								myPacket.data.add("MAXOUTNUM",document.frm.MAXOUTNUM.value);
								myPacket.data.add("FEEFLAG",document.frm.FEEFLAG.value);
								myPacket.data.add("LMTFEE",document.frm.LMTFEE.value);
								myPacket.data.add("PKGTYPE",document.frm.PKGTYPE.value);
								myPacket.data.add("FEETYPE","");
								if( document.frm.PKGDAY.value == ""){
									myPacket.data.add("PKGDAY",document.frm.PKGDAY.value);
								}else{
									myPacket.data.add("PKGDAY",document.frm.PKGDAY.value);
								}
								myPacket.data.add("tmpR1",document.frm.tmpR1.value);
								myPacket.data.add("tmpR2",document.frm.tmpR2.value);
								var strType=""
								for(i=0;i<a;i++){
									strType+="1|";
								}
								myPacket.data.add("strType",strType);
						    core.ajax.sendPacket(myPacket);
						    myPacket=null;
						    //delete(myPacket);	
	          }
		      }
		    }
		    else
	      {
	        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
	        {
						    var myPacket = new AJAXPacket("f3214_rpc_confirm.jsp?op_note="+document.frm.opNote.value+
						    								"&deparment="+document.frm.DEPT.value+
						    								"&user_name="+document.frm.tmpR3.value+
						    								"&id_card="+document.frm.tmpR4.value+
						    								"&p_comment="+document.frm.tmpR5.value+
						    								"&unit_id_id="+document.frm.unit_id.value.substring(0,document.frm.unit_id.value.indexOf("-"))//luxc
						    								,"����ȷ�ϣ����Ժ�......");
							
								myPacket.data.add("verifyType","confirm");	
								myPacket.data.add("opType", oprType_Upd);	
								
						
								//Ĭ��Ϊ�գ��޸�ʱ��
								if( document.frm.USERPIN1.value == "" ){
									document.frm.USERPIN1.value = "";
								}	
								//�û�����Ȩ�޼�Ĭ��Ϊ�գ��û����ı��ʱ��
								var flags_tmp = "";
								flags_tmp = document.frm.FLAGS.value;
								myPacket.data.add("loginNo",document.frm.loginNo.value);
								myPacket.data.add("orgCode",document.frm.orgCode.value);
								myPacket.data.add("opCode",document.frm.opCode.value);
								myPacket.data.add("GRPID",document.frm.GRPID.value);
								myPacket.data.add("CLOSENO1",document.frm.CLOSENO1.value);
								myPacket.data.add("CLOSENO2",document.frm.CLOSENO2.value);
								myPacket.data.add("CLOSENO3",document.frm.CLOSENO3.value);
								myPacket.data.add("CLOSENO4",document.frm.CLOSENO4.value);
								myPacket.data.add("CLOSENO5",document.frm.CLOSENO5.value);
								myPacket.data.add("USERPIN1",document.frm.USERPIN1.value);
								myPacket.data.add("LOCKFLAG",document.frm.LOCKFLAG.value);
								myPacket.data.add("FLAGS", flags_tmp);
								myPacket.data.add("STATUS",document.frm.STATUS.value);
								myPacket.data.add("USERTYPE",document.frm.USERTYPE.value);
								myPacket.data.add("OUTGRP",document.frm.OUTGRP.value);
								myPacket.data.add("MAXOUTNUM",document.frm.MAXOUTNUM.value);
								myPacket.data.add("FEEFLAG",document.frm.FEEFLAG.value);
								myPacket.data.add("LMTFEE",document.frm.LMTFEE.value);
								myPacket.data.add("PKGTYPE",document.frm.PKGTYPE.value);
								myPacket.data.add("FEETYPE","");
								if( document.frm.PKGDAY.value == ""){
									myPacket.data.add("PKGDAY",document.frm.PKGDAY.value);
								}else{
									myPacket.data.add("PKGDAY",document.frm.PKGDAY.value);
								}
								myPacket.data.add("tmpR1",document.frm.tmpR1.value);
								myPacket.data.add("tmpR2",document.frm.tmpR2.value);
								var strType=""
								for(i=0;i<a;i++){
									strType+="1|";
								}
								myPacket.data.add("strType",strType);
						    core.ajax.sendPacket(myPacket);
						    myPacket=null;
						    //delete(myPacket);	
	        }
	      }	
		   
}

function document_onkeydown()
{

    if (window.event.srcElement.type!="button" && window.event.srcElement.type!="textarea")
    {

        if (window.event.keyCode == 13)
        {
            window.event.keyCode = 9;
        }
    }
}


	function printInfo(printType)
	{		
				
		var unit_id=null;
		var PKGTYPE=null;
			
		if(document.all.unit_id.options.length>0){
			unit_id=document.all.unit_id.options[document.all.unit_id.selectedIndex].text;
			PKGTYPE=document.all.PKGTYPE.options[document.all.PKGTYPE.selectedIndex].text;
		}				
				
		var retInfo = "";
	      retInfo+='<%=loginNo%>  <%=loginName%>'+"|";
	      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())%>'+"|";
	      
		    retInfo+="���ű�ţ�"+document.all.GRPID.value+"|";
	      retInfo+="�������ƣ�"+unit_id+"|";
	      retInfo+=" "+"|";
	      retInfo+=" "+"|";
	      retInfo+=" "+"|";
	      retInfo+=" "+"|";
	      retInfo+=" "+"|";
	      retInfo+=" "+"|";
	      retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
	      retInfo+=" "+"|";
	      retInfo+=" "+"|";
	      
	      retInfo+="����ҵ��"+"������VPMN�����޸ļ��ų�Ա"+"|";
	      retInfo+="�޸ĵ��ֻ����룺"+(document.all.tmpR2.value).replace(/\|/g,",")+"|";
	      retInfo+="��Ӧԭ�ʷ����ͣ�"+(document.all.tmpR3.value).replace(/\|/g,",")+"|";
		    retInfo+="�����ʷ����ͣ�"+PKGTYPE+"|";
		    retInfo+="�����ʷ���Чʱ�䣺"+document.all.PKGDAY.value+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
	      retInfo+=" "+"|";
	      retInfo+=" "+"|";
	
		  return retInfo;
	}

	 function showPrtDlg(printType,DlgMessage,submitCfm)
	{  //��ʾ��ӡ�Ի��� 
	     var h=162;
	     var w=352;
	     var t=screen.availHeight/2-h/2;
	     var l=screen.availWidth/2-w/2;
	   
	     var printStr = printInfo(printType);
	   
	     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	     var path = "<%=request.getContextPath()%>/npage/innet/hljGdPrint.jsp?DlgMsg=" + DlgMessage;
	     var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
	     var ret=window.showModalDialog(path,"",prop);
	     return ret;     
	}

	function getPhoneList(){
		var rows=dyntb.rows.length
		for(i=1;i<rows;i++){
			dyntb.deleteRow(1);
		}
		if(document.all.GRPID.value==""){
			rdShowMessageDialog("�������뼯�ű�ţ�");
			return false;
		}
		
		if(!forNonNegInt(document.all.sNo) || !forNonNegInt(document.all.lNo)){
			return false;
		}
		var shortNo = document.frm.sNo.value;			
		//wuxy alter 20090427 Ϊ�������
		/*if(shortNo.length > 6 || shortNo.length < 4){
		  	rdShowMessageDialog("�̺ų��ȱ�����4-6λ!!");
		  	return false;	  			
		}
		
	
	    if(shortNo.substr(0,1) !=6)
	   	{
	   		rdShowMessageDialog("�̺��������6��ͷ!");
	   		return false;
	   	}
	   	
	   	if(shortNo.substr(1,1) ==0)
	   	{
	   		rdShowMessageDialog("�̺���ڶ�λ����Ϊ0!");
	   		return false;
	   	} 	*/	
		var myPacket = new AJAXPacket("f3214_getPhoneNo.jsp","���ڶ�ȡ���ݣ����Ժ�......");
		var groupNo=document.all.GRPID.value.trim();
		myPacket.data.add("verifyType","phoneNo");
		myPacket.data.add("groupNo",groupNo);
		myPacket.data.add("sNo",document.all.sNo.value);
		myPacket.data.add("lNo",document.all.lNo.value);
		core.ajax.sendPacket(myPacket);
		myPacket=null;
		//delete(myPacket);
	}
	function getOtherPhoneList(){
		var rows=dyntb.rows.length
		for(i=1;i<rows;i++){
			dyntb.deleteRow(1);
		}
		if(document.all.GRPID.value==""){
			rdShowMessageDialog("�������뼯�ű�ţ�");
			return false;
		}
		
		if(!forNonNegInt(document.all.sNo) || !forNonNegInt(document.all.lNo)){
			return false;
		}
		
		var myPacket = new AJAXPacket("f3214_getOtherPhoneNo.jsp","���ڶ�ȡ���ݣ����Ժ�......");
		var groupNo=document.all.GRPID.value.trim();
		myPacket.data.add("verifyType","phoneNo");
		myPacket.data.add("groupNo",groupNo);
		myPacket.data.add("sNo",document.all.sNo.value);
		myPacket.data.add("lNo",document.all.lNo.value);
		core.ajax.sendPacket(myPacket);
		myPacket=null;
		//delete(myPacket);
	}
	function clearRows(){
		var rows=dyntb.rows.length
		for(i=1;i<rows;i++){
			dyntb.deleteRow(1);
		}
	}

//-->
</script>
</head>
	<body>
		<form name="frm" method="post" action="" onKeyDown="document_onkeydown()">
			<input name="CLOSENO1" type="hidden"  id="CLOSENO1" maxlength="8" v_must=1 v_type=0_9 v_minlength=1    value="">
			<input name="CLOSENO2" type="hidden"  id="CLOSENO2" maxlength="8" v_must=1 v_type=0_9 v_minlength=1    value="">
			<input name="CLOSENO3" type="hidden"  id="CLOSENO3" maxlength="8" v_must=1 v_type=0_9 v_minlength=1    value="">
			<input name="CLOSENO4" type="hidden"  id="CLOSENO4" maxlength="8" v_must=1 v_type=0_9 v_minlength=1    value="">
			<input name="CLOSENO5" type="hidden"  id="CLOSENO5" maxlength="8" v_must=1 v_type=0_9 v_minlength=1    value="">
			<input name="LOCKFLAG" type="hidden"  id="LOCKFLAG" maxlength="8" v_must=1 v_type=0_9 v_minlength=8    value="0"> 
			<input name="USERPIN1" type="hidden"  id="USERPIN1" maxlength="8" v_must=1 v_type=0_9 v_minlength=8    value="">
			<input name="USERPIN2" type="hidden"  id="USERPIN2" maxlength="8" v_must=1 v_type=0_9 v_minlength=8    value="">
			<!--input name="FLAGS" type="hidden" disabled  id="FLAGS" size="36" maxlength="36" value=""-->
			<input name="OUTGRP" type="hidden"  id="OUTGRP" maxlength="8" v_must=1 v_type=0_9 v_minlength=1    value="">
			<input name="MAXOUTNUM" type="hidden"  id="MAXOUTNUM" maxlength="8" v_must=1 v_type=0_9 v_minlength=1    value="">
			<input name="limitcount" type="hidden"  id="limitcount"  v_must=1 v_type=0_9 v_minlength=1    value=""> 
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">                                   																																															  
				<div id="title_zi">�����޸ļ��ų�Ա</div>     																																															  
			</div> 
        		<table  cellspacing="0">
	          		<tr width="100%">            
	            			<td class="blue" width="15%" colspan="1">���ű��</td>
		            		<td width="30%" colspan="2">
		              			<input name="GRPID" type="text"  id="GRPID"  maxlength="10" v_must=1 v_type=0_9 v_minlength=10   onchange="clearRows()">              
					              <input name="getUI" type="button" class="b_text" value="��ѯ" onclick="getUnitId()"></input>
		              			<font class="orange">*</Font>
		              		  </td>
		            		<td class="blue" colspan="1" width="15%">�û�����</td>
		            		<td colspan="2" width="40%">
		              			<input name="DEPT" type="text"  id="DEPT" maxlength="36">  
		              		  </td>
					       </tr>
					       <tr>	
					          <td class="blue" colspan="1">���Ź���ϵͳID</td>			     
		           		  <td colspan="5">
					              <select name="unit_id"  id="unit_id">
					              </select>
					              </td>		  
			       </tr>		  
	         	 <tr>
	            		<td class="blue" colspan="1">�û����ܼ�</td>
			            <td colspan="5">
				              <input name="FLAGS" type="text"  class="InputGrey" id="FLAGS" size="36" maxlength="36" readonly>
				              <input name="updateFlags" type="button" class="b_text" id="updateFlags" value="�޸�" onClick="call_FLAGS()">
			            </td>
	           </tr>    
		         <tr>
		         	      <td class="blue" colspan="1">���˸��ѷ�����־</td>
		                <td colspan="2">
			                    <select name="STATUS1" id="STATUS1">
				                      <option value="0">0--&gt;δ����</option>
				                      <option value="1">1--&gt;�ѷ���</option>
			                    </select>
		                      </td>
		                  <td class="blue" colspan="1">��������</td>
		                  <td colspan="2">
			                    <select name="STATUS2" id="STATUS2">
						                  <option value="1">1--&gt;��ͨ��</option>
				                      <option value="0">0--&gt;δ��������</option>
				                      <option value="2">2--&gt;Ӣ��</option>
				                      <option value="3">3--&gt;�ط���</option>
			                    </select>
		                      </td>
		           </tr>
		           <tr>
		                  <td class="blue" colspan="1">���к�����ʾ��ʽ</td>
		                  <td colspan="2">
			                    <select name="STATUS3" id="STATUS3">
				                      <option value="1">1--&gt;��ʾ�̺�</option>
				                      <option value="2">2--&gt;��ʾ��ʵ����</option>
				                      <option value="3">3--&gt;PBX������ʾ��ʵ����</option>
				                      <option value="4">4--&gt;����������ʾ�̺�</option>
			                    </select>
		            <td width="15%" class="blue" colspan="1">�û�����</td>
		            <td width="20%" colspan="2">
			              <select name="USERTYPE" id="USERTYPE">
				                <option value="0" selected>0--&gt;��ͨ�û�</option>
				                <option value="1">1--&gt;����Ա</option>
			              </select>
		            </td>	
		                  </td>
		          </tr>   
		          <tr>
		          	<td class="blue" colspan="1">����</td>
			          <td colspan="2">
				                    <select name="FEEFLAG1" id="FEEFLAG1">
					                      <option value="0" selected>0--&gt;���Ÿ������޶�</option>
					                      <option value="1" >1--&gt;���˸��Ѳ��޶�</option>
				                    </select>
			                     </td>
		                  <td class="blue" colspan="1">����</td>
		                  <td colspan="2">
			                    <select name="FEEFLAG2" id="FEEFLAG2">
				                      <option value="0" selected>0--&gt;���Ÿ������޶�</option>
				                      <option value="1">1--&gt;���˸��Ѳ��޶�</option>
			                    </select>
		                  </td>
		            </tr>
		            <tr>
		                  <td class="blue" colspan="1">��������</td>
		                  <td colspan="2">
			                    <select name="FEEFLAG3" id="FEEFLAG3">
				                      <option value="0" selected>0--&gt;���Ÿ������޶�</option>
				                      <option value="1">1--&gt;���˸��Ѳ��޶�</option>
			                    </select>
		                  </td>
		                  <td class="blue" colspan="1">���������</td>
		                  <td colspan="2">
			                    <select name="FEEFLAG4" id="FEEFLAG4">
				                      <option value="0" selected>0--&gt;���Ÿ������޶�</option>
				                      <option value="1">1--&gt;���˸��Ѳ��޶�</option>
			                    </select>
		                  </td>
		           </tr>		             
          
		          <tr>
		            	<td class="blue" colspan="1">�·����޶�</td>
			         <td colspan="2">
				              <input name="LMTFEE" type="text"  id="LMTFEE" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   >
				              <font class="orange">*</Font>
			          </td>
		            	<td colspan="1" class="blue">�����ʷ���Ч����<br>(��ʽ��YYYY-MM-DD)</td>
		            	<td colspan="2" >
		              		<input name="PKGDAY" type="text"  id="PKGDAY" maxlength="10" v_format="YYYY-MM-DD"  v_minlength=10    value="<%=dateStr%>">
		              		<font class="orange">*</Font>
		           	</td>
		          </tr>
		          
		          <tr  id="SHOWADD3">      
		            	<td colspan="1" class="blue">���·��ʷ�����</td>
		            	<td colspan="5">
		              		 <select name="PKGTYPE" id="PKGTYPE">
					           <%
					            for(int i=0;i<recordNum; i++){
					            out.println("<option class='button' value='"+result[i][0]+"'>"+result[i][1]+"</option>");
					            }
					          %>
              				</select>		              		
		            	</td>
		          </tr>
          	</table>
          	
	          <br>
		  <div class="title">
			<div id="title_zi">���м��ų�Ա������Ϣ</div>
		  </div>
	  	<table  cellspacing="0">          
	          <tr>
		            <td width="15%" class="blue">�̺�</td>
		            <td>
		              		<input name="sNo" type="text"  id="sNo" maxlength="6" v_type=0_9 >
		             </td>
		            <td width="20%" class="blue">��ʵ����</td>
		            <td colspan=3>
			              <input name="lNo" type="text"  id="lNo" maxlength="12" v_type=0_9   >
			              <input name="NoButton" type="button" class="b_text" id="NoButton" value="��ѯ" onclick="getPhoneList()">
			              <input name="OtherNoButton" type="button" class="b_text" id="OtherNoButton" value="��ѯ���ƶ�����" onclick="getOtherPhoneList()">
		           </td>
	          </tr>	    
	                
	          <tr>
	            	<td colspan=6 width="15%"><font color="#FF0000">(ע�⣺ÿ�β�ѯֻѡ������������ǰ50����)</font></td>
	          </tr>
	          </table>          
		 
              	<table  id="dyntb" cellspacing="0">
	                <tr>
		                  <td align=center nowrap class="blue">ѡ��
		                  <input type="button" class="b_text" value="ȫѡ" onclick="allChoose()">	
		                  <input type="button" class="b_text" value="ȡ��" onclick="cancelChoose()">
		                  </td>
		                  <td align=center class="blue">�̺�</td>
		                  <td align=center  class="blue">��ʵ����</td>
		                  <td align=center class="blue">��ǰ�ʷ�</td>		               
		                  <td align=center class="blue">������Ϣ</td>
		                  <td align=center class="blue">ִ��״̬</td>
	                </tr>
                        <tr id="tr0" style="display:none">
		                  <td>
		                    <div align="center">
		                      <input type="checkBox" id="R0" value="">
		                    </div>
		                  </td>
		                  <td>
		                    <div align="center">
		                      <input type="text" id="R1" value="">
		                    </div>
		                  </td>
		                  <td>
		                    <div align="center">
		                      <input type="text" id="R2" value="">
		                    </div>
		                  </td>
		                  <td>
		                    <div align="center">
		                      <input type="text" id="R3" value="">
		                    </div>
		                  </td>
		                  <td>
		                    <div align="center">
		                      <input type="text" id="R5" value="">
		                    </div>
		                  </td>
		                  <td>
		                    <div align="center">
		                      <input type="text" id="R6" value="">
		                    </div>
		                  </td>
                		</tr>
			</table>
			
			<table cellspacing="0">
		        	<tr>
		            		<td width="15%" class="blue">��ע��Ϣ</td>
			            	<td colspan="5">			              		
			              		<input name="opNote" type="text" class="InputGrey" id="opNote" size="60" maxlength="10" readonly >
			            	</td>
		          	</tr>	
		        <table>	
		        
		        <table cellspacing="0">
			    <tr> 
			    	<td id="footer"> 			    		
			    		<input name="confirm" type="button" class="b_foot" value="ȷ��" onClick="commitJsp()">
			    		&nbsp;
			            <input name="reset" type="button" class="b_foot" value="���" onClick="resetJsp()">
			                &nbsp;
			            <input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="�ر�">
			   	</td>
			    </tr>
  			</table> 	
		    <%@ include file="/npage/include/footer.jsp" %>
		    <input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
		    <input type="hidden" name="loginName" id="loginName" value="">
		    <input type="hidden" name="opCode" id="opCode" value="">
		    <input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
		    <input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
		    <input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">		
		
		    <input type="hidden" name="tmpFLAGS" id="tmpFLAGS" value="">
		    <input type="hidden" name="tmpLOCKFLAG" id="tmpLOCKFLAG" value="">
		    <input type="hidden" name="tmpUSERTYPE" id="tmpUSERTYPE" value="">
		    <input type="hidden" name="tmpCURFEETYPE" id="tmpCURFEETYPE" value="">
		    <input type="hidden" name="tmpFEETYPE" id="tmpFEETYPE" value="">
		
		    <input type="hidden" name="STATUS" id="STATUS" value="">
		    <input type="hidden" name="FEEFLAG" id="FEEFLAG" value="">
		    <input type="hidden" name="USERPIN" id="USERPIN" value="">
		
		    <input type="hidden" name="tmpR1" id="tmpR1" value="">
		    <input type="hidden" name="tmpR2" id="tmpR2" value="">
		    <input type="hidden" name="tmpR3" id="tmpR3" value="">
		    <input type="hidden" name="tmpR4" id="tmpR4" value="">
		    <input type="hidden" name="tmpR5" id="tmpR5" value="">
		    <input type="hidden" name="tmpR6" id="tmpR6" value="">
		
		    <input type="hidden" name="tmpAddShortNo" id="tmpAddShortNo" value="">
		    <input type="hidden" name="tmpAddRealNo" id="tmpAddRealNo" value="">
		    <input type="hidden" name="ContractNum" id="ContractNum" value="">

		    <input type="hidden" name="connRegionCode" id="connRegionCode" value="">
		    <input type="hidden" name="org_id"  value="<%=OrgId%>">
		    <input type="hidden" name="group_id"  value="<%=GroupId%>">
		    <input type="hidden" name="opName" value="<%=opName%>">
		
		</form>
	</body>
</html>
