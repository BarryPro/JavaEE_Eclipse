<!--(01)�ͷ� songjia begin 2010/08/19-->
<script language="javaScript">		
//��������ѡ������ by libin 2009/04/28
function copyToClipBoard(obj){ 
	var clipBoardContent = obj.innerHTML; 		
	window.clipboardData.setData('Text',clipBoardContent);		
}

function callCome(val,contactId){
	//tancf 20110420
		<%if("1".equals(shomeflag)){%>
				var workNum=cCcommonTool.getWorkNo();
				var currentState=0;
				if(parPhone.QueryAgentStatusEx(workNum)==0){
					currentState=parPhone.AgentInfoEx_CurState;
				 }
         if(currentState!=5&&currentState!=4)
          {
                return false;
          }
		<%}%>
		//add by songjia �������ơ�
		 	<%if("1".equals(limitLoginFlag)){%>
	 		var limitCodeRows = "<%=limitCodeRows%>";
	 		var limitCodeArr = limitCodeRows.split(",");
	 		var workNum=cCcommonTool.getWorkNo();
			var currentState;			
			if(parPhone.QueryAgentStatusEx(workNum)==0){
				currentState=parPhone.AgentInfoEx_CurState;
			}
  		if(currentState!=5&&currentState!=4)
   	  {            
        return false;
      }

	 		
	 	<%}%>
	 	
	document.getElementById('speciallight').style.display = 'none'; //add by yinzx 20091105
	window.top.cCcommonTool.DebugLog("javascript begin callCome");			
	var sendphone_no = {};
	sendphone_no["phone_no"] = val;			
	sendphone_no["caller"]=window.top.cCcommonTool.getCaller();
	sendphone_no["called"]=window.top.cCcommonTool.getCalled();    
	dofreshPhoneInfo(val);     
	if(val.length>1)
	{
		try{
		//jiangbing 20090808 �̻���Ҫ��ͨ�жϺ�ȷ���Ƿ���
		var urlStrl='<%=request.getContextPath()%>/npage/callbosspage/public/getUerMsg.jsp?phone_no='+val+'&contactId='+contactId;
		asyncGetText(urlStrl,doCallCome);
		}catch(e){
			alert(e);
		}	
	} 
	window.top.cCcommonTool.DebugLog("javascript end callCome");
	}	
	function doCallCome(txt)
	{
	   window.top.cCcommonTool.DebugLog("javascript begin docallcome");
	   var sp_return=txt.split('~');
	   var ret_code = sp_return[0];  
	   var cust_name=sp_return[1];
	   var contact_address=sp_return[2];
	   var card_name=sp_return[3];
	   var product_name=sp_return[4];
	   var town_name=sp_return[5];
	   var run_name=sp_return[6];
	   var prepay_fee=sp_return[7];
	   var sm_name=sp_return[8];
	   var phone_no=sp_return[9];
	   var contactId=sp_return[10];
	   var joinDate=sp_return[11];
	   var CurrContactId=sp_return[12]; //add wangyong 20091104 ͳһ�Ӵ�ID
	   var accept_phone=sp_return[13]; //add yinzx 20091104 ��������
	 	 var spcust_name=sp_return[14]; //add yinzx 20091104 ��������
	   var reason=sp_return[15]; //add yinzx 20091104 ��������
	   var specialcolor=sp_return[16]; //add yinzx 20091104 ��������
	   var bak1=sp_return[17]; //add yinzx 20091105 ��������	
	   var yue_1=sp_return[18]; //add tancf yue_1 ���	 
	   var hasMoney=sp_return[19]; //add tancf hasMoney ����Ԥ���  
	   var password_error_num =sp_return[20];//add jingzhi password_error_num ������֤�������
	   if(ret_code!=null&&ret_code.toUpperCase()=='NULL')ret_code='';
	   if(cust_name!=null&&cust_name.toUpperCase()=='NULL')cust_name='δ֪';
	   if(contact_address!=null&&contact_address.toUpperCase()=='NULL')contact_address='δ֪';
	   if(card_name!=null&&card_name.toUpperCase()=='NULL')card_name='δ֪';
	   if(product_name!=null&&product_name.toUpperCase()=='NULL')product_name='';
	   if(town_name!=null&&town_name.toUpperCase()=='NULL')town_name='';
	   if(prepay_fee!=null&&prepay_fee.toUpperCase()=='NULL')prepay_fee='';
	   if(sm_name!=null&&sm_name.toUpperCase()=='NULL')sm_name='δ֪';
		 if(sm_name=='zn')sm_name='������';	   
	   if(phone_no!=null&&phone_no.toUpperCase()=='NULL')phone_no='δ֪';
	   if(contactId!=null&&contactId.toUpperCase()=='NULL')contactId='δ֪';
	   if(joinDate!=null&&joinDate.toUpperCase()=='NULL')joinDate='';
	   if(CurrContactId!=null&&CurrContactId.toUpperCase()=='NULL')CurrContactId='';
	   if(accept_phone!=null&&accept_phone.toUpperCase()=='NULL')accept_phone='';
	   if(spcust_name!=null&&spcust_name.toUpperCase()=='NULL')spcust_name='';
	   if(reason!=null&&reason.toUpperCase()=='NULL')reason='';
	   if(specialcolor!=null&&specialcolor.toUpperCase()=='NULL')specialcolor='';
	   if(bak1!=null&&bak1.toUpperCase()=='NULL')bak1='';		  
	   if(yue_1!=null&&yue_1.toUpperCase()=='NULL')yue_1='';	 
	   if(hasMoney!=null&&hasMoney.toUpperCase()=='NULL')hasMoney='';	 
	   setCust_name(cust_name);	   
	   
	    //songjia 20101109 ���Ӻ��м���
	   var callSkill = document.getElementById('callSkill').value;
	   if(callSkill != "")
	   {
		   var sit = callSkill.lastIndexOf(',');
		   if(sit != -1)
		   {
		   		appendText(document.getElementById('call_skill'),callSkill.substring(sit+1),null,0);
		   }
		 }else{
		 			appendText(document.getElementById('call_skill'),"",null,0);
		 }
	   //end 
	   
	   //add by hucw 20101031
	   appendText(document.getElementById('contactIdnew'),contactId,null,0);	   
	   //add by jingzhi 20110701
	   appendText(document.getElementById('password_error_num'),password_error_num,null,0); 
	   appendText(document.getElementById('cust_name'),cust_name,null,0);
	   appendText(document.getElementById('card_name'),card_name,null,0);
	   appendText(document.getElementById('sm_name'),sm_name,null,0);
	   //appendText(document.getElementById('contact_address'),contact_address,null,0);
	   appendText(document.getElementById('hasMoney'),hasMoney,null,0);
	   //end by hucw 20101031
	   var callerPhoneNo = window.top.cCcommonTool.getCaller();
	   var calledPhoneNo = window.top.cCcommonTool.getCalled();
	   if(callerPhoneNo==phone_no||calledPhoneNo==phone_no){
	   	//add by hucw 20101031
	   	  appendText(document.getElementById('town'),town_name,null,0);
				document.getElementById('phone_no1').style.color = "#ff0000";
	   	  appendText(document.getElementById('phone_no1'),phone_no,null,0);
	   	//end by hucw 20101031
	   }else{
	   	  //add by hucw 20101031
	   	  appendText(document.getElementById('town'),town_name,null,0);
				document.getElementById('phone_no1').style.color = "red";
	   	  appendText(document.getElementById('phone_no1'),phone_no,null,0);
	   		//end by hucw 20101031
	  }
	   //add by hucw 20101031
	   //appendText(document.getElementById('product_name'),product_name,null,0);
	   appendText(document.getElementById('run_name'),run_name,null,0);
	   //appendText(document.getElementById('joinDate'),joinDate,null,0);
	   appendText(document.getElementById('called_phone_no'),window.top.cCcommonTool.getCalled(),null,0);
	   document.getElementById("CurrContactId").value = CurrContactId;
	   //end by hucw 20101031
	   var  prepay_fee1="";
	   var  prepay_fee2="";
	   if(prepay_fee!=undefined&&prepay_fee!='')
	   {
	   	if(prepay_fee>=0)
		   	{
		   		prepay_fee1=prepay_fee;	
		   	}
	   	else
	   		{
	   			prepay_fee1=0.00;	
	   		}		   			
	   }
	  prepay_fee2=yue_1;
	  if(prepay_fee2>=0)
	  {
	  	prepay_fee2='0.00';	
	  }
	  //add by hucw 20101031 
	  appendText(document.getElementById('prepay_fee1'),prepay_fee1,null,0);
	  appendText(document.getElementById('prepay_fee2'),prepay_fee2,null,0);
		//end by hucw 20101031
		
		//added by tangsong 2010110 ���й켣
		var callTrack = parPhone.RoutPackage_KeyTrace;
		//var hwclass = parPhone.RoutPackage_UserClass;
  	//document.getElementById('call_track').innerHTML = "<a href='javascript:void(0)' onclick=\"addTab(true,'calltrack','���й켣','/npage/callbosspage/k021/showRouteTrace.jsp?hwclass="+hwclass+"')\">"+callTrack+"</a>";
  	//ȡ����callTrackǰ�����һ��1���ص�
  	callTrack = callTrack.substring(1,callTrack.length);
  	var callTrack2 = "";
  	for (var i=0;i<callTrack.length;i++) {
  		callTrack2 += callTrack.charAt(i) + "-";
  	}
  	if (callTrack2 != "") {
  		callTrack2 = callTrack2.substring(0,callTrack2.length-1);
  	}
  	appendText(document.getElementById('call_track'),callTrack2,null,0);
		
		var val=phone_no;
		window.top.cCcommonTool.DebugLog("javascript begin docallcome1 ret_code="+ret_code);
		dolocation(val);
		if(ret_code==000000){
			 	 if(val.length>4){
					if(enterTypeAll=='kf')
					{
					addTabBySearchCustName(val,'kf');
				  }
				 }
			 }
			 else
			 	{
			 		//tancf20090314���ƶ��ֻ�ҲҪˢ�û���Ϣ
			 		if(enterTypeAll=='kf')
					{
					addTabBySearchCustName(val,'kf');
					enterTypeAll='';
				  }
					  if(val.length<5){						  	 
					  }
					  else{
					  	//�жϹ̻��������û�,��ȡ�ַ����ĵ�һλ�������0���ǹ̻�������Ϊ�����û� by libin 2009-04-27
					  	var strval = val.substring(0,1);
					  	if(strval == '0'){
					  		//rdShowMessageDialog("�̻��û�",1);
					  		similarMSNPop("<font color='#000080'>�̻��û�</font>");
					  	}else{
					  		//rdShowMessageDialog("�����û�",1);
					  		if(isChinaMobile(val) != ''){
					  			similarMSNPop("<font color='#000080'>�����û�</font>");
					  		}							  		
					  	}
					  }					 		  					 
			 	}	
			 	window.top.cCcommonTool.DebugLog("javascript end docallcome");		
				if(accept_phone!="")
				{
              
					   document.getElementById('speciallight').style.display = 'none';
					   //document.getElementById('specialcontent').style.color =   specialcolor.trim() ;
		   		   //document.getElementById('specialcontent').innerHTML="<b>�û���"+spcust_name+"<br>����ԭ��"+reason+"</b>";	 
					   //similarMSNPop("<font color="+specialcolor.trim()+"  ><blink><b>�û���"+spcust_name+"<br>����ԭ��"+reason+"</b></blink></font>");
				}			
		}
		
