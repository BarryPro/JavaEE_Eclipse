	<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%! 
		/** 
		 ����˵��: ����һ��������sql.Ȼ��ҳ�����ģʽ��  [�����_=_�ֶ���] ��  [�����_like_�ֶ���]
		 ����columnΪ��ѯ�ֶ�.��һλ�������.����Ų����ظ�.�ظ����������һ��ֵ.�ұ���������.��С������1,11,123.
		 */ 
   public String returnSql(HttpServletRequest request){
    StringBuffer buffer = new StringBuffer();
		   //�������.
		Map map = request.getParameterMap();
		Object[] objNames = map.keySet().toArray();
		Map temp = new HashMap();
		String name="";
		String[] names= new String[0];
		String value="";
		//���������������.key������.�����ֽ�������.value�������object�����ֵ.
		for (int i = 0; i < objNames.length; i++) {
			name = objNames[i] == null ? "" : objNames[i]
			.toString();
			//String name
			names = name.split("_");
			//��name����'_'�ֳ�3������.
			if (names.length >= 3) {
		//������ܷ�˵�����ֲ��Ϸ�.̫�����ֲ���.
		    value = request.getParameter(name);
		//�������ֵõ�value
		if (value.trim().equals("")||value.trim().equals("NULL")) {
			//���value��""����.
			continue;
		}
		Object[] objs = new Object[3];
		objs[0] = names[1];
		//���� ��һ���ַ���.��like ���� =
		name = name.substring(name.indexOf("_") + 1);
		name = name.substring(name.indexOf("_") + 1);
		//��ط������ݿ���ֶδ���.������'_'�Ժ�Ķ������ݿ��ֶ���.
		objs[1] = name;
		//�ڶ����ַ���.��ѯ����.
		objs[2] = value;
		//������.��ѯ��ֵ.
	//	System.out.println("~~~~~~~~~~~~~" + objs[0]);
		try {
			temp.put(Integer.valueOf(names[0]), objs);
			//����ط��ǽ��ַ���ת��������.Ȼ���������.����19Ҫ��2֮��.
		} catch (Exception e) {

		}
		//������������key����,ojbs����ŵ�value����.
			}
		}
		Object[] objNos = temp.keySet().toArray();
		//�õ�һ�����������.
		Arrays.sort(objNos);
		//�����ֽ�������.
		for (int i = 0; i < objNos.length; i++) {
			Object[] objs = null;
			objs = (Object[]) temp.get(objNos[i]);
			//�����like �� = �ֱ���.
			if (objs[0].toString().toLowerCase().equalsIgnoreCase(
			"like")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " '%%"
				+ objs[2].toString().trim() + "%%' ");
			}
			if (objs[0].toString().equalsIgnoreCase("=")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " '"
				+ objs[2].toString().trim() + "' ");
			}
			if (objs[0].toString().equalsIgnoreCase("str")){

			buffer.append(" and instr("+objs[1]+",',"+objs[2].toString()+"',-1,1)>0");

			}
		}

        return buffer.toString();
	 }
%>
<%!
//����Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
   			System.out.println( " ��ʼ����Excel�ļ� " );
        XLSExport e  =   new  XLSExport(null);
        String headname = "����ԭ���ѯ";//Excel�ļ���
        try {
        OutputStream os = response.getOutputStream();//ȡ�������
        response.reset();//��������
        response.setContentType("application/ms-excel");//�����������
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//�趨����ļ�ͷ
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4],queryList[i][5],queryList[i][6],queryList[i][7],queryList[i][8],queryList[i][9],queryList[i][10],queryList[i][11]};
				    datalist.add(dateSour);
		    }
				XLSExport.excelExport(e, os, strHead, datalist, intMaxRow);
           e.exportXLS(os);
           System.out.println( " ����Excel�ļ�[�ɹ�] ");
        }catch  (Exception e1) {
           System.out.println( " ����Excel�ļ�[ʧ��] ");
           e1.printStackTrace();
        } 
    }
    public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>


