/*******************************************************
 * �ļ����� ajaxXML.js
 * �޸��ˣ� ������
 * �޸�ʱ�䣺2008-09-20
 * �޸����ݣ�����,���ڿ�������xml����
 ********************************************************/
 /*
 url���Ƿ���˴���jsp��·����
 */
  function getXMLData(url){
     xmldso = new ActiveXObject("Microsoft.XMLDOM");
     xmldso.async = false; 
     alert(url);
     xmldso.load(url); 
     var dataList = xmldso.documentElement.selectNodes("//list/item");
     var dataArray=new Array();
     for(var i=0;i<dataList.length;i++){
         var re=dataList.item(i);
         dataArray[i]=new Array();
         for(var k=0;k<re.childNodes.length;k++){
           var par_node=re.childNodes(k);
           dataArray[i][k]=par_node.text;
           //alert(par_node.text);
         }
     }
     xmldso=null;
     //alert(dataArray);
     return dataArray
  }

  /*
  *��ȡ�����˵�
  */
  function iniSel(selectob){
     var pars="&textField="+selectob.textField+"&valueField="+selectob.valueField+"&tableName="+selectob.tableName+"&condition="+selectob.condition+"&selctName="+selectob.name
     var ret=getXMLData('/sitechcallcenter/npage/callbosspage/common/serverajaxProxy.jsp?url=/callpage/common/serverajaxCodeInfo.jsp'+pars);
     //alert(ret);
     if(ret!=null){
	     for(var i=0;i<ret.length;i++){
	       var toption = new Option(ret[i][1], ret[i][0]);
	       selectob.options.add(toption);
	       inivalue=selectob.getAttribute("iniValue");
	       if(inivalue!=null&&inivalue!=''){
	         alert(inivalue+","+ret[i][0]);
  		     if(ret[i][0]==inivalue){
  		      selected=i+1;
  		     }
  	       }
	     }
	      selectob.selectedIndex=selected;
	 }  
  }
  