function dcust_name(txt)
{
	var reg=new RegExp("#+","g"); 
	var newstr=txt.replace(reg,"");  
	return newstr;	
}
</script>
<!--(01)�ͷ� songjia end 2010/08/19-->

	<%-- modified by hejwa in 20110714 ��OP����--���ݹ��� begin --%>
	<% //���ù���
	
		String  powerCodeOp = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//��ɫ����
		String c_commfunc = "���ù���" ;
		String c_commfuncCls = "ico_user";
		String contentSql_11 = "select content_cls,content_name from dcontentmsg where content_id='p_commfunc'  and op_roleid=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode='"+powerCodeOp+"') and is_effect='1'";
	%>
	 
	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=contentSql_11%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="commfunc1" scope="end"/>
	<%
		if("000000".equals(code)){
				if(commfunc1.length>0){
						c_commfuncCls = commfunc1[0][0];
						c_commfunc = commfunc1[0][1];
				}
		}
		c_commfunc = c_commfunc.trim();
		c_commfuncCls = c_commfuncCls.trim();
		
	%>
	
	<% //ϵͳ����
		String c_sysmenu = "ϵͳ�˵�" ;
		String c_sysmenuCls = "ico_tree";
		String contentSql_22 = " select content_cls,content_name from dcontentmsg where content_id='p_sysmenu' and op_roleid=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode='"+powerCodeOp+"') and is_effect='1'";
	%>
	 
	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=contentSql_22%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="sysmenu1" scope="end"/>
	<%
		if("000000".equals(code)){
				if(sysmenu1.length>0){
						c_sysmenuCls = sysmenu1[0][0];
						c_sysmenu = sysmenu1[0][1];
				}
		}
		c_sysmenu = c_sysmenu.trim();
		c_sysmenuCls = c_sysmenuCls.trim();
	%>
	<% //ȫ������
		String c_privset = "ȫ������" ;
		String c_privsetCls = "ico_fav";
		String contentSql_33 = " select content_cls,content_name from dcontentmsg where content_id='p_privset' and op_roleid=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode='"+powerCodeOp+"') and is_effect='1'";
	%>
	 
	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=contentSql_33%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="privset1" scope="end"/>
	<%
		if("000000".equals(code)){
				if(privset1.length>0){
						c_privsetCls = privset1[0][0];
						c_privset = privset1[0][1];
				}
		}
		c_privset = c_privset.trim();
		c_privsetCls = c_privsetCls.trim();
	%>
	
	<% //ҵ����
		String c_busiguide = "ҵ����" ;
		String c_busiguideCls = "ico_buGu";
		String contentSql_44 = " select content_cls,content_name from dcontentmsg where content_id='p_busiguide' and op_roleid=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode='"+powerCodeOp+"') and is_effect='1'";
	%>
	 
	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=contentSql_44%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="busiguide1" scope="end"/>
	<%
		if("000000".equals(code)){
				if(busiguide1.length>0){
						c_busiguideCls = busiguide1[0][0];
						c_busiguide = busiguide1[0][1];
				}
		}
		c_busiguide = c_busiguide.trim();
		c_busiguideCls = c_busiguideCls.trim();
	%>
	
	
	<% //�û���Ϣ�������û���Ϣ���ͷ�����
		String c_callUserInfo = "�û���Ϣ" ;
		String c_callUserInfoCls = "ico_fav";
		String contentSql_55= " select content_cls,content_name from dcontentmsg where content_id='p_callUserInfo'  and op_roleid=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode='"+powerCodeOp+"') and is_effect='1'";
	%>
	 
	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=contentSql_55%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="callUserInfo1" scope="end"/>
	<%
		if("000000".equals(code)){
				if(callUserInfo1.length>0){
						c_callUserInfoCls = callUserInfo1[0][0];
						c_callUserInfo = callUserInfo1[0][1];
				}
		}
		c_callUserInfo = c_callUserInfo.trim();
		c_callUserInfoCls = c_callUserInfoCls.trim();
	%>
	
	
	<%-- modified by hejwa in 20110714 ��OP����--���ݹ��� end --%>