<%
  /*ȡ��ǰ��½���ŵĽ�ɫID��Ϊ���ŷָ���ַ��� hanjc add 20090423*/
	String  powerCode = (String) (session.getAttribute("powerCodekf")==null?"":session.getAttribute("powerCodekf"));
	String[]  powerCodeArr = powerCode.split(",");
  String isCommonLogin="N";	//Y:��ʾ������С�鳤����ͨ��ϯ
	/*
	 *�Ƿ��ǻ���Ա update by hanjc 20090719
        *01120O04Ϊ��ѵ��ɫid,01120O0EΪ�ʼ��ɫid,011202Ϊ�ͻ��绰Ӫҵ����01120O02����ͨ��ϯ
        *01120O02011202��01120201120O02�ǿͻ��绰Ӫҵ������ͨ��ϯ������ɫ��ƴ��
        *����Աֻ�пͻ��绰Ӫҵ������ͨ��ϯ������ɫ,��01120O02011202��01120201120O02��������С�鳤��
        *01120201120O0G��01120O0G011202ΪС���Ž�ɫidƴ��
	 */
     	/* modify by yinzx 20090826 ����ɽ������д�Ľ��ң�����д����ɫ��Ϣ ���Ը��죬������ʱ����
      //add by hanjc 20090719 �жϵ�ǰ�����Ƿ��ǻ���Ա��
      if(powerCodeArr.length==2){
         String tempVal = powerCodeArr[0].trim()+powerCodeArr[1].trim();
         if("01120O02011202".equals(tempVal)||"01120201120O02".equals(tempVal)){
		isCommonLogin="Y";	
         }
       } 
   *//*add by yinzx 090826*/
   for(int i = 0; i < powerCodeArr.length; i++){
		for(int j=0; j<HUAWUYUAN_ID.length; j++){
			if(HUAWUYUAN_ID[j].equals(powerCodeArr[i])) {
				isCommonLogin="Y";
			}
		}
	}
