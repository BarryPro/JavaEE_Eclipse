<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page errorPage="/npage/common/errorpage.jsp" %><%/*update by diling for Ӫҵ��������weblogic�����Բ�����@2011/10/27 */%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.math.BigDecimal"%>
<%
    /* BEGIN : add by qidp for ϵͳ���� @ 2010-04-19 */
    String versonType = WtcUtil.repNull((String)session.getAttribute("versonType"));    // ҳ���ܰ汾:: normal:��ͨ��;simple:���ٰ�.
    System.out.println("$ versonType = "+versonType);
    
    String cssPath = (String)session.getAttribute("themePath")==null?"default":(String)session.getAttribute("themePath");
    
    //��ֹ�ظ�������
    String accountType_f_Ng35 =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");
%>

<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="/njs/extend/jquery/jquery.dimensions.js"></script>	
<script type="text/javascript" src="/njs/extend/jquery/tooltip/jquery.tooltip.pack.js"></script>
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="/njs/csp/checkWork_dialog.js"></script>
<script type="text/javascript" src="/njs/extend/jquery/block/jquery.blockUI.js"></script>
<!-- <script type="text/javascript" src="/njs/si/rightKey.js" defer="true"></script>	 -->
<script language="JavaScript" src="/njs/si/desAPI.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
<script language="JavaScript" src="/njs/si/prompt.js"></script>
<script language="JavaScript" src="/njs/si/rewriteSMD.js"></script>
<link href="/nresources/<%=cssPath%>/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/prompt.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/rightKey.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="/njs/extend/jquery/tooltip/jquery.tooltip.js"></script>	
<link href="/njs/extend/jquery/tooltip/jquery.tooltip.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/ng35_kf.css" rel="stylesheet" type="text/css"></link><!--hejwa ���� ng3.5��ʽ-->
<!------hejwa������ng3.5��Ŀ����-----2012-12-12-------------��ʼ----------------------->
<style>
	input.input-style2{	background-color:#ffffcc;}
	tr.even_hig{	background-color:#cfc; }
	td.even_ng35_trcolor{background:#F7F7F7;}
</style>
<!------hejwa������ng3.5��Ŀ����-----2012-12-12-------------����----------------------->
	<%-- /**  modified by hejwa in 20110714 ��OP����--������ͨѶ����  begin **/ --%>
<% 

String rightkey_public_flag = (String)session.getAttribute("rightkey_public_flag");
String rightkey_public = "0";
String rightKeyArr = "";//����ȫ��

if(rightkey_public_flag==null){//���Ϊ�գ���һ�β�ѯ
String wkSql_public = "select to_char(is_commu) from dwkspace where login_no=:login_no";
String wkparam_public ="login_no="+(String)session.getAttribute("workNo");
String region_code_public = ((String)session.getAttribute("orgCode")).substring(0,2);

%>
<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" retcode="wkretCode" retmsg="wkretMsg" routerValue="<%=region_code_public%>">
  	<wtc:param value="<%=wkSql_public%>"/>
  	<wtc:param value="<%=wkparam_public%>"/>
</wtc:service>
<wtc:array id="wkResult_public" scope="end"/>
<%
	System.out.println(wkretCode);
	if("000000".equals(wkretCode)){
			if(wkResult_public.length>0){
					rightkey_public = wkResult_public[0][0].trim();	
					session.setAttribute("rightkey_public_flag",rightkey_public);	
			}else{
				session.setAttribute("rightkey_public_flag","0");	
			}	
	}else{
		session.setAttribute("rightkey_public_flag","0");
	}
	System.out.println("rightkey_public="+rightkey_public);
}else{
	rightkey_public = (String)session.getAttribute("rightkey_public_flag");
}	
if("1".equals(rightkey_public)) {//����������ͨѶ
%> 
	<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/rightKey.js" defer="true" ></script>  --%>
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/rightKey.css" rel="stylesheet" type="text/css"></link>
	

	<%
		String wkCode = request.getParameter("opCode");
		String wk_sql = "select lower(wkspace_code),field from dcommunicate where lower(wkspace_code) in (:wkspace_code ,'all') and is_effect ='1'";
		String wk_param = "wkspace_code="+wkCode;
		System.out.println("-----------------wkCode---------------------"+wkCode);
		%>
		<wtc:service name="TlsPubSelCrm"  retcode="wkspaceRetCode" retmsg="wkspaceRetMsg"  outnum="2">
			<wtc:param value="<%=wk_sql%>" />
			<wtc:param value="<%=wk_param%>" />
		</wtc:service>
		<wtc:array id="wkspace" scope="end"/>
		<%	
	for(int iii=0;iii<wkspace.length;iii++){
		for(int jjj=0;jjj<wkspace[iii].length;jjj++){
			System.out.println("---------------------wkspace["+iii+"]["+jjj+"]=-----------------"+wkspace[iii][jjj]);
		}
	}
		//������ͨѶ
		
		int allWkFlag = 0; //������ͨѶ�ֶΣ�ȫ������������ȫ�֡�
		
		String opCodeStr = "";
		String allWkStr = "";			
		
		if("000000".equals(wkspaceRetCode)){ 
			if(wkspace.length>0){
				allWkFlag = 1;
				for(int i=0;i<wkspace.length;i++){
					if("all".equals(wkspace[i][0])){
						allWkStr = wkspace[i][1];
					}else{
						opCodeStr = wkspace[i][1];
					}
				}
			}
		}
		if(allWkFlag != 0){
		    rightKeyArr = allWkStr;
		    if(!"".equals(opCodeStr)){
		        if(!"".equals(rightKeyArr)){
		            rightKeyArr+=","+opCodeStr;
		        }else{
		            rightKeyArr = opCodeStr;
		        }
		    }
		}
		
	%>
	
<%}%>
<script type="text/javascript" language="JavaScript">
  		var rightKeyArr = '<%=rightKeyArr%>'.split(",");
	</script>
<%-- /**  modified by hejwa in 20110714 ��OP����--������ͨѶ����  end **/ --%>
<!-- 20091215 add by fengry for MAC��ַ -->
<%
	String qxjy_allowEnd = (String)session.getAttribute("allowend");
	if (qxjy_allowEnd != null) {
		String qxjy_cccTime=new java.text.SimpleDateFormat("HHmmss", Locale.getDefault()).format(new java.util.Date());
		System.out.println("----- qxjy ----- " + Integer.parseInt(qxjy_allowEnd) + " , " + Integer.parseInt(qxjy_cccTime));
		if("".equals(qxjy_allowEnd) || Integer.parseInt(qxjy_allowEnd)<Integer.parseInt(qxjy_cccTime))
		{
		String setLoginOutWorkNo = (String)session.getAttribute("workNo");
		String setLoginOutRegionCode = (String)session.getAttribute("regCode");
		%>
		<wtc:service name="sLoginOut" outnum="0" routerKey="region" routerValue="<%=setLoginOutRegionCode%>" 
			 retmsg="msg2" retcode="code2" >
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value=""/>
				<wtc:param value="<%=setLoginOutWorkNo%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
		</wtc:service>
		<%
			session.invalidate();
	%>
			<script language="JavaScript">
			{
				rdShowMessageDialog("�ù��ŵ���Ч����ʱ���ѹ��ڣ�");
				//������Ч����ʱ����ں��˳�ҵ����浽��½��ʼ������
				window.open('/npage/login/index.html','','width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
				window.opener=null;
			  this.close();
			}
			</script>
	<%
		}
	}
%>

<!-- 20091215 end -->

<SCRIPT language="JavaScript">
	function esckeydown()
	{
	    if(event.keyCode==27){
	       event.returnValue = null;
	    }
	}
	 //------hejwa������ng3.5��Ŀ����-----2012-12-12-------------��ʼ-----------------------
$(document).ready(function(){
	//���������ɫ
	$("input[type='text']:visible").bind("focus",function(){
		if(typeof($(this).attr("readonly"))=="undefined"){
			$(this).addClass("input-style2");
		}
	})
	$("input[type='text']:visible").bind("blur",function(){
		if(typeof($(this).attr("readOnly"))=="undefined"){
			$(this).removeClass("input-style2");
		}
	})
	//ֻ��Ҫ��table����һ��vColorTr='set' ���ԾͿ��Ը��б�ɫ
	$("table[vColorTr='set']").each(function(){
		$(this).find("tr").each(function(i,n){
			$(this).bind("mouseover",function(){
				$(this).addClass("even_hig");
			});
			
			$(this).bind("mouseout",function(){
				$(this).removeClass("even_hig");
			});
			
			if(i%2==0){
				$(this).addClass("even");
			}
		});
	});

	

  //����ͷ� ����
	if("2"=="<%=accountType_f_Ng35%>"){
		//tab����ɫ������һ��
		/*
	  $("table").find("td").each(function(){
	  	$(this).addClass("even_ng35_trcolor");
		});
		*/
		//readOnly����������ɫ
		$("input[type='text']:visible").each(function(){
			if(typeof($(this).attr("readOnly"))!="undefined"){
				$(this).attr("style","color:#000000");
			}
		});
	}else{
		//���<a href="#"> �����ʽ����
		$("a[href='#']").each(function(){
					$(this).attr("href","javascript:void(0)");
		});
//���size���Գ���	
		$("input[type='text']:visible").each(function(){
			if(typeof($(this).attr("size"))!="undefined"){
				$(this).css("width","auto")
			}					 
		});
	}
//��ѡ����������ѡ�����ԣ�Ϊ�˲��ظ������𳤵�
	$("q[vType='setNg35Attr']").each(function(){
			$(this).attr("style","cursor:hand");
			var oldtext = $(this).text();
			var oldhtml = $(this).html();
			oldhtml = oldhtml.substring(0,oldhtml.indexOf(oldtext));
			var newhtml = oldhtml+"<a style='cursor:hand;color:#159ee4;' onclick='ng35_cheThisAttr(this)'>"+oldtext+"</a>";
			$(this).html(newhtml);
	});

//��ѡ����������ѡ�����ԣ�Ϊ�˲��ظ������𳤵�
	$("q[vType='setNg35ChekbAttr']").each(function(){
			$(this).attr("style","cursor:hand");
			var oldtext = $(this).text();
			var oldhtml = $(this).html();
			oldhtml = oldhtml.substring(0,oldhtml.indexOf(oldtext));
			var newhtml = oldhtml+"<a style='cursor:hand;color:#159ee4;' onclick='ng35_cheThisCheckb(this)'>"+oldtext+"</a>";
			$(this).html(newhtml);
	});

});

function ng35_cheThisCheckb(bt){
	var b = $(bt).prev().attr("checked");
	if(typeof(b)=="undefined") b = false; else b =true;
	$(bt).prev().attr("checked",b);
	if($(bt).prev().attr("click")){//�����click�¼�
		$(bt).prev().click();
	}
}
function ng35_cheThisAttr(bt){
	$(bt).prev().attr("checked",true);
	if($(bt).prev().attr("click")){//�����click�¼�
		$(bt).prev().click();
	}
}


/**������ɽ����Զ��л�����һ��Ԫ��
* �������÷���  onkeyup="ng35_autoChgFocus(this,n,nextId)"
* this = Ԫ��ָ��
* n = ��n���ַ��л�����
* nextId = ��һ���õ������ID����ȷ��λ
*/
function ng35_autoChgFocus(bt,n,nextId){
	if(countCharacters($(bt).val())>=n){
		$("#"+nextId).focus();
	}
}
//ͳ���ַ���
function countCharacters(str){
  var totalCount = 0; 
  for (var i=0; i<str.length; i++) { 
    var c = str.charCodeAt(i); 
    if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) { 
           totalCount++; 
        }else {    
           totalCount++;//totalCount+=2; ����˫�ֽڣ��˴�Ҳ+1��
        } 
    }
  return totalCount;
}
	$(document).bind("keydown",function(){
		 
	   //alt +x �л�ҳ��
		 var oEvent = window.event;
	   if (oEvent.keyCode == 88 && oEvent.altKey) {
	   	//alert(1);
	    parent.parent.altD_tab();
	   }
	   
	   //alt+c �ر�ҳ��
	   if(oEvent.keyCode == 67 && oEvent.altKey) {
	   	parent.parent.altC_tab();
	    //removeCurrentTab();
	   }
	});
	
	//------hejwa������ng3.5��Ŀ����-----2012-12-12-------------����-----------------------
	document.onkeydown=esckeydown;
//�����Ҽ�
//document.oncontextmenu=new Function("event.returnValue=false");

//function disableKeys(eve)
//{
//	var ev=(document.all)?window.event:eve;
//	var evCode=(document.all)?ev.keyCode:ev.which;
//	var srcElement=(document.all)?ev.srcElement:ev.target;
//	//Backspace 
//		if(srcElement.type!="textarea"&&srcElement.type!="text"&&srcElement.type!="Password")
//		{
//				if(evCode==8)
//				{
//					return  false;
//				}
//		}
//}
//(document.all)?(document.onkeydown=disableKeys):(document.onkeypress=disableKeys);
//var his = window.history.go;
/******************
author:zhouyg

���ܣ����iframe��goHistory(-1)���˴���
�Ѳ����������ie6��ie7��ie8��firefox3
*******************/
/*
var framenum = null;
(
function() {
    if (parent != null) {
        var len = parent.window.frames.length;
        for (var i = 0; i < len; i++) {
            if (parent.window.frames[i].window.document == document)
                if (typeof eval("parent.lc" + i) != "undefined") {
                eval("parent.lc" + i).push(location.href);
                framenum = i;
                break;
            }
            else {
                eval("parent.lc" + i + "=[]");
                eval("parent.lc" + i).push(location.href);
                framenum = i;
                break;
            }
        }
    }
   
    window.history.go = function(num) {
        if (num == -1) {
            if (typeof eval("parent.lc" + framenum) != "undefined") {
                if (eval("parent.lc" + framenum).length > 1) {
                    eval("parent.lc" + framenum + ".length=parent.lc" + framenum + ".length-1"); window.location.href = eval("parent.lc" + framenum)[eval("parent.lc" + framenum).length - 1];
                }
            }
        }
        else
            his(num);
    }


}
)()
*/

/*********************
 * ���select�������option���ݹ���ʱ����ʾ����ȫ���⣻
 * ������������Ϊ180px��
 * Ϊoption�������title���ԣ������ͣ��optionʱ������option title��ʾ��ǰoption text������(��IE7.0+��Ч)��
 *********************/
$(document).ready(function(){
    var selects = document.getElementsByTagName("select");
    if (selects.length > 0){
        for (var i = 0; i < selects.length; i++){
            var options = selects[i].options;
            if (selects[i].options.length > 0){
                for (var j = 0; j < options.length; j++){
                    if (options[j].title == ""){
                        options[j].title = options[j].text;
                    }
                }
            }
            if(!(selects[i].style.width)){
                //selects[i].style.width="180px"; // ng35ͳһ���� hejwa ע��
            }
        }
    }
});
</SCRIPT>	
<%
	String external_workNo = (String)session.getAttribute("workNo");
	String external_regionCode = (String)session.getAttribute("regCode");
	String region_code_public = ((String)session.getAttribute("orgCode")).substring(0,2);
	int external_timeDifference = 10;
	int external_n = 10;
	int external_m = 1000;
	/* list���Ⱥ�ʱ��ֵ�ŵ�properties�����ļ��� */
	Properties external_props = new Properties();
	String external_timeDifferencekey = "external.timeDifference";
	String external_lengthkey = "external.listLength";
	String external_valvekey = "external.valve";
	String external_path = request.getRealPath("npage/properties")+"/externalCfg.properties";
	InputStream external_in = new BufferedInputStream(new FileInputStream(external_path));
	try {
		external_props.load(external_in);
		String external_timeDifferenceStr =new String(external_props.getProperty(external_timeDifferencekey).getBytes("ISO-8859-1"),"gbk"); 
		String external_listLength =new String(external_props.getProperty(external_lengthkey).getBytes("ISO-8859-1"),"gbk"); 
		String external_valve =new String(external_props.getProperty(external_valvekey).getBytes("ISO-8859-1"),"gbk"); 
		external_n = Integer.parseInt(external_listLength); 
		external_m = Integer.parseInt(external_valve);
		external_timeDifference = Integer.parseInt(external_timeDifferenceStr);
	} catch (FileNotFoundException ex) {
		ex.printStackTrace();
	}catch (Exception e) {
		e.printStackTrace();
	}finally{
		external_in.close();
	}
	System.out.println("ningtn external_m " + external_n + " , " + external_m + " , " + external_timeDifference);
	/******************
		��ֹͬһ�����ظ���¼��ʹ��BOSSϵͳ������
		ningtn 2012-6-7 16:05:56
		session������ʱ����Ϣ��session�У�������+pubTime��
		����Ƿǿͷ����ţ�ÿ�ε���public_title_name.jspʱ
		�Ƚ�ϵͳ��ǰʱ����session�м�¼���ϴε���ʱ��
		����������һ���̶���ʱ��Ƶ�ʣ���ʱ��Ϊ10�룩
		����ø��ݹ��Ŵ����ѯsessionId����
	*/
	String publicSessionId = session.getId();
	String publicNowTime=new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
	/*session�д�ŵķ������ʱ��*/
	String publicSessionTime = (String)session.getAttribute(external_workNo+"pubTime");
	if(publicSessionTime == null){
		/*Ϊ�յĻ������ǵ�һ�ε��ã������*/
		publicSessionTime = publicNowTime;
		session.setAttribute(external_workNo+"pubTime",publicSessionTime);
	}
	BigDecimal bd1 = new BigDecimal(publicNowTime);
	BigDecimal bd2 = new BigDecimal(publicSessionTime);
	System.out.println("ningtn double " + bd1.subtract(bd2));
	/* Ϊ�绰�����������ų����� */
	boolean psmFlag = false;
	String loginNoClassCode = (String)session.getAttribute("class_code");
	System.out.println("ningtn loginNoClassCode " + loginNoClassCode);
	if(loginNoClassCode == null){
		/*��һ�ε��ã�ȡһ��classCode����session�У���ֹ��ε��÷���*/
		String getClassCodeSql = "select class_code from dchngroupmsg where group_id=:groupId";
		String[] external_inParams = new String[2];
		external_inParams[0] = getClassCodeSql;
		external_inParams[1] = "groupId="+(String)session.getAttribute("groupId");
%>
			<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" 
				 routerValue="<%=external_regionCode%>" retcode="external_retCode" retmsg="external_retMsg">
				<wtc:param value="<%=external_inParams[0]%>"/>
				<wtc:param value="<%=external_inParams[1]%>"/>
			</wtc:service>
			<wtc:array id="external_result" scope="end"/>
<%
		if("000000".equals(external_retCode)){
			if(external_result != null && external_result.length > 0){
				loginNoClassCode = external_result[0][0];
			}
			session.setAttribute("class_code",loginNoClassCode);
		}
	}
	System.out.println("=====ningtn loginNoClassCode " + external_workNo + " : " + loginNoClassCode);
	if("203".equals(loginNoClassCode)){
		/*class_code Ϊ203 ���ǵ绰������*/
		psmFlag = true;
	}
	if(!"2".equals((String)session.getAttribute("accountType")) 
		&& bd1.subtract(bd2).intValue() > external_timeDifference
		&& !"aaa1zh".equals(external_workNo)
		&& !"aaaaxp".equals(external_workNo)
		&& !"aa0102".equals(external_workNo)
		&& !psmFlag
		){
		 
	}


	/********
		��鹤���쳣����ϵͳҳ����������ʶ����ҵ�����
		ningtn 2012-6-4 15:49:15
		�������¼�����¼��List�С�List����session�У�������+external��
		���Ѽ�¼���ﵽnʱ��У����Сʱ�������ʱ��֮���ʱ���С��mֵ��
		���Ӹ�session��Ӧ�Ĳ�����������ɡ�
		nΪ10��mΪ1��
	*/
	
	java.util.List external_list = (java.util.List)session.getAttribute(external_workNo+"external");
	String external_nowTime = "" +System.currentTimeMillis();
	if(external_list == null){
		System.out.println("ningtn list ��û����");
		external_list = new ArrayList();
		external_list.add(external_list.size(),external_nowTime);
		session.setAttribute(external_workNo+"external",external_list);
	}else{
		if(external_list.size() < external_n){
			external_list.add(external_list.size(), external_nowTime);
		}
	}
	
	System.out.println("ningtn list size " + external_list.size());
	if(external_list.size() == external_n){
		/*����ʱ�����*/
		/*�ж������ʱ��ͽ�β��ʱ�����������ֵm���ͼ�¼��־*/
		BigDecimal bdFirst = new BigDecimal((String)external_list.get(0));
		BigDecimal bdLast = new BigDecimal((String)external_list.get(external_list.size()-1));
		System.out.println("======== ningtn, bdFirst " + bdFirst + "   bdLast  " + bdLast + " size " + external_list.size());
		System.out.println("ningtn " + external_workNo + " external_time " + bdLast.subtract(bdFirst));
		if(bdLast.subtract(bdFirst).intValue() < external_m){
			/*������ֵ����Ҫ�����š�IP��ʱ������Ϣ��Ϊ��־���*/
			String external_log = "\r\n===================��ص��쳣 ��ʼ====================";
			external_log += "\r\n ���ţ�" + external_workNo;
			external_log += "\r\n IP��" + (String)session.getAttribute("ipAddr");
			external_log += "\r\n ʱ���(��ȷ������)��" + bdLast.subtract(bdFirst);
			external_log += "\r\n ��ǰʱ�䣺" + new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
			external_log += "\r\n ��ǰ����ҵ��" + WtcUtil.repNull(request.getParameter("opCode")) + " " + WtcUtil.repNull(request.getParameter("opName"));
			external_log += "\r\n===================��ص��쳣 ����====================";
			String fileName = "externalList.log";
			FileWriter externalWriter = new FileWriter(fileName, true);
			externalWriter.write(external_log);
			externalWriter.close();
		}
		external_list.clear();
	}
%>
<%
  String tabcloseId = WtcUtil.repNull(request.getParameter("closeId"));
	String activePhone  = (String)request.getParameter("activePhone");
	String appCnttFlag  = (String)application.getAttribute("appCnttFlag");//�Ӵ�ƽ̨״̬
	String opBeginTime  = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());//ҵ��ʼʱ��
	//System.out.println("opBeginTime=="+opBeginTime);
%>