<div id="navPanel" onclick="hideFavMenu()" style="width: 220px;">
	<div class="title">
		<ul>
			<!--(02)�ͷ� songjia begin 2010/08/19-->
			<li id="getUserInfo" onclick="HoverNav('userinfo')" title="<%=c_callUserInfo%>" class="on">
				<div class="<%=c_callUserInfoCls%>"></div>
				<span><%=c_callUserInfo%></span>	
			</li>
		 
		<li id="getFavFunc" onclick="HoverNav('fav')" title="<%=c_commfunc%>" class="on">
				<div class="<%=c_commfuncCls%>"></div>
				<span><%=c_commfunc%></span>	
			</li>
			<li id="getTree"  onclick="HoverNav('tree','99999','<%=c_sysmenu%>')"  title="<%=c_sysmenu%>">
				<div class="<%=c_sysmenuCls%>"></div>
				<span><%=c_sysmenu%></span>	
			</li>
			<li id="getAllTree" onclick="HoverNav('alltree','99999','<%=c_privset%>')" title="<%=c_privset%>">
				<div class="<%=c_privsetCls%>"></div>
				<span><%=c_privset%></span>	
			</li>
			
			<li id="buGu" onclick="HoverNav('buGu')" title="<%=c_busiguide%>">
				<div class="<%=c_busiguideCls%>"></div>
				<span><%=c_busiguide%></span>	
				<li id="tbc_04" style="display:none;"></li>
			</li>
			<!--li id="getAuthorizeTree" onclick="HoverNav('authorizetree','99999','��Ȩ����')" title="��Ȩ����">
				<div class="ico_all"></div>
				<span>��Ȩ����</span>	
			</li-->
		</ul>
	</div>
	<%-- modified by hejwa in 2011-8-2 ��OP����--���ݹ��� end --%>
		<div class="search_bar">
			<div class="input">
				<input name="funcText" id="funcText" type="text" onkeyup="if(this.value=='')$('#system_search_result').hide();" onkeypress="if(event.keyCode==13) searchFunc($('#funcText').val());" value="����ģ�� (Alt+3)" >
			</div>
			<button onclick="searchFunc($('#funcText').val())"></button>
		</div>
		<div id="system_search_result" class="search_result" >
			<div class="close" onclick="$('#system_search_result').hide();"></div>
			<ul class="custom_module" id="functionResult"></ul>
		</div>
	
		<div class="navMain" id="navMainTmp">
				<div id="wait">
					<div class="loading_gif"></div>
				</div>
		</div>
	