%>
<script language="javascript">
   //ѡ���и�����ʾ
		var hisObj="";//������һ����ɫ����
		var hisColor=""; //������һ������ԭʼ��ɫ
		/**
   *hisColor ����ǰtr��className
   *obj       ����ǰtr����
   */
   
   //�޸�����ԭ�򣬱����ڴ���������������
   var xmlHelper = window.top.xmlHelper;
	 var xmlSeach  = window.top.xmlSeach;

		function changeColor(color,obj){
		  //�ָ�ԭ��һ�е���ʽ
		  if(hisObj != ""){
			 for(var i=0;i<hisObj.cells.length;i++){
				var tempTd=hisObj.cells.item(i);
				//tempTd.className=hisColor; ��ԭ�ֵ���ɫ
				tempTd.style.backgroundColor = '#F7F7F7';		//��ԭ�б�����ɫ
			 }
			}
				hisObj   = obj;
				hisColor = color;
		  //���õ�ǰ�е���ʽ
			for(var i=0;i<obj.cells.length;i++){
				var tempTd=obj.cells.item(i);
				//tempTd.className='green'; �ı��ֵ���ɫ
				tempTd.style.backgroundColor='#00BFFF';	//�ı��б�����ɫ
			}
		}
	/*****************��ҳ���� begin******************/
	function doLoad(operateCode){
		var formobj = parent.queryFrame2.document.sitechform;
		 var str='1';
	   if(operateCode=="load")
	   {
	   	formobj.page.value="";
	   	str='0';
	   }
	   else if(operateCode=="first")
	   {
	   	formobj.page.value=1;
	   }
	   else if(operateCode=="pre")
	   {
	   	formobj.page.value=<%=(curPage-1)%>;
	   }
	   else if(operateCode=="next")
	   {
	   	formobj.page.value=<%=(curPage+1)%>;
	   }
	   else if(operateCode=="last")
	   {
	   	formobj.page.value=<%=pageCount%>;
	   }
	   
	   //zengzq 20100125 �ڶ�������1 ��ʾΪ�����һҳ����һҳ��
	   //ȡ����
	   var rowCount = '<%=rowCount%>';
	   //zengzq 20100125 �ǲ�ѯʱ��ֱ�ӽ�����������
	   parent.queryFrame2.submitMe(str,'1',rowCount);
	}
	/***************��ҳ��������**************/
	
	//���д򿪴���
		function openWinMid(url,name,iHeight,iWidth)
		{
		  //var url; //ת����ҳ�ĵ�ַ;
		  //var name; //��ҳ���ƣ���Ϊ��;
		  //var iWidth; //�������ڵĿ��;
		  //var iHeight; //�������ڵĸ߶�;
		  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
		  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
		  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
		}
	  //ȥ��ո�;
		function ltrim(s){
		  return s.replace( /^\s*/, "");
		}
		//ȥ�ҿո�;
		function rtrim(s){
		return s.replace( /\s*$/, "");
		}
		//ȥ���ҿո�;
		function trim(s){
		return rtrim(ltrim(s));
		}
		//��ת��ָ��ҳ��
		function jumpToPage(operateCode){
			
			 if(operateCode=="jumpToPage")
		   {
		   	  var thePage = document.getElementById("thePage").value;
		   	  if(trim(thePage)!=""){
		   		 parent.queryFrame2.window.sitechform.page.value=parseInt(thePage);
		   		 doLoad('0');
		   	  }
		   }
		   else if(operateCode=="jumpToPage1")
		   {
		   	  var thePage=document.getElementById("thePage1").value;
		   	  if(trim(thePage)!=""){
		   		 parent.queryFrame2.window.sitechform.page.value=parseInt(thePage);
		       doLoad('0');
		      }
		   }else if(trim(operateCode)!=""){
		   	 parent.queryFrame2.window.sitechform.page.value=parseInt(operateCode);
		   	 doLoad('0');
		   }
		}
		
		//��ȡ¼��****************************begin**************/
		function checkCallListen(id,staffno){
				if(id==''){
				return;
				}
				if("Y"=="<%=isCommonLogin%>"){
					if('<%=loginNo%>'!=staffno){
					  rdShowMessageDialog("��û����ȡ��¼����Ȩ�ޣ�");
					  return;
				  }
				}
			var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsListen_rpc.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
			packet.data.add("contact_id",id);
			core.ajax.sendPacket(packet,doProcessGetPath,false);
			packet=null;
		}
		
		 function doLisenRecord(filepath,contact_id)
			{
					   window.top.document.getElementById("recordfile").value=filepath;
					   window.top.document.getElementById("lisenContactId").value=contact_id;
					   window.top.document.getElementById("K042").click();
						var packet = new AJAXPacket("../../../npage/callbosspage/K042/lisenRecord.jsp","���ڴ���,���Ժ�...");
				     packet.data.add("retType" ,  "chkExample");
				     packet.data.add("filepath" ,  filepath);
				     packet.data.add("liscontactId" ,contact_id);
				    core.ajax.sendPacket(packet,doProcessNavcomring,true);
						packet =null;
			}
			function getCallListen(id){
				if(id==''){
						return;
				}			
				openWinMid("k170_getCallListen.jsp?flag_id="+id,'¼����ȡ',650,850);
			}
			
			function doProcessNavcomring(packet)
			 {
			    var retType = packet.data.findValueByName("retType");
			    var retCode = packet.data.findValueByName("retCode");
			    var retMsg = packet.data.findValueByName("retMsg");
			    if(retType=="chkExample"){
			    	if(retCode=="000000"){
			    		//alert("����ɹ�!");
			    	}else{
			    		//alert("����ʧ��!");
			    		return false;
			    	}
			    }
			 }
			 
			 function doProcessGetPath(packet){
			   var file_path = packet.data.findValueByName("file_path");
			   var flag = packet.data.findValueByName("flag");
			   var contact_id = packet.data.findValueByName("contact_id");
			   if(flag=='Y'){
			   	doLisenRecord(file_path,contact_id);
			   }else{
			   	getCallListen(contact_id)	;
			   }		
			 }
			 /****************��ȡ¼������end********************/
			 
			 //��ʾͨ����ϸ��Ϣ
			function getCallDetail(contact_id,start_date){
				if(contact_id==''){
					return;
				}
				var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
			  path = path + "?contact_id=" + contact_id;
			  path = path + "&start_date=" + start_date;
			  openWinMid(path,"��Ϣ����",680,960);
				return true;
			}
			
			//����¼��
			function keepRec(id,staffno){
			 if("Y"=="<%=isCommonLogin%>"){
					if('<%=kf_longin_no%>'!=staffno){
					  rdShowMessageDialog("��û����ȡ��¼����Ȩ�ޣ�");
					  return;
				  }
			 }
			 if(id==''){
					return;
			 }
			 openWinMid("k170_download.jsp?flag_id="+id,'���¼��������',450,850);
			}
			
			//��ʾ���й켣
			function showCallLoc(){
				//rdShowMessageDialog("��ʾ���й켣",2);
				//openWinMid("k170_showCallLoc.jsp",'��ʾ���й켣',480,640);
			}
			
			//�жϵ�ǰ�����Ƿ��и���ˮ���ŵ��ʼ�ƻ�******************begin******/
			function checkIsHavePlan(serialnum,flag,staffno){
				var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsHavePlan_rpc.jsp","���ڽ��мƻ�У�飬���Ժ�......");
				mypacket.data.add("serialnum",serialnum);
			  mypacket.data.add("start_date",parent.queryFrame2.window.sitechform.start_date.value);
			  mypacket.data.add("flag",flag);
			  mypacket.data.add("staffno",staffno);
			  core.ajax.sendPacket(mypacket,doProcessIsHavePlan,true);
				mypacket=null;
			}
			
			function doProcessIsHavePlan(packet){
				var serialnum = packet.data.findValueByName("serialnum");
				var planCounts = packet.data.findValueByName("planCounts");
				var flag = packet.data.findValueByName("flag");
			  var staffno = packet.data.findValueByName("staffno");
				
			  if(parseInt(planCounts)>0){
			  	planInQua(serialnum,staffno,flag);
			    //checkIsQc(serialnum,flag,staffno);
				}else{
					rdShowMessageDialog("��Ŀǰ�޸ù��ŵ��ʼ�ƻ���");
				}
			}
			
			//�ʼ�ǰ�ж��Ƿ��ѱ��ʼ��
			//flag 0:�ƻ����ʼ� 1:�ƻ����ʼ�
			function checkIsQc(serialnum,flag,staffno){
				var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsQc_rpc.jsp","���ڽ������ʼ�У�飬���Ժ�......");
				mypacket.data.add("serialnum",serialnum);
			  mypacket.data.add("start_date",parent.queryFrame2.window.sitechform.start_date.value);
			  mypacket.data.add("flag",flag);
			  mypacket.data.add("staffno",staffno);
			  core.ajax.sendPacket(mypacket,doProcess,true);
				mypacket=null;
			}
			
			function doProcess(packet){
				var serialnum = packet.data.findValueByName("serialnum");
				var checkList = packet.data.findValueByName("checkList");
				var isOutPlanflag = packet.data.findValueByName("flag");
			  var staffno = packet.data.findValueByName("staffno");
				
			  if(parseInt(checkList)<1){
			    planInQua(serialnum,staffno);
				}else{
					rdShowMessageDialog("����ˮ�Ѿ����й��ʼ죬�����ظ����У�");
				}
			}
			
			/**
			  *
			  *��������ˮ�����ʼ촰��
			  */
			function planInQua(serialnum,staffno,flag){
				var start_date = parent.queryFrame2.window.sitechform.start_date.value;
				var  path = '/npage/callbosspage/checkWork/K217/K218_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno + '&flag=' + flag + '&start_date=' + start_date;
				//�ƻ����ʼ�tabidΪ��ˮ��0���ƻ����ʼ�Ϊ��ˮ��1
				if(!parent.parent.document.getElementById(serialnum+0)){
				parent.parent.addTab(true,serialnum+0,'ִ���ʼ�ƻ�',path);
			  }
			}

