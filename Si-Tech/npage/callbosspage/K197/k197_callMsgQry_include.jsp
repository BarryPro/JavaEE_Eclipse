	<%@ include file="/npage/callbosspage/public/constants.jsp" %>
	  <%!
			/**
			 ����˵��: ����һ��������sql.Ȼ��ҳ�����ģʽ��  [�����_=_�ֶ���] ��  [�����_like_�ֶ���]
			 ����columnΪ��ѯ�ֶ�.��һλ�������.����Ų����ظ�.�ظ����������һ��ֵ.�ұ���������.��С������1,11,123.
			 */
	   public String[]  returnSql(HttpServletRequest request){
        StringBuffer buffer = new StringBuffer();
        StringBuffer bufferPara = new StringBuffer();
 
		   //�������.
		Map map = request.getParameterMap();
		Object[] objNames = map.keySet().toArray();
		Map temp = new HashMap();
		String name="";
		String[] names= new String[0];
    String[] bingd= {"",""};
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
		if (value.trim().equals("")) {
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
		buffer.append(" and " + objs[1] + " " + objs[0] + " '%%'||:v"
				+ objs[1].toString().replace('.','a') + "||'%%' ");
			bufferPara.append(",v"+objs[1].toString().replace('.','a')+"="+objs[2].toString().trim());
			}
			if (objs[0].toString().equalsIgnoreCase("=")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " :v"
				+ objs[1].toString().replace('.','a') + "  ");
 
			bufferPara.append(",v"+objs[1].toString().replace('.','a')+"="+objs[2].toString().trim());
			}
		}
     bingd[0]=buffer.toString();
     bingd[1]=bufferPara.toString();
        return bingd;
}
	%>
  
  <%
  /*ȡ��ǰ��½���ŵĽ�ɫID��Ϊ���ŷָ���ַ��� hanjc add 20090423*/
	String  powerCode = (String)session.getAttribute("powerCodekf");
	//�е��û���¼ʱ������δ��session��ȡ��powerCodekf��ҳ������ 
	//���Լ���������ҳ�����
	//add by tangsong 20100330
	if (powerCode == null) {
		powerCode = "";
	}
	String[]  powerCodeArr = powerCode.split(",");
  String isCommonLogin="N";	
	/*
	 *�Ƿ��ǻ���Ա update by hanjc 20090719
        *01120O04Ϊ��ѵ��ɫid,01120O0EΪ�ʼ��ɫid,011202Ϊ�ͻ��绰Ӫҵ����01120O02����ͨ��ϯ
        *01120O02011202��01120201120O02�ǿͻ��绰Ӫҵ������ͨ��ϯ������ɫ��ƴ��
        *����Աֻ�пͻ��绰Ӫҵ������ͨ��ϯ������ɫ,��01120O02011202��01120201120O02��������С�鳤��
	 */
	 /* modify by yinzx 20090826 ����ɽ������д�Ľ��ң�����д����ɫ��Ϣ ���Ը��죬������ʱ����
      //add by hanjc 20090719 �жϵ�ǰ�����Ƿ��ǻ���Ա��������ȡ¼��Ȩ��
      if(powerCodeArr.length==2){
         String tempVal = powerCodeArr[0].trim()+powerCodeArr[1].trim();
         if("01120O02011202".equals(tempVal)||"01120201120O02".equals(tempVal)){
		       isCommonLogin="Y";	
         }
       }
   *//*add by yinzx 20090826*/
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
		 var formobj = parent.queryFrame.document.sitechform;
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
	    parent.queryFrame.submitMe(str);
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
		   		 parent.queryFrame.window.sitechform.page.value=parseInt(thePage);
		   		 doLoad('0');
		   	  }
		   }
		   else if(operateCode=="jumpToPage1")
		   {
		   	  var thePage=document.getElementById("thePage1").value;
		   	  if(trim(thePage)!=""){
		   		 parent.queryFrame.window.sitechform.page.value=parseInt(thePage);
		       doLoad('0');
		      }
		   }else if(trim(operateCode)!=""){
		   	 parent.queryFrame.window.sitechform.page.value=parseInt(operateCode);
		   	 doLoad('0');
		   }
		}
		  function checkAll(a) {
    var el = document.getElementsByTagName('input');
    var ck_all = document.getElementsByName('ck_all');
    var len = el.length;
    //alert(len);
   
    
 if(a.checked==false)
 {   for (var i = 1; i < len; i++) {
        if ((el[i].type == "checkbox") ) {
            el[i].checked = false;
        }
    }
 
 }
 else if(a.checked==true)
 { 
 	  
 	for (var i = 1; i < len; i++) {
        if ((el[i].type == "checkbox") ) {
            el[i].checked = true;
        }
    }
   
 }
}			 


	function modifysceTrans(){
			 
				if($("input:checked").length !=1)
				{
						rdShowMessageDialog("��ѡ��һ�����ݽ����޸Ĳ���",0);
						return;
				} 
				
				  if($(":checkbox").length==2 )
				 {
				 	  
			    		openWinMid('k197_modifysceTrans.jsp?sceid='+document.all.sceid.value.trim(),'�޸Ľ��',650,800);
			   }else
			   {
			   	   
			  	    openWinMid('k197_modifysceTrans.jsp?sceid='+document.all.sceid[$("input:checked")[0].value ].value.trim(),'�޸Ľ��',650,800);
			   }
			  //alert(document.all.sceid[$("input:checked")[0].value ].value.trim());
			}
			
			
			
			//ҳ������
			function showQuery(frameset){				
				if(parent.document.all(frameset).rows=="0,*"){					
					parent.document.all(frameset).rows="260,*";					
					
				}else{
					
					parent.document.all(frameset).rows="0,*";					
				}
			}
			
			//����ҳ��ʱ��sql����where������ֵ�������sqlWhere�������Ա㵼������
			function insertParentFrameValue(){
				try{
					if(parent.queryFrame.document.sitechform.sqlWhere!=undefined){
						
						parent.queryFrame.document.sitechform.sqlWhere.value = "<%=sqlFilter %>";
						
					}else{
						
						insertParentFrameValue();
					}
			  }catch(e){
			  	
			  }
			}
			
			function delsceTrans(){
			 
				var checkval="";
				if($("input:checked").length ==0)
				{
						rdShowMessageDialog("��ѡ��һ����������ݽ���ɾ������",0);
						return;
				} 
			
			if(rdShowConfirmDialog("��ȷ��ɾ���˼�¼ô��")=='1'){	 
				for(var i=0;i<$("input:checked").length;i++)
				{
					 
          if($("input:checked")[i].name!='ck_all')
         {   if($(":checkbox").length==2)
					{
						 checkval=document.all.sceid.value.trim();
					}else{
						 
					  if (i==($("input:checked").length -1))
					  {
								checkval+=document.all.sceid[$("input:checked")[i].value].value.trim();
						}else
						{
							  checkval+=document.all.sceid[$("input:checked")[i].value].value.trim()+",";
					  }
					}
				 }
				}
          
				var packet = new AJAXPacket("k197_delsceTrans_rpc.jsp","...");
				packet.data.add("retType","delsceTrans");
				packet.data.add("checkval" ,checkval);
			
				core.ajax.sendPacket(packet,doProcessdelsceTrans,true);
				packet=null;
			}
			}
			
			
				/**
  *���ش�����
  */
function doProcessdelsceTrans(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");

	if (retCode == "000000") {
 
		rdShowMessageDialog("ɾ�������������ݳɹ���",1);	
		 // window.sitechform.action="result.jsp" ;
			//window.sitechform.submit(); 
		  document.location.replace("result.jsp");	
    window.close();
   
	} else {
		rdShowMessageDialog("ɾ��������������ʧ�ܣ�",2);

	}
}
		</script>