</div>

<div class="rightmenu" id="favMenu" style="display:none">
	<ul>
		<li id="delIcon"><span class="del"></span>ɾ��</li>
		<li id="editIcon"><span class="edit"></span>���ÿ�ݼ�</li>
		<li id="todoIcon"><span class="todo"></span>���߰���</li>
	</ul>
</div>

<!--(03)�ͷ� songjia begin 2010/08/19-->
<script>
function dofreshPhoneInfo(callPhon){
	//jiangbing 20091101 ��������û���ʾ��Ϣ
	var searchPhoneNo = callPhon;
	var callerNo = window.top.cCcommonTool.getCaller();
	var calledNo = window.top.cCcommonTool.getCalled()		
	if(searchPhoneNo!=callerNo&&searchPhoneNo!=calledNo){
		document.getElementById('handleNo_town_tr').style.display = 'block';
	}
	else{
	document.getElementById('handleNo_town_tr').style.display = 'none';	
	}			
	var workMyNo=cCcommonTool.getWorkNo();
	//add by hucw 20101031
	appendText(document.getElementById('caller_phone_no'),window.top.cCcommonTool.getCaller(),null,0);
	appendText(document.getElementById('called_phone_no'),window.top.cCcommonTool.getCalled(),null,0);
	// end by hucw 20101031
	if(window.top.cCcommonTool.getOp_code()=="K025"){
	//add by hucw 20101031
	appendText(document.getElementById('handleType'),"�绰����",null,0);
	//end by hucw 20101031
	}else{
	// by fangyuan 090324 ������кŶθ��¹�������Ϣ
	//add by hucw 20101031
	appendText(document.getElementById('handleType'),"�绰����",null,0);
	//end by hucw 20101031
	}	
}
function dolocation(callPhon)
{
	var searchPhoneNo = callPhon;
	var callerNo = window.top.cCcommonTool.getCaller();
	var calledNo = window.top.cCcommonTool.getCalled()		
	if(searchPhoneNo!=callerNo&&searchPhoneNo!=calledNo){
		document.getElementById('handleNo_town_tr').style.display = 'block';	
		getLocationEx(searchPhoneNo,updateHandleNoRegion);
	}
	else
	{
		document.getElementById('handleNo_town_tr').style.display = 'none';	
	}			
	var workMyNo=cCcommonTool.getWorkNo();
	//add by hucw 20101031
	appendText(document.getElementById('caller_phone_no'),window.top.cCcommonTool.getCaller(),null,0);
	appendText(document.getElementById('called_phone_no'),window.top.cCcommonTool.getCalled(),null,0);
	//end by hucw 20101031
	if(window.top.cCcommonTool.getOp_code()=="K025"){	
		//add by hucw 20101031
	  appendText(document.getElementById('handleType'),"�绰����",null,0);
		//end by hucw 20101031
		getLocation(window.top.cCcommonTool.getCalled());
	}else{	
		//add by hucw 20101031
		appendText(document.getElementById('handleType'),"�绰����",null,0);
		//end by hucw 20101031
		getLocation(window.top.cCcommonTool.getCaller());
	}
}
   