//added by liujied 20091016
function planOutCheckQua(serialnum,staffno,isCheck)
{
    
    if(isCheck == "���ʼ�"){
        rdShowMessageDialog("����ˮ�Ѿ����й��ʼ죬�����ظ��ʼ�!");
        return false;
    }
    planOutQua(serialnum,staffno,"0");
}

			/*****************************end***********************/
			
			/**
			  *
			  *�����ƻ����ʼ촰��
			  */
			function planOutQua(serialnum,staffno,group_flag){
				var path ='/npage/callbosspage/checkWork/K217/K217_select_check_content.jsp?serialnum=' + serialnum+'&staffno='+staffno+'&isOutPlanflag=0&group_flag='+group_flag;
				var param  = 'dialogWidth=900px;dialogHeight=300px';
				//window.showModalDialog('../checkWork/K217/K217_select_check_content.jsp?serialnum=' + serialnum+'&staffno='+staffno+'&isOutPlanflag=0','', param);
				//window.open(path,'', 'width=900px;height=300px');
					if(!parent.parent.document.getElementById(serialnum+1)){
				   parent.parent.addTab(true,serialnum+1,'ִ���ʼ�ƻ�',path);
			    }
			}
			
			
			//����ҳ��ʱ��sql����where������ֵ�������sqlWhere�������Ա㵼������
			function insertParentFrameValue(){
				
			}
			
			//ҳ������
			function showQuery(frameset){				
				if(parent.document.all(frameset).rows=="0,*"){					
					parent.document.all(frameset).rows="180,*";					
					
				}else{
					
					parent.document.all(frameset).rows="0,*";					
				}
			}
			function modifyCallCauseTree(strNode_Id,contact_id,start_date){
			
				 var path="<%=request.getContextPath()%>/npage/callbosspage/k170/callreason.jsp";
			    path = path + "?contactId=" + contact_id;
			    path = path + "&contactMonth=" + start_date.substr(0,6);
			    //path = path + "&strnodeid="+ strNode_Id;
			    window.open(path,'����ԭ���춯�޸�','scrollbars=yes,height=600, width=600');
			  
				/*
				  var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k172_modifyCallCauseTree.jsp";
			    path = path + "?contact_id=" + contact_id;
			    path = path + "&contactMonth=" + start_date;
			    path = path + "&strnodeid="+ strNode_Id;
			    window.open(path,'����ԭ���춯�޸�','scrollbars=yes,height=600, width=500');
			  */
			}
			
			//�жϵ�ǰ�����Ƿ��и���ˮ���ŵ��ʼ�ƻ�
			/*function checkIsHavePlan(serialnum,flag,staffno){
				var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsHavePlan_rpc.jsp","���ڽ��мƻ�У�飬���Ժ�......");
				mypacket.data.add("serialnum",serialnum);
			  mypacket.data.add("start_date",parent.queryFrame2.window.sitechform.start_date.value);
			  mypacket.data.add("flag",flag);
			  mypacket.data.add("staffno",staffno);  
			  core.ajax.sendPacket(mypacket,doProcessIsHavePlan,true);
				mypacket=null;
			}
			
			function doProcessIsHavePlan(packet){
				var serialnum = packet.data.findValueByName("serialnum");
				var planCounts = packet.data.findValueByName("planCounts");
				var flag = packet.data.findValueByName("flag");
			  var staffno = packet.data.findValueByName("staffno");	
				//alert(parseInt(checkList)+parseInt(checkMutList));
			  if(parseInt(planCounts)>0){
			    checkIsQc(serialnum,flag,staffno);
				}else{
					rdShowMessageDialog("��Ŀǰ�޸ù��ŵ��ʼ�ƻ���");
				}
			}
			*/
			//ҳ�����˳�����������ؼ���result_cause.jspҳ��ʱ��sql����where������ֵ�������sqlWhere�������Ա㵼������
			function insertParentFrameValue(){				
				try{
					if(parent.queryFrame2.document.sitechform.sqlWhere!=undefined){
						
						
					}else{
						
						insertParentFrameValue();
					}
			  }catch(e){
			  	
			  }						
			}
			
			function canNotModify()
			{
				rdShowMessageDialog("��ʱ���޸���Ч!");
			}
</script>