function setCust_name(thecust_name)
{
  document.getElementById('custName').value=thecust_name;
  window.top.cCcommonTool.setCallerUserName(thecust_name);
}
function getLocationEx(phoneNo,callback){
	if(phoneNo==''||phoneNo=='undefined'){
		return;
	}
	var urlStrl='<%=request.getContextPath()%>/npage/callbosspage/portal/getLocation.jsp?callPhone='+phoneNo;
	asyncGetText(urlStrl,callback);
}
function getLocation(phoneNo){
	if(phoneNo==''||phoneNo=='undefined'){
		//add by hucw 20101031
	  appendText(document.getElementById('town'),'',null,0);
		//end by hucw 20101031
		return;
	}
	var urlStrl='<%=request.getContextPath()%>/npage/callbosspage/portal/getLocation.jsp?callPhone='+phoneNo;
	asyncGetText(urlStrl,doGetLocation);
}

function doGetLocation(txt){
	var sp_return=txt.split('|');
	var townName = sp_return[0];  
	//add by hucw 20101031
	appendText(document.getElementById('town'),townName,null,0);
	//add by hucw 20101031
	return;
}
  
function updateHandleNoRegion(txt){
	var sp_return=txt.split('|');
	var townName = sp_return[0];  				
	var provice=sp_return[1];		
	appendText(document.getElementById('handleNo_town'),townName,null,0);
	document.getElementById('handleNo_townHi').value=trim(townName);
	//end by hucw 20101031
	document.getElementById('provice').value=provice;
	return;
}

function getIsTTNo(val,contactId){
	var urlStrl='<%=request.getContextPath()%>/npage/callbosspage/portal/getIsTTNo.jsp?callPhone='+val+'&contactId='+contactId;
	asyncGetText(urlStrl,doGetIsTTNo);
}
  
function doGetIsTTNo(txt){
	var sp_return=txt.split('|');
	var isTTNo = sp_return[1];  
	var val = sp_return[2];
	var contactId = sp_return[3];
	if(isTTNo=='1'){
		var urlStrl='<%=request.getContextPath()%>/npage/callbosspage/public/getUerMsg.jsp?phone_no='+val+'&contactId='+contactId;
		asyncGetText(urlStrl,doCallCome);
	}else{
		similarMSNPop("<font color='#000080'>�����û�</font>");
		//add by hucw 20101031
		appendText(document.getElementById('phone_no1'),'',null,0);
		appendText(document.getElementById('contactIdnew'),contactId,null,0);
		//end by hucw 20101031
		clearSomething();
	}
}
  
function clearSomething(){
	  appendText(document.getElementById('cust_name'),'',null,0);
	  appendText(document.getElementById('card_name'),'',null,0);
	  appendText(document.getElementById('sm_name'),'',null,0);
	  //appendText(document.getElementById('contact_address'),'',null,0);
	  //appendText(document.getElementById('product_name'),'',null,0);
	  appendText(document.getElementById('run_name'),'',null,0);
	  appendText(document.getElementById('prepay_fee1'),'',null,0);
	  appendText(document.getElementById('prepay_fee2'),'',null,0);
	  appendText(document.getElementById('call_track'),'',null,0);
}
</script>
<!--(03)�ͷ� songjia end 2010/08/19-->